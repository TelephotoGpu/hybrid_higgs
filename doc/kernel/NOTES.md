# Image kernel datapath — design notes

This file is the engineering log and the specification. The Python model
(`libs/datapath/image/img_model.py`), the RTL (`libs/datapath/image/rtl/`)
and the C library (`libs/riscv-baseband/c/inc/image_kernel.{h,c}`) all
implement what is written here. If they disagree, this file wins; then fix
the code or update this file in the same commit.

## 0. Context and base branch

* The target is Xilinx (xczu7ev, Vivado 2025.2). `imgmaster` was rebased onto
  `xilmaster` (from `../xil1_higgs`), so the image work carries the full
  Xilinx port: the `HIGGS_FPGA_XILINX` flow, the XSIM parity harness and the
  CS12 Vivado build. The pre-rebase tip is kept as the branch
  `imgmaster-pre-rebase`.
* Baseline evidence: `sim/verilator/test_fft_lib_1` passed before the work
  started (ring output `0xdeadbeef,0x34,0x6,0x2,0x1,0x0,0x0,0xf`, ~14 min
  build+run).
* Both verification flows are required: Verilator and XSIM.

## 1. How the existing datapath is built (study)

* A Q-engine = VexRiscv + *piston* (vector unit + VMEM + datapath).
  `libs/q-engine/piston/hdl/piston.v` was produced by the reqack/fhyper
  generator (`piston/bin/gen.js`, `piston/lib/piston.js`); since M8 it comes
  from SpinalHDL with the same graph (§11). The datapath graph
  itself comes from `libs/datapath/lib/datapath.js`
  (`funnel → cmul(muladdsub) → radix4 → bs → round_sat → defunnel`).
* Datapath interface (`dpTargets`/`dpInitiators` in `piston.js`):
  * `k8`, `k9`: 512-bit rows loaded from VMEM by `LK8`/`LK9` instructions.
  * `k14`: 512-bit config row loaded by `LK14` (`FLUSH_CONFIG_WORD`).
  * `k1`: 512-bit result row consumed by `SK1`.
  * All four are valid/ready (req/ack) elastic channels. In `piston.v` they
    are `dat38`/`dat39`/`dat40` in and `dat42_nxt` out. The handshakes are
    `req/ack38_0`, `39_0`, `40_0` and `req/ack42` in `piston_ctrl`.
* The existing datapath funnels each 512-bit row into 4 beats of 128 bits
  (8 complex 16I/16Q samples per beat), so it is 16-bit complex only.
* VMEM: 16 banks (slices) × 32 bit, 4096 rows (`VMEM_DEPTH`) = 256 KiB.
  VMEM row r, bank b is DMA word `16*r+b` and CPU address
  `0x40000 + 4*(16*r+b)`.
* Vector registers: 16 per slice, 16 bits: `{perm[15:12], baddr[11:0]}`.
  * Bank `b` reads/writes address `vreg[b].baddr`.
  * The load permutation gives output slice `s` = bank `(s + perm[s]) mod 16`
    (`perm_full_data_dat_2_1.v`).
  * `LKn`/`SKn` use the *pre-op* value of `s1` (`i0_data` is source 1), so
    `ADD_LK9(V8,V8,V9)` loads row `V8` then increments `V8`.
  * `MVXV_KNOP(v,x)` broadcasts the low 16 bits of `x` to all slices.
  * `VNOP_LK15(v); MVK15V_KNOP(d,0)` loads a VMEM row into a vreg.
  * `SK15` stores the vector unit's *k15 output*, which is only valid for
    funct `MV_V_K15`. To store a vreg into a row:
    `MVVK15_KNOP(Vsrc); MVXV_KNOP(Va,row); VNOP_SK15(Va)`
    (the pattern in `test_slice_0`). The `MVVK15_SK15` macro in
    `xbaseband.h` is malformed (`| |`), so the library does not use it.
  * **MVVK15 over-pushes when the vector unit goes idle** (found in
    test_image_1, §10). In `vector_slice.v`,
    `i_k15_valid = (funct_reg==MV_V_K15) & ~k15_latched`. `funct_reg` keeps
    the last opcode while no instruction is valid, and `k15_latched` clears
    on every idle cycle (`t_instr_ready` is 1 then). So an `MVVK15` that is
    not immediately followed by another vector instruction pushes the same
    value again and again, until the k15 → inmux elastic buffers are full.
    The next `SK15` then stores a stale copy. The image library therefore
    never uses `MVVK15`; its fence uses `LK13`/`SK13` (§6.3).
  * `LK13 → SK13` is a plain row copy: VMEM → oumux k13 → 4-deep FIFO
    (edge 41) → inmux k13 → store.
  * vreg `ADD` is field-split: the 12-bit baddr and the 4-bit perm are added
    separately, with no carry from baddr into perm (`test_slice_0`,
    "add overflow test").
* `piston/hdl/*` is generated (`make -C libs/q-engine/piston build`); do not
  hand-edit it. reqack is pinned to exactly `1.3.1` in both
  `piston/package.json` and `datapath/package.json`: with it the generator
  reproduces the committed `piston.v` (ignoring trailing whitespace), while
  later reqack versions change the netlist substantially (about 4k lines
  shorter). Earlier hand edits in `hdl/` were moved into the generator:
  * the `HIGGS_FPGA_XILINX` `vmem_dat_6_5_1_1` ifdef (`vmemData` in
    `piston/lib/macros.js`);
  * the `DEPTH` parameter in `memory_slice.v`/`vmem_dat_6_5.v` (templates);
  * the muladdsub `cfg_valid_N`/`addsub_detect` logic
    (`datapath/lib/datapath-macros.js`).

## 2. Task 1 — kernel operations (grill Q1–Q3, Q5)

All operations are 8-bit per channel, same-size output, and use the
tap-accumulate engine below. Coefficients are signed 8-bit (`s8`).

| id | name | taps | kernel (cA; cB) | comb | shift | round | offset |
|----|------|------|-----------------|------|-------|-------|--------|
| 0 | COPY | 1x1 | `1` | A | 0 | – | 0 |
| 1 | GAUSS3 | 3x3 | `[1 2 1]ᵀ[1 2 1]` (sum 16) | A | 4 | y | 0 |
| 2 | GAUSS5 | 5x5 | `[1 4 6 4 1]ᵀ[1 4 6 4 1]` (sum 256) | A | 8 | y | 0 |
| 3 | GAUSS7 | 7x7 | `[1 3 7 10 7 3 1]ᵀ[…]` (sum 1024) | A | 10 | y | 0 |
| 4 | BOX3 | 3x3 | all `114` (≈1024/9) | A | 10 | y | 0 |
| 5 | BOX5 | 5x5 | all `82` (≈2048/25) | A | 11 | y | 0 |
| 6 | SHARPEN | 3x3 | `[0 -1 0; -1 5 -1; 0 -1 0]` | A | 0 | – | 0 |
| 7 | UNSHARP | 3x3 | `32δ − gauss3` = `[-1 -2 -1; -2 28 -2; -1 -2 -1]` | A | 4 | y | 0 |
| 8 | LAPLACE | 3x3 | `[0 1 0; 1 -4 1; 0 1 0]` | \|A\| | 0 | – | 0 |
| 9 | SOBEL | 3x3 | Gx `[-1 0 1; -2 0 2; -1 0 1]`; Gy = Gxᵀ | \|A\|+\|B\| | 2 | y | 0 |
| 10 | SOBEL_X | 3x3 | Gx | \|A\| | 2 | y | 0 |
| 11 | PREWITT | 3x3 | `[-1 0 1]×3`; transpose | \|A\|+\|B\| | 2 | y | 0 |
| 12 | SCHARR | 3x3 | `[-3 0 3; -10 0 10; -3 0 3]`; transpose | \|A\|+\|B\| | 4 | y | 0 |
| 13 | EMBOSS | 3x3 | `[-2 -1 0; -1 1 1; 0 1 2]` | A | 0 | – | +128 |
| 14 | ERODE3 | 3x3 | MIN over mask (all 1) | – | – | – | – |
| 15 | DILATE3 | 3x3 | MAX over mask (all 1) | – | – | – | – |
| 16 | CUSTOM | ≤7x7 | user s8 kernel(s), user post settings | any | any | any | any |
| 17 | CHAN_GAUSS | 3x3 | per-lane demo: R `2·gauss3`, G `gauss3`, B `0` | A | 4 | y | 0 |

The feature operations (ids 32+) are in §3.

Notes:
* Kernel sizes 1, 3, 5 and 7 are supported (max 7x7 = 49 taps). The
  accumulator has headroom for 9x9 (see §4).
* A 7x7 binomial (`[1 6 15 20 15 6 1]`) overflows s8 (20·20=400), so GAUSS7
  uses `[1 3 7 10 7 3 1]` (sum 32, 2-D sum 1024, max coefficient 100).
* Box filters cannot divide by N², so they use `c = round(2^s/N²)` with a
  small gain error (+0.2 % for BOX3, +0.1 % for BOX5), saturated.
* Median was explicitly rejected (Q1); it needs sorting, not MACs.
* Other operations this engine also covers (suggestions): motion blur
  (1xN/Nx1 box), directional/compass edges (Kirsch/Robinson as CUSTOM),
  high-pass/high-boost, morphological gradient (DILATE − ERODE, two passes
  plus a CPU subtract), opening/closing (ERODE→DILATE chains), thresholding
  and binary masks, and the local-peak detector.

### Borders (Q5)
* Same-size output. There are two modes, ZERO and REPLICATE.
* Horizontal: each line in VMEM has a pad row (16 words) on the left and the
  right. After the line lands, the C library fills the `R = (N-1)/2` halo
  words next to the line with 0 (ZERO) or the edge pixel (REPLICATE).
* Vertical: the row index `y+dy` is clamped to `[0,H-1]` (REPLICATE) or
  redirected to an all-zero line (ZERO).
* The Python model (`img_model.fetch`) implements exactly this: zero, or
  a clamped (edge-replicated) coordinate.

### Pixel formats (Q2)
* GRAY: one pixel per 32-bit word, value in byte 0 (lane 0). Lanes 1–3 are
  zero on input and forced to zero on output. A 512-bit row = 16 pixels.
  (Future: pack 4 vertical strips per word for 4× gray throughput.)
* RGBX: one pixel per word, R=byte0, G=byte1, B=byte2, X=byte3. X is forced
  to 0 on output. Every channel is filtered independently with the same
  kernel.

## 3. Task 2 — feature detection (grill Q6)

Built on top of the kernel ops, so there is no extra datapath hardware:

| id | name | pipeline | output image |
|----|------|----------|--------------|
| 32 | EDGES | SOBEL + threshold (`thr_en`) | 255 where mag ≥ T else 0 |
| 33 | PEAKS | SOBEL → 3x3 NMS/peak stage | mag where mag is the 3x3 max and ≥ T, else 0 |

Where:
* **Threshold** is a datapath post-op: `out = (v >= T) ? 255 : 0`.
* **NMS / local peaks** is a second streaming stage. It runs MAX over a 3x3
  window with the `CENTER` tap flag capturing the centre pixel, then
  `out = (ctr == max && ctr >= T) ? ctr : 0`. Plateaus keep all equal
  maxima. This is isotropic 3x3 peak suppression, not Canny's directional
  NMS.
* **Global statistics** are computed by the CPU from each finished output
  line while it is still in VMEM, for every op. The value used is
  `v = max(R,G,B)` (lane 0 for gray):
  * max value and the (x,y) of its first occurrence in raster order;
  * min value and the (x,y) of its first occurrence;
  * the count of non-zero pixels and the sum of `v`.
* **Interesting regions (ROI)**: the image is split into 16x16 tiles
  (ceil at the edges). A tile's score is its count of non-zero output pixels
  (edge pixels for EDGES/PEAKS). A tile is a ROI when `score >= roi_thr`.
  The CPU reports the ROI tile count and the pixel bounding box of all ROI
  tiles.
* Deferred to future work: Harris corners (needs products of gradients, 3
  passes), connected components, per-ROI centroid.
* Refinement vs the grill answer: the "datapath per-column running max"
  idea (a MAX op over {line, running-max row}) works with the existing ops,
  but it cannot give the (x,y) location cheaply. v1 therefore does the
  min/max reduction on the CPU, which already has each line in VMEM. The
  running-max trick is noted as an optimisation.

## 4. Task 3 — processing level and multipliers (grill Q3, Q4)

* **Real, not complex:** image data is u8 and coefficients are s8. The
  existing 16I/16Q complex `muladdsub` datapath is replaced (at compile time)
  by a real u8×s8 engine.
* **Width:** a whole 512-bit row per beat is 64 byte-lanes (16 words × 4
  lanes). There is no funnel: one LK8/LK9 pair per clock.
* **Dual accumulator:** each lane has accumulator A (`p·cA`) and B
  (`p·cB`), so Sobel/Prewitt/Scharr get Gx and Gy in one pass. That is
  2 × 64 = **128 u8×s8 multipliers**, about 128 DSP48E2 (≈7.4 % of the
  xczu7ev's 1,728 DSPs). Future work: pack two u8×s8 products per DSP48E2
  (INT8 packing) to halve this.
* **Accumulator width:** |p·c| ≤ 255·128 = 32,640. 49 taps ≤ 1.6 M < 2²³,
  and 81 taps (9x9) ≤ 2.65 M, so the accumulators are **24-bit signed**.
* **Per-lane mode:** coefficients differ per channel (`cA` from bytes 0..2
  of the coefficient word, lane 3 = 0, B unused). Useful for per-channel
  weighting and colour-specific kernels.
* **MIN/MAX mode** (erode/dilate/NMS) uses 64 8-bit comparators per op; no
  multipliers.
* **Post stage** per lane:
  combine → round/shift → offset → saturate u8 → threshold/peak → lane mask.

## 5. Datapath specification (bit-exact contract)

### 5.1 Coefficient row (k9, LK9)
The coefficient row has 16 words, one per slice. v1 always uses the same
word in all 16 slices.
```
word[7:0]   cA  (s8)       per-lane mode: cA for lane 0 (R/gray)
word[15:8]  cB  (s8)       per-lane mode: cA for lane 1 (G)
word[23:16] reserved (0)   per-lane mode: cA for lane 2 (B)
word[24]    FIRST   clear accumulators (load instead of add)
word[25]    LAST    emit the post-processed row on k1 after this tap
word[26]    CENTER  capture this tap's pixel as the centre value
word[31:27] reserved (0)
```
In normal mode `cA` and `cB` are broadcast to the 4 lanes of the word.
Per-lane mode: lane 3 has cA=0, and cB=0 for all lanes.
The flags (FIRST/LAST/CENTER) are taken from **slice 0's word only**.
Coefficients come from each slice's own word, so per-slice coefficients also
work, although the C library always writes the same word to all 16 slices.

### 5.2 Config row (k14, LK14) — only word 0 and word 1 (slice 0, 1) are used
```
w0[1:0]   op       0=MAC 1=MIN 2=MAX
w0[3:2]   comb     0=A 1=|A| 2=|A|+|B| 3=max(|A|,|B|)      (MAC only)
w0[7:4]   shift    0..15 arithmetic right shift            (MAC only)
w0[8]     round    add 1<<(shift-1) before the shift (if shift>0)
w0[9]     thr_en   out = (v >= thr) ? 255 : 0
w0[10]    peak_en  out = (ctr == v && ctr >= thr) ? ctr : 0 (MIN/MAX)
w0[11]    perlane  per-lane coefficient mode
w0[15:12] lane_mask  output lane enable (gray 0x1, RGBX 0x7)
w0[23:16] thr      u8 threshold
w1[15:0]  offset   s16 added after the shift              (MAC only)
```
`peak_en` takes precedence over `thr_en`.

### 5.3 Per-lane arithmetic (lane l = 4·slice + byte)
```
p   = k8 byte l (u8)
cA  = perlane ? (byte<3 ? word.byte[byte] : 0) : s8(word[7:0])
cB  = perlane ? 0 : s8(word[15:8])
MAC: A = FIRST ? p*cA : A + p*cA ; B = FIRST ? p*cB : B + p*cB  (24-bit)
MIN: M = FIRST ? (cA? p : 255) : (cA? min(M,p) : M)
MAX: M = FIRST ? (cA? p : 0)   : (cA? max(M,p) : M)
CENTER: C = p
LAST → post:
  MAC: v = comb(A,B);  if round && shift: v += 1<<(shift-1)
       v = v >>> shift (arithmetic); v += offset; v = clamp(v,0,255)
  MIN/MAX: v = M
  if peak_en: v = (C == v && C >= thr) ? C : 0
  elif thr_en: v = (v >= thr) ? 255 : 0
  out byte = lane_mask[byte] ? v : 0
```
`|A|` is computed on the 24-bit value (it cannot overflow). Combine results
use 26-bit signed arithmetic.

### 5.4 Handshake / pipeline
* One beat = one k8 row + one k9 row, taken together (join). The k14 config
  is latched whenever a k14 token arrives (the op is always acked).
* A k1 row is produced only on LAST. The module is a global-stall pipeline:
  every stage advances when the output register is empty or being accepted.
  Latency from the LAST beat to the k1 row is 5 clocks. The k14 config is
  sampled with every beat and travels down the pipeline with it.
* Only k8+k9 pairs are consumed. A k9 without a matching k8 (or the other
  way round) waits.

## 6. Instruction schedule and C library (task 6)

`libs/riscv-baseband/c/inc/image_kernel.{h,c}`. Like every file in that
folder it is compiled into every firmware. `--gc-sections` drops it, and its
VMEM buffers, when unused.

### 6.1 VMEM layout (static `VMEM_SECTION` arrays, ~93 KB)
| buffer | rows | use |
|---|---|---|
| `img_ring_mem` | 14 slots × (1024+32)/16 | line rings: stage s has n_s slots |
| `img_zero_mem` | 1 slot | all-zero line for ZERO borders |
| `img_out_mem` | 2 × 64 | final output lines, double-buffered for DMA out |
| `img_cfg_mem` | 2 | k14 config row per stage (words 0, 1) |
| `img_coef_mem` | 2 × 49 | one k9 row per tap per stage (same word in all 16 slices) |
| `img_skew_mem` | 7 | SKEW rows, dx = −3..+3 |
| `img_fence_mem` | 3 | fence row, token rows (all 1s, all 2s) |
| `img_hin_mem`, `img_hout_mem` | 1 each | header in/out |
| `img_trl_mem` | trailer | 14 words + 4096 tile counts |

* A line slot is `W/16 + 2` rows: `[pad][W/16 pixel rows][pad]`. Image row
  y of stage s lives in slot `y mod n_s`. Pixel x is DMA word
  `16·(slot_row + 1) + x`.
* Horizontal halo: after each input DMA (and after each intermediate stage
  row) the CPU writes R words either side of the line (0 or the edge pixel),
  then reads one back so the write has landed before any vector load.
* Vertical border: out-of-image rows map to the clamped row (REPLICATE) or
  to the zero line (ZERO).

### 6.2 Vector registers
V0 row address, V1..V7 SKEW for dx = −3..+3, V8 coefficient pointer,
V9 = 1, V10 output pointer, V11 skewed address, V12/V13 fence and config
addresses.
SKEW rows are loaded once per `img_run_stages` with
`MVXV(V0,row); LK15(V0); MVK15V(Vn,0)`.

### 6.3 Per output row (stage s, row y)
```
if stage changed:  MVXV(V13,cfg_row); LK14(V13)       // after a fence: nothing in flight
MVXV(V10, dst_row)
for chunk j in 0..W/16-1:
    MVXV(V8, coef_row)
    for dx in -R..R:                 // column-major = coefficient order
        for dy in -R..R:
            MVXV(V0, pix_row(y+dy) + j)
            ADD(V11, V0, SKEW[dx])   // dx == 0: LK8(V0) directly
            LK8(V11)
            ADD_LK9(V8, V8, V9)      // load coef row, then V8++
    ADD_SK1(V10, V10, V9)            // store k1 row, then V10++
fence()
```
* `SKEW[dx][b] = ((dx & 15) << 12) | (off & 0xFFF)`, where
  `off = dx ≥ 0 ? (b < dx) : −(b ≥ 16+dx)`. The vreg ADD is field-split
  (§1), so the permutation and the row offset are encoded separately. Bank b
  reads row `base + off_b`, and the permutation rotates the banks back into
  pixel order, so slice s sees pixel `16j + s + dx`.
* Coefficient rows follow the same column-major tap order (t → `jx = t/n`,
  `iy = t%n`). FIRST is on t = 0, LAST on t = n²−1, CENTER on (r, r). The
  accumulation is order-independent, so the result equals the model's
  row-major reference.
* 3x3 cost: ~5 RISC-V instructions per tap, so ~50 per 16 pixels. 7x7 is
  ~250.
* **Fence:** there is no hardware CPU↔vector fence. `img_fence()`
  alternates the token between 1 and 2 and copies the matching token row
  onto the fence row with `MVXV(V12,fence_row+tok); LK13(V12);
  MVXV(V13,fence_row); SK13(V13)`. It then polls `fence_mem[0]` until it
  equals the token. Vector stores leave through one in-order store mux, so
  once the token is visible every earlier SK1 row is in VMEM, and the
  datapath is empty. The first version used `MVVK15`/`SK15` and hung on the
  second row (§1, §10).

### 6.4 Multi-stage (PEAKS) and pull scheduling
`img_produce(s, y)` first makes sure stage s has the input rows up to
`min(y+R, H−1)`. For stage 0 it DMAs input lines. For stage s > 0 it
recursively produces rows of stage s−1 into stage s's ring. Then it runs
the row. This keeps only n_s lines per stage and runs PEAKS (Sobel → 3x3
NMS) in a single pass.

### 6.5 API
* `img_op_stages(op, fmt, thr, stages)`: the op table, mirroring
  `img_model.op_stages`.
* `img_run_stages(stages, n, W, H, border, line_in, line_out, ctx)`: the
  generic engine. `line_in(y, dma_addr, W)` fills an input line (the stream
  layer DMAs it; other users can copy from memory). `line_out(y, cpu_ptr,
  dma_addr, W)` receives each final line.
* `img_stream_job` / `img_stream_loop`: the cs22 stream protocol (§7).
  Stats are computed per output line in the out callback, which also DMAs
  the line out. Before a new output line buffer is written, the code waits
  until DMA_1 has ≤ 1 transfer queued (`dma_out` pops a schedule entry only
  after its last word has been read).
* `img_last_stats()`, `img_last_cycles()`: the last job's features and
  timer cycles.

## 7. Test I/O (grill Q7, Q8)

* cs22 is the image FPGA. The testbench injects on `cs22in`, which requires
  `CS32_NO_RISCV`, as in `test_inject_cs22`, and captures `cs22out`.
* cs21 must run firmware. cs22out's ready is cs21's `HS_EAST_OUT`, which only
  goes high while cs21 has an input DMA scheduled, so cs21 runs a DMA sink
  loop (`test_image_1/override/fpgas/cs/cs21`). The platform is cs32
  (no RISC-V) → cs22 (image firmware) → cs21 (sink).
* The datapath choice is sim-wide: every Q-engine in the build gets the image
  datapath (`HIGGS_DATAPATH=img`).
* Input stream, per job:
  * `w0 = 0x1A6E0000 | border<<9 | fmt<<8 | op`, where fmt 0 = gray and
    1 = RGBX, and border 0 = ZERO and 1 = REPLICATE;
  * `w1 = H<<16 | W`;
  * `w2 = thr | roi_thr<<8`;
  * then `W·H` pixel words.
  * `op = 0xFF` ends the run.
* Output stream, per job:
  * the same 3 header words;
  * `W·H` pixel words;
  * a trailer: `0x5A7A0000 | n` followed by n words: `max_v, max_x, max_y,
    min_v, min_x, min_y, nz_count, sum, roi_count, roi_x0, roi_y0, roi_x1,
    roi_y1`, then one edge count per 16x16 tile in raster order. With no ROI
    tiles the bounding box is `0xFFFF`×4.
* Errors: a job with an unknown op (1), a bad W (2: 0, not a multiple of 16,
  or > 1024), a zero H (2) or more than 4096 16x16 tiles (3) is echoed as
  its 3 header words plus `0xEE770000|code`. Its W·H pixels are consumed and
  dropped. A bad header magic gives code 4 and nothing is drained.
  `IMG_OP_CUSTOM` is API-only (`img_run_stages`), so it is an error in a
  stream.
* The END job (`op = 0xFF`) is echoed as 3 words, and `img_stream_loop`
  returns.
* Test images: gray 64x24 and RGBX 32x16. The synthetic
  scene is deterministic and generated by Python: a rectangle, a disc, a
  diagonal line, a gradient and LCG noise.

## 8. Python model (task 4)

`libs/datapath/image/img_model.py` is pure Python 3 with no numpy, so the
test Makefiles have no dependencies.

* `Datapath`: a beat-level model of §5 (64 lanes, 24-bit wrapping
  accumulators, flags from slice 0). It is the reference for the RTL unit
  test.
* `run_stage`: the pixel-level reference, with the borders from §2.
  `run_stage_beats` evaluates the same stage in the hardware order (16-pixel
  chunks, one beat per tap). The self-test checks that the two are identical
  for every op, both formats and both borders.
* `op_stages(op, fmt, thr)`: the op table (§2/§3) as a list of `Stage`s,
  each holding its kernels, config and tap list (row-major, with
  FIRST/LAST/CENTER flags). The C library mirrors this table.
* `stats_trailer` / `run_job` / `build_streams`: the feature trailer and the
  full input/expected cs22 stream for `default_jobs()`. There are 24 jobs:
  every op on gray 64x24, 4 on RGBX 32x16 and 2 error jobs (an unknown op
  and a width that is not a multiple of 16), giving 29,947 input words and
  30,233 expected words.
* `job_error(op, w, h)`: the stream-level validation the C library also
  does. An error job echoes the header plus `0xEE770000|code` (1 = op,
  2 = size, 3 = tiles > 4096) and its pixels are consumed and dropped.
* Scene generator: a gradient, a rectangle, a disc, the diagonal `x = 2y`
  and ±8 LCG noise. Each channel has different shapes, so the RGBX ops
  exercise every lane.
* CLI:
  * `selftest` (about 2 s): hand-checked Sobel step, flat-field invariants
    for the blurs, derivatives and emboss, erode/dilate/peak plateau, 81-tap
    headroom, ROI clipping, compare round trip, and beat-vs-pixel
    cross-check.
  * `gen-unit OUT`: RTL beat vectors (`C`/`B`/`E` lines). They cover
    random configs of every op/comb, extreme values (255·−128 × 81 taps),
    ±32767 offsets, per-lane mode, thresholds and peaks, and random flags in
    slices 1–15.
  * `gen-stream IN EXP`, `compare EXP GOT`: the stream files for
    test_image_1 and the job-by-job diff report.

### 8.1 Simple numpy model (prototyping)

`libs/datapath/image/simple_model.py` is a second model, written
independently of `img_model.py` for readability. Use it to try new kernels
and to check Verilog output.

* Setup: numpy in a venv, so the test Makefiles keep needing only python3:
  `python3 -m venv libs/datapath/image/.venv &&
  libs/datapath/image/.venv/bin/pip install -r libs/datapath/image/requirements.txt`
  (`.venv/` is gitignored).
* Images are `uint8` arrays, `(H, W)` for gray or `(H, W, 3)` for RGB.
  Each op is whole-image numpy:
  * `correlate`: `np.pad` (ZERO/REPLICATE), then the sum of `k[i,j]` times
    the shifted image, in int64 with a 24-bit wrap;
  * `requant`: round, arithmetic shift, offset, clip to u8;
  * optional `threshold`.
* Building blocks (one datapath stage each):
  * `mac(img, ka, kb, comb, shift, rnd, offset, border, thr)`: any s8
    kernel, the same knobs as the k14 config, and the same maths as the C
    API's `IMG_OP_CUSTOM`;
  * `minmax(img, n, 'min'|'max')`: erode/dilate;
  * `peaks(img, thr)`: 3x3 NMS;
  * `stats(img, roi_thr)`: the feature trailer body (§3).
* `OPS`: every stream op as one line built from those blocks.
  `run_stream(words)` turns an input stream into the expected output
  stream, including error jobs and END.
* CLI (run with `.venv/bin/python`):
  * `selftest` (about 7 s): every op, both borders, gray (with junk in the
    unused bytes) and RGB, scene and noise images, and several thresholds,
    compared bit-exactly with `img_model.run_stage` / `stats_trailer`. It
    also checks random 5x5 custom kernels with all four combine modes, the
    24-bit wrap, and the whole test_image_1 stream. A mutation check
    (breaking GAUSS3 rounding) fails as expected.
  * `run IN.hex OUT.hex`: the expected stream. For test_image_1's `in.hex`
    it is byte-identical to `img_model`'s `exp.hex`.
  * `check IN.hex GOT.hex`: model vs Verilog. It passes on test_image_1's
    Verilator `got.hex` and XSIM `xsim_got.hex` (all 24 jobs).
  * `filter OP IN.pgm|ppm OUT.pgm|ppm [--border] [--thr]`: runs one op on a
    real 8-bit netpbm image and prints the max/min/nonzero stats.

## 9. RTL, integration and synthesis (task 5)

* `libs/datapath/image/rtl/img_datapath.v`: a single module with the
  piston-style ports `t_k8/t_k9/t_k14` (req/ack) and `i_k1`. It is a 6-stage
  global-stall pipeline (§5.4). Each lane has two `(* use_dsp = "yes" *)`
  u8×s8 products into 24-bit accumulators A/B, plus a MIN/MAX register and a
  centre-capture register.
* Unit test `libs/datapath/image/sim` (`make`): Verilator `-Wall` lint, then
  a C++ TB that replays `img_model.py gen-unit` vectors (240 random
  sequences plus directed edge cases) with 0 %, 30 % and 70 % random
  backpressure/bubbles. It is bit-exact against the model on every row.
* (M6 state; since M8c the netlists are `piston.v` + `piston_dp_{fft,img}.v`
  from SpinalHDL and `hdl/piston_img.v` is gone, §11.4.)
* Piston integration is generated, not hand-edited. `piston/bin/gen.js`
  builds the piston graph twice and writes two netlists, both defining
  `module piston`:
  * `hdl/piston.v`: FFT datapath (`libs/datapath/lib/datapath.js`);
  * `hdl/piston_img.v`: one `img_datapath` node
    (`libs/datapath/lib/img-datapath.js`, builder + fhyper macro) on the same
    k8/k9/k14 targets and k1 initiator (`dat38/39/40`, `dat42_nxt`,
    `req/ack38_0..40_0`, `req/ack42`). It is about 3.3k lines instead of
    14.4k, because the FFT datapath is gone.
  * The rest of the graph is shared, so the VMEM node index (and
    `c/vmem_node.h`) is identical; `gen.js` checks this.
  * `make -C libs/q-engine/piston lint` lints both (`verilate_lint`,
    `verilate_lint_img`).
* Selection knob `HIGGS_DATAPATH=img`:
  * `verilog_paths.mk` sets `PISTON_NETLIST` to `piston_img.v` and adds
    `img_datapath.v` to `Q_ENGINE_ALL_VERILOG`;
  * `xsim_common.mk` uses `PISTON_NETLIST` for its reg-init patched copy;
  * the CS12 Vivado scripts (`build.tcl`/`implement.tcl`) read the same
    environment variable, swap `piston.v` for `piston_img.v` in `prj_src`,
    add `img_datapath.v`, and write to `out_img/`.
  * No Verilog define is involved.
* Checks for the generator change: regenerated `hdl/piston.v` equals the
  pre-image `piston.v` (ignoring trailing whitespace), and the other `hdl/`
  files differ only in whitespace. Both lint targets are clean. After a clean
  rebuild, test_image_1 passes on Verilator and XSIM (outputs identical) and
  test_fft_lib_1 still passes. A mocked `prj_src` run confirms that Vivado
  gets `piston_img.v` only when `HIGGS_DATAPATH=img`.
* Vivado 2025.2, CS12 (xczu-class part), `sys_clk` 125 MHz:

  | | FFT datapath (baseline) | image datapath |
  |---|---|---|
  | DSP | 38 | 134 (128 lane MACs + 6 elsewhere) |
  | CLB LUT | ~28k | 39,615 |
  | CLB FF | – | 31,128 |
  | BRAM tiles | 72 | 72 |
  | routed WNS | met | **+0.647 ns**, all constraints met |

  The 128 u8×s8 multipliers all mapped to DSP48E2. The extra LUTs are the
  64-lane MIN/MAX, combine and saturate logic plus the 512-bit pipeline.

## 10. Platform test results (task 7)

`sim/verilator/test_image_1` (see its README) builds cs22 with
`HIGGS_DATAPATH=img`, runs `img_init(); img_stream_loop();`, and injects the
24-job stream from `img_model.py gen-stream` into `cs22in`.

* **Verilator** (`make test`): all 24 jobs are bit-exact against the model.
  That covers 18 gray ops at 64×24, two error jobs (bad op, W=40 not a
  multiple of 16) and 4 RGBX jobs at 32×16. END arrives at about 1.95 M
  cycles. A clean build plus the run takes about 4.5 min wall.
* **XSIM** (`make xsim_run`, Vivado 2025.2): PASS. `xsim_got.hex` is
  byte-identical to Verilator's `got.hex`. The run takes about 8 min wall.
* **Regression:** `test_fft_lib_1` with the default FFT datapath still
  passes ("All Tests Passed").

### 10.1 Cycles per job

`tb.cpp` records the 500-cycle tick at which each job header appears in
`cs22out` and prints `JOBCYC` lines. The header goes out once the job
starts, so each gap below covers one whole job: pixels in, kernel, lines
out, trailer.

| job | size | cycles | per pixel |
|---|---|---|---|
| COPY (1 tap) | 64×24 gray | 77.5 k | 50 |
| GAUSS3, BOX3, SHARPEN, LAPLACE, SOBEL, … (3×3) | 64×24 | 91–93 k | ~60 |
| GAUSS5, BOX5 (5×5) | 64×24 | 113 k | 74 |
| GAUSS7 (7×7) | 64×24 | 142 k | 92 |
| PEAKS (Sobel → NMS, 2 stages) | 64×24 | 120 k | 78 |
| GAUSS3 / SOBEL / CHAN_GAUSS / EDGES | 32×16 RGBX | 46–47.5 k | ~90 |
| error job (drain) | 32×3, 40×2 | < 500 | – |

* **Fixed cost.** COPY sets the floor at about 50 cycles per pixel. Most of
  that is the CPU: it reads each input word from the stream FIFO and packs
  it into VMEM, then does per-line output DMA and stats (min/max/nz/sum/tile
  counts are all computed on the CPU per output pixel).
* **Kernel cost.** Each extra tap costs about 14–16 cycles per 16-pixel
  chunk. Measured against COPY over 96 chunks: 3×3 adds ~150 per chunk,
  5×5 ~370 and 7×7 ~670. The per-tap cost is the MVXV + ADD(skew) + LK8 +
  ADD_LK9 issue sequence. The 64-lane datapath itself is never the
  bottleneck.
* **Speed-up options** (not done): move stats to the datapath (min/max are
  already available as MIN/MAX ops); unroll the input packing loop; issue
  the tap sequence from a precomputed schedule so the per-tap address math
  leaves the inner loop.

### 10.2 Issues found by the platform test

1. **MVVK15 idle over-push** (hardware, `vector_slice.v`, §1). The first
   fence design (MVVK15 + SK15) hung on output row 1 of job 0. Fixed in
   the library with an LK13→SK13 token-copy fence (§6.3). The shared RTL
   is unchanged.
2. **First injected word lost on XSIM** (`vex_machine_top.v` input buffer).
   The buffer writes on `temp_valid && temp_ready_delay`, and the delayed
   ready leaves reset one cycle after `o_afull_n`, so a word offered right
   after reset is acked but dropped. `tb_higgs_top_xsim.sv` waits
   `INJECT_DELAY` = 100 cycles after reset before injecting. Verilator's
   injector starts later and never hit this.
3. **Debug method.** `./obj_dir/Vtb_higgs_top +stalltrace`: if no output
   arrives for 500 k cycles, the TB prints the cs22 PC and the fence row and
   writes a 20-cycle `stall.vcd`. Verilator inlines most piston signals, so
   the VCD is the practical way to inspect the inmux/oumux req/ack state.

## 11. SpinalHDL replacement for reqack (M8)

Goal: generate the elastic netlists (`k15_op.v`, `piston.v`, the datapath)
with SpinalHDL instead of reqack's `fhyper-verilog`. Instance and signal
names are explicit and stable, so saved testbench and waveform paths stop
depending on reqack's node numbering (`unode28`). Leaf modules (templated
`*_dat_*` / `*_ctrl_*` from `gen.js`, `muladdsub`, `img_datapath`) are
BlackBoxes for now; porting them to Spinal is a later phase.

### 11.1 Layout
* `libs/spinal/hw/spinal/reqack/`
  * `Graph.scala`: fhyper-like DSL. `g(kind, name)` makes a node,
    `node(ESpec(width, capacity), taillabel)` an output edge, and
    `edge(node, headlabel)` connects a target (chainable). Creation order is
    kept, as in reqack, because per-node input/output order sets
    concat/deconcat/m2c bit and port order.
  * `Buffers.scala`: exact ports of reqack's EB1, EB1.5 (`eb15_ctrl`),
    EB1.7 (`eb17_ctrl`) and FIFO (`eb_fifo_ctrl`, capacity ≥ 2).
  * `Netlist.scala`: elaborates a graph into one flat module: IO ports,
    edges, buffers, edge forks, join and node-fork controllers, and the
    add/sub/concat operators.
  * `Macros.scala`: the standard macro (data module plus a ctrl module or an
    inline controller, reqack's rule), pass-through leaves (`img_datapath`,
    `piston_dp`), deconcat, slice16, m2c, bs and muladdsub.
  * `VerilogHeader.scala`: a strict ANSI header parser. BlackBox ports come
    from the leaf `.v` files, so a template change cannot silently mis-wire.
* `libs/spinal/hw/spinal/qengine/K15Op.scala`: the k15_op graph.
* `libs/spinal/hw/spinal/qengine/Piston.scala`: the piston graph and the
  `PistonVerilog` main (§11.4).
* `libs/spinal/hw/spinal/qengine/PistonDp.scala`: the FFT and image
  datapath graphs (`cmul`, `radix4`, `fft` as in `datapath.js`,
  `img-datapath.js`).
* `libs/spinal/equiv/equiv.py`: the equivalence harness (§11.3).
* `libs/spinal/scripts/direct-run.sh`: runs a generator with scalac from the
  coursier cache when sbt cannot start (§11.6).
* `libs/spinal/names/`: `names.py` + `names.lock` (name lock) and `map.py`
  (reqack → Spinal name map), §11.5.

### 11.2 Naming
Edge `<e>`: `<e>` (buffered data), `<e>_nxt` (source data, buffered edges
only), `<e>_req`/`<e>_ack` (source side), `<e>_m_req`/`<e>_m_ack` (after
the buffer), `<e>_to_<target>_req/ack` (per target, after the fork) and
`<e>_eb_*` (buffer state). The default edge name is
`<source>_<taillabel|output index>`. A source is `t_<label>` for a target
port, `i_<label>` for an initiator port and the node name otherwise. Leaf
instances are named after their node: the data module is `<node>` and the
ctrl module `<node>_ctrl`. Extra data↔ctrl signals (`sel`, `mode`,
`k_ctrl`, …) connect the two instances' pins directly and appear as
`<node>_<port>`. Node names must be unique and differ from their leaf
module name (Verilog allows `img_datapath img_datapath (`, but Spinal
renames the instance `img_datapath_1`; the image node is `img`). Everything
in the generated files is covered by the name lock (§11.5).

Differences from reqack (intentional):
* One flat module per graph, with no `<graph>_ctrl` submodule.
* Unknown capacities (reqack typos such as `cpacity`) are rejected, not
  silently turned into EB0. The ports keep the old EB0 behaviour.
* An unbound leaf input is an error, and so is a custom-controller input
  that is not target 0 of its edge. reqack binds `req<e>_0` there, which is
  a latent miswire.

### 11.3 Equivalence
`gen.js` still runs reqack and writes the reference netlists to
`libs/q-engine/piston/build/ref/` (gitignored). `equiv.py` renames every
module in the reference with a `_ref` suffix and instantiates both copies in
`equiv_top` with shared inputs and the leaf modules shared. The C++ bench
does 8 seeds × 20 k cycles. Each seed biases every 1-bit input with its own
probability, randomises the data every cycle and adds random resets. Every
output is compared on both clock edges. A one-state mutation in an EB1.5 is
caught at cycle 29.

* `make -C libs/q-engine/piston build SPINAL_RUNNER=direct` regenerates
  everything (templates, reqack references, Spinal netlists).
* `make -C libs/q-engine/piston equiv SPINAL_RUNNER=direct` runs the
  checks.

Harness options (added for piston): `--stim PORT=<C++ expr>` overrides the
random value of an input; `--prelude FILE` includes C++ helpers for those
expressions; `fire_<port>` flags (handshake completed in the previous cycle)
let a stimulus model advance on accepted beats; `--reset-rate` sets the reset
probability. A mismatch prints the differing 32-bit words.

Uniform random input words almost never form a useful piston program, so the
full-piston checks use `equiv/piston_stim.h`: a program model that emits
KNOP, LK14 → 1–4 × (LK8, LK9 in random order) → SK1, LK13 → SK13, and random
vector ops (mostly MVXV with small `rs1` so that LK/SK addresses fall in the
vmem words the DMA stimulus writes). The make targets pass it through
`PISTON_STIM` (`libs/spinal/Makefile`).

Results (`make -C libs/spinal equiv SPINAL_RUNNER=direct`):

| check | ref | result |
|-------|-----|--------|
| `equiv_k15_op` | `k15_op.v` | PASS |
| `equiv_piston_dp_fft` | `piston_dp_fft.v` (dp only, §11.4) | PASS |
| `equiv_piston_dp_img` | `piston_dp_img.v` | PASS |
| `equiv_piston_fft` | flat reqack `piston.v` | PASS |
| `equiv_piston_img` | flat reqack `piston_img.v` | PASS |

test_image_1 passes with the Spinal `k15_op.v`.

Mutation checks (each must fail):
* EB1.5 one-state mutation in `k15_op`: caught at cycle 29.
* re/im swapped at the first radix-4 input of `piston_dp_fft`: caught at
  cycle 251 (`i_k1_dat` word 12).
* k8/k9 swapped on the `dp` instance in `piston.v`: caught (seed 2,
  `t_instr_ack`). With uniform stimulus alone it was **not** caught; that
  gap is why `piston_stim.h` exists.
* one bit flipped on `dp → inmux` k1 in `piston.v`: caught for both
  datapaths (seed 2, `i_odma_*_dat`).

Coverage of the full-piston run is modest: tens of accepted instructions
per 20 k cycles, because the image datapath only returns k1 after a beat
whose k9 flags have LAST set, and random memory rarely has it. The dp-level
checks cover the datapath graphs directly; the platform tests (M8c) cover
real programs.

Bug found by the checks: Spinal's `Cat(seq)` already puts the first element
at the LSB. `Cat(args.reverse)` in the concat operator reversed every concat
node; it is now `Cat(args)`.

### 11.4 piston split
reqack emitted `piston.v` (and `piston_img.v`) as one flat module with the
datapath graph merged in. The Spinal version splits it:
* `piston_dp_fft.v` and `piston_dp_img.v` both define `module piston_dp`
  with the same ports (k8, k9, k14 in; k1 out). `PistonVerilog` checks the
  two headers match.
* `piston.v` instantiates `piston_dp` as the pass-through node `dp`. The
  datapath is then selected by which `piston_dp_*.v` file is compiled, and
  `piston.v` is shared.
* `gen.js` also writes dp-only reqack references
  (`build/ref/piston_dp_{fft,img}.v`) so each datapath graph is checked on
  its own, not only through the piston.

`PistonVerilog` post-patches `piston.v`:
* the top parameters become `VMEM_SIZE` and `VMEM0..31` (reqack called them
  `NODE28_*`; `q_engine.v` passes the new names, `piston_test_top.sv` uses
  the defaults);
* the vmem data module is `vmem_dat_6_5_1_1` under `HIGGS_FPGA_XILINX` and
  `vmem_dat_6_5` otherwise, as in `gen.js`.

Build integration (M8c):
* `make -C libs/q-engine/piston build` runs `gen.js` (templates, reqack
  references and `.dot` graphs in `build/ref/`, `c/vmem_node.h`) and then
  `make -C libs/spinal reqack`, which writes `hdl/k15_op.v`, `hdl/piston.v`,
  `hdl/piston_dp_fft.v` and `hdl/piston_dp_img.v`. Nothing in `hdl/` comes
  from reqack any more.
* The piston Makefile targets are `.PHONY` (M8d): the `build/` directory
  otherwise made `make build` and `make lint` skip generation. `make lint`
  starts with `clean` (`rm -f hdl/*`), which also deletes the checked-in
  `piston.svg`, `vmem_dat_6_5_1_1.v` and
  `vmem_dat_arb_out_spinal_wrapper.v`; restore them with `git checkout`.
* `verilog_paths.mk`: `PISTON_NETLIST = piston.v piston_dp_<fft|img>.v`
  (`HIGGS_DATAPATH`); `xsim_common.mk` picks it up unchanged.
* Vivado/Diamond: `diamond_sources.tcl` lists `piston.v` and
  `piston_dp_fft.v`; the CS12 `build.tcl` swaps `piston_dp_fft.v` for
  `piston_dp_img.v` when `HIGGS_DATAPATH=img`. The Xilinx sim Makefiles
  (`fpgas/common/xilinx/sim/{q_engine,vex_machine_top}`) list
  `piston_dp_fft.v`; `sim/piston` globs `hdl/*.v` and now filters out
  `piston_dp_img.v` (it also picked up both `piston.v` and `piston_img.v`
  after M6, a duplicate `module piston`).
* The vmem data instance is `vmem` (was `unode28`): `c/vmem_node.h` and
  `sim/verilator/inc/piston_c_types.h` define `UNODE_NAME vmem`, and the
  direct references in `test_xbb/tb.cpp`, `test_dma_slicer/tb.cpp` and
  `test_fill_lib/tb_higgs_top_xsim.sv` use `vmem`. Saved `.gtkw`/`.tcl`/
  `.lpf` paths were migrated in M8d (§11.5).

### 11.5 Name lock and the reqack name map (M8d)
Saved paths into `piston_inst` (gtkw, higgs.tcl signal lists, Diamond LPF
`BLOCK NET`/`BLKNAME`, tb.cpp, the C headers) must not break silently when
the generator changes.

Name lock: `libs/spinal/names/names.py` lists every declared port, wire,
reg and instance of `piston.v`, `piston_dp_{fft,img}.v` and `k15_op.v`
(except Spinal temporaries `_zz_*`) and compares it with the committed
`libs/spinal/names/names.lock` (5514 names). `make reqack` runs
`make names_check` after generating, so a rename fails the build with a
`-`/`+` list. It also flags new wire/reg pairs `x` and `x_<n>` (Spinal's
clash suffix). To accept a rename, run `make names_lock`, migrate the saved
paths, and commit both.

Clash suffixes fixed while adding the lock:
* The extra data↔ctrl wires collided with Spinal's BlackBox pin wires and
  produced about 30 `_1` names (`inmux_sel_1`, `vector_instr_0_ready_1`,
  `k1_defunnel_mode_1`, …). The extras now link pin to pin
  (`Leaf.link`, which also checks the widths).
* The `img_datapath` instance was `img_datapath_1` (node named after its
  module); the node is now `img`.

The equivalence checks compare ports only and still pass.

reqack → Spinal map: `libs/spinal/names/map.py`.
* Inputs: `gen.js` dumps the reqack graphs (`build/ref/{piston,piston_img,
  piston_dp_fft,piston_dp_img}.json`, with the node/edge range the datapath
  generator created), and `qengine.PistonGraphs` dumps the Spinal graphs
  (`libs/spinal/build/names/*.json`).
* The graphs are paired structurally, not by index: Spinal names reqack's
  anonymous nodes and creates some in another order (`dp` is node 37, the
  reqack datapath block is nodes 53–222). Seeds are labels unique in both
  graphs; pairs propagate through each node's ordered input/output edges
  and each edge's source and ordered targets. At piston level the reqack
  datapath block is one `piston_dp` node; inside, the reqack dp-only graph
  is paired with the Spinal dp graph. Every reqack node and edge pairs.
* Each reqack name is translated with the §11.2 table (`unodeN` → node,
  `uctrl.unodeN` → `<node>_ctrl`, `datN` → edge, `datN_r0` → `<e>_eb_r0`,
  `selN` → `<e>_eb_sel`, `reqNm` → `<e>_m_req`, `reqN_k` →
  `<e>_to_<target>_req`, datapath names → `dp.<name>`) and kept only if it
  is declared in the Spinal netlist. FFT: 3570 of 4879 names map; the rest
  are reqack controller internals with no Spinal counterpart
  (`uctrl_<k>` EB controllers, fork registers, FIFO pointers).
* Cross-check: for every reqack `unodeM.<port>(datN…)` connection the
  mapped Spinal instance port reaches the mapped edge (144 connections; the
  two exceptions are p_decode `i_p_{sk,lk}`, where both netlists
  zero-extend a 64-bit port onto a 68-bit edge).

```sh
make -C libs/q-engine/piston build SPINAL_RUNNER=direct   # reqack .json
libs/spinal/scripts/direct-run.sh qengine.PistonGraphs libs/spinal/build/names
python3 libs/spinal/names/map.py map fft          # "<reqack> <spinal>"
python3 libs/spinal/names/map.py migrate fft FILE...
```

Migration (FFT map, since the saved files predate the image datapath)
rewrote 419 paths in 47 files, e.g. `unode26` → `vector`,
`dat29_r0` → `cmd_lane_14_0_eb_r0`, `sel29` → `cmd_lane_14_0_eb_sel`,
`dat40_r` → `oumux_k14_eb_r`, `dat232` → `dp.s0_r4_c0_im_0`, and the
flattened Diamond LPF nets `req40`/`req40m` → `oumux_k14_req`/
`oumux_k14_m_req` (synthesis flattens reqack's `uctrl`, so controller
names also match at `piston_inst` scope). Line endings are preserved (the
LPFs are CRLF).

Left as is: paths that the reqack netlist did not have either, i.e. stale
before M8 (`unode13` ×631 and `unode17` ×129, mostly commented-out LPF
lines; `unode10`, `instr_0_valid11`, `ivs_valid15`, `ivs_ready15`, `en28`,
`dat28_r`, `dat26_r`).

### 11.6 sbt on shared machines
On this host sbt 1.10 cannot start: it always creates an inotify watch
service and the per-user inotify instance limit is exhausted. The sysctl was
deliberately not changed on a shared machine. `SPINAL_RUNNER=direct` makes
the `libs/spinal` Makefile use `scripts/direct-run.sh`, which compiles
`hw/spinal` with the same Scala 2.13.14, SpinalHDL 1.11.0 and idsl plugin
jars from the coursier cache (sbt must have filled it once) and runs the
main class (about 2 s after the first compile).


## 12. Reciprocal in the FFT datapath (M9)
A 1/c unit in each of the 8 cmuls of the Spinal FFT datapath, so that
`vector_divide_1024()` computes x / Re(y) with the existing
LK14 → LK8/LK9 → SK1 schedule. The image datapath is unchanged.

### 12.1 Sources studied
* `libs/d-engine/rtl/reciprocal` (reqack `reciprocal.js`, `hdl/reciprocal.v`):
  a 3-stage Newton-style reciprocal in Q6.10, Y ≈ 2^20 / X.
  Two defects (bit-exact model of it, compared over all 16-bit inputs):
  * |X| in [1, 31] wraps the result to 0 instead of saturating;
  * negative X is treated as unsigned (a huge X, so Y ≈ 0).
* The earlier attempt to put it in the FFT datapath (closed_higgs) broke
  other tests. Three bugs:
  1. it repurposed m2c **code 2** (constant 1), which the 8
     `config_word_add_*` rows use on ac/bd/cd/da, so every vector add
     became a multiply by 1/c;
  2. one reciprocal queue was shared by several lanes, cross-wiring their
     results;
  3. the 16-bit result was zero-extended into the 18-bit lane, so a
     negative 1/c became a large positive number.

Decoding all 83 k14 config words in the repository: m2c codes 0, 1 and 2
are used, **code 3 never**. The unit takes code 3.

### 12.2 Design Decisions
| decision | choice |
|----------|--------|
| placement | always in the FFT datapath, one unit per cmul (8); `PistonDp.fft(recip = false)` removes it |
| select | m2c code 3 on m2c_ac and m2c_cd → 1/c (c = Re(y), low 16 bits of the k9 lane); codes 0–2 and the k14 layout unchanged |
| numerics | the d-engine algorithm and constants (C1 = 0x5dd ≈ 1.466, C2 = 0x401 ≈ 1.0012, M = 6), with fixes: sign-magnitude, ±32767 for \|X\| < 32 (including 0), 18-bit sign extension |
| resources | 8 × 2 small multipliers (10×11, 11×11); the FFT build uses 38 of 1,728 DSP48E2 on the xczu7ev |

`libs/spinal/hw/spinal/qengine/Reciprocal.scala`, three `FuncMacro` nodes
with EB1 edges between them (latency 3):
* norm: `neg`, `sat = |X| < 32`, `lz` = leading zeros of |X| (16 bit),
  `xn = (|X| << lz) >> 6` (10 bits, [0.5, 1));
* mul: `y0 = C1 − xn`, `u = C2 − (xn·y0)[20:10]`;
* out: `r = (u·y0)[21:10] << 2`, renormalized by `lz` (`>> (6 − lz)` or
  `<< (lz − 6)`), saturated to 0x7fff, negated if `neg`, sign-extended to 18
  bits.

In `PistonDp.cmul` the c edge forks to `<cmul>_recip_norm` (its last
target), and m2c_ac/m2c_cd become `m2c_r` (`M2c(Seq(0, 1, 3))`: inputs
a|c, c, 1, 1/c) with the recip edge before the cfg edge. An unselected m2c
input is acked unconditionally, so the unit drains when code 3 is not used.
New generic reqack pieces: `class M2c(codes)` and `FuncMacro` (a join node
with a Scala function body), both in `reqack/Macros.scala`.

Accuracy (`recip_model.py`): at most 0.6 % relative error for |X| < 4096;
up to 3.3 % for large |X|, where 2^20/X has few integer bits. `recip(−32768)
= −32`.

### 12.3 Using it
* Config row `config_word_cdiv_eq_05` = `config_word_cmul_eq_0f` with
  shorts 0–7 = `0x4753` (ac = cd = 3) and bs = 5. Each lane computes
  (a + jb) · (1/c + jd) >> 5, i.e. Q1.15 · Q6.10 → Q1.15; with d = 0 this is
  (a + jb) / c. Saturates like any cmul.
* `vector_divide_1024(x_row, y_row, out_row)` (`vector_divide.{h,c}`, a
  wrapper of `cfg_vector_multiply_1024`). It is a separate header so that
  existing users of `vector_multiply.h` do not get an extra VMEM row.
* Throughput (test_recip_1, 1024 words + fence): divide 593 timer ticks,
  plain cmul 533 (+11 %). The a/b/d operands wait for the 3-stage 1/c.

### 12.4 Verification
* Model vs the d-engine netlist behaviour: identical for 32 ≤ X ≤ 32767.
* `make -C libs/spinal recip_test`: the Spinal unit (`RecipUnitVerilog`,
  `libs/spinal/recip/tb_recip.cpp`, random req/ack) against the model for
  all 65,536 inputs: PASS. Mutation: C1 off by one fails; `|X| < 32` →
  `< 16` is equivalent (the 18-bit `rn` saturates anyway).
* Names: 432 new names, 0 removed (`names.lock` updated); the 99 k14 cfg
  fields decode identically.
* Regeneration: `make -B -C libs/spinal piston` reproduces the committed
  `hdl/` byte for byte.
* test_recip_1 (see its README): bit-exact, 0 mismatches in 2 × 1024 words
  including special divisors and d ≠ 0. An exact `round(2^20/c)` model
  gives 89 mismatches, so the test sees LSB differences.

### 12.5 Equivalence with the reqack FFT datapath
The reference has no reciprocal, so code 3 legitimately differs (an
unconstrained `equiv_piston_dp_fft` fails at cycle 21). `equiv.py` got two
options:
* `--fixup STMT`: C++ run after the inputs are set each cycle. For
  `piston_dp_fft`, `norecip_k14(m->t_k14_dat)` (`equiv/norecip.h`) remaps
  code 3 of every m2c_ac/m2c_cd field to a random 0–2. `piston_stim.h`
  applies the same to the DMA data.
* `--stop EXPR`: ends a seed early (not a failure) after the first cycle
  where EXPR is true. In the full piston, SK1 results written to vmem can
  later be loaded by LK14 with code 3, which no input constraint prevents.
  `norecip_piston_code3(m)` (needs `--vflags=--public`; `dut(m)` reaches the
  DUT instance) stops when such a k14 enters the DUT datapath.
  `equiv_piston_fft` runs 16 seeds.

Result: all 5 checks PASS. `piston_fft`: 292,864 cycles compared, seeds 6
and 12 stopped at cycles 7,767 and 5,097. Seed 6 used to fail at cycle
8,573 (`t_instr_ack`); a probe showed the first code-3 k14 accepted at
cycle 7,766, and the pre-reciprocal dp passes all 8 seeds with the same
stimulus, so the difference is the reciprocal itself.

### 12.6 Regression
`/home/ubuntu/work/recip_regress/run.sh` (outside the repo) runs `TEST_LIST`
(32), `RANDOMIZED_TESTS` (12) and test_image_1, test_cmul, test_fft_2,
test_dengine_1 in 4 git worktrees (tests write into the shared
`fpgas/cs/*/c/build`, so parallel runs need separate trees).

Baseline (`ed43299`, before M9): 48 tests, 39 PASS, 9 FAIL. The failures
are pre-existing and unrelated to the datapath:
* test_mapper_lib, test_mover_lib: Python 2 syntax in the post-check;
* test_cmul: needs cs30, which no longer exists;
* test_dengine_1: `DUPLEX_FRAMES` undeclared in its firmware;
* test_issue_112, test_issue_112_b, test_fork_1: tb C++ cannot find
  `schifra_galois_field.hpp` (the `libs/s-modem/soapy/src/3rd/schifra` submodule is not
  initialized);
* test_ring_3: `TEST_SELECT=8` is an invalid test in its tb;
* test_fft_2: segfaults after the ring returns 0 items.

After (`47aa34a`, M9; test_recip_1 now in `TEST_LIST`): 49 tests, 40 PASS,
9 FAIL. The same 9 tests fail with the same errors, and every baseline
PASS still passes, including test_fft_lib_1, test_image_1, test_hw_mul,
test_dma_fft, test_tx_9 and the feedback-bus tests. test_recip_1 passes (0
mismatches; divide 593 ticks, cmul 533). No regression.

# Q-engine complex FIR filter plan

This file is the agreed contract for adding a streaming complex FIR filter to
the Q-engine. `NOTES.md` records evidence and findings; `README.md` is the
entry point.

## Contract

### Topology

- The Xilinx VMEM crossbar (`VmemDatArbOut1_1`, `vmem_dat_6_5_1_1`,
  `memory_slice_1_1_xilinx`) grows from 4 to 6 DMA ports (DMA tag 2 -> 3
  bits). `piston.v` gains `t_idma_4/5` and `i_odma_4/5` only under
  `HIGGS_FPGA_XILINX`; the legacy Lattice `vmem_dat_6_5` is untouched.
- Port 4 is the FIR feed (VMEM read -> FIR), port 5 is the FIR result
  (FIR -> VMEM write).
- In `q_engine.v` the FIR, DMA_3 and DMA_4 are instantiated under
  `` `ifdef HIGGS_FPGA_XILINX `` and `` `ifndef NO_FIR ``. Elsewhere the new
  CSR interfaces are tied off.

### DMA / CSR map

| DMA   | Direction              | Engine            | CSR base |
|-------|------------------------|-------------------|----------|
| DMA_3 | VMEM -> FIR (feed)     | `dma_out_last`    | `0xB48`  |
| DMA_4 | FIR -> VMEM (result)   | `dma_in`          | `0xB58`  |

The register layout is identical to DMA_0/1/2 (`START_ADDR`, `LENGTH`, `TIMER_VAL`,
`PUSH_SCHEDULE`, `STATUS`, `SCHEDULE_OCCUPANCY`, `FLUSH_SCHEDULE`,
`INTERRUPT_CLEAR`, `REVERSE`, `LAST_RTL`). The new DMAs are poll-only; they
are not added to `io_externalInterrupt`. `0xB30-0xB3F` stays reserved for
profiling. `XbbRiscv.v` is regenerated for every build.

### Numeric format

- Every 32-bit word is one complex value: I (real) in `[15:0]`, Q (imag) in
  `[31:16]`, both signed two's complement. Data and coefficients use the same
  format (nominally Q1.15).
- `y[n] = sum_{k=0}^{NTAPS-1} h[k] * x[n-k]` (complex multiply, full precision,
  4 real multiplies per tap, wide accumulator).
- Output per component: `sat16((acc + (shift ? 1 << (shift-1) : 0)) >>> shift)`
  (round half up, arithmetic shift, saturate to [-32768, 32767]).
- Verilog parameters: `NTAPS` (default 16), `DW` (default 16), `CW` (default 16). The
  runtime `shift` (0..31) defaults to 15 after reset.

### Stream framing

The FIR input is an AXI-stream-like `data/last/valid/ready`. One packet is a
header word followed by a payload, and `last` marks the final word of the
packet.

Header word:

| Bits    | Field                                              |
|---------|----------------------------------------------------|
| `31:16` | magic `0xF1F0`                                     |
| `15:13` | reserved, must be 0                                |
| `12:8`  | shift (read only by LOAD_COEFFS)                   |
| `7:4`   | reserved, must be 0                                |
| `3:0`   | opcode: 1 = DATA, 2 = LOAD_COEFFS, 3 = RESET       |

- **DATA**: header + 1..N samples. One output per sample, and output `last`
  is set on the sample that had input `last`. A DATA header with `last`
  (zero samples) is a no-op and is not an error.
- **LOAD_COEFFS**: header + exactly `NTAPS` words, first word = `h[0]`
  (multiplies the newest sample). Produces no output. Coefficients go to a
  shadow bank that is committed only when the packet is complete. The
  delay line is **not** cleared. The new `shift` is committed together with
  the taps.
- **RESET**: header only. Zeroes the delay line; coefficients and shift are
  kept. Produces no output.
- The delay line persists across DATA packets, so a stream can span many DMAs.
- Coefficient/shift changes take effect in stream order.

### Errors

The module always drains the offending packet up to and including `last`,
never emits output for it, and never deadlocks. It sets sticky error bits
(module ports, with a clear input; they are left unconnected in `q_engine`):

- `ERR_HDR`: bad magic, bad opcode, or nonzero reserved bits. The packet is dropped.
- `ERR_COEF_LEN`: `last` arrived before `NTAPS` words, or the `NTAPS`-th word
  was not `last`. The coefficients stay unchanged and extra words are drained.
- `ERR_RST_LEN`: RESET followed by payload. The reset is still applied and
  extra words are dropped.

### Micro-architecture

- Fully parallel direct form, 1 sample/clk: an `NTAPS`-deep complex delay line,
  `NTAPS` 4-multiply complex multipliers (64 DSP48E2 at NTAPS=16), and a
  registered adder tree.
- Global pipeline enable plus a registered output skid buffer, giving full
  valid/ready with no combinational `ready` path through the datapath.
- The RTL is Verilog-2005 (`libs/q-engine/hdl/fir/fir_filter.v`) for Verilator 4.016 and
  Vivado.

### C library

`libs/riscv-baseband/c/inc/fir_driver.{h,c}` plus DMA_3/DMA_4 defines in
`csr_control.h`. A packet is two chained DMA_3 schedules: first the header
word from a VMEM scratch word with `last=0`, then the payload with `last=1`.
The caller's buffers therefore do not need a reserved header slot.

- `fir_init()` (phase 2: after `qstream_init(scratch_vmem)`, which owns
  the VMEM scratch; phase 1 took `FIR_SCRATCH_WORDS` scratch words here)
- `fir_load_coeffs(const uint32_t *coeffs_vmem, unsigned shift)`
- `fir_reset()`
- `fir_filter(const uint32_t *in_vmem, uint32_t *out_vmem, unsigned n)`
  (non-blocking; registers the output before sending), `fir_filter_cb`
- `fir_busy()`, `fir_wait()`
- `fir_send_raw(words_vmem, n, out_vmem, out_n)` (test only; the caller
  supplies the header word, and output is captured when `out_n > 0`)
- `FIR_HDR_*` header macros and `FIR_SAMPLE(i, q)`

### Verification and timing

- Python model: `libs/q-engine/hdl/fir/model/fir_model.py`, bit-exact, the
  single source of truth.
- Module harness `fpgas/common/xilinx/sim/fir_filter/`: vectors generated by
  the Python model, including every error case, zero-length DATA, and
  single-word packets. Seeded random input gaps and output backpressure,
  long stalls, `last` placement, output stability under stall, sticky errors, and a
  bit-exact scoreboard. About 20 seeds, run under Verilator and XSIM, with
  identical traces.
- System test `sim/verilator/test_fir_1`: CS20 override firmware, Xilinx
  VMEM defines. Sequence: LOAD_COEFFS(A) -> DATA split over 3 DMAs ->
  LOAD_COEFFS(B, different shift) -> DATA -> RESET -> DATA -> bad header ->
  DATA. The output goes through VMEM -> DMA1 -> CS20 stream and is compared
  bit-exactly against the model. Verilator and XSIM must give an exact compare.
- Timing on `xczu7ev-ffvc1156-2-e` at 125 MHz: out-of-context P&R of `fir_filter`
  (WNS >= 0, with resource report) and a full CS12 routed build with the FIR
  integrated (WNS >= 0).

## Ordered work

1. Contract (this file).
2. Python fixed-point complex FIR model.
3. `fir_filter` RTL + module harness (Verilator + XSIM, seeded
   backpressure/last/error coverage) against the model.
4. Expand the crossbar to 6 DMA ports and connect the FIR with DMA_3/DMA_4
   (mirroring the NCO + DMA_2 integration).
5. CSR plugins + C library.
6. `sim/verilator/test_fir_1` full-system test against the model.
7. Timing on `xczu7ev-ffvc1156-2-e`.

## Milestone rule

Each verified step is committed on the current branch (no push).

# Phase 2: stream router and Golay correlator

## Topology

```text
DMA_3 -> [stall] -> stream_router(N=2) -> port 0 -> [stall] -> fir_filter -> [stall] -+
                                       -> port 1 -> [stall] -> golay_corr -> [stall] -+-> stream_merge(N=2) -> [stall] -> DMA_4
```

`[stall]` is `stream_stall`, a sim-only shim that is compiled in only under
`` `ifdef QSTREAM_STALL_INJECT ``. It randomly drops valid/ready with a seed
from a `+STALL_SEED=<n>` plusarg. Otherwise it is a pure wire, so synthesis
never sees it.

## Route word (`stream_router`)

The first word of every DMA_3 packet (all words up to and including `last`)
is a route word. The router consumes it and forwards the rest of the packet,
with `last` unchanged, to the selected port.

| Bits    | Field                         |
|---------|-------------------------------|
| `31:16` | magic `0x5271`                |
| `15:4`  | reserved, must be 0           |
| `3:0`   | port (`< N`, parameter N=2)   |

- If the magic is wrong, a reserved bit is set, or port >= N, the whole
  packet is dropped up to `last` and the sticky error `err[0]` is set. The
  router never deadlocks.
- A route word that carries `last` (a one-word packet) is a no-op and is
  not an error.
- `t_ready` is registered (input skid). `i_valid`/`i_data` come from
  registers.

## Tag word (`stream_merge`)

For each output packet, the merge prepends one tag word:
`0x5271 << 16 | seq[7:0] << 4 | port`. Here `seq` is an 8-bit per-port
counter of output packets that wraps at 256 and resets to 0. The tag is
emitted only when an arm actually produces a packet, so FIR/correlator
config and reset packets get no tag. Arbitration is packet-level round
robin: the merge locks on the winning port until that port's `last`. The
tag never carries `last`, and payload `last` passes through unchanged.

## Ports

- Port 0 is `fir_filter`. Its packet is `[ROUTE 0][FIR hdr][payload]`, and
  its output is `[TAG 0][samples]`.
- Port 1 is `golay_corr`. Its packet is `[ROUTE 1][CORR hdr][payload]`,
  and its output is `[TAG 1][samples]`.

## Golay correlator (`golay_corr`)

> **Superseded by phase 3:** `fft_corr` replaced `golay_corr` on port 1,
> and the Golay RTL, model and harness were deleted (see git history).

This is an Efficient Golay Correlator (EGC): no multipliers and no BRAM.
The parameter `M` (default 7) sets the stage count, so `L = 2^M = 128`.

- **Configuration:** each stage k = 1..M has a delay exponent `P(k)` in
  0..M-1, giving `D_k = 2^P(k)`, and a seed `w_k` in {+1, -1, +j, -j}
  (codes 0..3). Any setting is legal; the hardware does not check that the
  exponents form a permutation.
- **Pair generation (model, C library):**

  ```text
  a_0 = b_0 = delta
  a_k[n] = w_k a_{k-1}[n] + b_{k-1}[n - D_k]
  b_k[n] = w_k a_{k-1}[n] - b_{k-1}[n - D_k]
  ```

  a = a_M and b = b_M. Every entry is in {+-1, +-j}.
- **Correlator:** `ra_0 = rb_0 = x`.

  ```text
  ra_k[n] = conj(w_k) ra_{k-1}[n - D_k] + rb_{k-1}[n]
  rb_k[n] = conj(w_k) ra_{k-1}[n - D_k] - rb_{k-1}[n]
  ```

  This gives `Ra = ra_M = sum_i conj(a[i]) x[n-L+1+i]`, and likewise `Rb`.
  For a config that is not a permutation, the same identity holds with
  sequences of length `1 + sum(D_k)`.
  `|ra_k|, |rb_k| <= 2^(15+k)`, and the positive bound is reachable
  because -32768 has no positive counterpart. Stage k therefore outputs
  17+k bits, so Ra/Rb are 17+M bits and the mode-0 sum is 18+M bits.
- **Output modes (from the LOAD_CFG header):**
  - mode 0 (default) outputs `C[n] = Ra[n-L] + Rb[n]`. When a‖b is
    transmitted, it peaks at 2L·amplitude at the last sample of b.
  - mode 1 outputs `Ra`.
  - mode 2 outputs `Rb`.
  - mode 3 is an invalid-config error.

  Each component is `sat16((v + round) >>> shift)`, the same as the FIR.
- **History:** "history" is the last `2^(M-1)` values entering each
  stage's delayed branch, plus the last L values of Ra for mode 0. History
  persists across DATA packets and config loads. RESET zeroes all of it.
  Config commits and resets take effect in stream order, so earlier
  samples use the old config.
- **Default after reset:** `P(k) = k-1`, `w_k = +1`, shift = M, mode 0.

### Correlator framing

The framing mirrors the FIR contract.

- **Header:** magic `0xC0A7` in `31:16`. The other fields are:

  | Bits    | Field                                            |
  |---------|--------------------------------------------------|
  | `15:13` | reserved                                         |
  | `12:8`  | shift                                            |
  | `7:6`   | mode (used by LOAD_CFG only; must be 0 for other ops) |
  | `5:4`   | reserved                                         |
  | `3:0`   | op: 1 = DATA, 2 = LOAD_CFG, 3 = RESET            |
- **DATA:** one output per sample. The output `last` follows the input.
  A header-only packet is a no-op.
- **LOAD_CFG:** header plus exactly M words. Word k-1 holds `P(k)` in
  `3:0` and the seed code in `5:4`; every other bit must be 0. The words
  go to a shadow copy that is committed only when the complete packet is
  valid.
- **Sticky errors** (module ports only), all of which drain the packet to
  `last`:
  - `err[0]` bad header;
  - `err[1]` LOAD_CFG length is not M;
  - `err[2]` RESET with a payload (the reset is still applied);
  - `err[3]` bad config word (`P >= M`, reserved bits set) or mode 3. The
    config stays unchanged.

  Precedence details:
  - A non-zero mode on a DATA or RESET header is a bad header (`err[0]`).
  - A LOAD_CFG header with mode 3 sets only `err[3]`, and its payload is
    not length-checked.
  - A LOAD_CFG that is both short and has a bad word sets `err[1]` and
    `err[3]`. So does one that is long and whose first M words include a
    bad word.
  - Words after the M-th are not checked.

## Firmware

- `qstream.{h,c}` owns the DMA_3/DMA_4 plumbing.
  - **Send:** `qstream_send(port, hdr, payload, n)` sends one packet as two
    chained DMA_3 schedules: a `[route, hdr]` pair from a ring of 8 VMEM
    scratch slots, then the payload with `last`. Caller buffers need no
    reserved slots. A slot is reused only after a later DMA_3 schedule has
    completed (or DMA_3 is idle). `qstream_send_words` (caller-supplied
    header) and `qstream_send_raw` (no route word) exist for tests.
  - **Receive (as built):** every output packet is registered first with
    `qstream_expect(port, dst, n, cb, ctx)` into a per-port FIFO (16 deep).
    qstream keeps one 1-word DMA_4 schedule armed for the next tag. When
    the tag lands, `qstream_poll()` checks its magic, port and sequence
    number, pops that port's next expected packet and schedules DMA_4 for
    `n` words **directly into `dst`** (no receive ring, no copy), then
    re-arms the tag. dma_in holds `ready` low between schedules, so the
    merge simply waits. Completion is counted from the DMA_4 schedule
    occupancy, and then the callback runs. A tag with a bad magic or an
    unexpected port is fatal (`QSTREAM_EPROTO`); a sequence mismatch is
    recorded in `qstream_errors()`.
  - Every blocking loop (DMA_3 room, slot reuse, expect-FIFO room,
    `qstream_wait`) services the receive side, so full schedule FIFOs
    cannot deadlock.
- `fir_driver` and the new `xcorr_driver` are built on `qstream`
  (`qstream_init(scratch)` once, then `fir_init()` / `xcorr_init()`).
  FIR and correlator jobs may overlap freely: packets for both ports are
  queued back to back and qstream sorts the outputs by tag.
  `xcorr_golay_pair_words()` generates a pair on the target (permutation
  configs only).

## Verification

- **Module harnesses** (Verilator + XSIM, about 20 seeds, trace parity)
  cover:
  - `stream_router` alone;
  - `stream_merge` alone;
  - router -> two random echo arms -> merge, with both arms busy;
  - `golay_corr` against the Python model.

  All of them randomize gaps, backpressure, `last` and error packets.
- **Full-system tests.** All of these run with stall injection:
  - `test_fir_1`, updated for route/tag words;
  - new `test_qstream_1`, which uses the qstream library;
  - new `test_xcorr_fir_1`, which alternates FIR and correlator jobs
    drawn randomly from `TEST_SEED`. It runs 8 seeds under Verilator and
    2 under XSIM.
- **Timing:** OOC runs for `golay_corr`, `stream_router` and
  `stream_merge`, plus a full CS12 routed build.
- **Regression:** all existing harnesses and `test_nco` must still pass.

## Ordered work (phase 2)

1. Router/merge RTL; route word added to `fir_driver`.
2. Router/merge harnesses (alone and combined), then existing regressions.
3. Correlator contract (this section).
4. Golay Python model; `golay_corr` RTL and harness.
5. Correlator integrated on port 1.
6. `qstream` library and `test_qstream_1`.
7. `test_xcorr_fir_1`: multi-seed and stall-injected.

# Phase 3: FFT overlap-save correlator (`fft_corr`, replaces `golay_corr`)

The goals were an arbitrary reference and an architecture unlike the FIR and
Golay designs.

## Decisions

| # | Topic | Decision |
|---|---|---|
| 1 | Goal | Arbitrary loadable reference |
| 2 | Reference alphabet | Full 16-bit complex (packed like the FIR: I `15:0`, Q `31:16`) |
| 3 | Length | Parameter `N` (maximum taps), default 256, power of 2 from 16 to 1024 |
| 4 | Throughput | At least one sample per 4 clk (31.25 MSPS); backpressure above that |
| 5 | Engine | Own radix-2² SDF pipelines: one forward (DIF) and one inverse (DIT) core |
| 6 | Reference load | Time-domain taps; the hardware FFTs them into an H BRAM |
| 7 | Framing | One output per input, `last` follows the input, history persists |
| 8 | Numerics | Deterministic fixed point, bit-exact Python model |
| 9 | Modes | 0 = complex y (sat16 I/Q); 1 = \|y\|² (unsigned 32-bit) |
| 10 | Golay | Deleted; `fft_corr` takes router port 1 |
| 11 | Reference length | 1..N taps; front zero-padded, so the peak lands on the last matched sample |
| 12 | Encoding | Below |
| 13 | Verification | Below |

## Function

`K = 2N`. For a loaded reference `ref[0..R-1]` (1 <= R <= N):

```text
y[n] = sum_{i=0}^{R-1} conj(ref[i]) * x[n-R+1+i]
```

Samples before the last RESET (or power-up) count as 0. This is computed by
overlap-save:

- `c[k] = conj(ref[R-1-k])` for k < R, else 0 (length K).
- A block is the last K input samples `w[0..K-1]` (the newest is
  `w[K-1]`), launched after `m` new samples.
- `z = IFFT(FFT(w) · FFT(c))`. Positions `K-m .. K-1` are the m new
  outputs; they are free of wrap because `m <= B = K-N+1 = N+1`.

**Block rule** (bits depend on block boundaries, so this is part of the
contract): a block launches when a DATA packet has accumulated `B` new
samples, and at its `last` beat if `0 < m < B`. Boundaries depend only on
the sample sequence and packet framing, never on timing.

## Numerics (bit-exact)

These use `W = 27` data bits (the 27-bit DSP port) and `TW = 18` twiddle
and H bits, so each real multiply is one DSP48E2. A study showed that 24
bits gave about 13 output LSB rms error in the worst case (identity
reference, full-scale noise), while 27 bits gives about 1.7 LSB there and
0.3–1 LSB on realistic correlations.

- `rs(v, s)` rounds half up, `(v + 2^(s-1)) >> s`, for s > 0. For s <= 0
  it is `v << -s`. `sat_b` saturates to b-bit signed.
- **Twiddles:** `W_K^t = (round(cos(2πt/K)·A), round(-sin(2πt/K)·A))`
  with `A = 2^17 - 1`.
  - They are derived from one quarter-wave table
    `Q[u] = round(cos(2πu/KMAX)·A)`, u = 0..KMAX/4, KMAX = 2048, using
    symmetry, so every K ≤ KMAX shares one ROM with identical values.
  - The ROM is generated into `fft_corr.v` (between the
    `BEGIN/END generated fftc_qrom` markers) by
    `python3 model/fft_corr_model.py --qrom fft_corr.v`.
  - Complex multiply by a twiddle: each rail is
    `rs(exact integer sum of products, 17)`.
  - The inverse uses `conj(W)`.
- **Forward FFT (DIF radix-2², natural in, bit-reversed out).** For group
  size `S = K, K/4, ...` while `S >= 4`, on each group:
  1. butterfly with span S/2, `(a+b, a-b)`, each rail `rs(·,1)`;
  2. multiply positions `[3S/4, S)` by `-j` (exact);
  3. butterfly with span S/4, `rs(·,1)`;
  4. if `S > 4`, multiply position `q·S/4 + t` by `W_S^(t·e_q)` with
     `e = [0, 2, 1, 3]`.

  If `log2 K` is odd, a final span-1 butterfly (`rs(·,1)`) follows. The
  overall gain is `1/K`.
- **Inverse FFT (DIT radix-2², bit-reversed in, natural out).** This is the
  exact transpose of the forward FFT with `+j` and conjugated twiddles:
  - the lone span-1 butterfly first (odd `log2 K`);
  - then for `S = 4, 16, ..., K`:
    1. twiddle (if `S > 4`);
    2. span-S/4 butterfly;
    3. `+j` on positions `[3S/4, S)`;
    4. span-S/2 butterfly.

  Every butterfly rounds `rs(·,1)`, so the overall gain is `1/K`
  (normalized IDFT).
- **Data path:** input rails go in as `x << 9`.
  1. `X = FFT(w)`.
  2. `P = sat_27(rs(X·H, 17))`, with each rail from exact products.
  3. `v = IFFT(P)`, 27-bit rails.
- **Reference path (at LOAD_REF commit, and at `srst` with `ref = [0x7fff]`):**
  1. `F = FFT(c << 9)`.
  2. `e = 17 - bitlen(max |rail of F|)` (e = 0 if F = 0).
  3. `H = sat_18(rs(F, -e))`.
- **Scale:** `v ≈ y · 2^-g`, with `g = 2·log2(K) - 1 - e`.
  - Mode 0: `out = sat16(rs(v_rail, s - g))` per rail.
  - Mode 1: `out = satu32(rs(vI² + vQ², s - 2g))`.

  `s` is the header shift, 0..63. A negative total shift is a left shift
  and saturates.

## Framing

| Bits | Field |
|---|---|
| `31:16` | magic `0xFC0A` |
| `15:14` | mode (DATA only): 0 = complex, 1 = \|y\|²; 2 and 3 are a bad header |
| `13:8` | shift 0..63 (DATA only) |
| `7:4` | reserved, must be 0 |
| `3:0` | op: 1 = DATA, 2 = LOAD_REF, 3 = RESET |

- **DATA:** one output per sample, with the packet's mode and shift. A
  header-only packet is a no-op.
- **LOAD_REF:** 1..N tap words. They are staged, validated at `last`, then
  FFT'd into H. The data history is kept.
- **RESET:** clears the input history and keeps H.
- LOAD_REF and RESET take effect in stream order: `t_ready` stays low
  while earlier blocks drain and H is recomputed.
- Non-DATA headers must have mode = shift = 0.
- **Sticky errors** (each drains the packet to `last` with no output):
  - `err[0]` bad header;
  - `err[1]` LOAD_REF length 0 or greater than N (H is unchanged);
  - `err[2]` RESET with a payload (the reset is still applied).
- **Power-up:** `ref = [0x7fff]` (R = 1), so y = 32767·x (use shift 15 for
  unity gain).

## Micro-architecture

- An input ring buffer (BRAM, 2K samples) with a fill counter: slots older
  than RESET, or never written, read as 0.
- A block scheduler feeds the K-sample window into the DIF core at 1/clk.
  - Only one block may be pending at a time.
  - A block launches only when the output FIFO has room for its m results.
    After launch the pipeline never stalls.
- `X·H`: H is a K×2×27 BRAM (raw F plus exponent e), normalized on read,
  in bit-reversed order, the same as X.
- The DIT core outputs z in natural order. The first K-m samples are
  discarded. The last m go through the mode/shift stage into the output
  FIFO (depth ≥ 2B), tagged with `last` on the packet's final sample.
- A tap staging BRAM (N words) holds LOAD_REF taps. After a valid `last`
  and a full pipeline drain, the scheduler feeds `c` (reversed, conjugated,
  zero-padded) into the DIF core and captures F and e.
- Steady state is B new samples per K+overhead clocks, about 0.5
  sample/clk. A short packet costs one full block (about K clocks plus the
  pipeline depth).

## Verification and timing (phase 3)

1. `fft_corr_model.py` self-test:
   - the output against the exact integer correlation, with an asserted
     error bound;
   - peak position with front padding;
   - split packets (block rule);
   - all framing and error rules;
   - float cross-check of the FFT structure.
2. `fpgas/common/xilinx/sim/fft_corr` harness: about 20 random
   valid/ready/`last`/error seeds at N=256 plus N=16 and N=64. RTL must
   equal the model in Verilator and XSIM, and a mutation check is
   included.
3. Golay removed; `xcorr_driver`, `qs_gen.py`, test_qstream_1 and
   test_xcorr_fir_1 updated; seed sweep; XSIM on one seed each.
4. OOC timing at N=256 and N=1024, plus a full CS12 build.

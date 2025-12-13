# Q-engine FIR notes

## contract

- The contract was agreed by design interview and recorded in `PLAN.md`.
- Finding: production `dma_out` derives `i1_last` from `q_last_cnt`, which is
  cleared as soon as the request state machine returns to `WAIT`. With
  `slicer_busy=0` the request side finishes before the VMEM read latency has
  elapsed, so the final returned word can miss `last`, and a
  following schedule can inherit a stale count. DMA_1 hides this because the
  slicer holds `WAIT_FOR_SLICER`. The FIR feed therefore needs `last`
  tracked on the returned-data side, not in the request state machine. Production
  `dma_out` is left unchanged.

## Python model

- `libs/q-engine/hdl/fir/model/fir_model.py` is the bit-exact model: header
  parsing, shadow-bank coefficient commit, the delay line kept across packets, the
  error/drain rules, round-half-up and saturation. `python3 fir_model.py` runs a
  self-test. It recovers the impulse response, matches an independent floating-point
  complex convolution to within 1 LSB over 200 samples split across two
  packets, and checks each framing/error rule plus saturation and rounding.

## `fir_filter` RTL and module harness

- `libs/q-engine/hdl/fir/fir_filter.v` is Verilog-2005 with one parameter,
  `NTAPS`. It deviates slightly from the contract: `DW`/`CW` are localparams
  fixed at 16, because the 32-bit word packing and header layout define them.
- Pipeline, measured in enable cycles from the accepted sample: delay line, then
  M (4 x 16x16 products per tap), then complex combine, then a `log2(NTAPS)`-level
  heap adder tree, then round, then shift/saturate, then a 2-entry output FIFO.
  At NTAPS=16 the latency is 9 enable cycles. `t_ready = (fifo_count != 2)` is a function
  of registers only, so no combinational path runs from `i_ready` to `t_ready`.
  The shift value travels with each sample through the pipeline, and coefficient
  commits cannot overtake an in-flight sample. That holds because at least one
  enable cycle separates a sample's acceptance from any LOAD_COEFFS commit, and
  the products are captured on the first of those enable cycles.
- Verilator 4.016 refuses to unroll NBA loops over arrays of more than 64
  entries (`BLKLOOPINIT`). The adder tree is therefore a per-node generate heap,
  not a 2-D reset loop.
- `fpgas/common/xilinx/sim/fir_filter/`: 25 seeded runs (20 at NTAPS=16,
  plus NTAPS=1,2,5,8,13) pass under Verilator 4.016 and XSIM 2025.2, with
  byte-identical traces. Seed 0 proves 1 sample/clk. A mutation check
  confirmed the harness detects rounding, commit, reset, error, and backpressure
  faults.

## 6-port crossbar, DMA_3/DMA_4 and q_engine integration

- The Spinal arbiter `VmemDatArbOut1_1` now defaults to `DMA = 6` (3-bit
  tag), and `libs/spinal/hw/gen/VmemDatArbOut1_1.v` has been regenerated. With
  6 DMAs the unused tag values 6/7 fall into the fanout's `default` arm, which
  is harmless. `vmem_dat_arb_out_spinal_wrapper.v` and `vmem_dat_6_5_1_1.v`
  are parameterised by `D = 6` / `EAB = 3`, and every slice passes
  `EAB1(EAB)` to `memory_slice_1_1`. Two fallback branches were removed from
  `vmem_dat_6_5_1_1.v` because both were dead. The `VMEM_DAT_ARB_OUT_1_1`
  else-branch named `vmem_dat_arb_out_1_0`, which does not exist in the
  repository. The `MEMORY_SLICE_1_1` else-branch named the legacy untagged
  `memory_slice`, which cannot carry a DMA tag. Every Xilinx flow already
  defines both macros.
- `piston.v` is generated. Instead of regenerating the whole control network,
  ports `t_idma_4/5` and `i_odma_4/5` are added under `HIGGS_FPGA_XILINX` as
  one `eb15` register slice per direction, feeding bits [5:4] of the VMEM
  valid/ready vectors. Ports 0-3 are unchanged, and the non-Xilinx `piston`
  keeps exactly 4 ports. VMEM gives the lower DMA index priority, so the FIR
  ports 4/5 have the lowest priority.
- `libs/q-engine/hdl/dma/dma_out_last.v` (DMA_3) fixes the finding above. A tag
  FIFO entry is pushed per issued read with its `last` bit, and popped when
  the word leaves. Its occupancy is the read credit count, so the 32-deep data
  FIFO cannot overflow, and `last` is independent of VMEM latency. A schedule
  is popped as soon as its last read is issued, so header+payload chains stream
  with a single bubble at the schedule boundary. `status[0]` = busy
  (requests pending or words unconsumed), and `status[AW+1:1]` = the tag count.
  `dmaReset` aborts the schedule and forces `last` onto the newest issued
  word if it is still queued, so the FIR sees a terminated (truncated) packet.
  Limitation: if the abort lands on a schedule that has not issued a word yet
  (for example, the payload after a header-only schedule), the FIR stays
  mid-packet until the next `last`.
- `fpgas/common/xilinx/sim/dma_out_last/` uses one clocked SV testbench core
  for both simulators. It covers a StreamFifo-like config source, an in-order
  VMEM model with random latency and backpressure, random output stalls,
  zero-length, reverse, timer-gated and aborted schedules. 20 seeds pass under
  Verilator and XSIM, with byte-identical traces. Six injected mutations (abort
  termination, last placement, credit gating, FIFO sizing, reverse, timer) were
  all detected. Finding: Verilator 4.016 merges repeated side-effecting
  function calls and evaluates both `?:` arms, so the TB's RNG draws are
  tasks.
- `XbbRiscv.scala` adds `DmaCsrPlugin("3", 0xB48)` and `("4", 0xB58)` as
  `dma_3_*`/`dma_4_*` io, poll-only, so they are not in
  `io_externalInterrupt`. The regeneration flow is the `genriscv` Makefile
  recipe run in a scratch copy of the `VexRiscv` submodule with
  `sbt -java-home /usr/lib/jvm/java-8-openjdk-amd64` (sbt 0.13.16 / SpinalHDL
  1.1.5 need Java 8; `openjdk-8-jdk-headless` was installed). A baseline
  regeneration from the unmodified Scala matched the committed file in
  ports, module set, and register count. Only SpinalHDL 1.1.5's internal
  `_zz_` numbering differs between runs. With the plugins added, the port
  diff is exactly the new `dma_3_*`/`dma_4_*` signals. `XbbRiscvNoEBR.v` is
  re-derived with the recipe's `sed`. `d_engine.sv` ties the new inputs with
  the same convention it uses for DMA_1/2 (`status = 0`, `config_ready = 1`).
- `q_engine.v` instantiates `dma_out_last` (DMA_3), `fir_filter #(16)`, and
  `dma_in` (DMA_4) under `HIGGS_FPGA_XILINX` and `` `ifndef NO_FIR ``. DMA_3
  reads on piston port 4 (`{1'b0, addr, 32'b0}`, returns on `i_odma_4`), and
  DMA_4 writes on port 5 (`{1'b1, addr, data}`). DMA_4 uses `dma_in`
  unchanged; its `t0_ready = 0` in `WAIT` holds the FIR until DMA_4 is
  scheduled. Otherwise the CSRs are tied to `config_ready = 1` and
  `status = 0`. The FIR error bits stay module-level, as agreed.
- The new sources are in the CS12 Vivado overlay (`build.tcl`) and in the
  `q_engine` and `vex_machine_top` harness lists.
- Regression after the change: `vmem_dat_arb` was widened to drive all
  6 DMAs (512 transactions, trace parity). `vmem_dat_6_5` and `piston` were
  widened to 6 DMAs (768 ordered reads, and piston trace parity). `q_engine`
  and `vex_machine_top` run real firmware through the regenerated `XbbRiscv`
  with the FIR instantiated. All pass under Verilator 4.016 and XSIM 2025.2.

## C library

- `csr_control.h` adds `DMA_3_*` (0xB48) and `DMA_4_*` (0xB58), using the
  same register offsets as DMA_0-2. There are no `MCAUSE`/`ENABLE_BIT` defines
  because the new DMAs raise no interrupt. `SCHEDULE_DEPTH` is 16, which is
  the `DmaCsrPlugin` `StreamFifo` depth. A push to a full FIFO is silently
  dropped, so the driver always checks occupancy before pushing.
- `fir_driver.{h,c}` keeps three header words (DATA, RESET, LOAD_COEFFS) in
  caller-provided VMEM scratch. A packet is a header schedule with `last=0`
  chained to a payload schedule with `last=1` (or a header-only schedule for
  RESET). `LAST_RTL` is written before every push because the plugin clears it
  on push. If `fir_load_coeffs` is given a new shift, it waits for DMA_3 to be
  idle before it rewrites the LOAD_COEFFS header word, so a queued load never
  reads a changed header.
- `fir_busy()` reads DMA_3 occupancy before STATUS. `dma_out_last` pops a
  schedule on the same cycle its final read is issued (making `tag_count`
  non-zero), so this order cannot miss in-flight work. DMA_4 occupancy covers
  output that is still being written. `dma_out_last` drops zero-length
  schedules, and the driver rejects `n == 0`.
- Every firmware build compiles all of `c/inc/*.c`. With the repository's
  full warning set, `fir_driver.c` builds cleanly. Because of `-ffunction-sections`
  and `--gc-sections`, unused driver code costs nothing: the CS20 image stays at
  920 B imem.

## full-system test `sim/verilator/test_fir_1`

- The CS20 override firmware uses `fir_driver` to queue 16 operations back to
  back, then calls `fir_wait()` once and streams the result out through
  DMA_1. The operations are:
  - LOAD_COEFFS A/15;
  - DATA split 100/37/1;
  - LOAD_COEFFS B/17 (the history carries over, and some outputs saturate);
  - DATA;
  - RESET;
  - DATA;
  - the three dropped error packets (bad magic, short coefficients,
    reserved bits);
  - DATA;
  - RESET with a payload;
  - DATA;
  - LOAD_COEFFS A;
  - DATA.

  `gen_vectors.py` produces the firmware's input table and
  `expected.hex` (475 words) from `fir_model.py`. Both are regenerated before
  every firmware build. The input words live in imem `.rodata`, and the
  firmware copies them into VMEM because the Xilinx VMEM does not honour
  `LOAD_VMEM` preloading.
- The full-system build now has a Xilinx Q-engine. The test adds
  `HIGGS_FPGA_XILINX`/`MEMORY_SLICE_1_1`/`VMEM_DAT_ARB_OUT_1_1` and the Xilinx
  VMEM sources. It also adds the XPM Verilator model or, for XSIM, `-L xpm`
  through a new optional `XSIM_ELAB_FLAGS` in `xsim_common.mk`. Only four
  RTL files test `HIGGS_FPGA_XILINX`, and all of them already run under this
  define in the `q_engine` harness.
- Finding: without the Lattice `memory_slice` and its public `rtn_mem`
  function, Verilator `-O3` flattens `piston`, so `higgs_helper.hpp`'s
  `readVmem()` paths (`...->piston_inst->unode28`) no longer compile. A
  `HIGGS_TB_NO_VMEM_READ` guard compiles them out for this test only; other
  tests are unchanged.
- Result: `make xsim_compare` from a clean tree passes. Verilator and XSIM
  both match the model on all 475 words, and the two streams are identical
  (about 3 minutes end to end). As a mutation check, dropping the firmware's
  `fir_reset()` call makes the output diverge at word 288, the first sample
  after the RESET.
- Non-Xilinx regression: `sim/verilator/test_nco` `make xsim_compare` still
  passes (32768 samples, parity). This covers the regenerated `XbbRiscv`,
  the `d_engine` tie-offs, the `csr_control.h` additions, and the helper
  guard.

## timing on `xczu7ev-ffvc1156-2-e` (Vivado 2025.2, 125 MHz)

- Out-of-context `fir_filter` (NTAPS=16),
  `fpgas/common/xilinx/timing/fir_filter/fir_filter_ooc.tcl`: routed
  **WNS = +4.658 ns**, WHS = +0.043 ns, 0 unconstrained internal endpoints.
  Resources: 380 CLB LUTs, 672 registers, 18 CARRY8, 0 BRAM, **94 DSP48E2**.
  The worst path is the output-FIFO occupancy -> global enable fanout
  (`ob_cnt_reg` -> DSP `CEM`, 1 LUT level, 92% routing). The only
  methodology warnings are TIMING-18 (OOC ports have no I/O delay).
- Deviation from the PLAN estimate of 64 DSPs: Vivado also maps 30 of the
  wide leaf/tree adders into DSP48E2 ALUs (e.g. `nd[26].leaf.qi_reg`), so the
  count is 64 multipliers + 30 adders = 94. Timing has ample slack, so this
  was left as is.
- Full CS12 routed build (`fpgas/cs/cs12/build/vivado`, `build.tcl` +
  `implement.tcl`) with DMA_3, fir_filter, DMA_4 and the 6-port crossbar:
  **WNS = +2.320 ns**, TNS = 0, all user timing constraints met, 0
  unconstrained internal endpoints. Resources: 31,062 CLB LUTs, 32,544
  registers, 72 RAMB36, 132 DSP48E2. Compared with the pre-FIR baseline
  (WNS +2.186 ns, 28,061 LUTs, 38 DSPs), the DSP delta is exactly the FIR's
  94. The worst path is pre-existing (CPU timer CSR -> demapper multiplier),
  not in the FIR. The 37 input/37 output ports still lack board I/O delays,
  as before.


# Phase 2 notes (add stream router and Golay correlator)

## phase-2 contract

- The second design interview is recorded in PLAN.md ("Phase 2"). Firmware
  does not overlap FIR and correlator jobs; the module harnesses exercise
  overlap with random valid/ready.

## `stream_router`, `stream_merge`, `stream_stall`

- RTL is in `libs/q-engine/hdl/stream/`. All three files are lint-clean
  with `verilator -Wall`.
- `stream_stall` is a pure wire unless `QSTREAM_STALL_INJECT` is defined.
  When defined, it becomes a 2-entry AXI-compliant FIFO whose input and
  output are gated by xorshift. The seed comes from `+STALL_SEED` mixed
  with the `SALT` parameter.
- Harness: `fpgas/common/xilinx/sim/stream_router_merge`.
  - It has three modes: MODE 0 router alone, MODE 1 merge alone, MODE 2
    router -> two random echo arms -> merge.
  - Each mode runs 20 seeds with random gaps, backpressure, `last`, bad
    route words and route-only packets. Seed 0 is a full-rate check.
  - MODE 0/2 run two phases so that sticky `err` and `err_clear` can be
    checked.
  - `make compare`: **60/60 PASS** in Verilator and XSIM with identical
    traces.
- Harness bug fixed during bring-up: the phase-0 drain check compared
  against the final expected counts instead of the counts at the phase
  boundary. The full-rate check now measures phase 1 only.
- Mutation checks:
  - Dropping the route word's reserved-bit check fails MODE 0.
  - Replacing round-robin `rr <= cur + 1` with `rr <= cur` fails MODE 1
    with 202 errors.

## q_engine integration and `fir_driver` route/tag words

- `q_engine.v` (Xilinx, `!NO_FIR`) now wires:
  - `DMA_3 -> stall -> stream_router(N=2)`;
  - port 0: `stall -> fir_filter -> stall -> stream_merge`;
  - `stream_merge -> stall -> DMA_4`.

  Port 1 sinks its input and drives no output until `golay_corr` is added.
- New RTL files were added to the q_engine and vex_machine_top harnesses,
  `test_fir_1`, and CS12 `build.tcl`.
- `fir_driver`:
  - Its scratch area holds `[ROUTE0, hdr]` pairs, so route and header go
    out as one 2-word DMA_3 schedule. `FIR_SCRATCH_WORDS` is now 7.
  - Every output job schedules DMA_4 twice: 1 tag word into scratch, then
    the n samples.
  - `fir_last_tag()` returns the last captured tag.
  - `fir_send_raw()` prepends the route word.
- `test_fir_1`:
  - The firmware appends `fir_last_tag()` after the samples, and
    `gen_vectors.py` expects `0x5271<<16 | (n_data_pkts-1)<<4 | 0`.
  - The store must be `volatile`. Otherwise GCC removes it as a dead store,
    because only DMA_1 reads it before the final `while(1)`.
- `test_fir_1` now builds with `QSTREAM_STALL_INJECT`. The plusarg is set
  with `STALL_SEED` (default 1); `RUN_PLUSARGS` was added to `tb_common.mk`
  and `xsim_common.mk`, where it becomes `-testplusarg`.
- Results:
  - Verilator: 476/476 words match (475 samples + tag) for stall seeds
    1–5.
  - `make xsim_compare`: PASS, with Verilator and XSIM identical.

## phase-2 regressions (step 2)

- `make compare` passes for every Xilinx module harness: q_engine,
  vex_machine_top, fir_filter, dma_out_last, alu54b_wrapper, fwft_sc_fifo,
  generic_dpram, generic_fifo_sc_a, memory_slice, muladdsub, piston,
  scalar_memory and vmem_dat_arb.
- `make xsim` passes for memory_slice_1_1 and vmem_dat_6_5.
- `sim/verilator/test_nco` `make xsim_compare`: PASS (32768 samples, parity).

## Golay model, `golay_corr` RTL and harness (steps 3-4)

- Model: `libs/q-engine/hdl/xcorr/model/golay_model.py`. Its self-test
  covers:
  - for M in {1,2,3,5,7}, random permutation and non-permutation configs;
  - complementarity of the pairs (for permutations);
  - bit-exactness of the structural EGC against a brute-force matched
    filter on full-scale random input;
  - the mode-0 peak `2L·amp` at the last sample of b;
  - history persisting across split packets and config loads, and being
    cleared by RESET;
  - every framing and error rule.
- A width finding from RTL bring-up corrected the PLAN's "1 bit per stage".
  `-(-32768)` makes `+2^(15+k)` reachable (for example, M=1, w=-1:
  b = [-1,-1], and x = -32768 gives Rb = +65536). Stage k now outputs 17+k
  bits, and the model self-test asserts this case.
- A second bring-up bug: the rounding constant `1<<30` for shift 31
  overflowed the 25-bit rounding register. `RW` is now at least 33 bits.
- RTL: `libs/q-engine/hdl/xcorr/golay_corr.v`. It has no multipliers.
  - Per-stage 64-deep addressable SRL delay lines shift only on valid
    samples. Fill counters zero the tap after RESET, because SRLs have no
    reset.
  - A 128-deep Ra history (a flat shift vector) feeds mode 0.
  - Config commits and RESET wait in `S_WAIT` (registered `t_ready` = 0)
    until the pipeline is empty, so they take effect in stream order.
- Harness: `fpgas/common/xilinx/sim/golay_corr`, with 20 seeds at M=7 plus
  M=1..5.
  - `make compare`: **25/25 PASS**, with Verilator and XSIM traces
    identical.
  - Seed 0 is full rate except for 4 bounded config/reset drains.
- Mutation check: committing without waiting for the pipeline to drain
  (`apply = state == S_WAIT`) fails 20 runs.

## correlator on port 1 (step 5)

- `q_engine.v`: port 1 is `stall_xcin` (SALT 4) -> `golay_corr #(.M(7))` ->
  `stall_xcout` (SALT 5) -> merge port 1. The sink tie-off is gone.
  `golay_corr.v` was added to the q_engine and vex_machine_top harnesses,
  `test_fir_1` and the CS12 `build.tcl`.
- `test_fir_1` (Verilator + XSIM compare, 476 words) and the q_engine and
  vex_machine_top trace compares pass.

## `qstream` library, drivers, `test_qstream_1` (step 6)

- `libs/riscv-baseband/c/inc/qstream.{h,c}` implements the design in
  PLAN.md "Firmware (as built)".
  - The receive path deviates from the PLAN text: DMA_4 lands each payload
    directly in the caller's buffer. There is no receive ring or copy.
  - FIR and correlator jobs may overlap. The earlier "firmware does not
    overlap" note is superseded, because step 7 muxes them.
  - Completion uses `completed = pushed - occupancy` on both DMAs. This is
    exact, because both pop a schedule only when its last access issues.
  - Tag slots are zeroed after use and spun on until non-zero, which covers
    write latency.
- `fir_driver` is rebuilt on qstream. `fir_init()` takes no scratch now;
  the `QSTREAM_*` macros moved to `qstream.h`. New: `fir_filter_cb`.
- New `xcorr_driver.{h,c}` (port 1) provides:
  - header, mode, seed and config-word macros;
  - `xcorr_load_cfg`, `xcorr_reset`, `xcorr_correlate[_cb]`, `xcorr_send_raw`;
  - `xcorr_golay_pair_words()`, an in-place pair generator. It matched
    `golay_model.golay_pair` for 50 random configs on the host and
    rejects non-permutations.
- The firmware build compiles every `inc/*.c`. `--gc-sections` keeps
  unused qstream/xcorr code out of other images.
- `sim/verilator/test_qstream_1` (directed):
  - an op-interpreter firmware plus `qs_gen.py`, which mirrors router,
    FIR, Golay and tags;
  - the tb stops when the expected word count arrives;
  - coverage is listed in its README.
  - Result: 711 words bit-exact in Verilator (STALL_SEED 1–7) and in XSIM
    (`make xsim_compare` PASS).
- Findings:
  - `ld_standard` puts `.sbss` in `.var_space`, outside the range crt
    zeroes. Small statics therefore start at 0 in Verilator but X in XSIM,
    which first showed up as an XSIM-only trailer mismatch. The test
    firmware now initializes them explicitly; qstream already did. The
    linker script is unchanged, since that is out of scope.
  - `$display("%m")` in `stream_stall`'s initial block segfaulted Verilator
    4.016: scope registration runs during the tb's static construction.
    The new `+STALL_VERBOSE` print omits `%m`. It confirmed that all 12
    shims (CS12 and CS20) read `+STALL_SEED`.
  - In this directed test the end cycle is identical across stall seeds.
    The CPU is the bottleneck, and each `qstream_wait` poll iteration
    (~100 cycles) absorbs the few cycles of stall latency on small packets.
- Review fix (after the first passing runs): payload visibility.
  - The VMEM input arbiter (`vmem_dat_6_5_1_1`) is fixed-priority, and
    DMA_4 (`t_idma_5`, behind an `eb15`) is its lowest-priority writer.
    dma_in retires a schedule when the last write is *accepted*, so up to a
    few final words can land after the CPU sees completion. A CPU load of
    the same bank (`t_idma_2`) would win arbitration and read stale data.
  - qstream now stores a sentinel in `dst[n-1]` before scheduling each
    payload. A job retires only once that word has changed; DMA_4 writes
    land in order, so every earlier word is then visible too. Data that
    equals the sentinel retires after 8 extra polls.
  - `fir_wait()` now returns `qstream_wait()`'s status instead of dropping
    `QSTREAM_EPROTO`.
  - After the fix, test_qstream_1 (711 words) and test_fir_1 (476 words)
    pass again in Verilator.

## `test_xcorr_fir_1`, randomized FIR + correlator muxing (step 7)

- `sim/verilator/test_xcorr_fir_1` reuses the test_qstream_1 firmware,
  tb and compare scripts. `gen_vectors.py` draws a random program from
  `TEST_SEED`:
  - FIR and correlator packets interleave back and forth (`BURST` ops),
    and both ports have jobs in flight at once;
  - coefficient and config reloads and resets are mid-stream;
  - raw error packets and bad route words are included;
  - random packet lengths reach FIR packets over 256 so tag seq wraps.
- The stream_stall shims inject random valid/ready gaps from `STALL_SEED`.
  `make seeds SEEDS="t:s ..."` rebuilds only vectors and firmware, then
  reruns the same Verilator model.
- Results (Verilator; all bit-exact against the Python models):

  | TEST_SEED:STALL_SEED | words | cycles |
  |---|---|---|
  | 1:1 | 3796 | 1,177,353 |
  | 1:9 | 3796 | 1,177,369 |
  | 2:7 | 3613 | 1,338,979 |
  | 3:3 | 5255 | 1,715,403 |
  | 4:11 | 3454 | 1,182,787 |
  | 5:5 | 4542 | 1,325,802 |
  | 6:13 | 3361 | 1,100,001 |
  | 7:2 | 2017 | 838,046 |
  | 8:17 | 4655 | 1,402,267 |

  `make xsim_compare TEST_SEED=1 STALL_SEED=1`: PASS. The same 3796 words
  are bit-exact in Verilator and XSIM (elaboration ~30 min, run ~4 min).
  Seeds 2 and 3 ran before the sentinel fix. Seed 1 took 1,160,000
  cycles before the fix, so the sentinel check costs about 1.5%. Stall
  seeds change the end cycle only slightly, since the CPU
  (`qstream_poll` loop) is the throughput bottleneck.

## timing, phase 2 (step 7 of the original list)

Part xczu7ev-ffvc1156-2-e, 125 MHz, Vivado 2025.2.

- OOC harness: `fpgas/common/xilinx/timing/qstream/qstream_ooc.tcl`

  | module | WNS | WHS | LUT | FF | DSP | BRAM |
  |---|---|---|---|---|---|---|
  | golay_corr M=7 | +4.128 | +0.019 | 2603 (748 SRL) | 1077 | 0 | 0 |
  | stream_router | +6.417 | met | 41 | 77 | 0 | 0 |
  | stream_merge | +6.416 | met | 83 | 89 | 0 | 0 |

  golay_corr's worst path is `cp_reg` -> `stg[4].rb_i_reg` (10 levels,
  4 CARRY8). The only methodology warnings are TIMING-18 (OOC I/O).
- CS12 full implementation: all constraints met, with no failing
  endpoints for setup or hold.
  - Setup WNS +3.167 ns (worst path inside VexRiscv); hold WHS +0.010 ns.
  - Utilization: 33,843 LUTs (3,060 as memory), 33,780 FFs, 132 DSPs,
    72 RAMB36.
  - Against phase 1 (WNS +2.320, 31,062 LUTs, 132 DSPs): +2.8k LUTs and
    no new DSPs. The correlator is multiplier-free.

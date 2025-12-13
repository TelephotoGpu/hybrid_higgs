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


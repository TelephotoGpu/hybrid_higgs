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

- `fir_init(uint32_t *scratch_vmem)` (`FIR_SCRATCH_WORDS` VMEM words that
  hold the header words)
- `fir_load_coeffs(const uint32_t *coeffs_vmem, unsigned shift)`
- `fir_reset()`
- `fir_filter(const uint32_t *in_vmem, uint32_t *out_vmem, unsigned n)`
  (non-blocking; schedules DMA_4 before DMA_3)
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

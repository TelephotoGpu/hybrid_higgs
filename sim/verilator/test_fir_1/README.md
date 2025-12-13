# FIR platform regression

This test runs the Q-engine complex FIR through the full platform, under the
control of the CS20 firmware and the `fir_driver` C library (built on the
`qstream` transport):

```text
VMEM -> DMA_3 -> stream_router -> fir_filter (port 0) -> stream_merge -> DMA_4 -> VMEM -> DMA_1 -> CS20 stream
```

`gen_vectors.py` uses the bit-exact model in
`libs/q-engine/hdl/fir/model/fir_model.py` to generate two files:

- `override/fpgas/cs/cs20/c/src/fir_vectors.h`, which holds the firmware's
  input words and packet table;
- `expected.hex`, which holds the expected CS20 output.

Both are regenerated before every firmware build (`compilehex` depends on
`vectors`). The firmware queues the whole sequence back to back and then
calls `fir_wait()` once. The driver blocks only when a DMA schedule FIFO is
full.

1. LOAD_COEFFS A (shift 15).
2. DATA over three DMAs of 100, 37 and 1 samples; history carries across them.
3. LOAD_COEFFS B (shift 17, full-scale taps, some saturation), with history kept.
4. DATA 150.
5. RESET, then DATA 50.
6. A bad magic packet, a short LOAD_COEFFS (5 taps), and a DATA header
   with reserved bits set. All of these are dropped, and coefficients and
   history are unchanged.
7. DATA 64.
8. RESET with a 2-word payload (`ERR_RST_LEN`; the reset is still applied),
   then DATA 33.
9. LOAD_COEFFS A again, then DATA 40.

Every DMA_3 packet starts with a route word (port 0), and every output
packet is preceded by a merge tag word, which qstream consumes and checks.
After `fir_wait()`, the firmware appends `fir_last_tag()`. Its expected
value is `0x5271<<16 | (n_data_packets-1)<<4 | 0`; any qstream receive
error replaces it with `0xdead0000 | errors`. fft_corr sits idle on
router port 1 (see `test_qstream_1` and `test_xcorr_fir_1`).

The build defines `QSTREAM_STALL_INJECT`, so the `stream_stall` shims
around the router and merge insert random valid/ready gaps. Pick the stall
pattern with `make ... STALL_SEED=<n>` (default 1).

Both simulators compare all 476 output words (475 samples plus the tag)
bit-exactly against `expected.hex`. `compare_fir.py` then checks both captured streams against
the model again.

The FIR exists only in the Xilinx Q-engine, which has the 6-port VMEM
crossbar. The Makefile therefore defines `HIGGS_FPGA_XILINX`,
`MEMORY_SLICE_1_1` and `VMEM_DAT_ARB_OUT_1_1`, and adds the Xilinx VMEM
sources. Verilator uses the behavioural XPM model, and XSIM links the vendor
`xpm` library (`XSIM_ELAB_FLAGS=-L xpm`). There is no Lattice `memory_slice`
with a public accessor to hold the hierarchy, so Verilator flattens `piston`.
`HIGGS_TB_NO_VMEM_READ` compiles out the helper's VMEM peek, which is unused
here.

Run:

```sh
PATH=/opt/amd/2025.2/Vivado/bin:$PATH make xsim_compare
```

Successful output ends with:

```text
PASS: 475 FIR samples match the Python model exactly in Verilator and XSIM
```

To run Verilator alone, use `make verilator_run_log`. `make fir_clean`
removes all build products and generated vectors.

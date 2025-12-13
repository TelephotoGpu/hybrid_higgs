# Randomized FIR + correlator muxing test

Muxes FIR (port 0) and Golay correlator (port 1) packets back and forth
through one DMA_3 -> `stream_router` -> modules -> `stream_merge` -> DMA_4
path. It uses `fir_driver` and `xcorr_driver` on `qstream`. The firmware
(the op interpreter), `tb.cpp` and the XSIM testbench are shared with
`test_qstream_1` through symlinks; see that README for the output format.

## Randomization

`gen_vectors.py <TEST_SEED>` draws 70–110 jobs, weighted:

- FIR and correlator data of random length;
- Golay pairs for the loaded config. Some are split over two packets; a
  mode-0/shift-M peak is asserted in the generator;
- FIR coefficient reloads with a random shift;
- correlator config reloads: random, sometimes non-permutation, with
  random shift and mode;
- resets on either port;
- route-only packets and bad routes;
- header-only packets;
- module error packets of 6 kinds;
- caller-built packets and `WAIT` sync points.

At a random point it also adds a burst of 260–300 single-sample FIR packets
with interleaved correlator packets. This wraps the 8-bit merge tag
sequence and keeps the expect queues full. Sample amplitudes vary from
full scale, which saturates, down to 0x40.

`STALL_SEED` separately randomizes valid/ready at every stream boundary.

## Run

```sh
make verilator_run_log TEST_SEED=1 STALL_SEED=1   # full build + run
make seeds [SEEDS="t:s t:s ..."]                  # rerun per seed pair (firmware-only rebuild)
PATH=/opt/amd/2025.2/Vivado/bin:$PATH make xsim_compare TEST_SEED=n STALL_SEED=m
```

`make seeds` prints one PASS/FAIL line per pair, and keeps each log as
`seed_<t>_<s>.log`.

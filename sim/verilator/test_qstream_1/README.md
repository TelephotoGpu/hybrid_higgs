# qstream platform test (directed)

Drives both stream modules through the full platform with the `qstream`,
`fir_driver` and `xcorr_driver` C libraries on CS20:

```text
VMEM -> DMA_3 -> stream_router -> port 0 fir_filter  -> stream_merge -> DMA_4 -> VMEM -> DMA_1 -> CS20 stream
                               -> port 1 golay_corr  ->
```

## How it works

- **Firmware** (`override/fpgas/cs/cs20/c/src/main.c`, shared with
  `test_xcorr_fir_1`) interprets an op table:
  - builds its input in VMEM: xorshift32 noise, literal words, correlator
    config words, and Golay pairs from `xcorr_golay_pair_words()`;
  - sends packets on both ports back to back;
  - waits once at the end (plus explicit `WAIT` ops).

  qstream reads each merge tag and DMAs the payload straight into the
  `out_v` slot of the packet it belongs to. A callback checks every
  arrival: right port, right destination and length, per-port issue order.
- **Generator.** `gen_vectors.py` (on `qs_gen.py`) mirrors all of this:
  - the firmware's memory image;
  - `stream_router` routing and drops;
  - the bit-exact FIR and Golay Python models;
  - the merge tags.

  It writes `qs_vectors.h` and `expected.hex`.
- **Output** is `out_v` plus a 6-word trailer:
  1. FIR packet count;
  2. correlator packet count;
  3. last FIR tag;
  4. last correlator tag;
  5. error word (qstream errors | callback errors << 16 | driver failures), expected 0;
  6. `0x600d0000 | (port switches seen ? 0x100 : 0) | (arrivals & 0xff)`.

## Directed coverage

- route-only packets on both ports;
- bad routes: port 2, port 15, bad magic, reserved bits, and a lone route word;
- interleaved data on both ports, including 1-sample packets;
- a Golay pair `[a, b]` whose mode-0 peak is checked in the generator;
- header-only DATA packets, which produce no output and no tag;
- module error packets on both modules. They produce no output, and state
  is kept, or RESET is applied;
- a caller-built packet via `qstream_send_words` + `qstream_expect`;
- resets, a non-permutation correlator config, and modes 1 and 2 with
  shifts 3 and 12;
- 48 alternating back-to-back small packets plus a 20-packet single-port
  burst. Both overflow the 16-deep per-port expect queue.

## Timing and seeds

The testbench runs until the expected word count has arrived, plus 5000
cycles, bounded by `+MAX_CYCLES` (default 3M). The build defines
`QSTREAM_STALL_INJECT`: `stream_stall` shims around the router, merge and
both modules insert seeded random valid/ready gaps. Select the pattern with
`STALL_SEED=<n>`, and add `+STALL_VERBOSE` to `RUN_PLUSARGS` to print each
shim's seed.

## Run

```sh
make verilator_run_log [STALL_SEED=n]
PATH=/opt/amd/2025.2/Vivado/bin:$PATH make xsim_compare
```

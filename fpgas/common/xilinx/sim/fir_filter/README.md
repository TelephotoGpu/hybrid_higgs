# `fir_filter` module harness

Verifies `libs/q-engine/hdl/fir/fir_filter.v` against the bit-exact model
`libs/q-engine/hdl/fir/model/fir_model.py` (contract: `doc/add-fir/PLAN.md`).

`gen_vectors.py <dir> <seed> <ntaps>` uses the model to build a randomized
packet stream per seed, together with the expected output and valid/ready
patterns. The packet mix includes:

- DATA packets of 1..4*NTAPS+8 samples, including single-sample and zero-length
  (header-only) packets
- LOAD_COEFFS with random, full-scale saturating, impulse, and real-only taps,
  and random shifts from 0 to 31
- RESET
- every error case: bad magic (single-bit flips), bad opcodes, each
  reserved-bit field, a lone garbage word, short/long/header-only coefficient
  packets, and RESET with payload
- `err_clear` pulses between packets

The input side offers beats with full, probabilistic, or bursty patterns, and holds
each beat until it is accepted. The output side applies full, probabilistic, or bursty
`ready`, including stalls of up to 150 cycles. Seed 0 is fully open in both
directions and additionally proves one accepted beat per cycle
(`check_throughput.py`).

Both `tb_fir_filter.sv` (XSIM) and `verilator_fir_filter.cpp` (Verilator
4.016) replay the same files cycle for cycle. On every cycle they check:

- exact output data and `last` order, and no extra outputs
- output held stable while `i_valid && !i_ready`
- no X on the handshakes (XSIM)
- the sticky `err` value after every accepted input beat
- that `err_clear` clears the error bits
- completion without a timeout

Each simulator writes a CSV trace of every handshake. `make compare`
requires the traces to be byte-identical.

Default runs: 20 seeds at `NTAPS=16`, plus `NTAPS` = 1, 2, 5, 8, 13, which
cover the degenerate tree, non-power-of-two padding, and the coefficient counter
width.

```sh
PATH=/opt/amd/2025.2/Vivado/bin:$PATH make clean compare
```

Expected tail:

```text
PASS: 546 input beats accepted back-to-back (1 err_clear cycles)
PASS: all 25 Verilator/XSIM traces identical
```

A quick mutation check showed the harness failing on all of these injected
faults: dropped rounding constant, an off-by-one in the coefficient commit,
RESET not clearing the delay line, a missing `ERR_RST_LEN`, and ignored
output-FIFO backpressure.

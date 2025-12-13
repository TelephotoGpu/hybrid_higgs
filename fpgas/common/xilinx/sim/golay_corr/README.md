# golay_corr module harness

`gen_vectors.py` drives the bit-exact model
`libs/q-engine/hdl/xcorr/model/golay_model.py` to produce stimulus, the
expected outputs, the sticky `err` value after every input beat, and
per-cycle valid/ready patterns. The patterns are full rate for seed 0;
otherwise each seed uses random probability or bursty patterns.

Packet mix:
- DATA of 0, 1 or up to 3L+10 samples. The data can be random, full-scale,
  sparse, or the configured Golay pair plus noise.
- LOAD_CFG with random permutation and non-permutation delays, modes 0–2,
  and shifts 0–31.
- RESET, with and without a payload.
- Error packets: bad magic, bad op, reserved bits, non-zero mode on DATA
  or RESET, short/long/header-only LOAD_CFG, LOAD_CFG mode 3, config words
  with reserved bits or `P >= M`, and err_clear.

The Verilator (`verilator_golay_corr.cpp`) and XSIM (`tb_golay_corr.sv`)
drivers are cycle-for-cycle mirrors. They check:
- the exact output data and `last` order;
- output stability while stalled;
- `err` after every accepted beat;
- that `err_clear` clears `err`;
- that there are no extra outputs and the run finishes.

`check_throughput.py` requires one input beat per cycle at seed 0. The only
exceptions are the bounded (at most M+6 cycles) pipeline drain after a
config commit or a RESET, which `in.txt` flags in column 5.

```sh
make verilator          # 20 seeds at M=7 plus M=1..5
PATH=/opt/amd/2025.2/Vivado/bin:$PATH make compare   # + XSIM, traces must be identical
```

# test_recip_1 — FFT datapath reciprocal

Platform test of the per-cmul 1/c unit in the FFT datapath
(`doc/kernel/NOTES.md` §12) through the C library.

## What it does
* Default (FFT) datapath, cs20 only (`OVERRIDE_CS20_C`, `TB_USE_CS20`).
* `make vectors` (a prerequisite of `compilehex`) runs
  `libs/datapath/recip/recip_model.py gen-header` and writes
  `override/fpgas/cs/cs20/c/src/recip_vectors.h` (generated, gitignored):
  1024 x, y and expected words as `VMEM_SECTION` rows.
  * y = c + jd: special divisors first (0, ±1, ±31, ±32, 33, 64, 32767,
    −32768, …), then random c of every magnitude; d = 0 except the last
    quarter, which checks x · (1/c + jd).
  * Expected = the bit-exact lane model (m2c, muladdsub, bs = 5,
    round_sat) with `config_word_cdiv_eq_05`.
* Firmware (`override/fpgas/cs/cs20/c/src/main.c`): `vector_divide_1024()`
  twice into fresh vmalloc rows, an LK13/SK13 fence, then a word-by-word
  compare. It also times the divide and a plain cmul with the same
  schedule.
* Ringbus: `0xdeadbeef`, per run the mismatch count (plus index, got,
  expected of the first mismatch), divide ticks, cmul ticks, pass mask
  `0x3`. `tb.cpp` asserts zero mismatches.

## Running
```
make test      # ~1 min
```
Result: 0 mismatches in both runs; divide 593 ticks, cmul 533 ticks.
Replacing the expected values with an exact `round(2^20/c)` reciprocal
makes 89 words differ, so the compare is sensitive to the LSB.

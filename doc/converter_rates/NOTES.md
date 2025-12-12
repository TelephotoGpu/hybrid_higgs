# Converter ratio expansion notes

## Key design decisions

- Reuse the existing halfband stages as a prefix of every higher-ratio
  cascade instead of redesigning the entire converter chain from scratch.
  That preserved the known-good default behaviour and limited new work to
  the genuinely missing later stages.
- Use one parameterized, generate-based cascade per converter instead of
  cloning separate top-level modules for each supported ratio.
- Keep the DAC and ADC sample rates fixed. `RATIO` changes the baseband
  rate seen at the converter interface: baseband rate = converter sample
  rate / `RATIO`.
- Treat verification as complete only when the golden model and RTL are
  bit-exact with an explained alignment result. The accepted bar is
  `0 LSB` mismatch and `lag=0`.

## Verification cautionary note

An early compare flow appeared to "pass" only with a loose `±512 LSB`
window. That was a false start, not an acceptable final criterion.

The real issues were:
- the Python model originally omitted the DDS `reg2` pipeline stage in both
  `fixed_ddsx2` and `duc_fixed_dds`, which made the mixer coefficients one
  cycle early; and
- the downconverter model initially used the wrong mixer-to-cascade I/Q
  sign mapping, then was corrected to the RTL's actual `(I, -Q)` path.

Once those were fixed, cross-correlation settled at `lag=0` and the
comparison tightened to exact sample-for-sample equality.

## New halfband stages added

The new stages were generated with the same `remez`/Q1.17 workflow used in
`doc/converter_rates/scripts/halfband_design.py`, continuing the pattern of
sharper later stages where the final Nyquist zone is tighter.

- `duc_hb_interp_fir_h1.sv`
  - 127 taps
  - design sweep selected `trans_frac=0.0195`
  - candidate quantized design point from the implementation sweep:
    about `-80.53 dB` worst stopband rejection
- `duc_hb_interp_fir_h2.sv`
  - 255 taps
  - design sweep selected `trans_frac=0.0165`
  - candidate quantized design point from the implementation sweep:
    about `-84.43 dB` worst stopband rejection
- `ddc_hb_decim_fir_h3.sv`
  - 127 taps
  - design sweep selected `trans_frac=0.0255`
  - candidate quantized design point from the implementation sweep:
    about `-88.05 dB` worst stopband rejection

These choices follow the established strategy from the existing cascades:
use looser early stages where spectrum is still far from alias boundaries,
and tighter later stages where the output band sits closer to Nyquist.

## Stage maps by ratio

Upconverter:
- `RATIO=2`: `h0`
- `RATIO=4`: `h0, h0`
- `RATIO=8`: `h0, h0, h1`
- `RATIO=16`: `h0, h0, h1, h2`

Downconverter:
- `RATIO=2`: `h0`
- `RATIO=4`: `h0, h1`
- `RATIO=8`: `h0, h1, h2`
- `RATIO=16`: `h0, h1, h2, h3`

## Re-running verification

From the repository root, run:

```sh
python3 doc/converter_rates/scripts/compare_upconverter.py --ratio 2
python3 doc/converter_rates/scripts/compare_upconverter.py --ratio 4
python3 doc/converter_rates/scripts/compare_upconverter.py --ratio 8
python3 doc/converter_rates/scripts/compare_upconverter.py --ratio 16
python3 doc/converter_rates/scripts/compare_downconverter.py --ratio 2
python3 doc/converter_rates/scripts/compare_downconverter.py --ratio 4
python3 doc/converter_rates/scripts/compare_downconverter.py --ratio 8
python3 doc/converter_rates/scripts/compare_downconverter.py --ratio 16
```

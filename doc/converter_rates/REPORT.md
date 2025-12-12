# Up/down converter architecture and rate/coefficient recalculation

This directory documents research into `libs/ip-library/upconverter` and
`libs/ip-library/downconverter`: how they work, what it takes to
recalculate their filter/NCO coefficients, and whether different sample
rates/IFs are feasible. It includes runnable scripts (`scripts/`) that
decode the existing coefficients, validate a redesign methodology against
them, and generate a few example alternate-rate configurations
(`examples/`).

Update: the later RTL work described in this directory has now been
implemented and verified. Today that means:
- upconverter `RATIO=2`, `4`, `8`, and `16` are implemented; `RATIO=4`
  remains the default/current mode.
- downconverter `RATIO=2`, `4`, `8`, and `16` are implemented;
  `RATIO=8` remains the default/current mode.
- new halfband stages were added for the previously-missing higher-ratio
  cases, and the Python/Verilator compare flows are bit-exact for all
  eight supported converter/ratio combinations.

## 1. How the upconverter works

`libs/ip-library/upconverter/hdl/upconverter.sv` takes a baseband I/Q
stream and produces a single real-valued IF-modulated output. The
illustration below is the default ``RATIO=4`` path:

```
baseband I/Q  -->  duc_hb_cascade  -->  complex mixer (duc_fixed_dds)  -->  take real part  -->  IF output
   (rate Fs)     (2 halfband interp        (fixed -39 MHz*                    o_inph_data
                  stages, x2 each,           NCO, ROM-based)
                  total x4, rate 4*Fs)
```

- `duc_hb_cascade.sv` instantiates **the same filter module twice**
  (`duc_hb_interp_fir_h0`, a 63-tap halfband interpolator) with a `duc_skid`
  elastic buffer between the two stages to adapt the 2x rate change each
  stage introduces. Both stages use identical coefficients — this is a
  real asymmetry vs. the downconverter (see below), presumably acceptable
  because only ×4 total interpolation is needed and halfband filters are
  self-dual (same filter works as the 2nd and 3rd Nyquist-zone rejector at
  both oversampling ratios here).
- `duc_fixed_dds.sv` is a ROM-based, **non-programmable** NCO: a 9-bit
  phase counter indexes a 512-entry (`duc_sincos.mif`) complex
  sine/cosine ROM. Only **125** of those 512 entries are unique
  (`LUT_PERIOD=500 = 4*125`; the fourth copy is redundant) — the IF
  frequency is permanently baked into this ROM's *content*, not derived
  from a runtime-settable phase-increment register as in a classic DDS.
  `test_coeffs.py`-style analysis of the ROM content confirms the ratio
  is exactly `39/125` (IF = 39 MHz at a final output rate of 125 MS/s, per
  `doc/upconverter.rst`; earlier doc revisions referred to 35 MHz, which
  was a stale historical note rather than the current shipped setting).
- After mixing, a ×2 gain and saturation/rounding stage converts the
  complex product to the real-valued IF output. `upconverter.sv` still
  computes and outputs both `o_inph_data` (real) and `o_quad_data`
  (imaginary) of the mixer product — only the real part is the actual IF
  signal a single DAC would use, per the module's own doc comment
  ("outputs the real part... resulting in a real signal"). Note
  `upconverter/README`'s port table literally says *"This is the real
  part of the **downconverted/decimated** output signal"* for both ports —
  that phrase is a leftover copy-paste from `downconverter/README`
  (an upconverter doesn't downconvert or decimate); a pre-existing
  documentation bug, now corrected in the README.

## 2. How the downconverter works

`libs/ip-library/downconverter/hdl/downconverter.sv` is the mirror image.
The illustration below is the default ``RATIO=8`` path:

```
real IF input (2 samples/clock, rate Fs_adc)
   --> complex demodulate (fixed_ddsx2, conjugate -39 MHz* NCO)
   --> ddc_hb_decim_firx2_h0 (/2, 15 taps, loosest)
   --> ddc_hb_decim_fir_h1   (/2, 31 taps, medium)
   --> ddc_hb_decim_fir_h2   (/2, 63 taps, tightest)
   --> baseband I/Q (rate Fs_adc/8)
```

- Three **different** halfband filters are cascaded (unlike the
  upconverter's "same filter twice"), with **increasing** tap count /
  selectivity at each stage: 15 → 31 → 63 taps. This is the standard
  multirate decimation-cascade design pattern (Lyons/Harris-style):
  aliasing margin is large right after the mixer (plenty of empty
  spectrum before the first alias), so the first stage can be a cheap,
  lossy filter; by the last stage the output band of interest is close to
  the new (lower) Nyquist edge, so the final filter must be much sharper.
  Verified numerically (see `scripts/halfband_design.py`, Step 1):
  worst-case stopband rejection is -8.98 dB, -17.58 dB, and -91.05 dB for
  the three stages respectively — a clear, deliberate progression.
- `fixed_ddsx2.sv` is the same idea as `duc_fixed_dds.sv` but handles two
  real input samples (`i_inph_data`, `i_inph_delay_data`, one clock apart)
  per clock, using **two** interleaved phase accumulators/ROM reads per
  clock (`LUT_PERIOD=100`). Verified ratio: exactly `39/100` (IF=39 MHz at
  an **ADC rate of 100 MS/s** — different from the upconverter's 125 MS/s
  DAC rate, which is a normal thing for an SDR with separate ADC/DAC
  parts, not a bug).
- **Found but out of scope to fix**: `downconverter/sim/ddc_sincos.mif`
  (513 lines) is a stale leftover — it is byte-identical to
  `upconverter/hdl/duc_sincos.mif`, not a valid copy of the real
  100-entry `downconverter/hdl/ddc_sincos.mif` ROM. The actual HDL
  simulation (`downconverter/hdl/Makefile`) runs from the `hdl/`
  directory and correctly reads the 100-entry file sitting next to it;
  the `sim/` copy only matters if someone runs a simulator from that
  directory instead, and would silently desensitize/mis-tune the NCO if
  so. Not changed here (unrelated pre-existing issue), but worth a
  follow-up cleanup.

*Both* `-39 MHz` figures above are the frequency **magnitude**; the
upconverter's DDS explicitly negates the sine term
(`sine_reg1 <= -sine_reg0` in `duc_fixed_dds.sv`) to put the image on the
correct (negative) side for its single-sideband-style real mixer, and the
downconverter's conjugate-sense demodulation undoes that.

## 3. What it takes to recalculate the coefficients

Two independent things are "the coefficients" here, and they decouple
cleanly — this is good news for feasibility:

### 3a. Halfband FIR taps (filter shape — depends on decimation/interpolation ratio and desired selectivity, NOT on the absolute sample rate or IF)

The HDL for every halfband stage is **generated code**: tap values are
baked in as literal two's-complement Verilog constants (e.g.
`18'sb111111111110000110`) directly inside multiply expressions, one pair
of `always_ff` lines per nonzero tap-pair (`scripts/decode.py` extracts
these programmatically and was cross-checked byte-for-byte against
`upconverter/hdl/test_coeffs.py`'s own hand-rolled bit-decoder — both
agree exactly, e.g. tap 0 of `duc_h0` is `-122` in both).

The structure (confirmed from the HDL + `test_coeffs.py`) is a standard
linear-phase halfband FIR of length `4*n_pairs - 1`:
- the center tap = `2^17` (i.e. `0.5` in the filter's `Q1.17` fixed-point
  coefficient format, giving overall DC gain of `1.0` before the
  explicit `x2` interpolation-gain compensation seen in `upconverter.sv`)
- taps at an **even** distance from the center are always exactly zero
  (never stored — that's the whole point of a halfband filter: half the
  multiplies are free)
- taps at **odd** distances `1, 3, 5, …, 2*n_pairs-1` from the center are
  the `n_pairs` designed/stored coefficients, mirrored symmetrically on
  both sides (linear phase)

To recalculate: design a new halfband lowpass (cutoff fixed at exactly
`0.25` cycles/sample — that's what "halfband" means and is intrinsic to
the ×2 per-stage structure, not a free parameter) with your chosen
tap-budget and transition-bandwidth/stopband trade-off, force it into this
odd/even-zero structure, round to `Q1.17` (scale by `2^17`, clip to the
18-bit signed range `[-131072, 131071]`), and splice the new literals into
copies of the `always_ff` multiply lines. **No change to the sample rate
or IF affects this step at all** — halfband filter design only depends on
the decimation/interpolation ratio per stage (always exactly 2 here) and
how many stages you cascade, and how much stopband rejection you need
relative to your signal bandwidth as a fraction of each stage's Nyquist
rate.

`scripts/halfband_design.py` implements this (`design_halfband()` +
`quantize()` + `verilog_literal()`), and **Step 2** of running it
reproduces filters with the same tap counts and the same order-of-magnitude
ripple/stopband numbers as the four real filters (method validated:
equiripple/Parks-McClellan (`scipy.signal.remez`) with a hand-tuned
transition width per stage, same as any standard multistage decimator
design flow) — meaning this methodology is good enough to design *new*
stages for *new* ratios with confidence, even without the original
designer's exact weighting choices.

### 3b. NCO sine/cosine ROM (IF/Fs — depends on the absolute IF-to-sample-rate RATIO, is completely independent of the filters)

Both DDS modules (`duc_fixed_dds.sv`, `fixed_ddsx2.sv`) are **not**
general-purpose NCOs with a programmable phase-increment register; they
are fixed-content ROMs where the IF is permanently encoded in the ROM's
data. The ROM has exactly `LUT_PERIOD` unique entries, where
`LUT_PERIOD` = denominator of `|IF| / Fs` reduced to lowest terms (e.g.
`39/125` needs period 125; `39/100` needs period 100). Recalculating this
is just: reduce the new `IF/Fs` fraction, confirm the resulting
denominator is small enough to be a practical BRAM/ROM (hundreds to a few
thousand entries is trivially fine on any FPGA this project targets — see
the feasibility table below), and regenerate
`sincos_lut_ram[k] = {sin(2*pi*k*num/den), cos(2*pi*k*num/den)}` for
`k = 0 .. den-1`, each as a 36-bit signed fixed-point pair (scale factor
`2^35 - 2`, matching `nco/hdl/romsave.py`'s existing convention for the
sibling `nco` IP block).

**This step is completely decoupled from the filter redesign in 3a** —
you can retune the IF (or change the absolute sample rate) without
touching a single filter tap, as long as the new `IF/Fs` ratio still
reduces to a small-enough denominator. You only need to redesign the
halfband filters if you change the *decimation/interpolation factor*
(e.g. going from ×8 to ×16), not if you just change what frequency or
what absolute rate you're running at.

`scripts/gen_nco_mif.py` implements this and was used to generate
Example A below.

## 4. Is this feasible for different rates? Three worked examples

**Yes, with one real constraint**: the NCO ROM denominator must stay
small. `halfband_design.py`'s Step 3 (`nco_feasibility_table()`) checks a
spread of IF/Fs combinations:

| Case | Ratio (reduced) | ROM entries | Feasible? |
|---|---|---|---|
| existing duc (39 MHz @ 125 MS/s) | 39/125 | 125 | yes |
| existing ddc (39 MHz @ 100 MS/s) | 39/100 | 100 | yes |
| doc's old 35 MHz @ 125 MS/s | 7/25 | 25 | yes |
| 30 MHz @ 125 MS/s | 6/25 | 25 | yes |
| 25 MHz @ 100 MS/s | 1/4 | 4 | yes (trivial mixer, see Example C) |
| 20 MHz @ 80 MS/s | 1/4 | 4 | yes (trivial mixer) |
| 15.36 MHz @ 61.44 MS/s (common SDR rate) | 1/4 | 4 | yes (trivial mixer) |
| 10 MHz @ 122.88 MS/s | 125/1536 | 1536 | yes, but a notably bigger ROM |
| 39 MHz @ 128 MS/s | 39/128 | 128 | yes |
| 33.3333 MHz @ 100 MS/s (1/3 Fs) | 1/3 | 3 | yes (trivial mixer) |

In practice almost any "nice" real-world IF/Fs pairing (both expressed as
a rational multiple of a common reference clock, which is how RF system
budgets are actually specified) reduces to a denominator in the tens to
low thousands — comfortably small for a BRAM. The only way to get an
*infeasible* (huge-denominator) ratio is to pick an IF/Fs pair that are
*not* simple rational multiples of a shared clock — e.g. an IF frequency
specified to many decimal places against an unrelated clock domain — which
realistic hardware designs don't do (ADC/DAC and LO clocks are always
derived from a shared reference in practice).

### Example A — retune only (same rates, new IF, no filter changes)

`examples/retune_if30/{duc,ddc}_sincos_if30.mif` — regenerated NCO ROMs
for **IF = 30 MHz** at the existing 125 MS/s (duc) / 100 MS/s (ddc) rates.
Ratios reduce to `6/25` and `3/10` respectively — both *smaller* ROMs than
the current 39 MHz tables (125 and 100 entries), a nice side benefit of
picking a rounder IF. No filter/HDL structural changes needed at all;
these files are drop-in replacements for the existing `.mif` files.

### Example B — different total rate-change factor (×16 instead of ×8/×4)

`halfband_design.py`'s Step 4 designs a 5th/4th cascade stage (63 taps,
16 nonzero tap-pairs, tuned for ~-95 dB stopband — tighter than any
existing stage, as required since it would sit closest to the new,
narrower final Nyquist edge) that could be appended to either converter's
cascade to go from the current ×8 (ddc) / ×4 (duc) to ×16 / ×8 total. This
demonstrates that **different total decimation/interpolation ratios are
architecturally straightforward** — the cascade is just a chain of
identical-shaped modules; adding a stage is adding one more instance plus
an elastic buffer (for the upconverter's rate-matching `duc_skid` pattern)
or decimator handshake (downconverter side), with the only required
engineering work being designing that one new filter's taps (shown
feasible above) — no change to the mixer/DDS is required at all for a
decimation-ratio-only change, since it only depends on IF/Fs (3b), and the
total decimation factor and final output sample rate can be kept
unchanged.

### Example C — IF = Fs/4 (trivial mixer, no ROM or multiplier at all)

`halfband_design.py`'s Step 5: if the IF is chosen to be *exactly* a
quarter of the sample rate, `cos`/`sin` degenerate to the sequences
`{1, 0, -1, 0, …}` / `{0, 1, 0, -1, …}`. A complex multiply by these
values is just a 4-state counter driving an I/Q swap and conditional
negate — **no sine/cosine ROM and no multiplier is needed at all**. Both
the 20 MHz @ 80 MS/s and 15.36 MHz @ 61.44 MS/s rows above are real-world
examples of this (15.36 MS/s baseband rate ×4 is a common LTE-derived
clock family). This is a genuinely different, much cheaper
implementation available to a system integrator who has freedom to choose
IF relative to Fs, and worth calling out explicitly as a design option if
new rates are ever adopted.

## 5. Summary / recommendation

- Recalculating the NCO for a new IF (keeping the same sample rates) is
  low-risk and mechanical: reduce the new ratio, check the denominator is
  small, regenerate the `.mif` file. Example A shows this end-to-end.
- Recalculating/extending the halfband filter cascade for a new total
  rate-change factor is well-understood, standard multirate filter design
  (validated against the real silicon's specs in Step 1/2 above) but is
  genuinely more work: each new/changed stage needs its taps redesigned,
  requantized, and re-spliced into generated-style HDL, and (not
  attempted here, since it needs real RTL/testbench changes, not just
  coefficient math) the pipeline bit-growth/rounding/shift-amount
  constants elsewhere in each `*_fir_*.sv` file would need re-deriving for
  a different tap count or width budget.
- Changing the *absolute* sample rate (e.g. 100 → 61.44 MS/s) while
  keeping the same decimation/interpolation ratios needs **no filter
  changes at all** — halfband filter design is rate-agnostic by
  construction — only a new NCO ROM (3b.), exactly like Example A/C.
- Picking IF = Fs/4 (or Fs/8, etc., in general any ratio with denominator
  a small power of 2) is a free optimization worth considering for any
  new rate plan: it removes the NCO ROM and the four parallel multipliers
  entirely.

## Files

- `scripts/decode.py` — extracts the ordered signed-integer tap
  coefficients from any of the four generated `*_fir_*.sv`/`duc_hb_*.sv`
  files, by parsing the literal `18'sb...` constants used as hardware
  multiplier operands.
- `scripts/halfband_design.py` — the main tool: reconstructs + analyzes
  the 4 existing filters, designs/validates equivalent filters with
  `scipy.signal.remez`, tabulates NCO ROM feasibility for various
  IF/Fs choices, and generates the Example B/C artifacts. Run directly to
  reproduce every number in this report.
- `scripts/gen_nco_mif.py` — generates a `.mif` NCO ROM file for any
  `(IF, Fs)` pair, in this repo's existing `$readmemb`-loaded binary
  format; used to produce Example A.
- `examples/retune_if30/` — Example A's generated `.mif` files (IF = 30
  MHz at the existing sample rates).


## 6. What was implemented

The feasibility work in this report was carried through into the shipped
RTL and compare harnesses:

- Both converters now expose a `RATIO` parameter with legal values 2, 4,
  8, and 16.
- The upconverter keeps the existing `RATIO=4` default and now selects a
  generate-based halfband cascade of 1, 2, 3, or 4 stages. The added
  stages are `duc_hb_interp_fir_h1.sv` (127 taps) and
  `duc_hb_interp_fir_h2.sv` (255 taps), extending the cascade to `h0,
  h0, h1, h2` for `RATIO=16`.
- The downconverter keeps the existing `RATIO=8` default and now selects a
  generate-based halfband cascade of 1, 2, 3, or 4 stages. The added
  stage is `ddc_hb_decim_fir_h3.sv` (127 taps), extending the cascade to
  `h0, h1, h2, h3` for `RATIO=16`.
- `doc/converter_rates/scripts/fixedpoint_model.py` now models all of
  those cascades, and the Verilator compare scripts accept `--ratio 2`,
  `4`, `8`, or `16` as appropriate.
- Verified result: all eight combinations pass bit-exact comparison with
  `0 LSB` tolerance and `lag=0`.

This closes the original feasibility loop: no DDS retune was needed for the
ratio-only expansion, while the new halfband stages supplied the extra image
and alias rejection required near the narrower final Nyquist zones.

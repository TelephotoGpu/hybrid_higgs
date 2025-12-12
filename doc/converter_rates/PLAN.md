# Converter ratio expansion plan

## Goal

Support `RATIO=2`, `4`, `8`, and `16` on both `libs/ip-library/upconverter`
and `libs/ip-library/downconverter` while preserving the existing default
behaviour bit-for-bit (`RATIO=4` for the upconverter, `RATIO=8` for the
downconverter).

## Phased approach taken

1. **Baseline verification**
   - Build Python fixed-point golden models and Verilator compare harnesses
     for the pre-change RTL.
   - Tighten the comparison from an early loose tolerance to true bit-exact
     checking once the model matched the RTL pipeline and sign conventions.

2. **Parameterize the shipped cascades**
   - Add a `RATIO` parameter to both converters.
   - Keep the existing default cascades as the default code path.
   - Select the required number of halfband stages with generate logic
     instead of forking separate top-level modules per ratio.

3. **Add the missing higher-ratio stages**
   - Upconverter: add `duc_hb_interp_fir_h1.sv` and
     `duc_hb_interp_fir_h2.sv` for `RATIO=8` and `RATIO=16`.
   - Downconverter: add `ddc_hb_decim_fir_h3.sv` for `RATIO=16`.
   - Extend the golden model and compare flows to cover every supported
     configuration.

4. **Document the final design**
   - Update the IP READMEs and the upconverter RST note.
   - Refresh `REPORT.md` from feasibility-only research to implemented
     status.
   - Capture the final plan, technical notes, and verification commands in
     this directory.

## Current status

Complete.

- All requested ratios are implemented on both converters.
- Default behaviour remains unchanged and bit-exact.
- All eight supported converter/ratio combinations have been re-verified
  with the Python model and Verilator harnesses at `0 LSB` tolerance and
  `lag=0`.

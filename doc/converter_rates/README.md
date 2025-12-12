# Converter rate-change documentation

This directory collects the converter rate-change work:
- `REPORT.md`: architecture background, feasibility research, and final implementation summary
- `PLAN.md`: the phased plan that was executed and the final completion status
- `NOTES.md`: technical decisions, filter-stage notes, and verification gotchas

Quick start:
- `python3 doc/converter_rates/scripts/compare_upconverter.py --ratio N`
- `python3 doc/converter_rates/scripts/compare_downconverter.py --ratio N`
- Use `N` in `2 4 8 16` to re-run the full bit-exact verification matrix.

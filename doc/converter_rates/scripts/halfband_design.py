"""
Halfband FIR / NCO design tools used to research recalculating the
upconverter/downconverter coefficients for new sample rates and IFs.

See doc/converter_rates/REPORT.md for the full writeup. Run this file
directly to reproduce all findings:

    python3 doc/converter_rates/scripts/halfband_design.py
"""
import os
import numpy as np
from scipy.signal import remez
from fractions import Fraction

try:
    from decode import decode_coeff_file
except ImportError:
    from .decode import decode_coeff_file

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
IP_LIB = os.path.join(REPO_ROOT, "libs", "ip-library")


def design_halfband(n_pairs, trans_frac=0.05):
    """Design a linear-phase halfband FIR with `n_pairs` nonzero
    tap-pairs (matching this repo's HDL structure: length = 4*n_pairs-1,
    with every tap at an EVEN distance from the center forced to zero,
    center tap = 0.5, and taps at ODD distances 1,3,...,2*n_pairs-1 from
    center are the n_pairs free/designed coefficients -- exactly how
    duc_hb_interp_fir_h0.sv / ddc_hb_decim_fir_h{0x2,1,2}.sv are built,
    confirmed against test_coeffs.py's bit-unpacking of h0.)

    trans_frac sets the transition-band half-width (fraction of sample
    rate) around the mandatory halfband cutoff of 0.25 cycles/sample --
    smaller trans_frac => sharper cutoff => needs more taps for the same
    stopband attenuation, the same trade-off the original design made.
    """
    length = 4 * n_pairs - 1
    center = 2 * n_pairs - 1
    edge = trans_frac
    bands = [0, 0.25 - edge, 0.25 + edge, 0.5]
    desired = [1, 0]
    h = remez(length, bands, desired, weight=[1, 1], fs=1.0)
    h2 = np.zeros(length)
    h2[center] = 0.5
    for k in range(n_pairs):
        d = 2 * n_pairs - 1 - 2 * k   # distances 2n-1, 2n-3, ..., 1
        val = (h[center - d] + h[center + d]) / 2.0
        h2[center - d] = val
        h2[center + d] = val
    h2 *= 1.0 / h2.sum()  # exact unity DC gain
    return h2


def quantize(h, width=18, scale_bits=17):
    scale = 2.0 ** scale_bits
    q = np.round(h * scale).astype(np.int64)
    qmax = (1 << (width - 1)) - 1
    qmin = -(1 << (width - 1))
    if q.max() > qmax or q.min() < qmin:
        raise OverflowError(f"coefficient overflow: {q.min()}..{q.max()} vs [{qmin},{qmax}]")
    return q


def verilog_literal(v, width=18):
    if v < 0:
        v = (1 << width) + v
    return f"{width}'sb{v:0{width}b}"


def analyze(h, label="", pb_edge=0.2, sb_edge=0.3):
    w = np.linspace(0, 0.5, 8192)
    n = np.arange(len(h))
    H = np.array([np.sum(h * np.exp(-2j * np.pi * f * n)) for f in w])
    mag_db = 20 * np.log10(np.abs(H) + 1e-12)
    pb = mag_db[w <= pb_edge]
    sb = mag_db[w >= sb_edge]
    ripple = pb.max() - pb.min()
    worst_sb = sb.max()
    print(f"{label:52s} len={len(h):3d}  ripple={ripple:6.3f} dB  worst_stopband={worst_sb:7.2f} dB")
    return ripple, worst_sb


def nco_period(if_hz, fs_hz, max_period=4096):
    """Reduce |if_hz|/fs_hz to lowest terms (treated as exact rational
    inputs); returns (numerator, denominator, feasible). denominator is
    the number of ROM entries a fixed-frequency NCO needs for that exact
    ratio -- this is the real constraint on which rates/IFs are feasible
    with this architecture's ROM-based 'fixed DDS' (no runtime-programmable
    phase increment)."""
    r = Fraction(if_hz).limit_denominator(10 ** 6) / Fraction(fs_hz).limit_denominator(10 ** 6)
    r = abs(r)
    num, den = r.numerator, r.denominator
    return num, den, den <= max_period


def build_halfband_from_hdl(path):
    """Reconstruct the full symmetric tap array from a generated HDL file
    (reverses decode.py's extraction), for cross-checking against freshly
    designed filters."""
    coeffs = decode_coeff_file(path)
    vals = [v for i, (_, v) in enumerate(coeffs) if i % 2 == 0]
    n_pairs = len(vals)
    length = 4 * n_pairs - 1
    center = length // 2
    h = np.zeros(length)
    h[center] = 1.0
    for k, v in enumerate(vals):
        d = 2 * n_pairs - 1 - 2 * k
        h[center - d] = v / 2.0 ** 17
        h[center + d] = v / 2.0 ** 17
    return h


def step1_validate_existing_filters():
    print("=== Step 1: decode + analyze the 4 existing halfband filters ===")
    files = {
        'duc_h0 (both upconverter interp stages)': f'{IP_LIB}/upconverter/hdl/duc_hb_interp_fir_h0.sv',
        'ddc_h0x2 (downconverter stage 1 of 3)':    f'{IP_LIB}/downconverter/hdl/ddc_hb_decim_firx2_h0.sv',
        'ddc_h1 (downconverter stage 2 of 3)':      f'{IP_LIB}/downconverter/hdl/ddc_hb_decim_fir_h1.sv',
        'ddc_h2 (downconverter stage 3 of 3)':      f'{IP_LIB}/downconverter/hdl/ddc_hb_decim_fir_h2.sv',
    }
    for label, path in files.items():
        h = build_halfband_from_hdl(path)
        analyze(h, label)


def step2_reproduce_with_remez():
    print("\n=== Step 2: redesign equivalent filters with scipy.signal.remez ===")
    print("    (confirms the methodology: same order-of-magnitude ripple/")
    print("     stopband specs as the real silicon, without having the exact")
    print("     original design weights -- good enough to design NEW filters)")
    for n_pairs, trans, label in [
        (16, 0.09, 'duc_h0-like  (16 pairs, len 63)'),
        (4, 0.145, 'ddc_h0x2-like (4 pairs, len 15)'),
        (8, 0.11, 'ddc_h1-like  (8 pairs, len 31)'),
        (16, 0.045, 'ddc_h2-like  (16 pairs, len 63)'),
    ]:
        h = design_halfband(n_pairs, trans_frac=trans)
        analyze(h, label)
        q = quantize(h)
        print("   quantized OK, max |coeff| =", np.abs(q).max(), "/ 131071 (18-bit signed limit)")


def step3_nco_feasibility_table():
    print("\n=== Step 3: NCO ROM-size feasibility for various (IF, Fs) choices ===")
    cases = [
        ("existing duc", 39e6, 125e6),
        ("existing ddc", 39e6, 100e6),
        ("IF=35MHz (doc-mentioned legacy value) @ 125MS/s", 35e6, 125e6),
        ("IF=30MHz @ 125MS/s", 30e6, 125e6),
        ("IF=25MHz @ 100MS/s", 25e6, 100e6),
        ("IF=20MHz @ 80MS/s (baseband 20MS/s x4)", 20e6, 80e6),
        ("IF=15.36MHz @ 61.44MS/s (common SDR rate)", 15.36e6, 61.44e6),
        ("IF=10MHz @ 122.88MS/s", 10e6, 122.88e6),
        ("IF=39MHz @ 128MS/s (power-of-two friendly)", 39e6, 128e6),
        ("IF=33.3333MHz @ 100MS/s (1/3 Fs, nasty)", 100e6 / 3, 100e6),
    ]
    for label, iff, fs in cases:
        num, den, ok = nco_period(iff, fs, max_period=4096)
        print(f"  {label:55s} ratio={num}/{den:<6d} ROM entries needed={den:<6d} feasible(<=4096)={ok}")


def step4_extra_stage_for_x16(n_pairs=16, trans_frac=0.045):
    print("\n=== Step 4 (Example B): extra halfband stage to reach x16 total rate change ===")
    h = design_halfband(n_pairs, trans_frac=trans_frac)
    analyze(h, "new 4th cascade stage (x16 total)")
    q = quantize(h)
    vals = []
    center = len(h) // 2
    for k in range(n_pairs):
        d = 2 * n_pairs - 1 - 2 * k
        vals.append(int(q[center - d]))
    print("  Verilog 18'sb coefficient literals (outermost tap first, matches")
    print("  the repo's existing word-list convention in each *_fir_*.sv file):")
    for v in vals:
        print("   ", verilog_literal(v))
    return vals


def step5_if_eq_fs_over_4_demo():
    print("\n=== Step 5 (Example C): IF = Fs/4 special case (trivial mixer) ===")
    n = np.arange(8)
    cos_ = np.round(np.cos(2 * np.pi * n / 4)).astype(int)
    sin_ = np.round(np.sin(2 * np.pi * n / 4)).astype(int)
    print("  cos(2*pi*n/4) sequence:", cos_)
    print("  sin(2*pi*n/4) sequence:", sin_)
    print("  -> {1,0,-1,0,...} / {0,1,0,-1,...}: mixer reduces to a per-sample")
    print("     swap(I,Q) + conditional negate, 4-state counter -- no NCO ROM,")
    print("     no complex multiplier needed at all for this specific ratio.")


if __name__ == "__main__":
    step1_validate_existing_filters()
    step2_reproduce_with_remez()
    step3_nco_feasibility_table()
    step4_extra_stage_for_x16()
    step5_if_eq_fs_over_4_demo()

import numpy as np, os
from fractions import Fraction

def mybin(x, N=36):
    if x < 0:
        x = (1 << N) + x
    return f"{x:0{N}b}"

def gen_duc_mif(if_hz, fs_hz, path, width=36, negate_sine=True):
    """duc_fixed_dds.sv layout: each ROM word = {sine[35:0], cosine[35:0]}
    (sine in upper half), one word per phase step, LUT_PERIOD = denominator
    of reduced if/fs fraction (module then negates sine internally for the
    image-reject mixer -- see upconverter.sv: sine_reg1 <= -sine_reg0).
    """
    r = Fraction(if_hz).limit_denominator(10**6) / Fraction(fs_hz).limit_denominator(10**6)
    num, period = r.numerator, r.denominator
    scale = (2**(width-1)) - 2
    lines = []
    for n in range(period):
        theta = 2*np.pi*num*n/period
        c = int(np.round(scale*np.cos(theta)))
        s = int(np.round(scale*np.sin(theta)))
        lines.append(mybin(s, width) + mybin(c, width))
    with open(path, 'w') as f:
        f.write("\n".join(lines) + "\n")
    return num, period

def gen_ddc_mif(if_hz, fs_hz, path, width=36):
    """fixed_ddsx2.sv layout: identical word format, but LUT size must be
    >= period and phase increments by 2 covering the interleaved n,n+1
    real-sample pair each clock -- so this is just the plain period-length
    table indexed directly by sample-time-mod-period (same math as duc)."""
    return gen_duc_mif(if_hz, fs_hz, path, width=width)

if __name__ == "__main__":
    outdir = os.path.join(os.path.dirname(__file__), "..", "examples", "retune_if30")
    os.makedirs(outdir, exist_ok=True)
    num, period = gen_duc_mif(30e6, 125e6, f"{outdir}/duc_sincos_if30.mif")
    print("duc IF=30MHz @ Fs=125MHz -> ratio", num, "/", period, "(was 39/125, period 125 -> now period", period, ")")
    num2, period2 = gen_ddc_mif(30e6, 100e6, f"{outdir}/ddc_sincos_if30.mif")
    print("ddc IF=30MHz @ Fs=100MHz -> ratio", num2, "/", period2, "(was 39/100, period 100 -> now period", period2, ")")

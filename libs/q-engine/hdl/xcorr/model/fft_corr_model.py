#!/usr/bin/env python3
"""Bit-exact model of the Q-engine FFT overlap-save correlator (``fft_corr``).

This is the single source of truth for the phase-3 contract in
doc/add-fir/PLAN.md.

Word format (same as the FIR): I (real) in [15:0], Q (imag) in [31:16],
signed 16-bit.  For a loaded reference ref[0..R-1] (1 <= R <= N):

    y[n] = sum_{i<R} conj(ref[i]) * x[n-R+1+i]

computed with K = 2N point fixed-point FFTs (overlap-save).  Blocks hold the
last K input samples and launch after B = N+1 new samples, or at a DATA
packet's last beat; the block partition is part of the contract because the
rounding depends on it.
"""
import math

MAGIC = 0xFC0A
OP_DATA = 1
OP_LOAD_REF = 2
OP_RESET = 3

ERR_HDR = 1
ERR_REF_LEN = 2
ERR_RST_LEN = 4

W = 27          # FFT data rail width
TWB = 18        # twiddle and H rail width
TW_A = (1 << (TWB - 1)) - 1
IN_SHIFT = W - 18          # input placement: x << 9
PROD_SHIFT = TWB - 1       # X*H rounding
DEFAULT_REF = 0x7FFF


def s16(v):
    v &= 0xFFFF
    return v - 0x10000 if v & 0x8000 else v


def pack(i, q):
    return ((q & 0xFFFF) << 16) | (i & 0xFFFF)


def unpack(w):
    return s16(w), s16(w >> 16)


def sat(v, bits=16):
    hi = (1 << (bits - 1)) - 1
    lo = -(1 << (bits - 1))
    return hi if v > hi else lo if v < lo else v


def satu(v, bits=32):
    hi = (1 << bits) - 1
    return hi if v > hi else 0 if v < 0 else v


def rs(v, s):
    """Round half up and shift right by s; s <= 0 shifts left."""
    if s <= 0:
        return v << (-s)
    return (v + (1 << (s - 1))) >> s


def header(op, shift=0, mode=0, magic=MAGIC, reserved=0):
    return (((magic & 0xFFFF) << 16) | ((mode & 3) << 14) | ((shift & 0x3F) << 8)
            | (op & 0xF) | reserved) & 0xFFFFFFFF


def header_valid(w):
    op = w & 0xF
    if (w >> 16) != MAGIC or (w & 0xF0) != 0 or op not in (OP_DATA, OP_LOAD_REF, OP_RESET):
        return False
    if op == OP_DATA:
        return (w >> 14) & 3 < 2
    return (w & 0xFF00) == 0


def log2i(n):
    b = n.bit_length() - 1
    assert n == 1 << b, n
    return b


# ------------------------------------------------------------------ FFT
class Arith:
    """Fixed-point arithmetic used by both FFT cores."""
    exact = False

    @staticmethod
    def half(v):
        return rs(v, 1)

    @staticmethod
    def twiddle(v, t):
        vr, vi = v
        c, s = t
        return rs(vr * c - vi * s, TWB - 1), rs(vr * s + vi * c, TWB - 1)


class ExactArith:
    """Float arithmetic with the same flow graph (structure cross-check)."""
    exact = True

    @staticmethod
    def half(v):
        return v / 2

    @staticmethod
    def twiddle(v, t):
        z = complex(*v) * complex(*t)
        return z.real, z.imag


KMAX = 2048
QN = KMAX // 4
# Quarter-wave cosine table shared with the RTL ROM (fft_corr_qrom.vh):
# Q[i] = round(cos(2*pi*i/KMAX) * A), i = 0..KMAX/4.
QTAB = [int(round(math.cos(2 * math.pi * i / KMAX) * TW_A)) for i in range(QN + 1)]


def tw_q(u):
    """(cos, sin) * A of angle 2*pi*u/KMAX from the quarter-wave table."""
    qd, r = u // QN, u % QN
    if qd == 0:
        return QTAB[r], QTAB[QN - r]
    if qd == 1:
        return -QTAB[QN - r], QTAB[r]
    if qd == 2:
        return -QTAB[r], -QTAB[QN - r]
    return QTAB[QN - r], -QTAB[r]


_TW_CACHE = {}


def twiddles(k, exact=False):
    """W_k^t for t < k as (re, im) = (cos, -sin)."""
    key = (k, exact)
    if key not in _TW_CACHE:
        if exact:
            tab = [(math.cos(2 * math.pi * t / k), -math.sin(2 * math.pi * t / k)) for t in range(k)]
        else:
            assert k <= KMAX
            tab = []
            for t in range(k):
                c, sn = tw_q(t * (KMAX // k))
                tab.append((c, -sn))
        _TW_CACHE[key] = tab
    return _TW_CACHE[key]


QROM_BEGIN = "   // BEGIN generated fftc_qrom: fft_corr_model.py --qrom fft_corr.v\n"
QROM_END = "   // END generated fftc_qrom\n"


def qrom_verilog():
    out = ["   // Q[i] = round(cos(2*pi*i/%d) * (2**17-1)), i = 0..%d\n" % (KMAX, QN),
           "   function [16:0] fftc_qrom;\n      input [9:0] i;\n      begin\n         case (i)\n"]
    for i, v in enumerate(QTAB):
        out.append("           10'd%d: fftc_qrom = 17'd%d;\n" % (i, v))
    out.append("           default: fftc_qrom = 17'd0;\n         endcase\n      end\n   endfunction\n")
    return "".join(out)


def write_qrom(path):
    """Regenerate the quarter-wave ROM function between the markers in fft_corr.v."""
    s = open(path).read()
    a = s.index(QROM_BEGIN) + len(QROM_BEGIN)
    b = s.index(QROM_END)
    new = s[:a] + qrom_verilog() + s[b:]
    if new != s:
        open(path, "w").write(new)


def _bfly(x, base, s, span, ar):
    """Butterflies of span `span` over every sub-block of the size-s group."""
    for sub in range(base, base + s, 2 * span):
        for j in range(span):
            a, b = sub + j, sub + j + span
            (ar_, ai_), (br_, bi_) = x[a], x[b]
            x[a] = (ar.half(ar_ + br_), ar.half(ai_ + bi_))
            x[b] = (ar.half(ar_ - br_), ar.half(ai_ - bi_))


def _rot_j(x, base, s, sign):
    """Multiply positions [3S/4, S) of the group by sign*j (exact)."""
    for p in range(base + 3 * s // 4, base + s):
        r, i = x[p]
        x[p] = (-i, r) if sign > 0 else (i, -r)


def _tw_group(x, base, s, k, tab, conj, ar):
    q4 = s // 4
    step = k // s
    for q, e in enumerate((0, 2, 1, 3)):
        if e == 0:
            continue
        for t in range(q4):
            idx = (t * e * step) % k
            c, sn = tab[idx]
            if conj:
                sn = -sn
            p = base + q * q4 + t
            x[p] = ar.twiddle(x[p], (c, sn))


def _groups(k):
    s = k
    while s >= 4:
        yield s
        s //= 4


def fft_fwd(x, ar=Arith):
    """DIF radix-2^2, natural in, bit-reversed out, gain 1/K."""
    k = len(x)
    x = list(x)
    tab = twiddles(k, ar.exact)
    for s in _groups(k):
        for base in range(0, k, s):
            _bfly(x, base, s, s // 2, ar)
            _rot_j(x, base, s, -1)
            _bfly(x, base, s, s // 4, ar)
            if s > 4:
                _tw_group(x, base, s, k, tab, False, ar)
    if log2i(k) & 1:
        for base in range(0, k, 2):
            _bfly(x, base, 2, 1, ar)
    return x


def fft_inv(x, ar=Arith):
    """Transpose of fft_fwd with conj twiddles: bit-reversed in, natural out,
    gain 1/K (normalized inverse DFT)."""
    k = len(x)
    x = list(x)
    tab = twiddles(k, ar.exact)
    if log2i(k) & 1:
        for base in range(0, k, 2):
            _bfly(x, base, 2, 1, ar)
    for s in reversed(list(_groups(k))):
        for base in range(0, k, s):
            if s > 4:
                _tw_group(x, base, s, k, tab, True, ar)
            _bfly(x, base, s, s // 4, ar)
            _rot_j(x, base, s, +1)
            _bfly(x, base, s, s // 2, ar)
    return x


def bitrev_perm(k):
    b = log2i(k)
    return [int(format(i, "0%db" % b)[::-1], 2) if b else 0 for i in range(k)]


# ------------------------------------------------------------------ model
class FftCorrModel:
    def __init__(self, n=256):
        assert 16 <= n <= 1024 and n == 1 << log2i(n)
        self.n = n
        self.k = 2 * n
        self.lk = log2i(self.k)
        self.b = self.k - n + 1
        self.err = 0
        self.blocks = 0
        self._state = "HDR"
        self._taps = []
        self._pending = []
        self._mode = 0
        self._shift = 0
        self.load_ref([pack(DEFAULT_REF, 0)])
        self.reset_history()

    # -------------------------------------------------------- reference
    def load_ref(self, words):
        r = len(words)
        assert 1 <= r <= self.n
        c = [(0, 0)] * self.k
        for kk in range(r):
            i, q = unpack(words[r - 1 - kk])
            c[kk] = (i << IN_SHIFT, (-q) << IN_SHIFT)
        f = fft_fwd(c)
        m = max(max(abs(a), abs(b)) for a, b in f)
        e = (TWB - 1) - m.bit_length() if m else 0
        self.h_raw = f
        self.e = e
        self.h = [(sat(rs(a, -e), TWB), sat(rs(b, -e), TWB)) for a, b in f]
        self.g = 2 * self.lk - 1 - e
        self.ref = list(words)

    def reset_history(self):
        self.win = [(0, 0)] * self.k

    # -------------------------------------------------------- data path
    def block(self, new):
        """Process m = len(new) new samples; return [(vI, vQ)] for them."""
        m = len(new)
        assert 1 <= m <= self.b
        self.win = self.win[m:] + [unpack(w) for w in new]
        self.blocks += 1
        xs = fft_fwd([(a << IN_SHIFT, b << IN_SHIFT) for a, b in self.win])
        p = []
        for (xr, xi), (hr, hi) in zip(xs, self.h):
            p.append((sat(rs(xr * hr - xi * hi, PROD_SHIFT), W),
                      sat(rs(xr * hi + xi * hr, PROD_SHIFT), W)))
        z = fft_inv(p)
        return z[self.k - m:]

    def fmt(self, v, mode, shift):
        vi, vq = v
        if mode == 0:
            s = shift - self.g
            return pack(sat(rs(vi, s)), sat(rs(vq, s)))
        return satu(rs(vi * vi + vq * vq, shift - 2 * self.g))

    def _flush(self, last):
        outs = []
        new = self._pending
        self._pending = []
        vs = self.block(new)
        for idx, v in enumerate(vs):
            outs.append((self.fmt(v, self._mode, self._shift),
                         1 if (last and idx == len(vs) - 1) else 0))
        return outs

    def push(self, word, last):
        """Consume one input beat; return a list of output beats (word, last)."""
        word &= 0xFFFFFFFF
        last = 1 if last else 0
        st = self._state
        if st == "HDR":
            if not header_valid(word):
                self.err |= ERR_HDR
                self._state = "HDR" if last else "DRAIN"
                return []
            op = word & 0xF
            if op == OP_DATA:
                self._mode = (word >> 14) & 3
                self._shift = (word >> 8) & 0x3F
                self._state = "HDR" if last else "DATA"
            elif op == OP_LOAD_REF:
                if last:
                    self.err |= ERR_REF_LEN
                else:
                    self._taps = []
                    self._state = "REF"
            else:
                self.reset_history()
                if not last:
                    self.err |= ERR_RST_LEN
                    self._state = "DRAIN"
            return []
        if st == "DATA":
            self._pending.append(word)
            outs = []
            if len(self._pending) == self.b or last:
                outs = self._flush(last)
            if last:
                self._state = "HDR"
            return outs
        if st == "REF":
            if len(self._taps) < self.n + 1:
                self._taps.append(word)
            if last:
                if len(self._taps) <= self.n:
                    self.load_ref(self._taps)
                else:
                    self.err |= ERR_REF_LEN
                self._state = "HDR"
            return []
        if st == "DRAIN":
            if last:
                self._state = "HDR"
            return []
        raise AssertionError(st)

    def run(self, beats):
        out = []
        for w, l in beats:
            out += self.push(w, l)
        return out


# ---------------------------------------------------------------- packets
def _frame(hdr, payload):
    if not payload:
        return [(hdr, 1)]
    return [(hdr, 0)] + [(w, 1 if i == len(payload) - 1 else 0) for i, w in enumerate(payload)]


def pkt_data(samples, shift=0, mode=0):
    return _frame(header(OP_DATA, shift, mode), list(samples))


def pkt_ref(taps):
    return _frame(header(OP_LOAD_REF), list(taps))


def pkt_reset(extra=()):
    return _frame(header(OP_RESET), list(extra))


def pkt_raw(words):
    return [(w, 1 if i == len(words) - 1 else 0) for i, w in enumerate(words)]


def rand_word(rng, amp=0x7FFF):
    return pack(rng.randint(-amp - 1, amp), rng.randint(-amp - 1, amp))


def exact_corr(ref_words, x_words):
    """Exact integer y[n] for all n (samples before x[0] are 0)."""
    ref = [complex(*unpack(w)) for w in ref_words]
    x = [complex(*unpack(w)) for w in x_words]
    r = len(ref)
    out = []
    for n in range(len(x)):
        acc = 0j
        for i in range(r):
            j = n - r + 1 + i
            if j >= 0:
                acc += ref[i].conjugate() * x[j]
        out.append((int(acc.real), int(acc.imag)))
    return out


# ---------------------------------------------------------------- self test
def _selftest():
    import cmath
    import random

    rng = random.Random(11)

    # FFT structure: exact arithmetic reproduces DFT / K in bit-reversed order
    for k in (4, 8, 32, 64, 128):
        x = [(rng.uniform(-1, 1), rng.uniform(-1, 1)) for _ in range(k)]
        xf = fft_fwd(x, ExactArith)
        br = bitrev_perm(k)
        for p in range(k):
            kk = br[p]
            d = sum(complex(*x[n]) * cmath.exp(-2j * math.pi * n * kk / k) for n in range(k)) / k
            assert abs(complex(*xf[p]) - d) < 1e-9, (k, p)
        xi = fft_inv(xf, ExactArith)
        for n in range(k):
            assert abs(complex(*xi[n]) - complex(*x[n]) / k) < 1e-9, (k, n)

    # quarter-wave twiddles equal direct rounding for every supported K
    for k in (32, 512, 2048):
        for t in range(k):
            c, sn = twiddles(k)[t]
            assert abs(c - math.cos(2 * math.pi * t / k) * TW_A) <= 0.5 + 1e-6
            assert abs(sn + math.sin(2 * math.pi * t / k) * TW_A) <= 0.5 + 1e-6

    # rail bounds: nothing exceeds W bits for full-scale worst cases
    for n in (16, 64):
        mdl = FftCorrModel(n)
        for ref in ([pack(-0x8000, -0x8000)] * n, [pack(0x7FFF, 0)]):
            mdl.load_ref(ref)
            for x in ([pack(-0x8000, -0x8000)] * mdl.b, [rand_word(rng) for _ in range(mdl.b)]):
                mdl.reset_history()
                for vi, vq in mdl.block(x):
                    assert -(1 << (W - 1)) <= vi < (1 << (W - 1))
                    assert -(1 << (W - 1)) <= vq < (1 << (W - 1))

    # accuracy against the exact correlation
    def check(n, ref, x, shift, bound_rms, bound_max, split=None):
        mdl = FftCorrModel(n)
        assert mdl.run(pkt_ref(ref)) == [] and mdl.err == 0
        outs = []
        if split is None:
            outs = mdl.run(pkt_data(x, shift))
        else:
            a = 0
            for b in split + [len(x)]:
                outs += mdl.run(pkt_data(x[a:b], shift))
                a = b
        assert len(outs) == len(x) and mdl.err == 0
        ex = exact_corr(ref, x)
        errs = []
        for (w, _), (ei, eq) in zip(outs, ex):
            gi, gq = unpack(w)
            for g_, e_ in ((gi, ei), (gq, eq)):
                t = sat(rs(e_, shift))
                errs.append(abs(g_ - t))
        rms = math.sqrt(sum(e * e for e in errs) / len(errs))
        assert rms <= bound_rms and max(errs) <= bound_max, (n, shift, rms, max(errs))
        return outs, rms, max(errs)

    x = [rand_word(rng) for _ in range(700)]
    check(256, [pack(0x7FFF, 0)], x, 15, 3.0, 12)                    # identity
    ref = [pack(rng.choice((-16000, 16000)), rng.choice((-16000, 16000))) for _ in range(256)]
    xm = [rand_word(rng, 8000) for _ in range(900)]
    for i in range(256):
        a, b = unpack(xm[300 + i])
        c, d = unpack(ref[i])
        xm[300 + i] = pack(sat(a + c), sat(b + d))
    outs, _, _ = check(256, ref, xm, 22, 1.0, 4)                    # matched QPSK
    peak = max(range(len(outs)), key=lambda t: sum(v * v for v in unpack(outs[t][0])))
    assert peak == 300 + 255, peak
    check(64, [rand_word(rng) for _ in range(40)], [rand_word(rng) for _ in range(400)], 20, 1.5, 8,
          split=[1, 7, 70, 71, 200])

    # front padding: a short reference peaks at the last matched sample
    mdl = FftCorrModel(64)
    ref = [rand_word(rng, 20000) for _ in range(13)]
    mdl.run(pkt_ref(ref))
    xs = [0] * 50 + ref + [0] * 30
    outs = mdl.run(pkt_data(xs, 40, 1))
    assert max(w for w, _ in outs) < 0xFFFFFFFF
    peak = max(range(len(outs)), key=lambda t: outs[t][0])
    assert peak == 50 + 12, peak

    # block rule: partition matters only at the bit level, framing always holds
    mdl = FftCorrModel(16)
    o = mdl.run(pkt_data([rand_word(rng) for _ in range(40)]))
    assert len(o) == 40 and [l for _, l in o].count(1) == 1 and o[-1][1] == 1
    assert mdl.blocks == 3            # 17 + 17 + 6
    assert mdl.run(pkt_data([])) == [] and mdl.blocks == 3

    # |y|^2 mode matches mode 0 values
    mdl = FftCorrModel(16)
    mdl.run(pkt_ref([rand_word(rng) for _ in range(16)]))
    xs = [rand_word(rng) for _ in range(20)]
    m2 = FftCorrModel(16)
    m2.run(pkt_ref(mdl.ref))
    a = mdl.run(pkt_data(xs, 0, 1))
    b = m2.run(pkt_data(xs, 63, 0))
    assert len(a) == 20 and all(w <= 0xFFFFFFFF for w, _ in a)
    mdl.reset_history()
    vs = mdl.block(xs[:17])
    assert mdl.fmt(vs[0], 1, 40) == satu(rs(vs[0][0] ** 2 + vs[0][1] ** 2, 40 - 2 * mdl.g))
    assert all(w == 0 or w == 0xFFFFFFFF for w, _ in b)

    # history across packets, LOAD_REF keeps it, RESET clears it
    m1, m2 = FftCorrModel(16), FftCorrModel(16)
    xs = [rand_word(rng) for _ in range(30)]
    m1.run(pkt_data(xs[:10]))
    m2.run(pkt_data(xs[:10]))
    m2.run(pkt_ref([pack(0x7FFF, 0)]))
    assert m1.run(pkt_data(xs[10:])) == m2.run(pkt_data(xs[10:]))
    m1.run(pkt_reset())
    assert m1.win == FftCorrModel(16).win

    # defaults and scale
    mdl = FftCorrModel(256)
    assert mdl.ref == [pack(0x7FFF, 0)] and mdl.g == 2 * 9 - 1 - mdl.e
    y = unpack(mdl.run(pkt_data([pack(1000, -2000)], 15))[0][0])
    assert abs(y[0] - 1000) <= 2 and abs(y[1] + 2000) <= 2, y

    # framing and errors
    mdl = FftCorrModel(16)
    h0 = mdl.h
    mdl.run(pkt_raw([header(OP_LOAD_REF)] + [1] * 17))
    assert mdl.err == ERR_REF_LEN and mdl.h == h0
    mdl.err = 0
    mdl.run([(header(OP_LOAD_REF), 1)])
    assert mdl.err == ERR_REF_LEN
    mdl.err = 0
    for bad in (header(OP_DATA, mode=2), header(OP_DATA, mode=3), header(OP_RESET, shift=1),
                header(OP_LOAD_REF, mode=1), header(OP_DATA, reserved=0x10), header(0),
                header(4), header(OP_DATA, magic=0xC0A7)):
        mdl.err = 0
        assert mdl.run(pkt_raw([bad, 5, 6])) == [] and mdl.err == ERR_HDR, hex(bad)
    mdl.err = 0
    mdl.run(pkt_data([rand_word(rng) for _ in range(5)]))
    mdl.run(pkt_reset([5, 6]))
    assert mdl.err == ERR_RST_LEN and mdl.win == FftCorrModel(16).win
    mdl.err = 0
    mdl.run(pkt_ref([pack(5, 5)] * 16))
    assert mdl.err == 0 and len(mdl.ref) == 16
    assert header_valid(header(OP_DATA, 63, 1))
    print("fft_corr_model selftest PASS")


if __name__ == "__main__":
    import sys
    if len(sys.argv) == 3 and sys.argv[1] == "--qrom":
        write_qrom(sys.argv[2])
    else:
        _selftest()

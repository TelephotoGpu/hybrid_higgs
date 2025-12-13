#!/usr/bin/env python3
"""Bit-exact model of the Q-engine streaming complex FIR (``fir_filter``).

This is the single source of truth for the contract in doc/add-fir/PLAN.md.

Word format: one 32-bit word per complex value, I (real) in [15:0], Q (imag)
in [31:16], signed two's complement.  Coefficients use the same packing.

    y[n] = sum_k h[k] * x[n-k]            (h[0] multiplies the newest sample)
    out  = sat16((acc + round) >>> shift)  round = 1 << (shift-1) if shift else 0

Stream framing: header word, payload, ``last`` on the final word of a packet.
"""

MAGIC = 0xF1F0
OP_DATA = 1
OP_LOAD_COEFFS = 2
OP_RESET = 3

ERR_HDR = 1
ERR_COEF_LEN = 2
ERR_RST_LEN = 4

DEFAULT_SHIFT = 15


def s16(v):
    v &= 0xFFFF
    return v - 0x10000 if v & 0x8000 else v


def pack(i, q):
    return ((q & 0xFFFF) << 16) | (i & 0xFFFF)


def unpack(w):
    return s16(w), s16(w >> 16)


def header(op, shift=0, magic=MAGIC, reserved=0):
    """Build a header word. ``reserved`` is OR-ed in (for error tests)."""
    return (((magic & 0xFFFF) << 16) | ((shift & 0x1F) << 8) | (op & 0xF) | reserved) & 0xFFFFFFFF


def header_valid(w):
    return ((w >> 16) == MAGIC and (w & 0xE0F0) == 0
            and (w & 0xF) in (OP_DATA, OP_LOAD_COEFFS, OP_RESET))


def sat(v, bits=16):
    hi = (1 << (bits - 1)) - 1
    lo = -(1 << (bits - 1))
    return hi if v > hi else lo if v < lo else v


def round_shift(acc, shift):
    if shift:
        acc += 1 << (shift - 1)
    return acc >> shift  # arithmetic (floor) shift on Python ints


class FirModel:
    def __init__(self, ntaps=16):
        self.ntaps = ntaps
        self.coef = [(0, 0)] * ntaps
        self.shift = DEFAULT_SHIFT
        self.hist = [(0, 0)] * ntaps
        self.err = 0
        self._state = "HDR"
        self._shadow = []
        self._shadow_shift = 0

    def reset_history(self):
        self.hist = [(0, 0)] * self.ntaps

    def filter_sample(self, w):
        self.hist = [unpack(w)] + self.hist[:-1]
        ar = ai = 0
        for (hr, hi), (xr, xi) in zip(self.coef, self.hist):
            ar += hr * xr - hi * xi
            ai += hr * xi + hi * xr
        return pack(sat(round_shift(ar, self.shift)), sat(round_shift(ai, self.shift)))

    def push(self, word, last):
        """Consume one input beat. Returns an output beat (word, last) or None."""
        word &= 0xFFFFFFFF
        last = 1 if last else 0
        st = self._state
        if st == "HDR":
            if not header_valid(word):
                self.err |= ERR_HDR
                self._state = "HDR" if last else "DRAIN"
                return None
            op = word & 0xF
            if op == OP_DATA:
                self._state = "HDR" if last else "DATA"
            elif op == OP_LOAD_COEFFS:
                if last:
                    self.err |= ERR_COEF_LEN
                    self._state = "HDR"
                else:
                    self._shadow = []
                    self._shadow_shift = (word >> 8) & 0x1F
                    self._state = "COEF"
            else:  # RESET
                self.reset_history()
                self._state = "HDR"
                if not last:
                    self.err |= ERR_RST_LEN
                    self._state = "DRAIN"
            return None
        if st == "DATA":
            if last:
                self._state = "HDR"
            return (self.filter_sample(word), last)
        if st == "COEF":
            self._shadow.append(unpack(word))
            if len(self._shadow) == self.ntaps:
                if last:
                    self.coef = list(self._shadow)
                    self.shift = self._shadow_shift
                    self._state = "HDR"
                else:
                    self.err |= ERR_COEF_LEN
                    self._state = "DRAIN"
            elif last:
                self.err |= ERR_COEF_LEN
                self._state = "HDR"
            return None
        if st == "DRAIN":
            if last:
                self._state = "HDR"
            return None
        raise AssertionError(st)

    def run(self, beats):
        out = []
        for w, l in beats:
            r = self.push(w, l)
            if r is not None:
                out.append(r)
        return out


# ---------------------------------------------------------------- packets
def pkt_data(samples):
    if not samples:
        return [(header(OP_DATA), 1)]
    return [(header(OP_DATA), 0)] + [
        (w, 1 if i == len(samples) - 1 else 0) for i, w in enumerate(samples)]


def pkt_coef(coefs, shift):
    if not coefs:
        return [(header(OP_LOAD_COEFFS, shift), 1)]
    return [(header(OP_LOAD_COEFFS, shift), 0)] + [
        (w, 1 if i == len(coefs) - 1 else 0) for i, w in enumerate(coefs)]


def pkt_reset(extra=()):
    if not extra:
        return [(header(OP_RESET), 1)]
    return [(header(OP_RESET), 0)] + [
        (w, 1 if i == len(extra) - 1 else 0) for i, w in enumerate(extra)]


def pkt_raw(words):
    return [(w, 1 if i == len(words) - 1 else 0) for i, w in enumerate(words)]


def rand_word(rng, amp=0x7FFF):
    return pack(rng.randint(-amp - 1, amp), rng.randint(-amp - 1, amp))


# ---------------------------------------------------------------- self test
def _selftest():
    import random

    rng = random.Random(1)
    # impulse response recovers the taps
    m = FirModel(16)
    h = [rand_word(rng, 0x3FFF) for _ in range(16)]
    m.run(pkt_coef(h, 15))
    out = m.run(pkt_data([pack(0x7FFF, 0)] + [0] * 20))
    for k in range(16):
        hr, hi = unpack(h[k])
        yr, yi = unpack(out[k][0])
        assert abs(yr - hr) <= 1 and abs(yi - hi) <= 1, (k, h[k], out[k])
    assert all(unpack(o[0]) == (0, 0) for o in out[16:])
    # independent float complex convolution, split across packets
    m = FirModel(16)
    h = [rand_word(rng, 0x0FFF) for _ in range(16)]
    x = [rand_word(rng, 0x3FFF) for _ in range(200)]
    m.run(pkt_coef(h, 15))
    y = [o[0] for o in m.run(pkt_data(x[:70]))] + [o[0] for o in m.run(pkt_data(x[70:]))]
    hc = [complex(*unpack(w)) for w in h]
    xc = [complex(*unpack(w)) for w in x]
    for n in range(len(x)):
        ref = sum(hc[k] * xc[n - k] for k in range(16) if n - k >= 0) / 32768.0
        got = complex(*unpack(y[n]))
        assert abs(got - ref) <= 1.0, (n, got, ref)
    # framing and errors
    m = FirModel(4)
    assert m.run(pkt_coef([pack(1, 0)] * 3, 0)) == [] and m.err == ERR_COEF_LEN
    assert m.coef == [(0, 0)] * 4
    m.err = 0
    m.run([(header(OP_LOAD_COEFFS, 0), 0)] + [(pack(1, 0), 0)] * 4 + [(7, 1)])
    assert m.err == ERR_COEF_LEN and m.coef == [(0, 0)] * 4
    m.err = 0
    m.run(pkt_coef([pack(1, 0)] * 4, 0))
    assert m.err == 0 and m.shift == 0
    o = m.run(pkt_data([pack(1, 0)] * 6))
    assert [unpack(w)[0] for w, _ in o] == [1, 2, 3, 4, 4, 4] and o[-1][1] == 1
    m.run(pkt_raw([0x12345678, pack(9, 9), pack(9, 9)]))
    assert m.err == ERR_HDR
    m.run(pkt_reset([5]))
    assert m.err == ERR_HDR | ERR_RST_LEN
    assert m.run(pkt_data([pack(1, 0)])) == [(pack(1, 0), 1)]
    assert m.run(pkt_data([])) == []
    assert not header_valid(header(OP_DATA, reserved=0x10))
    assert not header_valid(header(OP_DATA, reserved=0x2000))
    assert not header_valid(header(0))
    # saturation and rounding
    m = FirModel(2)
    m.run(pkt_coef([pack(0x7FFF, 0), pack(0x7FFF, 0)], 0))
    assert unpack(m.run(pkt_data([pack(0x7FFF, -0x8000)]))[0][0]) == (0x7FFF, -0x8000)
    assert round_shift(3, 1) == 2 and round_shift(-3, 1) == -1 and round_shift(-1, 1) == 0
    print("fir_model selftest PASS")


if __name__ == "__main__":
    _selftest()

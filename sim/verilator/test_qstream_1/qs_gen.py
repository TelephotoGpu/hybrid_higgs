"""Shared vector builder for the qstream full-system tests (test_qstream_1,
test_xcorr_fir_1).

A Builder records ops for the op-interpreter firmware (see
override/fpgas/cs/cs20/c/src/main.c) and, in lockstep, simulates what the
system must produce:

  * an image of in_v (xorshift32 fills and literal words, mirroring the
    firmware);
  * stream_router: route word check, drop on a bad route, route-only no-op;
  * fir_filter / fft_corr through their bit-exact Python models;
  * stream_merge tags: per-port output packet counts and the last tag.

write() emits qs_vectors.h and expected.hex (out_v followed by the status
trailer).
"""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "../../..")
sys.path.insert(0, os.path.join(ROOT, "libs/q-engine/hdl/fir/model"))
sys.path.insert(0, os.path.join(ROOT, "libs/q-engine/hdl/xcorr/model"))
import fir_model as fm  # noqa: E402
import fft_corr_model as xm  # noqa: E402

NTAPS = 16
XN = 256          # fft_corr N in q_engine.v
FIR_PORT, XC_PORT = 0, 1

QS_MAGIC = 0x5271

# op codes (must match QV_OP_* use in main.c)
OPS = ["FILL", "WORD", "FIR_COEF", "XC_REF", "DATA", "RESET", "RAW", "WORDS",
       "WAIT", "BURST"]
OP = {name: i + 1 for i, name in enumerate(OPS)}

# trailer layout (main.c)
TRAILER_WORDS = 6


def route(port):
    return (QS_MAGIC << 16) | (port & 0xF)


def tag(port, seq):
    return (QS_MAGIC << 16) | ((seq & 0xFF) << 4) | (port & 0xF)


def route_valid(w):
    return (w >> 16) == QS_MAGIC and (w & 0xFFF0) == 0 and (w & 0xF) < 2


def xorshift32(x):
    x ^= (x << 13) & 0xFFFFFFFF
    x ^= x >> 17
    x ^= (x << 5) & 0xFFFFFFFF
    return x


def xc_fmt(mode, shift):
    """Correlator output format as packed in an op field (main.c XC_MODE/SHIFT)."""
    assert mode in (0, 1) and 0 <= shift <= 63
    return (mode << 8) | shift


class Builder:
    def __init__(self):
        self.ops = []
        self.mem = []          # in_v image
        self.out = []          # expected out_v
        self.fir = fm.FirModel(NTAPS)
        self.xc = xm.FftCorrModel(XN)
        self.rx_count = [0, 0]
        self.arrivals = []     # port per output packet, in op order
        self.stats = {"fir_out": 0, "xc_out": 0, "dropped": 0, "route_only": 0}
        self.fills = {}        # in_v offset -> (n, amp, seed) of each fill

    # ------------------------------------------------------------ memory
    def alloc(self, n):
        off = len(self.mem)
        self.mem += [0] * n
        return off

    def _op(self, name, port=0, a=0, b=0, c=0, d=0):
        vals = (OP[name], port, a, b, c, d)
        assert all(0 <= v <= 0xFFFFFFFF for v in vals), vals
        self.ops.append(vals)

    def fill(self, n, amp, seed):
        """xorshift32 noise with lanes uniform-ish in [-amp, amp]."""
        assert 1 <= amp <= 0x7FFF and seed != 0
        off = self.alloc(n)
        x = seed
        for i in range(n):
            lanes = []
            for _ in range(2):
                x = xorshift32(x)
                lanes.append((x % (2 * amp + 1)) - amp)
            self.mem[off + i] = xm.pack(lanes[0], lanes[1])
        self._op("FILL", a=off, b=n, c=amp, d=seed)
        self.fills[off] = (n, amp, seed)
        return off

    def words(self, values):
        off = self.alloc(len(values))
        for i, v in enumerate(values):
            self.mem[off + i] = v & 0xFFFFFFFF
            self._op("WORD", a=off + i, c=v & 0xFFFFFFFF)
        return off

    # ------------------------------------------------------------ system
    def _deliver(self, words):
        """One DMA_3 packet (list of words, `last` on the final one) through
        stream_router into a module. Returns (port, outputs) or (None, [])."""
        if not route_valid(words[0]):
            self.stats["dropped"] += 1
            return None, []
        port = words[0] & 0xF
        body = words[1:]
        if not body:
            self.stats["route_only"] += 1
            return port, []
        beats = xm.pkt_raw(body)
        outs = (self.fir if port == FIR_PORT else self.xc).run(beats)
        if outs:
            assert outs[-1][1] == 1 and all(l == 0 for _, l in outs[:-1])
        return port, [w for w, _ in outs]

    def _collect(self, port, outs, out_n):
        assert len(outs) == out_n, (len(outs), out_n)
        assert out_n < 2048 and len(self.out) < (1 << 20)  # main.c CTX()
        if not outs:
            return 0
        d = len(self.out)
        self.out += outs
        self.rx_count[port] += 1
        self.arrivals.append(port)
        self.stats["fir_out" if port == FIR_PORT else "xc_out"] += len(outs)
        return d

    def fir_coef(self, off, shift):
        self._deliver([route(FIR_PORT), fm.header(fm.OP_LOAD_COEFFS, shift)]
                      + self.mem[off:off + NTAPS])
        self._op("FIR_COEF", a=off, c=shift)

    def xc_ref(self, off, n):
        assert 1 <= n <= XN
        self._deliver([route(XC_PORT), xm.header(xm.OP_LOAD_REF)] + self.mem[off:off + n])
        self._op("XC_REF", a=off, b=n)

    def data(self, port, off, n, mode=0, shift=15):
        """DATA packet; mode/shift apply to the correlator port only."""
        if port == FIR_PORT:
            hdr, f = fm.header(fm.OP_DATA), 0
        else:
            hdr, f = xm.header(xm.OP_DATA, shift, mode), xc_fmt(mode, shift)
        _, outs = self._deliver([route(port), hdr] + self.mem[off:off + n])
        d = self._collect(port, outs, n)
        self._op("DATA", port, off, n, f, d)
        return outs

    def reset(self, port):
        hdr = fm.header(fm.OP_RESET) if port == FIR_PORT else xm.header(xm.OP_RESET)
        self._deliver([route(port), hdr])
        self._op("RESET", port)

    def raw(self, off, n):
        """Packet with no driver route word (the first word is the route)."""
        port, outs = self._deliver(self.mem[off:off + n])
        assert not outs, "raw packets must not produce output"
        self._op("RAW", a=off, b=n)

    def send_words(self, port, off, n):
        """[ROUTE(port)] + in_v[off:off+n]; output (if any) is expected."""
        _, outs = self._deliver([route(port)] + self.mem[off:off + n])
        d = self._collect(port, outs, len(outs))
        self._op("WORDS", port, off, n, len(outs), d)
        return outs

    def burst(self, count, xc_every, amp, seed, xc_mode=0, xc_shift=15):
        """count one-sample FIR packets; after every xc_every-th (k % xc_every
        == 0) also a one-sample correlator packet (firmware loop, one op)."""
        n_xc = 0 if xc_every == 0 else (count + xc_every - 1) // xc_every
        off = self.fill(count + n_xc, amp, seed)
        d0 = len(self.out)
        x = off
        for k in range(count):
            _, outs = self._deliver([route(FIR_PORT), fm.header(fm.OP_DATA), self.mem[x]])
            self._collect(FIR_PORT, outs, 1)
            x += 1
            if xc_every and k % xc_every == 0:
                _, outs = self._deliver([route(XC_PORT), xm.header(xm.OP_DATA, xc_shift, xc_mode),
                                         self.mem[x]])
                self._collect(XC_PORT, outs, 1)
                x += 1
        self._op("BURST", xc_fmt(xc_mode, xc_shift), off, count, xc_every, d0)

    def xc_shift(self, amp, extra=0):
        """Shift that puts a typical mode-0 output for noise of lane amplitude
        amp near 2^13 with the loaded reference (+extra)."""
        e = sum(a * a + q * q for a, q in (xm.unpack(w) for w in self.xc.ref))
        typ = int((e ** 0.5) * amp) + 1
        return max(0, min(63, typ.bit_length() - 13 + extra))

    def peak(self, ref_off, split=None):
        """Re-create the fill at ref_off (same seed) and correlate it as mode 0
        data (split into two packets at `split` if given). The last output is
        sum |ref|^2 >> shift; assert the model is within its precision.
        Resets the correlator history first.
        Valid only while that fill is the loaded reference."""
        n, amp, seed = self.fills[ref_off]
        e = sum(a * a + q * q for a, q in (xm.unpack(w) for w in self.mem[ref_off:ref_off + n]))
        shift = max(0, e.bit_length() - 14)
        off = self.fill(n, amp, seed)
        # large earlier samples in the overlap-save window add forward-FFT
        # noise scaled by the reference gain; start from a clean history
        self.reset(XC_PORT)
        if split:
            self.data(XC_PORT, off, split, 0, shift)
            outs = self.data(XC_PORT, off + split, n - split, 0, shift)
        else:
            outs = self.data(XC_PORT, off, n, 0, shift)
        pi, pq = xm.unpack(outs[-1])
        want = e / (1 << shift)
        # model error is ~0.7 rms / <4 max internal LSBs (2^g in y units)
        tol = 2 + 4 * 2 ** max(0, self.xc.g - shift)
        assert abs(pi - want) <= tol and abs(pq) <= tol, (pi, pq, want, tol)
        return pi

    def wait(self):
        self._op("WAIT")

    # ------------------------------------------------------------ output
    def expected(self):
        last = [tag(p, self.rx_count[p] - 1) if self.rx_count[p] else 0 for p in (0, 1)]
        switches = sum(1 for x, y in zip(self.arrivals, self.arrivals[1:]) if x != y)
        trailer = [self.rx_count[0], self.rx_count[1], last[0], last[1], 0,
                   0x600D0000 | (0x100 if switches else 0) | (len(self.arrivals) & 0xFF)]
        assert len(trailer) == TRAILER_WORDS
        return self.out + trailer

    def write(self, test_dir, banner):
        assert len(self.mem) < 0x10000 - 0x1000, "in_v exceeds VMEM"
        hdr = os.path.join(test_dir, "override/fpgas/cs/cs20/c/src/qs_vectors.h")
        with open(hdr, "w") as f:
            f.write("// Generated by gen_vectors.py (%s). Do not edit.\n" % banner)
            f.write("#ifndef __QS_VECTORS_H__\n#define __QS_VECTORS_H__\n\n")
            for name in OPS:
                f.write("#define QV_OP_%-9s (%d)\n" % (name, OP[name]))
            f.write("\n#define QV_WORDS   (%d)\n" % max(1, len(self.mem)))
            # 24 bytes per op in the 25 KB imem next to about 5 KB of code
            assert len(self.ops) <= 700, "op table too large for imem: %d ops" % len(self.ops)
            f.write("#define QV_OPS     (%d)\n" % len(self.ops))
            f.write("#define QV_OUTPUTS (%d)\n\n" % len(self.out))
            f.write("// {op, port, a, b, c, d}\n")
            f.write("static const unsigned int qv_ops[QV_OPS][6] = {\n")
            for o in self.ops:
                f.write("    {%d, %d, %d, %d, 0x%x, 0x%x},\n" % o)
            f.write("};\n\n#endif\n")
        exp = self.expected()
        with open(os.path.join(test_dir, "expected.hex"), "w") as f:
            for w in exp:
                f.write("%08x\n" % w)
        return exp

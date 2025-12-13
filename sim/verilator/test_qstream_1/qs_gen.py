"""Shared vector builder for the qstream full-system tests (test_qstream_1,
test_xcorr_fir_1).

A Builder records ops for the op-interpreter firmware (see
override/fpgas/cs/cs20/c/src/main.c) and, in lockstep, simulates what the
system must produce:

  * an image of in_v (xorshift32 fills, literal words, config words and
    Golay pairs, mirroring the firmware);
  * stream_router: route word check, drop on a bad route, route-only no-op;
  * fir_filter / golay_corr through their bit-exact Python models;
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
import golay_model as gm  # noqa: E402

NTAPS = 16
M = 7
L = 1 << M
FIR_PORT, XC_PORT = 0, 1

QS_MAGIC = 0x5271

# op codes (must match QV_OP_* use in main.c)
OPS = ["FILL", "WORD", "CFGW", "PAIR", "FIR_COEF", "XC_CFG", "DATA",
       "RESET", "RAW", "WORDS", "WAIT", "BURST"]
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


def cfg_pack(p, w):
    pnib = sum((pk & 0xF) << (4 * k) for k, pk in enumerate(p))
    wbits = sum((wk & 3) << (2 * k) for k, wk in enumerate(w))
    return pnib, wbits


class Builder:
    def __init__(self):
        self.ops = []
        self.mem = []          # in_v image
        self.out = []          # expected out_v
        self.fir = fm.FirModel(NTAPS)
        self.xc = gm.GolayModel(M)
        self.rx_count = [0, 0]
        self.arrivals = []     # port per output packet, in op order
        self.stats = {"fir_out": 0, "xc_out": 0, "dropped": 0, "route_only": 0}

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
            self.mem[off + i] = gm.pack(lanes[0], lanes[1])
        self._op("FILL", a=off, b=n, c=amp, d=seed)
        return off

    def words(self, values):
        off = self.alloc(len(values))
        for i, v in enumerate(values):
            self.mem[off + i] = v & 0xFFFFFFFF
            self._op("WORD", a=off + i, c=v & 0xFFFFFFFF)
        return off

    def cfg_words(self, p, w):
        off = self.alloc(M)
        for k in range(M):
            self.mem[off + k] = gm.cfg_word(p[k], w[k])
        pnib, wbits = cfg_pack(p, w)
        self._op("CFGW", a=off, c=pnib, d=wbits)
        return off

    def pair(self, p, w, amp):
        """[a, b] Golay pair (2*L words) generated on target."""
        assert gm.is_permutation(p) and 1 <= amp <= 0x7FFF
        off = self.alloc(2 * L)
        a, b = gm.golay_pair(p, w)
        self.mem[off:off + 2 * L] = gm.seq_words(a, amp) + gm.seq_words(b, amp)
        pnib, wbits = cfg_pack(p, w)
        self._op("PAIR", a=off, c=pnib, d=wbits | (amp << 16))
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
        beats = gm.pkt_raw(body)
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

    def xc_cfg(self, off, shift, mode):
        self._deliver([route(XC_PORT), gm.header(gm.OP_LOAD_CFG, shift, mode)]
                      + self.mem[off:off + M])
        self._op("XC_CFG", a=off, c=shift, d=mode)

    def data(self, port, off, n):
        hdr = fm.header(fm.OP_DATA) if port == FIR_PORT else gm.header(gm.OP_DATA)
        _, outs = self._deliver([route(port), hdr] + self.mem[off:off + n])
        d = self._collect(port, outs, n)
        self._op("DATA", port, off, n, 0, d)
        return outs

    def reset(self, port):
        hdr = fm.header(fm.OP_RESET) if port == FIR_PORT else gm.header(gm.OP_RESET)
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

    def burst(self, count, xc_every, amp, seed):
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
                _, outs = self._deliver([route(XC_PORT), gm.header(gm.OP_DATA), self.mem[x]])
                self._collect(XC_PORT, outs, 1)
                x += 1
        self._op("BURST", 0, off, count, xc_every, d0)

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

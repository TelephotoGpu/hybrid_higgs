#!/usr/bin/env python3
"""test_qstream_1: directed DMA_3 -> stream_router -> {fir_filter,
fft_corr} -> stream_merge -> DMA_4 test through the qstream C library.

Writes override/fpgas/cs/cs20/c/src/qs_vectors.h and expected.hex (see
qs_gen.py). Covers route-only packets, bad routes (port, magic, reserved
bits), header-only data packets, module error packets, explicit expect via
qstream_send_words, coefficient/reference reloads and resets on both ports,
correlation peaks (whole and split over two packets), power mode, packets
longer than one FFT block, and long runs of back-to-back small packets that
overflow the per-port expect queue.
"""
import random
import sys

from qs_gen import Builder, FIR_PORT, XC_PORT, XN, HERE, NTAPS, fm, xm, route

SEED = 0x51500001


def main():
    rng = random.Random(SEED)
    b = Builder()
    seed = lambda: rng.randrange(1, 1 << 32)  # noqa: E731

    # configure both modules
    coef = b.fill(NTAPS, 0x1FFF, seed())
    b.fir_coef(coef, 15)
    ref = b.fill(64, 0x7FFF, seed())
    b.xc_ref(ref, 64)

    # route-only no-ops on both ports
    b.send_words(FIR_PORT, 0, 0)
    b.send_words(XC_PORT, 0, 0)

    # bad routes: port 2, bad magic, reserved bits; router drops each packet
    for rw in (route(2), 0x12340000, route(0) | 0x100, route(15)):
        body = b.words([rw, fm.header(fm.OP_DATA)])
        b.fill(3, 0x7FFF, seed())
        b.raw(body, 5)
    # a bad route that is a single word (route + last)
    b.raw(b.words([route(3)]), 1)

    # interleaved data
    for n0, n1 in ((40, 50), (1, 1), (17, 3)):
        b.data(FIR_PORT, b.fill(n0, 0x7FFF, seed()), n0)
        b.data(XC_PORT, b.fill(n1, 0x0FFF, seed()), n1, 0, b.xc_shift(0x0FFF))

    # correlation peak: a copy of the reference, whole and split
    b.peak(ref)
    b.data(XC_PORT, b.fill(20, 0x40, seed()), 20, 0, b.xc_shift(0x40))
    b.peak(ref, split=23)

    # header-only data packets (no output, no tag)
    b.send_words(FIR_PORT, b.words([fm.header(fm.OP_DATA)]), 1)
    b.send_words(XC_PORT, b.words([xm.header(xm.OP_DATA, 20)]), 1)

    # module error packets: bad header, header-only LOAD_REF, bad mode,
    # FIR reset with payload, FIR reserved bits
    b.send_words(XC_PORT, b.words([0xDEADBEEF, 1, 2]), 3)
    b.send_words(XC_PORT, b.words([xm.header(xm.OP_LOAD_REF)]), 1)
    b.send_words(XC_PORT, b.words([xm.header(xm.OP_DATA, 3, 2), 5]), 2)
    b.send_words(FIR_PORT, b.words([fm.header(fm.OP_RESET), 7]), 2)
    b.send_words(FIR_PORT, b.words([fm.header(fm.OP_DATA, reserved=0x80), 1]), 2)

    # explicit expect: caller-built packets via qstream_send_words
    blk = b.alloc(0)
    b.words([fm.header(fm.OP_DATA)])
    b.fill(5, 0x7FFF, seed())
    assert len(b.send_words(FIR_PORT, blk, 6)) == 5
    blk = b.alloc(0)
    b.words([xm.header(xm.OP_DATA, b.xc_shift(0x7FFF))])
    b.fill(7, 0x7FFF, seed())
    assert len(b.send_words(XC_PORT, blk, 8)) == 7

    b.wait()

    # resets, then data on both ports (XC longer than one FFT block)
    b.reset(FIR_PORT)
    b.reset(XC_PORT)
    b.data(XC_PORT, b.fill(2 * XN + 40, 0x7FFF, seed()), 2 * XN + 40, 0, b.xc_shift(0x7FFF))
    b.data(FIR_PORT, b.fill(30, 0x7FFF, seed()), 30)

    # new references: a full-length one with power output, a single tap
    ref2 = b.fill(XN, 0x3FF, seed())
    b.xc_ref(ref2, XN)
    b.data(XC_PORT, b.fill(40, 0x3FF, seed()), 40, 1, 2 * b.xc_shift(0x3FF, 2))
    b.peak(ref2)
    b.xc_ref(b.words([xm.pack(0, 0x7FFF)]), 1)     # y = -j x
    xo = b.fill(40, 0x7FFF, seed())
    outs = b.data(XC_PORT, xo, 40, 0, 15)
    for w, o in zip(b.mem[xo:xo + 40], outs):
        (xi, xq), (oi, oq) = xm.unpack(w), xm.unpack(o)
        tol = 2 + max(abs(xi), abs(xq)) // 4096   # H is 18-bit: ~1e-4 gain error
        assert abs(oi - xq) <= tol and abs(oq + xi) <= tol or 0x8000 in (-xi, -xq), (w, o)
    b.fir_coef(b.fill(NTAPS, 0x7FFF, seed()), 17)

    # 24 back-to-back small packets per port (> the 16-deep expect queue)
    for i in range(24):
        b.data(FIR_PORT, b.fill(1 + i % 4, 0x7FFF, seed()), 1 + i % 4)
        b.data(XC_PORT, b.fill(1 + (i * 3) % 5, 0x7FFF, seed()), 1 + (i * 3) % 5, i % 2, 15 + 15 * (i % 2))
    # and a same-port burst of 20
    for i in range(20):
        b.data(FIR_PORT, b.fill(2, 0x7FFF, seed()), 2)

    assert b.fir.err == fm.ERR_HDR | fm.ERR_RST_LEN, b.fir.err
    assert b.xc.err == xm.ERR_HDR | xm.ERR_REF_LEN, b.xc.err
    exp = b.write(HERE, "seed 0x%08X" % SEED)
    print("gen_vectors: %d ops, %d in_v words, %d expected words, "
          "fir/xc packets %d/%d, %s" % (len(b.ops), len(b.mem), len(exp),
                                        b.rx_count[0], b.rx_count[1], b.stats))


if __name__ == "__main__":
    sys.exit(main())

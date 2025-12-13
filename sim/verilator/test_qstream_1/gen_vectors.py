#!/usr/bin/env python3
"""test_qstream_1: directed DMA_3 -> stream_router -> {fir_filter,
golay_corr} -> stream_merge -> DMA_4 test through the qstream C library.

Writes override/fpgas/cs/cs20/c/src/qs_vectors.h and expected.hex (see
qs_gen.py). Covers route-only packets, bad routes (port, magic, reserved
bits), header-only data packets, module error packets, explicit expect via
qstream_send_words, config/coef reloads and resets on both ports, a Golay
pair correlation peak, and long runs of back-to-back small packets that
overflow the per-port expect queue.
"""
import random
import sys

from qs_gen import (Builder, FIR_PORT, XC_PORT, HERE, L, NTAPS, fm, gm,
                    route)

SEED = 0x51500001


def main():
    rng = random.Random(SEED)
    b = Builder()
    seed = lambda: rng.randrange(1, 1 << 32)  # noqa: E731

    p, w = gm.rand_cfg(rng, 7)

    # configure both modules
    coef = b.fill(NTAPS, 0x1FFF, seed())
    b.fir_coef(coef, 15)
    cfg = b.cfg_words(p, w)
    b.xc_cfg(cfg, 7, 0)

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
        b.data(XC_PORT, b.fill(n1, 0x0FFF, seed()), n1)

    # Golay pair [a, b] with the loaded config: mode 0 peak = 2*L*amp >> 7
    amp = 0x100
    pk = b.pair(p, w, amp)
    outs = b.data(XC_PORT, pk, 2 * L)
    peak = gm.unpack(outs[-1])
    assert peak == (2 * L * amp >> 7, 0), peak
    b.data(XC_PORT, b.fill(20, 0x40, seed()), 20)

    # header-only data packets (no output, no tag)
    b.send_words(FIR_PORT, b.words([fm.header(fm.OP_DATA)]), 1)
    b.send_words(XC_PORT, b.words([gm.header(gm.OP_DATA)]), 1)

    # module error packets: bad headers, short config, reset with payload
    b.send_words(XC_PORT, b.words([0xDEADBEEF, 1, 2]), 3)
    b.send_words(XC_PORT, b.words([gm.header(gm.OP_LOAD_CFG, 3), 0, 1]), 3)
    b.send_words(XC_PORT, b.words([gm.header(gm.OP_DATA, mode=1), 5]), 2)
    b.send_words(FIR_PORT, b.words([fm.header(fm.OP_RESET), 7]), 2)
    b.send_words(FIR_PORT, b.words([fm.header(fm.OP_DATA, reserved=0x80), 1]), 2)

    # explicit expect: caller-built FIR data packet via qstream_send_words
    blk = b.alloc(0)
    b.words([fm.header(fm.OP_DATA)])
    b.fill(5, 0x7FFF, seed())
    outs = b.send_words(FIR_PORT, blk, 6)
    assert len(outs) == 5

    b.wait()

    # resets, then data on both ports
    b.reset(FIR_PORT)
    b.reset(XC_PORT)
    b.data(XC_PORT, b.fill(30, 0x7FFF, seed()), 30)
    b.data(FIR_PORT, b.fill(30, 0x7FFF, seed()), 30)

    # new configs: non-default shift/mode, arbitrary (non-permutation) config
    p2, w2 = gm.rand_cfg(rng, 7, perm=False)
    b.xc_cfg(b.cfg_words(p2, w2), 3, 1)
    b.data(XC_PORT, b.fill(40, 0x3FF, seed()), 40)
    b.xc_cfg(b.cfg_words(p, w), 12, 2)
    b.data(XC_PORT, b.fill(40, 0x7FFF, seed()), 40)
    b.fir_coef(b.fill(NTAPS, 0x7FFF, seed()), 17)

    # 24 back-to-back small packets per port (> the 16-deep expect queue)
    for i in range(24):
        b.data(FIR_PORT, b.fill(1 + i % 4, 0x7FFF, seed()), 1 + i % 4)
        b.data(XC_PORT, b.fill(1 + (i * 3) % 5, 0x7FFF, seed()), 1 + (i * 3) % 5)
    # and a same-port burst of 20
    for i in range(20):
        b.data(FIR_PORT, b.fill(2, 0x7FFF, seed()), 2)

    assert b.fir.err == fm.ERR_HDR | fm.ERR_RST_LEN, b.fir.err
    assert b.xc.err == gm.ERR_HDR | gm.ERR_CFG_LEN, b.xc.err
    exp = b.write(HERE, "seed 0x%08X" % SEED)
    print("gen_vectors: %d ops, %d in_v words, %d expected words, "
          "fir/xc packets %d/%d, %s" % (len(b.ops), len(b.mem), len(exp),
                                        b.rx_count[0], b.rx_count[1], b.stats))


if __name__ == "__main__":
    sys.exit(main())

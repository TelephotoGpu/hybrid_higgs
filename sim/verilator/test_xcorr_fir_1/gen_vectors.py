#!/usr/bin/env python3
"""test_xcorr_fir_1: randomized, interleaved FIR + Golay correlator traffic
through qstream (DMA_3 -> stream_router -> {fir_filter, golay_corr} ->
stream_merge -> DMA_4).

TEST_SEED (env or argv[1]) picks a random job list. Packets for both ports
are queued back to back, so the firmware's qstream receive side must read
each merge tag and route the following payload to the packet it belongs to.
Jobs include data of random length on both ports, Golay pairs (correlation
peaks, sometimes split over two packets), coefficient/config reloads (random
shift/mode, sometimes a non-permutation config), resets, route-only packets,
bad routes, header-only packets, module error packets, caller-built packets,
sync points, and a burst of single-sample packets on both ports that wraps
the 8-bit merge tag sequence. Stall injection (STALL_SEED) randomizes
valid/ready around every stream block independently of TEST_SEED.
"""
import os
import random
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../test_qstream_1"))
from qs_gen import (Builder, FIR_PORT, XC_PORT, L, M, NTAPS, fm, gm,  # noqa: E402
                    route)

AMPS = (0x7FFF, 0x1FFF, 0x3FF, 0x40)
JOBS = [
    ("fir", 25), ("xc", 25), ("pair", 6), ("coef", 5), ("cfg", 5),
    ("rst0", 3), ("rst1", 3), ("route_only", 3), ("bad_route", 4),
    ("hdr_only", 3), ("mod_err", 5), ("words", 4), ("wait", 2),
]


def main():
    seed = int(sys.argv[1] if len(sys.argv) > 1 else os.environ.get("TEST_SEED", "1"), 0)
    rng = random.Random(0x0C0A7F1F ^ seed)
    b = Builder()
    s = lambda: rng.randrange(1, 1 << 32)  # noqa: E731
    noise = lambda n: b.fill(n, rng.choice(AMPS), s())  # noqa: E731

    cfg = gm.rand_cfg(rng, M)
    b.fir_coef(b.fill(NTAPS, rng.choice(AMPS[:2]), s()), rng.randint(12, 18))
    b.xc_cfg(b.cfg_words(*cfg), M, 0)
    xc_perm = True

    names = [j for j, _ in JOBS]
    weights = [w for _, w in JOBS]
    njobs = rng.randint(70, 110)
    burst_at = rng.randrange(njobs)
    peaks = 0
    for i in range(njobs):
        if i == burst_at:
            b.burst(rng.randint(260, 300), rng.randint(1, 4), rng.choice(AMPS), s())
        job = rng.choices(names, weights)[0]
        if job == "fir":
            n = rng.randint(1, 48)
            b.data(FIR_PORT, noise(n), n)
        elif job == "xc":
            n = rng.randint(1, 64)
            b.data(XC_PORT, noise(n), n)
        elif job == "pair" and xc_perm:
            amp = rng.choice((0x40, 0x100, 0x400))
            off = b.pair(cfg[0], cfg[1], amp)
            if rng.random() < 0.5:
                b.data(XC_PORT, off, 2 * L)
            else:
                cut = rng.randint(1, 2 * L - 1)
                b.data(XC_PORT, off, cut)
                b.data(XC_PORT, off + cut, 2 * L - cut)
            if b.xc.mode == 0 and b.xc.shift == M:
                # Ra[n-L] + Rb[n] at the end of [a, b] = 2*L*amp >> M
                assert gm.unpack(b.out[-1]) == (2 * amp, 0)
                peaks += 1
            n = rng.randint(1, 20)
            b.data(XC_PORT, noise(n), n)
        elif job == "coef":
            b.fir_coef(b.fill(NTAPS, rng.choice(AMPS), s()), rng.randint(10, 20))
        elif job == "cfg":
            xc_perm = rng.random() < 0.8
            cfg = gm.rand_cfg(rng, M, perm=xc_perm)
            if xc_perm and rng.random() < 0.5:
                shift, mode = M, 0
            else:
                shift, mode = rng.randint(0, 16), rng.randrange(3)
            b.xc_cfg(b.cfg_words(*cfg), shift, mode)
        elif job == "rst0":
            b.reset(FIR_PORT)
        elif job == "rst1":
            b.reset(XC_PORT)
        elif job == "route_only":
            b.send_words(rng.randrange(2), 0, 0)
        elif job == "bad_route":
            rw = rng.choice((route(2), route(rng.randint(3, 15)), 0xDEAD0000,
                             route(rng.randrange(2)) | (rng.randint(1, 0xFFF) << 4)))
            n = rng.randint(0, 6)
            off = b.words([rw])
            if n:
                noise(n)
            b.raw(off, 1 + n)
        elif job == "hdr_only":
            if rng.randrange(2):
                b.send_words(FIR_PORT, b.words([fm.header(fm.OP_DATA)]), 1)
            else:
                b.send_words(XC_PORT, b.words([gm.header(gm.OP_DATA)]), 1)
        elif job == "mod_err":
            kind = rng.randrange(6)
            if kind == 0:       # FIR bad header
                w = [0xBADBAD00, 1, 2]
                port = FIR_PORT
            elif kind == 1:     # FIR short coefficient load
                w = [fm.header(fm.OP_LOAD_COEFFS, 15)] + [1] * rng.randint(0, NTAPS - 1)
                port = FIR_PORT
            elif kind == 2:     # correlator reset with payload
                w = [gm.header(gm.OP_RESET), 3]
                port = XC_PORT
            elif kind == 3:     # correlator config of the wrong length
                w = [gm.header(gm.OP_LOAD_CFG, 4)] + [0] * rng.choice((1, M - 1, M + 1))
                port = XC_PORT
            elif kind == 4:     # correlator config word out of range
                w = [gm.header(gm.OP_LOAD_CFG, 4)] + [gm.cfg_word(M, 0)] * M
                port = XC_PORT
            else:               # non-zero mode on a DATA header
                w = [gm.header(gm.OP_DATA, mode=2), 5]
                port = XC_PORT
            b.send_words(port, b.words(w), len(w))
        elif job == "words":
            port = rng.randrange(2)
            n = rng.randint(1, 12)
            hdr = fm.header(fm.OP_DATA) if port == FIR_PORT else gm.header(gm.OP_DATA)
            off = b.words([hdr])
            noise(n)
            assert len(b.send_words(port, off, 1 + n)) == n
        elif job == "wait":
            b.wait()

    assert b.rx_count[FIR_PORT] > 256, "tag sequence must wrap"
    exp = b.write(HERE, "TEST_SEED %d" % seed)
    print("gen_vectors: TEST_SEED %d: %d ops, %d in_v words, %d expected words, "
          "fir/xc packets %d/%d, peaks %d, fir err %d xc err %d, %s"
          % (seed, len(b.ops), len(b.mem), len(exp), b.rx_count[0], b.rx_count[1],
             peaks, b.fir.err, b.xc.err, b.stats))


if __name__ == "__main__":
    sys.exit(main())

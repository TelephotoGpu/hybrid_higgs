#!/usr/bin/env python3
"""Generate fir_filter module-harness vectors from the bit-exact model.

usage: gen_vectors.py <outdir> <seed> <ntaps>

Writes:
  in.txt    one input beat per line: data last clear_before expected_err_after
  exp.txt   one expected output beat per line: data last
  vpat.txt  per-cycle input 'offer' bits (source may start a new beat)
  rpat.txt  per-cycle output ready bits
  meta.txt  n_in n_out npat mode
"""
import os
import random
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "../../../../../libs/q-engine/hdl/fir/model"))
import fir_model as fm  # noqa: E402


def coef_set(rng, ntaps):
    style = rng.choice(["rand", "small", "full", "impulse", "real"])
    if style == "rand":
        return [fm.rand_word(rng) for _ in range(ntaps)], rng.randint(12, 20)
    if style == "small":
        return [fm.rand_word(rng, 0x0FFF) for _ in range(ntaps)], 15
    if style == "full":  # drives saturation hard
        return [rng.choice([fm.pack(0x7FFF, 0x7FFF), fm.pack(-0x8000, -0x8000),
                            fm.pack(-0x8000, 0x7FFF)]) for _ in range(ntaps)], rng.randint(0, 16)
    if style == "impulse":
        c = [0] * ntaps
        c[rng.randrange(ntaps)] = fm.pack(0x7FFF, 0)
        return c, 15
    return [fm.pack(rng.randint(-0x8000, 0x7FFF), 0) for _ in range(ntaps)], rng.randint(0, 31)


def data_words(rng, n):
    style = rng.choice(["rand", "rand", "full", "tone"])
    if style == "full":
        return [rng.choice([fm.pack(0x7FFF, -0x8000), fm.pack(-0x8000, -0x8000),
                            fm.pack(0x7FFF, 0x7FFF)]) for _ in range(n)]
    if style == "tone":
        a, b = rng.randint(-0x4000, 0x4000), rng.randint(-0x4000, 0x4000)
        return [fm.pack(a if i % 2 else -a, b if i % 3 else -b) for i in range(n)]
    return [fm.rand_word(rng) for _ in range(n)]


def build_packets(rng, ntaps, npk):
    """Return list of (beats, clear_before)."""
    pk = []
    pk.append((fm.pkt_coef(*coef_set(rng, ntaps)), False))
    pk.append((fm.pkt_data(data_words(rng, 3 * ntaps)), False))
    kinds = (["data"] * 8 + ["coef"] * 3 + ["reset"] * 2 + ["data1"] * 2 +
             ["data0", "bad_magic", "bad_op", "bad_rsv_lo", "bad_rsv_hi",
              "bad_single", "coef_short", "coef_long", "coef_hdr_only",
              "reset_payload", "clear"])
    for _ in range(npk):
        k = rng.choice(kinds)
        clr = False
        if k == "data":
            b = fm.pkt_data(data_words(rng, rng.randint(1, 4 * ntaps + 8)))
        elif k == "data1":
            b = fm.pkt_data(data_words(rng, 1))
        elif k == "data0":
            b = fm.pkt_data([])
        elif k == "coef":
            b = fm.pkt_coef(*coef_set(rng, ntaps))
        elif k == "reset":
            b = fm.pkt_reset()
        elif k == "bad_magic":
            b = fm.pkt_raw([fm.header(fm.OP_DATA, magic=fm.MAGIC ^ (1 << rng.randrange(16)))] +
                           data_words(rng, rng.randint(1, 10)))
        elif k == "bad_op":
            b = fm.pkt_raw([fm.header(rng.choice([0] + list(range(4, 16))))] +
                           data_words(rng, rng.randint(0, 10)))
        elif k == "bad_rsv_lo":
            b = fm.pkt_raw([fm.header(fm.OP_DATA, reserved=0x10 << rng.randrange(4))] +
                           data_words(rng, rng.randint(1, 5)))
        elif k == "bad_rsv_hi":
            b = fm.pkt_raw([fm.header(fm.OP_LOAD_COEFFS, reserved=0x2000 << rng.randrange(3))] +
                           [fm.rand_word(rng) for _ in range(ntaps)])
        elif k == "bad_single":
            b = fm.pkt_raw([rng.getrandbits(32) & 0x0FFFFFFF])
        elif k == "coef_short":
            c, s = coef_set(rng, ntaps)
            b = fm.pkt_coef(c[:rng.randint(1, ntaps - 1)] if ntaps > 1 else [], s)
        elif k == "coef_long":
            c, s = coef_set(rng, ntaps)
            b = fm.pkt_coef(c + [fm.rand_word(rng) for _ in range(rng.randint(1, 5))], s)
        elif k == "coef_hdr_only":
            b = fm.pkt_coef([], rng.randint(0, 31))
        elif k == "reset_payload":
            b = fm.pkt_reset([fm.rand_word(rng) for _ in range(rng.randint(1, 6))])
        else:  # clear the sticky error bits before a normal data packet
            b = fm.pkt_data(data_words(rng, rng.randint(1, 20)))
            clr = True
        pk.append((b, clr))
    pk.append((fm.pkt_data(data_words(rng, 2 * ntaps)), False))
    return pk


def pattern(rng, n, mode):
    if mode == "full":
        return [1] * n
    if mode == "prob":
        p = rng.choice([0.1, 0.3, 0.5, 0.8, 0.95])
        return [1 if rng.random() < p else 0 for _ in range(n)]
    out = []  # bursty: long stalls and long runs
    while len(out) < n:
        out += [rng.choice([0, 1])] * rng.choice([1, 2, 3, 7, 20, 60, 150])
    return out[:n]


def main():
    outdir, seed, ntaps = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
    rng = random.Random(seed * 7919 + ntaps)
    os.makedirs(outdir, exist_ok=True)
    model = fm.FirModel(ntaps)
    packets = build_packets(rng, ntaps, 20 if seed == 0 else rng.randint(30, 60))
    ins, exp = [], []
    for beats, clr in packets:
        if clr:
            model.err = 0
        for j, (w, l) in enumerate(beats):
            r = model.push(w, l)
            if r is not None:
                exp.append(r)
            ins.append((w, l, 1 if (clr and j == 0) else 0, model.err))
    # seed 0: full throughput on both sides; otherwise random modes per side
    if seed == 0:
        vmode = rmode = "full"
    else:
        vmode = rng.choice(["full", "prob", "burst"])
        rmode = rng.choice(["full", "prob", "burst", "burst"])
    npat = 4 * (len(ins) + len(exp)) + 2000
    vp, rp = pattern(rng, npat, vmode), pattern(rng, npat, rmode)
    with open(os.path.join(outdir, "in.txt"), "w") as f:
        for w, l, c, e in ins:
            f.write("%08x %d %d %d\n" % (w, l, c, e))
    with open(os.path.join(outdir, "exp.txt"), "w") as f:
        for w, l in exp:
            f.write("%08x %d\n" % (w, l))
    with open(os.path.join(outdir, "vpat.txt"), "w") as f:
        f.write("".join("%d\n" % b for b in vp))
    with open(os.path.join(outdir, "rpat.txt"), "w") as f:
        f.write("".join("%d\n" % b for b in rp))
    with open(os.path.join(outdir, "meta.txt"), "w") as f:
        f.write("%d %d %d\n" % (len(ins), len(exp), npat))
    print("seed %d ntaps %d: %d in beats, %d out beats, %d packets, final err %d, %s/%s"
          % (seed, ntaps, len(ins), len(exp), len(packets), model.err, vmode, rmode))


if __name__ == "__main__":
    main()

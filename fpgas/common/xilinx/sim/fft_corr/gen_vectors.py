#!/usr/bin/env python3
"""Generate fft_corr module-harness vectors from the bit-exact model.

usage: gen_vectors.py <outdir> <seed> <N>

Writes:
  in.txt    one input beat per line: data last clear_before err_after tput
            (tput = 1 on beats of the seed-0 throughput packet)
  exp.txt   one expected output beat per line: data last
  vpat.txt  per-cycle input 'offer' bits (source may start a new beat)
  rpat.txt  per-cycle output ready bits
  meta.txt  n_in n_out npat

Seed 0 is the throughput scenario (always valid/ready, one long DATA packet
after a LOAD_REF); every other seed is a random mix of all packet kinds,
error cases and valid/ready patterns.
"""
import os
import random
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "../../../../../libs/q-engine/hdl/xcorr/model"))
import fft_corr_model as fm  # noqa: E402


def rand_taps(rng, n, r=None):
    r = r or rng.choice([1, 2, rng.randint(1, 16), rng.randint(1, n), n, n])
    amp = rng.choice([0x7FFF, 0x7FFF, 0x2000, 300, 20])
    style = rng.choice(["rand", "rand", "pm", "impulse"])
    if style == "pm":        # +-amp BPSK/QPSK style taps
        return [fm.pack(rng.choice([amp, -amp]), rng.choice([amp, -amp, 0])) for _ in range(r)]
    if style == "impulse":
        t = [0] * r
        t[rng.randrange(r)] = fm.pack(rng.choice([amp, -amp]), rng.choice([0, amp]))
        return t
    return [fm.rand_word(rng, amp) for _ in range(r)]


def data_words(rng, n, ref):
    style = rng.choice(["rand", "rand", "full", "sparse", "ref", "ref", "small"])
    if style == "full":
        return [rng.choice([fm.pack(0x7FFF, -0x8000), fm.pack(-0x8000, -0x8000),
                            fm.pack(0x7FFF, 0x7FFF)]) for _ in range(n)]
    if style == "sparse":
        return [fm.rand_word(rng) if rng.random() < 0.05 else 0 for _ in range(n)]
    if style == "small":
        return [fm.rand_word(rng, 50) for _ in range(n)]
    if style == "ref":
        # copies of the reference plus noise at random offsets (correlation peaks)
        out = []
        while len(out) < n:
            out += [fm.rand_word(rng, 30) for _ in range(rng.randint(0, 40))]
            for w in ref:
                a, b = fm.unpack(w)
                out.append(fm.pack(fm.sat(a + rng.randint(-40, 40)), fm.sat(b + rng.randint(-40, 40))))
        return out[:n]
    return [fm.rand_word(rng) for _ in range(n)]


def data_hdr(rng, model):
    mode = rng.choice([0, 0, 0, 1])
    g = model.g
    if mode == 0:
        sh = rng.choice([g, g + 1, g + 4, g + 8, g + 12, g + 15, rng.randint(0, 63)])
    else:
        sh = rng.choice([2 * g, 2 * g + 8, 2 * g + 16, 2 * g + 24, rng.randint(0, 63)])
    return max(0, min(63, sh)), mode


def build_packets(rng, n, npk, model):
    """Yield (beats, clear_before) lazily so data headers can follow model.g."""
    b = n + 1
    kinds = (["data"] * 12 + ["ref"] * 3 + ["reset"] * 2 + ["data1"] * 3 +
             ["data0", "bad_magic", "bad_op", "bad_rsv", "bad_mode_data", "bad_nondata",
              "bad_single", "ref_long", "ref_hdr_only", "reset_payload", "clear", "datab"])
    if n == 256:
        kinds.append("ref_hsat")
    ref = [fm.pack(0x7FFF, 0)]
    yield fm.pkt_ref(rand_taps(rng, n)), False
    for _ in range(npk):
        k = rng.choice(kinds)
        clr = False
        if k in ("data", "data1", "clear", "datab"):
            ln = {"data": rng.randint(1, 3 * b + 10), "data1": 1,
                  "clear": rng.randint(1, 20), "datab": rng.choice([b - 1, b, b + 1, 2 * b])}[k]
            sh, md = data_hdr(rng, model)
            pk = fm.pkt_data(data_words(rng, ln, model.ref), sh, md)
            clr = k == "clear"
        elif k == "data0":
            sh, md = data_hdr(rng, model)
            pk = fm.pkt_data([], sh, md)
        elif k == "ref":
            pk = fm.pkt_ref(rand_taps(rng, n))
        elif k == "reset":
            pk = fm.pkt_reset()
        elif k == "bad_magic":
            pk = fm.pkt_raw([fm.header(fm.OP_DATA, magic=fm.MAGIC ^ (1 << rng.randrange(16)))] +
                            data_words(rng, rng.randint(1, 10), ref))
        elif k == "bad_op":
            pk = fm.pkt_raw([fm.header(rng.choice([0] + list(range(4, 16))))] +
                            data_words(rng, rng.randint(0, 10), ref))
        elif k == "bad_rsv":
            pk = fm.pkt_raw([fm.header(rng.choice([1, 2, 3]), reserved=rng.choice([0x10, 0x40, 0x80]))] +
                            data_words(rng, rng.randint(0, 5), ref))
        elif k == "bad_mode_data":
            pk = fm.pkt_raw([fm.header(fm.OP_DATA, rng.randint(0, 63), rng.choice([2, 3]))] +
                            data_words(rng, rng.randint(0, 5), ref))
        elif k == "bad_nondata":
            pk = fm.pkt_raw([fm.header(rng.choice([fm.OP_LOAD_REF, fm.OP_RESET]),
                                       rng.randint(1, 63), rng.randint(0, 3))] +
                            data_words(rng, rng.randint(0, 5), ref))
        elif k == "bad_single":
            pk = fm.pkt_raw([rng.getrandbits(32) & 0x0FFFFFFF])
        elif k == "ref_hsat":
            # DC bin = sum of taps = 2^19 - 1 -> e = -2, rs(F, 2) = 2^17: H saturates
            pk = fm.pkt_ref([fm.pack(0x7FFF, 0)] * 16 + [fm.pack(15, 0)])
        elif k == "ref_long":
            pk = fm.pkt_ref(rand_taps(rng, n, n + rng.randint(1, 4)))
        elif k == "ref_hdr_only":
            pk = fm.pkt_ref([])
        else:  # reset_payload
            pk = fm.pkt_reset([fm.rand_word(rng) for _ in range(rng.randint(1, 6))])
        yield pk, clr
    sh, md = data_hdr(rng, model)
    yield fm.pkt_data(data_words(rng, 2 * b, model.ref), sh, md), False


def tput_packets(rng, n, model):
    yield fm.pkt_ref(rand_taps(rng, n, n)), False
    sh, md = data_hdr(rng, model)
    yield fm.pkt_data([fm.rand_word(rng) for _ in range(12 * (n + 1) + 7)], sh, 0), False


def pattern(rng, n, mode):
    if mode == "full":
        return [1] * n
    if mode == "prob":
        p = rng.choice([0.1, 0.3, 0.5, 0.8, 0.95])
        return [1 if rng.random() < p else 0 for _ in range(n)]
    out = []  # bursty: long stalls and long runs
    while len(out) < n:
        out += [rng.choice([0, 1])] * rng.choice([1, 2, 3, 7, 20, 60, 150, 600])
    return out[:n]


def main():
    outdir, seed, n = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
    rng = random.Random(seed * 7919 + n * 31 + 11)
    os.makedirs(outdir, exist_ok=True)
    model = fm.FftCorrModel(n)
    gen = tput_packets(rng, n, model) if seed == 0 else \
        build_packets(rng, n, rng.randint(25, 45), model)
    ins, exp = [], []
    npk = 0
    for beats, clr in gen:
        npk += 1
        if clr:
            model.err = 0
        tput = 1 if (seed == 0 and npk == 2) else 0
        for j, (w, l) in enumerate(beats):
            exp += model.push(w, l)
            ins.append((w, l, 1 if (clr and j == 0) else 0, model.err, tput))
    if seed == 0:
        vmode = rmode = "full"
    else:
        vmode = rng.choice(["full", "prob", "burst"])
        rmode = rng.choice(["full", "prob", "burst", "burst"])
    npat = min(4 * (len(ins) + len(exp)) + 3 * 2 * n * model.blocks + 2000, 1900000)
    vp, rp = pattern(rng, npat, vmode), pattern(rng, npat, rmode)
    with open(os.path.join(outdir, "in.txt"), "w") as f:
        for w, l, c, e, t in ins:
            f.write("%08x %d %d %d %d\n" % (w, l, c, e, t))
    with open(os.path.join(outdir, "exp.txt"), "w") as f:
        for w, l in exp:
            f.write("%08x %d\n" % (w, l))
    with open(os.path.join(outdir, "vpat.txt"), "w") as f:
        f.write("".join("%d\n" % v for v in vp))
    with open(os.path.join(outdir, "rpat.txt"), "w") as f:
        f.write("".join("%d\n" % v for v in rp))
    with open(os.path.join(outdir, "meta.txt"), "w") as f:
        f.write("%d %d %d\n" % (len(ins), len(exp), npat))
    sat_hits = sum(1 for w, _ in exp for v in fm.unpack(w) if v in (0x7FFF, -0x8000))
    zeros = sum(1 for w, _ in exp if w == 0)
    print("seed %d N %d: %d in, %d out, %d packets, %d blocks, %d sat lanes, %d zero, err %d, %s/%s"
          % (seed, n, len(ins), len(exp), npk, model.blocks, sat_hits, zeros, model.err, vmode, rmode))


if __name__ == "__main__":
    main()

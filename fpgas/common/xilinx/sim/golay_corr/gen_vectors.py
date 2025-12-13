#!/usr/bin/env python3
"""Generate golay_corr module-harness vectors from the bit-exact model.

usage: gen_vectors.py <outdir> <seed> <M>

Writes:
  in.txt    one input beat per line: data last clear_before err_after wait_after
            (wait_after = 1 when the beat commits a config or applies RESET,
            after which the RTL may drain its pipeline before the next beat)
  exp.txt   one expected output beat per line: data last
  vpat.txt  per-cycle input 'offer' bits (source may start a new beat)
  rpat.txt  per-cycle output ready bits
  meta.txt  n_in n_out npat
"""
import os
import random
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "../../../../../libs/q-engine/hdl/xcorr/model"))
import golay_model as gm  # noqa: E402


def cfg_set(rng, m):
    p, w = gm.rand_cfg(rng, m, perm=rng.random() < 0.7)
    mode = rng.choice([0, 0, 1, 2])
    shift = rng.choice([0, m, m, m + 1, rng.randint(0, 31)])
    return p, w, shift, mode


def data_words(rng, n, cur_cfg):
    style = rng.choice(["rand", "rand", "full", "golay", "golay", "sparse"])
    if style == "full":
        return [rng.choice([gm.pack(0x7FFF, -0x8000), gm.pack(-0x8000, -0x8000),
                            gm.pack(0x7FFF, 0x7FFF)]) for _ in range(n)]
    if style == "sparse":
        return [gm.rand_word(rng) if rng.random() < 0.05 else 0 for _ in range(n)]
    if style == "golay":
        # the configured pair plus noise, at a random offset
        a, b = gm.golay_pair(cur_cfg[0], cur_cfg[1])
        amp = rng.choice([50, 300, 2000, 0x3FFF])
        tx = gm.seq_words(a + b, amp)
        off = rng.randint(0, 20)
        seq = [0] * off + tx
        out = []
        for i in range(n):
            v = seq[i % len(seq)] if i < len(seq) else 0
            r, q = gm.unpack(v)
            nr, nq = rng.randint(-40, 40), rng.randint(-40, 40)
            out.append(gm.pack(gm.sat(r + nr), gm.sat(q + nq)))
        return out
    return [gm.rand_word(rng) for _ in range(n)]


def build_packets(rng, m, npk):
    """Return list of (beats, clear_before)."""
    L = 1 << m
    cur = list(gm.default_cfg(m))
    pk = []

    def cfg_pkt():
        p, w, sh, md = cfg_set(rng, m)
        cur[0], cur[1] = p, w
        return gm.pkt_cfg(p, w, sh, md)

    pk.append((cfg_pkt(), False))
    pk.append((gm.pkt_data(data_words(rng, 3 * L, cur)), False))
    kinds = (["data"] * 10 + ["cfg"] * 3 + ["reset"] * 2 + ["data1"] * 3 +
             ["data0", "bad_magic", "bad_op", "bad_rsv", "bad_mode_data",
              "bad_single", "cfg_short", "cfg_long", "cfg_hdr_only", "cfg_mode3",
              "cfg_badword", "cfg_badp", "reset_payload", "clear"])
    for _ in range(npk):
        k = rng.choice(kinds)
        clr = False
        if k == "data":
            b = gm.pkt_data(data_words(rng, rng.randint(1, 3 * L + 10), cur))
        elif k == "data1":
            b = gm.pkt_data(data_words(rng, 1, cur))
        elif k == "data0":
            b = gm.pkt_data([])
        elif k == "cfg":
            b = cfg_pkt()
        elif k == "reset":
            b = gm.pkt_reset()
        elif k == "bad_magic":
            b = gm.pkt_raw([gm.header(gm.OP_DATA, magic=gm.MAGIC ^ (1 << rng.randrange(16)))] +
                           data_words(rng, rng.randint(1, 10), cur))
        elif k == "bad_op":
            b = gm.pkt_raw([gm.header(rng.choice([0] + list(range(4, 16))))] +
                           data_words(rng, rng.randint(0, 10), cur))
        elif k == "bad_rsv":
            rsv = rng.choice([0x10, 0x20, 0x2000, 0x4000, 0x8000])
            b = gm.pkt_raw([gm.header(rng.choice([1, 2, 3]), reserved=rsv)] +
                           data_words(rng, rng.randint(1, m + 2), cur))
        elif k == "bad_mode_data":
            b = gm.pkt_raw([gm.header(rng.choice([gm.OP_DATA, gm.OP_RESET]),
                                      mode=rng.randint(1, 3))] +
                           data_words(rng, rng.randint(0, 5), cur))
        elif k == "bad_single":
            b = gm.pkt_raw([rng.getrandbits(32) & 0x0FFFFFFF])
        elif k == "cfg_short":
            p, w, sh, md = cfg_set(rng, m)
            n = rng.randint(1, m - 1) if m > 1 else 0
            b = gm.pkt_cfg(p[:n], w[:n], sh, md) if n else gm.pkt_cfg([], [], sh, md)
        elif k == "cfg_long":
            p, w, sh, md = cfg_set(rng, m)
            b = gm.pkt_raw([gm.header(gm.OP_LOAD_CFG, sh, md)] +
                           [gm.cfg_word(pk_, wk) for pk_, wk in zip(p, w)] +
                           [rng.getrandbits(32) for _ in range(rng.randint(1, 4))])
        elif k == "cfg_hdr_only":
            b = gm.pkt_cfg([], [], rng.randint(0, 31), rng.randint(0, 2))
        elif k == "cfg_mode3":
            p, w, sh, _ = cfg_set(rng, m)
            b = gm.pkt_cfg(p, w, sh, 3)
        elif k == "cfg_badword":
            p, w, sh, md = cfg_set(rng, m)
            words = [gm.cfg_word(pk_, wk) for pk_, wk in zip(p, w)]
            words[rng.randrange(m)] |= 1 << rng.randrange(6, 32)
            b = gm.pkt_raw([gm.header(gm.OP_LOAD_CFG, sh, md)] + words)
        elif k == "cfg_badp":
            p, w, sh, md = cfg_set(rng, m)
            p[rng.randrange(m)] = rng.randint(m, 15)
            b = gm.pkt_cfg(p, w, sh, md)
        elif k == "reset_payload":
            b = gm.pkt_reset([gm.rand_word(rng) for _ in range(rng.randint(1, 6))])
        else:  # clear the sticky error bits before a normal data packet
            b = gm.pkt_data(data_words(rng, rng.randint(1, 20), cur))
            clr = True
        pk.append((b, clr))
    pk.append((gm.pkt_data(data_words(rng, 2 * L, cur)), False))
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
    outdir, seed, m = sys.argv[1], int(sys.argv[2]), int(sys.argv[3])
    rng = random.Random(seed * 7919 + m * 31 + 5)
    os.makedirs(outdir, exist_ok=True)
    model = gm.GolayModel(m)
    packets = build_packets(rng, m, 25 if seed == 0 else rng.randint(30, 60))
    ins, exp = [], []
    n_wait = 0
    for beats, clr in packets:
        if clr:
            model.err = 0
        for j, (w, l) in enumerate(beats):
            st = model._state
            r = model.push(w, l)
            if r is not None:
                exp.append(r)
            wait = 0
            if st == "HDR" and gm.header_valid(w) and (w & 0xF) == gm.OP_RESET:
                wait = 1
            elif (st == "CFG" and l and len(model._shadow) == m
                  and not model._shadow_bad):
                wait = 1   # complete, valid LOAD_CFG: committed
            n_wait += wait
            ins.append((w, l, 1 if (clr and j == 0) else 0, model.err, wait))
    if seed == 0:
        vmode = rmode = "full"
    else:
        vmode = rng.choice(["full", "prob", "burst"])
        rmode = rng.choice(["full", "prob", "burst", "burst"])
    npat = 4 * (len(ins) + len(exp)) + 2000
    vp, rp = pattern(rng, npat, vmode), pattern(rng, npat, rmode)
    with open(os.path.join(outdir, "in.txt"), "w") as f:
        for w, l, c, e, wt in ins:
            f.write("%08x %d %d %d %d\n" % (w, l, c, e, wt))
    with open(os.path.join(outdir, "exp.txt"), "w") as f:
        for w, l in exp:
            f.write("%08x %d\n" % (w, l))
    with open(os.path.join(outdir, "vpat.txt"), "w") as f:
        f.write("".join("%d\n" % b for b in vp))
    with open(os.path.join(outdir, "rpat.txt"), "w") as f:
        f.write("".join("%d\n" % b for b in rp))
    with open(os.path.join(outdir, "meta.txt"), "w") as f:
        f.write("%d %d %d\n" % (len(ins), len(exp), npat))
    sat_hits = sum(1 for w, _ in exp for v in gm.unpack(w) if v in (0x7FFF, -0x8000))
    print("seed %d M %d: %d in, %d out, %d packets, %d commits/resets, %d sat lanes, err %d, %s/%s"
          % (seed, m, len(ins), len(exp), len(packets), n_wait, sat_hits, model.err, vmode, rmode))


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Simple numpy fixed-point model of the Higgs image-kernel datapath.

This is the "prototype here" model. Every operation is a few lines of whole-
image numpy: pad the border, add up shifted copies of the image times the
integer kernel taps, then requantise (round, shift, offset, saturate to u8).
It is written independently of img_model.py (the pure-python, beat-level
reference), and ``selftest`` checks that the two agree bit for bit.

Images are numpy arrays:
  * gray: uint8, shape (H, W)
  * colour: uint8, shape (H, W, 3), channels R, G, B (stream byte 0, 1, 2)

Prototyping a new kernel: call ``mac()`` with your s8 kernel(s), then run the
same kernel on the hardware with the C API (``IMG_OP_CUSTOM``,
libs/riscv-baseband/c/inc/image_kernel.h) and compare.

The fixed-point contract is doc/kernel/NOTES.md section 5; the stream format
is section 7. Requires numpy (see requirements.txt):

  python3 -m venv libs/datapath/image/.venv
  libs/datapath/image/.venv/bin/pip install -r libs/datapath/image/requirements.txt

CLI (python = libs/datapath/image/.venv/bin/python):
  simple_model.py selftest
  simple_model.py run    IN.hex OUT.hex          expected stream for IN.hex
  simple_model.py check  IN.hex GOT.hex          model(IN.hex) vs Verilog output
  simple_model.py filter OP IN.pgm|ppm OUT.pgm|ppm [--border zero|replicate]
                         [--thr N]                one op on a netpbm image
"""

import argparse
import sys

import numpy as np

# --------------------------------------------------------------------------
# datapath arithmetic (NOTES section 5)
# --------------------------------------------------------------------------
ACC_BITS = 24          # A and B accumulators wrap at 24 bits (signed)


def wrap(acc, bits=ACC_BITS):
    """Two's-complement wrap. Stream kernels never reach it (81 taps of
    255 * -128 still fit), but big custom kernels can."""
    m = 1 << bits
    return ((acc + (m >> 1)) & (m - 1)) - (m >> 1)


def pad(img, r, border):
    """Pad H and W by r on each side: 'zero' or 'replicate' (edge)."""
    widths = [(r, r), (r, r)] + [(0, 0)] * (img.ndim - 2)
    return np.pad(img, widths, mode="constant" if border == "zero" else "edge")


def windows(img, n, border):
    """Yield (i, j, shifted) for every tap of an n x n window, row-major.
    ``shifted[y, x]`` is the pixel at (y + i - r, x + j - r)."""
    r = (n - 1) // 2
    p = pad(img.astype(np.int64), r, border)
    h, w = img.shape[:2]
    for i in range(n):
        for j in range(n):
            yield i, j, p[i:i + h, j:j + w]


def correlate(img, k, border):
    """Sum of k[i, j] * pixel over the window (no kernel flip), int64.
    ``k`` is n x n; for per-channel kernels pass shape (n, n, C)."""
    k = np.asarray(k, dtype=np.int64)
    if k.min() < -128 or k.max() > 127:
        raise ValueError("kernel taps must be s8 (-128..127)")
    acc = np.zeros(img.shape, dtype=np.int64)
    for i, j, win in windows(img, k.shape[0], border):
        acc += k[i, j] * win
    return wrap(acc)


def requant(v, shift=0, rnd=False, offset=0):
    """(v [+ 2^(shift-1)]) >> shift, + offset, saturate to u8."""
    if rnd and shift:
        v = v + (1 << (shift - 1))
    return np.clip((v >> shift) + offset, 0, 255).astype(np.uint8)


def threshold(v, thr):
    return np.where(v >= thr, 255, 0).astype(np.uint8)


# --------------------------------------------------------------------------
# public building blocks (one datapath stage each)
# --------------------------------------------------------------------------
def mac(img, ka, kb=None, comb="a", shift=0, rnd=False, offset=0,
        border="replicate", thr=None):
    """Multiply-accumulate stage.

    comb: 'a' -> A, 'abs' -> |A|, 'l1' -> |A|+|B|, 'maxabs' -> max(|A|,|B|).
    thr: if given, output 255 where the result >= thr, else 0.
    """
    a = correlate(img, ka, border)
    b = correlate(img, kb, border) if kb is not None else np.zeros_like(a)
    v = {"a": lambda: a,
         "abs": lambda: np.abs(a),
         "l1": lambda: np.abs(a) + np.abs(b),
         "maxabs": lambda: np.maximum(np.abs(a), np.abs(b))}[comb]()
    out = requant(v, shift, rnd, offset)
    return out if thr is None else threshold(out, thr)


def minmax(img, n, kind, border="replicate", thr=None):
    """n x n erode ('min') or dilate ('max'). ZERO borders count as 0."""
    wins = [w for _, _, w in windows(img, n, border)]
    out = (np.min if kind == "min" else np.max)(wins, axis=0).astype(np.uint8)
    return out if thr is None else threshold(out, thr)


def peaks(img, thr, border="replicate"):
    """3x3 non-maximum suppression: keep a pixel if it equals its 3x3 max
    (plateaus survive) and is >= thr, else 0."""
    keep = (minmax(img, 3, "max", border) == img) & (img >= thr)
    return np.where(keep, img, 0).astype(np.uint8)


# --------------------------------------------------------------------------
# the stream ops (NOTES sections 2 and 3)
# --------------------------------------------------------------------------
def binomial(n):
    row = {3: [1, 2, 1], 5: [1, 4, 6, 4, 1], 7: [1, 3, 7, 10, 7, 3, 1]}[n]
    return np.outer(row, row)


GX = np.array([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]])
PX = np.array([[-1, 0, 1]] * 3)
SX = np.array([[-3, 0, 3], [-10, 0, 10], [-3, 0, 3]])


def full(n, c):
    return np.full((n, n), c)


def sobel(img, border, thr=None):
    return mac(img, GX, GX.T, "l1", 2, True, border=border, thr=thr)


def chan_gauss(img, border):
    """Per-channel kernels: R = 2*G3 (x2 gain), G = G3, B = 0."""
    if img.ndim != 3:
        raise ValueError("CHAN_GAUSS needs a colour image")
    g3 = binomial(3)
    k = np.stack([2 * g3, g3, 0 * g3], axis=-1)
    return mac(img, k, shift=4, rnd=True, border=border)


# name -> (op id, fn(img, border, thr))
OPS = {
    "COPY":       (0, lambda im, b, t: im.copy()),
    "GAUSS3":     (1, lambda im, b, t: mac(im, binomial(3), shift=4, rnd=True, border=b)),
    "GAUSS5":     (2, lambda im, b, t: mac(im, binomial(5), shift=8, rnd=True, border=b)),
    "GAUSS7":     (3, lambda im, b, t: mac(im, binomial(7), shift=10, rnd=True, border=b)),
    "BOX3":       (4, lambda im, b, t: mac(im, full(3, 114), shift=10, rnd=True, border=b)),
    "BOX5":       (5, lambda im, b, t: mac(im, full(5, 82), shift=11, rnd=True, border=b)),
    "SHARPEN":    (6, lambda im, b, t: mac(im, [[0, -1, 0], [-1, 5, -1], [0, -1, 0]], border=b)),
    "UNSHARP":    (7, lambda im, b, t: mac(im, [[-1, -2, -1], [-2, 28, -2], [-1, -2, -1]],
                                           shift=4, rnd=True, border=b)),
    "LAPLACE":    (8, lambda im, b, t: mac(im, [[0, 1, 0], [1, -4, 1], [0, 1, 0]], comb="abs", border=b)),
    "SOBEL":      (9, lambda im, b, t: sobel(im, b)),
    "SOBEL_X":    (10, lambda im, b, t: mac(im, GX, comb="abs", shift=2, rnd=True, border=b)),
    "PREWITT":    (11, lambda im, b, t: mac(im, PX, PX.T, "l1", 2, True, border=b)),
    "SCHARR":     (12, lambda im, b, t: mac(im, SX, SX.T, "l1", 4, True, border=b)),
    "EMBOSS":     (13, lambda im, b, t: mac(im, [[-2, -1, 0], [-1, 1, 1], [0, 1, 2]], offset=128, border=b)),
    "ERODE3":     (14, lambda im, b, t: minmax(im, 3, "min", b)),
    "DILATE3":    (15, lambda im, b, t: minmax(im, 3, "max", b)),
    "CHAN_GAUSS": (17, lambda im, b, t: chan_gauss(im, b)),
    "EDGES":      (32, lambda im, b, t: sobel(im, b, thr=t)),
    "PEAKS":      (33, lambda im, b, t: peaks(sobel(im, b), t, b)),
}
OP_BY_ID = {op_id: name for name, (op_id, _) in OPS.items()}


def apply_op(name, img, border="replicate", thr=0):
    return OPS[name][1](img, border, thr)


# --------------------------------------------------------------------------
# feature statistics trailer (NOTES section 3)
# --------------------------------------------------------------------------
TILE = 16


def stats(img, roi_thr):
    """Return the trailer body: max v/x/y, min v/x/y, nonzero count, sum,
    ROI tile count, ROI box x0 y0 x1 y1, then per-16x16-tile nonzero counts."""
    v = img if img.ndim == 2 else img.max(axis=2)
    h, w = v.shape
    ymax, xmax = np.unravel_index(np.argmax(v), v.shape)   # first in raster order
    ymin, xmin = np.unravel_index(np.argmin(v), v.shape)
    th, tw = -(-h // TILE), -(-w // TILE)
    nz = np.zeros((th * TILE, tw * TILE), dtype=np.int64)
    nz[:h, :w] = v != 0
    tiles = nz.reshape(th, TILE, tw, TILE).sum(axis=(1, 3))
    roi_ty, roi_tx = np.nonzero((tiles > 0) & (tiles >= roi_thr))
    if len(roi_tx):
        box = [roi_tx.min() * TILE, roi_ty.min() * TILE,
               min(w, (roi_tx.max() + 1) * TILE) - 1, min(h, (roi_ty.max() + 1) * TILE) - 1]
    else:
        box = [0xFFFF] * 4
    body = [v.max(), xmax, ymax, v.min(), xmin, ymin, np.count_nonzero(v),
            int(v.sum(dtype=np.int64)) & 0xFFFFFFFF, len(roi_tx)] + box + tiles.ravel().tolist()
    return [int(x) for x in body]


# --------------------------------------------------------------------------
# cs22 stream (NOTES section 7)
# --------------------------------------------------------------------------
HDR_MAGIC, TRL_MAGIC, ERR_MAGIC, OP_END = 0x1A6E0000, 0x5A7A0000, 0xEE770000, 0xFF
ERR_OP, ERR_SIZE, ERR_TILES = 1, 2, 3
MAX_W, MAX_TILES = 1024, 4096


def words_to_image(words, w, h, color):
    b = np.asarray(words, dtype=np.uint32).reshape(h, w).view(np.uint8).reshape(h, w, 4)
    return b[..., :3].copy() if color else b[..., 0].copy()


def image_to_words(img):
    h, w = img.shape[:2]
    b = np.zeros((h, w, 4), dtype=np.uint8)
    if img.ndim == 2:
        b[..., 0] = img
    else:
        b[..., :3] = img
    return b.view("<u4").ravel().tolist()


def job_error(op, w, h):
    if op not in OP_BY_ID:
        return ERR_OP
    if w == 0 or h == 0 or w % 16 or w > MAX_W:
        return ERR_SIZE
    if (w // 16) * -(-h // 16) > MAX_TILES:
        return ERR_TILES
    return 0


def run_stream(words):
    """Return the expected output stream for an input stream."""
    out, i = [], 0
    while i + 3 <= len(words):
        hdr = words[i:i + 3]
        op, color, border = hdr[0] & 0xFF, hdr[0] >> 8 & 1, hdr[0] >> 9 & 1
        w, h = hdr[1] & 0xFFFF, hdr[1] >> 16
        thr, roi_thr = hdr[2] & 0xFF, hdr[2] >> 8 & 0xFF
        out += hdr
        i += 3
        if op == OP_END:
            break
        pix = words[i:i + w * h]
        i += w * h
        err = job_error(op, w, h)
        if err:
            out.append(ERR_MAGIC | err)
            continue
        img = words_to_image(pix, w, h, color)
        res = apply_op(OP_BY_ID[op], img, "replicate" if border else "zero", thr)
        body = stats(res, roi_thr)
        out += image_to_words(res) + [TRL_MAGIC | len(body)] + body
    return out


def read_hex(path):
    with open(path) as f:
        return [int(t, 16) for t in (ln.split("#")[0].strip() for ln in f) if t]


def write_hex(path, words):
    with open(path, "w") as f:
        f.writelines("%08x\n" % (v & 0xFFFFFFFF) for v in words)


def compare(exp, got):
    """Print a per-job report (img_model's) and return True on a match."""
    try:
        import img_model
        return img_model.compare_streams(exp, got)
    except ImportError:
        bad = [k for k in range(max(len(exp), len(got)))
               if k >= len(exp) or k >= len(got) or exp[k] != got[k]]
        for k in bad[:8]:
            print("word %d exp %s got %s" % (k, exp[k:k + 1], got[k:k + 1]))
        return not bad


# --------------------------------------------------------------------------
# netpbm (P5 gray / P6 colour, 8-bit) for trying real images
# --------------------------------------------------------------------------
def read_pnm(path):
    data = open(path, "rb").read()
    fields, pos = [], 0
    while len(fields) < 4:
        while data[pos:pos + 1].isspace():
            pos += 1
        if data[pos:pos + 1] == b"#":
            pos = data.index(b"\n", pos)
            continue
        end = pos
        while not data[end:end + 1].isspace():
            end += 1
        fields.append(data[pos:end])
        pos = end
    magic, w, h, maxval = fields[0], int(fields[1]), int(fields[2]), int(fields[3])
    if magic not in (b"P5", b"P6") or maxval != 255:
        raise ValueError("only 8-bit binary P5/P6 is supported")
    shape = (h, w) if magic == b"P5" else (h, w, 3)
    return np.frombuffer(data, np.uint8, count=int(np.prod(shape)), offset=pos + 1).reshape(shape)


def write_pnm(path, img):
    with open(path, "wb") as f:
        f.write(b"%s\n%d %d\n255\n" % (b"P5" if img.ndim == 2 else b"P6", img.shape[1], img.shape[0]))
        f.write(np.ascontiguousarray(img, dtype=np.uint8).tobytes())


# --------------------------------------------------------------------------
# self test: agree with img_model.py (the independent reference)
# --------------------------------------------------------------------------
def selftest():
    import img_model as ref
    fails = []

    def check(cond, msg):
        if not cond:
            fails.append(msg)
            print("FAIL:", msg)

    rng = np.random.default_rng(1)
    cases = [("scene gray", ref.scene(48, 20, ref.FMT_GRAY, 3), 0),
             ("scene rgb", ref.scene(32, 17, ref.FMT_RGBX, 4), 1),
             ("noise gray", rng.integers(0, 1 << 32, (9, 32)).astype(np.uint32).tolist(), 0),  # junk in bytes 1-3
             ("noise rgb", (rng.integers(0, 1 << 24, (7, 16))).astype(np.uint32).tolist(), 1)]
    for label, words2d, color in cases:
        h, w = len(words2d), len(words2d[0])
        img = words_to_image([v for r in words2d for v in r], w, h, color)
        fmt = ref.FMT_RGBX if color else ref.FMT_GRAY
        for name, (op_id, _) in OPS.items():
            if name == "CHAN_GAUSS" and not color:
                continue
            for border, rb in (("zero", ref.BORDER_ZERO), ("replicate", ref.BORDER_REPLICATE)):
                for thr in ((0, 60, 200) if name in ("EDGES", "PEAKS") else (0,)):
                    got = apply_op(name, img, border, thr)
                    cur = words2d
                    for st in ref.op_stages(op_id, fmt, thr):
                        cur = ref.run_stage(cur, st, rb)
                    exp = words_to_image([v for r in cur for v in r], w, h, color)
                    check(np.array_equal(got, exp), "%s %s %s thr=%d" % (label, name, border, thr))
                    for roi in (0, 5):
                        check(stats(got, roi) == ref.stats_trailer(cur, fmt, roi)[1:],
                              "stats %s %s %s roi=%d" % (label, name, border, roi))

    # the whole test_image_1 stream, including the error jobs and END
    inp, exp = ref.build_streams()
    check(run_stream(inp) == exp, "test_image_1 stream")

    # a custom kernel with both accumulators, and 24-bit wrap
    img = rng.integers(0, 256, (6, 16)).astype(np.uint8)
    ka, kb = rng.integers(-128, 128, (5, 5)), rng.integers(-128, 128, (5, 5))
    for comb, rcomb in (("a", ref.COMB_A), ("abs", ref.COMB_ABS_A),
                        ("l1", ref.COMB_L1), ("maxabs", ref.COMB_MAXABS)):
        got = mac(img, ka, kb, comb, 7, True, -20, "zero")
        st = ref.Stage(5, ka.tolist(), kb.tolist(), ref.Cfg(comb=rcomb, shift=7, rnd=True, offset=-20))
        exp = np.array(ref.run_stage(img.astype(np.uint32).tolist(), st, ref.BORDER_ZERO), np.uint8)
        check(np.array_equal(got, exp), "custom 5x5 comb=%s" % comb)
    check(wrap(np.int64(1 << 23)) == -(1 << 23) and wrap(np.int64(-1)) == -1, "wrap24")

    print("selftest: %s (%d failures)" % ("PASS" if not fails else "FAIL", len(fails)))
    return not fails


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("selftest")
    for cmd, b in (("run", "out"), ("check", "got")):
        p = sub.add_parser(cmd)
        p.add_argument("inp")
        p.add_argument(b)
    p = sub.add_parser("filter")
    p.add_argument("op", choices=sorted(OPS))
    p.add_argument("inp")
    p.add_argument("out")
    p.add_argument("--border", choices=("zero", "replicate"), default="replicate")
    p.add_argument("--thr", type=int, default=0)
    a = ap.parse_args(argv)
    if a.cmd == "selftest":
        return 0 if selftest() else 1
    if a.cmd == "run":
        out = run_stream(read_hex(a.inp))
        write_hex(a.out, out)
        print("wrote %d words to %s" % (len(out), a.out))
        return 0
    if a.cmd == "check":
        ok = compare(run_stream(read_hex(a.inp)), read_hex(a.got))
        print("RESULT: %s" % ("PASS" if ok else "FAIL"))
        return 0 if ok else 1
    img = read_pnm(a.inp)
    res = apply_op(a.op, img, a.border, a.thr)
    write_pnm(a.out, res)
    body = stats(res, 1)
    print("%s: %dx%d max %d at (%d,%d), min %d at (%d,%d), %d nonzero" % (
        a.op, res.shape[1], res.shape[0], *body[:7]))
    return 0


if __name__ == "__main__":
    sys.exit(main())

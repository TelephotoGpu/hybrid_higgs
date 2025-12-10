package qengine

import java.io.File
import reqack._

/** piston_dp: the datapath half of piston, one module per datapath with the
  * same ports (t_k8/t_k9/t_k14 in, i_k1 out). The build picks one file
  * (piston_dp_fft.v or piston_dp_img.v) with HIGGS_DATAPATH.
  *
  * The graphs are ports of libs/datapath/lib/{datapath,cmul,radix4,
  * img-datapath}.js and keep their construction order: deconcat outputs
  * (cfg), slice16 outputs and concat inputs are ordered by creation, which
  * fixes the bit layout of k14 and of the k8/k9/k1 lanes. */
object PistonDp {
  val kw = 32 * 32 / 2 // k8/k9/k14/k1 width (32 lanes x 32 bits / div)

  /** re/im edge pair */
  case class Cx(re: Edge, im: Edge)

  /** Common frame: k8/k9/k14 targets (wires; the buffers are in piston) and
    * the k1 initiator. body returns the k1 source edge. */
  def frame(body: (Graph, Edge, Edge, Edge) => Edge): Graph = {
    val g = new Graph("piston_dp")
    val w0 = ESpec(kw, 0)
    val k8 = g("k8")(w0)
    val k9 = g("k9")(w0)
    val k14 = g("k14")(w0)
    body(g, k8, k9, k14)(g("k1"))
    g
  }

  val s2 = ESpec(2)
  val s18 = ESpec(18)
  val s36 = ESpec(36)

  /** cmul.js: (a + jb)(c + jd) with m2c operand muxes and two muladdsub.
    * With recip, m2c_ac and m2c_cd also take 1/c (Reciprocal) on code 3,
    * which was constant 1 and unused: the cmul config with ac = cd = 3
    * computes (a + jb)(1/c + jd), i.e. (a + jb)/c for d = 0. The 1/c chain
    * is the last target of c, so existing names and the k14 layout stay. */
  def cmul(g: Graph, pre: String, x: Cx, y: Cx, cfg: (ESpec, Node) => Unit, recip: Boolean = false): Cx = {
    val ops = Map('a' -> x.re, 'b' -> x.im, 'c' -> y.re, 'd' -> y.im)
    val rc = if (recip) Some(Reciprocal.chain(g, pre)) else None
    val x0 = Seq(Seq(Seq("a", "ac"), Seq("bc", "bd")), Seq(Seq("cb", "cd"), Seq("d", "da")))
    val x1 = x0.map(_.map(_.map { pair =>
      if (pair.length == 1) ops(pair.head)
      else {
        val r = rc.filter(_ => pair == "ac" || pair == "cd")
        val n = g(if (r.isDefined) "m2c_r" else "m2c", s"${pre}_m2c_$pair")
        pair.foreach(ch => ops(ch)(n))
        r.foreach(_._2(n))
        cfg(s2, n)
        n(s18)
      }
    }))
    rc.foreach { case (norm, _) => y.re(norm) }
    val x2 = x1.zip(Seq("re", "im")).map { case (e0, ri) =>
      val n = g("concat", s"${pre}_cat_$ri")
      e0.foreach(_.foreach(_(n)))
      n(ESpec(72, 1.5))
    }
    val x3 = x2.zip(Seq("re", "im")).map { case (e, ri) =>
      val n = g("muladdsub", s"${pre}_mas_$ri")
      e(n)
      cfg(s2, n)
      n(s36)
    }
    Cx(x3(0), x3(1))
  }

  /** radix4.js: two add/sub stages, the -j twiddle, and an m2c bypass that
    * selects the butterfly input or output per lane. */
  def radix4(g: Graph, pre: String, t: Seq[Cx], cfg: (ESpec, Node) => Unit): Seq[Cx] = {
    val ltype = ESpec(36, 1)
    val pairs = Seq(Seq(0, 2), Seq(1, 3), Seq(0, 2), Seq(1, 3))
    def stage(st: String, ops: Seq[(String, String)], in: Seq[Cx], spec: ESpec): Seq[Cx] = {
      val nodes = ops.zipWithIndex.map { case ((re, im), i) =>
        (g(re, s"${pre}_${st}${i}_re"), g(im, s"${pre}_${st}${i}_im"))
      }
      pairs.zipWithIndex.foreach { case (p, ei) =>
        p.foreach { k => in(k).re(nodes(ei)._1); in(k).im(nodes(ei)._2) }
      }
      nodes.map { case (re, im) => Cx(re(spec), im(spec)) }
    }
    val a = stage("a", Seq("add" -> "add", "add" -> "add", "sub" -> "sub", "sub" -> "sub"), t, ESpec(36, 1.5))
    val b = Seq(a(0), a(2), a(1), Cx(a(3).im, a(3).re))
    val c = stage("c", Seq("add" -> "add", "add" -> "sub", "sub" -> "sub", "sub" -> "add"), b, ESpec(36))
    c.indices.map { i =>
      val re = g("m2c", s"${pre}_byp${i}_re")
      val im = g("m2c", s"${pre}_byp${i}_im")
      t(i).re(re); c(i).re(re)
      t(i).im(im); c(i).im(im)
      cfg(s2, re)
      cfg(s2, im)
      Cx(re(ltype), im(ltype))
    }
  }

  /** datapath.js: 16-slice, 8-section radix-4 FFT datapath, plus a 1/c unit
    * per cmul (recip, see cmul). */
  def fft(recip: Boolean = true): Graph = frame { (g, k8, k9, k14) =>
    val radix = 4
    val nSections = 8
    val iport8 = g("funnel", "k8_funnel")
    val iport9 = g("funnel", "k9_funnel")
    val oport1 = g("defunnel", "k1_defunnel")
    val cfg = g("deconcat", "cfg")
    // k14 config field for node n (a deconcat output, LSB first by creation)
    val cfgTo = (spec: ESpec, n: Node) => { cfg(spec, name = s"cfg_${n.name}")(n, "cfg"); () }

    k8(iport8)
    k9(iport9)
    val k1 = oport1(ESpec(kw, 1.5))

    val cmuls = (0 until nSections / radix).map { s =>
      val c8 = g("slice16", s"s${s}_k8_slice")
      val c9 = g("slice16", s"s${s}_k9_slice")
      iport8(ESpec(radix * 2 * 16, 1))(c8)
      iport9(ESpec(radix * 2 * 16, 1))(c9)
      val ins = (0 until radix).map(_ => (Cx(c8(s18), c8(s18)), Cx(c9(s18), c9(s18))))
      ins.zipWithIndex.map { case ((x, y), c) => cmul(g, s"s${s}_cmul$c", x, y, cfgTo, recip) }
    }
    val r4 = cmuls.zipWithIndex.map { case (t, s) => radix4(g, s"s${s}_r4", t, cfgTo) }
    r4.zipWithIndex.foreach { case (e, s) =>
      val cat = g("concat", s"s${s}_k1_cat")
      cat(ESpec(radix * 2 * 16))(oport1)
      val outs = e.zipWithIndex.map { case (ee, i) =>
        val bsRe = g("bs", s"s${s}_bs${i}_re")
        val bsIm = g("bs", s"s${s}_bs${i}_im")
        val rsRe = g("round_sat", s"s${s}_rsat${i}_re")
        val rsIm = g("round_sat", s"s${s}_rsat${i}_im")
        ee.re(bsRe)
        ee.im(bsIm)
        cfgTo(ESpec(8), bsRe)
        cfgTo(ESpec(8), bsIm)
        bsRe(ESpec(20, 1.5))(rsRe)
        bsIm(ESpec(20, 1.5))(rsIm)
        Cx(rsRe(ESpec(16, 1)), rsIm(ESpec(16, 1)))
      }
      outs.foreach { o => o.re(cat); o.im(cat) }
    }

    k14(cfg)
    cfgTo(ESpec(8), iport8)
    cfgTo(ESpec(8), iport9)
    cfgTo(ESpec(8), oport1)
    k1
  }

  /** img-datapath.js: the image kernel datapath is one leaf with its own
    * pipeline and handshakes. */
  def img(): Graph = frame { (g, k8, k9, k14) =>
    val n = g("img_datapath", "img")
    k8(n, "k8")
    k9(n, "k9")
    k14(n, "k14")
    n(ESpec(kw, 1.5), "k1")
  }

  val macros: Map[String, Macro] = Map(
    "funnel" -> StandardMacro("funnel", Seq(Extra("sel", 8), Extra("mode", -8))),
    "defunnel" -> StandardMacro("defunnel", Seq(Extra("enable", 8), Extra("mode", -8))),
    "deconcat" -> DeconcatMacro,
    "slice16" -> Slice16Macro,
    "m2c" -> M2cMacro,
    "muladdsub" -> MulAddSubMacro,
    "bs" -> BsMacro,
    "round_sat" -> StandardMacro("round_sat"),
    "img_datapath" -> PassThroughMacro("img_datapath")
  ) ++ Reciprocal.macros

  def leafDirs: Seq[File] = Seq(PistonPaths.pistonHdl, new File(PistonPaths.repo, "libs/datapath/image/rtl"))

  val variants: Seq[(String, () => Graph)] = Seq("fft" -> (() => fft()), "img" -> (() => img()))
}

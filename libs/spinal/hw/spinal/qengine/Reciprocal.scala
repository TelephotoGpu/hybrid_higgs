package qengine

import spinal.core._
import reqack._

/** 1/c for the FFT datapath cmul (m2c code 3 on m2c_ac and m2c_cd), see
  * doc/kernel/NOTES.md §12. Bit-exact model: libs/datapath/recip/recip_model.py.
  *
  * The d-engine reciprocal (libs/d-engine/rtl/reciprocal) in Q6.10, so the
  * result is about 2^20 / X for the low 16 bits X of the lane, with its edge
  * cases fixed: sign-magnitude for X < 0, +-32767 for |X| < 32 (d-engine
  * wrapped to 0 there) and an 18-bit sign-extended output. Three nodes with
  * EB1 edges between them (latency 3):
  *   norm: |X|, leading zeros lz, xn = |X| normalized to [0.5, 1)
  *   mul:  y0 = 1.466 - xn, u = 1.0012 - xn * y0
  *   out:  r = 4 * u * y0 renormalized by lz, saturated and signed */
object Reciprocal {
  val M = 6
  val C1 = 0x5dd // 1.466
  val C2 = 0x401 // 1.0012

  // stage payloads, LSB first: norm = {neg, sat, lz[4:0], xn[9:0]},
  // mul = {neg, sat, lz[4:0], u[10:0], y0[10:0]}
  val normW = 17
  val mulW = 29
  val outW = 18

  private def named[T <: Data](n: NodeCtx, s: String, v: T): T = v.setName(s"${n.name}_$s")

  def norm(n: NodeCtx, in: Seq[Bits]): Bits = {
    val x = named(n, "x", in.head(15 downto 0).asSInt)
    val m = named(n, "mag", x.abs)
    val lz = named(n, "lz", UInt(5 bits))
    lz := U(16, 5 bits)
    for (i <- 0 until 16) when(m(i))(lz := U(15 - i, 5 bits))
    val sat = named(n, "sat", m < 32)
    val xn = named(n, "xn", (m |<< lz) >> M)
    x.msb ## sat ## lz ## xn
  }

  def mul(n: NodeCtx, in: Seq[Bits]): Bits = {
    val p = in.head
    val xn = p(9 downto 0).asUInt
    val y0 = named(n, "y0", U(C1, 11 bits) - xn.resize(11))
    val t = named(n, "t", (xn * y0)(20 downto 10))
    val u = named(n, "u", U(C2, 11 bits) - t)
    p(16 downto 10) ## u ## y0
  }

  def out(n: NodeCtx, in: Seq[Bits]): Bits = {
    val p = in.head
    val y0 = p(10 downto 0).asUInt
    val u = p(21 downto 11).asUInt
    val lz = p(26 downto 22).asUInt
    val sat = p(27)
    val neg = p(28)
    val r = named(n, "r", (u * y0)(21 downto 10) @@ U(0, 2 bits))
    val rn = named(n, "rn", UInt(18 bits))
    when(lz <= M)(rn := (r >> (U(M, 5 bits) - lz)).resize(18))
      .otherwise(rn := r.resize(18) |<< (lz - U(M, 5 bits)))
    val mag = named(n, "rmag", Mux(sat || rn >= 0x8000, U(0x7fff, 18 bits), rn).asSInt)
    Mux(neg, -mag, mag).asBits
  }

  val macros: Map[String, Macro] = Map(
    "recip_norm" -> FuncMacro(norm),
    "recip_mul" -> FuncMacro(mul),
    "recip_out" -> FuncMacro(out),
    "m2c_r" -> new M2c(Seq(0, 1, 3))
  )

  /** The three nodes; returns the norm node (connect X to it) and the 1/X
    * edge (18 bits, EB1). */
  def chain(g: Graph, pre: String): (Node, Edge) = {
    val n0 = g("recip_norm", s"${pre}_recip_norm")
    val n1 = g("recip_mul", s"${pre}_recip_mul")
    val n2 = g("recip_out", s"${pre}_recip_out")
    n0(ESpec(normW, 1))(n1)
    n1(ESpec(mulW, 1))(n2)
    (n0, n2(ESpec(outW, 1)))
  }

  /** Standalone netlist for the unit test (libs/spinal recip_test). */
  def unit(): Graph = {
    val g = new Graph("recip_unit")
    val (n0, r) = chain(g, "u")
    g("x")(ESpec(18))(n0)
    r(g("y"))
    g
  }
}

object RecipUnitVerilog extends App {
  Netlist.emit(args.headOption.getOrElse("build/recip"), "recip_unit.v")(
    new Netlist(Reciprocal.unit(), Reciprocal.macros, Nil))
}

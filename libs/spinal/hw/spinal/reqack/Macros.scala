package reqack

import spinal.core._

/** Leaf-module helpers shared by the macros. */
object Leaf {
  /** Connect a BlackBox port to a netlist signal with Verilog port-connection
    * semantics (zero-extend / truncate on width mismatch). */
  def bindIn(bb: VerilogBlackBox, port: String, sig: Data): Unit = {
    val p = bb.pin(port)
    if (!bb.isInput(port)) throw new Exception(s"${bb.definitionName}.$port is not an input")
    val b = sig.asBits
    if (b.getWidth != p.getWidth)
      SpinalWarning(s"${bb.getName()}.$port: ${b.getWidth}-bit signal on ${p.getWidth}-bit port")
    p := b.resized
  }

  def bindOut(bb: VerilogBlackBox, port: String, sig: Data): Unit = {
    val p = bb.pin(port)
    if (bb.isInput(port)) throw new Exception(s"${bb.definitionName}.$port is not an output")
    if (p.getWidth != sig.getBitsWidth)
      SpinalWarning(s"${bb.getName()}.$port: ${p.getWidth}-bit port on ${sig.getBitsWidth}-bit signal")
    sig.assignFromBits(p.resized)
  }

  /** Drive input `port` of `to` from output `port` of `from` (extras). */
  def link(from: VerilogBlackBox, to: VerilogBlackBox, port: String, width: Int): Unit = {
    val o = from.pin(port)
    val i = to.pin(port)
    if (from.isInput(port)) throw new Exception(s"${from.definitionName}.$port is not an output")
    if (!to.isInput(port)) throw new Exception(s"${to.definitionName}.$port is not an input")
    if (o.getWidth != width || i.getWidth != width)
      throw new Exception(s"${from.getName()}/${to.getName()}.$port: expected $width bits")
    i := o
  }

  def clock(bb: VerilogBlackBox, n: NodeCtx): Unit = {
    bindIn(bb, "clk", n.netlist.clk)
    bindIn(bb, "reset_n", n.netlist.reset_n)
  }

  /** Every BlackBox input must be bound (reqack leaves unbound ports
    * floating; here that is an error). */
  def checkBound(bb: VerilogBlackBox, bound: Set[String]): Unit = {
    val missing = bb.dirs.collect { case (p, "input") if !bound(p) => p }
    if (missing.nonEmpty) throw new Exception(s"${bb.getName()}: unbound inputs ${missing.mkString(", ")}")
  }

  def blackBox(n: NodeCtx, module: String, instName: String): VerilogBlackBox = {
    val bb = new VerilogBlackBox(module, VerilogHeader.ports(n.netlist.leafFile(module), module))
    bb.setName(instName)
    bb
  }
}

/** Extra data<->ctrl wire of a standard macro (reqack ctrl2data entry).
  * width > 0: the ctrl module drives it; width < 0: the data module does. */
case class Extra(port: String, width: Int)

/** reqack's standard macro: data module <label>_dat_<T>_<I> as instance
  * <node>, and either a ctrl module <label>_ctrl_<T>_<I> as instance
  * <node>_ctrl (when there are extras or several outputs, like reqack) or the
  * given inline controller (default: join). Extras connect the two instances'
  * pins directly (an intermediate named wire made Spinal suffix the pin wire,
  * e.g. inmux_sel_1). */
case class StandardMacro(label: String,
                         extras: Seq[Extra] = Nil,
                         inlineCtrl: Option[NodeCtx => Unit] = None,
                         generics: Seq[(String, Any)] = Nil,
                         dataModule: Option[NodeCtx => String] = None) extends Macro {
  def elaborate(n: NodeCtx): Unit = {
    val tn = n.ins.size
    val in = n.outs.size
    val dat = Leaf.blackBox(n, dataModule.map(_(n)).getOrElse(s"${label}_dat_${tn}_$in"), n.name)
    generics.foreach { case (k, v) => dat.addGeneric(k, v) }
    var bound = Set("clk", "reset_n")
    n.ins.foreach { i => Leaf.bindIn(dat, s"${i.port}_dat", i.dat); bound += s"${i.port}_dat" }
    n.outs.foreach(o => Leaf.bindOut(dat, s"${o.port}_dat", o.dat))
    extras.foreach(x => if (x.width > 0) bound += x.port)
    Leaf.clock(dat, n)
    Leaf.checkBound(dat, bound)

    inlineCtrl match {
      case Some(f) =>
        if (extras.nonEmpty) n.fail("inline controller with extras")
        f(n)
      case None if extras.nonEmpty || in > 1 =>
        val ctl = Leaf.blackBox(n, s"${label}_ctrl_${tn}_$in", s"${n.name}_ctrl")
        var cb = Set("clk", "reset_n")
        n.ins.foreach { i =>
          // reqack binds custom controllers to target 0 of each input edge
          if (i.tindex != 0) n.fail(s"input ${i.port} is target ${i.tindex} of ${i.edge}; reqack would miswire it")
          Leaf.bindIn(ctl, s"${i.port}_req", i.req); cb += s"${i.port}_req"
          Leaf.bindOut(ctl, s"${i.port}_ack", i.ack)
        }
        n.outs.foreach { o =>
          Leaf.bindOut(ctl, s"${o.port}_req", o.req)
          Leaf.bindIn(ctl, s"${o.port}_ack", o.ack); cb += s"${o.port}_ack"
        }
        extras.foreach { x =>
          if (x.width < 0) cb += x.port
          Leaf.link(if (x.width > 0) ctl else dat, if (x.width > 0) dat else ctl, x.port, x.width.abs)
        }
        Leaf.clock(ctl, n)
        Leaf.checkBound(ctl, cb)
      case None => Ctrl.join(n)
    }
  }
}

/** Leaf with its own req/ack handshakes (img_datapath, piston_dp): the
  * instance takes the edge req/ack directly. Inputs are bound by headlabel
  * (t_<label>_*), outputs by taillabel (i_<label>_*). With portsFromEdges
  * the header is derived from the node's edges instead of <module>.v (for a
  * module generated alongside, e.g. piston_dp). */
case class PassThroughMacro(module: String, portsFromEdges: Boolean = false) extends Macro {
  def elaborate(n: NodeCtx): Unit = {
    val bb =
      if (portsFromEdges) {
        val ports = Seq(VPort("clk", "input", 1), VPort("reset_n", "input", 1)) ++
          n.ins.flatMap(i => Seq(VPort(s"${i.port}_dat", "input", i.dat.getWidth),
            VPort(s"${i.port}_req", "input", 1), VPort(s"${i.port}_ack", "output", 1))) ++
          n.outs.flatMap(o => Seq(VPort(s"${o.port}_dat", "output", o.dat.getWidth),
            VPort(s"${o.port}_req", "output", 1), VPort(s"${o.port}_ack", "input", 1)))
        val b = new VerilogBlackBox(module, ports)
        b.setName(n.name)
        b
      } else Leaf.blackBox(n, module, n.name)
    var bound = Set("clk", "reset_n")
    n.ins.foreach { i =>
      Seq("dat" -> i.dat, "req" -> i.req).foreach { case (s, sig) =>
        Leaf.bindIn(bb, s"${i.port}_$s", sig); bound += s"${i.port}_$s"
      }
      Leaf.bindOut(bb, s"${i.port}_ack", i.ack)
    }
    n.outs.foreach { o =>
      Leaf.bindOut(bb, s"${o.port}_dat", o.dat)
      Leaf.bindOut(bb, s"${o.port}_req", o.req)
      Leaf.bindIn(bb, s"${o.port}_ack", o.ack); bound += s"${o.port}_ack"
    }
    Leaf.clock(bb, n)
    Leaf.checkBound(bb, bound)
  }
}

/** reqack node-macros deconcat: outputs slice the input, first output at the
  * LSB; node-fork controller. */
object DeconcatMacro extends Macro {
  def elaborate(n: NodeCtx): Unit = {
    if (n.ins.size != 1) n.fail("deconcat needs one input")
    val t = n.ins.head.dat
    var lsb = 0
    n.outs.foreach { o =>
      val w = o.dat.getWidth
      if (lsb + w > t.getWidth) n.fail(s"deconcat outputs exceed the ${t.getWidth}-bit input")
      o.dat := t(lsb + w - 1 downto lsb)
      lsb += w
    }
    Ctrl.nodeFork(n)
  }
}

/** datapath-macros slice16: output i is t0[16i+15:16i] sign-extended;
  * node-fork controller. */
object Slice16Macro extends Macro {
  def elaborate(n: NodeCtx): Unit = {
    val t = n.ins.head.dat
    n.outs.zipWithIndex.foreach { case (o, i) =>
      o.dat := t(16 * i + 15 downto 16 * i).asSInt.resize(o.dat.getWidth).asBits
    }
    Ctrl.nodeFork(n)
  }
}

/** datapath-macros m2c: the last input (2 bits) selects one of up to four
  * inputs; a missing input reads as constant 1 with req always high. codes
  * gives the select code of each data input (default: input k is code k), so
  * an input can skip a code that keeps its constant 1. */
class M2c(codes: Seq[Int] = Seq(0, 1, 2, 3)) extends Macro {
  def elaborate(n: NodeCtx): Unit = {
    val data = n.ins.dropRight(1)
    if (data.size > codes.size || codes.take(data.size).exists(c => c < 0 || c > 3))
      n.fail(s"${data.size} data inputs for codes ${codes.mkString(",")}")
    val selIn = n.ins.last
    val o = n.outs.head
    val sel = n.wire("sel", 2)
    sel := selIn.dat.resized
    val at = data.zip(codes).map(_.swap).toMap
    def pick[T <: Data](f: InPort => T, one: => T): Seq[T] = (0 to 3).map(k => at.get(k).map(f).getOrElse(one))
    val d = pick[Bits](_.dat.resized, B(1, o.dat.getWidth bits))
    o.dat := sel.mux(0 -> d(0), 1 -> d(1), 2 -> d(2), 3 -> d(3))
    val r = pick[Bool](_.req, True)
    o.req := sel.mux(0 -> r(0), 1 -> r(1), 2 -> r(2), 3 -> r(3))
    data.zip(codes).foreach { case (i, k) => i.ack := sel =/= k || o.ack }
    selIn.ack := True
  }
}

object M2cMacro extends M2c()

/** Combinational node: f computes the output data from the input data;
  * default join controller. For small inline datapaths (the reciprocal),
  * pipelined by buffered edges between nodes. */
case class FuncMacro(f: (NodeCtx, Seq[Bits]) => Bits) extends Macro {
  def elaborate(n: NodeCtx): Unit = {
    if (n.outs.size != 1) n.fail("func node needs one output")
    val o = n.outs.head
    val v = f(n, n.ins.map(_.dat))
    if (v.getWidth != o.dat.getWidth) n.fail(s"func result is ${v.getWidth} bits, edge is ${o.dat.getWidth}")
    o.dat := v
    Ctrl.join(n)
  }
}

/** datapath-macros bs: standard data module, controller passes input 0 to
  * the output and always accepts the cfg input. */
object BsMacro extends Macro {
  private val std = StandardMacro("bs", inlineCtrl = Some { n =>
    n.outs.head.req := n.ins(0).req
    n.ins(0).ack := n.outs.head.ack
    n.ins(1).ack := True
  })
  def elaborate(n: NodeCtx): Unit = std.elaborate(n)
}

/** datapath-macros muladdsub: 3-stage DSP (A0*B0 +/- A1*B1) with an EB1-like
  * controller per stage; a cfg beat clocks all stages 4 cycles later. The
  * input is {B1, A1, B0, A0} = {q3, q2, q1, q0}, 18 bits each. */
object MulAddSubMacro extends Macro {
  val ports = Seq(VPort("CLK0", "input", 1), VPort("CE0", "input", 1), VPort("CE1", "input", 1),
    VPort("CE2", "input", 1), VPort("RST0", "input", 1), VPort("ADDNSUB", "input", 1),
    VPort("A0", "input", 18), VPort("A1", "input", 18), VPort("B0", "input", 18), VPort("B1", "input", 18),
    VPort("SUM", "output", 36))

  def elaborate(n: NodeCtx): Unit = {
    val t0 = n.ins(0)
    val t1 = n.ins(1)
    val o = n.outs.head
    val cfgValid = Reg(Bits(4 bits)).setName(s"${n.name}_cfg_valid")
    cfgValid := cfgValid(2 downto 0) ## t1.req
    t1.ack := True

    // stage k: (req in, ack in) -> (req out, ack out)
    def stage(k: Int, req: Bool, ack: Bool, nextAck: Bool): (Bool, Bool) = {
      val r = RegInit(False).setName(s"${n.name}_s${k}_valid")
      val en = n.bool(s"s${k}_en")
      en := (req & ack) | cfgValid(3)
      ack := !r | nextAck
      r := !ack | req
      (r, en)
    }
    val ack1 = n.bool("s1_ack")
    val ack2 = n.bool("s2_ack")
    val (req1, en1) = stage(1, t0.req, t0.ack, ack1)
    val (req2, en2) = stage(2, req1, ack1, ack2)
    val (req3, en3) = stage(3, req2, ack2, o.ack)
    o.req := req3

    val bb = new VerilogBlackBox("muladdsub", ports)
    bb.setName(n.name)
    val q = (0 to 3).map(k => t0.dat(18 * k + 17 downto 18 * k))
    Leaf.bindIn(bb, "CLK0", n.netlist.clk)
    Leaf.bindIn(bb, "RST0", !n.netlist.reset_n)
    Leaf.bindIn(bb, "CE0", en1)
    Leaf.bindIn(bb, "CE1", en2)
    Leaf.bindIn(bb, "CE2", en3)
    Leaf.bindIn(bb, "ADDNSUB", t1.dat(0))
    Leaf.bindIn(bb, "A0", q(0))
    Leaf.bindIn(bb, "B0", q(1))
    Leaf.bindIn(bb, "A1", q(2))
    Leaf.bindIn(bb, "B1", q(3))
    Leaf.bindOut(bb, "SUM", o.dat)
  }
}

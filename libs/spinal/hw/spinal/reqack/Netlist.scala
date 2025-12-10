package reqack

import java.io.File
import scala.collection.mutable
import spinal.core._

/** Signals of one edge. For an unbuffered edge nxt and dat are the same
  * signal. tReq/tAck are per target, after the edge fork. */
class EdgeSig(val e: Edge) {
  val dat: Bits = Bits(e.width bits).setName(e.name)
  val nxt: Bits = if (e.buffered) Bits(e.width bits).setName(s"${e.name}_nxt") else dat
  val req: Bool = Bool().setName(s"${e.name}_req")
  val ack: Bool = Bool().setName(s"${e.name}_ack")
  val mReq: Bool = Bool().setName(s"${e.name}_m_req")
  val mAck: Bool = Bool().setName(s"${e.name}_m_ack")
  private val tnames = {
    val base = e.targets.map(t => t.node.ident)
    base.zipWithIndex.map { case (b, i) => if (base.count(_ == b) > 1) s"${b}_$i" else b }
  }
  val tReq: Seq[Bool] = tnames.map(t => Bool().setName(s"${e.name}_to_${t}_req")).toSeq
  val tAck: Seq[Bool] = tnames.map(t => Bool().setName(s"${e.name}_to_${t}_ack")).toSeq
}

/** Node input: edge buffered output as seen by target index tindex.
  * port is reqack's t_<headlabel|ei> base name. */
case class InPort(edge: Edge, index: Int, tindex: Int, port: String, dat: Bits, req: Bool, ack: Bool)
/** Node output: edge source side. port is reqack's i_<taillabel|ei>. */
case class OutPort(edge: Edge, index: Int, port: String, dat: Bits, req: Bool, ack: Bool)

class NodeCtx(val node: Node, val ins: Seq[InPort], val outs: Seq[OutPort], val netlist: Netlist) {
  def name: String = node.name
  def in(port: String): InPort = ins.find(_.port == port).getOrElse(fail(s"no input $port"))
  def out(port: String): OutPort = outs.find(_.port == port).getOrElse(fail(s"no output $port"))
  def fail(msg: String): Nothing = throw new Exception(s"${node}: $msg")
  def wire(suffix: String, width: Int): Bits = Bits(width bits).setName(s"${name}_$suffix")
  def bool(suffix: String): Bool = Bool().setName(s"${name}_$suffix")
}

/** How a labelled node is implemented. elaborate must drive every out.dat,
  * out.req and in.ack of the node. */
trait Macro {
  def elaborate(n: NodeCtx): Unit
}

object Ctrl {
  /** reqack default node controller (fhyper-verilog cJoins). */
  def join(n: NodeCtx): Unit = {
    if (n.outs.size != 1) n.fail(s"join controller needs one output, has ${n.outs.size}")
    val o = n.outs.head
    o.req := n.ins.map(_.req).reduce(_ & _)
    n.ins.foreach { i =>
      i.ack := (Seq(o.ack) ++ n.ins.filter(_ ne i).map(_.req)).reduce(_ & _)
    }
  }

  /** reqack lib/node-fork-ctrl.js: one input broadcast to all outputs. */
  def nodeFork(n: NodeCtx): Unit = {
    if (n.ins.size != 1) n.fail("node fork needs exactly one input")
    val t = n.ins.head
    val g = n.outs.map { o =>
      val r = RegInit(False).setName(s"${n.name}_${o.port}_req_reg")
      o.req := t.req & !r
      val ag = n.bool(s"${o.port}_ack_g")
      ag := o.ack | !o.req
      (r, ag)
    }
    t.ack := g.map(_._2).reduce(_ & _)
    g.foreach { case (r, ag) => r := ag & !t.ack }
  }

  /** reqack lib/fork-ctrl.js: edge fan-out after the buffer. */
  def edgeFork(s: EdgeSig): Unit = {
    if (s.tReq.size == 1) {
      s.tReq.head := s.mReq
      s.mAck := s.tAck.head
    } else {
      val parts = s.tReq.indices.map { i =>
        val r = RegInit(False).setName(s"${s.e.name}_fork_ack_r_$i")
        val as = Bool().setName(s"${s.e.name}_fork_ack_s_$i")
        s.tReq(i) := s.mReq & !r
        as := s.tAck(i) | !s.tReq(i)
        (r, as)
      }
      s.mAck := parts.map(_._2).reduce(_ & _)
      parts.foreach { case (r, as) => r := as & !s.mAck }
    }
  }
}

/** reqack lib/operators.js: add/sub (signed, Verilog context width) and
  * concat (first input at the LSB). A single input is split in halves. */
object Operators {
  val names = Set("add", "sub", "concat")

  def elaborate(n: NodeCtx, op: String): Unit = {
    if (n.outs.size != 1) n.fail(s"operator $op needs one output")
    val o = n.outs.head
    val args: Seq[Bits] =
      if (n.ins.size == 1 && op != "concat") {
        val d = n.ins.head.dat
        val h = d.getWidth / 2
        Seq(d(h - 1 downto 0), d(d.getWidth - 1 downto h))
      } else n.ins.map(_.dat)
    o.dat := (op match {
      case "concat" => Cat(args).resized // Cat: first element at the LSB
      case _ =>
        val w = (args.map(_.getWidth) :+ o.dat.getWidth).max
        val s = args.map(_.asSInt.resize(w))
        (if (op == "add") s.reduce(_ + _) else s.reduce(_ - _)).asBits.resized
    })
    Ctrl.join(n)
  }
}

/** Elaborates a Graph into one flat Verilog module named after the graph:
  * IO ports t_<label>_{dat,req,ack} / i_<label>_{dat,req,ack}, clk and
  * async active-low reset_n, all edges, buffers and forks inline, and leaf
  * macros as BlackBox instances named after their node. */
class Netlist(val graph: Graph, macros: Map[String, Macro], val leafDirs: Seq[File]) extends Component {
  graph.validate()
  setDefinitionName(graph.label)

  val clk = in(Bool()).setName("clk")
  val reset_n = in(Bool()).setName("reset_n")
  val cd = ClockDomain(clk, reset_n, config = ClockDomainConfig(resetKind = ASYNC, resetActiveLevel = LOW))

  private val ioDat = mutable.LinkedHashMap[Node, (Bits, Bool, Bool)]()
  graph.nodes.foreach { n =>
    if (n.isTarget) {
      val w = n.to.head.width
      ioDat(n) = (in(Bits(w bits)).setName(s"t_${n.name}_dat"),
        in(Bool()).setName(s"t_${n.name}_req"), out(Bool()).setName(s"t_${n.name}_ack"))
    } else if (n.isInitiator) {
      val w = n.from.head.width
      ioDat(n) = (out(Bits(w bits)).setName(s"i_${n.name}_dat"),
        out(Bool()).setName(s"i_${n.name}_req"), in(Bool()).setName(s"i_${n.name}_ack"))
    }
  }

  val sigs: Map[Edge, EdgeSig] = graph.edges.map(e => e -> new EdgeSig(e)).toMap

  /** Find <module>.v in the leaf directories. */
  def leafFile(module: String): File =
    leafDirs.map(new File(_, module + ".v")).find(_.exists())
      .getOrElse(throw new Exception(s"${module}.v not found in ${leafDirs.mkString(", ")}"))

  def ctx(n: Node): NodeCtx = {
    val ins = n.from.zipWithIndex.map { case (e, ei) =>
      val ti = e.targetIndex(n)
      val port = s"t_${Option(e.targets(ti).headlabel).getOrElse(ei.toString)}"
      InPort(e, ei, ti, port, sigs(e).dat, sigs(e).tReq(ti), sigs(e).tAck(ti))
    }.toSeq
    val outs = n.to.zipWithIndex.map { case (e, ei) =>
      OutPort(e, ei, s"i_${e.taillabel.getOrElse(ei.toString)}", sigs(e).nxt, sigs(e).req, sigs(e).ack)
    }.toSeq
    new NodeCtx(n, ins, outs, this)
  }

  cd {
    graph.nodes.foreach { n =>
      val c = ctx(n)
      if (n.isTarget) {
        val (d, r, a) = ioDat(n)
        val o = c.outs.head
        o.dat := d; o.req := r; a := o.ack
      } else if (n.isInitiator) {
        val (d, r, a) = ioDat(n)
        val i = c.ins.head
        d := i.dat; r := i.req; i.ack := a
      } else n.kind match {
        case Some(op) if Operators.names(op) => Operators.elaborate(c, op)
        case Some(k) if macros.contains(k) => macros(k).elaborate(c)
        case Some(k) => c.fail(s"unknown kind '$k'")
        case None =>
          if (c.ins.size != 1 || c.outs.size != 1) c.fail("unlabelled node must have one input and one output")
          c.outs.head.dat := c.ins.head.dat.resized
          Ctrl.join(c)
      }
    }
    graph.edges.foreach { e =>
      val s = sigs(e)
      Buffers(e, s.req, s.ack, s.nxt, s.mReq, s.mAck, s.dat)
      Ctrl.edgeFork(s)
    }
  }
}

object Netlist {
  /** Stable-naming Verilog config: no repo hash, no timescale (reqack emitted
    * none), no per-file `when` naming. */
  def config(targetDir: String): SpinalConfig = SpinalConfig(
    targetDirectory = targetDir,
    headerWithRepoHash = false,
    nameWhenByFile = false,
    withTimescale = false,
    anonymSignalPrefix = "_zz"
  )

  def emit(targetDir: String, fileName: String)(top: => Component): Unit = {
    val cfg = config(targetDir)
    cfg.netlistFileName = fileName
    cfg.generateVerilog(top)
  }
}

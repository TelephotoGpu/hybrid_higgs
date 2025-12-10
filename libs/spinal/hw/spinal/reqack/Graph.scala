package reqack

import scala.collection.mutable.ArrayBuffer

/** Edge label: data width and elastic-buffer capacity. Capacity 0 is a plain
  * wire (EB0), 1 is EB1, 1.5 is EB1.5, 1.7 is EB1.7 and >= 2 is a FIFO; any
  * other value is rejected (reqack silently treats unknown values as EB0). */
case class ESpec(width: Int, capacity: Double = 0) {
  require(width > 0, s"edge width must be positive, got $width")
  require(Seq(0.0, 1.0, 1.5, 1.7).contains(capacity) || (capacity >= 2 && capacity == capacity.floor),
    s"unsupported capacity $capacity")
}

case class Target(node: Node, headlabel: String)

/** Directed hypergraph with the same construction semantics as reqack's
  * fhyper: nodes and edges are kept in creation order, an edge is an output of
  * one node and may fan out to several targets, and node/edge names are the
  * stable handles that become Verilog instance and signal names. */
class Graph(val label: String) {
  val nodes = ArrayBuffer[Node]()
  val edges = ArrayBuffer[Edge]()

  /** kind selects the IO/operator/macro behaviour (reqack's node label);
    * name is the stable identifier (defaults to the kind). IO nodes are named
    * by their port label, so kind == name there. */
  def apply(kind: String = null, name: String = null): Node = {
    val nm = Option(name).orElse(Option(kind)).getOrElse(s"n${nodes.size}")
    val n = new Node(this, Option(kind), nm)
    nodes += n
    n
  }

  def node(name: String): Node =
    nodes.find(_.name == name).getOrElse(throw new Exception(s"$label: no node '$name'"))

  def edge(name: String): Edge =
    edges.find(_.name == name).getOrElse(throw new Exception(s"$label: no edge '$name'"))

  /** Structural checks done before elaboration. */
  def validate(): Unit = {
    def dups(names: Seq[String]) = names.groupBy(identity).collect { case (k, v) if v.size > 1 => k }
    val dn = dups(nodes.map(_.ident).toSeq)
    if (dn.nonEmpty) throw new Exception(s"$label: duplicate node names ${dn.mkString(", ")} (give them explicit names)")
    val de = dups(edges.map(_.name).toSeq)
    if (de.nonEmpty) throw new Exception(s"$label: duplicate edge names ${de.mkString(", ")}")
    edges.foreach(e => if (e.targets.isEmpty) throw new Exception(s"$label: edge ${e.name} has no target"))
    nodes.foreach { n =>
      if (n.from.isEmpty && n.to.isEmpty) throw new Exception(s"$label: node ${n.name} is unconnected")
      if (n.isTarget && n.to.size != 1) throw new Exception(s"$label: target port ${n.name} needs exactly one edge")
      if (n.isInitiator && n.from.size != 1) throw new Exception(s"$label: initiator port ${n.name} needs exactly one edge")
    }
  }
}

class Node(val graph: Graph, val kind: Option[String], val name: String) {
  val from = ArrayBuffer[Edge]()
  val to = ArrayBuffer[Edge]()

  def isTarget: Boolean = from.isEmpty
  def isInitiator: Boolean = to.isEmpty
  def isIo: Boolean = isTarget || isInitiator
  /** reqack's label: port name for IO nodes, macro/operator name otherwise. */
  def label: String = kind.getOrElse(name)
  /** Unique handle: t_<name> / i_<name> for IO nodes, else the name. */
  def ident: String = if (isTarget) s"t_$name" else if (isInitiator) s"i_$name" else name

  /** New output edge (reqack: node(label, taillabel)). */
  def apply(spec: ESpec, taillabel: String = null, name: String = null): Edge = {
    val e = new Edge(graph, this, to.size, spec, Option(taillabel), Option(name))
    to += e
    graph.edges += e
    e
  }

  /** Index of this node's input edge e (reqack's ei for t_<headlabel|ei>). */
  def inIndex(e: Edge): Int = from.indexOf(e)
  def outIndex(e: Edge): Int = to.indexOf(e)
  override def toString: String = s"${graph.label}.$ident"
}

class Edge(val graph: Graph, val source: Node, val sourceIndex: Int, val spec: ESpec,
           val taillabel: Option[String], explicitName: Option[String]) {
  val targets = ArrayBuffer[Target]()

  /** Stable signal prefix; resolved lazily because a node's IO role is only
    * known once the graph is complete. */
  def name: String =
    explicitName.getOrElse(s"${source.ident}_${taillabel.getOrElse(sourceIndex.toString)}")

  def width: Int = spec.width
  def capacity: Double = spec.capacity
  def buffered: Boolean = capacity != 0

  /** Connect to another target (reqack: edge(node, headlabel)); chainable. */
  def apply(n: Node, headlabel: String = null): Edge = {
    require(n.graph eq graph, s"$name: node ${n.name} is in another graph")
    targets += Target(n, headlabel)
    n.from += this
    this
  }

  /** Index of node n among this edge's targets. */
  def targetIndex(n: Node): Int = targets.indexWhere(_.node eq n)
  override def toString: String = s"${graph.label}.$name"
}

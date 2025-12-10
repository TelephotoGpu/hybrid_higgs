package reqack

import java.io.File
import java.nio.charset.StandardCharsets.UTF_8
import java.nio.file.Files

/** Graph dump for names/map.py (reqack -> Spinal signal-name map). */
object GraphJson {
  private def q(s: String) = "\"" + s + "\""

  def apply(g: Graph): String = {
    def idx(n: Node) = g.nodes.indexWhere(_ eq n)
    def eix(es: Seq[Edge]) = es.map(e => g.edges.indexWhere(_ eq e)).mkString("[", ",", "]")
    val nodes = g.nodes.map(n =>
      s"""{"name":${q(n.name)},"kind":${n.kind.map(q).getOrElse("null")},"ident":${q(n.ident)},""" +
        s""""from":${eix(n.from.toSeq)},"to":${eix(n.to.toSeq)}}""")
    val edges = g.edges.map { e =>
      val t = e.targets.map(t => s"[${idx(t.node)},${Option(t.headlabel).map(q).getOrElse("null")}]")
      s"""{"name":${q(e.name)},"src":${idx(e.source)},"idx":${e.sourceIndex},"capacity":${e.capacity},"targets":[${t.mkString(",")}]}"""
    }
    s"""{"nodes":[\n${nodes.mkString(",\n")}\n],"edges":[\n${edges.mkString(",\n")}\n]}\n"""
  }

  def write(g: Graph, f: File): Unit = {
    f.getParentFile.mkdirs()
    Files.write(f.toPath, apply(g).getBytes(UTF_8))
  }
}

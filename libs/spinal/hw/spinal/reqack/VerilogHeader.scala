package reqack

import java.io.File
import scala.collection.mutable
import scala.io.Source
import spinal.core._

case class VPort(name: String, dir: String, width: Int)

/** Port list of an ANSI-style Verilog module header, with parameter-dependent
  * ranges evaluated at the parameter defaults. Fails loudly on anything it
  * does not understand, so a template change cannot silently mis-wire a
  * BlackBox. */
object VerilogHeader {
  private val cache = mutable.HashMap[(String, String), Seq[VPort]]()

  def ports(file: File, module: String): Seq[VPort] =
    cache.getOrElseUpdate((file.getCanonicalPath, module), parse(file, module))

  private def fail(file: File, module: String, msg: String): Nothing =
    throw new Exception(s"VerilogHeader: $file module $module: $msg")

  private def stripComments(s: String): String =
    s.replaceAll("(?s)/\\*.*?\\*/", " ").replaceAll("//[^\n]*", " ")

  // body between the '(' at open and its matching ')', and the index after it
  private def balanced(s: String, open: Int): (String, Int) = {
    var depth = 0
    var i = open
    while (i < s.length) {
      s(i) match {
        case '(' => depth += 1
        case ')' =>
          depth -= 1
          if (depth == 0) return (s.substring(open + 1, i), i + 1)
        case _ =>
      }
      i += 1
    }
    throw new Exception("unbalanced parentheses")
  }

  private def skipWs(s: String, i0: Int): Int = {
    var i = i0
    while (i < s.length && s(i).isWhitespace) i += 1
    i
  }

  private def splitTop(s: String): Seq[String] = {
    val out = mutable.ArrayBuffer[String]()
    var depth = 0
    val cur = new StringBuilder
    s.foreach {
      case c @ ('(' | '[' | '{') => depth += 1; cur += c
      case c @ (')' | ']' | '}') => depth -= 1; cur += c
      case ',' if depth == 0 => out += cur.toString; cur.clear()
      case c => cur += c
    }
    out += cur.toString
    out.map(_.trim).filter(_.nonEmpty).toSeq
  }

  /** Integer expression over + - * / ( ) with decimal or sized literals. */
  def eval(expr: String, params: Map[String, BigInt]): BigInt = {
    val toks = "[0-9]+'[dDhHbB][0-9a-fA-F_]+|[0-9]+|[A-Za-z_][A-Za-z0-9_]*|[-+*/()]".r
      .findAllIn(expr).toList
    if (toks.mkString != expr.replaceAll("\\s", "")) throw new Exception(s"cannot evaluate '$expr'")
    var rest = toks
    def peek = rest.headOption.getOrElse("")
    def next() = { val t = rest.head; rest = rest.tail; t }
    def atom(): BigInt = next() match {
      case "(" => val v = sum(); if (next() != ")") throw new Exception(s"')' expected in '$expr'"); v
      case "-" => -atom()
      case t if t.contains("'") =>
        val v = t.split("'")(1)
        BigInt(v.tail.replace("_", ""), v.head.toLower match { case 'd' => 10 case 'h' => 16 case 'b' => 2 })
      case t if t.head.isDigit => BigInt(t)
      case t => params.getOrElse(t, throw new Exception(s"unknown parameter $t in '$expr'"))
    }
    def prod(): BigInt = {
      var v = atom()
      while (peek == "*" || peek == "/") { if (next() == "*") v *= atom() else v /= atom() }
      v
    }
    def sum(): BigInt = {
      var v = prod()
      while (peek == "+" || peek == "-") { if (next() == "+") v += prod() else v -= prod() }
      v
    }
    val v = sum()
    if (rest.nonEmpty) throw new Exception(s"trailing tokens in '$expr'")
    v
  }

  private val portRe =
    """^(?:(input|output|inout)\s+)?(?:(?:wire|reg|logic)\s+)?(?:signed\s+)?(?:\[([^\]]+)\])?\s*([A-Za-z_][A-Za-z0-9_$]*)$""".r

  private def parse(file: File, module: String): Seq[VPort] = {
    if (!file.exists()) fail(file, module, "file not found")
    val src = Source.fromFile(file)
    val text = try stripComments(src.mkString) finally src.close()
    val m = ("\\bmodule\\s+" + java.util.regex.Pattern.quote(module) + "\\b").r
      .findFirstMatchIn(text).getOrElse(fail(file, module, "module not found"))
    var i = skipWs(text, m.end)
    val params = mutable.LinkedHashMap[String, BigInt]()
    if (text(i) == '#') {
      i = skipWs(text, i + 1)
      val (body, end) = balanced(text, i)
      splitTop(body).foreach { item =>
        val p = """^(?:parameter\s+)?(?:integer\s+)?([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.+)$""".r
        item.replaceAll("\\s+", " ").trim match {
          case p(name, value) =>
            if (!value.trim.startsWith("\"")) params(name) = eval(value, params.toMap)
          case other => fail(file, module, s"cannot parse parameter '$other'")
        }
      }
      i = skipWs(text, end)
    }
    if (text(i) != '(') fail(file, module, "port list expected")
    val (body, _) = balanced(text, i)
    if (body.contains("`")) fail(file, module, "preprocessor directive in port list")
    var dir: String = null
    var range: String = null
    val ports = splitTop(body).map { item =>
      item.replaceAll("\\s+", " ").trim match {
        case portRe(d, r, name) =>
          if (d != null) { dir = d; range = r }
          else if (r != null) fail(file, module, s"range without direction on '$item'")
          if (dir == null) fail(file, module, s"non-ANSI header (port '$name' has no direction)")
          val width = if (range == null) 1 else {
            val Array(msb, lsb) = range.split(":").map(e => eval(e.trim, params.toMap))
            ((msb - lsb).abs + 1).toInt
          }
          VPort(name, dir, width)
        case other => fail(file, module, s"cannot parse port '$other'")
      }
    }
    if (ports.map(_.name).distinct.size != ports.size) fail(file, module, "duplicate port")
    ports
  }
}

/** BlackBox whose ports come from a Verilog header (see VerilogHeader) or an
  * explicit list. Every port is Bits; use pin(name) to connect. */
class VerilogBlackBox(module: String, portList: Seq[VPort]) extends BlackBox {
  setDefinitionName(module)
  val pins: Map[String, Bits] = portList.map { p =>
    val s = p.dir match {
      case "input"  => in(Bits(p.width bits))
      case "output" => out(Bits(p.width bits))
      case d        => throw new Exception(s"$module.${p.name}: unsupported direction $d")
    }
    s.setName(p.name)
    p.name -> s
  }.toMap
  val dirs: Map[String, String] = portList.map(p => p.name -> p.dir).toMap
  def has(name: String): Boolean = pins.contains(name)
  def pin(name: String): Bits =
    pins.getOrElse(name, throw new Exception(s"$module has no port '$name' (ports: ${portList.map(_.name).mkString(", ")})"))
  def isInput(name: String): Boolean = dirs(name) == "input"
}

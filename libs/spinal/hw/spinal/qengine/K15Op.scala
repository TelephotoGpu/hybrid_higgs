package qengine

import java.io.File
import reqack._

/** Paths shared by the reqack-replacement generators. Run from libs/spinal
  * (sbt or scripts/direct-run.sh); the first program argument, if given,
  * overrides the output directory. */
object PistonPaths {
  val repo = new File("../..").getCanonicalFile
  val pistonHdl = new File(repo, "libs/q-engine/piston/hdl")
  def outDir(args: Array[String]): String =
    args.headOption.getOrElse(pistonHdl.getPath)
}

/** k15_op: 24-bit k15 opcode pipe, EB1.5 -> EB1 -> EB1.5
  * (was libs/q-engine/piston/lib/k15_op.js). */
object K15Op {
  def graph(): Graph = {
    val g = new Graph("k15_op")
    val opw = ESpec(4 + 4 + 16, 1.5)
    val opw1 = ESpec(4 + 4 + 16, 1)
    val tk15 = g("k15_op")
    val unity1 = g(name = "unity1")
    val unity2 = g(name = "unity2")
    val ik15 = g("k15_op")
    tk15(opw)(unity1)
    unity1(opw1)(unity2)
    unity2(opw)(ik15)
    g
  }
}

object K15OpVerilog extends App {
  Netlist.emit(PistonPaths.outDir(args), "k15_op.v")(new Netlist(K15Op.graph(), Map.empty, Nil))
}

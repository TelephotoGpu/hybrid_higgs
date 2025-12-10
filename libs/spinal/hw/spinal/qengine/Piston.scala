package qengine

import java.io.File
import java.nio.charset.StandardCharsets.UTF_8
import java.nio.file.Files
import reqack._

/** piston: the q-engine elastic core (vector unit, vmem, muxes, permuters,
  * decoders) with the datapath as the pass-through instance dp
  * (module piston_dp, see PistonDp). Port of libs/q-engine/piston/lib/
  * piston.js, construction order kept. */
object Piston {
  val div = 2
  val kw = 32 * 32 / div
  val vmemParams: Seq[String] = "VMEM_SIZE" +: (0 until 32).map(i => s"VMEM$i")

  def graph(): Graph = {
    val g = new Graph("piston")
    val k8w = ESpec(kw, 1.5)
    val k9w = ESpec(kw, 1.5)
    val k14w = ESpec(kw, 1)
    val kwe = ESpec(kw, 1)
    val k15w = ESpec(kw, 1)
    val rkw = ESpec(kw, 0)
    val rkw15 = ESpec(kw, 1.5)
    val idmaw = ESpec(1 + 16 + 32, 1.5)
    val odmaw = ESpec(32, 1.7)
    val odmaweb1 = ESpec(32, 1)
    val kactrlw = ESpec(4 + 32 / div * (11 + 1), 1)
    val kpctrlw = ESpec(4 + 32 / div * (5 - 1), 1)
    val kakpctrlw = ESpec(4 + 4 + 32 / div * (11 + 5), 1.5)
    val opermOw = ESpec(kw, 1.5)
    val cmdw = ESpec(64, 1.5)
    val kImuxw = ESpec(4, 2)
    val kpIpermw = ESpec(4 + 32 / div * (5 - 1), 3)
    val kaVmemw = ESpec(4 + 32 / div * (11 + 1), 4)
    val kpOpermw = ESpec(4 + 32 / div * (5 - 1), 3)
    val kOmuxw = ESpec(4, 4)
    val k13w = ESpec(kw, 4)

    val cmd = g("instr")
    val s1 = (0 until 2).map(i => g(name = s"cmd_s1_$i"))
    val s2 = (0 until 4).map(i => g(name = s"cmd_s2_$i"))
    val sx = (0 until 8).map(i => g(name = s"cmd_s3_$i"))

    val tdma = (0 until 4).map(i => g(s"idma_$i"))
    val tdma1s1 = g(name = "idma_1_s1")
    val idma = (0 until 4).map(i => g(s"odma_$i"))
    val idma1s1 = g(name = "odma_1_s1")
    val idma2s1 = g(name = "odma_2_s1")
    val vector = g("vector")
    val imux = g("inmux")
    val vmem = g("vmem")
    val omux = g("oumux")
    val kapDeconcat = g("deconcat", "kap_deconcat")
    val permAddr = g("perm_full_addr")
    val ipermData = g("perm_full_data", "iperm_data")
    val opermData = g("perm_full_data", "operm_data")
    val kaDecode = g("ka_decode")
    val pDecode = g("p_decode")
    val vmemOvs = g(name = "vmem_ovs")
    val dp = g("piston_dp", "dp")

    // instruction broadcast tree: 1 -> 2 -> 4 -> 8 -> 16 vector lanes
    cmd(cmdw)(s1(0))(s1(1))
    s1(0)(cmdw)(s2(0))(s2(1))
    s1(1)(cmdw)(s2(2))(s2(3))
    s2.zipWithIndex.foreach { case (n, i) => n(cmdw)(sx(2 * i))(sx(2 * i + 1)) }
    sx.zipWithIndex.foreach { case (n, ni) =>
      val e = n(cmdw)
      (0 until 4 / div).foreach { idx =>
        val lane = 4 / div * ni + idx
        val eq = g(name = s"cmd_lane_$lane")
        e(eq)
        eq(cmdw)(vector, s"instr_$lane")
      }
    }

    vector(rkw15, "k15")(imux, "k15")
    imux(k15w, "inmux")(ipermData, "data")
    ipermData(kwe, "data")(vmem, "ivs")
    vmem(rkw, "ovs")(vmemOvs)
    vmemOvs(k15w)(opermData, "data")
    opermData(opermOw, "data")(omux, "oumux")

    omux(rkw15, "k15")(vector, "k15")
    omux(k8w, "k8")(dp, "k8")
    omux(k9w, "k9")(dp, "k9")
    omux(k14w, "k14")(dp, "k14")
    omux(k13w, "k13")(imux, "k13")
    dp(rkw, "k1")(imux, "k1")

    vector(kakpctrlw, "kap")(kapDeconcat)
    kapDeconcat(kpctrlw)(permAddr, "0")
    kapDeconcat(kactrlw)(kaDecode, "ka")
    kaDecode(kaVmemw, "ka")(vmem, "ka")
    kaDecode(kImuxw, "k_sk")(imux, "c")
    permAddr(kpctrlw, "0")(pDecode, "kp")
    kaDecode(kOmuxw, "k_lk")(omux, "c")
    pDecode(kpIpermw, "p_sk")(ipermData, "addr")
    pDecode(kpOpermw, "p_lk")(opermData, "addr")

    tdma(0)(idmaw, "idma_0")(vmem, "idma_0")
    tdma(1)(idmaw, "idma_1")(tdma1s1)
    tdma1s1(idmaw)(vmem, "idma_1")
    tdma(2)(idmaw, "idma_2")(vmem, "idma_2")
    tdma(3)(idmaw, "idma_3")(vmem, "idma_3")

    vmem(odmaw, "odma_0")(idma(0), "odma_0")
    vmem(odmaw, "odma_1")(idma1s1)
    idma1s1(odmaweb1)(idma(1), "odma_1")
    vmem(odmaw, "odma_2")(idma2s1)
    idma2s1(odmaweb1)(idma(2), "odma_2")
    vmem(odmaw, "odma_3")(idma(3), "odma_3")
    g
  }

  private def valid(p: String) = Seq(Extra(s"${p}_valid", 1), Extra(s"${p}_ready", -1))
  private def ready(p: String) = Seq(Extra(s"${p}_valid", -1), Extra(s"${p}_ready", 1))

  val macros: Map[String, Macro] = Map(
    "vector" -> StandardMacro("vector",
      (0 until 16).flatMap(i => valid(s"instr_$i")) ++ valid("tk15") ++ ready("ik15") ++ ready("kap")),
    "inmux" -> StandardMacro("inmux", Seq(Extra("sel", -4))),
    "oumux" -> StandardMacro("oumux", Seq(Extra("sel", -4))),
    // vmem_dat_<t>_<i> (generated) or, with HIGGS_FPGA_XILINX,
    // vmem_dat_<t>_<i>_1_1 (hand-written): see PistonVerilog.patchVmem
    "vmem" -> StandardMacro("vmem",
      Seq(Extra("idma_valid", 4), Extra("idma_ready", -4), Extra("odma_valid", -4), Extra("odma_ready", 4),
        Extra("tvs_valid", 1), Extra("tvs_ready", -1), Extra("ivs_valid", -1), Extra("ivs_ready", 1),
        Extra("k_ctrl", -4)),
      generics = vmemParams.map(p => p -> spinal.core.VerilogValues(p))),
    "ka_decode" -> StandardMacro("ka_decode", Seq(Extra("k_ctrl", -4))),
    "p_decode" -> StandardMacro("p_decode", Seq(Extra("k_ctrl", -4))),
    "perm_full_addr" -> StandardMacro("perm_full_addr"),
    "perm_full_data" -> StandardMacro("perm_full_data"),
    "deconcat" -> DeconcatMacro,
    "piston_dp" -> PassThroughMacro("piston_dp", portsFromEdges = true)
  )
}

/** Writes piston.v, piston_dp_fft.v and piston_dp_img.v (args(0): output
  * directory, default libs/q-engine/piston/hdl). */
object PistonVerilog extends App {
  val out = PistonPaths.outDir(args)

  def read(f: File) = new String(Files.readAllBytes(f.toPath), UTF_8)
  def write(f: File, s: String) = Files.write(f.toPath, s.getBytes(UTF_8))
  def replaceOnce(s: String, from: String, to: String, what: String): String = {
    val n = s.sliding(from.length).count(_ == from)
    if (n != 1) throw new Exception(s"piston.v patch '$what': expected one match, found $n")
    s.replace(from, to)
  }

  PistonDp.variants.foreach { case (v, graph) =>
    Netlist.emit(out, s"piston_dp_$v.v")(new Netlist(graph(), PistonDp.macros, PistonDp.leafDirs))
  }
  Netlist.emit(out, "piston.v")(new Netlist(Piston.graph(), Piston.macros, Seq(PistonPaths.pistonHdl)))

  // Spinal cannot emit module parameters or `ifdef, so patch them in:
  // top-level VMEM_SIZE/VMEM0..31 (passed down from q_engine) and the
  // Xilinx vmem data module.
  val pv = new File(out, "piston.v")
  var s = read(pv)
  val defaults = Piston.vmemParams.map {
    case "VMEM_SIZE" => "  parameter VMEM_SIZE = 4096"
    case p => s"""  parameter $p = "${p.toLowerCase}.mif""""
  }
  s = replaceOnce(s, "module piston (", "module piston #(\n" + defaults.mkString(",\n") + "\n) (", "parameters")
  s = replaceOnce(s, "  vmem_dat_6_5 #(\n",
    "`ifdef HIGGS_FPGA_XILINX\n  vmem_dat_6_5_1_1 #(\n`else\n  vmem_dat_6_5 #(\n`endif\n", "vmem ifdef")
  write(pv, s)

  // every datapath must match the dp instance in piston
  val dpPorts = PistonDp.variants.map { case (v, _) =>
    v -> VerilogHeader.ports(new File(out, s"piston_dp_$v.v"), "piston_dp").toSet
  }
  dpPorts.tail.foreach { case (v, p) =>
    if (p != dpPorts.head._2)
      throw new Exception(s"piston_dp_$v.v ports differ from piston_dp_${dpPorts.head._1}.v: ${p.diff(dpPorts.head._2)}")
  }
}

/** Graph dumps for names/map.py (args(0): output directory). */
object PistonGraphs extends App {
  val out = new File(args.headOption.getOrElse("build/names"))
  PistonDp.variants.foreach { case (v, graph) => reqack.GraphJson.write(graph(), new File(out, s"piston_dp_$v.json")) }
  reqack.GraphJson.write(Piston.graph(), new File(out, "piston.json"))
}

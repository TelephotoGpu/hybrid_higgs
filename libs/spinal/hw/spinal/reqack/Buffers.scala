package reqack

import spinal.core._

/** Exact ports of reqack's elastic buffers (lib/macro-verilog.js, eb15.js,
  * eb17.js, ebfifo.js and rtl/eb*_ctrl.v). Each takes the source side
  * (req, ack, nxt) and the buffered side (mReq, mAck, dat) of one edge and
  * must be called inside the netlist clock domain. */
object Buffers {
  def apply(e: Edge, req: Bool, ack: Bool, nxt: Bits, mReq: Bool, mAck: Bool, dat: Bits): Unit = {
    val p = s"${e.name}_eb"
    e.capacity match {
      case 0.0 => mReq := req; ack := mAck // dat is nxt (same signal)
      case 1.0 => eb1(p, req, ack, nxt, mReq, mAck, dat)
      case 1.5 => eb15(p, req, ack, nxt, mReq, mAck, dat)
      case 1.7 => eb17(p, req, ack, nxt, mReq, mAck, dat)
      case c   => fifo(p, c.toInt, req, ack, nxt, mReq, mAck, dat)
    }
  }

  private def eb1(p: String, req: Bool, ack: Bool, nxt: Bits, mReq: Bool, mAck: Bool, dat: Bits): Unit = {
    val valid = RegInit(False).setName(s"${p}_valid")
    val en = Bool().setName(s"${p}_en")
    val r = Reg(Bits(nxt.getWidth bits)).setName(s"${p}_r")
    ack := !valid | mAck
    en := req & ack
    valid := !ack | req
    when(en)(r := nxt)
    mReq := valid
    dat := r
  }

  // 2-register buffers share this data path; ctrl gives (en0, en1, sel)
  private def twoRegs(p: String, nxt: Bits, en0: Bool, en1: Bool, sel: Bool, eb17: Boolean): (Bits, Bits) = {
    val r0 = Reg(Bits(nxt.getWidth bits)).setName(s"${p}_r0")
    val r1 = Reg(Bits(nxt.getWidth bits)).setName(s"${p}_r1")
    if (eb17) when(en0)(r0 := Mux(sel, r1, nxt)) else when(en0)(r0 := nxt)
    when(en1)(r1 := nxt)
    (r0, r1)
  }

  private def eb15(p: String, req: Bool, ack: Bool, nxt: Bits, mReq: Bool, mAck: Bool, dat: Bits): Unit = {
    val S0 = B"5'b10100"; val S1 = B"5'b11010"; val S2 = B"5'b01000"; val S3 = B"5'b11101"; val S4 = B"5'b01001"
    val state = RegInit(S0).setName(s"${p}_state")
    val next = Bits(5 bits).setName(s"${p}_state_nxt")
    next := state
    switch(state) {
      is(S0) { when(req)(next := S1) }
      is(S1) {
        when(!req & mAck)(next := S0)
        when(req & !mAck)(next := S2)
        when(req & mAck)(next := S3)
      }
      is(S2) { when(mAck)(next := S3) }
      is(S3) {
        when(!req & mAck)(next := S0)
        when(req & !mAck)(next := S4)
        when(req & mAck)(next := S1)
      }
      is(S4) { when(mAck)(next := S1) }
    }
    state := next
    val en0 = Bool().setName(s"${p}_en0"); en0 := state(2) & req
    val en1 = Bool().setName(s"${p}_en1"); en1 := state(1) & req
    val sel = Bool().setName(s"${p}_sel"); sel := state(0)
    ack := state(4)
    mReq := state(3)
    val (r0, r1) = twoRegs(p, nxt, en0, en1, sel, eb17 = false)
    dat := Mux(sel, r1, r0)
  }

  private def eb17(p: String, req: Bool, ack: Bool, nxt: Bits, mReq: Bool, mAck: Bool, dat: Bits): Unit = {
    val ZERO = B"7'b1001000"; val ONE = B"7'b1100110"; val TWO = B"7'b0110101"
    val state = RegInit(ZERO).setName(s"${p}_state")
    val next = Bits(7 bits).setName(s"${p}_state_nxt")
    next := state
    switch(state) {
      is(ZERO) { when(req)(next := ONE) }
      is(ONE) {
        when(!req & mAck)(next := ZERO)
        when(req & !mAck)(next := TWO)
      }
      is(TWO) { when(mAck)(next := ONE) }
    }
    state := next
    val en0 = Bool().setName(s"${p}_en0"); en0 := (state(4) | req) & (state(3) | mAck)
    val en1 = Bool().setName(s"${p}_en1"); en1 := (state(2) & req) & (state(1) ^ mAck)
    val sel = Bool().setName(s"${p}_sel"); sel := state(0)
    ack := state(6)
    mReq := state(5)
    val (r0, _) = twoRegs(p, nxt, en0, en1, sel, eb17 = true)
    dat := r0
  }

  private def fifo(p: String, c: Int, req: Bool, ack: Bool, nxt: Bits, mReq: Bool, mAck: Bool, dat: Bits): Unit = {
    val d = log2Up(c)
    val last = U(c - 1, d bits)
    val cnt = RegInit(U(0, d bits)).setName(s"${p}_cnt")
    val wrPtr = RegInit(U(0, d bits)).setName(s"${p}_wr_ptr")
    val qRdPtr = RegInit(U(0, d bits)).setName(s"${p}_q_rd_ptr")
    val rdPtr = UInt(d bits).setName(s"${p}_rd_ptr")
    val valid = RegInit(False).setName(s"${p}_valid")
    val wen = Bool().setName(s"${p}_wen")
    val ren = Bool().setName(s"${p}_ren")

    ack := !(cnt === last)
    ren := True
    wen := req & ack
    val rd = valid & mAck
    when(cnt === 0)(valid := False)
      .elsewhen(rd & cnt === 1)(valid := False)
      .otherwise(valid := True)
    when(wen)(wrPtr := Mux(wrPtr === last, U(0, d bits), wrPtr + 1))
    val rdNext = Mux(qRdPtr === last & cnt =/= 0, U(0, d bits), qRdPtr + 1)
    rdPtr := Mux(rd, rdNext, qRdPtr)
    when(rd)(qRdPtr := rdNext)
    when(rd & wen) {}
      .elsewhen(rd & cnt =/= 0)(cnt := cnt - 1)
      .elsewhen(wen)(cnt := cnt + 1)
    mReq := valid

    val mem = Mem(Bits(nxt.getWidth bits), c).setName(s"${p}_mem")
    mem.write(wrPtr, nxt, wen)
    dat := mem.readSync(rdPtr, ren).setName(s"${p}_r0")
  }
}

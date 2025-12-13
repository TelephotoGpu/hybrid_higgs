// golay_corr: streaming Efficient Golay Correlator (EGC) for the Q-engine.
//
// Contract: doc/add-fir/PLAN.md (phase 2).  Bit-exact model:
// model/golay_model.py.
//
// Words are 32-bit complex values, I in [15:0], Q in [31:16] (signed).
// Every packet is a header word plus payload; t_last marks the final word.
// Header: [31:16]=0xC0A7, [12:8]=shift, [7:6]=mode (LOAD_CFG only),
// [3:0]=op (1 DATA, 2 LOAD_CFG, 3 RESET); other bits zero.
//
// Stage k (1..M), D_k = 2**P(k), seed w_k in {+1,-1,+j,-j}:
//   ra_k[n] = conj(w_k) ra_{k-1}[n-D_k] + rb_{k-1}[n]
//   rb_k[n] = conj(w_k) ra_{k-1}[n-D_k] - rb_{k-1}[n]
// Seeds are swap/negate, so there are no multipliers.  Each stage's delayed
// branch is an addressable shift register (SRL) that shifts only on valid
// samples; since SRLs cannot be reset, a per-stage fill counter makes the
// tap read zero until D_k samples have entered since the last RESET.
//
// All datapath stages advance on `en`, derived only from the registered
// occupancy of the 2-entry output FIFO.  Config commits and RESET wait in
// S_WAIT (t_ready low) until the pipeline is empty so they apply in stream
// order.
module golay_corr
  #(parameter M = 7)
   (input  wire        clk,
    input  wire        srst,

    input  wire [31:0] t_data,
    input  wire        t_last,
    input  wire        t_valid,
    output wire        t_ready,

    output wire [31:0] i_data,
    output wire        i_last,
    output wire        i_valid,
    input  wire        i_ready,

    // sticky: [0] bad header, [1] config length, [2] reset with payload,
    //         [3] bad config word / mode 3
    output reg  [3:0]  err,
    input  wire        err_clear
    );

   localparam L     = 1 << M;
   localparam DEPTH = 1 << (M - 1);        // max stage delay
   localparam AW    = (M > 1) ? M - 1 : 1; // SRL address width
   // |ra_k|,|rb_k| <= 2**(15+k) (reached with -32768 inputs): 17+k bits
   localparam WM    = 17 + M;              // Ra/Rb width
   localparam CWD   = WM + 1;              // mode-0 sum width
   // + rounding headroom; rnd = 1 << 30 for shift 31 must be representable
   localparam RW    = (CWD + 1 > 33) ? CWD + 1 : 33;
   localparam CBW   = $clog2(M + 1);
   localparam FW    = M;                   // stage fill counter: 0..DEPTH
   localparam RFW   = M + 1;               // Ra history fill: 0..L
   // en-stages after the input register: M stages, select, round, output
   localparam TAIL  = 3;

   localparam [15:0] MAGIC = 16'hC0A7;
   localparam [3:0]  OP_DATA = 4'd1, OP_CFG = 4'd2, OP_RESET = 4'd3;
   localparam [2:0]  S_HDR = 3'd0, S_DATA = 3'd1, S_CFG = 3'd2, S_DRAIN = 3'd3,
                     S_WAIT = 3'd4;

   // ------------------------------------------------------------ output FIFO
   reg  [31:0] ob_data [0:1];
   reg  [1:0]  ob_last;
   reg  [1:0]  ob_cnt;
   reg         ob_rd, ob_wr;
   wire        en = (ob_cnt != 2'd2);

   reg  [2:0]  state;
   assign t_ready = en && (state != S_WAIT);
   wire   in_fire = t_valid & t_ready;

   // ------------------------------------------------------------ config
   reg [3:0]     cp [0:M-1];
   reg [1:0]     cw [0:M-1];
   reg [4:0]     shift;
   reg [1:0]     mode;
   reg [3:0]     sp [0:M-1];
   reg [1:0]     sw [0:M-1];
   reg [4:0]     s_shift;
   reg [1:0]     s_mode;
   reg           s_bad;
   reg [CBW-1:0] ccnt;
   reg           pend_cfg, pend_rst;
   reg [2:0]     wait_next;

   wire [3:0] op     = t_data[3:0];
   wire       hdr_ok = (t_data[31:16] == MAGIC) && (t_data[15:13] == 3'b0) &&
                       (t_data[5:4] == 2'b0) &&
                       (op == OP_DATA || op == OP_CFG || op == OP_RESET) &&
                       (op == OP_CFG || t_data[7:6] == 2'b0);
   /* verilator lint_off WIDTH */
   wire       word_ok = (t_data[31:6] == 26'b0) && (t_data[3:0] < M);
   localparam [CBW-1:0] LASTC = M - 1;
   /* verilator lint_on WIDTH */
   wire       cfg_full = (ccnt == LASTC);

   wire       do_sample = in_fire && (state == S_DATA);
   wire       pipe_busy;
   wire       apply = (state == S_WAIT) && !pipe_busy;
   wire       do_reset = apply && pend_rst;

   integer k;

   always @(posedge clk) begin
      if (srst) begin
         state <= S_HDR;
         ccnt <= 0;
         /* verilator lint_off WIDTH */
         shift <= M;
         mode <= 2'd0;
         s_shift <= 5'd0;
         s_mode <= 2'd0;
         s_bad <= 1'b0;
         pend_cfg <= 1'b0;
         pend_rst <= 1'b0;
         wait_next <= S_HDR;
         err <= 4'b0;
         for (k = 0; k < M; k = k + 1) begin
            cp[k] <= k;
            /* verilator lint_on WIDTH */
            cw[k] <= 2'd0;
            sp[k] <= 4'd0;
            sw[k] <= 2'd0;
         end
      end
      else begin
         if (err_clear)
           err <= 4'b0;
         if (apply) begin
            if (pend_cfg) begin
               for (k = 0; k < M; k = k + 1) begin
                  cp[k] <= sp[k];
                  cw[k] <= sw[k];
               end
               shift <= s_shift;
               mode <= s_mode;
            end
            pend_cfg <= 1'b0;
            pend_rst <= 1'b0;
            state <= wait_next;
         end
         if (in_fire) begin
            case (state)
              S_HDR: begin
                 if (!hdr_ok) begin
                    err[0] <= 1'b1;
                    state <= t_last ? S_HDR : S_DRAIN;
                 end
                 else if (op == OP_DATA)
                   state <= t_last ? S_HDR : S_DATA;
                 else if (op == OP_CFG) begin
                    if (t_data[7:6] == 2'd3) begin
                       err[3] <= 1'b1;
                       state <= t_last ? S_HDR : S_DRAIN;
                    end
                    else if (t_last) begin
                       err[1] <= 1'b1;
                       state <= S_HDR;
                    end
                    else begin
                       ccnt <= 0;
                       s_bad <= 1'b0;
                       s_shift <= t_data[12:8];
                       s_mode <= t_data[7:6];
                       state <= S_CFG;
                    end
                 end
                 else begin
                    if (!t_last)
                      err[2] <= 1'b1;
                    pend_rst <= 1'b1;
                    wait_next <= t_last ? S_HDR : S_DRAIN;
                    state <= S_WAIT;
                 end
              end
              S_DATA:
                if (t_last)
                  state <= S_HDR;
              S_CFG: begin
                 sp[ccnt] <= t_data[3:0];
                 sw[ccnt] <= t_data[5:4];
                 ccnt <= ccnt + 1'b1;
                 if (!word_ok)
                   s_bad <= 1'b1;
                 if (cfg_full) begin
                    if (s_bad || !word_ok)
                      err[3] <= 1'b1;
                    if (!t_last) begin
                       err[1] <= 1'b1;
                       state <= S_DRAIN;
                    end
                    else if (s_bad || !word_ok)
                      state <= S_HDR;
                    else begin
                       pend_cfg <= 1'b1;
                       wait_next <= S_HDR;
                       state <= S_WAIT;
                    end
                 end
                 else if (t_last) begin
                    err[1] <= 1'b1;
                    if (s_bad || !word_ok)
                      err[3] <= 1'b1;
                    state <= S_HDR;
                 end
              end
              S_DRAIN:
                if (t_last)
                  state <= S_HDR;
              default: ;
            endcase
         end
      end
   end

   // ------------------------------------------------------------ input register
   reg        v0, l0;
   reg [31:0] x0;

   always @(posedge clk) begin
      if (srst) begin
         v0 <= 1'b0;
         l0 <= 1'b0;
         x0 <= 32'b0;
      end
      else if (en) begin
         v0 <= do_sample;
         l0 <= t_last;
         x0 <= t_data;
      end
   end

   // ------------------------------------------------------------ EGC stages
   // Buses carry each stage's output sign-extended to WM bits; index 0 is x.
   wire [(M+1)*WM-1:0] bra_r, bra_i, brb_r, brb_i;
   wire [M:0]          bv, bl;

   assign bra_r[WM-1:0] = {{(WM-16){x0[15]}}, x0[15:0]};
   assign bra_i[WM-1:0] = {{(WM-16){x0[31]}}, x0[31:16]};
   assign brb_r[WM-1:0] = bra_r[WM-1:0];
   assign brb_i[WM-1:0] = bra_i[WM-1:0];
   assign bv[0] = v0;
   assign bl[0] = l0;

   genvar g;
   generate
      for (g = 1; g <= M; g = g + 1) begin : stg
         localparam WI = (g == 1) ? 16 : 16 + g;
         localparam WO = 17 + g;

         wire signed [WI-1:0] ar = bra_r[(g-1)*WM +: WI];
         wire signed [WI-1:0] ai = bra_i[(g-1)*WM +: WI];
         wire signed [WI-1:0] br = brb_r[(g-1)*WM +: WI];
         wire signed [WI-1:0] bi = brb_i[(g-1)*WM +: WI];
         wire                 vin = bv[g-1];

         // delayed branch: SRL of ra_{k-1}, newest at index 0
         reg [2*WI-1:0] srl [0:DEPTH-1];
         reg [FW-1:0]   fill;
         integer        j;

         always @(posedge clk) begin
            if (en && vin) begin
               srl[0] <= {ai, ar};
               for (j = 1; j < DEPTH; j = j + 1)
                 srl[j] <= srl[j-1];
            end
         end

         wire [3:0]     p    = cp[g-1];
         wire [1:0]     w    = cw[g-1];
         /* verilator lint_off WIDTH */
         wire [AW-1:0]  addr = ({{AW{1'b0}}, 1'b1} << p) - 1'b1;
         wire [FW:0]    dval = {{FW{1'b0}}, 1'b1} << p;
         /* verilator lint_on WIDTH */
         wire           have = ({1'b0, fill} >= dval);
         wire [2*WI-1:0] tap = have ? srl[addr] : {2*WI{1'b0}};
         wire signed [WI-1:0] tr = tap[WI-1:0];
         wire signed [WI-1:0] ti = tap[2*WI-1:WI];

         always @(posedge clk) begin
            if (srst || do_reset)
              fill <= {FW{1'b0}};
            /* verilator lint_off WIDTH */
            else if (en && vin && fill != DEPTH)
            /* verilator lint_on WIDTH */
              fill <= fill + 1'b1;
         end

         // conj(w) * tap: +1 -> (r,i); -1 -> (-r,-i); +j -> (i,-r); -j -> (-i,r)
         wire signed [WO-1:0] er = {{(WO-WI){tr[WI-1]}}, tr};
         wire signed [WO-1:0] ei = {{(WO-WI){ti[WI-1]}}, ti};
         reg  signed [WO-1:0] dr, di;
         always @(*) begin
            case (w)
              2'd0: begin dr = er;  di = ei;  end
              2'd1: begin dr = -er; di = -ei; end
              2'd2: begin dr = ei;  di = -er; end
              default: begin dr = -ei; di = er; end
            endcase
         end

         wire signed [WO-1:0] xr = {{(WO-WI){br[WI-1]}}, br};
         wire signed [WO-1:0] xi = {{(WO-WI){bi[WI-1]}}, bi};
         reg  signed [WO-1:0] ra_r, ra_i, rb_r, rb_i;
         reg                  v, l;

         always @(posedge clk) begin
            if (srst) begin
               v <= 1'b0;
               l <= 1'b0;
               ra_r <= 0;
               ra_i <= 0;
               rb_r <= 0;
               rb_i <= 0;
            end
            else if (en) begin
               v <= vin;
               l <= bl[g-1];
               ra_r <= dr + xr;
               ra_i <= di + xi;
               rb_r <= dr - xr;
               rb_i <= di - xi;
            end
         end

         assign bra_r[g*WM +: WM] = {{(WM-WO){ra_r[WO-1]}}, ra_r};
         assign bra_i[g*WM +: WM] = {{(WM-WO){ra_i[WO-1]}}, ra_i};
         assign brb_r[g*WM +: WM] = {{(WM-WO){rb_r[WO-1]}}, rb_r};
         assign brb_i[g*WM +: WM] = {{(WM-WO){rb_i[WO-1]}}, rb_i};
         assign bv[g] = v;
         assign bl[g] = l;
      end
   endgenerate

   wire signed [WM-1:0] Ra_r = bra_r[M*WM +: WM];
   wire signed [WM-1:0] Ra_i = bra_i[M*WM +: WM];
   wire signed [WM-1:0] Rb_r = brb_r[M*WM +: WM];
   wire signed [WM-1:0] Rb_i = brb_i[M*WM +: WM];
   wire                 vM = bv[M];
   wire                 lM = bl[M];

   // ------------------------------------------------------------ Ra history, mode select
   // flat shift vector (fixed tap at L-1): newest word in the low bits
   reg [L*2*WM-1:0] rh;
   reg [RFW-1:0]    rfill;

   always @(posedge clk) begin
      if (en && vM)
        rh <= {rh[(L-1)*2*WM-1:0], Ra_i, Ra_r};
   end

   always @(posedge clk) begin
      if (srst || do_reset)
        rfill <= {RFW{1'b0}};
      /* verilator lint_off WIDTH */
      else if (en && vM && rfill != L)
      /* verilator lint_on WIDTH */
        rfill <= rfill + 1'b1;
   end

   /* verilator lint_off WIDTH */
   wire [2*WM-1:0]      rold = (rfill == L) ? rh[(L-1)*2*WM +: 2*WM] : {2*WM{1'b0}};
   /* verilator lint_on WIDTH */
   wire signed [WM-1:0] ro_r = rold[WM-1:0];
   wire signed [WM-1:0] ro_i = rold[2*WM-1:WM];

   reg signed [CWD-1:0] s_r, s_i;
   reg                  vs, ls;

   always @(posedge clk) begin
      if (srst) begin
         vs <= 1'b0;
         ls <= 1'b0;
         s_r <= 0;
         s_i <= 0;
      end
      else if (en) begin
         vs <= vM;
         ls <= lM;
         case (mode)
           2'd0: begin
              s_r <= {ro_r[WM-1], ro_r} + {Rb_r[WM-1], Rb_r};
              s_i <= {ro_i[WM-1], ro_i} + {Rb_i[WM-1], Rb_i};
           end
           2'd1: begin
              s_r <= {Ra_r[WM-1], Ra_r};
              s_i <= {Ra_i[WM-1], Ra_i};
           end
           default: begin
              s_r <= {Rb_r[WM-1], Rb_r};
              s_i <= {Rb_i[WM-1], Rb_i};
           end
         endcase
      end
   end

   // ------------------------------------------------------------ round, shift, saturate
   wire signed [RW-1:0] rnd = (shift == 5'd0) ? {RW{1'b0}} :
                              ({{(RW-1){1'b0}}, 1'b1} <<< (shift - 5'd1));
   reg signed [RW-1:0]  rr, ri;
   reg                  vr, lr;

   always @(posedge clk) begin
      if (srst) begin
         vr <= 1'b0;
         lr <= 1'b0;
         rr <= 0;
         ri <= 0;
      end
      else if (en) begin
         vr <= vs;
         lr <= ls;
         rr <= $signed({{(RW-CWD){s_r[CWD-1]}}, s_r}) + rnd;
         ri <= $signed({{(RW-CWD){s_i[CWD-1]}}, s_i}) + rnd;
      end
   end

   wire signed [RW-1:0] qr = rr >>> shift;
   wire signed [RW-1:0] qi = ri >>> shift;

   function [15:0] sat16;
      input signed [RW-1:0] v;
      begin
         if (v > $signed({{(RW-16){1'b0}}, 16'h7FFF}))
           sat16 = 16'h7FFF;
         else if (v < $signed({{(RW-16){1'b1}}, 16'h8000}))
           sat16 = 16'h8000;
         else
           sat16 = v[15:0];
      end
   endfunction

   reg [31:0] y;
   reg        vy, ly;

   always @(posedge clk) begin
      if (srst) begin
         vy <= 1'b0;
         ly <= 1'b0;
         y <= 32'b0;
      end
      else if (en) begin
         vy <= vr;
         ly <= lr;
         y <= {sat16(qi), sat16(qr)};
      end
   end

   assign pipe_busy = v0 | (|bv[M:1]) | vs | vr | vy;

   // ------------------------------------------------------------ output FIFO
   wire push = en & vy;
   wire pop  = i_ready & (ob_cnt != 2'd0);

   always @(posedge clk) begin
      if (srst) begin
         ob_cnt <= 2'd0;
         ob_rd <= 1'b0;
         ob_wr <= 1'b0;
         ob_last <= 2'b0;
         ob_data[0] <= 32'b0;
         ob_data[1] <= 32'b0;
      end
      else begin
         if (push) begin
            ob_data[ob_wr] <= y;
            ob_last[ob_wr] <= ly;
            ob_wr <= ~ob_wr;
         end
         if (pop)
           ob_rd <= ~ob_rd;
         ob_cnt <= ob_cnt + {1'b0, push} - {1'b0, pop};
      end
   end

   assign i_valid = (ob_cnt != 2'd0);
   assign i_data  = ob_data[ob_rd];
   assign i_last  = ob_last[ob_rd];

endmodule

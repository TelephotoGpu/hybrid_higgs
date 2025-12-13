// fft_corr: streaming FFT overlap-save cross-correlator for the Q-engine.
//
// Contract: doc/add-fir/PLAN.md (phase 3).  Bit-exact model:
// model/fft_corr_model.py.
//
// Words are 32-bit complex values, I in [15:0], Q in [31:16] (signed).
// Every packet is a header word plus payload; t_last marks the final word.
// Header: [31:16]=0xFC0A, [15:14]=mode, [13:8]=shift (DATA only),
// [7:4]=0, [3:0]=op (1 DATA, 2 LOAD_REF, 3 RESET).
//
//   y[n] = sum_{i<R} conj(ref[i]) x[n-R+1+i]
//
// K = 2N point radix-2^2 single-path delay-feedback (SDF) pipelines: a DIF
// forward core (natural in, bit-reversed out) and its transpose, a DIT
// inverse core (bit-reversed in, natural out).  A block is the last K input
// samples, launched after B = N+1 new samples or at a DATA packet's last
// beat; positions K-m..K-1 of the inverse output are its m new outputs.
//
// Frames through the cores are always K contiguous cycles; every stage has
// a fixed latency and never stalls.  A block is launched only when the
// output FIFO has room reserved for all of its outputs.  LOAD_REF waits for
// earlier blocks to pass the X*H multiplier, then runs the reference
// through the forward core into the H BRAM (t_ready low meanwhile).
module fft_corr
  #(parameter N = 256)
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

    // sticky: [0] bad header, [1] LOAD_REF length, [2] reset with payload
    output reg  [2:0]  err,
    input  wire        err_clear
    );

   localparam K    = 2 * N;
   localparam LK   = $clog2(K);
   localparam B    = N + 1;
   localparam W    = 27;
   localparam NG   = LK / 2;            // radix-2^2 groups
   localparam ODD  = LK % 2;
   localparam NS   = 4 * NG + ODD;      // pipeline stage slots per core
   localparam OFD  = 4 * N;             // output FIFO depth (>= 2B)
   localparam LOF  = $clog2(OFD);
   localparam RA   = LK + 1;            // ring address bits (2K entries)
   localparam CW   = LK + 2;            // counters 0..2K
   localparam MQ   = 8;                 // frame metadata FIFO depth (> frames in flight)

   localparam [15:0] MAGIC = 16'hFC0A;
   localparam [3:0]  OP_DATA = 4'd1, OP_REF = 4'd2, OP_RESET = 4'd3;
   localparam [2:0]  S_HDR = 3'd0, S_DATA = 3'd1, S_REF = 3'd2, S_DRAIN = 3'd3,
                     S_WREF = 3'd4, S_WCAP = 3'd5;

   initial begin
      if (N < 16 || N > 1024 || (1 << $clog2(N)) != N) begin
         $display("fft_corr: N must be a power of 2 in 16..1024");
         $finish;
      end
   end

   // ================================================================ output FIFO
   reg [32:0]  of_mem [0:OFD-1];
   reg [LOF-1:0] of_wa, of_ra;
   reg [LOF:0]   of_cnt;               // entries in of_mem
   reg           of_v;
   reg [32:0]    of_q;
   reg           of_wr;
   reg [32:0]    of_wd;
   wire          of_pop  = of_v & i_ready;
   wire          of_load = (of_cnt != 0) && (!of_v || of_pop);
   assign i_valid = of_v;
   assign i_data  = of_q[31:0];
   assign i_last  = of_q[32];

   always @(posedge clk) begin
      if (of_wr) of_mem[of_wa] <= of_wd;
      if (of_load) of_q <= of_mem[of_ra];
   end
   always @(posedge clk) begin
      if (srst) begin
         of_wa <= 0; of_ra <= 0; of_cnt <= 0; of_v <= 1'b0;
      end else begin
         if (of_wr) of_wa <= of_wa + 1'b1;
         if (of_load) of_ra <= of_ra + 1'b1;
         of_cnt <= of_cnt + (of_wr ? 1'b1 : 1'b0) - (of_load ? 1'b1 : 1'b0);
         if (of_load) of_v <= 1'b1;
         else if (of_pop) of_v <= 1'b0;
      end
   end

   // ================================================================ front end
   reg [2:0]    state;
   reg          init;                  // power-up reference load pending
   reg [1:0]    d_mode;
   reg [5:0]    d_shift;
   reg [CW-1:0] pend;                  // new samples not yet in a block
   reg [CW-1:0] since_rst;             // samples since RESET, saturates at K
   reg [RA-1:0] wptr;
   reg [CW-1:0] rcnt;                  // LOAD_REF taps, saturates at N+1
   reg [CW-1:0] r_len;                 // committed-for-FFT reference length

   // block request (one deep)
   reg          q_v;
   reg [RA-1:0] q_end;
   reg [CW-1:0] q_m, q_avail;
   reg          q_last;
   reg [1:0]    q_mode;
   reg [5:0]    q_shift;

   reg [31:0]   ring  [0:2*K-1];
   reg [31:0]   stage [0:N-1];

   assign t_ready = (state == S_HDR) || (state == S_REF) || (state == S_DRAIN)
                    || (state == S_DATA && !q_v);
   wire in_fire = t_valid & t_ready;

   wire [3:0] h_op = t_data[3:0];
   wire hdr_ok = (t_data[31:16] == MAGIC) && (t_data[7:4] == 4'd0)
                 && (h_op == OP_DATA ? (t_data[15:14] < 2'd2)
                     : ((h_op == OP_REF || h_op == OP_RESET) && t_data[15:8] == 8'd0));

   // feeder / pipeline status used by the front end
   reg          f_run;
   reg [CW-1:0] inflight;              // data frames not yet past X*H
   reg          cap_done;
   wire         ref_go;

   assign ref_go = (state == S_WREF) && !q_v && !f_run && (inflight == 0);

   wire [CW-1:0] pend1  = pend + 1'b1;
   wire [CW-1:0] since1 = (since_rst == K) ? since_rst : since_rst + 1'b1;
   wire          launch_data;

   always @(posedge clk) begin
      if (in_fire && state == S_DATA) ring[wptr] <= t_data;
      if (in_fire && state == S_REF && rcnt < N) stage[rcnt[LK-1:0]] <= t_data;
   end

   always @(posedge clk) begin
      if (srst) begin
         state <= S_WREF; init <= 1'b1;
         err <= 3'd0;
         pend <= 0; since_rst <= 0; wptr <= 0; rcnt <= 0; r_len <= 1;
         q_v <= 1'b0; d_mode <= 2'd0; d_shift <= 6'd0;
      end else begin
         if (err_clear) err <= 3'd0;
         if (launch_data) q_v <= 1'b0;
         case (state)
           S_HDR: if (in_fire) begin
              if (!hdr_ok) begin
                 err[0] <= 1'b1;
                 if (!t_last) state <= S_DRAIN;
              end else if (h_op == OP_DATA) begin
                 d_mode <= t_data[15:14];
                 d_shift <= t_data[13:8];
                 if (!t_last) state <= S_DATA;
              end else if (h_op == OP_REF) begin
                 rcnt <= 0;
                 if (t_last) err[1] <= 1'b1;
                 else state <= S_REF;
              end else begin
                 since_rst <= 0;
                 if (!t_last) begin
                    err[2] <= 1'b1;
                    state <= S_DRAIN;
                 end
              end
           end
           S_DATA: if (in_fire) begin
              wptr <= wptr + 1'b1;
              since_rst <= since1;
              if (pend1 == B || t_last) begin
                 q_v <= 1'b1;
                 q_end <= wptr;
                 q_m <= pend1;
                 q_avail <= since1;
                 q_last <= t_last;
                 q_mode <= d_mode;
                 q_shift <= d_shift;
                 pend <= 0;
              end else begin
                 pend <= pend1;
              end
              if (t_last) state <= S_HDR;
           end
           S_REF: if (in_fire) begin
              if (rcnt <= N) rcnt <= rcnt + 1'b1;
              if (t_last) begin
                 if (rcnt + 1'b1 <= N) begin
                    r_len <= rcnt + 1'b1;
                    state <= S_WREF;
                 end else begin
                    err[1] <= 1'b1;
                    state <= S_HDR;
                 end
              end
           end
           S_DRAIN: if (in_fire && t_last) state <= S_HDR;
           S_WREF: if (ref_go) state <= S_WCAP;
           S_WCAP: if (cap_done) begin
              state <= S_HDR;
              init <= 1'b0;
           end
           default: state <= S_HDR;
         endcase
      end
   end

   // ================================================================ feeder
   // launch: reserve output FIFO room, record frame metadata
   reg [LOF+1:0] resv;                 // reserved output slots
   wire [LOF+1:0] of_used = of_cnt + of_v + resv;
   wire          credit_ok = (OFD - of_used) >= q_m;
   assign launch_data = q_v && !f_run && (state != S_WCAP) && credit_ok
                        && !(state == S_WREF && ref_go);

   reg          f_tag;                 // 1 = reference frame
   reg          f_init;
   reg [CW-1:0] f_i;
   reg [RA-1:0] f_lo;
   reg [CW-1:0] f_zero;               // positions < f_zero read as 0
   reg [CW-1:0] f_rlen;

   // metadata FIFO: {e, m, last, mode, shift} per data frame
   reg [CW-1:0] mq_m    [0:MQ-1];
   reg          mq_last [0:MQ-1];
   reg [1:0]    mq_mode [0:MQ-1];
   reg [5:0]    mq_shift[0:MQ-1];
   reg signed [6:0] mq_g [0:MQ-1];
   reg [2:0]    mq_wa, mq_ra;
   reg [3:0]    mq_cnt;
   wire         mq_pop;

   reg signed [5:0] h_e;               // committed H exponent
   wire signed [6:0] h_g = 2 * LK - 1 - h_e;

   // read pipeline: a0 (address) -> a1 (RAM data) -> DIF input register
   reg          a1_v, a1_sof, a1_tag, a1_zero, a1_init0;
   reg [31:0]   a1_ring, a1_stage;
   reg          a2_v, a2_sof, a2_tag;
   reg signed [W-1:0] a2_re, a2_im;
   wire [CW-1:0] f_ridx = f_rlen - 1'b1 - f_i;   // staging index for c[f_i]

   always @(posedge clk) begin
      a1_ring  <= ring[f_lo + f_i[RA-1:0]];
      a1_stage <= stage[f_ridx[LK-1:0]];
   end

   always @(posedge clk) begin
      if (srst) begin
         f_run <= 1'b0; resv <= 0;
         mq_wa <= 0; mq_ra <= 0; mq_cnt <= 0;
         a1_v <= 1'b0; a2_v <= 1'b0; a1_sof <= 1'b0; a2_sof <= 1'b0;
      end else begin
         resv <= resv + (launch_data ? q_m : 0) - (of_wr ? 1'b1 : 1'b0);
         mq_cnt <= mq_cnt + (launch_data ? 1'b1 : 1'b0) - (mq_pop ? 1'b1 : 1'b0);
         if (mq_pop) mq_ra <= mq_ra + 1'b1;
         if (launch_data) begin
            f_run <= 1'b1; f_i <= 0; f_tag <= 1'b0; f_init <= 1'b0;
            f_lo <= q_end - (K - 1);
            f_zero <= K - q_avail;
            mq_m[mq_wa] <= q_m; mq_last[mq_wa] <= q_last;
            mq_mode[mq_wa] <= q_mode; mq_shift[mq_wa] <= q_shift;
            mq_g[mq_wa] <= h_g;
            mq_wa <= mq_wa + 1'b1;
         end else if (ref_go) begin
            f_run <= 1'b1; f_i <= 0; f_tag <= 1'b1; f_init <= init;
            f_rlen <= r_len;
         end else if (f_run) begin
            f_i <= f_i + 1'b1;
            if (f_i == K - 1) f_run <= 1'b0;
         end
         a1_v <= f_run;
         a1_sof <= f_run && (f_i == 0);
         a1_tag <= f_tag;
         a1_zero <= f_tag ? (f_i >= f_rlen) : (f_i < f_zero);
         a1_init0 <= f_init;
         a2_v <= a1_v;
         a2_sof <= a1_sof;
         a2_tag <= a1_tag;
      end
      // data (no reset needed)
      if (a1_zero || (a1_init0 && !a1_sof)) begin
         a2_re <= 0; a2_im <= 0;
      end else if (a1_init0) begin
         a2_re <= $signed({16'sh7fff, 9'd0}); a2_im <= 0;
      end else if (a1_tag) begin
         a2_re <= $signed({{2{a1_stage[15]}}, a1_stage[15:0], 9'd0});
         a2_im <= -$signed({{2{a1_stage[31]}}, a1_stage[31:16], 9'd0});
      end else begin
         a2_re <= $signed({{2{a1_ring[15]}}, a1_ring[15:0], 9'd0});
         a2_im <= $signed({{2{a1_ring[31]}}, a1_ring[31:16], 9'd0});
      end
   end

   // ================================================================ forward core
   /* verilator lint_off UNOPTFLAT */
   wire              fv  [0:NS];
   wire              fs  [0:NS];
   wire              ft  [0:NS];
   wire signed [W-1:0] fre [0:NS];
   wire signed [W-1:0] fim [0:NS];
   /* verilator lint_on UNOPTFLAT */
   assign fv[0] = a2_v; assign fs[0] = a2_sof; assign ft[0] = a2_tag;
   assign fre[0] = a2_re; assign fim[0] = a2_im;

   genvar gi;
   generate
      for (gi = 0; gi < NG; gi = gi + 1) begin : g_dif
         localparam S = K >> (2 * gi);
         fftc_bf #(.D(S/2), .W(W), .K(K)) b1
           (.clk(clk), .srst(srst),
            .iv(fv[4*gi]), .isof(fs[4*gi]), .itag(ft[4*gi]), .ire(fre[4*gi]), .iim(fim[4*gi]),
            .ov(fv[4*gi+1]), .osof(fs[4*gi+1]), .otag(ft[4*gi+1]), .ore(fre[4*gi+1]), .oim(fim[4*gi+1]));
         fftc_jrot #(.S(S), .W(W), .POS(0)) j1
           (.clk(clk), .srst(srst),
            .iv(fv[4*gi+1]), .isof(fs[4*gi+1]), .itag(ft[4*gi+1]), .ire(fre[4*gi+1]), .iim(fim[4*gi+1]),
            .ov(fv[4*gi+2]), .osof(fs[4*gi+2]), .otag(ft[4*gi+2]), .ore(fre[4*gi+2]), .oim(fim[4*gi+2]));
         fftc_bf #(.D(S/4), .W(W), .K(K)) b2
           (.clk(clk), .srst(srst),
            .iv(fv[4*gi+2]), .isof(fs[4*gi+2]), .itag(ft[4*gi+2]), .ire(fre[4*gi+2]), .iim(fim[4*gi+2]),
            .ov(fv[4*gi+3]), .osof(fs[4*gi+3]), .otag(ft[4*gi+3]), .ore(fre[4*gi+3]), .oim(fim[4*gi+3]));
         if (S > 4) begin : g_tw
            fftc_tw #(.S(S), .W(W), .CONJ(0)) t1
              (.clk(clk), .srst(srst),
               .iv(fv[4*gi+3]), .isof(fs[4*gi+3]), .itag(ft[4*gi+3]), .ire(fre[4*gi+3]), .iim(fim[4*gi+3]),
               .ov(fv[4*gi+4]), .osof(fs[4*gi+4]), .otag(ft[4*gi+4]), .ore(fre[4*gi+4]), .oim(fim[4*gi+4]));
         end else begin : g_notw
            assign fv[4*gi+4] = fv[4*gi+3]; assign fs[4*gi+4] = fs[4*gi+3];
            assign ft[4*gi+4] = ft[4*gi+3];
            assign fre[4*gi+4] = fre[4*gi+3]; assign fim[4*gi+4] = fim[4*gi+3];
         end
      end
      if (ODD) begin : g_dif_odd
         fftc_bf #(.D(1), .W(W), .K(K)) b0
           (.clk(clk), .srst(srst),
            .iv(fv[NS-1]), .isof(fs[NS-1]), .itag(ft[NS-1]), .ire(fre[NS-1]), .iim(fim[NS-1]),
            .ov(fv[NS]), .osof(fs[NS]), .otag(ft[NS]), .ore(fre[NS]), .oim(fim[NS]));
      end
   endgenerate

   // ================================================================ H capture and X*H
   reg [2*W-1:0] hmem [0:K-1];
   reg [LK-1:0]  x_p;                  // forward output position
   wire [LK-1:0] x_pos = fs[NS] ? {LK{1'b0}} : x_p;
   wire          x_dat = fv[NS] && !ft[NS];
   wire          x_ref = fv[NS] && ft[NS];

   function [W-1:0] fabs;
      input signed [W-1:0] v;
      fabs = v[W-1] ? -v : v;
   endfunction
   function signed [5:0] fexp;         // 17 - bitlen(m), 0 for m = 0
      input [W-1:0] m;
      integer b;
      begin
         fexp = 0;
         for (b = 0; b < W; b = b + 1)
            if (m[b]) fexp = 17 - (b + 1);
      end
   endfunction

   reg [W-1:0]   cap_max;
   wire [W-1:0]  mr = fabs(fre[NS]);
   wire [W-1:0]  mi = fabs(fim[NS]);
   wire [W-1:0]  m1 = (mr > cap_max) ? mr : cap_max;
   wire [W-1:0]  m2 = (mi > m1) ? mi : m1;
   wire [W-1:0]  cap_m = (x_pos == 0) ? ((mr > mi) ? mr : mi) : m2;

   always @(posedge clk) begin
      if (x_ref) hmem[x_pos] <= {fim[NS], fre[NS]};
   end

   always @(posedge clk) begin
      if (srst) begin
         x_p <= 0; cap_done <= 1'b0; h_e <= 0; cap_max <= 0;
      end else begin
         if (fv[NS]) x_p <= x_pos + 1'b1;
         cap_done <= 1'b0;
         if (x_ref) begin
            cap_max <= cap_m;
            if (x_pos == K - 1) begin
               h_e <= fexp(cap_m);
               cap_done <= 1'b1;
            end
         end
      end
      if (srst) inflight <= 0;
      else inflight <= inflight + (launch_data ? 1'b1 : 1'b0)
                       - ((x_dat && x_pos == K - 1) ? 1'b1 : 1'b0);
   end

   // c0: address H; c1: raw H; c2: normalized H; c3: products; c4: P
   reg [2*W-1:0] c1_h;
   reg           c1_v, c1_s, c2_v, c2_s, c3_v, c3_s, c4_v, c4_s;
   reg signed [W-1:0] c1_xr, c1_xi, c2_xr, c2_xi;
   reg signed [17:0]  c2_hr, c2_hi;
   reg signed [W+17:0] c3_rr, c3_ii, c3_ri, c3_ir;
   reg signed [W-1:0] c4_re, c4_im;

   function signed [17:0] hnorm;       // sat18(rs(v, -e))
      input signed [W-1:0] v;
      input signed [5:0]   e;
      reg signed [W+16:0]  t;
      begin
         if (e >= 0)
            t = $signed(v) <<< e;
         else
            t = ($signed(v) + $signed((1 << (-e - 1)))) >>> (-e);
         if (t > 131071) hnorm = 18'sd131071;
         else if (t < -131072) hnorm = -18'sd131072;
         else hnorm = t[17:0];
      end
   endfunction

   function signed [W-1:0] psat;       // sat27(rs(v, 17))
      input signed [W+18:0] v;
      reg signed [W+18:0] t;
      begin
         t = (v + 46'sd65536) >>> 17;
         if (t > 67108863) psat = 27'sd67108863;
         else if (t < -67108864) psat = -27'sd67108864;
         else psat = t[W-1:0];
      end
   endfunction

   always @(posedge clk) begin
      c1_h <= hmem[x_pos];
      c1_xr <= fre[NS]; c1_xi <= fim[NS];
      c2_xr <= c1_xr; c2_xi <= c1_xi;
      c2_hr <= hnorm(c1_h[W-1:0], h_e);
      c2_hi <= hnorm(c1_h[2*W-1:W], h_e);
      c3_rr <= c2_xr * c2_hr;
      c3_ii <= c2_xi * c2_hi;
      c3_ri <= c2_xr * c2_hi;
      c3_ir <= c2_xi * c2_hr;
      c4_re <= psat($signed({c3_rr[W+17], c3_rr}) - $signed({c3_ii[W+17], c3_ii}));
      c4_im <= psat($signed({c3_ri[W+17], c3_ri}) + $signed({c3_ir[W+17], c3_ir}));
   end
   always @(posedge clk) begin
      if (srst) begin
         c1_v <= 0; c2_v <= 0; c3_v <= 0; c4_v <= 0;
         c1_s <= 0; c2_s <= 0; c3_s <= 0; c4_s <= 0;
      end else begin
         c1_v <= x_dat; c1_s <= x_dat && fs[NS];
         c2_v <= c1_v; c2_s <= c1_s;
         c3_v <= c2_v; c3_s <= c2_s;
         c4_v <= c3_v; c4_s <= c3_s;
      end
   end

   // ================================================================ inverse core
   /* verilator lint_off UNOPTFLAT */
   wire              iv_  [0:NS];
   wire              is_  [0:NS];
   wire              it_  [0:NS];
   wire signed [W-1:0] ire_ [0:NS];
   wire signed [W-1:0] iim_ [0:NS];
   /* verilator lint_on UNOPTFLAT */
   assign iv_[0] = c4_v; assign is_[0] = c4_s; assign it_[0] = 1'b0;
   assign ire_[0] = c4_re; assign iim_[0] = c4_im;

   generate
      if (ODD) begin : g_dit_odd
         fftc_bf #(.D(1), .W(W), .K(K)) b0
           (.clk(clk), .srst(srst),
            .iv(iv_[0]), .isof(is_[0]), .itag(it_[0]), .ire(ire_[0]), .iim(iim_[0]),
            .ov(iv_[1]), .osof(is_[1]), .otag(it_[1]), .ore(ire_[1]), .oim(iim_[1]));
      end
      for (gi = 0; gi < NG; gi = gi + 1) begin : g_dit
         localparam S  = K >> (2 * (NG - 1 - gi));
         localparam I0 = ODD + 4 * gi;
         if (S > 4) begin : g_tw
            fftc_tw #(.S(S), .W(W), .CONJ(1)) t1
              (.clk(clk), .srst(srst),
               .iv(iv_[I0]), .isof(is_[I0]), .itag(it_[I0]), .ire(ire_[I0]), .iim(iim_[I0]),
               .ov(iv_[I0+1]), .osof(is_[I0+1]), .otag(it_[I0+1]), .ore(ire_[I0+1]), .oim(iim_[I0+1]));
         end else begin : g_notw
            assign iv_[I0+1] = iv_[I0]; assign is_[I0+1] = is_[I0]; assign it_[I0+1] = it_[I0];
            assign ire_[I0+1] = ire_[I0]; assign iim_[I0+1] = iim_[I0];
         end
         fftc_bf #(.D(S/4), .W(W), .K(K)) b2
           (.clk(clk), .srst(srst),
            .iv(iv_[I0+1]), .isof(is_[I0+1]), .itag(it_[I0+1]), .ire(ire_[I0+1]), .iim(iim_[I0+1]),
            .ov(iv_[I0+2]), .osof(is_[I0+2]), .otag(it_[I0+2]), .ore(ire_[I0+2]), .oim(iim_[I0+2]));
         fftc_jrot #(.S(S), .W(W), .POS(1)) j1
           (.clk(clk), .srst(srst),
            .iv(iv_[I0+2]), .isof(is_[I0+2]), .itag(it_[I0+2]), .ire(ire_[I0+2]), .iim(iim_[I0+2]),
            .ov(iv_[I0+3]), .osof(is_[I0+3]), .otag(it_[I0+3]), .ore(ire_[I0+3]), .oim(iim_[I0+3]));
         fftc_bf #(.D(S/2), .W(W), .K(K)) b1
           (.clk(clk), .srst(srst),
            .iv(iv_[I0+3]), .isof(is_[I0+3]), .itag(it_[I0+3]), .ire(ire_[I0+3]), .iim(iim_[I0+3]),
            .ov(iv_[I0+4]), .osof(is_[I0+4]), .otag(it_[I0+4]), .ore(ire_[I0+4]), .oim(iim_[I0+4]));
      end
   endgenerate

   // ================================================================ output formatting
   reg [LK-1:0] z_p;
   wire [LK-1:0] z_pos = is_[NS] ? {LK{1'b0}} : z_p;
   wire [CW-1:0] mh_m    = mq_m[mq_ra];
   wire          z_end   = iv_[NS] && (z_pos == K - 1);
   assign mq_pop = z_end;

   reg          o1_v, o1_last, o2_v, o2_last, o3_v, o3_last;
   reg [1:0]    o1_mode, o2_mode;
   reg signed [9:0] o1_sh0, o1_sh1, o2_sh0, o2_sh1;
   reg signed [W-1:0] o1_re, o1_im, o2_re, o2_im;
   reg [2*W-1:0] o2_sqr, o2_sqi;
   reg [31:0]   o3_w;

   function [15:0] fmt0;               // sat16(rs(v, sh))
      input signed [W-1:0] v;
      input signed [9:0]   sh;
      reg signed [63:0]    t;
      begin
         t = v;
         if (sh >= W)
            t = 0;
         else if (sh > 0)
            t = (t + (64'sd1 <<< (sh - 1))) >>> sh;
         else if (-sh >= 17)
            t = (v == 0) ? 64'sd0 : v[W-1] ? -64'sd32768 : 64'sd32767;
         else
            t = t <<< (-sh);
         fmt0 = (t > 32767) ? 16'h7fff : (t < -32768) ? 16'h8000 : t[15:0];
      end
   endfunction

   function [31:0] fmt1;               // satu32(rs(u, sh))
      input [2*W:0]      u;
      input signed [9:0] sh;
      reg [63:0]         t;
      begin
         t = u;
         if (sh >= 2 * W + 1)
            t = 0;
         else if (sh > 0)
            t = (t + (64'd1 << (sh - 1))) >> sh;
         else if (-sh >= 32)
            t = (u == 0) ? 64'd0 : 64'hffffffff;
         else
            t = t << (-sh);
         fmt1 = (t > 64'hffffffff) ? 32'hffffffff : t[31:0];
      end
   endfunction

   always @(posedge clk) begin
      o1_re <= ire_[NS]; o1_im <= iim_[NS];
      o1_mode <= mq_mode[mq_ra];
      o1_sh0 <= $signed({4'd0, mq_shift[mq_ra]}) - mq_g[mq_ra];
      o1_sh1 <= $signed({4'd0, mq_shift[mq_ra]}) - 2 * mq_g[mq_ra];
      o2_re <= o1_re; o2_im <= o1_im; o2_mode <= o1_mode;
      o2_sh0 <= o1_sh0; o2_sh1 <= o1_sh1;
      o2_sqr <= o1_re * o1_re;
      o2_sqi <= o1_im * o1_im;
      o3_w <= (o2_mode == 2'd0) ? {fmt0(o2_im, o2_sh0), fmt0(o2_re, o2_sh0)}
                                : fmt1({1'b0, o2_sqr} + {1'b0, o2_sqi}, o2_sh1);
   end
   always @(posedge clk) begin
      if (srst) begin
         z_p <= 0; o1_v <= 0; o2_v <= 0; o3_v <= 0; of_wr <= 1'b0;
      end else begin
         if (iv_[NS]) z_p <= z_pos + 1'b1;
         o1_v <= iv_[NS] && ({1'b0, z_pos} >= K - mh_m);
         o1_last <= z_end && mq_last[mq_ra];
         o2_v <= o1_v; o2_last <= o1_last;
         o3_v <= o2_v; o3_last <= o2_last;
         of_wr <= o3_v;
      end
      of_wd <= {o3_last, o3_w};
   end

`ifdef FFTC_DEBUG
   always @(posedge clk) begin
      if (fv[NS]) $display("DBGF %0d %0d %0d %0d", fs[NS], ft[NS], fre[NS], fim[NS]);
      if (c4_v) $display("DBGP %0d %0d %0d", c4_s, c4_re, c4_im);
      if (iv_[NS]) $display("DBGI %0d %0d %0d", is_[NS], ire_[NS], iim_[NS]);
   end
`endif
`ifndef SYNTHESIS
   // metadata FIFO and reservation sanity (simulation only)
   always @(posedge clk) begin
      if (!srst && mq_cnt > MQ) begin
         $display("fft_corr: metadata FIFO overflow");
         $finish;
      end
      if (!srst && of_wr && of_cnt == OFD) begin
         $display("fft_corr: output FIFO overflow");
         $finish;
      end
   end
`endif
endmodule


// ---------------------------------------------------------------------------
// Sideband delay: sof/tag delayed by exactly D cycles; valid for the K cycles
// of the delayed frame.  Frames are K contiguous cycles and D < K, so at most
// one sof is pending.
module fftc_sbd
  #(parameter D = 1, parameter K = 32)
   (input  wire clk, input wire srst,
    input  wire isof, input wire itag,
    output wire dv, output wire dsof, output wire dtag);
   localparam CB = $clog2(K) + 1;
   reg          pend, run, ptag, rtag;
   reg [CB-1:0] pc, rc;
   wire fire = pend && (pc == 0);
   assign dsof = fire;
   assign dv   = fire || run;
   assign dtag = fire ? ptag : rtag;
   always @(posedge clk) begin
      if (srst) begin
         pend <= 1'b0; run <= 1'b0;
      end else begin
         if (isof) begin
            pend <= 1'b1; pc <= D - 1; ptag <= itag;
         end else if (pend) begin
            if (pc == 0) pend <= 1'b0;
            else pc <= pc - 1'b1;
         end
         if (fire) begin
            run <= 1'b1; rc <= K - 2; rtag <= ptag;
         end else if (run) begin
            if (rc == 0) run <= 1'b0;
            else rc <= rc - 1'b1;
         end
      end
   end
endmodule


// ---------------------------------------------------------------------------
// D-cycle free-running delay line (no reset).
module fftc_delay
  #(parameter D = 1, parameter WD = 54)
   (input wire clk, input wire [WD-1:0] din, output wire [WD-1:0] dout);
   generate
      if (D == 1) begin : g_reg
         reg [WD-1:0] r;
         always @(posedge clk) r <= din;
         assign dout = r;
      end else if (D < 64) begin : g_lut
         reg [WD-1:0] mem [0:D-1];
         reg [$clog2(D)-1:0] p;
         initial p = 0;
         always @(posedge clk) begin
            mem[p] <= din;
            p <= (p == D - 1) ? 0 : p + 1'b1;
         end
         assign dout = mem[p];
      end else begin : g_ram
         // read-first RAM of depth D-1 plus the read register
         reg [WD-1:0] mem [0:D-2];
         reg [WD-1:0] q;
         reg [$clog2(D)-1:0] p;
         initial p = 0;
         always @(posedge clk) begin
            q <= mem[p];
            mem[p] <= din;
            p <= (p == D - 2) ? 0 : p + 1'b1;
         end
         assign dout = q;
      end
   endgenerate
endmodule


// ---------------------------------------------------------------------------
// SDF radix-2 butterfly with span D, each rail rounded (v + 1) >>> 1.
// Latency D + 1.
module fftc_bf
  #(parameter D = 1, parameter W = 27, parameter K = 32)
   (input  wire clk, input wire srst,
    input  wire iv, input wire isof, input wire itag,
    input  wire signed [W-1:0] ire, input wire signed [W-1:0] iim,
    output reg  ov, output reg osof, output reg otag,
    output reg  signed [W-1:0] ore, output reg signed [W-1:0] oim);
   localparam LD = $clog2(D);
   reg  [LD:0] cnt;
   wire [LD:0] pos = isof ? {(LD+1){1'b0}} : cnt;
   wire        second = iv && pos[LD];

   wire signed [W-1:0] ar, ai;
   wire signed [W:0]   sr = ar + ire, si = ai + iim;
   wire signed [W:0]   dr = ar - ire, di = ai - iim;
   wire signed [W:0]   sr1 = (sr + 1) >>> 1, si1 = (si + 1) >>> 1;
   wire signed [W:0]   dr1 = (dr + 1) >>> 1, di1 = (di + 1) >>> 1;
   wire [2*W-1:0] din = second ? {di1[W-1:0], dr1[W-1:0]} : {iim, ire};
   wire [2*W-1:0] dout;
   assign ar = dout[W-1:0];
   assign ai = dout[2*W-1:W];

   fftc_delay #(.D(D), .WD(2*W)) dl (.clk(clk), .din(din), .dout(dout));

   wire dv, dsof, dtag;
   fftc_sbd #(.D(D), .K(K)) sb (.clk(clk), .srst(srst), .isof(isof && iv), .itag(itag),
                                .dv(dv), .dsof(dsof), .dtag(dtag));

   always @(posedge clk) begin
      if (srst) cnt <= 0;
      else if (iv) cnt <= pos + 1'b1;
      if (srst) begin
         ov <= 1'b0; osof <= 1'b0;
      end else begin
         ov <= dv; osof <= dsof;
      end
      otag <= dtag;
      ore <= second ? sr1[W-1:0] : ar;
      oim <= second ? si1[W-1:0] : ai;
   end
endmodule


// ---------------------------------------------------------------------------
// Multiply positions [3S/4, S) of each S-group by -j (POS=0) or +j (POS=1).
// Latency 1.
module fftc_jrot
  #(parameter S = 4, parameter W = 27, parameter POS = 0)
   (input  wire clk, input wire srst,
    input  wire iv, input wire isof, input wire itag,
    input  wire signed [W-1:0] ire, input wire signed [W-1:0] iim,
    output reg  ov, output reg osof, output reg otag,
    output reg  signed [W-1:0] ore, output reg signed [W-1:0] oim);
   localparam LS = $clog2(S);
   reg  [LS-1:0] cnt;
   wire [LS-1:0] pos = isof ? {LS{1'b0}} : cnt;
   wire rot = pos[LS-1] & pos[LS-2];
   always @(posedge clk) begin
      if (srst) begin
         cnt <= 0; ov <= 1'b0; osof <= 1'b0;
      end else begin
         if (iv) cnt <= pos + 1'b1;
         ov <= iv; osof <= iv && isof;
      end
      otag <= itag;
      if (!rot) begin
         ore <= ire; oim <= iim;
      end else if (POS) begin          // +j (r + ji) = -i + jr
         ore <= -iim; oim <= ire;
      end else begin                   // -j (r + ji) = i - jr
         ore <= iim; oim <= -ire;
      end
   end
endmodule


// ---------------------------------------------------------------------------
// Radix-2^2 twiddle for an S-group: position q*S/4 + t is multiplied by
// W_S^(t*e_q), e = [0, 2, 1, 3] (conjugated when CONJ); q = 0 passes through.
// Twiddles come from the shared quarter-wave ROM (KMAX = 2048).  Latency 5.
module fftc_tw
  #(parameter S = 16, parameter W = 27, parameter CONJ = 0)
   (input  wire clk, input wire srst,
    input  wire iv, input wire isof, input wire itag,
    input  wire signed [W-1:0] ire, input wire signed [W-1:0] iim,
    output reg  ov, output reg osof, output reg otag,
    output reg  signed [W-1:0] ore, output reg signed [W-1:0] oim);
   localparam LS = $clog2(S);
   // BEGIN generated fftc_qrom: fft_corr_model.py --qrom fft_corr.v
   // Q[i] = round(cos(2*pi*i/2048) * (2**17-1)), i = 0..512
   function [16:0] fftc_qrom;
      input [9:0] i;
      begin
         case (i)
           10'd0: fftc_qrom = 17'd131071;
           10'd1: fftc_qrom = 17'd131070;
           10'd2: fftc_qrom = 17'd131069;
           10'd3: fftc_qrom = 17'd131065;
           10'd4: fftc_qrom = 17'd131061;
           10'd5: fftc_qrom = 17'd131056;
           10'd6: fftc_qrom = 17'd131049;
           10'd7: fftc_qrom = 17'd131041;
           10'd8: fftc_qrom = 17'd131032;
           10'd9: fftc_qrom = 17'd131021;
           10'd10: fftc_qrom = 17'd131009;
           10'd11: fftc_qrom = 17'd130996;
           10'd12: fftc_qrom = 17'd130982;
           10'd13: fftc_qrom = 17'd130967;
           10'd14: fftc_qrom = 17'd130950;
           10'd15: fftc_qrom = 17'd130932;
           10'd16: fftc_qrom = 17'd130913;
           10'd17: fftc_qrom = 17'd130893;
           10'd18: fftc_qrom = 17'd130871;
           10'd19: fftc_qrom = 17'd130848;
           10'd20: fftc_qrom = 17'd130824;
           10'd21: fftc_qrom = 17'd130799;
           10'd22: fftc_qrom = 17'd130773;
           10'd23: fftc_qrom = 17'd130745;
           10'd24: fftc_qrom = 17'd130716;
           10'd25: fftc_qrom = 17'd130686;
           10'd26: fftc_qrom = 17'd130654;
           10'd27: fftc_qrom = 17'd130622;
           10'd28: fftc_qrom = 17'd130588;
           10'd29: fftc_qrom = 17'd130553;
           10'd30: fftc_qrom = 17'd130516;
           10'd31: fftc_qrom = 17'd130479;
           10'd32: fftc_qrom = 17'd130440;
           10'd33: fftc_qrom = 17'd130400;
           10'd34: fftc_qrom = 17'd130359;
           10'd35: fftc_qrom = 17'd130316;
           10'd36: fftc_qrom = 17'd130272;
           10'd37: fftc_qrom = 17'd130227;
           10'd38: fftc_qrom = 17'd130181;
           10'd39: fftc_qrom = 17'd130134;
           10'd40: fftc_qrom = 17'd130085;
           10'd41: fftc_qrom = 17'd130035;
           10'd42: fftc_qrom = 17'd129984;
           10'd43: fftc_qrom = 17'd129932;
           10'd44: fftc_qrom = 17'd129879;
           10'd45: fftc_qrom = 17'd129824;
           10'd46: fftc_qrom = 17'd129768;
           10'd47: fftc_qrom = 17'd129711;
           10'd48: fftc_qrom = 17'd129652;
           10'd49: fftc_qrom = 17'd129593;
           10'd50: fftc_qrom = 17'd129532;
           10'd51: fftc_qrom = 17'd129470;
           10'd52: fftc_qrom = 17'd129407;
           10'd53: fftc_qrom = 17'd129342;
           10'd54: fftc_qrom = 17'd129276;
           10'd55: fftc_qrom = 17'd129209;
           10'd56: fftc_qrom = 17'd129141;
           10'd57: fftc_qrom = 17'd129072;
           10'd58: fftc_qrom = 17'd129001;
           10'd59: fftc_qrom = 17'd128930;
           10'd60: fftc_qrom = 17'd128857;
           10'd61: fftc_qrom = 17'd128782;
           10'd62: fftc_qrom = 17'd128707;
           10'd63: fftc_qrom = 17'd128630;
           10'd64: fftc_qrom = 17'd128553;
           10'd65: fftc_qrom = 17'd128473;
           10'd66: fftc_qrom = 17'd128393;
           10'd67: fftc_qrom = 17'd128312;
           10'd68: fftc_qrom = 17'd128229;
           10'd69: fftc_qrom = 17'd128145;
           10'd70: fftc_qrom = 17'd128060;
           10'd71: fftc_qrom = 17'd127974;
           10'd72: fftc_qrom = 17'd127886;
           10'd73: fftc_qrom = 17'd127798;
           10'd74: fftc_qrom = 17'd127708;
           10'd75: fftc_qrom = 17'd127617;
           10'd76: fftc_qrom = 17'd127524;
           10'd77: fftc_qrom = 17'd127431;
           10'd78: fftc_qrom = 17'd127336;
           10'd79: fftc_qrom = 17'd127240;
           10'd80: fftc_qrom = 17'd127143;
           10'd81: fftc_qrom = 17'd127045;
           10'd82: fftc_qrom = 17'd126945;
           10'd83: fftc_qrom = 17'd126844;
           10'd84: fftc_qrom = 17'd126743;
           10'd85: fftc_qrom = 17'd126639;
           10'd86: fftc_qrom = 17'd126535;
           10'd87: fftc_qrom = 17'd126430;
           10'd88: fftc_qrom = 17'd126323;
           10'd89: fftc_qrom = 17'd126215;
           10'd90: fftc_qrom = 17'd126106;
           10'd91: fftc_qrom = 17'd125996;
           10'd92: fftc_qrom = 17'd125885;
           10'd93: fftc_qrom = 17'd125772;
           10'd94: fftc_qrom = 17'd125658;
           10'd95: fftc_qrom = 17'd125543;
           10'd96: fftc_qrom = 17'd125427;
           10'd97: fftc_qrom = 17'd125310;
           10'd98: fftc_qrom = 17'd125191;
           10'd99: fftc_qrom = 17'd125072;
           10'd100: fftc_qrom = 17'd124951;
           10'd101: fftc_qrom = 17'd124829;
           10'd102: fftc_qrom = 17'd124706;
           10'd103: fftc_qrom = 17'd124581;
           10'd104: fftc_qrom = 17'd124456;
           10'd105: fftc_qrom = 17'd124329;
           10'd106: fftc_qrom = 17'd124201;
           10'd107: fftc_qrom = 17'd124072;
           10'd108: fftc_qrom = 17'd123942;
           10'd109: fftc_qrom = 17'd123810;
           10'd110: fftc_qrom = 17'd123678;
           10'd111: fftc_qrom = 17'd123544;
           10'd112: fftc_qrom = 17'd123409;
           10'd113: fftc_qrom = 17'd123273;
           10'd114: fftc_qrom = 17'd123136;
           10'd115: fftc_qrom = 17'd122997;
           10'd116: fftc_qrom = 17'd122858;
           10'd117: fftc_qrom = 17'd122717;
           10'd118: fftc_qrom = 17'd122575;
           10'd119: fftc_qrom = 17'd122432;
           10'd120: fftc_qrom = 17'd122288;
           10'd121: fftc_qrom = 17'd122143;
           10'd122: fftc_qrom = 17'd121997;
           10'd123: fftc_qrom = 17'd121849;
           10'd124: fftc_qrom = 17'd121700;
           10'd125: fftc_qrom = 17'd121550;
           10'd126: fftc_qrom = 17'd121399;
           10'd127: fftc_qrom = 17'd121247;
           10'd128: fftc_qrom = 17'd121094;
           10'd129: fftc_qrom = 17'd120939;
           10'd130: fftc_qrom = 17'd120784;
           10'd131: fftc_qrom = 17'd120627;
           10'd132: fftc_qrom = 17'd120469;
           10'd133: fftc_qrom = 17'd120310;
           10'd134: fftc_qrom = 17'd120150;
           10'd135: fftc_qrom = 17'd119989;
           10'd136: fftc_qrom = 17'd119826;
           10'd137: fftc_qrom = 17'd119663;
           10'd138: fftc_qrom = 17'd119498;
           10'd139: fftc_qrom = 17'd119332;
           10'd140: fftc_qrom = 17'd119166;
           10'd141: fftc_qrom = 17'd118998;
           10'd142: fftc_qrom = 17'd118828;
           10'd143: fftc_qrom = 17'd118658;
           10'd144: fftc_qrom = 17'd118487;
           10'd145: fftc_qrom = 17'd118314;
           10'd146: fftc_qrom = 17'd118141;
           10'd147: fftc_qrom = 17'd117966;
           10'd148: fftc_qrom = 17'd117790;
           10'd149: fftc_qrom = 17'd117613;
           10'd150: fftc_qrom = 17'd117435;
           10'd151: fftc_qrom = 17'd117256;
           10'd152: fftc_qrom = 17'd117076;
           10'd153: fftc_qrom = 17'd116894;
           10'd154: fftc_qrom = 17'd116712;
           10'd155: fftc_qrom = 17'd116528;
           10'd156: fftc_qrom = 17'd116344;
           10'd157: fftc_qrom = 17'd116158;
           10'd158: fftc_qrom = 17'd115971;
           10'd159: fftc_qrom = 17'd115783;
           10'd160: fftc_qrom = 17'd115594;
           10'd161: fftc_qrom = 17'd115404;
           10'd162: fftc_qrom = 17'd115213;
           10'd163: fftc_qrom = 17'd115021;
           10'd164: fftc_qrom = 17'd114827;
           10'd165: fftc_qrom = 17'd114633;
           10'd166: fftc_qrom = 17'd114437;
           10'd167: fftc_qrom = 17'd114241;
           10'd168: fftc_qrom = 17'd114043;
           10'd169: fftc_qrom = 17'd113844;
           10'd170: fftc_qrom = 17'd113645;
           10'd171: fftc_qrom = 17'd113444;
           10'd172: fftc_qrom = 17'd113242;
           10'd173: fftc_qrom = 17'd113039;
           10'd174: fftc_qrom = 17'd112835;
           10'd175: fftc_qrom = 17'd112630;
           10'd176: fftc_qrom = 17'd112423;
           10'd177: fftc_qrom = 17'd112216;
           10'd178: fftc_qrom = 17'd112008;
           10'd179: fftc_qrom = 17'd111798;
           10'd180: fftc_qrom = 17'd111588;
           10'd181: fftc_qrom = 17'd111377;
           10'd182: fftc_qrom = 17'd111164;
           10'd183: fftc_qrom = 17'd110950;
           10'd184: fftc_qrom = 17'd110736;
           10'd185: fftc_qrom = 17'd110520;
           10'd186: fftc_qrom = 17'd110303;
           10'd187: fftc_qrom = 17'd110086;
           10'd188: fftc_qrom = 17'd109867;
           10'd189: fftc_qrom = 17'd109647;
           10'd190: fftc_qrom = 17'd109426;
           10'd191: fftc_qrom = 17'd109204;
           10'd192: fftc_qrom = 17'd108982;
           10'd193: fftc_qrom = 17'd108758;
           10'd194: fftc_qrom = 17'd108533;
           10'd195: fftc_qrom = 17'd108307;
           10'd196: fftc_qrom = 17'd108080;
           10'd197: fftc_qrom = 17'd107852;
           10'd198: fftc_qrom = 17'd107623;
           10'd199: fftc_qrom = 17'd107393;
           10'd200: fftc_qrom = 17'd107162;
           10'd201: fftc_qrom = 17'd106930;
           10'd202: fftc_qrom = 17'd106697;
           10'd203: fftc_qrom = 17'd106462;
           10'd204: fftc_qrom = 17'd106227;
           10'd205: fftc_qrom = 17'd105991;
           10'd206: fftc_qrom = 17'd105754;
           10'd207: fftc_qrom = 17'd105516;
           10'd208: fftc_qrom = 17'd105277;
           10'd209: fftc_qrom = 17'd105037;
           10'd210: fftc_qrom = 17'd104796;
           10'd211: fftc_qrom = 17'd104554;
           10'd212: fftc_qrom = 17'd104311;
           10'd213: fftc_qrom = 17'd104067;
           10'd214: fftc_qrom = 17'd103822;
           10'd215: fftc_qrom = 17'd103576;
           10'd216: fftc_qrom = 17'd103329;
           10'd217: fftc_qrom = 17'd103081;
           10'd218: fftc_qrom = 17'd102833;
           10'd219: fftc_qrom = 17'd102583;
           10'd220: fftc_qrom = 17'd102332;
           10'd221: fftc_qrom = 17'd102080;
           10'd222: fftc_qrom = 17'd101828;
           10'd223: fftc_qrom = 17'd101574;
           10'd224: fftc_qrom = 17'd101319;
           10'd225: fftc_qrom = 17'd101064;
           10'd226: fftc_qrom = 17'd100807;
           10'd227: fftc_qrom = 17'd100550;
           10'd228: fftc_qrom = 17'd100291;
           10'd229: fftc_qrom = 17'd100032;
           10'd230: fftc_qrom = 17'd99772;
           10'd231: fftc_qrom = 17'd99510;
           10'd232: fftc_qrom = 17'd99248;
           10'd233: fftc_qrom = 17'd98985;
           10'd234: fftc_qrom = 17'd98721;
           10'd235: fftc_qrom = 17'd98456;
           10'd236: fftc_qrom = 17'd98190;
           10'd237: fftc_qrom = 17'd97923;
           10'd238: fftc_qrom = 17'd97655;
           10'd239: fftc_qrom = 17'd97387;
           10'd240: fftc_qrom = 17'd97117;
           10'd241: fftc_qrom = 17'd96847;
           10'd242: fftc_qrom = 17'd96575;
           10'd243: fftc_qrom = 17'd96303;
           10'd244: fftc_qrom = 17'd96030;
           10'd245: fftc_qrom = 17'd95756;
           10'd246: fftc_qrom = 17'd95481;
           10'd247: fftc_qrom = 17'd95205;
           10'd248: fftc_qrom = 17'd94928;
           10'd249: fftc_qrom = 17'd94650;
           10'd250: fftc_qrom = 17'd94371;
           10'd251: fftc_qrom = 17'd94092;
           10'd252: fftc_qrom = 17'd93812;
           10'd253: fftc_qrom = 17'd93530;
           10'd254: fftc_qrom = 17'd93248;
           10'd255: fftc_qrom = 17'd92965;
           10'd256: fftc_qrom = 17'd92681;
           10'd257: fftc_qrom = 17'd92396;
           10'd258: fftc_qrom = 17'd92111;
           10'd259: fftc_qrom = 17'd91824;
           10'd260: fftc_qrom = 17'd91537;
           10'd261: fftc_qrom = 17'd91249;
           10'd262: fftc_qrom = 17'd90960;
           10'd263: fftc_qrom = 17'd90670;
           10'd264: fftc_qrom = 17'd90379;
           10'd265: fftc_qrom = 17'd90087;
           10'd266: fftc_qrom = 17'd89795;
           10'd267: fftc_qrom = 17'd89501;
           10'd268: fftc_qrom = 17'd89207;
           10'd269: fftc_qrom = 17'd88912;
           10'd270: fftc_qrom = 17'd88616;
           10'd271: fftc_qrom = 17'd88319;
           10'd272: fftc_qrom = 17'd88022;
           10'd273: fftc_qrom = 17'd87724;
           10'd274: fftc_qrom = 17'd87424;
           10'd275: fftc_qrom = 17'd87124;
           10'd276: fftc_qrom = 17'd86823;
           10'd277: fftc_qrom = 17'd86522;
           10'd278: fftc_qrom = 17'd86219;
           10'd279: fftc_qrom = 17'd85916;
           10'd280: fftc_qrom = 17'd85612;
           10'd281: fftc_qrom = 17'd85307;
           10'd282: fftc_qrom = 17'd85001;
           10'd283: fftc_qrom = 17'd84695;
           10'd284: fftc_qrom = 17'd84388;
           10'd285: fftc_qrom = 17'd84080;
           10'd286: fftc_qrom = 17'd83771;
           10'd287: fftc_qrom = 17'd83461;
           10'd288: fftc_qrom = 17'd83151;
           10'd289: fftc_qrom = 17'd82839;
           10'd290: fftc_qrom = 17'd82527;
           10'd291: fftc_qrom = 17'd82215;
           10'd292: fftc_qrom = 17'd81901;
           10'd293: fftc_qrom = 17'd81587;
           10'd294: fftc_qrom = 17'd81272;
           10'd295: fftc_qrom = 17'd80956;
           10'd296: fftc_qrom = 17'd80639;
           10'd297: fftc_qrom = 17'd80322;
           10'd298: fftc_qrom = 17'd80003;
           10'd299: fftc_qrom = 17'd79685;
           10'd300: fftc_qrom = 17'd79365;
           10'd301: fftc_qrom = 17'd79045;
           10'd302: fftc_qrom = 17'd78723;
           10'd303: fftc_qrom = 17'd78402;
           10'd304: fftc_qrom = 17'd78079;
           10'd305: fftc_qrom = 17'd77756;
           10'd306: fftc_qrom = 17'd77431;
           10'd307: fftc_qrom = 17'd77107;
           10'd308: fftc_qrom = 17'd76781;
           10'd309: fftc_qrom = 17'd76455;
           10'd310: fftc_qrom = 17'd76128;
           10'd311: fftc_qrom = 17'd75800;
           10'd312: fftc_qrom = 17'd75472;
           10'd313: fftc_qrom = 17'd75143;
           10'd314: fftc_qrom = 17'd74813;
           10'd315: fftc_qrom = 17'd74482;
           10'd316: fftc_qrom = 17'd74151;
           10'd317: fftc_qrom = 17'd73819;
           10'd318: fftc_qrom = 17'd73486;
           10'd319: fftc_qrom = 17'd73153;
           10'd320: fftc_qrom = 17'd72819;
           10'd321: fftc_qrom = 17'd72484;
           10'd322: fftc_qrom = 17'd72149;
           10'd323: fftc_qrom = 17'd71813;
           10'd324: fftc_qrom = 17'd71476;
           10'd325: fftc_qrom = 17'd71139;
           10'd326: fftc_qrom = 17'd70801;
           10'd327: fftc_qrom = 17'd70462;
           10'd328: fftc_qrom = 17'd70123;
           10'd329: fftc_qrom = 17'd69783;
           10'd330: fftc_qrom = 17'd69442;
           10'd331: fftc_qrom = 17'd69101;
           10'd332: fftc_qrom = 17'd68758;
           10'd333: fftc_qrom = 17'd68416;
           10'd334: fftc_qrom = 17'd68073;
           10'd335: fftc_qrom = 17'd67729;
           10'd336: fftc_qrom = 17'd67384;
           10'd337: fftc_qrom = 17'd67039;
           10'd338: fftc_qrom = 17'd66693;
           10'd339: fftc_qrom = 17'd66346;
           10'd340: fftc_qrom = 17'd65999;
           10'd341: fftc_qrom = 17'd65652;
           10'd342: fftc_qrom = 17'd65303;
           10'd343: fftc_qrom = 17'd64954;
           10'd344: fftc_qrom = 17'd64605;
           10'd345: fftc_qrom = 17'd64254;
           10'd346: fftc_qrom = 17'd63904;
           10'd347: fftc_qrom = 17'd63552;
           10'd348: fftc_qrom = 17'd63200;
           10'd349: fftc_qrom = 17'd62848;
           10'd350: fftc_qrom = 17'd62495;
           10'd351: fftc_qrom = 17'd62141;
           10'd352: fftc_qrom = 17'd61786;
           10'd353: fftc_qrom = 17'd61432;
           10'd354: fftc_qrom = 17'd61076;
           10'd355: fftc_qrom = 17'd60720;
           10'd356: fftc_qrom = 17'd60363;
           10'd357: fftc_qrom = 17'd60006;
           10'd358: fftc_qrom = 17'd59648;
           10'd359: fftc_qrom = 17'd59290;
           10'd360: fftc_qrom = 17'd58931;
           10'd361: fftc_qrom = 17'd58572;
           10'd362: fftc_qrom = 17'd58212;
           10'd363: fftc_qrom = 17'd57851;
           10'd364: fftc_qrom = 17'd57490;
           10'd365: fftc_qrom = 17'd57128;
           10'd366: fftc_qrom = 17'd56766;
           10'd367: fftc_qrom = 17'd56403;
           10'd368: fftc_qrom = 17'd56040;
           10'd369: fftc_qrom = 17'd55676;
           10'd370: fftc_qrom = 17'd55312;
           10'd371: fftc_qrom = 17'd54947;
           10'd372: fftc_qrom = 17'd54582;
           10'd373: fftc_qrom = 17'd54216;
           10'd374: fftc_qrom = 17'd53850;
           10'd375: fftc_qrom = 17'd53483;
           10'd376: fftc_qrom = 17'd53115;
           10'd377: fftc_qrom = 17'd52748;
           10'd378: fftc_qrom = 17'd52379;
           10'd379: fftc_qrom = 17'd52010;
           10'd380: fftc_qrom = 17'd51641;
           10'd381: fftc_qrom = 17'd51271;
           10'd382: fftc_qrom = 17'd50901;
           10'd383: fftc_qrom = 17'd50530;
           10'd384: fftc_qrom = 17'd50159;
           10'd385: fftc_qrom = 17'd49787;
           10'd386: fftc_qrom = 17'd49415;
           10'd387: fftc_qrom = 17'd49042;
           10'd388: fftc_qrom = 17'd48669;
           10'd389: fftc_qrom = 17'd48295;
           10'd390: fftc_qrom = 17'd47921;
           10'd391: fftc_qrom = 17'd47547;
           10'd392: fftc_qrom = 17'd47172;
           10'd393: fftc_qrom = 17'd46796;
           10'd394: fftc_qrom = 17'd46421;
           10'd395: fftc_qrom = 17'd46044;
           10'd396: fftc_qrom = 17'd45668;
           10'd397: fftc_qrom = 17'd45290;
           10'd398: fftc_qrom = 17'd44913;
           10'd399: fftc_qrom = 17'd44535;
           10'd400: fftc_qrom = 17'd44156;
           10'd401: fftc_qrom = 17'd43778;
           10'd402: fftc_qrom = 17'd43398;
           10'd403: fftc_qrom = 17'd43019;
           10'd404: fftc_qrom = 17'd42639;
           10'd405: fftc_qrom = 17'd42258;
           10'd406: fftc_qrom = 17'd41877;
           10'd407: fftc_qrom = 17'd41496;
           10'd408: fftc_qrom = 17'd41115;
           10'd409: fftc_qrom = 17'd40733;
           10'd410: fftc_qrom = 17'd40350;
           10'd411: fftc_qrom = 17'd39967;
           10'd412: fftc_qrom = 17'd39584;
           10'd413: fftc_qrom = 17'd39201;
           10'd414: fftc_qrom = 17'd38817;
           10'd415: fftc_qrom = 17'd38433;
           10'd416: fftc_qrom = 17'd38048;
           10'd417: fftc_qrom = 17'd37663;
           10'd418: fftc_qrom = 17'd37278;
           10'd419: fftc_qrom = 17'd36892;
           10'd420: fftc_qrom = 17'd36506;
           10'd421: fftc_qrom = 17'd36119;
           10'd422: fftc_qrom = 17'd35733;
           10'd423: fftc_qrom = 17'd35346;
           10'd424: fftc_qrom = 17'd34958;
           10'd425: fftc_qrom = 17'd34571;
           10'd426: fftc_qrom = 17'd34183;
           10'd427: fftc_qrom = 17'd33794;
           10'd428: fftc_qrom = 17'd33405;
           10'd429: fftc_qrom = 17'd33016;
           10'd430: fftc_qrom = 17'd32627;
           10'd431: fftc_qrom = 17'd32238;
           10'd432: fftc_qrom = 17'd31848;
           10'd433: fftc_qrom = 17'd31457;
           10'd434: fftc_qrom = 17'd31067;
           10'd435: fftc_qrom = 17'd30676;
           10'd436: fftc_qrom = 17'd30285;
           10'd437: fftc_qrom = 17'd29894;
           10'd438: fftc_qrom = 17'd29502;
           10'd439: fftc_qrom = 17'd29110;
           10'd440: fftc_qrom = 17'd28718;
           10'd441: fftc_qrom = 17'd28325;
           10'd442: fftc_qrom = 17'd27933;
           10'd443: fftc_qrom = 17'd27540;
           10'd444: fftc_qrom = 17'd27146;
           10'd445: fftc_qrom = 17'd26753;
           10'd446: fftc_qrom = 17'd26359;
           10'd447: fftc_qrom = 17'd25965;
           10'd448: fftc_qrom = 17'd25571;
           10'd449: fftc_qrom = 17'd25176;
           10'd450: fftc_qrom = 17'd24781;
           10'd451: fftc_qrom = 17'd24386;
           10'd452: fftc_qrom = 17'd23991;
           10'd453: fftc_qrom = 17'd23596;
           10'd454: fftc_qrom = 17'd23200;
           10'd455: fftc_qrom = 17'd22804;
           10'd456: fftc_qrom = 17'd22408;
           10'd457: fftc_qrom = 17'd22012;
           10'd458: fftc_qrom = 17'd21615;
           10'd459: fftc_qrom = 17'd21219;
           10'd460: fftc_qrom = 17'd20822;
           10'd461: fftc_qrom = 17'd20425;
           10'd462: fftc_qrom = 17'd20027;
           10'd463: fftc_qrom = 17'd19630;
           10'd464: fftc_qrom = 17'd19232;
           10'd465: fftc_qrom = 17'd18834;
           10'd466: fftc_qrom = 17'd18436;
           10'd467: fftc_qrom = 17'd18038;
           10'd468: fftc_qrom = 17'd17640;
           10'd469: fftc_qrom = 17'd17241;
           10'd470: fftc_qrom = 17'd16842;
           10'd471: fftc_qrom = 17'd16444;
           10'd472: fftc_qrom = 17'd16044;
           10'd473: fftc_qrom = 17'd15645;
           10'd474: fftc_qrom = 17'd15246;
           10'd475: fftc_qrom = 17'd14847;
           10'd476: fftc_qrom = 17'd14447;
           10'd477: fftc_qrom = 17'd14047;
           10'd478: fftc_qrom = 17'd13647;
           10'd479: fftc_qrom = 17'd13247;
           10'd480: fftc_qrom = 17'd12847;
           10'd481: fftc_qrom = 17'd12447;
           10'd482: fftc_qrom = 17'd12047;
           10'd483: fftc_qrom = 17'd11646;
           10'd484: fftc_qrom = 17'd11246;
           10'd485: fftc_qrom = 17'd10845;
           10'd486: fftc_qrom = 17'd10444;
           10'd487: fftc_qrom = 17'd10043;
           10'd488: fftc_qrom = 17'd9642;
           10'd489: fftc_qrom = 17'd9241;
           10'd490: fftc_qrom = 17'd8840;
           10'd491: fftc_qrom = 17'd8439;
           10'd492: fftc_qrom = 17'd8037;
           10'd493: fftc_qrom = 17'd7636;
           10'd494: fftc_qrom = 17'd7234;
           10'd495: fftc_qrom = 17'd6833;
           10'd496: fftc_qrom = 17'd6431;
           10'd497: fftc_qrom = 17'd6030;
           10'd498: fftc_qrom = 17'd5628;
           10'd499: fftc_qrom = 17'd5226;
           10'd500: fftc_qrom = 17'd4824;
           10'd501: fftc_qrom = 17'd4422;
           10'd502: fftc_qrom = 17'd4021;
           10'd503: fftc_qrom = 17'd3619;
           10'd504: fftc_qrom = 17'd3217;
           10'd505: fftc_qrom = 17'd2815;
           10'd506: fftc_qrom = 17'd2413;
           10'd507: fftc_qrom = 17'd2011;
           10'd508: fftc_qrom = 17'd1608;
           10'd509: fftc_qrom = 17'd1206;
           10'd510: fftc_qrom = 17'd804;
           10'd511: fftc_qrom = 17'd402;
           10'd512: fftc_qrom = 17'd0;
           default: fftc_qrom = 17'd0;
         endcase
      end
   endfunction
   // END generated fftc_qrom

   reg  [LS-1:0] cnt;
   wire [LS-1:0] pos = isof ? {LS{1'b0}} : cnt;
   wire [1:0]    q   = pos[LS-1:LS-2];
   wire [1:0]    e   = (q == 2'd1) ? 2'd2 : (q == 2'd2) ? 2'd1 : q;
   wire [LS-3:0] t   = pos[LS-3:0];
   wire [LS-1:0] te  = t * e;
   wire [10:0]   u   = te << (11 - LS);

   reg [4:0]     v_d, s_d, g_d;       // valid / sof / tag pipes
   reg [4:0]     byp;
   reg signed [W-1:0] r1, i1, r2, i2, r3, i3, r4, i4;
   reg [1:0]     qd2;
   reg [16:0]    qa2, qb2;
   reg [10:0]    u1;
   reg signed [17:0] tr3, ti3;
   reg signed [W+17:0] p_rc, p_is, p_rs, p_ic;

   always @(posedge clk) begin
      if (srst) begin
         cnt <= 0; v_d <= 0; s_d <= 0;
         ov <= 1'b0; osof <= 1'b0;
      end else begin
         if (iv) cnt <= pos + 1'b1;
         v_d <= {v_d[3:0], iv};
         s_d <= {s_d[3:0], iv && isof};
         ov <= v_d[3];
         osof <= s_d[3];
      end
      g_d <= {g_d[3:0], itag};
      otag <= g_d[3];
      byp <= {byp[3:0], (e == 2'd0)};
      // stage 1: angle
      u1 <= u; r1 <= ire; i1 <= iim;
      // stage 2: ROM
      qd2 <= u1[10:9];
      qa2 <= fftc_qrom({1'b0, u1[8:0]});
      qb2 <= fftc_qrom(10'd512 - {1'b0, u1[8:0]});
      r2 <= r1; i2 <= i1;
      // stage 3: twiddle (cos, -sin), or (cos, +sin) when CONJ
      case (qd2)
        2'd0: begin tr3 <=  $signed({1'b0, qa2}); ti3 <= CONJ ?  $signed({1'b0, qb2}) : -$signed({1'b0, qb2}); end
        2'd1: begin tr3 <= -$signed({1'b0, qb2}); ti3 <= CONJ ?  $signed({1'b0, qa2}) : -$signed({1'b0, qa2}); end
        2'd2: begin tr3 <= -$signed({1'b0, qa2}); ti3 <= CONJ ? -$signed({1'b0, qb2}) :  $signed({1'b0, qb2}); end
        default: begin tr3 <= $signed({1'b0, qb2}); ti3 <= CONJ ? -$signed({1'b0, qa2}) : $signed({1'b0, qa2}); end
      endcase
      r3 <= r2; i3 <= i2;
      // stage 4: products
      p_rc <= r3 * tr3;
      p_is <= i3 * ti3;
      p_rs <= r3 * ti3;
      p_ic <= i3 * tr3;
      r4 <= r3; i4 <= i3;
      // stage 5: round
      if (byp[3]) begin
         ore <= r4; oim <= i4;
      end else begin
         ore <= fr(p_rc, p_is, 1'b1);
         oim <= fr(p_rs, p_ic, 1'b0);
      end
   end

   function signed [W-1:0] fr;         // rs(a -/+ b, 17)
      input signed [W+17:0] a;
      input signed [W+17:0] b;
      input sub;
      reg signed [W+18:0] s;
      begin
         s = sub ? ($signed({a[W+17], a}) - $signed({b[W+17], b}))
                 : ($signed({a[W+17], a}) + $signed({b[W+17], b}));
         s = (s + 65536) >>> 17;
         fr = s[W-1:0];
      end
   endfunction
endmodule

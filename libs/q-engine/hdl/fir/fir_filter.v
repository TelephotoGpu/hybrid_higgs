// fir_filter: streaming fixed-point complex FIR for the Q-engine.
//
// Contract: doc/add-fir/PLAN.md.  Bit-exact model: model/fir_model.py.
//
// Words are 32-bit complex values, I in [15:0], Q in [31:16] (signed).
// Every input packet is a header word followed by a payload; t_last marks
// the final word.  Header: [31:16]=0xF1F0, [12:8]=shift, [3:0]=opcode
// (1 DATA, 2 LOAD_COEFFS, 3 RESET), all other bits zero.
//
// Pipeline: all datapath stages advance on a single enable `en`, which is
// derived only from the registered occupancy of the 2-entry output FIFO, so
// there is no combinational path from i_ready to t_ready.
module fir_filter
  #(parameter NTAPS = 16)
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

    // sticky: [0] bad header, [1] coefficient length, [2] reset with payload
    output reg  [2:0]  err,
    input  wire        err_clear
    );

   localparam DW     = 16;
   localparam CW     = 16;
   localparam LEVELS = (NTAPS > 1) ? $clog2(NTAPS) : 0;
   localparam P2     = 1 << LEVELS;
   localparam PW     = DW + CW;           // one real product
   localparam ACCW   = PW + 1 + LEVELS;   // complex combine + tree growth
   localparam RW     = ACCW + 1;          // + rounding headroom
   localparam CBW    = (NTAPS > 1) ? $clog2(NTAPS) : 1;
   // en-stages after the delay line: M, combine, LEVELS tree, round, shift/sat
   localparam DEPTH  = 4 + LEVELS;

   localparam [15:0] MAGIC = 16'hF1F0;
   localparam [3:0]  OP_DATA = 4'd1, OP_COEF = 4'd2, OP_RESET = 4'd3;
   localparam [1:0]  S_HDR = 2'd0, S_DATA = 2'd1, S_COEF = 2'd2, S_DRAIN = 2'd3;

   // ------------------------------------------------------------ output FIFO
   reg  [31:0] ob_data [0:1];
   reg  [1:0]  ob_last;
   reg  [1:0]  ob_cnt;
   reg         ob_rd, ob_wr;
   wire        en = (ob_cnt != 2'd2);

   assign t_ready = en;
   wire   in_fire = t_valid & en;

   // ------------------------------------------------------------ parser
   reg [1:0]      state;
   reg [CBW-1:0]  ccnt;
   reg [4:0]      shift, shadow_shift;
   reg [31:0]     coef   [0:NTAPS-1];
   reg [31:0]     shadow [0:NTAPS-1];
   reg [31:0]     xl     [0:NTAPS-1];

   wire       hdr_ok = (t_data[31:16] == MAGIC) && (t_data[15:13] == 3'b0) &&
                       (t_data[7:4] == 4'b0) &&
                       (t_data[3:0] == OP_DATA || t_data[3:0] == OP_COEF ||
                        t_data[3:0] == OP_RESET);
   wire       is_hdr    = (state == S_HDR);
   wire       do_sample = in_fire && (state == S_DATA);
   wire       do_reset  = in_fire && is_hdr && hdr_ok && (t_data[3:0] == OP_RESET);
   /* verilator lint_off WIDTH */
   localparam [CBW-1:0] LASTC = NTAPS-1;
   /* verilator lint_on WIDTH */
   wire       coef_full = (ccnt == LASTC);

   integer k;

   always @(posedge clk) begin
      if (srst) begin
         state <= S_HDR;
         ccnt <= 0;
         shift <= 5'd15;
         shadow_shift <= 5'd0;
         err <= 3'b0;
         for (k = 0; k < NTAPS; k = k + 1) begin
            coef[k] <= 32'b0;
            shadow[k] <= 32'b0;
         end
      end
      else begin
         if (err_clear)
           err <= 3'b0;
         if (in_fire) begin
            case (state)
              S_HDR: begin
                 if (!hdr_ok) begin
                    err[0] <= 1'b1;
                    state <= t_last ? S_HDR : S_DRAIN;
                 end
                 else if (t_data[3:0] == OP_DATA)
                   state <= t_last ? S_HDR : S_DATA;
                 else if (t_data[3:0] == OP_COEF) begin
                    if (t_last) begin
                       err[1] <= 1'b1;
                       state <= S_HDR;
                    end
                    else begin
                       ccnt <= 0;
                       shadow_shift <= t_data[12:8];
                       state <= S_COEF;
                    end
                 end
                 else begin
                    if (!t_last)
                      err[2] <= 1'b1;
                    state <= t_last ? S_HDR : S_DRAIN;
                 end
              end
              S_DATA:
                if (t_last)
                  state <= S_HDR;
              S_COEF: begin
                 shadow[ccnt] <= t_data;
                 ccnt <= ccnt + 1'b1;
                 if (coef_full) begin
                    if (t_last) begin
                       for (k = 0; k < NTAPS-1; k = k + 1)
                         coef[k] <= shadow[k];
                       coef[NTAPS-1] <= t_data;
                       shift <= shadow_shift;
                       state <= S_HDR;
                    end
                    else begin
                       err[1] <= 1'b1;
                       state <= S_DRAIN;
                    end
                 end
                 else if (t_last) begin
                    err[1] <= 1'b1;
                    state <= S_HDR;
                 end
              end
              default:
                if (t_last)
                  state <= S_HDR;
            endcase
         end
      end
   end

   // ------------------------------------------------------------ delay line
   reg       v0, l0;
   reg [4:0] sh0;

   always @(posedge clk) begin
      if (srst || do_reset) begin
         for (k = 0; k < NTAPS; k = k + 1)
           xl[k] <= 32'b0;
      end
      else if (do_sample) begin
         xl[0] <= t_data;
         for (k = 1; k < NTAPS; k = k + 1)
           xl[k] <= xl[k-1];
      end
   end

   always @(posedge clk) begin
      if (srst) begin
         v0 <= 1'b0;
         l0 <= 1'b0;
         sh0 <= 5'd0;
      end
      else if (en) begin
         v0 <= do_sample;
         l0 <= t_last;
         sh0 <= shift;
      end
   end

   // ------------------------------------------------------------ products
   // Stage 1 (M): four real products per tap.  Stage 2: complex combine.
   reg signed [PW-1:0]   p_rr [0:NTAPS-1];
   reg signed [PW-1:0]   p_ii [0:NTAPS-1];
   reg signed [PW-1:0]   p_ri [0:NTAPS-1];
   reg signed [PW-1:0]   p_ir [0:NTAPS-1];

   genvar g;
   generate
      for (g = 0; g < NTAPS; g = g + 1) begin : tap
         wire signed [CW-1:0] hr = coef[g][15:0];
         wire signed [CW-1:0] hi = coef[g][31:16];
         wire signed [DW-1:0] xr = xl[g][15:0];
         wire signed [DW-1:0] xi = xl[g][31:16];
         always @(posedge clk) begin
            if (en) begin
               p_rr[g] <= hr * xr;
               p_ii[g] <= hi * xi;
               p_ri[g] <= hr * xi;
               p_ir[g] <= hi * xr;
            end
         end
      end
   endgenerate

   // Adder tree as a binary heap: node n has children 2n and 2n+1, leaves are
   // nodes P2..2*P2-1 (tap n-P2, complex combine), node 1 is the root.
   wire [2*P2*ACCW-1:0] node_r, node_i;
   assign node_r[ACCW-1:0] = {ACCW{1'b0}};
   assign node_i[ACCW-1:0] = {ACCW{1'b0}};

   generate
      for (g = 1; g < 2*P2; g = g + 1) begin : nd
         reg signed [ACCW-1:0] qr, qi;
         assign node_r[g*ACCW +: ACCW] = qr;
         assign node_i[g*ACCW +: ACCW] = qi;
         if (g >= P2 && g - P2 < NTAPS) begin : leaf
            always @(posedge clk) begin
               if (srst) begin
                  qr <= 0;
                  qi <= 0;
               end
               else if (en) begin
                  qr <= {{(ACCW-PW){p_rr[g-P2][PW-1]}}, p_rr[g-P2]} -
                        {{(ACCW-PW){p_ii[g-P2][PW-1]}}, p_ii[g-P2]};
                  qi <= {{(ACCW-PW){p_ri[g-P2][PW-1]}}, p_ri[g-P2]} +
                        {{(ACCW-PW){p_ir[g-P2][PW-1]}}, p_ir[g-P2]};
               end
            end
         end
         else if (g >= P2) begin : pad
            always @(posedge clk) begin
               qr <= 0;
               qi <= 0;
            end
         end
         else begin : add
            always @(posedge clk) begin
               if (srst) begin
                  qr <= 0;
                  qi <= 0;
               end
               else if (en) begin
                  qr <= $signed(node_r[2*g*ACCW +: ACCW]) + $signed(node_r[(2*g+1)*ACCW +: ACCW]);
                  qi <= $signed(node_i[2*g*ACCW +: ACCW]) + $signed(node_i[(2*g+1)*ACCW +: ACCW]);
               end
            end
         end
      end
   endgenerate

   // With NTAPS == 1 the single leaf (node 1) is also the root.
   wire signed [ACCW-1:0] sum_r = node_r[ACCW +: ACCW];
   wire signed [ACCW-1:0] sum_i = node_i[ACCW +: ACCW];

   // ------------------------------------------------------------ control pipe
   // index 0 = aligned with the M stage output, DEPTH-1 = output register
   integer i;
   reg [DEPTH-1:0] vp, lp;
   reg [4:0]       shp [0:DEPTH-1];

   always @(posedge clk) begin
      if (srst) begin
         vp <= 0;
         lp <= 0;
         for (i = 0; i < DEPTH; i = i + 1)
           shp[i] <= 5'd0;
      end
      else if (en) begin
         vp <= {vp[DEPTH-2:0], v0};
         lp <= {lp[DEPTH-2:0], l0};
         shp[0] <= sh0;
         for (i = 1; i < DEPTH; i = i + 1)
           shp[i] <= shp[i-1];
      end
   end

   // ------------------------------------------------------------ round, shift, saturate
   // shp[LEVELS+1] is the shift aligned with sum_r/sum_i.
   wire [4:0]           sh_sum = shp[LEVELS+1];
   wire signed [RW-1:0] rnd = (sh_sum == 5'd0) ? {RW{1'b0}} :
                              ({{(RW-1){1'b0}}, 1'b1} <<< (sh_sum - 5'd1));
   reg signed [RW-1:0]  rr, ri;

   always @(posedge clk) begin
      if (srst) begin
         rr <= 0;
         ri <= 0;
      end
      else if (en) begin
         rr <= $signed({sum_r[ACCW-1], sum_r}) + rnd;
         ri <= $signed({sum_i[ACCW-1], sum_i}) + rnd;
      end
   end

   wire [4:0]           sh_rnd = shp[LEVELS+2];
   wire signed [RW-1:0] qr = rr >>> sh_rnd;
   wire signed [RW-1:0] qi = ri >>> sh_rnd;

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

   always @(posedge clk) begin
      if (srst)
        y <= 32'b0;
      else if (en)
        y <= {sat16(qi), sat16(qr)};
   end

   wire y_valid = vp[DEPTH-1];
   wire y_last  = lp[DEPTH-1];

   // ------------------------------------------------------------ output FIFO
   wire push = en & y_valid;
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
            ob_last[ob_wr] <= y_last;
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

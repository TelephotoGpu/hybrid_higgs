// stream_stall: simulation-only random valid/ready injector.
//
// Without QSTREAM_STALL_INJECT this is a pure wire.  With it, a 2-entry FIFO
// randomly withholds t_ready and i_valid; once i_valid is shown it is held
// until accepted (AXI-stream compliant).  The pattern is seeded from the
// +STALL_SEED=<n> plusarg (default 1) mixed with the SALT parameter, so
// every shim in a design is independent and every seed is reproducible.
module stream_stall
  #(parameter SALT = 0)
   (input  wire        clk,
    input  wire        srst,

    input  wire [31:0] t_data,
    input  wire        t_last,
    input  wire        t_valid,
    output wire        t_ready,

    output wire [31:0] i_data,
    output wire        i_last,
    output wire        i_valid,
    input  wire        i_ready
    );

`ifdef QSTREAM_STALL_INJECT
   reg [31:0] rng;
   reg [31:0] sd;
   reg [31:0] fb_data [0:1];
   reg [1:0]  fb_last;
   reg [1:0]  fb_cnt;
   reg        fb_rd, fb_wr, shown;

   initial begin
      sd = 32'd1;
      if (!$value$plusargs("STALL_SEED=%d", sd))
        sd = 32'd1;
      rng = (sd * 32'h9E3779B1) ^ (SALT * 32'h85EBCA77) ^ 32'h2545F491;
      if (rng == 32'd0)
        rng = 32'h1;
      if ($test$plusargs("STALL_VERBOSE"))
        $display("stream_stall SALT %0d STALL_SEED %0d", SALT, sd);
   end

   // ~70% open on each side; a slow phase (rng[31:28]==0) closes both
   wire open_in  = (rng[2:0] > 3'd1) && (rng[31:28] != 4'd0);
   wire open_out = (rng[6:4] > 3'd1) && (rng[31:28] != 4'd0);

   assign t_ready = (fb_cnt != 2'd2) && open_in;
   assign i_valid = (fb_cnt != 2'd0) && (shown || open_out);
   assign i_data  = fb_data[fb_rd];
   assign i_last  = fb_last[fb_rd];
   wire push = t_valid & t_ready;
   wire pop  = i_valid & i_ready;

   always @(posedge clk) begin
      rng <= rng ^ (rng << 13) ^ ((rng ^ (rng << 13)) >> 17) ^
             ((rng ^ (rng << 13) ^ ((rng ^ (rng << 13)) >> 17)) << 5);
      if (srst) begin
         fb_cnt <= 2'd0;
         fb_rd <= 1'b0;
         fb_wr <= 1'b0;
         fb_last <= 2'b0;
         shown <= 1'b0;
      end
      else begin
         if (push) begin
            fb_data[fb_wr] <= t_data;
            fb_last[fb_wr] <= t_last;
            fb_wr <= ~fb_wr;
         end
         if (pop)
           fb_rd <= ~fb_rd;
         fb_cnt <= fb_cnt + {1'b0, push} - {1'b0, pop};
         shown <= i_valid & ~i_ready;
      end
   end
`else
   /* verilator lint_off UNUSED */
   wire unused = clk | srst;
   /* verilator lint_on UNUSED */
   assign i_data  = t_data;
   assign i_last  = t_last;
   assign i_valid = t_valid;
   assign t_ready = i_ready;
`endif

endmodule

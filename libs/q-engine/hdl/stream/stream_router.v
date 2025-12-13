// stream_router: 1 -> N packet router for the Q-engine DMA_3 stream.
//
// Contract: doc/add-fir/PLAN.md (phase 2).  The first word of every packet
// (words up to and including t_last) is a route word:
//   [31:16] = 0x5271, [15:4] = 0, [3:0] = port (< N)
// It is consumed; the rest of the packet is forwarded, last unchanged, to
// the selected port.  A bad route word drops the packet up to t_last and
// sets the sticky err.  A route word carrying t_last is a no-op.
//
// t_ready comes from the registered occupancy of a 2-entry input FIFO and
// i_valid/i_data from registers, so there is no combinational path from any
// i_ready to t_ready.
module stream_router
  #(parameter N = 2)
   (input  wire          clk,
    input  wire          srst,

    input  wire [31:0]   t_data,
    input  wire          t_last,
    input  wire          t_valid,
    output wire          t_ready,

    output wire [N*32-1:0] i_data,
    output wire [N-1:0]  i_last,
    output wire [N-1:0]  i_valid,
    input  wire [N-1:0]  i_ready,

    output reg           err,
    input  wire          err_clear
    );

   localparam [15:0] MAGIC = 16'h5271;
   localparam [1:0]  S_HDR = 2'd0, S_FWD = 2'd1, S_DRAIN = 2'd2;

   // ------------------------------------------------------------ input FIFO
   reg [31:0] fb_data [0:1];
   reg [1:0]  fb_last;
   reg [1:0]  fb_cnt;
   reg        fb_rd, fb_wr;

   assign t_ready = (fb_cnt != 2'd2);
   wire        push   = t_valid & t_ready;
   wire        h_valid = (fb_cnt != 2'd0);
   wire [31:0] h_data  = fb_data[fb_rd];
   wire        h_last  = fb_last[fb_rd];

   // ------------------------------------------------------------ routing
   reg [1:0] state;
   reg [3:0] port;

   wire route_ok = (h_data[31:16] == MAGIC) && (h_data[15:4] == 12'b0) &&
                   ({28'b0, h_data[3:0]} < N);
   reg  sel_ready;
   integer k;
   always @(*) begin
      sel_ready = 1'b0;
      for (k = 0; k < N; k = k + 1)
        if ({28'b0, port} == k)
          sel_ready = i_ready[k];
   end
   wire pop = h_valid & ((state != S_FWD) | sel_ready);

   genvar g;
   generate
      for (g = 0; g < N; g = g + 1) begin : o
         assign i_valid[g] = h_valid && (state == S_FWD) && ({28'b0, port} == g);
         assign i_data[g*32 +: 32] = h_data;
         assign i_last[g] = h_last;
      end
   endgenerate

   always @(posedge clk) begin
      if (srst) begin
         fb_cnt <= 2'd0;
         fb_rd <= 1'b0;
         fb_wr <= 1'b0;
         fb_last <= 2'b0;
         fb_data[0] <= 32'b0;
         fb_data[1] <= 32'b0;
         state <= S_HDR;
         port <= 4'd0;
         err <= 1'b0;
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

         if (err_clear)
           err <= 1'b0;
         if (pop) begin
            case (state)
              S_HDR:
                if (!route_ok) begin
                   err <= 1'b1;
                   state <= h_last ? S_HDR : S_DRAIN;
                end
                else begin
                   port <= h_data[3:0];
                   state <= h_last ? S_HDR : S_FWD;
                end
              default:
                if (h_last)
                  state <= S_HDR;
            endcase
         end
      end
   end

endmodule

// stream_merge: N -> 1 packet merge for the Q-engine DMA_4 stream.
//
// Contract: doc/add-fir/PLAN.md (phase 2).  Each output packet is prefixed
// with a tag word {16'h5271, 4'b0, seq[7:0], port[3:0]}, where seq counts
// that port's packets (wrapping).  Packet-level round robin: the winning
// port is locked until its t_last.  The tag never carries last.
//
// t_ready and i_valid/i_data derive only from registers (2-entry output
// FIFO), so there is no combinational path from i_ready to any t_ready.
module stream_merge
  #(parameter N = 2)
   (input  wire          clk,
    input  wire          srst,

    input  wire [N*32-1:0] t_data,
    input  wire [N-1:0]  t_last,
    input  wire [N-1:0]  t_valid,
    output wire [N-1:0]  t_ready,

    output wire [31:0]   i_data,
    output wire          i_last,
    output wire          i_valid,
    input  wire          i_ready
    );

   localparam [15:0] MAGIC = 16'h5271;
   localparam PW = (N > 1) ? $clog2(N) : 1;

   // ------------------------------------------------------------ output FIFO
   reg [31:0] ob_data [0:1];
   reg [1:0]  ob_last;
   reg [1:0]  ob_cnt;
   reg        ob_rd, ob_wr;
   wire       room = (ob_cnt != 2'd2);

   // ------------------------------------------------------------ arbiter
   reg          locked;
   reg [PW-1:0] cur;    // locked port
   reg [PW-1:0] rr;     // highest-priority port for the next packet
   reg [7:0]    seq [0:N-1];

   // round robin pick among t_valid starting at rr
   reg          any;
   reg [PW-1:0] pick;
   integer      k, c;
   always @(*) begin
      any = 1'b0;
      pick = rr;
      for (k = N - 1; k >= 0; k = k - 1) begin
         c = {{(32-PW){1'b0}}, rr} + k;
         if (c >= N)
           c = c - N;
         if (t_valid[c]) begin
            any = 1'b1;
            pick = c[PW-1:0];
         end
      end
   end

   genvar g;
   generate
      for (g = 0; g < N; g = g + 1) begin : tr
         assign t_ready[g] = locked && ({{(32-PW){1'b0}}, cur} == g) && room;
      end
   endgenerate

   wire [31:0] cur_data = t_data[cur*32 +: 32];
   wire        cur_last = t_last[cur];
   wire        fwd  = locked && room && t_valid[cur];
   wire        tag  = !locked && room && any;
   wire        push = fwd | tag;
   wire [31:0] tag_word = {MAGIC, 4'b0, seq[pick], {(4-PW){1'b0}}, pick};
   wire        pop  = i_ready & (ob_cnt != 2'd0);

   always @(posedge clk) begin
      if (srst) begin
         ob_cnt <= 2'd0;
         ob_rd <= 1'b0;
         ob_wr <= 1'b0;
         ob_last <= 2'b0;
         ob_data[0] <= 32'b0;
         ob_data[1] <= 32'b0;
         locked <= 1'b0;
         cur <= {PW{1'b0}};
         rr <= {PW{1'b0}};
         for (k = 0; k < N; k = k + 1)
           seq[k] <= 8'd0;
      end
      else begin
         if (push) begin
            ob_data[ob_wr] <= tag ? tag_word : cur_data;
            ob_last[ob_wr] <= tag ? 1'b0 : cur_last;
            ob_wr <= ~ob_wr;
         end
         if (pop)
           ob_rd <= ~ob_rd;
         ob_cnt <= ob_cnt + {1'b0, push} - {1'b0, pop};

         if (tag) begin
            locked <= 1'b1;
            cur <= pick;
            seq[pick] <= seq[pick] + 8'd1;
         end
         if (fwd && cur_last) begin
            locked <= 1'b0;
            rr <= ({{(32-PW){1'b0}}, cur} == N - 1) ? {PW{1'b0}} : cur + 1'b1;
         end
      end
   end

   assign i_valid = (ob_cnt != 2'd0);
   assign i_data  = ob_data[ob_rd];
   assign i_last  = ob_last[ob_rd];

endmodule

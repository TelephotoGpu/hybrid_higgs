// VMEM -> stream DMA with per-word `last` tracked on the returned-data side.
//
// Unlike dma_out, the last flag is decided when a read request is issued and
// stored in a tag FIFO; the tag is paired with the returned word in request
// order. The tag FIFO occupancy (outstanding reads + buffered words) is the
// credit count, so the data FIFO can never overflow and t0 needs no
// backpressure. Schedules are popped as soon as their last request is
// issued, so back-to-back schedules (e.g. header then payload) stream without
// a bubble. `status[0]` is busy (requests pending or words not yet consumed).
//
// dmaReset aborts the active schedule; if it already issued a word, the most
// recent issued word is forced to carry last=1 so the consumer sees a
// terminated packet.
module dma_out_last
  #(
    parameter DEPTH = 32  // power of two, >= VMEM read round trip for full rate
    )
   (input wire         clk,
    input wire         srst,
    input wire [31:0]  ctimer,
    //config
    input wire         config_valid,
    output reg         config_ready,
    input wire [31:0]  config_payload_startAddr,
    input wire [31:0]  config_payload_length,
    input wire [31:0]  config_payload_timerInit,
    input wire         config_payload_reverse,
    input wire         config_payload_last,

    input wire         dmaReset,
    output wire [31:0] status,
    output wire        strobe_complete,
    /* verilator lint_off SYMRSVDWORD */
    output wire        interrupt,
    /* verilator lint_on SYMRSVDWORD */
    input wire         interrupt_clear,
    //t0 stream <- memory read data
    input wire [31:0]  t0_data,
    input wire         t0_valid,
    output wire        t0_ready,
    //mem port -> read requests
    output wire [31:0] i0_addr,
    output wire        i0_valid,
    input wire         i0_ready,
    //output stream
    output wire [31:0] i1_data,
    output wire        i1_last,
    output wire        i1_valid,
    input wire         i1_ready
    );

   localparam AW = $clog2(DEPTH);
   localparam WAIT = 1'b0;
   localparam ENABLE = 1'b1;

   reg                 q_state;
   reg [31:0]          q_cnt, q_addr, q_length;
   reg                 q_last, q_reverse;
   reg                 q_strobe, q_interrupt;

   // tag FIFO: one entry per issued request, popped when the word leaves
   reg                 tag_mem [0:DEPTH-1];
   reg [AW-1:0]        tag_wp, tag_rp;
   reg [AW:0]          tag_count;
   // data FIFO: returned words
   reg [31:0]          dat_mem [0:DEPTH-1];
   reg [AW-1:0]        dat_wp, dat_rp;
   reg [AW:0]          dat_count;

   wire                tag_full = (tag_count == DEPTH);
   wire                req_fire = i0_valid & i0_ready;
   wire                ret_fire = t0_valid & t0_ready;
   wire                out_fire = i1_valid & i1_ready;
   wire                final_req = (q_cnt == q_length - 1);
   wire                start = (q_state == WAIT) && config_valid
                               && config_payload_length != 0
                               && ((ctimer == config_payload_timerInit)
                                   || &config_payload_timerInit);
   wire                abort = (q_state == ENABLE) && dmaReset;

   assign i0_valid = (q_state == ENABLE) && !tag_full && !dmaReset;
   assign i0_addr = q_addr;
   assign t0_ready = (dat_count != DEPTH);
   assign i1_valid = (dat_count != 0);
   assign i1_data = dat_mem[dat_rp];
   assign i1_last = tag_mem[tag_rp];
   assign strobe_complete = q_strobe;
   assign interrupt = q_interrupt;
   assign status = {16'b0, {(14-AW){1'b0}}, tag_count,
                    (q_state == ENABLE) || (tag_count != 0)};

   always @(*) begin
      config_ready = 1'b0;
      if (q_state == WAIT && config_valid && config_payload_length == 0)
        config_ready = 1'b1;
      if (q_state == ENABLE && (abort || (req_fire && final_req)))
        config_ready = 1'b1;
   end

   always @(posedge clk) begin
      if (req_fire)
        tag_mem[tag_wp] <= final_req & q_last;
      else if (abort && q_cnt != 0 && tag_count != 0)
        tag_mem[tag_wp - 1'b1] <= 1'b1;
      if (ret_fire)
        dat_mem[dat_wp] <= t0_data;
   end

   always @(posedge clk or posedge srst) begin
      if (srst) begin
         q_state <= WAIT;
         q_cnt <= 0;
         q_addr <= 0;
         q_length <= 0;
         q_last <= 1'b0;
         q_reverse <= 1'b0;
         q_strobe <= 1'b0;
         q_interrupt <= 1'b0;
         tag_wp <= 0;
         tag_rp <= 0;
         tag_count <= 0;
         dat_wp <= 0;
         dat_rp <= 0;
         dat_count <= 0;
      end else begin
         q_strobe <= 1'b0;
         if (interrupt_clear)
           q_interrupt <= 1'b0;

         case (q_state)
           WAIT: begin
              q_cnt <= 0;
              if (start) begin
                 q_state <= ENABLE;
                 q_addr <= config_payload_startAddr;
                 q_length <= config_payload_length;
                 q_last <= config_payload_last;
                 q_reverse <= config_payload_reverse;
              end
           end
           ENABLE: begin
              if (abort) begin
                 q_state <= WAIT;
              end else if (req_fire) begin
                 q_cnt <= q_cnt + 1;
                 q_addr <= q_reverse ? q_addr - 1 : q_addr + 1;
                 if (final_req) begin
                    q_state <= WAIT;
                    q_strobe <= 1'b1;
                    q_interrupt <= 1'b1;
                 end
              end
           end
         endcase

         if (req_fire)
           tag_wp <= tag_wp + 1'b1;
         if (out_fire)
           tag_rp <= tag_rp + 1'b1;
         tag_count <= tag_count + req_fire - out_fire;

         if (ret_fire)
           dat_wp <= dat_wp + 1'b1;
         if (out_fire)
           dat_rp <= dat_rp + 1'b1;
         dat_count <= dat_count + ret_fire - out_fire;
      end
   end

endmodule

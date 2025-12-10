// Generator : SpinalHDL v1.11.0    git head : 63852c61e498798f4e293594ce53fcb02c45eb6b
// Component : piston_dp



module piston_dp (
  input  wire          clk,
  input  wire          reset_n,
  input  wire [511:0]  t_k8_dat,
  input  wire          t_k8_req,
  output wire          t_k8_ack,
  input  wire [511:0]  t_k9_dat,
  input  wire          t_k9_req,
  output wire          t_k9_ack,
  input  wire [511:0]  t_k14_dat,
  input  wire          t_k14_req,
  output wire          t_k14_ack,
  output wire [511:0]  i_k1_dat,
  output wire          i_k1_req,
  input  wire          i_k1_ack
);

  wire       [0:0]    img_clk;
  wire       [0:0]    img_reset_n;
  wire       [0:0]    img_t_k8_req;
  wire       [0:0]    img_t_k9_req;
  wire       [0:0]    img_t_k14_req;
  wire       [0:0]    img_i_k1_ack;
  wire       [0:0]    img_t_k8_ack;
  wire       [0:0]    img_t_k9_ack;
  wire       [0:0]    img_t_k14_ack;
  wire       [511:0]  img_i_k1_dat;
  wire       [0:0]    img_i_k1_req;
  wire       [511:0]  t_k8_0;
  wire                t_k8_0_req;
  wire                t_k8_0_ack;
  wire                t_k8_0_m_req;
  wire                t_k8_0_m_ack;
  wire                t_k8_0_to_img_req;
  wire                t_k8_0_to_img_ack;
  wire       [511:0]  t_k9_0;
  wire                t_k9_0_req;
  wire                t_k9_0_ack;
  wire                t_k9_0_m_req;
  wire                t_k9_0_m_ack;
  wire                t_k9_0_to_img_req;
  wire                t_k9_0_to_img_ack;
  wire       [511:0]  t_k14_0;
  wire                t_k14_0_req;
  wire                t_k14_0_ack;
  wire                t_k14_0_m_req;
  wire                t_k14_0_m_ack;
  wire                t_k14_0_to_img_req;
  wire                t_k14_0_to_img_ack;
  wire       [511:0]  img_k1;
  wire       [511:0]  img_k1_nxt;
  wire                img_k1_req;
  wire                img_k1_ack;
  wire                img_k1_m_req;
  wire                img_k1_m_ack;
  wire                img_k1_to_i_k1_req;
  wire                img_k1_to_i_k1_ack;
  reg        [4:0]    img_k1_eb_state;
  reg        [4:0]    img_k1_eb_state_nxt;
  wire                img_k1_eb_en0;
  wire                img_k1_eb_en1;
  wire                img_k1_eb_sel;
  reg        [511:0]  img_k1_eb_r0;
  reg        [511:0]  img_k1_eb_r1;

  img_datapath img (
    .clk       (img_clk            ), //i
    .reset_n   (img_reset_n        ), //i
    .t_k8_dat  (t_k8_0[511:0]      ), //i
    .t_k8_req  (img_t_k8_req       ), //i
    .t_k8_ack  (img_t_k8_ack       ), //o
    .t_k9_dat  (t_k9_0[511:0]      ), //i
    .t_k9_req  (img_t_k9_req       ), //i
    .t_k9_ack  (img_t_k9_ack       ), //o
    .t_k14_dat (t_k14_0[511:0]     ), //i
    .t_k14_req (img_t_k14_req      ), //i
    .t_k14_ack (img_t_k14_ack      ), //o
    .i_k1_dat  (img_i_k1_dat[511:0]), //o
    .i_k1_req  (img_i_k1_req       ), //o
    .i_k1_ack  (img_i_k1_ack       )  //i
  );
  assign t_k8_0 = t_k8_dat;
  assign t_k8_0_req = t_k8_req;
  assign t_k8_ack = t_k8_0_ack;
  assign t_k9_0 = t_k9_dat;
  assign t_k9_0_req = t_k9_req;
  assign t_k9_ack = t_k9_0_ack;
  assign t_k14_0 = t_k14_dat;
  assign t_k14_0_req = t_k14_req;
  assign t_k14_ack = t_k14_0_ack;
  assign img_t_k8_req = t_k8_0_to_img_req;
  assign t_k8_0_to_img_ack = img_t_k8_ack[0];
  assign img_t_k9_req = t_k9_0_to_img_req;
  assign t_k9_0_to_img_ack = img_t_k9_ack[0];
  assign img_t_k14_req = t_k14_0_to_img_req;
  assign t_k14_0_to_img_ack = img_t_k14_ack[0];
  assign img_k1_nxt = img_i_k1_dat;
  assign img_k1_req = img_i_k1_req[0];
  assign img_i_k1_ack = img_k1_ack;
  assign img_clk = clk;
  assign img_reset_n = reset_n;
  assign i_k1_dat = img_k1;
  assign i_k1_req = img_k1_to_i_k1_req;
  assign img_k1_to_i_k1_ack = i_k1_ack;
  assign t_k8_0_m_req = t_k8_0_req;
  assign t_k8_0_ack = t_k8_0_m_ack;
  assign t_k8_0_to_img_req = t_k8_0_m_req;
  assign t_k8_0_m_ack = t_k8_0_to_img_ack;
  assign t_k9_0_m_req = t_k9_0_req;
  assign t_k9_0_ack = t_k9_0_m_ack;
  assign t_k9_0_to_img_req = t_k9_0_m_req;
  assign t_k9_0_m_ack = t_k9_0_to_img_ack;
  assign t_k14_0_m_req = t_k14_0_req;
  assign t_k14_0_ack = t_k14_0_m_ack;
  assign t_k14_0_to_img_req = t_k14_0_m_req;
  assign t_k14_0_m_ack = t_k14_0_to_img_ack;
  always @(*) begin
    img_k1_eb_state_nxt = img_k1_eb_state;
    case(img_k1_eb_state)
      5'h14 : begin
        if(img_k1_req) begin
          img_k1_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! img_k1_req) && img_k1_m_ack)) begin
          img_k1_eb_state_nxt = 5'h14;
        end
        if((img_k1_req && (! img_k1_m_ack))) begin
          img_k1_eb_state_nxt = 5'h08;
        end
        if((img_k1_req && img_k1_m_ack)) begin
          img_k1_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(img_k1_m_ack) begin
          img_k1_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! img_k1_req) && img_k1_m_ack)) begin
          img_k1_eb_state_nxt = 5'h14;
        end
        if((img_k1_req && (! img_k1_m_ack))) begin
          img_k1_eb_state_nxt = 5'h09;
        end
        if((img_k1_req && img_k1_m_ack)) begin
          img_k1_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(img_k1_m_ack) begin
          img_k1_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign img_k1_eb_en0 = (img_k1_eb_state[2] && img_k1_req);
  assign img_k1_eb_en1 = (img_k1_eb_state[1] && img_k1_req);
  assign img_k1_eb_sel = img_k1_eb_state[0];
  assign img_k1_ack = img_k1_eb_state[4];
  assign img_k1_m_req = img_k1_eb_state[3];
  assign img_k1 = (img_k1_eb_sel ? img_k1_eb_r1 : img_k1_eb_r0);
  assign img_k1_to_i_k1_req = img_k1_m_req;
  assign img_k1_m_ack = img_k1_to_i_k1_ack;
  always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
      img_k1_eb_state <= 5'h14;
    end else begin
      img_k1_eb_state <= img_k1_eb_state_nxt;
    end
  end

  always @(posedge clk) begin
    if(img_k1_eb_en0) begin
      img_k1_eb_r0 <= img_k1_nxt;
    end
    if(img_k1_eb_en1) begin
      img_k1_eb_r1 <= img_k1_nxt;
    end
  end


endmodule

// Generator : SpinalHDL v1.11.0    git head : 63852c61e498798f4e293594ce53fcb02c45eb6b
// Component : k15_op



module k15_op (
  input  wire          clk,
  input  wire          reset_n,
  input  wire [23:0]   t_k15_op_dat,
  input  wire          t_k15_op_req,
  output wire          t_k15_op_ack,
  output wire [23:0]   i_k15_op_dat,
  output wire          i_k15_op_req,
  input  wire          i_k15_op_ack
);

  wire       [23:0]   t_k15_op_0;
  wire       [23:0]   t_k15_op_0_nxt;
  wire                t_k15_op_0_req;
  wire                t_k15_op_0_ack;
  wire                t_k15_op_0_m_req;
  wire                t_k15_op_0_m_ack;
  wire                t_k15_op_0_to_unity1_req;
  wire                t_k15_op_0_to_unity1_ack;
  wire       [23:0]   unity1_0;
  wire       [23:0]   unity1_0_nxt;
  wire                unity1_0_req;
  wire                unity1_0_ack;
  wire                unity1_0_m_req;
  wire                unity1_0_m_ack;
  wire                unity1_0_to_unity2_req;
  wire                unity1_0_to_unity2_ack;
  wire       [23:0]   unity2_0;
  wire       [23:0]   unity2_0_nxt;
  wire                unity2_0_req;
  wire                unity2_0_ack;
  wire                unity2_0_m_req;
  wire                unity2_0_m_ack;
  wire                unity2_0_to_i_k15_op_req;
  wire                unity2_0_to_i_k15_op_ack;
  reg        [4:0]    t_k15_op_0_eb_state;
  reg        [4:0]    t_k15_op_0_eb_state_nxt;
  wire                t_k15_op_0_eb_en0;
  wire                t_k15_op_0_eb_en1;
  wire                t_k15_op_0_eb_sel;
  reg        [23:0]   t_k15_op_0_eb_r0;
  reg        [23:0]   t_k15_op_0_eb_r1;
  reg                 unity1_0_eb_valid;
  wire                unity1_0_eb_en;
  reg        [23:0]   unity1_0_eb_r;
  reg        [4:0]    unity2_0_eb_state;
  reg        [4:0]    unity2_0_eb_state_nxt;
  wire                unity2_0_eb_en0;
  wire                unity2_0_eb_en1;
  wire                unity2_0_eb_sel;
  reg        [23:0]   unity2_0_eb_r0;
  reg        [23:0]   unity2_0_eb_r1;

  assign t_k15_op_0_nxt = t_k15_op_dat;
  assign t_k15_op_0_req = t_k15_op_req;
  assign t_k15_op_ack = t_k15_op_0_ack;
  assign unity1_0_nxt = t_k15_op_0;
  assign unity1_0_req = t_k15_op_0_to_unity1_req;
  assign t_k15_op_0_to_unity1_ack = unity1_0_ack;
  assign unity2_0_nxt = unity1_0;
  assign unity2_0_req = unity1_0_to_unity2_req;
  assign unity1_0_to_unity2_ack = unity2_0_ack;
  assign i_k15_op_dat = unity2_0;
  assign i_k15_op_req = unity2_0_to_i_k15_op_req;
  assign unity2_0_to_i_k15_op_ack = i_k15_op_ack;
  always @(*) begin
    t_k15_op_0_eb_state_nxt = t_k15_op_0_eb_state;
    case(t_k15_op_0_eb_state)
      5'h14 : begin
        if(t_k15_op_0_req) begin
          t_k15_op_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! t_k15_op_0_req) && t_k15_op_0_m_ack)) begin
          t_k15_op_0_eb_state_nxt = 5'h14;
        end
        if((t_k15_op_0_req && (! t_k15_op_0_m_ack))) begin
          t_k15_op_0_eb_state_nxt = 5'h08;
        end
        if((t_k15_op_0_req && t_k15_op_0_m_ack)) begin
          t_k15_op_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(t_k15_op_0_m_ack) begin
          t_k15_op_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! t_k15_op_0_req) && t_k15_op_0_m_ack)) begin
          t_k15_op_0_eb_state_nxt = 5'h14;
        end
        if((t_k15_op_0_req && (! t_k15_op_0_m_ack))) begin
          t_k15_op_0_eb_state_nxt = 5'h09;
        end
        if((t_k15_op_0_req && t_k15_op_0_m_ack)) begin
          t_k15_op_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(t_k15_op_0_m_ack) begin
          t_k15_op_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign t_k15_op_0_eb_en0 = (t_k15_op_0_eb_state[2] && t_k15_op_0_req);
  assign t_k15_op_0_eb_en1 = (t_k15_op_0_eb_state[1] && t_k15_op_0_req);
  assign t_k15_op_0_eb_sel = t_k15_op_0_eb_state[0];
  assign t_k15_op_0_ack = t_k15_op_0_eb_state[4];
  assign t_k15_op_0_m_req = t_k15_op_0_eb_state[3];
  assign t_k15_op_0 = (t_k15_op_0_eb_sel ? t_k15_op_0_eb_r1 : t_k15_op_0_eb_r0);
  assign t_k15_op_0_to_unity1_req = t_k15_op_0_m_req;
  assign t_k15_op_0_m_ack = t_k15_op_0_to_unity1_ack;
  assign unity1_0_ack = ((! unity1_0_eb_valid) || unity1_0_m_ack);
  assign unity1_0_eb_en = (unity1_0_req && unity1_0_ack);
  assign unity1_0_m_req = unity1_0_eb_valid;
  assign unity1_0 = unity1_0_eb_r;
  assign unity1_0_to_unity2_req = unity1_0_m_req;
  assign unity1_0_m_ack = unity1_0_to_unity2_ack;
  always @(*) begin
    unity2_0_eb_state_nxt = unity2_0_eb_state;
    case(unity2_0_eb_state)
      5'h14 : begin
        if(unity2_0_req) begin
          unity2_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! unity2_0_req) && unity2_0_m_ack)) begin
          unity2_0_eb_state_nxt = 5'h14;
        end
        if((unity2_0_req && (! unity2_0_m_ack))) begin
          unity2_0_eb_state_nxt = 5'h08;
        end
        if((unity2_0_req && unity2_0_m_ack)) begin
          unity2_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(unity2_0_m_ack) begin
          unity2_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! unity2_0_req) && unity2_0_m_ack)) begin
          unity2_0_eb_state_nxt = 5'h14;
        end
        if((unity2_0_req && (! unity2_0_m_ack))) begin
          unity2_0_eb_state_nxt = 5'h09;
        end
        if((unity2_0_req && unity2_0_m_ack)) begin
          unity2_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(unity2_0_m_ack) begin
          unity2_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign unity2_0_eb_en0 = (unity2_0_eb_state[2] && unity2_0_req);
  assign unity2_0_eb_en1 = (unity2_0_eb_state[1] && unity2_0_req);
  assign unity2_0_eb_sel = unity2_0_eb_state[0];
  assign unity2_0_ack = unity2_0_eb_state[4];
  assign unity2_0_m_req = unity2_0_eb_state[3];
  assign unity2_0 = (unity2_0_eb_sel ? unity2_0_eb_r1 : unity2_0_eb_r0);
  assign unity2_0_to_i_k15_op_req = unity2_0_m_req;
  assign unity2_0_m_ack = unity2_0_to_i_k15_op_ack;
  always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
      t_k15_op_0_eb_state <= 5'h14;
      unity1_0_eb_valid <= 1'b0;
      unity2_0_eb_state <= 5'h14;
    end else begin
      t_k15_op_0_eb_state <= t_k15_op_0_eb_state_nxt;
      unity1_0_eb_valid <= ((! unity1_0_ack) || unity1_0_req);
      unity2_0_eb_state <= unity2_0_eb_state_nxt;
    end
  end

  always @(posedge clk) begin
    if(t_k15_op_0_eb_en0) begin
      t_k15_op_0_eb_r0 <= t_k15_op_0_nxt;
    end
    if(t_k15_op_0_eb_en1) begin
      t_k15_op_0_eb_r1 <= t_k15_op_0_nxt;
    end
    if(unity1_0_eb_en) begin
      unity1_0_eb_r <= unity1_0_nxt;
    end
    if(unity2_0_eb_en0) begin
      unity2_0_eb_r0 <= unity2_0_nxt;
    end
    if(unity2_0_eb_en1) begin
      unity2_0_eb_r1 <= unity2_0_nxt;
    end
  end


endmodule

// Generator : SpinalHDL v1.11.0    git head : 63852c61e498798f4e293594ce53fcb02c45eb6b
// Component : piston



module piston #(
  parameter VMEM_SIZE = 4096,
  parameter VMEM0 = "vmem0.mif",
  parameter VMEM1 = "vmem1.mif",
  parameter VMEM2 = "vmem2.mif",
  parameter VMEM3 = "vmem3.mif",
  parameter VMEM4 = "vmem4.mif",
  parameter VMEM5 = "vmem5.mif",
  parameter VMEM6 = "vmem6.mif",
  parameter VMEM7 = "vmem7.mif",
  parameter VMEM8 = "vmem8.mif",
  parameter VMEM9 = "vmem9.mif",
  parameter VMEM10 = "vmem10.mif",
  parameter VMEM11 = "vmem11.mif",
  parameter VMEM12 = "vmem12.mif",
  parameter VMEM13 = "vmem13.mif",
  parameter VMEM14 = "vmem14.mif",
  parameter VMEM15 = "vmem15.mif",
  parameter VMEM16 = "vmem16.mif",
  parameter VMEM17 = "vmem17.mif",
  parameter VMEM18 = "vmem18.mif",
  parameter VMEM19 = "vmem19.mif",
  parameter VMEM20 = "vmem20.mif",
  parameter VMEM21 = "vmem21.mif",
  parameter VMEM22 = "vmem22.mif",
  parameter VMEM23 = "vmem23.mif",
  parameter VMEM24 = "vmem24.mif",
  parameter VMEM25 = "vmem25.mif",
  parameter VMEM26 = "vmem26.mif",
  parameter VMEM27 = "vmem27.mif",
  parameter VMEM28 = "vmem28.mif",
  parameter VMEM29 = "vmem29.mif",
  parameter VMEM30 = "vmem30.mif",
  parameter VMEM31 = "vmem31.mif"
) (
  input  wire          clk,
  input  wire          reset_n,
  input  wire [63:0]   t_instr_dat,
  input  wire          t_instr_req,
  output wire          t_instr_ack,
  input  wire [48:0]   t_idma_0_dat,
  input  wire          t_idma_0_req,
  output wire          t_idma_0_ack,
  input  wire [48:0]   t_idma_1_dat,
  input  wire          t_idma_1_req,
  output wire          t_idma_1_ack,
  input  wire [48:0]   t_idma_2_dat,
  input  wire          t_idma_2_req,
  output wire          t_idma_2_ack,
  input  wire [48:0]   t_idma_3_dat,
  input  wire          t_idma_3_req,
  output wire          t_idma_3_ack,
  output wire [31:0]   i_odma_0_dat,
  output wire          i_odma_0_req,
  input  wire          i_odma_0_ack,
  output wire [31:0]   i_odma_1_dat,
  output wire          i_odma_1_req,
  input  wire          i_odma_1_ack,
  output wire [31:0]   i_odma_2_dat,
  output wire          i_odma_2_req,
  input  wire          i_odma_2_ack,
  output wire [31:0]   i_odma_3_dat,
  output wire          i_odma_3_req,
  input  wire          i_odma_3_ack
);

  wire       [0:0]    vector_clk;
  wire       [0:0]    vector_reset_n;
  wire       [0:0]    vector_ctrl_t_instr_0_req;
  wire       [0:0]    vector_ctrl_t_instr_1_req;
  wire       [0:0]    vector_ctrl_t_instr_2_req;
  wire       [0:0]    vector_ctrl_t_instr_3_req;
  wire       [0:0]    vector_ctrl_t_instr_4_req;
  wire       [0:0]    vector_ctrl_t_instr_5_req;
  wire       [0:0]    vector_ctrl_t_instr_6_req;
  wire       [0:0]    vector_ctrl_t_instr_7_req;
  wire       [0:0]    vector_ctrl_t_instr_8_req;
  wire       [0:0]    vector_ctrl_t_instr_9_req;
  wire       [0:0]    vector_ctrl_t_instr_10_req;
  wire       [0:0]    vector_ctrl_t_instr_11_req;
  wire       [0:0]    vector_ctrl_t_instr_12_req;
  wire       [0:0]    vector_ctrl_t_instr_13_req;
  wire       [0:0]    vector_ctrl_t_instr_14_req;
  wire       [0:0]    vector_ctrl_t_instr_15_req;
  wire       [0:0]    vector_ctrl_t_k15_req;
  wire       [0:0]    vector_ctrl_i_k15_ack;
  wire       [0:0]    vector_ctrl_i_kap_ack;
  wire       [0:0]    vector_ctrl_clk;
  wire       [0:0]    vector_ctrl_reset_n;
  wire       [0:0]    inmux_clk;
  wire       [0:0]    inmux_reset_n;
  wire       [0:0]    inmux_ctrl_t_k1_req;
  wire       [0:0]    inmux_ctrl_t_k13_req;
  wire       [0:0]    inmux_ctrl_t_k15_req;
  wire       [0:0]    inmux_ctrl_t_c_req;
  wire       [0:0]    inmux_ctrl_i_inmux_ack;
  wire       [0:0]    inmux_ctrl_clk;
  wire       [0:0]    inmux_ctrl_reset_n;
  wire       [0:0]    vmem_clk;
  wire       [0:0]    vmem_reset_n;
  wire       [0:0]    vmem_ctrl_t_idma_0_req;
  wire       [0:0]    vmem_ctrl_t_idma_1_req;
  wire       [0:0]    vmem_ctrl_t_idma_2_req;
  wire       [0:0]    vmem_ctrl_t_idma_3_req;
  wire       [0:0]    vmem_ctrl_i_odma_0_ack;
  wire       [0:0]    vmem_ctrl_i_odma_1_ack;
  wire       [0:0]    vmem_ctrl_i_odma_2_ack;
  wire       [0:0]    vmem_ctrl_i_odma_3_ack;
  wire       [0:0]    vmem_ctrl_t_ka_req;
  wire       [0:0]    vmem_ctrl_t_ivs_req;
  wire       [0:0]    vmem_ctrl_i_ovs_ack;
  wire       [0:0]    vmem_ctrl_clk;
  wire       [0:0]    vmem_ctrl_reset_n;
  wire       [0:0]    oumux_clk;
  wire       [0:0]    oumux_reset_n;
  wire       [0:0]    oumux_ctrl_i_k8_ack;
  wire       [0:0]    oumux_ctrl_i_k9_ack;
  wire       [0:0]    oumux_ctrl_i_k13_ack;
  wire       [0:0]    oumux_ctrl_i_k14_ack;
  wire       [0:0]    oumux_ctrl_i_k15_ack;
  wire       [0:0]    oumux_ctrl_t_c_req;
  wire       [0:0]    oumux_ctrl_t_oumux_req;
  wire       [0:0]    oumux_ctrl_clk;
  wire       [0:0]    oumux_ctrl_reset_n;
  wire       [0:0]    perm_full_addr_clk;
  wire       [0:0]    perm_full_addr_reset_n;
  wire       [63:0]   iperm_data_t_addr_dat;
  wire       [0:0]    iperm_data_clk;
  wire       [0:0]    iperm_data_reset_n;
  wire       [63:0]   operm_data_t_addr_dat;
  wire       [0:0]    operm_data_clk;
  wire       [0:0]    operm_data_reset_n;
  wire       [0:0]    ka_decode_clk;
  wire       [0:0]    ka_decode_reset_n;
  wire       [0:0]    ka_decode_ctrl_t_ka_req;
  wire       [0:0]    ka_decode_ctrl_i_k_sk_ack;
  wire       [0:0]    ka_decode_ctrl_i_k_lk_ack;
  wire       [0:0]    ka_decode_ctrl_i_ka_ack;
  wire       [0:0]    ka_decode_ctrl_clk;
  wire       [0:0]    ka_decode_ctrl_reset_n;
  wire       [0:0]    p_decode_clk;
  wire       [0:0]    p_decode_reset_n;
  wire       [0:0]    p_decode_ctrl_t_kp_req;
  wire       [0:0]    p_decode_ctrl_i_p_sk_ack;
  wire       [0:0]    p_decode_ctrl_i_p_lk_ack;
  wire       [0:0]    p_decode_ctrl_clk;
  wire       [0:0]    p_decode_ctrl_reset_n;
  wire       [0:0]    dp_clk;
  wire       [0:0]    dp_reset_n;
  wire       [0:0]    dp_t_k8_req;
  wire       [0:0]    dp_t_k9_req;
  wire       [0:0]    dp_t_k14_req;
  wire       [0:0]    dp_i_k1_ack;
  reg        [511:0]  oumux_k13_eb_mem_spinal_port1;
  reg        [195:0]  ka_decode_ka_eb_mem_spinal_port1;
  reg        [3:0]    ka_decode_k_sk_eb_mem_spinal_port1;
  reg        [3:0]    ka_decode_k_lk_eb_mem_spinal_port1;
  reg        [67:0]   p_decode_p_sk_eb_mem_spinal_port1;
  reg        [67:0]   p_decode_p_lk_eb_mem_spinal_port1;
  wire       [0:0]    vector_instr_0_ready;
  wire       [0:0]    vector_instr_1_ready;
  wire       [0:0]    vector_instr_2_ready;
  wire       [0:0]    vector_instr_3_ready;
  wire       [0:0]    vector_instr_4_ready;
  wire       [0:0]    vector_instr_5_ready;
  wire       [0:0]    vector_instr_6_ready;
  wire       [0:0]    vector_instr_7_ready;
  wire       [0:0]    vector_instr_8_ready;
  wire       [0:0]    vector_instr_9_ready;
  wire       [0:0]    vector_instr_10_ready;
  wire       [0:0]    vector_instr_11_ready;
  wire       [0:0]    vector_instr_12_ready;
  wire       [0:0]    vector_instr_13_ready;
  wire       [0:0]    vector_instr_14_ready;
  wire       [0:0]    vector_instr_15_ready;
  wire       [0:0]    vector_tk15_ready;
  wire       [511:0]  vector_i_k15_dat;
  wire       [0:0]    vector_ik15_valid;
  wire       [263:0]  vector_i_kap_dat;
  wire       [0:0]    vector_kap_valid;
  wire       [0:0]    vector_ctrl_t_instr_0_ack;
  wire       [0:0]    vector_ctrl_t_instr_1_ack;
  wire       [0:0]    vector_ctrl_t_instr_2_ack;
  wire       [0:0]    vector_ctrl_t_instr_3_ack;
  wire       [0:0]    vector_ctrl_t_instr_4_ack;
  wire       [0:0]    vector_ctrl_t_instr_5_ack;
  wire       [0:0]    vector_ctrl_t_instr_6_ack;
  wire       [0:0]    vector_ctrl_t_instr_7_ack;
  wire       [0:0]    vector_ctrl_t_instr_8_ack;
  wire       [0:0]    vector_ctrl_t_instr_9_ack;
  wire       [0:0]    vector_ctrl_t_instr_10_ack;
  wire       [0:0]    vector_ctrl_t_instr_11_ack;
  wire       [0:0]    vector_ctrl_t_instr_12_ack;
  wire       [0:0]    vector_ctrl_t_instr_13_ack;
  wire       [0:0]    vector_ctrl_t_instr_14_ack;
  wire       [0:0]    vector_ctrl_t_instr_15_ack;
  wire       [0:0]    vector_ctrl_t_k15_ack;
  wire       [0:0]    vector_ctrl_i_k15_req;
  wire       [0:0]    vector_ctrl_i_kap_req;
  wire       [0:0]    vector_ctrl_instr_0_valid;
  wire       [0:0]    vector_ctrl_instr_1_valid;
  wire       [0:0]    vector_ctrl_instr_2_valid;
  wire       [0:0]    vector_ctrl_instr_3_valid;
  wire       [0:0]    vector_ctrl_instr_4_valid;
  wire       [0:0]    vector_ctrl_instr_5_valid;
  wire       [0:0]    vector_ctrl_instr_6_valid;
  wire       [0:0]    vector_ctrl_instr_7_valid;
  wire       [0:0]    vector_ctrl_instr_8_valid;
  wire       [0:0]    vector_ctrl_instr_9_valid;
  wire       [0:0]    vector_ctrl_instr_10_valid;
  wire       [0:0]    vector_ctrl_instr_11_valid;
  wire       [0:0]    vector_ctrl_instr_12_valid;
  wire       [0:0]    vector_ctrl_instr_13_valid;
  wire       [0:0]    vector_ctrl_instr_14_valid;
  wire       [0:0]    vector_ctrl_instr_15_valid;
  wire       [0:0]    vector_ctrl_tk15_valid;
  wire       [0:0]    vector_ctrl_ik15_ready;
  wire       [0:0]    vector_ctrl_kap_ready;
  wire       [511:0]  inmux_i_inmux_dat;
  wire       [3:0]    inmux_sel;
  wire       [0:0]    inmux_ctrl_t_k1_ack;
  wire       [0:0]    inmux_ctrl_t_k13_ack;
  wire       [0:0]    inmux_ctrl_t_k15_ack;
  wire       [0:0]    inmux_ctrl_t_c_ack;
  wire       [0:0]    inmux_ctrl_i_inmux_req;
  wire       [3:0]    vmem_idma_ready;
  wire       [31:0]   vmem_i_odma_0_dat;
  wire       [31:0]   vmem_i_odma_1_dat;
  wire       [31:0]   vmem_i_odma_2_dat;
  wire       [31:0]   vmem_i_odma_3_dat;
  wire       [3:0]    vmem_odma_valid;
  wire       [0:0]    vmem_tvs_ready;
  wire       [511:0]  vmem_i_ovs_dat;
  wire       [0:0]    vmem_ivs_valid;
  wire       [3:0]    vmem_k_ctrl;
  wire       [0:0]    vmem_ctrl_t_idma_0_ack;
  wire       [0:0]    vmem_ctrl_t_idma_1_ack;
  wire       [0:0]    vmem_ctrl_t_idma_2_ack;
  wire       [0:0]    vmem_ctrl_t_idma_3_ack;
  wire       [0:0]    vmem_ctrl_i_odma_0_req;
  wire       [0:0]    vmem_ctrl_i_odma_1_req;
  wire       [0:0]    vmem_ctrl_i_odma_2_req;
  wire       [0:0]    vmem_ctrl_i_odma_3_req;
  wire       [0:0]    vmem_ctrl_t_ka_ack;
  wire       [0:0]    vmem_ctrl_t_ivs_ack;
  wire       [0:0]    vmem_ctrl_i_ovs_req;
  wire       [3:0]    vmem_ctrl_idma_valid;
  wire       [3:0]    vmem_ctrl_odma_ready;
  wire       [0:0]    vmem_ctrl_tvs_valid;
  wire       [0:0]    vmem_ctrl_ivs_ready;
  wire       [511:0]  oumux_i_k8_dat;
  wire       [511:0]  oumux_i_k9_dat;
  wire       [511:0]  oumux_i_k13_dat;
  wire       [511:0]  oumux_i_k14_dat;
  wire       [511:0]  oumux_i_k15_dat;
  wire       [3:0]    oumux_sel;
  wire       [0:0]    oumux_ctrl_i_k8_req;
  wire       [0:0]    oumux_ctrl_i_k9_req;
  wire       [0:0]    oumux_ctrl_i_k13_req;
  wire       [0:0]    oumux_ctrl_i_k14_req;
  wire       [0:0]    oumux_ctrl_i_k15_req;
  wire       [0:0]    oumux_ctrl_t_c_ack;
  wire       [0:0]    oumux_ctrl_t_oumux_ack;
  wire       [67:0]   perm_full_addr_i_0_dat;
  wire       [511:0]  iperm_data_i_data_dat;
  wire       [511:0]  operm_data_i_data_dat;
  wire       [3:0]    ka_decode_i_k_sk_dat;
  wire       [3:0]    ka_decode_i_k_lk_dat;
  wire       [195:0]  ka_decode_i_ka_dat;
  wire       [3:0]    ka_decode_k_ctrl;
  wire       [0:0]    ka_decode_ctrl_t_ka_ack;
  wire       [0:0]    ka_decode_ctrl_i_k_sk_req;
  wire       [0:0]    ka_decode_ctrl_i_k_lk_req;
  wire       [0:0]    ka_decode_ctrl_i_ka_req;
  wire       [63:0]   p_decode_i_p_sk_dat;
  wire       [63:0]   p_decode_i_p_lk_dat;
  wire       [3:0]    p_decode_k_ctrl;
  wire       [0:0]    p_decode_ctrl_t_kp_ack;
  wire       [0:0]    p_decode_ctrl_i_p_sk_req;
  wire       [0:0]    p_decode_ctrl_i_p_lk_req;
  wire       [0:0]    dp_t_k8_ack;
  wire       [0:0]    dp_t_k9_ack;
  wire       [0:0]    dp_t_k14_ack;
  wire       [511:0]  dp_i_k1_dat;
  wire       [0:0]    dp_i_k1_req;
  wire       [1:0]    _zz_oumux_k13_eb_wr_ptr;
  wire       [1:0]    _zz__zz_oumux_k13_eb_q_rd_ptr;
  wire       [1:0]    _zz_ka_decode_ka_eb_wr_ptr;
  wire       [1:0]    _zz__zz_ka_decode_ka_eb_q_rd_ptr;
  wire       [0:0]    _zz_ka_decode_k_sk_eb_wr_ptr;
  wire       [0:0]    _zz__zz_ka_decode_k_sk_eb_q_rd_ptr;
  wire       [1:0]    _zz_ka_decode_k_lk_eb_wr_ptr;
  wire       [1:0]    _zz__zz_ka_decode_k_lk_eb_q_rd_ptr;
  wire       [1:0]    _zz_p_decode_p_sk_eb_wr_ptr;
  wire       [1:0]    _zz__zz_p_decode_p_sk_eb_q_rd_ptr;
  wire       [1:0]    _zz_p_decode_p_lk_eb_wr_ptr;
  wire       [1:0]    _zz__zz_p_decode_p_lk_eb_q_rd_ptr;
  wire       [63:0]   t_instr_0;
  wire       [63:0]   t_instr_0_nxt;
  wire                t_instr_0_req;
  wire                t_instr_0_ack;
  wire                t_instr_0_m_req;
  wire                t_instr_0_m_ack;
  wire                t_instr_0_to_cmd_s1_0_req;
  wire                t_instr_0_to_cmd_s1_1_req;
  wire                t_instr_0_to_cmd_s1_0_ack;
  wire                t_instr_0_to_cmd_s1_1_ack;
  wire       [63:0]   cmd_s1_0_0;
  wire       [63:0]   cmd_s1_0_0_nxt;
  wire                cmd_s1_0_0_req;
  wire                cmd_s1_0_0_ack;
  wire                cmd_s1_0_0_m_req;
  wire                cmd_s1_0_0_m_ack;
  wire                cmd_s1_0_0_to_cmd_s2_0_req;
  wire                cmd_s1_0_0_to_cmd_s2_1_req;
  wire                cmd_s1_0_0_to_cmd_s2_0_ack;
  wire                cmd_s1_0_0_to_cmd_s2_1_ack;
  wire       [63:0]   cmd_s1_1_0;
  wire       [63:0]   cmd_s1_1_0_nxt;
  wire                cmd_s1_1_0_req;
  wire                cmd_s1_1_0_ack;
  wire                cmd_s1_1_0_m_req;
  wire                cmd_s1_1_0_m_ack;
  wire                cmd_s1_1_0_to_cmd_s2_2_req;
  wire                cmd_s1_1_0_to_cmd_s2_3_req;
  wire                cmd_s1_1_0_to_cmd_s2_2_ack;
  wire                cmd_s1_1_0_to_cmd_s2_3_ack;
  wire       [63:0]   cmd_s2_0_0;
  wire       [63:0]   cmd_s2_0_0_nxt;
  wire                cmd_s2_0_0_req;
  wire                cmd_s2_0_0_ack;
  wire                cmd_s2_0_0_m_req;
  wire                cmd_s2_0_0_m_ack;
  wire                cmd_s2_0_0_to_cmd_s3_0_req;
  wire                cmd_s2_0_0_to_cmd_s3_1_req;
  wire                cmd_s2_0_0_to_cmd_s3_0_ack;
  wire                cmd_s2_0_0_to_cmd_s3_1_ack;
  wire       [63:0]   cmd_s2_1_0;
  wire       [63:0]   cmd_s2_1_0_nxt;
  wire                cmd_s2_1_0_req;
  wire                cmd_s2_1_0_ack;
  wire                cmd_s2_1_0_m_req;
  wire                cmd_s2_1_0_m_ack;
  wire                cmd_s2_1_0_to_cmd_s3_2_req;
  wire                cmd_s2_1_0_to_cmd_s3_3_req;
  wire                cmd_s2_1_0_to_cmd_s3_2_ack;
  wire                cmd_s2_1_0_to_cmd_s3_3_ack;
  wire       [63:0]   cmd_s2_2_0;
  wire       [63:0]   cmd_s2_2_0_nxt;
  wire                cmd_s2_2_0_req;
  wire                cmd_s2_2_0_ack;
  wire                cmd_s2_2_0_m_req;
  wire                cmd_s2_2_0_m_ack;
  wire                cmd_s2_2_0_to_cmd_s3_4_req;
  wire                cmd_s2_2_0_to_cmd_s3_5_req;
  wire                cmd_s2_2_0_to_cmd_s3_4_ack;
  wire                cmd_s2_2_0_to_cmd_s3_5_ack;
  wire       [63:0]   cmd_s2_3_0;
  wire       [63:0]   cmd_s2_3_0_nxt;
  wire                cmd_s2_3_0_req;
  wire                cmd_s2_3_0_ack;
  wire                cmd_s2_3_0_m_req;
  wire                cmd_s2_3_0_m_ack;
  wire                cmd_s2_3_0_to_cmd_s3_6_req;
  wire                cmd_s2_3_0_to_cmd_s3_7_req;
  wire                cmd_s2_3_0_to_cmd_s3_6_ack;
  wire                cmd_s2_3_0_to_cmd_s3_7_ack;
  wire       [63:0]   cmd_s3_0_0;
  wire       [63:0]   cmd_s3_0_0_nxt;
  wire                cmd_s3_0_0_req;
  wire                cmd_s3_0_0_ack;
  wire                cmd_s3_0_0_m_req;
  wire                cmd_s3_0_0_m_ack;
  wire                cmd_s3_0_0_to_cmd_lane_0_req;
  wire                cmd_s3_0_0_to_cmd_lane_1_req;
  wire                cmd_s3_0_0_to_cmd_lane_0_ack;
  wire                cmd_s3_0_0_to_cmd_lane_1_ack;
  wire       [63:0]   cmd_lane_0_0;
  wire       [63:0]   cmd_lane_0_0_nxt;
  wire                cmd_lane_0_0_req;
  wire                cmd_lane_0_0_ack;
  wire                cmd_lane_0_0_m_req;
  wire                cmd_lane_0_0_m_ack;
  wire                cmd_lane_0_0_to_vector_req;
  wire                cmd_lane_0_0_to_vector_ack;
  wire       [63:0]   cmd_lane_1_0;
  wire       [63:0]   cmd_lane_1_0_nxt;
  wire                cmd_lane_1_0_req;
  wire                cmd_lane_1_0_ack;
  wire                cmd_lane_1_0_m_req;
  wire                cmd_lane_1_0_m_ack;
  wire                cmd_lane_1_0_to_vector_req;
  wire                cmd_lane_1_0_to_vector_ack;
  wire       [63:0]   cmd_s3_1_0;
  wire       [63:0]   cmd_s3_1_0_nxt;
  wire                cmd_s3_1_0_req;
  wire                cmd_s3_1_0_ack;
  wire                cmd_s3_1_0_m_req;
  wire                cmd_s3_1_0_m_ack;
  wire                cmd_s3_1_0_to_cmd_lane_2_req;
  wire                cmd_s3_1_0_to_cmd_lane_3_req;
  wire                cmd_s3_1_0_to_cmd_lane_2_ack;
  wire                cmd_s3_1_0_to_cmd_lane_3_ack;
  wire       [63:0]   cmd_lane_2_0;
  wire       [63:0]   cmd_lane_2_0_nxt;
  wire                cmd_lane_2_0_req;
  wire                cmd_lane_2_0_ack;
  wire                cmd_lane_2_0_m_req;
  wire                cmd_lane_2_0_m_ack;
  wire                cmd_lane_2_0_to_vector_req;
  wire                cmd_lane_2_0_to_vector_ack;
  wire       [63:0]   cmd_lane_3_0;
  wire       [63:0]   cmd_lane_3_0_nxt;
  wire                cmd_lane_3_0_req;
  wire                cmd_lane_3_0_ack;
  wire                cmd_lane_3_0_m_req;
  wire                cmd_lane_3_0_m_ack;
  wire                cmd_lane_3_0_to_vector_req;
  wire                cmd_lane_3_0_to_vector_ack;
  wire       [63:0]   cmd_s3_2_0;
  wire       [63:0]   cmd_s3_2_0_nxt;
  wire                cmd_s3_2_0_req;
  wire                cmd_s3_2_0_ack;
  wire                cmd_s3_2_0_m_req;
  wire                cmd_s3_2_0_m_ack;
  wire                cmd_s3_2_0_to_cmd_lane_4_req;
  wire                cmd_s3_2_0_to_cmd_lane_5_req;
  wire                cmd_s3_2_0_to_cmd_lane_4_ack;
  wire                cmd_s3_2_0_to_cmd_lane_5_ack;
  wire       [63:0]   cmd_lane_4_0;
  wire       [63:0]   cmd_lane_4_0_nxt;
  wire                cmd_lane_4_0_req;
  wire                cmd_lane_4_0_ack;
  wire                cmd_lane_4_0_m_req;
  wire                cmd_lane_4_0_m_ack;
  wire                cmd_lane_4_0_to_vector_req;
  wire                cmd_lane_4_0_to_vector_ack;
  wire       [63:0]   cmd_lane_5_0;
  wire       [63:0]   cmd_lane_5_0_nxt;
  wire                cmd_lane_5_0_req;
  wire                cmd_lane_5_0_ack;
  wire                cmd_lane_5_0_m_req;
  wire                cmd_lane_5_0_m_ack;
  wire                cmd_lane_5_0_to_vector_req;
  wire                cmd_lane_5_0_to_vector_ack;
  wire       [63:0]   cmd_s3_3_0;
  wire       [63:0]   cmd_s3_3_0_nxt;
  wire                cmd_s3_3_0_req;
  wire                cmd_s3_3_0_ack;
  wire                cmd_s3_3_0_m_req;
  wire                cmd_s3_3_0_m_ack;
  wire                cmd_s3_3_0_to_cmd_lane_6_req;
  wire                cmd_s3_3_0_to_cmd_lane_7_req;
  wire                cmd_s3_3_0_to_cmd_lane_6_ack;
  wire                cmd_s3_3_0_to_cmd_lane_7_ack;
  wire       [63:0]   cmd_lane_6_0;
  wire       [63:0]   cmd_lane_6_0_nxt;
  wire                cmd_lane_6_0_req;
  wire                cmd_lane_6_0_ack;
  wire                cmd_lane_6_0_m_req;
  wire                cmd_lane_6_0_m_ack;
  wire                cmd_lane_6_0_to_vector_req;
  wire                cmd_lane_6_0_to_vector_ack;
  wire       [63:0]   cmd_lane_7_0;
  wire       [63:0]   cmd_lane_7_0_nxt;
  wire                cmd_lane_7_0_req;
  wire                cmd_lane_7_0_ack;
  wire                cmd_lane_7_0_m_req;
  wire                cmd_lane_7_0_m_ack;
  wire                cmd_lane_7_0_to_vector_req;
  wire                cmd_lane_7_0_to_vector_ack;
  wire       [63:0]   cmd_s3_4_0;
  wire       [63:0]   cmd_s3_4_0_nxt;
  wire                cmd_s3_4_0_req;
  wire                cmd_s3_4_0_ack;
  wire                cmd_s3_4_0_m_req;
  wire                cmd_s3_4_0_m_ack;
  wire                cmd_s3_4_0_to_cmd_lane_8_req;
  wire                cmd_s3_4_0_to_cmd_lane_9_req;
  wire                cmd_s3_4_0_to_cmd_lane_8_ack;
  wire                cmd_s3_4_0_to_cmd_lane_9_ack;
  wire       [63:0]   cmd_lane_8_0;
  wire       [63:0]   cmd_lane_8_0_nxt;
  wire                cmd_lane_8_0_req;
  wire                cmd_lane_8_0_ack;
  wire                cmd_lane_8_0_m_req;
  wire                cmd_lane_8_0_m_ack;
  wire                cmd_lane_8_0_to_vector_req;
  wire                cmd_lane_8_0_to_vector_ack;
  wire       [63:0]   cmd_lane_9_0;
  wire       [63:0]   cmd_lane_9_0_nxt;
  wire                cmd_lane_9_0_req;
  wire                cmd_lane_9_0_ack;
  wire                cmd_lane_9_0_m_req;
  wire                cmd_lane_9_0_m_ack;
  wire                cmd_lane_9_0_to_vector_req;
  wire                cmd_lane_9_0_to_vector_ack;
  wire       [63:0]   cmd_s3_5_0;
  wire       [63:0]   cmd_s3_5_0_nxt;
  wire                cmd_s3_5_0_req;
  wire                cmd_s3_5_0_ack;
  wire                cmd_s3_5_0_m_req;
  wire                cmd_s3_5_0_m_ack;
  wire                cmd_s3_5_0_to_cmd_lane_10_req;
  wire                cmd_s3_5_0_to_cmd_lane_11_req;
  wire                cmd_s3_5_0_to_cmd_lane_10_ack;
  wire                cmd_s3_5_0_to_cmd_lane_11_ack;
  wire       [63:0]   cmd_lane_10_0;
  wire       [63:0]   cmd_lane_10_0_nxt;
  wire                cmd_lane_10_0_req;
  wire                cmd_lane_10_0_ack;
  wire                cmd_lane_10_0_m_req;
  wire                cmd_lane_10_0_m_ack;
  wire                cmd_lane_10_0_to_vector_req;
  wire                cmd_lane_10_0_to_vector_ack;
  wire       [63:0]   cmd_lane_11_0;
  wire       [63:0]   cmd_lane_11_0_nxt;
  wire                cmd_lane_11_0_req;
  wire                cmd_lane_11_0_ack;
  wire                cmd_lane_11_0_m_req;
  wire                cmd_lane_11_0_m_ack;
  wire                cmd_lane_11_0_to_vector_req;
  wire                cmd_lane_11_0_to_vector_ack;
  wire       [63:0]   cmd_s3_6_0;
  wire       [63:0]   cmd_s3_6_0_nxt;
  wire                cmd_s3_6_0_req;
  wire                cmd_s3_6_0_ack;
  wire                cmd_s3_6_0_m_req;
  wire                cmd_s3_6_0_m_ack;
  wire                cmd_s3_6_0_to_cmd_lane_12_req;
  wire                cmd_s3_6_0_to_cmd_lane_13_req;
  wire                cmd_s3_6_0_to_cmd_lane_12_ack;
  wire                cmd_s3_6_0_to_cmd_lane_13_ack;
  wire       [63:0]   cmd_lane_12_0;
  wire       [63:0]   cmd_lane_12_0_nxt;
  wire                cmd_lane_12_0_req;
  wire                cmd_lane_12_0_ack;
  wire                cmd_lane_12_0_m_req;
  wire                cmd_lane_12_0_m_ack;
  wire                cmd_lane_12_0_to_vector_req;
  wire                cmd_lane_12_0_to_vector_ack;
  wire       [63:0]   cmd_lane_13_0;
  wire       [63:0]   cmd_lane_13_0_nxt;
  wire                cmd_lane_13_0_req;
  wire                cmd_lane_13_0_ack;
  wire                cmd_lane_13_0_m_req;
  wire                cmd_lane_13_0_m_ack;
  wire                cmd_lane_13_0_to_vector_req;
  wire                cmd_lane_13_0_to_vector_ack;
  wire       [63:0]   cmd_s3_7_0;
  wire       [63:0]   cmd_s3_7_0_nxt;
  wire                cmd_s3_7_0_req;
  wire                cmd_s3_7_0_ack;
  wire                cmd_s3_7_0_m_req;
  wire                cmd_s3_7_0_m_ack;
  wire                cmd_s3_7_0_to_cmd_lane_14_req;
  wire                cmd_s3_7_0_to_cmd_lane_15_req;
  wire                cmd_s3_7_0_to_cmd_lane_14_ack;
  wire                cmd_s3_7_0_to_cmd_lane_15_ack;
  wire       [63:0]   cmd_lane_14_0;
  wire       [63:0]   cmd_lane_14_0_nxt;
  wire                cmd_lane_14_0_req;
  wire                cmd_lane_14_0_ack;
  wire                cmd_lane_14_0_m_req;
  wire                cmd_lane_14_0_m_ack;
  wire                cmd_lane_14_0_to_vector_req;
  wire                cmd_lane_14_0_to_vector_ack;
  wire       [63:0]   cmd_lane_15_0;
  wire       [63:0]   cmd_lane_15_0_nxt;
  wire                cmd_lane_15_0_req;
  wire                cmd_lane_15_0_ack;
  wire                cmd_lane_15_0_m_req;
  wire                cmd_lane_15_0_m_ack;
  wire                cmd_lane_15_0_to_vector_req;
  wire                cmd_lane_15_0_to_vector_ack;
  wire       [511:0]  vector_k15;
  wire       [511:0]  vector_k15_nxt;
  wire                vector_k15_req;
  wire                vector_k15_ack;
  wire                vector_k15_m_req;
  wire                vector_k15_m_ack;
  wire                vector_k15_to_inmux_req;
  wire                vector_k15_to_inmux_ack;
  wire       [511:0]  inmux_inmux;
  wire       [511:0]  inmux_inmux_nxt;
  wire                inmux_inmux_req;
  wire                inmux_inmux_ack;
  wire                inmux_inmux_m_req;
  wire                inmux_inmux_m_ack;
  wire                inmux_inmux_to_iperm_data_req;
  wire                inmux_inmux_to_iperm_data_ack;
  wire       [511:0]  iperm_data_data;
  wire       [511:0]  iperm_data_data_nxt;
  wire                iperm_data_data_req;
  wire                iperm_data_data_ack;
  wire                iperm_data_data_m_req;
  wire                iperm_data_data_m_ack;
  wire                iperm_data_data_to_vmem_req;
  wire                iperm_data_data_to_vmem_ack;
  wire       [511:0]  vmem_ovs;
  wire                vmem_ovs_req;
  wire                vmem_ovs_ack;
  wire                vmem_ovs_m_req;
  wire                vmem_ovs_m_ack;
  wire                vmem_ovs_to_vmem_ovs_req;
  wire                vmem_ovs_to_vmem_ovs_ack;
  wire       [511:0]  vmem_ovs_0;
  wire       [511:0]  vmem_ovs_0_nxt;
  wire                vmem_ovs_0_req;
  wire                vmem_ovs_0_ack;
  wire                vmem_ovs_0_m_req;
  wire                vmem_ovs_0_m_ack;
  wire                vmem_ovs_0_to_operm_data_req;
  wire                vmem_ovs_0_to_operm_data_ack;
  wire       [511:0]  operm_data_data;
  wire       [511:0]  operm_data_data_nxt;
  wire                operm_data_data_req;
  wire                operm_data_data_ack;
  wire                operm_data_data_m_req;
  wire                operm_data_data_m_ack;
  wire                operm_data_data_to_oumux_req;
  wire                operm_data_data_to_oumux_ack;
  wire       [511:0]  oumux_k15;
  wire       [511:0]  oumux_k15_nxt;
  wire                oumux_k15_req;
  wire                oumux_k15_ack;
  wire                oumux_k15_m_req;
  wire                oumux_k15_m_ack;
  wire                oumux_k15_to_vector_req;
  wire                oumux_k15_to_vector_ack;
  wire       [511:0]  oumux_k8;
  wire       [511:0]  oumux_k8_nxt;
  wire                oumux_k8_req;
  wire                oumux_k8_ack;
  wire                oumux_k8_m_req;
  wire                oumux_k8_m_ack;
  wire                oumux_k8_to_dp_req;
  wire                oumux_k8_to_dp_ack;
  wire       [511:0]  oumux_k9;
  wire       [511:0]  oumux_k9_nxt;
  wire                oumux_k9_req;
  wire                oumux_k9_ack;
  wire                oumux_k9_m_req;
  wire                oumux_k9_m_ack;
  wire                oumux_k9_to_dp_req;
  wire                oumux_k9_to_dp_ack;
  wire       [511:0]  oumux_k14;
  wire       [511:0]  oumux_k14_nxt;
  wire                oumux_k14_req;
  wire                oumux_k14_ack;
  wire                oumux_k14_m_req;
  wire                oumux_k14_m_ack;
  wire                oumux_k14_to_dp_req;
  wire                oumux_k14_to_dp_ack;
  wire       [511:0]  oumux_k13;
  wire       [511:0]  oumux_k13_nxt;
  wire                oumux_k13_req;
  wire                oumux_k13_ack;
  wire                oumux_k13_m_req;
  wire                oumux_k13_m_ack;
  wire                oumux_k13_to_inmux_req;
  wire                oumux_k13_to_inmux_ack;
  wire       [511:0]  dp_k1;
  wire                dp_k1_req;
  wire                dp_k1_ack;
  wire                dp_k1_m_req;
  wire                dp_k1_m_ack;
  wire                dp_k1_to_inmux_req;
  wire                dp_k1_to_inmux_ack;
  wire       [263:0]  vector_kap;
  wire       [263:0]  vector_kap_nxt;
  wire                vector_kap_req;
  wire                vector_kap_ack;
  wire                vector_kap_m_req;
  wire                vector_kap_m_ack;
  wire                vector_kap_to_kap_deconcat_req;
  wire                vector_kap_to_kap_deconcat_ack;
  wire       [67:0]   kap_deconcat_0;
  wire       [67:0]   kap_deconcat_0_nxt;
  wire                kap_deconcat_0_req;
  wire                kap_deconcat_0_ack;
  wire                kap_deconcat_0_m_req;
  wire                kap_deconcat_0_m_ack;
  wire                kap_deconcat_0_to_perm_full_addr_req;
  wire                kap_deconcat_0_to_perm_full_addr_ack;
  wire       [195:0]  kap_deconcat_1;
  wire       [195:0]  kap_deconcat_1_nxt;
  wire                kap_deconcat_1_req;
  wire                kap_deconcat_1_ack;
  wire                kap_deconcat_1_m_req;
  wire                kap_deconcat_1_m_ack;
  wire                kap_deconcat_1_to_ka_decode_req;
  wire                kap_deconcat_1_to_ka_decode_ack;
  wire       [195:0]  ka_decode_ka;
  wire       [195:0]  ka_decode_ka_nxt;
  wire                ka_decode_ka_req;
  wire                ka_decode_ka_ack;
  wire                ka_decode_ka_m_req;
  wire                ka_decode_ka_m_ack;
  wire                ka_decode_ka_to_vmem_req;
  wire                ka_decode_ka_to_vmem_ack;
  wire       [3:0]    ka_decode_k_sk;
  wire       [3:0]    ka_decode_k_sk_nxt;
  wire                ka_decode_k_sk_req;
  wire                ka_decode_k_sk_ack;
  wire                ka_decode_k_sk_m_req;
  wire                ka_decode_k_sk_m_ack;
  wire                ka_decode_k_sk_to_inmux_req;
  wire                ka_decode_k_sk_to_inmux_ack;
  wire       [67:0]   perm_full_addr_0;
  wire       [67:0]   perm_full_addr_0_nxt;
  wire                perm_full_addr_0_req;
  wire                perm_full_addr_0_ack;
  wire                perm_full_addr_0_m_req;
  wire                perm_full_addr_0_m_ack;
  wire                perm_full_addr_0_to_p_decode_req;
  wire                perm_full_addr_0_to_p_decode_ack;
  wire       [3:0]    ka_decode_k_lk;
  wire       [3:0]    ka_decode_k_lk_nxt;
  wire                ka_decode_k_lk_req;
  wire                ka_decode_k_lk_ack;
  wire                ka_decode_k_lk_m_req;
  wire                ka_decode_k_lk_m_ack;
  wire                ka_decode_k_lk_to_oumux_req;
  wire                ka_decode_k_lk_to_oumux_ack;
  wire       [67:0]   p_decode_p_sk;
  wire       [67:0]   p_decode_p_sk_nxt;
  wire                p_decode_p_sk_req;
  wire                p_decode_p_sk_ack;
  wire                p_decode_p_sk_m_req;
  wire                p_decode_p_sk_m_ack;
  wire                p_decode_p_sk_to_iperm_data_req;
  wire                p_decode_p_sk_to_iperm_data_ack;
  wire       [67:0]   p_decode_p_lk;
  wire       [67:0]   p_decode_p_lk_nxt;
  wire                p_decode_p_lk_req;
  wire                p_decode_p_lk_ack;
  wire                p_decode_p_lk_m_req;
  wire                p_decode_p_lk_m_ack;
  wire                p_decode_p_lk_to_operm_data_req;
  wire                p_decode_p_lk_to_operm_data_ack;
  wire       [48:0]   t_idma_0_idma_0;
  wire       [48:0]   t_idma_0_idma_0_nxt;
  wire                t_idma_0_idma_0_req;
  wire                t_idma_0_idma_0_ack;
  wire                t_idma_0_idma_0_m_req;
  wire                t_idma_0_idma_0_m_ack;
  wire                t_idma_0_idma_0_to_vmem_req;
  wire                t_idma_0_idma_0_to_vmem_ack;
  wire       [48:0]   t_idma_1_idma_1;
  wire       [48:0]   t_idma_1_idma_1_nxt;
  wire                t_idma_1_idma_1_req;
  wire                t_idma_1_idma_1_ack;
  wire                t_idma_1_idma_1_m_req;
  wire                t_idma_1_idma_1_m_ack;
  wire                t_idma_1_idma_1_to_idma_1_s1_req;
  wire                t_idma_1_idma_1_to_idma_1_s1_ack;
  wire       [48:0]   idma_1_s1_0;
  wire       [48:0]   idma_1_s1_0_nxt;
  wire                idma_1_s1_0_req;
  wire                idma_1_s1_0_ack;
  wire                idma_1_s1_0_m_req;
  wire                idma_1_s1_0_m_ack;
  wire                idma_1_s1_0_to_vmem_req;
  wire                idma_1_s1_0_to_vmem_ack;
  wire       [48:0]   t_idma_2_idma_2;
  wire       [48:0]   t_idma_2_idma_2_nxt;
  wire                t_idma_2_idma_2_req;
  wire                t_idma_2_idma_2_ack;
  wire                t_idma_2_idma_2_m_req;
  wire                t_idma_2_idma_2_m_ack;
  wire                t_idma_2_idma_2_to_vmem_req;
  wire                t_idma_2_idma_2_to_vmem_ack;
  wire       [48:0]   t_idma_3_idma_3;
  wire       [48:0]   t_idma_3_idma_3_nxt;
  wire                t_idma_3_idma_3_req;
  wire                t_idma_3_idma_3_ack;
  wire                t_idma_3_idma_3_m_req;
  wire                t_idma_3_idma_3_m_ack;
  wire                t_idma_3_idma_3_to_vmem_req;
  wire                t_idma_3_idma_3_to_vmem_ack;
  wire       [31:0]   vmem_odma_0;
  wire       [31:0]   vmem_odma_0_nxt;
  wire                vmem_odma_0_req;
  wire                vmem_odma_0_ack;
  wire                vmem_odma_0_m_req;
  wire                vmem_odma_0_m_ack;
  wire                vmem_odma_0_to_i_odma_0_req;
  wire                vmem_odma_0_to_i_odma_0_ack;
  wire       [31:0]   vmem_odma_1;
  wire       [31:0]   vmem_odma_1_nxt;
  wire                vmem_odma_1_req;
  wire                vmem_odma_1_ack;
  wire                vmem_odma_1_m_req;
  wire                vmem_odma_1_m_ack;
  wire                vmem_odma_1_to_odma_1_s1_req;
  wire                vmem_odma_1_to_odma_1_s1_ack;
  wire       [31:0]   odma_1_s1_0;
  wire       [31:0]   odma_1_s1_0_nxt;
  wire                odma_1_s1_0_req;
  wire                odma_1_s1_0_ack;
  wire                odma_1_s1_0_m_req;
  wire                odma_1_s1_0_m_ack;
  wire                odma_1_s1_0_to_i_odma_1_req;
  wire                odma_1_s1_0_to_i_odma_1_ack;
  wire       [31:0]   vmem_odma_2;
  wire       [31:0]   vmem_odma_2_nxt;
  wire                vmem_odma_2_req;
  wire                vmem_odma_2_ack;
  wire                vmem_odma_2_m_req;
  wire                vmem_odma_2_m_ack;
  wire                vmem_odma_2_to_odma_2_s1_req;
  wire                vmem_odma_2_to_odma_2_s1_ack;
  wire       [31:0]   odma_2_s1_0;
  wire       [31:0]   odma_2_s1_0_nxt;
  wire                odma_2_s1_0_req;
  wire                odma_2_s1_0_ack;
  wire                odma_2_s1_0_m_req;
  wire                odma_2_s1_0_m_ack;
  wire                odma_2_s1_0_to_i_odma_2_req;
  wire                odma_2_s1_0_to_i_odma_2_ack;
  wire       [31:0]   vmem_odma_3;
  wire       [31:0]   vmem_odma_3_nxt;
  wire                vmem_odma_3_req;
  wire                vmem_odma_3_ack;
  wire                vmem_odma_3_m_req;
  wire                vmem_odma_3_m_ack;
  wire                vmem_odma_3_to_i_odma_3_req;
  wire                vmem_odma_3_to_i_odma_3_ack;
  reg                 kap_deconcat_i_0_req_reg;
  wire                kap_deconcat_i_0_ack_g;
  reg                 kap_deconcat_i_1_req_reg;
  wire                kap_deconcat_i_1_ack_g;
  reg        [4:0]    t_instr_0_eb_state;
  reg        [4:0]    t_instr_0_eb_state_nxt;
  wire                t_instr_0_eb_en0;
  wire                t_instr_0_eb_en1;
  wire                t_instr_0_eb_sel;
  reg        [63:0]   t_instr_0_eb_r0;
  reg        [63:0]   t_instr_0_eb_r1;
  reg                 t_instr_0_fork_ack_r_0;
  wire                t_instr_0_fork_ack_s_0;
  reg                 t_instr_0_fork_ack_r_1;
  wire                t_instr_0_fork_ack_s_1;
  reg        [4:0]    cmd_s1_0_0_eb_state;
  reg        [4:0]    cmd_s1_0_0_eb_state_nxt;
  wire                cmd_s1_0_0_eb_en0;
  wire                cmd_s1_0_0_eb_en1;
  wire                cmd_s1_0_0_eb_sel;
  reg        [63:0]   cmd_s1_0_0_eb_r0;
  reg        [63:0]   cmd_s1_0_0_eb_r1;
  reg                 cmd_s1_0_0_fork_ack_r_0;
  wire                cmd_s1_0_0_fork_ack_s_0;
  reg                 cmd_s1_0_0_fork_ack_r_1;
  wire                cmd_s1_0_0_fork_ack_s_1;
  reg        [4:0]    cmd_s1_1_0_eb_state;
  reg        [4:0]    cmd_s1_1_0_eb_state_nxt;
  wire                cmd_s1_1_0_eb_en0;
  wire                cmd_s1_1_0_eb_en1;
  wire                cmd_s1_1_0_eb_sel;
  reg        [63:0]   cmd_s1_1_0_eb_r0;
  reg        [63:0]   cmd_s1_1_0_eb_r1;
  reg                 cmd_s1_1_0_fork_ack_r_0;
  wire                cmd_s1_1_0_fork_ack_s_0;
  reg                 cmd_s1_1_0_fork_ack_r_1;
  wire                cmd_s1_1_0_fork_ack_s_1;
  reg        [4:0]    cmd_s2_0_0_eb_state;
  reg        [4:0]    cmd_s2_0_0_eb_state_nxt;
  wire                cmd_s2_0_0_eb_en0;
  wire                cmd_s2_0_0_eb_en1;
  wire                cmd_s2_0_0_eb_sel;
  reg        [63:0]   cmd_s2_0_0_eb_r0;
  reg        [63:0]   cmd_s2_0_0_eb_r1;
  reg                 cmd_s2_0_0_fork_ack_r_0;
  wire                cmd_s2_0_0_fork_ack_s_0;
  reg                 cmd_s2_0_0_fork_ack_r_1;
  wire                cmd_s2_0_0_fork_ack_s_1;
  reg        [4:0]    cmd_s2_1_0_eb_state;
  reg        [4:0]    cmd_s2_1_0_eb_state_nxt;
  wire                cmd_s2_1_0_eb_en0;
  wire                cmd_s2_1_0_eb_en1;
  wire                cmd_s2_1_0_eb_sel;
  reg        [63:0]   cmd_s2_1_0_eb_r0;
  reg        [63:0]   cmd_s2_1_0_eb_r1;
  reg                 cmd_s2_1_0_fork_ack_r_0;
  wire                cmd_s2_1_0_fork_ack_s_0;
  reg                 cmd_s2_1_0_fork_ack_r_1;
  wire                cmd_s2_1_0_fork_ack_s_1;
  reg        [4:0]    cmd_s2_2_0_eb_state;
  reg        [4:0]    cmd_s2_2_0_eb_state_nxt;
  wire                cmd_s2_2_0_eb_en0;
  wire                cmd_s2_2_0_eb_en1;
  wire                cmd_s2_2_0_eb_sel;
  reg        [63:0]   cmd_s2_2_0_eb_r0;
  reg        [63:0]   cmd_s2_2_0_eb_r1;
  reg                 cmd_s2_2_0_fork_ack_r_0;
  wire                cmd_s2_2_0_fork_ack_s_0;
  reg                 cmd_s2_2_0_fork_ack_r_1;
  wire                cmd_s2_2_0_fork_ack_s_1;
  reg        [4:0]    cmd_s2_3_0_eb_state;
  reg        [4:0]    cmd_s2_3_0_eb_state_nxt;
  wire                cmd_s2_3_0_eb_en0;
  wire                cmd_s2_3_0_eb_en1;
  wire                cmd_s2_3_0_eb_sel;
  reg        [63:0]   cmd_s2_3_0_eb_r0;
  reg        [63:0]   cmd_s2_3_0_eb_r1;
  reg                 cmd_s2_3_0_fork_ack_r_0;
  wire                cmd_s2_3_0_fork_ack_s_0;
  reg                 cmd_s2_3_0_fork_ack_r_1;
  wire                cmd_s2_3_0_fork_ack_s_1;
  reg        [4:0]    cmd_s3_0_0_eb_state;
  reg        [4:0]    cmd_s3_0_0_eb_state_nxt;
  wire                cmd_s3_0_0_eb_en0;
  wire                cmd_s3_0_0_eb_en1;
  wire                cmd_s3_0_0_eb_sel;
  reg        [63:0]   cmd_s3_0_0_eb_r0;
  reg        [63:0]   cmd_s3_0_0_eb_r1;
  reg                 cmd_s3_0_0_fork_ack_r_0;
  wire                cmd_s3_0_0_fork_ack_s_0;
  reg                 cmd_s3_0_0_fork_ack_r_1;
  wire                cmd_s3_0_0_fork_ack_s_1;
  reg        [4:0]    cmd_lane_0_0_eb_state;
  reg        [4:0]    cmd_lane_0_0_eb_state_nxt;
  wire                cmd_lane_0_0_eb_en0;
  wire                cmd_lane_0_0_eb_en1;
  wire                cmd_lane_0_0_eb_sel;
  reg        [63:0]   cmd_lane_0_0_eb_r0;
  reg        [63:0]   cmd_lane_0_0_eb_r1;
  reg        [4:0]    cmd_lane_1_0_eb_state;
  reg        [4:0]    cmd_lane_1_0_eb_state_nxt;
  wire                cmd_lane_1_0_eb_en0;
  wire                cmd_lane_1_0_eb_en1;
  wire                cmd_lane_1_0_eb_sel;
  reg        [63:0]   cmd_lane_1_0_eb_r0;
  reg        [63:0]   cmd_lane_1_0_eb_r1;
  reg        [4:0]    cmd_s3_1_0_eb_state;
  reg        [4:0]    cmd_s3_1_0_eb_state_nxt;
  wire                cmd_s3_1_0_eb_en0;
  wire                cmd_s3_1_0_eb_en1;
  wire                cmd_s3_1_0_eb_sel;
  reg        [63:0]   cmd_s3_1_0_eb_r0;
  reg        [63:0]   cmd_s3_1_0_eb_r1;
  reg                 cmd_s3_1_0_fork_ack_r_0;
  wire                cmd_s3_1_0_fork_ack_s_0;
  reg                 cmd_s3_1_0_fork_ack_r_1;
  wire                cmd_s3_1_0_fork_ack_s_1;
  reg        [4:0]    cmd_lane_2_0_eb_state;
  reg        [4:0]    cmd_lane_2_0_eb_state_nxt;
  wire                cmd_lane_2_0_eb_en0;
  wire                cmd_lane_2_0_eb_en1;
  wire                cmd_lane_2_0_eb_sel;
  reg        [63:0]   cmd_lane_2_0_eb_r0;
  reg        [63:0]   cmd_lane_2_0_eb_r1;
  reg        [4:0]    cmd_lane_3_0_eb_state;
  reg        [4:0]    cmd_lane_3_0_eb_state_nxt;
  wire                cmd_lane_3_0_eb_en0;
  wire                cmd_lane_3_0_eb_en1;
  wire                cmd_lane_3_0_eb_sel;
  reg        [63:0]   cmd_lane_3_0_eb_r0;
  reg        [63:0]   cmd_lane_3_0_eb_r1;
  reg        [4:0]    cmd_s3_2_0_eb_state;
  reg        [4:0]    cmd_s3_2_0_eb_state_nxt;
  wire                cmd_s3_2_0_eb_en0;
  wire                cmd_s3_2_0_eb_en1;
  wire                cmd_s3_2_0_eb_sel;
  reg        [63:0]   cmd_s3_2_0_eb_r0;
  reg        [63:0]   cmd_s3_2_0_eb_r1;
  reg                 cmd_s3_2_0_fork_ack_r_0;
  wire                cmd_s3_2_0_fork_ack_s_0;
  reg                 cmd_s3_2_0_fork_ack_r_1;
  wire                cmd_s3_2_0_fork_ack_s_1;
  reg        [4:0]    cmd_lane_4_0_eb_state;
  reg        [4:0]    cmd_lane_4_0_eb_state_nxt;
  wire                cmd_lane_4_0_eb_en0;
  wire                cmd_lane_4_0_eb_en1;
  wire                cmd_lane_4_0_eb_sel;
  reg        [63:0]   cmd_lane_4_0_eb_r0;
  reg        [63:0]   cmd_lane_4_0_eb_r1;
  reg        [4:0]    cmd_lane_5_0_eb_state;
  reg        [4:0]    cmd_lane_5_0_eb_state_nxt;
  wire                cmd_lane_5_0_eb_en0;
  wire                cmd_lane_5_0_eb_en1;
  wire                cmd_lane_5_0_eb_sel;
  reg        [63:0]   cmd_lane_5_0_eb_r0;
  reg        [63:0]   cmd_lane_5_0_eb_r1;
  reg        [4:0]    cmd_s3_3_0_eb_state;
  reg        [4:0]    cmd_s3_3_0_eb_state_nxt;
  wire                cmd_s3_3_0_eb_en0;
  wire                cmd_s3_3_0_eb_en1;
  wire                cmd_s3_3_0_eb_sel;
  reg        [63:0]   cmd_s3_3_0_eb_r0;
  reg        [63:0]   cmd_s3_3_0_eb_r1;
  reg                 cmd_s3_3_0_fork_ack_r_0;
  wire                cmd_s3_3_0_fork_ack_s_0;
  reg                 cmd_s3_3_0_fork_ack_r_1;
  wire                cmd_s3_3_0_fork_ack_s_1;
  reg        [4:0]    cmd_lane_6_0_eb_state;
  reg        [4:0]    cmd_lane_6_0_eb_state_nxt;
  wire                cmd_lane_6_0_eb_en0;
  wire                cmd_lane_6_0_eb_en1;
  wire                cmd_lane_6_0_eb_sel;
  reg        [63:0]   cmd_lane_6_0_eb_r0;
  reg        [63:0]   cmd_lane_6_0_eb_r1;
  reg        [4:0]    cmd_lane_7_0_eb_state;
  reg        [4:0]    cmd_lane_7_0_eb_state_nxt;
  wire                cmd_lane_7_0_eb_en0;
  wire                cmd_lane_7_0_eb_en1;
  wire                cmd_lane_7_0_eb_sel;
  reg        [63:0]   cmd_lane_7_0_eb_r0;
  reg        [63:0]   cmd_lane_7_0_eb_r1;
  reg        [4:0]    cmd_s3_4_0_eb_state;
  reg        [4:0]    cmd_s3_4_0_eb_state_nxt;
  wire                cmd_s3_4_0_eb_en0;
  wire                cmd_s3_4_0_eb_en1;
  wire                cmd_s3_4_0_eb_sel;
  reg        [63:0]   cmd_s3_4_0_eb_r0;
  reg        [63:0]   cmd_s3_4_0_eb_r1;
  reg                 cmd_s3_4_0_fork_ack_r_0;
  wire                cmd_s3_4_0_fork_ack_s_0;
  reg                 cmd_s3_4_0_fork_ack_r_1;
  wire                cmd_s3_4_0_fork_ack_s_1;
  reg        [4:0]    cmd_lane_8_0_eb_state;
  reg        [4:0]    cmd_lane_8_0_eb_state_nxt;
  wire                cmd_lane_8_0_eb_en0;
  wire                cmd_lane_8_0_eb_en1;
  wire                cmd_lane_8_0_eb_sel;
  reg        [63:0]   cmd_lane_8_0_eb_r0;
  reg        [63:0]   cmd_lane_8_0_eb_r1;
  reg        [4:0]    cmd_lane_9_0_eb_state;
  reg        [4:0]    cmd_lane_9_0_eb_state_nxt;
  wire                cmd_lane_9_0_eb_en0;
  wire                cmd_lane_9_0_eb_en1;
  wire                cmd_lane_9_0_eb_sel;
  reg        [63:0]   cmd_lane_9_0_eb_r0;
  reg        [63:0]   cmd_lane_9_0_eb_r1;
  reg        [4:0]    cmd_s3_5_0_eb_state;
  reg        [4:0]    cmd_s3_5_0_eb_state_nxt;
  wire                cmd_s3_5_0_eb_en0;
  wire                cmd_s3_5_0_eb_en1;
  wire                cmd_s3_5_0_eb_sel;
  reg        [63:0]   cmd_s3_5_0_eb_r0;
  reg        [63:0]   cmd_s3_5_0_eb_r1;
  reg                 cmd_s3_5_0_fork_ack_r_0;
  wire                cmd_s3_5_0_fork_ack_s_0;
  reg                 cmd_s3_5_0_fork_ack_r_1;
  wire                cmd_s3_5_0_fork_ack_s_1;
  reg        [4:0]    cmd_lane_10_0_eb_state;
  reg        [4:0]    cmd_lane_10_0_eb_state_nxt;
  wire                cmd_lane_10_0_eb_en0;
  wire                cmd_lane_10_0_eb_en1;
  wire                cmd_lane_10_0_eb_sel;
  reg        [63:0]   cmd_lane_10_0_eb_r0;
  reg        [63:0]   cmd_lane_10_0_eb_r1;
  reg        [4:0]    cmd_lane_11_0_eb_state;
  reg        [4:0]    cmd_lane_11_0_eb_state_nxt;
  wire                cmd_lane_11_0_eb_en0;
  wire                cmd_lane_11_0_eb_en1;
  wire                cmd_lane_11_0_eb_sel;
  reg        [63:0]   cmd_lane_11_0_eb_r0;
  reg        [63:0]   cmd_lane_11_0_eb_r1;
  reg        [4:0]    cmd_s3_6_0_eb_state;
  reg        [4:0]    cmd_s3_6_0_eb_state_nxt;
  wire                cmd_s3_6_0_eb_en0;
  wire                cmd_s3_6_0_eb_en1;
  wire                cmd_s3_6_0_eb_sel;
  reg        [63:0]   cmd_s3_6_0_eb_r0;
  reg        [63:0]   cmd_s3_6_0_eb_r1;
  reg                 cmd_s3_6_0_fork_ack_r_0;
  wire                cmd_s3_6_0_fork_ack_s_0;
  reg                 cmd_s3_6_0_fork_ack_r_1;
  wire                cmd_s3_6_0_fork_ack_s_1;
  reg        [4:0]    cmd_lane_12_0_eb_state;
  reg        [4:0]    cmd_lane_12_0_eb_state_nxt;
  wire                cmd_lane_12_0_eb_en0;
  wire                cmd_lane_12_0_eb_en1;
  wire                cmd_lane_12_0_eb_sel;
  reg        [63:0]   cmd_lane_12_0_eb_r0;
  reg        [63:0]   cmd_lane_12_0_eb_r1;
  reg        [4:0]    cmd_lane_13_0_eb_state;
  reg        [4:0]    cmd_lane_13_0_eb_state_nxt;
  wire                cmd_lane_13_0_eb_en0;
  wire                cmd_lane_13_0_eb_en1;
  wire                cmd_lane_13_0_eb_sel;
  reg        [63:0]   cmd_lane_13_0_eb_r0;
  reg        [63:0]   cmd_lane_13_0_eb_r1;
  reg        [4:0]    cmd_s3_7_0_eb_state;
  reg        [4:0]    cmd_s3_7_0_eb_state_nxt;
  wire                cmd_s3_7_0_eb_en0;
  wire                cmd_s3_7_0_eb_en1;
  wire                cmd_s3_7_0_eb_sel;
  reg        [63:0]   cmd_s3_7_0_eb_r0;
  reg        [63:0]   cmd_s3_7_0_eb_r1;
  reg                 cmd_s3_7_0_fork_ack_r_0;
  wire                cmd_s3_7_0_fork_ack_s_0;
  reg                 cmd_s3_7_0_fork_ack_r_1;
  wire                cmd_s3_7_0_fork_ack_s_1;
  reg        [4:0]    cmd_lane_14_0_eb_state;
  reg        [4:0]    cmd_lane_14_0_eb_state_nxt;
  wire                cmd_lane_14_0_eb_en0;
  wire                cmd_lane_14_0_eb_en1;
  wire                cmd_lane_14_0_eb_sel;
  reg        [63:0]   cmd_lane_14_0_eb_r0;
  reg        [63:0]   cmd_lane_14_0_eb_r1;
  reg        [4:0]    cmd_lane_15_0_eb_state;
  reg        [4:0]    cmd_lane_15_0_eb_state_nxt;
  wire                cmd_lane_15_0_eb_en0;
  wire                cmd_lane_15_0_eb_en1;
  wire                cmd_lane_15_0_eb_sel;
  reg        [63:0]   cmd_lane_15_0_eb_r0;
  reg        [63:0]   cmd_lane_15_0_eb_r1;
  reg        [4:0]    vector_k15_eb_state;
  reg        [4:0]    vector_k15_eb_state_nxt;
  wire                vector_k15_eb_en0;
  wire                vector_k15_eb_en1;
  wire                vector_k15_eb_sel;
  reg        [511:0]  vector_k15_eb_r0;
  reg        [511:0]  vector_k15_eb_r1;
  reg                 inmux_inmux_eb_valid;
  wire                inmux_inmux_eb_en;
  reg        [511:0]  inmux_inmux_eb_r;
  reg                 iperm_data_data_eb_valid;
  wire                iperm_data_data_eb_en;
  reg        [511:0]  iperm_data_data_eb_r;
  reg                 vmem_ovs_0_eb_valid;
  wire                vmem_ovs_0_eb_en;
  reg        [511:0]  vmem_ovs_0_eb_r;
  reg        [4:0]    operm_data_data_eb_state;
  reg        [4:0]    operm_data_data_eb_state_nxt;
  wire                operm_data_data_eb_en0;
  wire                operm_data_data_eb_en1;
  wire                operm_data_data_eb_sel;
  reg        [511:0]  operm_data_data_eb_r0;
  reg        [511:0]  operm_data_data_eb_r1;
  reg        [4:0]    oumux_k15_eb_state;
  reg        [4:0]    oumux_k15_eb_state_nxt;
  wire                oumux_k15_eb_en0;
  wire                oumux_k15_eb_en1;
  wire                oumux_k15_eb_sel;
  reg        [511:0]  oumux_k15_eb_r0;
  reg        [511:0]  oumux_k15_eb_r1;
  reg        [4:0]    oumux_k8_eb_state;
  reg        [4:0]    oumux_k8_eb_state_nxt;
  wire                oumux_k8_eb_en0;
  wire                oumux_k8_eb_en1;
  wire                oumux_k8_eb_sel;
  reg        [511:0]  oumux_k8_eb_r0;
  reg        [511:0]  oumux_k8_eb_r1;
  reg        [4:0]    oumux_k9_eb_state;
  reg        [4:0]    oumux_k9_eb_state_nxt;
  wire                oumux_k9_eb_en0;
  wire                oumux_k9_eb_en1;
  wire                oumux_k9_eb_sel;
  reg        [511:0]  oumux_k9_eb_r0;
  reg        [511:0]  oumux_k9_eb_r1;
  reg                 oumux_k14_eb_valid;
  wire                oumux_k14_eb_en;
  reg        [511:0]  oumux_k14_eb_r;
  wire       [1:0]    _zz_oumux_k13_ack;
  reg        [1:0]    oumux_k13_eb_cnt;
  reg        [1:0]    oumux_k13_eb_wr_ptr;
  reg        [1:0]    oumux_k13_eb_q_rd_ptr;
  wire       [1:0]    oumux_k13_eb_rd_ptr;
  reg                 oumux_k13_eb_valid;
  wire                oumux_k13_eb_wen;
  wire                oumux_k13_eb_ren;
  wire                _zz_oumux_k13_eb_rd_ptr;
  wire       [1:0]    _zz_oumux_k13_eb_q_rd_ptr;
  wire       [511:0]  oumux_k13_eb_r0;
  reg        [4:0]    vector_kap_eb_state;
  reg        [4:0]    vector_kap_eb_state_nxt;
  wire                vector_kap_eb_en0;
  wire                vector_kap_eb_en1;
  wire                vector_kap_eb_sel;
  reg        [263:0]  vector_kap_eb_r0;
  reg        [263:0]  vector_kap_eb_r1;
  reg                 kap_deconcat_0_eb_valid;
  wire                kap_deconcat_0_eb_en;
  reg        [67:0]   kap_deconcat_0_eb_r;
  reg                 kap_deconcat_1_eb_valid;
  wire                kap_deconcat_1_eb_en;
  reg        [195:0]  kap_deconcat_1_eb_r;
  wire       [1:0]    _zz_ka_decode_ka_ack;
  reg        [1:0]    ka_decode_ka_eb_cnt;
  reg        [1:0]    ka_decode_ka_eb_wr_ptr;
  reg        [1:0]    ka_decode_ka_eb_q_rd_ptr;
  wire       [1:0]    ka_decode_ka_eb_rd_ptr;
  reg                 ka_decode_ka_eb_valid;
  wire                ka_decode_ka_eb_wen;
  wire                ka_decode_ka_eb_ren;
  wire                _zz_ka_decode_ka_eb_rd_ptr;
  wire       [1:0]    _zz_ka_decode_ka_eb_q_rd_ptr;
  wire       [195:0]  ka_decode_ka_eb_r0;
  wire       [0:0]    _zz_ka_decode_k_sk_ack;
  reg        [0:0]    ka_decode_k_sk_eb_cnt;
  reg        [0:0]    ka_decode_k_sk_eb_wr_ptr;
  reg        [0:0]    ka_decode_k_sk_eb_q_rd_ptr;
  wire       [0:0]    ka_decode_k_sk_eb_rd_ptr;
  reg                 ka_decode_k_sk_eb_valid;
  wire                ka_decode_k_sk_eb_wen;
  wire                ka_decode_k_sk_eb_ren;
  wire                _zz_ka_decode_k_sk_eb_rd_ptr;
  wire       [0:0]    _zz_ka_decode_k_sk_eb_q_rd_ptr;
  wire       [3:0]    ka_decode_k_sk_eb_r0;
  reg                 perm_full_addr_0_eb_valid;
  wire                perm_full_addr_0_eb_en;
  reg        [67:0]   perm_full_addr_0_eb_r;
  wire       [1:0]    _zz_ka_decode_k_lk_ack;
  reg        [1:0]    ka_decode_k_lk_eb_cnt;
  reg        [1:0]    ka_decode_k_lk_eb_wr_ptr;
  reg        [1:0]    ka_decode_k_lk_eb_q_rd_ptr;
  wire       [1:0]    ka_decode_k_lk_eb_rd_ptr;
  reg                 ka_decode_k_lk_eb_valid;
  wire                ka_decode_k_lk_eb_wen;
  wire                ka_decode_k_lk_eb_ren;
  wire                _zz_ka_decode_k_lk_eb_rd_ptr;
  wire       [1:0]    _zz_ka_decode_k_lk_eb_q_rd_ptr;
  wire       [3:0]    ka_decode_k_lk_eb_r0;
  wire       [1:0]    _zz_p_decode_p_sk_ack;
  reg        [1:0]    p_decode_p_sk_eb_cnt;
  reg        [1:0]    p_decode_p_sk_eb_wr_ptr;
  reg        [1:0]    p_decode_p_sk_eb_q_rd_ptr;
  wire       [1:0]    p_decode_p_sk_eb_rd_ptr;
  reg                 p_decode_p_sk_eb_valid;
  wire                p_decode_p_sk_eb_wen;
  wire                p_decode_p_sk_eb_ren;
  wire                _zz_p_decode_p_sk_eb_rd_ptr;
  wire       [1:0]    _zz_p_decode_p_sk_eb_q_rd_ptr;
  wire       [67:0]   p_decode_p_sk_eb_r0;
  wire       [1:0]    _zz_p_decode_p_lk_ack;
  reg        [1:0]    p_decode_p_lk_eb_cnt;
  reg        [1:0]    p_decode_p_lk_eb_wr_ptr;
  reg        [1:0]    p_decode_p_lk_eb_q_rd_ptr;
  wire       [1:0]    p_decode_p_lk_eb_rd_ptr;
  reg                 p_decode_p_lk_eb_valid;
  wire                p_decode_p_lk_eb_wen;
  wire                p_decode_p_lk_eb_ren;
  wire                _zz_p_decode_p_lk_eb_rd_ptr;
  wire       [1:0]    _zz_p_decode_p_lk_eb_q_rd_ptr;
  wire       [67:0]   p_decode_p_lk_eb_r0;
  reg        [4:0]    t_idma_0_idma_0_eb_state;
  reg        [4:0]    t_idma_0_idma_0_eb_state_nxt;
  wire                t_idma_0_idma_0_eb_en0;
  wire                t_idma_0_idma_0_eb_en1;
  wire                t_idma_0_idma_0_eb_sel;
  reg        [48:0]   t_idma_0_idma_0_eb_r0;
  reg        [48:0]   t_idma_0_idma_0_eb_r1;
  reg        [4:0]    t_idma_1_idma_1_eb_state;
  reg        [4:0]    t_idma_1_idma_1_eb_state_nxt;
  wire                t_idma_1_idma_1_eb_en0;
  wire                t_idma_1_idma_1_eb_en1;
  wire                t_idma_1_idma_1_eb_sel;
  reg        [48:0]   t_idma_1_idma_1_eb_r0;
  reg        [48:0]   t_idma_1_idma_1_eb_r1;
  reg        [4:0]    idma_1_s1_0_eb_state;
  reg        [4:0]    idma_1_s1_0_eb_state_nxt;
  wire                idma_1_s1_0_eb_en0;
  wire                idma_1_s1_0_eb_en1;
  wire                idma_1_s1_0_eb_sel;
  reg        [48:0]   idma_1_s1_0_eb_r0;
  reg        [48:0]   idma_1_s1_0_eb_r1;
  reg        [4:0]    t_idma_2_idma_2_eb_state;
  reg        [4:0]    t_idma_2_idma_2_eb_state_nxt;
  wire                t_idma_2_idma_2_eb_en0;
  wire                t_idma_2_idma_2_eb_en1;
  wire                t_idma_2_idma_2_eb_sel;
  reg        [48:0]   t_idma_2_idma_2_eb_r0;
  reg        [48:0]   t_idma_2_idma_2_eb_r1;
  reg        [4:0]    t_idma_3_idma_3_eb_state;
  reg        [4:0]    t_idma_3_idma_3_eb_state_nxt;
  wire                t_idma_3_idma_3_eb_en0;
  wire                t_idma_3_idma_3_eb_en1;
  wire                t_idma_3_idma_3_eb_sel;
  reg        [48:0]   t_idma_3_idma_3_eb_r0;
  reg        [48:0]   t_idma_3_idma_3_eb_r1;
  reg        [6:0]    vmem_odma_0_eb_state;
  reg        [6:0]    vmem_odma_0_eb_state_nxt;
  wire                vmem_odma_0_eb_en0;
  wire                vmem_odma_0_eb_en1;
  wire                vmem_odma_0_eb_sel;
  reg        [31:0]   vmem_odma_0_eb_r0;
  reg        [31:0]   vmem_odma_0_eb_r1;
  reg        [6:0]    vmem_odma_1_eb_state;
  reg        [6:0]    vmem_odma_1_eb_state_nxt;
  wire                vmem_odma_1_eb_en0;
  wire                vmem_odma_1_eb_en1;
  wire                vmem_odma_1_eb_sel;
  reg        [31:0]   vmem_odma_1_eb_r0;
  reg        [31:0]   vmem_odma_1_eb_r1;
  reg                 odma_1_s1_0_eb_valid;
  wire                odma_1_s1_0_eb_en;
  reg        [31:0]   odma_1_s1_0_eb_r;
  reg        [6:0]    vmem_odma_2_eb_state;
  reg        [6:0]    vmem_odma_2_eb_state_nxt;
  wire                vmem_odma_2_eb_en0;
  wire                vmem_odma_2_eb_en1;
  wire                vmem_odma_2_eb_sel;
  reg        [31:0]   vmem_odma_2_eb_r0;
  reg        [31:0]   vmem_odma_2_eb_r1;
  reg                 odma_2_s1_0_eb_valid;
  wire                odma_2_s1_0_eb_en;
  reg        [31:0]   odma_2_s1_0_eb_r;
  reg        [6:0]    vmem_odma_3_eb_state;
  reg        [6:0]    vmem_odma_3_eb_state_nxt;
  wire                vmem_odma_3_eb_en0;
  wire                vmem_odma_3_eb_en1;
  wire                vmem_odma_3_eb_sel;
  reg        [31:0]   vmem_odma_3_eb_r0;
  reg        [31:0]   vmem_odma_3_eb_r1;
  reg [511:0] oumux_k13_eb_mem [0:3];
  reg [195:0] ka_decode_ka_eb_mem [0:3];
  reg [3:0] ka_decode_k_sk_eb_mem [0:1];
  reg [3:0] ka_decode_k_lk_eb_mem [0:3];
  reg [67:0] p_decode_p_sk_eb_mem [0:2];
  reg [67:0] p_decode_p_lk_eb_mem [0:2];

  assign _zz_oumux_k13_eb_wr_ptr = (oumux_k13_eb_wr_ptr + 2'b01);
  assign _zz__zz_oumux_k13_eb_q_rd_ptr = (oumux_k13_eb_q_rd_ptr + 2'b01);
  assign _zz_ka_decode_ka_eb_wr_ptr = (ka_decode_ka_eb_wr_ptr + 2'b01);
  assign _zz__zz_ka_decode_ka_eb_q_rd_ptr = (ka_decode_ka_eb_q_rd_ptr + 2'b01);
  assign _zz_ka_decode_k_sk_eb_wr_ptr = (ka_decode_k_sk_eb_wr_ptr + 1'b1);
  assign _zz__zz_ka_decode_k_sk_eb_q_rd_ptr = (ka_decode_k_sk_eb_q_rd_ptr + 1'b1);
  assign _zz_ka_decode_k_lk_eb_wr_ptr = (ka_decode_k_lk_eb_wr_ptr + 2'b01);
  assign _zz__zz_ka_decode_k_lk_eb_q_rd_ptr = (ka_decode_k_lk_eb_q_rd_ptr + 2'b01);
  assign _zz_p_decode_p_sk_eb_wr_ptr = (p_decode_p_sk_eb_wr_ptr + 2'b01);
  assign _zz__zz_p_decode_p_sk_eb_q_rd_ptr = (p_decode_p_sk_eb_q_rd_ptr + 2'b01);
  assign _zz_p_decode_p_lk_eb_wr_ptr = (p_decode_p_lk_eb_wr_ptr + 2'b01);
  assign _zz__zz_p_decode_p_lk_eb_q_rd_ptr = (p_decode_p_lk_eb_q_rd_ptr + 2'b01);
  always @(posedge clk) begin
    if(oumux_k13_eb_wen) begin
      oumux_k13_eb_mem[oumux_k13_eb_wr_ptr] <= oumux_k13_nxt;
    end
  end

  always @(posedge clk) begin
    if(oumux_k13_eb_ren) begin
      oumux_k13_eb_mem_spinal_port1 <= oumux_k13_eb_mem[oumux_k13_eb_rd_ptr];
    end
  end

  always @(posedge clk) begin
    if(ka_decode_ka_eb_wen) begin
      ka_decode_ka_eb_mem[ka_decode_ka_eb_wr_ptr] <= ka_decode_ka_nxt;
    end
  end

  always @(posedge clk) begin
    if(ka_decode_ka_eb_ren) begin
      ka_decode_ka_eb_mem_spinal_port1 <= ka_decode_ka_eb_mem[ka_decode_ka_eb_rd_ptr];
    end
  end

  always @(posedge clk) begin
    if(ka_decode_k_sk_eb_wen) begin
      ka_decode_k_sk_eb_mem[ka_decode_k_sk_eb_wr_ptr] <= ka_decode_k_sk_nxt;
    end
  end

  always @(posedge clk) begin
    if(ka_decode_k_sk_eb_ren) begin
      ka_decode_k_sk_eb_mem_spinal_port1 <= ka_decode_k_sk_eb_mem[ka_decode_k_sk_eb_rd_ptr];
    end
  end

  always @(posedge clk) begin
    if(ka_decode_k_lk_eb_wen) begin
      ka_decode_k_lk_eb_mem[ka_decode_k_lk_eb_wr_ptr] <= ka_decode_k_lk_nxt;
    end
  end

  always @(posedge clk) begin
    if(ka_decode_k_lk_eb_ren) begin
      ka_decode_k_lk_eb_mem_spinal_port1 <= ka_decode_k_lk_eb_mem[ka_decode_k_lk_eb_rd_ptr];
    end
  end

  always @(posedge clk) begin
    if(p_decode_p_sk_eb_wen) begin
      p_decode_p_sk_eb_mem[p_decode_p_sk_eb_wr_ptr] <= p_decode_p_sk_nxt;
    end
  end

  always @(posedge clk) begin
    if(p_decode_p_sk_eb_ren) begin
      p_decode_p_sk_eb_mem_spinal_port1 <= p_decode_p_sk_eb_mem[p_decode_p_sk_eb_rd_ptr];
    end
  end

  always @(posedge clk) begin
    if(p_decode_p_lk_eb_wen) begin
      p_decode_p_lk_eb_mem[p_decode_p_lk_eb_wr_ptr] <= p_decode_p_lk_nxt;
    end
  end

  always @(posedge clk) begin
    if(p_decode_p_lk_eb_ren) begin
      p_decode_p_lk_eb_mem_spinal_port1 <= p_decode_p_lk_eb_mem[p_decode_p_lk_eb_rd_ptr];
    end
  end

  vector_dat_17_2 vector (
    .t_instr_0_dat  (cmd_lane_0_0[63:0]        ), //i
    .instr_0_valid  (vector_ctrl_instr_0_valid ), //i
    .instr_0_ready  (vector_instr_0_ready      ), //o
    .t_instr_1_dat  (cmd_lane_1_0[63:0]        ), //i
    .instr_1_valid  (vector_ctrl_instr_1_valid ), //i
    .instr_1_ready  (vector_instr_1_ready      ), //o
    .t_instr_2_dat  (cmd_lane_2_0[63:0]        ), //i
    .instr_2_valid  (vector_ctrl_instr_2_valid ), //i
    .instr_2_ready  (vector_instr_2_ready      ), //o
    .t_instr_3_dat  (cmd_lane_3_0[63:0]        ), //i
    .instr_3_valid  (vector_ctrl_instr_3_valid ), //i
    .instr_3_ready  (vector_instr_3_ready      ), //o
    .t_instr_4_dat  (cmd_lane_4_0[63:0]        ), //i
    .instr_4_valid  (vector_ctrl_instr_4_valid ), //i
    .instr_4_ready  (vector_instr_4_ready      ), //o
    .t_instr_5_dat  (cmd_lane_5_0[63:0]        ), //i
    .instr_5_valid  (vector_ctrl_instr_5_valid ), //i
    .instr_5_ready  (vector_instr_5_ready      ), //o
    .t_instr_6_dat  (cmd_lane_6_0[63:0]        ), //i
    .instr_6_valid  (vector_ctrl_instr_6_valid ), //i
    .instr_6_ready  (vector_instr_6_ready      ), //o
    .t_instr_7_dat  (cmd_lane_7_0[63:0]        ), //i
    .instr_7_valid  (vector_ctrl_instr_7_valid ), //i
    .instr_7_ready  (vector_instr_7_ready      ), //o
    .t_instr_8_dat  (cmd_lane_8_0[63:0]        ), //i
    .instr_8_valid  (vector_ctrl_instr_8_valid ), //i
    .instr_8_ready  (vector_instr_8_ready      ), //o
    .t_instr_9_dat  (cmd_lane_9_0[63:0]        ), //i
    .instr_9_valid  (vector_ctrl_instr_9_valid ), //i
    .instr_9_ready  (vector_instr_9_ready      ), //o
    .t_instr_10_dat (cmd_lane_10_0[63:0]       ), //i
    .instr_10_valid (vector_ctrl_instr_10_valid), //i
    .instr_10_ready (vector_instr_10_ready     ), //o
    .t_instr_11_dat (cmd_lane_11_0[63:0]       ), //i
    .instr_11_valid (vector_ctrl_instr_11_valid), //i
    .instr_11_ready (vector_instr_11_ready     ), //o
    .t_instr_12_dat (cmd_lane_12_0[63:0]       ), //i
    .instr_12_valid (vector_ctrl_instr_12_valid), //i
    .instr_12_ready (vector_instr_12_ready     ), //o
    .t_instr_13_dat (cmd_lane_13_0[63:0]       ), //i
    .instr_13_valid (vector_ctrl_instr_13_valid), //i
    .instr_13_ready (vector_instr_13_ready     ), //o
    .t_instr_14_dat (cmd_lane_14_0[63:0]       ), //i
    .instr_14_valid (vector_ctrl_instr_14_valid), //i
    .instr_14_ready (vector_instr_14_ready     ), //o
    .t_instr_15_dat (cmd_lane_15_0[63:0]       ), //i
    .instr_15_valid (vector_ctrl_instr_15_valid), //i
    .instr_15_ready (vector_instr_15_ready     ), //o
    .t_k15_dat      (oumux_k15[511:0]          ), //i
    .tk15_valid     (vector_ctrl_tk15_valid    ), //i
    .tk15_ready     (vector_tk15_ready         ), //o
    .i_k15_dat      (vector_i_k15_dat[511:0]   ), //o
    .ik15_valid     (vector_ik15_valid         ), //o
    .ik15_ready     (vector_ctrl_ik15_ready    ), //i
    .i_kap_dat      (vector_i_kap_dat[263:0]   ), //o
    .kap_valid      (vector_kap_valid          ), //o
    .kap_ready      (vector_ctrl_kap_ready     ), //i
    .clk            (vector_clk                ), //i
    .reset_n        (vector_reset_n            )  //i
  );
  vector_ctrl_17_2 vector_ctrl (
    .t_instr_0_req  (vector_ctrl_t_instr_0_req ), //i
    .t_instr_0_ack  (vector_ctrl_t_instr_0_ack ), //o
    .t_instr_1_req  (vector_ctrl_t_instr_1_req ), //i
    .t_instr_1_ack  (vector_ctrl_t_instr_1_ack ), //o
    .t_instr_2_req  (vector_ctrl_t_instr_2_req ), //i
    .t_instr_2_ack  (vector_ctrl_t_instr_2_ack ), //o
    .t_instr_3_req  (vector_ctrl_t_instr_3_req ), //i
    .t_instr_3_ack  (vector_ctrl_t_instr_3_ack ), //o
    .t_instr_4_req  (vector_ctrl_t_instr_4_req ), //i
    .t_instr_4_ack  (vector_ctrl_t_instr_4_ack ), //o
    .t_instr_5_req  (vector_ctrl_t_instr_5_req ), //i
    .t_instr_5_ack  (vector_ctrl_t_instr_5_ack ), //o
    .t_instr_6_req  (vector_ctrl_t_instr_6_req ), //i
    .t_instr_6_ack  (vector_ctrl_t_instr_6_ack ), //o
    .t_instr_7_req  (vector_ctrl_t_instr_7_req ), //i
    .t_instr_7_ack  (vector_ctrl_t_instr_7_ack ), //o
    .t_instr_8_req  (vector_ctrl_t_instr_8_req ), //i
    .t_instr_8_ack  (vector_ctrl_t_instr_8_ack ), //o
    .t_instr_9_req  (vector_ctrl_t_instr_9_req ), //i
    .t_instr_9_ack  (vector_ctrl_t_instr_9_ack ), //o
    .t_instr_10_req (vector_ctrl_t_instr_10_req), //i
    .t_instr_10_ack (vector_ctrl_t_instr_10_ack), //o
    .t_instr_11_req (vector_ctrl_t_instr_11_req), //i
    .t_instr_11_ack (vector_ctrl_t_instr_11_ack), //o
    .t_instr_12_req (vector_ctrl_t_instr_12_req), //i
    .t_instr_12_ack (vector_ctrl_t_instr_12_ack), //o
    .t_instr_13_req (vector_ctrl_t_instr_13_req), //i
    .t_instr_13_ack (vector_ctrl_t_instr_13_ack), //o
    .t_instr_14_req (vector_ctrl_t_instr_14_req), //i
    .t_instr_14_ack (vector_ctrl_t_instr_14_ack), //o
    .t_instr_15_req (vector_ctrl_t_instr_15_req), //i
    .t_instr_15_ack (vector_ctrl_t_instr_15_ack), //o
    .t_k15_req      (vector_ctrl_t_k15_req     ), //i
    .t_k15_ack      (vector_ctrl_t_k15_ack     ), //o
    .i_k15_req      (vector_ctrl_i_k15_req     ), //o
    .i_k15_ack      (vector_ctrl_i_k15_ack     ), //i
    .i_kap_req      (vector_ctrl_i_kap_req     ), //o
    .i_kap_ack      (vector_ctrl_i_kap_ack     ), //i
    .instr_0_valid  (vector_ctrl_instr_0_valid ), //o
    .instr_0_ready  (vector_instr_0_ready      ), //i
    .instr_1_valid  (vector_ctrl_instr_1_valid ), //o
    .instr_1_ready  (vector_instr_1_ready      ), //i
    .instr_2_valid  (vector_ctrl_instr_2_valid ), //o
    .instr_2_ready  (vector_instr_2_ready      ), //i
    .instr_3_valid  (vector_ctrl_instr_3_valid ), //o
    .instr_3_ready  (vector_instr_3_ready      ), //i
    .instr_4_valid  (vector_ctrl_instr_4_valid ), //o
    .instr_4_ready  (vector_instr_4_ready      ), //i
    .instr_5_valid  (vector_ctrl_instr_5_valid ), //o
    .instr_5_ready  (vector_instr_5_ready      ), //i
    .instr_6_valid  (vector_ctrl_instr_6_valid ), //o
    .instr_6_ready  (vector_instr_6_ready      ), //i
    .instr_7_valid  (vector_ctrl_instr_7_valid ), //o
    .instr_7_ready  (vector_instr_7_ready      ), //i
    .instr_8_valid  (vector_ctrl_instr_8_valid ), //o
    .instr_8_ready  (vector_instr_8_ready      ), //i
    .instr_9_valid  (vector_ctrl_instr_9_valid ), //o
    .instr_9_ready  (vector_instr_9_ready      ), //i
    .instr_10_valid (vector_ctrl_instr_10_valid), //o
    .instr_10_ready (vector_instr_10_ready     ), //i
    .instr_11_valid (vector_ctrl_instr_11_valid), //o
    .instr_11_ready (vector_instr_11_ready     ), //i
    .instr_12_valid (vector_ctrl_instr_12_valid), //o
    .instr_12_ready (vector_instr_12_ready     ), //i
    .instr_13_valid (vector_ctrl_instr_13_valid), //o
    .instr_13_ready (vector_instr_13_ready     ), //i
    .instr_14_valid (vector_ctrl_instr_14_valid), //o
    .instr_14_ready (vector_instr_14_ready     ), //i
    .instr_15_valid (vector_ctrl_instr_15_valid), //o
    .instr_15_ready (vector_instr_15_ready     ), //i
    .tk15_valid     (vector_ctrl_tk15_valid    ), //o
    .tk15_ready     (vector_tk15_ready         ), //i
    .ik15_valid     (vector_ik15_valid         ), //i
    .ik15_ready     (vector_ctrl_ik15_ready    ), //o
    .kap_valid      (vector_kap_valid          ), //i
    .kap_ready      (vector_ctrl_kap_ready     ), //o
    .clk            (vector_ctrl_clk           ), //i
    .reset_n        (vector_ctrl_reset_n       )  //i
  );
  inmux_dat_4_1 inmux (
    .t_k1_dat    (dp_k1[511:0]            ), //i
    .t_k13_dat   (oumux_k13[511:0]        ), //i
    .t_k15_dat   (vector_k15[511:0]       ), //i
    .t_c_dat     (ka_decode_k_sk[3:0]     ), //i
    .i_inmux_dat (inmux_i_inmux_dat[511:0]), //o
    .sel         (inmux_sel[3:0]          ), //o
    .clk         (inmux_clk               ), //i
    .reset_n     (inmux_reset_n           )  //i
  );
  inmux_ctrl_4_1 inmux_ctrl (
    .t_k1_req    (inmux_ctrl_t_k1_req   ), //i
    .t_k1_ack    (inmux_ctrl_t_k1_ack   ), //o
    .t_k13_req   (inmux_ctrl_t_k13_req  ), //i
    .t_k13_ack   (inmux_ctrl_t_k13_ack  ), //o
    .t_k15_req   (inmux_ctrl_t_k15_req  ), //i
    .t_k15_ack   (inmux_ctrl_t_k15_ack  ), //o
    .t_c_req     (inmux_ctrl_t_c_req    ), //i
    .t_c_ack     (inmux_ctrl_t_c_ack    ), //o
    .i_inmux_req (inmux_ctrl_i_inmux_req), //o
    .i_inmux_ack (inmux_ctrl_i_inmux_ack), //i
    .sel         (inmux_sel[3:0]        ), //i
    .clk         (inmux_ctrl_clk        ), //i
    .reset_n     (inmux_ctrl_reset_n    )  //i
  );
`ifdef HIGGS_FPGA_XILINX
  vmem_dat_6_5_1_1 #(
`else
  vmem_dat_6_5 #(
`endif
    .VMEM_SIZE (VMEM_SIZE),
    .VMEM0     (VMEM0    ),
    .VMEM1     (VMEM1    ),
    .VMEM2     (VMEM2    ),
    .VMEM3     (VMEM3    ),
    .VMEM4     (VMEM4    ),
    .VMEM5     (VMEM5    ),
    .VMEM6     (VMEM6    ),
    .VMEM7     (VMEM7    ),
    .VMEM8     (VMEM8    ),
    .VMEM9     (VMEM9    ),
    .VMEM10    (VMEM10   ),
    .VMEM11    (VMEM11   ),
    .VMEM12    (VMEM12   ),
    .VMEM13    (VMEM13   ),
    .VMEM14    (VMEM14   ),
    .VMEM15    (VMEM15   ),
    .VMEM16    (VMEM16   ),
    .VMEM17    (VMEM17   ),
    .VMEM18    (VMEM18   ),
    .VMEM19    (VMEM19   ),
    .VMEM20    (VMEM20   ),
    .VMEM21    (VMEM21   ),
    .VMEM22    (VMEM22   ),
    .VMEM23    (VMEM23   ),
    .VMEM24    (VMEM24   ),
    .VMEM25    (VMEM25   ),
    .VMEM26    (VMEM26   ),
    .VMEM27    (VMEM27   ),
    .VMEM28    (VMEM28   ),
    .VMEM29    (VMEM29   ),
    .VMEM30    (VMEM30   ),
    .VMEM31    (VMEM31   )
  ) vmem (
    .t_idma_0_dat (t_idma_0_idma_0[48:0]    ), //i
    .t_idma_1_dat (idma_1_s1_0[48:0]        ), //i
    .t_idma_2_dat (t_idma_2_idma_2[48:0]    ), //i
    .t_idma_3_dat (t_idma_3_idma_3[48:0]    ), //i
    .idma_valid   (vmem_ctrl_idma_valid[3:0]), //i
    .idma_ready   (vmem_idma_ready[3:0]     ), //o
    .i_odma_0_dat (vmem_i_odma_0_dat[31:0]  ), //o
    .i_odma_1_dat (vmem_i_odma_1_dat[31:0]  ), //o
    .i_odma_2_dat (vmem_i_odma_2_dat[31:0]  ), //o
    .i_odma_3_dat (vmem_i_odma_3_dat[31:0]  ), //o
    .odma_valid   (vmem_odma_valid[3:0]     ), //o
    .odma_ready   (vmem_ctrl_odma_ready[3:0]), //i
    .t_ivs_dat    (iperm_data_data[511:0]   ), //i
    .t_ka_dat     (ka_decode_ka[195:0]      ), //i
    .tvs_valid    (vmem_ctrl_tvs_valid      ), //i
    .tvs_ready    (vmem_tvs_ready           ), //o
    .i_ovs_dat    (vmem_i_ovs_dat[511:0]    ), //o
    .ivs_valid    (vmem_ivs_valid           ), //o
    .ivs_ready    (vmem_ctrl_ivs_ready      ), //i
    .k_ctrl       (vmem_k_ctrl[3:0]         ), //o
    .clk          (vmem_clk                 ), //i
    .reset_n      (vmem_reset_n             )  //i
  );
  vmem_ctrl_6_5 vmem_ctrl (
    .t_idma_0_req (vmem_ctrl_t_idma_0_req   ), //i
    .t_idma_0_ack (vmem_ctrl_t_idma_0_ack   ), //o
    .t_idma_1_req (vmem_ctrl_t_idma_1_req   ), //i
    .t_idma_1_ack (vmem_ctrl_t_idma_1_ack   ), //o
    .t_idma_2_req (vmem_ctrl_t_idma_2_req   ), //i
    .t_idma_2_ack (vmem_ctrl_t_idma_2_ack   ), //o
    .t_idma_3_req (vmem_ctrl_t_idma_3_req   ), //i
    .t_idma_3_ack (vmem_ctrl_t_idma_3_ack   ), //o
    .i_odma_0_req (vmem_ctrl_i_odma_0_req   ), //o
    .i_odma_0_ack (vmem_ctrl_i_odma_0_ack   ), //i
    .i_odma_1_req (vmem_ctrl_i_odma_1_req   ), //o
    .i_odma_1_ack (vmem_ctrl_i_odma_1_ack   ), //i
    .i_odma_2_req (vmem_ctrl_i_odma_2_req   ), //o
    .i_odma_2_ack (vmem_ctrl_i_odma_2_ack   ), //i
    .i_odma_3_req (vmem_ctrl_i_odma_3_req   ), //o
    .i_odma_3_ack (vmem_ctrl_i_odma_3_ack   ), //i
    .t_ka_req     (vmem_ctrl_t_ka_req       ), //i
    .t_ka_ack     (vmem_ctrl_t_ka_ack       ), //o
    .t_ivs_req    (vmem_ctrl_t_ivs_req      ), //i
    .t_ivs_ack    (vmem_ctrl_t_ivs_ack      ), //o
    .i_ovs_req    (vmem_ctrl_i_ovs_req      ), //o
    .i_ovs_ack    (vmem_ctrl_i_ovs_ack      ), //i
    .idma_valid   (vmem_ctrl_idma_valid[3:0]), //o
    .idma_ready   (vmem_idma_ready[3:0]     ), //i
    .odma_valid   (vmem_odma_valid[3:0]     ), //i
    .odma_ready   (vmem_ctrl_odma_ready[3:0]), //o
    .tvs_valid    (vmem_ctrl_tvs_valid      ), //o
    .tvs_ready    (vmem_tvs_ready           ), //i
    .ivs_valid    (vmem_ivs_valid           ), //i
    .ivs_ready    (vmem_ctrl_ivs_ready      ), //o
    .k_ctrl       (vmem_k_ctrl[3:0]         ), //i
    .clk          (vmem_ctrl_clk            ), //i
    .reset_n      (vmem_ctrl_reset_n        )  //i
  );
  oumux_dat_2_5 oumux (
    .t_oumux_dat (operm_data_data[511:0]), //i
    .t_c_dat     (ka_decode_k_lk[3:0]   ), //i
    .i_k8_dat    (oumux_i_k8_dat[511:0] ), //o
    .i_k9_dat    (oumux_i_k9_dat[511:0] ), //o
    .i_k13_dat   (oumux_i_k13_dat[511:0]), //o
    .i_k14_dat   (oumux_i_k14_dat[511:0]), //o
    .i_k15_dat   (oumux_i_k15_dat[511:0]), //o
    .sel         (oumux_sel[3:0]        ), //o
    .clk         (oumux_clk             ), //i
    .reset_n     (oumux_reset_n         )  //i
  );
  oumux_ctrl_2_5 oumux_ctrl (
    .i_k8_req    (oumux_ctrl_i_k8_req   ), //o
    .i_k8_ack    (oumux_ctrl_i_k8_ack   ), //i
    .i_k9_req    (oumux_ctrl_i_k9_req   ), //o
    .i_k9_ack    (oumux_ctrl_i_k9_ack   ), //i
    .i_k13_req   (oumux_ctrl_i_k13_req  ), //o
    .i_k13_ack   (oumux_ctrl_i_k13_ack  ), //i
    .i_k14_req   (oumux_ctrl_i_k14_req  ), //o
    .i_k14_ack   (oumux_ctrl_i_k14_ack  ), //i
    .i_k15_req   (oumux_ctrl_i_k15_req  ), //o
    .i_k15_ack   (oumux_ctrl_i_k15_ack  ), //i
    .t_c_req     (oumux_ctrl_t_c_req    ), //i
    .t_c_ack     (oumux_ctrl_t_c_ack    ), //o
    .t_oumux_req (oumux_ctrl_t_oumux_req), //i
    .t_oumux_ack (oumux_ctrl_t_oumux_ack), //o
    .sel         (oumux_sel[3:0]        ), //i
    .clk         (oumux_ctrl_clk        ), //i
    .reset_n     (oumux_ctrl_reset_n    )  //i
  );
  perm_full_addr_dat_1_1 perm_full_addr (
    .t_0_dat (kap_deconcat_0[67:0]        ), //i
    .i_0_dat (perm_full_addr_i_0_dat[67:0]), //o
    .clk     (perm_full_addr_clk          ), //i
    .reset_n (perm_full_addr_reset_n      )  //i
  );
  perm_full_data_dat_2_1 iperm_data (
    .t_data_dat (inmux_inmux[511:0]          ), //i
    .t_addr_dat (iperm_data_t_addr_dat[63:0] ), //i
    .i_data_dat (iperm_data_i_data_dat[511:0]), //o
    .clk        (iperm_data_clk              ), //i
    .reset_n    (iperm_data_reset_n          )  //i
  );
  perm_full_data_dat_2_1 operm_data (
    .t_data_dat (vmem_ovs_0[511:0]           ), //i
    .t_addr_dat (operm_data_t_addr_dat[63:0] ), //i
    .i_data_dat (operm_data_i_data_dat[511:0]), //o
    .clk        (operm_data_clk              ), //i
    .reset_n    (operm_data_reset_n          )  //i
  );
  ka_decode_dat_1_3 ka_decode (
    .t_ka_dat   (kap_deconcat_1[195:0]    ), //i
    .i_k_sk_dat (ka_decode_i_k_sk_dat[3:0]), //o
    .i_k_lk_dat (ka_decode_i_k_lk_dat[3:0]), //o
    .i_ka_dat   (ka_decode_i_ka_dat[195:0]), //o
    .k_ctrl     (ka_decode_k_ctrl[3:0]    ), //o
    .clk        (ka_decode_clk            ), //i
    .reset_n    (ka_decode_reset_n        )  //i
  );
  ka_decode_ctrl_1_3 ka_decode_ctrl (
    .t_ka_req   (ka_decode_ctrl_t_ka_req  ), //i
    .t_ka_ack   (ka_decode_ctrl_t_ka_ack  ), //o
    .i_k_sk_req (ka_decode_ctrl_i_k_sk_req), //o
    .i_k_sk_ack (ka_decode_ctrl_i_k_sk_ack), //i
    .i_k_lk_req (ka_decode_ctrl_i_k_lk_req), //o
    .i_k_lk_ack (ka_decode_ctrl_i_k_lk_ack), //i
    .i_ka_req   (ka_decode_ctrl_i_ka_req  ), //o
    .i_ka_ack   (ka_decode_ctrl_i_ka_ack  ), //i
    .k_ctrl     (ka_decode_k_ctrl[3:0]    ), //i
    .clk        (ka_decode_ctrl_clk       ), //i
    .reset_n    (ka_decode_ctrl_reset_n   )  //i
  );
  p_decode_dat_1_2 p_decode (
    .t_kp_dat   (perm_full_addr_0[67:0]   ), //i
    .i_p_sk_dat (p_decode_i_p_sk_dat[63:0]), //o
    .i_p_lk_dat (p_decode_i_p_lk_dat[63:0]), //o
    .k_ctrl     (p_decode_k_ctrl[3:0]     ), //o
    .clk        (p_decode_clk             ), //i
    .reset_n    (p_decode_reset_n         )  //i
  );
  p_decode_ctrl_1_2 p_decode_ctrl (
    .t_kp_req   (p_decode_ctrl_t_kp_req  ), //i
    .t_kp_ack   (p_decode_ctrl_t_kp_ack  ), //o
    .i_p_sk_req (p_decode_ctrl_i_p_sk_req), //o
    .i_p_sk_ack (p_decode_ctrl_i_p_sk_ack), //i
    .i_p_lk_req (p_decode_ctrl_i_p_lk_req), //o
    .i_p_lk_ack (p_decode_ctrl_i_p_lk_ack), //i
    .k_ctrl     (p_decode_k_ctrl[3:0]    ), //i
    .clk        (p_decode_ctrl_clk       ), //i
    .reset_n    (p_decode_ctrl_reset_n   )  //i
  );
  piston_dp dp (
    .clk       (dp_clk            ), //i
    .reset_n   (dp_reset_n        ), //i
    .t_k8_dat  (oumux_k8[511:0]   ), //i
    .t_k8_req  (dp_t_k8_req       ), //i
    .t_k8_ack  (dp_t_k8_ack       ), //o
    .t_k9_dat  (oumux_k9[511:0]   ), //i
    .t_k9_req  (dp_t_k9_req       ), //i
    .t_k9_ack  (dp_t_k9_ack       ), //o
    .t_k14_dat (oumux_k14[511:0]  ), //i
    .t_k14_req (dp_t_k14_req      ), //i
    .t_k14_ack (dp_t_k14_ack      ), //o
    .i_k1_dat  (dp_i_k1_dat[511:0]), //o
    .i_k1_req  (dp_i_k1_req       ), //o
    .i_k1_ack  (dp_i_k1_ack       )  //i
  );
  assign t_instr_0_nxt = t_instr_dat;
  assign t_instr_0_req = t_instr_req;
  assign t_instr_ack = t_instr_0_ack;
  assign cmd_s1_0_0_nxt = t_instr_0;
  assign cmd_s1_0_0_req = t_instr_0_to_cmd_s1_0_req;
  assign t_instr_0_to_cmd_s1_0_ack = cmd_s1_0_0_ack;
  assign cmd_s1_1_0_nxt = t_instr_0;
  assign cmd_s1_1_0_req = t_instr_0_to_cmd_s1_1_req;
  assign t_instr_0_to_cmd_s1_1_ack = cmd_s1_1_0_ack;
  assign cmd_s2_0_0_nxt = cmd_s1_0_0;
  assign cmd_s2_0_0_req = cmd_s1_0_0_to_cmd_s2_0_req;
  assign cmd_s1_0_0_to_cmd_s2_0_ack = cmd_s2_0_0_ack;
  assign cmd_s2_1_0_nxt = cmd_s1_0_0;
  assign cmd_s2_1_0_req = cmd_s1_0_0_to_cmd_s2_1_req;
  assign cmd_s1_0_0_to_cmd_s2_1_ack = cmd_s2_1_0_ack;
  assign cmd_s2_2_0_nxt = cmd_s1_1_0;
  assign cmd_s2_2_0_req = cmd_s1_1_0_to_cmd_s2_2_req;
  assign cmd_s1_1_0_to_cmd_s2_2_ack = cmd_s2_2_0_ack;
  assign cmd_s2_3_0_nxt = cmd_s1_1_0;
  assign cmd_s2_3_0_req = cmd_s1_1_0_to_cmd_s2_3_req;
  assign cmd_s1_1_0_to_cmd_s2_3_ack = cmd_s2_3_0_ack;
  assign cmd_s3_0_0_nxt = cmd_s2_0_0;
  assign cmd_s3_0_0_req = cmd_s2_0_0_to_cmd_s3_0_req;
  assign cmd_s2_0_0_to_cmd_s3_0_ack = cmd_s3_0_0_ack;
  assign cmd_s3_1_0_nxt = cmd_s2_0_0;
  assign cmd_s3_1_0_req = cmd_s2_0_0_to_cmd_s3_1_req;
  assign cmd_s2_0_0_to_cmd_s3_1_ack = cmd_s3_1_0_ack;
  assign cmd_s3_2_0_nxt = cmd_s2_1_0;
  assign cmd_s3_2_0_req = cmd_s2_1_0_to_cmd_s3_2_req;
  assign cmd_s2_1_0_to_cmd_s3_2_ack = cmd_s3_2_0_ack;
  assign cmd_s3_3_0_nxt = cmd_s2_1_0;
  assign cmd_s3_3_0_req = cmd_s2_1_0_to_cmd_s3_3_req;
  assign cmd_s2_1_0_to_cmd_s3_3_ack = cmd_s3_3_0_ack;
  assign cmd_s3_4_0_nxt = cmd_s2_2_0;
  assign cmd_s3_4_0_req = cmd_s2_2_0_to_cmd_s3_4_req;
  assign cmd_s2_2_0_to_cmd_s3_4_ack = cmd_s3_4_0_ack;
  assign cmd_s3_5_0_nxt = cmd_s2_2_0;
  assign cmd_s3_5_0_req = cmd_s2_2_0_to_cmd_s3_5_req;
  assign cmd_s2_2_0_to_cmd_s3_5_ack = cmd_s3_5_0_ack;
  assign cmd_s3_6_0_nxt = cmd_s2_3_0;
  assign cmd_s3_6_0_req = cmd_s2_3_0_to_cmd_s3_6_req;
  assign cmd_s2_3_0_to_cmd_s3_6_ack = cmd_s3_6_0_ack;
  assign cmd_s3_7_0_nxt = cmd_s2_3_0;
  assign cmd_s3_7_0_req = cmd_s2_3_0_to_cmd_s3_7_req;
  assign cmd_s2_3_0_to_cmd_s3_7_ack = cmd_s3_7_0_ack;
  assign t_idma_0_idma_0_nxt = t_idma_0_dat;
  assign t_idma_0_idma_0_req = t_idma_0_req;
  assign t_idma_0_ack = t_idma_0_idma_0_ack;
  assign t_idma_1_idma_1_nxt = t_idma_1_dat;
  assign t_idma_1_idma_1_req = t_idma_1_req;
  assign t_idma_1_ack = t_idma_1_idma_1_ack;
  assign t_idma_2_idma_2_nxt = t_idma_2_dat;
  assign t_idma_2_idma_2_req = t_idma_2_req;
  assign t_idma_2_ack = t_idma_2_idma_2_ack;
  assign t_idma_3_idma_3_nxt = t_idma_3_dat;
  assign t_idma_3_idma_3_req = t_idma_3_req;
  assign t_idma_3_ack = t_idma_3_idma_3_ack;
  assign idma_1_s1_0_nxt = t_idma_1_idma_1;
  assign idma_1_s1_0_req = t_idma_1_idma_1_to_idma_1_s1_req;
  assign t_idma_1_idma_1_to_idma_1_s1_ack = idma_1_s1_0_ack;
  assign i_odma_0_dat = vmem_odma_0;
  assign i_odma_0_req = vmem_odma_0_to_i_odma_0_req;
  assign vmem_odma_0_to_i_odma_0_ack = i_odma_0_ack;
  assign i_odma_1_dat = odma_1_s1_0;
  assign i_odma_1_req = odma_1_s1_0_to_i_odma_1_req;
  assign odma_1_s1_0_to_i_odma_1_ack = i_odma_1_ack;
  assign i_odma_2_dat = odma_2_s1_0;
  assign i_odma_2_req = odma_2_s1_0_to_i_odma_2_req;
  assign odma_2_s1_0_to_i_odma_2_ack = i_odma_2_ack;
  assign i_odma_3_dat = vmem_odma_3;
  assign i_odma_3_req = vmem_odma_3_to_i_odma_3_req;
  assign vmem_odma_3_to_i_odma_3_ack = i_odma_3_ack;
  assign odma_1_s1_0_nxt = vmem_odma_1;
  assign odma_1_s1_0_req = vmem_odma_1_to_odma_1_s1_req;
  assign vmem_odma_1_to_odma_1_s1_ack = odma_1_s1_0_ack;
  assign odma_2_s1_0_nxt = vmem_odma_2;
  assign odma_2_s1_0_req = vmem_odma_2_to_odma_2_s1_req;
  assign vmem_odma_2_to_odma_2_s1_ack = odma_2_s1_0_ack;
  assign vector_k15_nxt = vector_i_k15_dat;
  assign vector_kap_nxt = vector_i_kap_dat;
  assign vector_clk = clk;
  assign vector_reset_n = reset_n;
  assign vector_ctrl_t_instr_0_req = cmd_lane_0_0_to_vector_req;
  assign cmd_lane_0_0_to_vector_ack = vector_ctrl_t_instr_0_ack[0];
  assign vector_ctrl_t_instr_1_req = cmd_lane_1_0_to_vector_req;
  assign cmd_lane_1_0_to_vector_ack = vector_ctrl_t_instr_1_ack[0];
  assign vector_ctrl_t_instr_2_req = cmd_lane_2_0_to_vector_req;
  assign cmd_lane_2_0_to_vector_ack = vector_ctrl_t_instr_2_ack[0];
  assign vector_ctrl_t_instr_3_req = cmd_lane_3_0_to_vector_req;
  assign cmd_lane_3_0_to_vector_ack = vector_ctrl_t_instr_3_ack[0];
  assign vector_ctrl_t_instr_4_req = cmd_lane_4_0_to_vector_req;
  assign cmd_lane_4_0_to_vector_ack = vector_ctrl_t_instr_4_ack[0];
  assign vector_ctrl_t_instr_5_req = cmd_lane_5_0_to_vector_req;
  assign cmd_lane_5_0_to_vector_ack = vector_ctrl_t_instr_5_ack[0];
  assign vector_ctrl_t_instr_6_req = cmd_lane_6_0_to_vector_req;
  assign cmd_lane_6_0_to_vector_ack = vector_ctrl_t_instr_6_ack[0];
  assign vector_ctrl_t_instr_7_req = cmd_lane_7_0_to_vector_req;
  assign cmd_lane_7_0_to_vector_ack = vector_ctrl_t_instr_7_ack[0];
  assign vector_ctrl_t_instr_8_req = cmd_lane_8_0_to_vector_req;
  assign cmd_lane_8_0_to_vector_ack = vector_ctrl_t_instr_8_ack[0];
  assign vector_ctrl_t_instr_9_req = cmd_lane_9_0_to_vector_req;
  assign cmd_lane_9_0_to_vector_ack = vector_ctrl_t_instr_9_ack[0];
  assign vector_ctrl_t_instr_10_req = cmd_lane_10_0_to_vector_req;
  assign cmd_lane_10_0_to_vector_ack = vector_ctrl_t_instr_10_ack[0];
  assign vector_ctrl_t_instr_11_req = cmd_lane_11_0_to_vector_req;
  assign cmd_lane_11_0_to_vector_ack = vector_ctrl_t_instr_11_ack[0];
  assign vector_ctrl_t_instr_12_req = cmd_lane_12_0_to_vector_req;
  assign cmd_lane_12_0_to_vector_ack = vector_ctrl_t_instr_12_ack[0];
  assign vector_ctrl_t_instr_13_req = cmd_lane_13_0_to_vector_req;
  assign cmd_lane_13_0_to_vector_ack = vector_ctrl_t_instr_13_ack[0];
  assign vector_ctrl_t_instr_14_req = cmd_lane_14_0_to_vector_req;
  assign cmd_lane_14_0_to_vector_ack = vector_ctrl_t_instr_14_ack[0];
  assign vector_ctrl_t_instr_15_req = cmd_lane_15_0_to_vector_req;
  assign cmd_lane_15_0_to_vector_ack = vector_ctrl_t_instr_15_ack[0];
  assign vector_ctrl_t_k15_req = oumux_k15_to_vector_req;
  assign oumux_k15_to_vector_ack = vector_ctrl_t_k15_ack[0];
  assign vector_k15_req = vector_ctrl_i_k15_req[0];
  assign vector_ctrl_i_k15_ack = vector_k15_ack;
  assign vector_kap_req = vector_ctrl_i_kap_req[0];
  assign vector_ctrl_i_kap_ack = vector_kap_ack;
  assign vector_ctrl_clk = clk;
  assign vector_ctrl_reset_n = reset_n;
  assign inmux_inmux_nxt = inmux_i_inmux_dat;
  assign inmux_clk = clk;
  assign inmux_reset_n = reset_n;
  assign inmux_ctrl_t_k15_req = vector_k15_to_inmux_req;
  assign vector_k15_to_inmux_ack = inmux_ctrl_t_k15_ack[0];
  assign inmux_ctrl_t_k13_req = oumux_k13_to_inmux_req;
  assign oumux_k13_to_inmux_ack = inmux_ctrl_t_k13_ack[0];
  assign inmux_ctrl_t_k1_req = dp_k1_to_inmux_req;
  assign dp_k1_to_inmux_ack = inmux_ctrl_t_k1_ack[0];
  assign inmux_ctrl_t_c_req = ka_decode_k_sk_to_inmux_req;
  assign ka_decode_k_sk_to_inmux_ack = inmux_ctrl_t_c_ack[0];
  assign inmux_inmux_req = inmux_ctrl_i_inmux_req[0];
  assign inmux_ctrl_i_inmux_ack = inmux_inmux_ack;
  assign inmux_ctrl_clk = clk;
  assign inmux_ctrl_reset_n = reset_n;
  assign vmem_ovs = vmem_i_ovs_dat;
  assign vmem_odma_0_nxt = vmem_i_odma_0_dat;
  assign vmem_odma_1_nxt = vmem_i_odma_1_dat;
  assign vmem_odma_2_nxt = vmem_i_odma_2_dat;
  assign vmem_odma_3_nxt = vmem_i_odma_3_dat;
  assign vmem_clk = clk;
  assign vmem_reset_n = reset_n;
  assign vmem_ctrl_t_ivs_req = iperm_data_data_to_vmem_req;
  assign iperm_data_data_to_vmem_ack = vmem_ctrl_t_ivs_ack[0];
  assign vmem_ctrl_t_ka_req = ka_decode_ka_to_vmem_req;
  assign ka_decode_ka_to_vmem_ack = vmem_ctrl_t_ka_ack[0];
  assign vmem_ctrl_t_idma_0_req = t_idma_0_idma_0_to_vmem_req;
  assign t_idma_0_idma_0_to_vmem_ack = vmem_ctrl_t_idma_0_ack[0];
  assign vmem_ctrl_t_idma_1_req = idma_1_s1_0_to_vmem_req;
  assign idma_1_s1_0_to_vmem_ack = vmem_ctrl_t_idma_1_ack[0];
  assign vmem_ctrl_t_idma_2_req = t_idma_2_idma_2_to_vmem_req;
  assign t_idma_2_idma_2_to_vmem_ack = vmem_ctrl_t_idma_2_ack[0];
  assign vmem_ctrl_t_idma_3_req = t_idma_3_idma_3_to_vmem_req;
  assign t_idma_3_idma_3_to_vmem_ack = vmem_ctrl_t_idma_3_ack[0];
  assign vmem_ovs_req = vmem_ctrl_i_ovs_req[0];
  assign vmem_ctrl_i_ovs_ack = vmem_ovs_ack;
  assign vmem_odma_0_req = vmem_ctrl_i_odma_0_req[0];
  assign vmem_ctrl_i_odma_0_ack = vmem_odma_0_ack;
  assign vmem_odma_1_req = vmem_ctrl_i_odma_1_req[0];
  assign vmem_ctrl_i_odma_1_ack = vmem_odma_1_ack;
  assign vmem_odma_2_req = vmem_ctrl_i_odma_2_req[0];
  assign vmem_ctrl_i_odma_2_ack = vmem_odma_2_ack;
  assign vmem_odma_3_req = vmem_ctrl_i_odma_3_req[0];
  assign vmem_ctrl_i_odma_3_ack = vmem_odma_3_ack;
  assign vmem_ctrl_clk = clk;
  assign vmem_ctrl_reset_n = reset_n;
  assign oumux_k15_nxt = oumux_i_k15_dat;
  assign oumux_k8_nxt = oumux_i_k8_dat;
  assign oumux_k9_nxt = oumux_i_k9_dat;
  assign oumux_k14_nxt = oumux_i_k14_dat;
  assign oumux_k13_nxt = oumux_i_k13_dat;
  assign oumux_clk = clk;
  assign oumux_reset_n = reset_n;
  assign oumux_ctrl_t_oumux_req = operm_data_data_to_oumux_req;
  assign operm_data_data_to_oumux_ack = oumux_ctrl_t_oumux_ack[0];
  assign oumux_ctrl_t_c_req = ka_decode_k_lk_to_oumux_req;
  assign ka_decode_k_lk_to_oumux_ack = oumux_ctrl_t_c_ack[0];
  assign oumux_k15_req = oumux_ctrl_i_k15_req[0];
  assign oumux_ctrl_i_k15_ack = oumux_k15_ack;
  assign oumux_k8_req = oumux_ctrl_i_k8_req[0];
  assign oumux_ctrl_i_k8_ack = oumux_k8_ack;
  assign oumux_k9_req = oumux_ctrl_i_k9_req[0];
  assign oumux_ctrl_i_k9_ack = oumux_k9_ack;
  assign oumux_k14_req = oumux_ctrl_i_k14_req[0];
  assign oumux_ctrl_i_k14_ack = oumux_k14_ack;
  assign oumux_k13_req = oumux_ctrl_i_k13_req[0];
  assign oumux_ctrl_i_k13_ack = oumux_k13_ack;
  assign oumux_ctrl_clk = clk;
  assign oumux_ctrl_reset_n = reset_n;
  assign kap_deconcat_0_nxt = vector_kap[67 : 0];
  assign kap_deconcat_1_nxt = vector_kap[263 : 68];
  assign kap_deconcat_0_req = (vector_kap_to_kap_deconcat_req && (! kap_deconcat_i_0_req_reg));
  assign kap_deconcat_i_0_ack_g = (kap_deconcat_0_ack || (! kap_deconcat_0_req));
  assign kap_deconcat_1_req = (vector_kap_to_kap_deconcat_req && (! kap_deconcat_i_1_req_reg));
  assign kap_deconcat_i_1_ack_g = (kap_deconcat_1_ack || (! kap_deconcat_1_req));
  assign vector_kap_to_kap_deconcat_ack = (kap_deconcat_i_0_ack_g && kap_deconcat_i_1_ack_g);
  assign perm_full_addr_0_nxt = perm_full_addr_i_0_dat;
  assign perm_full_addr_clk = clk;
  assign perm_full_addr_reset_n = reset_n;
  assign perm_full_addr_0_req = kap_deconcat_0_to_perm_full_addr_req;
  assign kap_deconcat_0_to_perm_full_addr_ack = perm_full_addr_0_ack;
  assign iperm_data_t_addr_dat = p_decode_p_sk[63:0];
  assign iperm_data_data_nxt = iperm_data_i_data_dat;
  assign iperm_data_clk = clk;
  assign iperm_data_reset_n = reset_n;
  assign iperm_data_data_req = (inmux_inmux_to_iperm_data_req && p_decode_p_sk_to_iperm_data_req);
  assign inmux_inmux_to_iperm_data_ack = (iperm_data_data_ack && p_decode_p_sk_to_iperm_data_req);
  assign p_decode_p_sk_to_iperm_data_ack = (iperm_data_data_ack && inmux_inmux_to_iperm_data_req);
  assign operm_data_t_addr_dat = p_decode_p_lk[63:0];
  assign operm_data_data_nxt = operm_data_i_data_dat;
  assign operm_data_clk = clk;
  assign operm_data_reset_n = reset_n;
  assign operm_data_data_req = (vmem_ovs_0_to_operm_data_req && p_decode_p_lk_to_operm_data_req);
  assign vmem_ovs_0_to_operm_data_ack = (operm_data_data_ack && p_decode_p_lk_to_operm_data_req);
  assign p_decode_p_lk_to_operm_data_ack = (operm_data_data_ack && vmem_ovs_0_to_operm_data_req);
  assign ka_decode_ka_nxt = ka_decode_i_ka_dat;
  assign ka_decode_k_sk_nxt = ka_decode_i_k_sk_dat;
  assign ka_decode_k_lk_nxt = ka_decode_i_k_lk_dat;
  assign ka_decode_clk = clk;
  assign ka_decode_reset_n = reset_n;
  assign ka_decode_ctrl_t_ka_req = kap_deconcat_1_to_ka_decode_req;
  assign kap_deconcat_1_to_ka_decode_ack = ka_decode_ctrl_t_ka_ack[0];
  assign ka_decode_ka_req = ka_decode_ctrl_i_ka_req[0];
  assign ka_decode_ctrl_i_ka_ack = ka_decode_ka_ack;
  assign ka_decode_k_sk_req = ka_decode_ctrl_i_k_sk_req[0];
  assign ka_decode_ctrl_i_k_sk_ack = ka_decode_k_sk_ack;
  assign ka_decode_k_lk_req = ka_decode_ctrl_i_k_lk_req[0];
  assign ka_decode_ctrl_i_k_lk_ack = ka_decode_k_lk_ack;
  assign ka_decode_ctrl_clk = clk;
  assign ka_decode_ctrl_reset_n = reset_n;
  assign p_decode_p_sk_nxt = {4'd0, p_decode_i_p_sk_dat};
  assign p_decode_p_lk_nxt = {4'd0, p_decode_i_p_lk_dat};
  assign p_decode_clk = clk;
  assign p_decode_reset_n = reset_n;
  assign p_decode_ctrl_t_kp_req = perm_full_addr_0_to_p_decode_req;
  assign perm_full_addr_0_to_p_decode_ack = p_decode_ctrl_t_kp_ack[0];
  assign p_decode_p_sk_req = p_decode_ctrl_i_p_sk_req[0];
  assign p_decode_ctrl_i_p_sk_ack = p_decode_p_sk_ack;
  assign p_decode_p_lk_req = p_decode_ctrl_i_p_lk_req[0];
  assign p_decode_ctrl_i_p_lk_ack = p_decode_p_lk_ack;
  assign p_decode_ctrl_clk = clk;
  assign p_decode_ctrl_reset_n = reset_n;
  assign vmem_ovs_0_nxt = vmem_ovs;
  assign vmem_ovs_0_req = vmem_ovs_to_vmem_ovs_req;
  assign vmem_ovs_to_vmem_ovs_ack = vmem_ovs_0_ack;
  assign dp_t_k8_req = oumux_k8_to_dp_req;
  assign oumux_k8_to_dp_ack = dp_t_k8_ack[0];
  assign dp_t_k9_req = oumux_k9_to_dp_req;
  assign oumux_k9_to_dp_ack = dp_t_k9_ack[0];
  assign dp_t_k14_req = oumux_k14_to_dp_req;
  assign oumux_k14_to_dp_ack = dp_t_k14_ack[0];
  assign dp_k1 = dp_i_k1_dat;
  assign dp_k1_req = dp_i_k1_req[0];
  assign dp_i_k1_ack = dp_k1_ack;
  assign dp_clk = clk;
  assign dp_reset_n = reset_n;
  assign cmd_lane_0_0_nxt = cmd_s3_0_0;
  assign cmd_lane_0_0_req = cmd_s3_0_0_to_cmd_lane_0_req;
  assign cmd_s3_0_0_to_cmd_lane_0_ack = cmd_lane_0_0_ack;
  assign cmd_lane_1_0_nxt = cmd_s3_0_0;
  assign cmd_lane_1_0_req = cmd_s3_0_0_to_cmd_lane_1_req;
  assign cmd_s3_0_0_to_cmd_lane_1_ack = cmd_lane_1_0_ack;
  assign cmd_lane_2_0_nxt = cmd_s3_1_0;
  assign cmd_lane_2_0_req = cmd_s3_1_0_to_cmd_lane_2_req;
  assign cmd_s3_1_0_to_cmd_lane_2_ack = cmd_lane_2_0_ack;
  assign cmd_lane_3_0_nxt = cmd_s3_1_0;
  assign cmd_lane_3_0_req = cmd_s3_1_0_to_cmd_lane_3_req;
  assign cmd_s3_1_0_to_cmd_lane_3_ack = cmd_lane_3_0_ack;
  assign cmd_lane_4_0_nxt = cmd_s3_2_0;
  assign cmd_lane_4_0_req = cmd_s3_2_0_to_cmd_lane_4_req;
  assign cmd_s3_2_0_to_cmd_lane_4_ack = cmd_lane_4_0_ack;
  assign cmd_lane_5_0_nxt = cmd_s3_2_0;
  assign cmd_lane_5_0_req = cmd_s3_2_0_to_cmd_lane_5_req;
  assign cmd_s3_2_0_to_cmd_lane_5_ack = cmd_lane_5_0_ack;
  assign cmd_lane_6_0_nxt = cmd_s3_3_0;
  assign cmd_lane_6_0_req = cmd_s3_3_0_to_cmd_lane_6_req;
  assign cmd_s3_3_0_to_cmd_lane_6_ack = cmd_lane_6_0_ack;
  assign cmd_lane_7_0_nxt = cmd_s3_3_0;
  assign cmd_lane_7_0_req = cmd_s3_3_0_to_cmd_lane_7_req;
  assign cmd_s3_3_0_to_cmd_lane_7_ack = cmd_lane_7_0_ack;
  assign cmd_lane_8_0_nxt = cmd_s3_4_0;
  assign cmd_lane_8_0_req = cmd_s3_4_0_to_cmd_lane_8_req;
  assign cmd_s3_4_0_to_cmd_lane_8_ack = cmd_lane_8_0_ack;
  assign cmd_lane_9_0_nxt = cmd_s3_4_0;
  assign cmd_lane_9_0_req = cmd_s3_4_0_to_cmd_lane_9_req;
  assign cmd_s3_4_0_to_cmd_lane_9_ack = cmd_lane_9_0_ack;
  assign cmd_lane_10_0_nxt = cmd_s3_5_0;
  assign cmd_lane_10_0_req = cmd_s3_5_0_to_cmd_lane_10_req;
  assign cmd_s3_5_0_to_cmd_lane_10_ack = cmd_lane_10_0_ack;
  assign cmd_lane_11_0_nxt = cmd_s3_5_0;
  assign cmd_lane_11_0_req = cmd_s3_5_0_to_cmd_lane_11_req;
  assign cmd_s3_5_0_to_cmd_lane_11_ack = cmd_lane_11_0_ack;
  assign cmd_lane_12_0_nxt = cmd_s3_6_0;
  assign cmd_lane_12_0_req = cmd_s3_6_0_to_cmd_lane_12_req;
  assign cmd_s3_6_0_to_cmd_lane_12_ack = cmd_lane_12_0_ack;
  assign cmd_lane_13_0_nxt = cmd_s3_6_0;
  assign cmd_lane_13_0_req = cmd_s3_6_0_to_cmd_lane_13_req;
  assign cmd_s3_6_0_to_cmd_lane_13_ack = cmd_lane_13_0_ack;
  assign cmd_lane_14_0_nxt = cmd_s3_7_0;
  assign cmd_lane_14_0_req = cmd_s3_7_0_to_cmd_lane_14_req;
  assign cmd_s3_7_0_to_cmd_lane_14_ack = cmd_lane_14_0_ack;
  assign cmd_lane_15_0_nxt = cmd_s3_7_0;
  assign cmd_lane_15_0_req = cmd_s3_7_0_to_cmd_lane_15_req;
  assign cmd_s3_7_0_to_cmd_lane_15_ack = cmd_lane_15_0_ack;
  always @(*) begin
    t_instr_0_eb_state_nxt = t_instr_0_eb_state;
    case(t_instr_0_eb_state)
      5'h14 : begin
        if(t_instr_0_req) begin
          t_instr_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! t_instr_0_req) && t_instr_0_m_ack)) begin
          t_instr_0_eb_state_nxt = 5'h14;
        end
        if((t_instr_0_req && (! t_instr_0_m_ack))) begin
          t_instr_0_eb_state_nxt = 5'h08;
        end
        if((t_instr_0_req && t_instr_0_m_ack)) begin
          t_instr_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(t_instr_0_m_ack) begin
          t_instr_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! t_instr_0_req) && t_instr_0_m_ack)) begin
          t_instr_0_eb_state_nxt = 5'h14;
        end
        if((t_instr_0_req && (! t_instr_0_m_ack))) begin
          t_instr_0_eb_state_nxt = 5'h09;
        end
        if((t_instr_0_req && t_instr_0_m_ack)) begin
          t_instr_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(t_instr_0_m_ack) begin
          t_instr_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign t_instr_0_eb_en0 = (t_instr_0_eb_state[2] && t_instr_0_req);
  assign t_instr_0_eb_en1 = (t_instr_0_eb_state[1] && t_instr_0_req);
  assign t_instr_0_eb_sel = t_instr_0_eb_state[0];
  assign t_instr_0_ack = t_instr_0_eb_state[4];
  assign t_instr_0_m_req = t_instr_0_eb_state[3];
  assign t_instr_0 = (t_instr_0_eb_sel ? t_instr_0_eb_r1 : t_instr_0_eb_r0);
  assign t_instr_0_to_cmd_s1_0_req = (t_instr_0_m_req && (! t_instr_0_fork_ack_r_0));
  assign t_instr_0_fork_ack_s_0 = (t_instr_0_to_cmd_s1_0_ack || (! t_instr_0_to_cmd_s1_0_req));
  assign t_instr_0_to_cmd_s1_1_req = (t_instr_0_m_req && (! t_instr_0_fork_ack_r_1));
  assign t_instr_0_fork_ack_s_1 = (t_instr_0_to_cmd_s1_1_ack || (! t_instr_0_to_cmd_s1_1_req));
  assign t_instr_0_m_ack = (t_instr_0_fork_ack_s_0 && t_instr_0_fork_ack_s_1);
  always @(*) begin
    cmd_s1_0_0_eb_state_nxt = cmd_s1_0_0_eb_state;
    case(cmd_s1_0_0_eb_state)
      5'h14 : begin
        if(cmd_s1_0_0_req) begin
          cmd_s1_0_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s1_0_0_req) && cmd_s1_0_0_m_ack)) begin
          cmd_s1_0_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s1_0_0_req && (! cmd_s1_0_0_m_ack))) begin
          cmd_s1_0_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s1_0_0_req && cmd_s1_0_0_m_ack)) begin
          cmd_s1_0_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s1_0_0_m_ack) begin
          cmd_s1_0_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s1_0_0_req) && cmd_s1_0_0_m_ack)) begin
          cmd_s1_0_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s1_0_0_req && (! cmd_s1_0_0_m_ack))) begin
          cmd_s1_0_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s1_0_0_req && cmd_s1_0_0_m_ack)) begin
          cmd_s1_0_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s1_0_0_m_ack) begin
          cmd_s1_0_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s1_0_0_eb_en0 = (cmd_s1_0_0_eb_state[2] && cmd_s1_0_0_req);
  assign cmd_s1_0_0_eb_en1 = (cmd_s1_0_0_eb_state[1] && cmd_s1_0_0_req);
  assign cmd_s1_0_0_eb_sel = cmd_s1_0_0_eb_state[0];
  assign cmd_s1_0_0_ack = cmd_s1_0_0_eb_state[4];
  assign cmd_s1_0_0_m_req = cmd_s1_0_0_eb_state[3];
  assign cmd_s1_0_0 = (cmd_s1_0_0_eb_sel ? cmd_s1_0_0_eb_r1 : cmd_s1_0_0_eb_r0);
  assign cmd_s1_0_0_to_cmd_s2_0_req = (cmd_s1_0_0_m_req && (! cmd_s1_0_0_fork_ack_r_0));
  assign cmd_s1_0_0_fork_ack_s_0 = (cmd_s1_0_0_to_cmd_s2_0_ack || (! cmd_s1_0_0_to_cmd_s2_0_req));
  assign cmd_s1_0_0_to_cmd_s2_1_req = (cmd_s1_0_0_m_req && (! cmd_s1_0_0_fork_ack_r_1));
  assign cmd_s1_0_0_fork_ack_s_1 = (cmd_s1_0_0_to_cmd_s2_1_ack || (! cmd_s1_0_0_to_cmd_s2_1_req));
  assign cmd_s1_0_0_m_ack = (cmd_s1_0_0_fork_ack_s_0 && cmd_s1_0_0_fork_ack_s_1);
  always @(*) begin
    cmd_s1_1_0_eb_state_nxt = cmd_s1_1_0_eb_state;
    case(cmd_s1_1_0_eb_state)
      5'h14 : begin
        if(cmd_s1_1_0_req) begin
          cmd_s1_1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s1_1_0_req) && cmd_s1_1_0_m_ack)) begin
          cmd_s1_1_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s1_1_0_req && (! cmd_s1_1_0_m_ack))) begin
          cmd_s1_1_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s1_1_0_req && cmd_s1_1_0_m_ack)) begin
          cmd_s1_1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s1_1_0_m_ack) begin
          cmd_s1_1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s1_1_0_req) && cmd_s1_1_0_m_ack)) begin
          cmd_s1_1_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s1_1_0_req && (! cmd_s1_1_0_m_ack))) begin
          cmd_s1_1_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s1_1_0_req && cmd_s1_1_0_m_ack)) begin
          cmd_s1_1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s1_1_0_m_ack) begin
          cmd_s1_1_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s1_1_0_eb_en0 = (cmd_s1_1_0_eb_state[2] && cmd_s1_1_0_req);
  assign cmd_s1_1_0_eb_en1 = (cmd_s1_1_0_eb_state[1] && cmd_s1_1_0_req);
  assign cmd_s1_1_0_eb_sel = cmd_s1_1_0_eb_state[0];
  assign cmd_s1_1_0_ack = cmd_s1_1_0_eb_state[4];
  assign cmd_s1_1_0_m_req = cmd_s1_1_0_eb_state[3];
  assign cmd_s1_1_0 = (cmd_s1_1_0_eb_sel ? cmd_s1_1_0_eb_r1 : cmd_s1_1_0_eb_r0);
  assign cmd_s1_1_0_to_cmd_s2_2_req = (cmd_s1_1_0_m_req && (! cmd_s1_1_0_fork_ack_r_0));
  assign cmd_s1_1_0_fork_ack_s_0 = (cmd_s1_1_0_to_cmd_s2_2_ack || (! cmd_s1_1_0_to_cmd_s2_2_req));
  assign cmd_s1_1_0_to_cmd_s2_3_req = (cmd_s1_1_0_m_req && (! cmd_s1_1_0_fork_ack_r_1));
  assign cmd_s1_1_0_fork_ack_s_1 = (cmd_s1_1_0_to_cmd_s2_3_ack || (! cmd_s1_1_0_to_cmd_s2_3_req));
  assign cmd_s1_1_0_m_ack = (cmd_s1_1_0_fork_ack_s_0 && cmd_s1_1_0_fork_ack_s_1);
  always @(*) begin
    cmd_s2_0_0_eb_state_nxt = cmd_s2_0_0_eb_state;
    case(cmd_s2_0_0_eb_state)
      5'h14 : begin
        if(cmd_s2_0_0_req) begin
          cmd_s2_0_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s2_0_0_req) && cmd_s2_0_0_m_ack)) begin
          cmd_s2_0_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s2_0_0_req && (! cmd_s2_0_0_m_ack))) begin
          cmd_s2_0_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s2_0_0_req && cmd_s2_0_0_m_ack)) begin
          cmd_s2_0_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s2_0_0_m_ack) begin
          cmd_s2_0_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s2_0_0_req) && cmd_s2_0_0_m_ack)) begin
          cmd_s2_0_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s2_0_0_req && (! cmd_s2_0_0_m_ack))) begin
          cmd_s2_0_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s2_0_0_req && cmd_s2_0_0_m_ack)) begin
          cmd_s2_0_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s2_0_0_m_ack) begin
          cmd_s2_0_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s2_0_0_eb_en0 = (cmd_s2_0_0_eb_state[2] && cmd_s2_0_0_req);
  assign cmd_s2_0_0_eb_en1 = (cmd_s2_0_0_eb_state[1] && cmd_s2_0_0_req);
  assign cmd_s2_0_0_eb_sel = cmd_s2_0_0_eb_state[0];
  assign cmd_s2_0_0_ack = cmd_s2_0_0_eb_state[4];
  assign cmd_s2_0_0_m_req = cmd_s2_0_0_eb_state[3];
  assign cmd_s2_0_0 = (cmd_s2_0_0_eb_sel ? cmd_s2_0_0_eb_r1 : cmd_s2_0_0_eb_r0);
  assign cmd_s2_0_0_to_cmd_s3_0_req = (cmd_s2_0_0_m_req && (! cmd_s2_0_0_fork_ack_r_0));
  assign cmd_s2_0_0_fork_ack_s_0 = (cmd_s2_0_0_to_cmd_s3_0_ack || (! cmd_s2_0_0_to_cmd_s3_0_req));
  assign cmd_s2_0_0_to_cmd_s3_1_req = (cmd_s2_0_0_m_req && (! cmd_s2_0_0_fork_ack_r_1));
  assign cmd_s2_0_0_fork_ack_s_1 = (cmd_s2_0_0_to_cmd_s3_1_ack || (! cmd_s2_0_0_to_cmd_s3_1_req));
  assign cmd_s2_0_0_m_ack = (cmd_s2_0_0_fork_ack_s_0 && cmd_s2_0_0_fork_ack_s_1);
  always @(*) begin
    cmd_s2_1_0_eb_state_nxt = cmd_s2_1_0_eb_state;
    case(cmd_s2_1_0_eb_state)
      5'h14 : begin
        if(cmd_s2_1_0_req) begin
          cmd_s2_1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s2_1_0_req) && cmd_s2_1_0_m_ack)) begin
          cmd_s2_1_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s2_1_0_req && (! cmd_s2_1_0_m_ack))) begin
          cmd_s2_1_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s2_1_0_req && cmd_s2_1_0_m_ack)) begin
          cmd_s2_1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s2_1_0_m_ack) begin
          cmd_s2_1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s2_1_0_req) && cmd_s2_1_0_m_ack)) begin
          cmd_s2_1_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s2_1_0_req && (! cmd_s2_1_0_m_ack))) begin
          cmd_s2_1_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s2_1_0_req && cmd_s2_1_0_m_ack)) begin
          cmd_s2_1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s2_1_0_m_ack) begin
          cmd_s2_1_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s2_1_0_eb_en0 = (cmd_s2_1_0_eb_state[2] && cmd_s2_1_0_req);
  assign cmd_s2_1_0_eb_en1 = (cmd_s2_1_0_eb_state[1] && cmd_s2_1_0_req);
  assign cmd_s2_1_0_eb_sel = cmd_s2_1_0_eb_state[0];
  assign cmd_s2_1_0_ack = cmd_s2_1_0_eb_state[4];
  assign cmd_s2_1_0_m_req = cmd_s2_1_0_eb_state[3];
  assign cmd_s2_1_0 = (cmd_s2_1_0_eb_sel ? cmd_s2_1_0_eb_r1 : cmd_s2_1_0_eb_r0);
  assign cmd_s2_1_0_to_cmd_s3_2_req = (cmd_s2_1_0_m_req && (! cmd_s2_1_0_fork_ack_r_0));
  assign cmd_s2_1_0_fork_ack_s_0 = (cmd_s2_1_0_to_cmd_s3_2_ack || (! cmd_s2_1_0_to_cmd_s3_2_req));
  assign cmd_s2_1_0_to_cmd_s3_3_req = (cmd_s2_1_0_m_req && (! cmd_s2_1_0_fork_ack_r_1));
  assign cmd_s2_1_0_fork_ack_s_1 = (cmd_s2_1_0_to_cmd_s3_3_ack || (! cmd_s2_1_0_to_cmd_s3_3_req));
  assign cmd_s2_1_0_m_ack = (cmd_s2_1_0_fork_ack_s_0 && cmd_s2_1_0_fork_ack_s_1);
  always @(*) begin
    cmd_s2_2_0_eb_state_nxt = cmd_s2_2_0_eb_state;
    case(cmd_s2_2_0_eb_state)
      5'h14 : begin
        if(cmd_s2_2_0_req) begin
          cmd_s2_2_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s2_2_0_req) && cmd_s2_2_0_m_ack)) begin
          cmd_s2_2_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s2_2_0_req && (! cmd_s2_2_0_m_ack))) begin
          cmd_s2_2_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s2_2_0_req && cmd_s2_2_0_m_ack)) begin
          cmd_s2_2_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s2_2_0_m_ack) begin
          cmd_s2_2_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s2_2_0_req) && cmd_s2_2_0_m_ack)) begin
          cmd_s2_2_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s2_2_0_req && (! cmd_s2_2_0_m_ack))) begin
          cmd_s2_2_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s2_2_0_req && cmd_s2_2_0_m_ack)) begin
          cmd_s2_2_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s2_2_0_m_ack) begin
          cmd_s2_2_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s2_2_0_eb_en0 = (cmd_s2_2_0_eb_state[2] && cmd_s2_2_0_req);
  assign cmd_s2_2_0_eb_en1 = (cmd_s2_2_0_eb_state[1] && cmd_s2_2_0_req);
  assign cmd_s2_2_0_eb_sel = cmd_s2_2_0_eb_state[0];
  assign cmd_s2_2_0_ack = cmd_s2_2_0_eb_state[4];
  assign cmd_s2_2_0_m_req = cmd_s2_2_0_eb_state[3];
  assign cmd_s2_2_0 = (cmd_s2_2_0_eb_sel ? cmd_s2_2_0_eb_r1 : cmd_s2_2_0_eb_r0);
  assign cmd_s2_2_0_to_cmd_s3_4_req = (cmd_s2_2_0_m_req && (! cmd_s2_2_0_fork_ack_r_0));
  assign cmd_s2_2_0_fork_ack_s_0 = (cmd_s2_2_0_to_cmd_s3_4_ack || (! cmd_s2_2_0_to_cmd_s3_4_req));
  assign cmd_s2_2_0_to_cmd_s3_5_req = (cmd_s2_2_0_m_req && (! cmd_s2_2_0_fork_ack_r_1));
  assign cmd_s2_2_0_fork_ack_s_1 = (cmd_s2_2_0_to_cmd_s3_5_ack || (! cmd_s2_2_0_to_cmd_s3_5_req));
  assign cmd_s2_2_0_m_ack = (cmd_s2_2_0_fork_ack_s_0 && cmd_s2_2_0_fork_ack_s_1);
  always @(*) begin
    cmd_s2_3_0_eb_state_nxt = cmd_s2_3_0_eb_state;
    case(cmd_s2_3_0_eb_state)
      5'h14 : begin
        if(cmd_s2_3_0_req) begin
          cmd_s2_3_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s2_3_0_req) && cmd_s2_3_0_m_ack)) begin
          cmd_s2_3_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s2_3_0_req && (! cmd_s2_3_0_m_ack))) begin
          cmd_s2_3_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s2_3_0_req && cmd_s2_3_0_m_ack)) begin
          cmd_s2_3_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s2_3_0_m_ack) begin
          cmd_s2_3_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s2_3_0_req) && cmd_s2_3_0_m_ack)) begin
          cmd_s2_3_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s2_3_0_req && (! cmd_s2_3_0_m_ack))) begin
          cmd_s2_3_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s2_3_0_req && cmd_s2_3_0_m_ack)) begin
          cmd_s2_3_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s2_3_0_m_ack) begin
          cmd_s2_3_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s2_3_0_eb_en0 = (cmd_s2_3_0_eb_state[2] && cmd_s2_3_0_req);
  assign cmd_s2_3_0_eb_en1 = (cmd_s2_3_0_eb_state[1] && cmd_s2_3_0_req);
  assign cmd_s2_3_0_eb_sel = cmd_s2_3_0_eb_state[0];
  assign cmd_s2_3_0_ack = cmd_s2_3_0_eb_state[4];
  assign cmd_s2_3_0_m_req = cmd_s2_3_0_eb_state[3];
  assign cmd_s2_3_0 = (cmd_s2_3_0_eb_sel ? cmd_s2_3_0_eb_r1 : cmd_s2_3_0_eb_r0);
  assign cmd_s2_3_0_to_cmd_s3_6_req = (cmd_s2_3_0_m_req && (! cmd_s2_3_0_fork_ack_r_0));
  assign cmd_s2_3_0_fork_ack_s_0 = (cmd_s2_3_0_to_cmd_s3_6_ack || (! cmd_s2_3_0_to_cmd_s3_6_req));
  assign cmd_s2_3_0_to_cmd_s3_7_req = (cmd_s2_3_0_m_req && (! cmd_s2_3_0_fork_ack_r_1));
  assign cmd_s2_3_0_fork_ack_s_1 = (cmd_s2_3_0_to_cmd_s3_7_ack || (! cmd_s2_3_0_to_cmd_s3_7_req));
  assign cmd_s2_3_0_m_ack = (cmd_s2_3_0_fork_ack_s_0 && cmd_s2_3_0_fork_ack_s_1);
  always @(*) begin
    cmd_s3_0_0_eb_state_nxt = cmd_s3_0_0_eb_state;
    case(cmd_s3_0_0_eb_state)
      5'h14 : begin
        if(cmd_s3_0_0_req) begin
          cmd_s3_0_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s3_0_0_req) && cmd_s3_0_0_m_ack)) begin
          cmd_s3_0_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_0_0_req && (! cmd_s3_0_0_m_ack))) begin
          cmd_s3_0_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s3_0_0_req && cmd_s3_0_0_m_ack)) begin
          cmd_s3_0_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s3_0_0_m_ack) begin
          cmd_s3_0_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s3_0_0_req) && cmd_s3_0_0_m_ack)) begin
          cmd_s3_0_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_0_0_req && (! cmd_s3_0_0_m_ack))) begin
          cmd_s3_0_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s3_0_0_req && cmd_s3_0_0_m_ack)) begin
          cmd_s3_0_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s3_0_0_m_ack) begin
          cmd_s3_0_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s3_0_0_eb_en0 = (cmd_s3_0_0_eb_state[2] && cmd_s3_0_0_req);
  assign cmd_s3_0_0_eb_en1 = (cmd_s3_0_0_eb_state[1] && cmd_s3_0_0_req);
  assign cmd_s3_0_0_eb_sel = cmd_s3_0_0_eb_state[0];
  assign cmd_s3_0_0_ack = cmd_s3_0_0_eb_state[4];
  assign cmd_s3_0_0_m_req = cmd_s3_0_0_eb_state[3];
  assign cmd_s3_0_0 = (cmd_s3_0_0_eb_sel ? cmd_s3_0_0_eb_r1 : cmd_s3_0_0_eb_r0);
  assign cmd_s3_0_0_to_cmd_lane_0_req = (cmd_s3_0_0_m_req && (! cmd_s3_0_0_fork_ack_r_0));
  assign cmd_s3_0_0_fork_ack_s_0 = (cmd_s3_0_0_to_cmd_lane_0_ack || (! cmd_s3_0_0_to_cmd_lane_0_req));
  assign cmd_s3_0_0_to_cmd_lane_1_req = (cmd_s3_0_0_m_req && (! cmd_s3_0_0_fork_ack_r_1));
  assign cmd_s3_0_0_fork_ack_s_1 = (cmd_s3_0_0_to_cmd_lane_1_ack || (! cmd_s3_0_0_to_cmd_lane_1_req));
  assign cmd_s3_0_0_m_ack = (cmd_s3_0_0_fork_ack_s_0 && cmd_s3_0_0_fork_ack_s_1);
  always @(*) begin
    cmd_lane_0_0_eb_state_nxt = cmd_lane_0_0_eb_state;
    case(cmd_lane_0_0_eb_state)
      5'h14 : begin
        if(cmd_lane_0_0_req) begin
          cmd_lane_0_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_0_0_req) && cmd_lane_0_0_m_ack)) begin
          cmd_lane_0_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_0_0_req && (! cmd_lane_0_0_m_ack))) begin
          cmd_lane_0_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_0_0_req && cmd_lane_0_0_m_ack)) begin
          cmd_lane_0_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_0_0_m_ack) begin
          cmd_lane_0_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_0_0_req) && cmd_lane_0_0_m_ack)) begin
          cmd_lane_0_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_0_0_req && (! cmd_lane_0_0_m_ack))) begin
          cmd_lane_0_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_0_0_req && cmd_lane_0_0_m_ack)) begin
          cmd_lane_0_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_0_0_m_ack) begin
          cmd_lane_0_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_0_0_eb_en0 = (cmd_lane_0_0_eb_state[2] && cmd_lane_0_0_req);
  assign cmd_lane_0_0_eb_en1 = (cmd_lane_0_0_eb_state[1] && cmd_lane_0_0_req);
  assign cmd_lane_0_0_eb_sel = cmd_lane_0_0_eb_state[0];
  assign cmd_lane_0_0_ack = cmd_lane_0_0_eb_state[4];
  assign cmd_lane_0_0_m_req = cmd_lane_0_0_eb_state[3];
  assign cmd_lane_0_0 = (cmd_lane_0_0_eb_sel ? cmd_lane_0_0_eb_r1 : cmd_lane_0_0_eb_r0);
  assign cmd_lane_0_0_to_vector_req = cmd_lane_0_0_m_req;
  assign cmd_lane_0_0_m_ack = cmd_lane_0_0_to_vector_ack;
  always @(*) begin
    cmd_lane_1_0_eb_state_nxt = cmd_lane_1_0_eb_state;
    case(cmd_lane_1_0_eb_state)
      5'h14 : begin
        if(cmd_lane_1_0_req) begin
          cmd_lane_1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_1_0_req) && cmd_lane_1_0_m_ack)) begin
          cmd_lane_1_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_1_0_req && (! cmd_lane_1_0_m_ack))) begin
          cmd_lane_1_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_1_0_req && cmd_lane_1_0_m_ack)) begin
          cmd_lane_1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_1_0_m_ack) begin
          cmd_lane_1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_1_0_req) && cmd_lane_1_0_m_ack)) begin
          cmd_lane_1_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_1_0_req && (! cmd_lane_1_0_m_ack))) begin
          cmd_lane_1_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_1_0_req && cmd_lane_1_0_m_ack)) begin
          cmd_lane_1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_1_0_m_ack) begin
          cmd_lane_1_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_1_0_eb_en0 = (cmd_lane_1_0_eb_state[2] && cmd_lane_1_0_req);
  assign cmd_lane_1_0_eb_en1 = (cmd_lane_1_0_eb_state[1] && cmd_lane_1_0_req);
  assign cmd_lane_1_0_eb_sel = cmd_lane_1_0_eb_state[0];
  assign cmd_lane_1_0_ack = cmd_lane_1_0_eb_state[4];
  assign cmd_lane_1_0_m_req = cmd_lane_1_0_eb_state[3];
  assign cmd_lane_1_0 = (cmd_lane_1_0_eb_sel ? cmd_lane_1_0_eb_r1 : cmd_lane_1_0_eb_r0);
  assign cmd_lane_1_0_to_vector_req = cmd_lane_1_0_m_req;
  assign cmd_lane_1_0_m_ack = cmd_lane_1_0_to_vector_ack;
  always @(*) begin
    cmd_s3_1_0_eb_state_nxt = cmd_s3_1_0_eb_state;
    case(cmd_s3_1_0_eb_state)
      5'h14 : begin
        if(cmd_s3_1_0_req) begin
          cmd_s3_1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s3_1_0_req) && cmd_s3_1_0_m_ack)) begin
          cmd_s3_1_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_1_0_req && (! cmd_s3_1_0_m_ack))) begin
          cmd_s3_1_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s3_1_0_req && cmd_s3_1_0_m_ack)) begin
          cmd_s3_1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s3_1_0_m_ack) begin
          cmd_s3_1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s3_1_0_req) && cmd_s3_1_0_m_ack)) begin
          cmd_s3_1_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_1_0_req && (! cmd_s3_1_0_m_ack))) begin
          cmd_s3_1_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s3_1_0_req && cmd_s3_1_0_m_ack)) begin
          cmd_s3_1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s3_1_0_m_ack) begin
          cmd_s3_1_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s3_1_0_eb_en0 = (cmd_s3_1_0_eb_state[2] && cmd_s3_1_0_req);
  assign cmd_s3_1_0_eb_en1 = (cmd_s3_1_0_eb_state[1] && cmd_s3_1_0_req);
  assign cmd_s3_1_0_eb_sel = cmd_s3_1_0_eb_state[0];
  assign cmd_s3_1_0_ack = cmd_s3_1_0_eb_state[4];
  assign cmd_s3_1_0_m_req = cmd_s3_1_0_eb_state[3];
  assign cmd_s3_1_0 = (cmd_s3_1_0_eb_sel ? cmd_s3_1_0_eb_r1 : cmd_s3_1_0_eb_r0);
  assign cmd_s3_1_0_to_cmd_lane_2_req = (cmd_s3_1_0_m_req && (! cmd_s3_1_0_fork_ack_r_0));
  assign cmd_s3_1_0_fork_ack_s_0 = (cmd_s3_1_0_to_cmd_lane_2_ack || (! cmd_s3_1_0_to_cmd_lane_2_req));
  assign cmd_s3_1_0_to_cmd_lane_3_req = (cmd_s3_1_0_m_req && (! cmd_s3_1_0_fork_ack_r_1));
  assign cmd_s3_1_0_fork_ack_s_1 = (cmd_s3_1_0_to_cmd_lane_3_ack || (! cmd_s3_1_0_to_cmd_lane_3_req));
  assign cmd_s3_1_0_m_ack = (cmd_s3_1_0_fork_ack_s_0 && cmd_s3_1_0_fork_ack_s_1);
  always @(*) begin
    cmd_lane_2_0_eb_state_nxt = cmd_lane_2_0_eb_state;
    case(cmd_lane_2_0_eb_state)
      5'h14 : begin
        if(cmd_lane_2_0_req) begin
          cmd_lane_2_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_2_0_req) && cmd_lane_2_0_m_ack)) begin
          cmd_lane_2_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_2_0_req && (! cmd_lane_2_0_m_ack))) begin
          cmd_lane_2_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_2_0_req && cmd_lane_2_0_m_ack)) begin
          cmd_lane_2_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_2_0_m_ack) begin
          cmd_lane_2_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_2_0_req) && cmd_lane_2_0_m_ack)) begin
          cmd_lane_2_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_2_0_req && (! cmd_lane_2_0_m_ack))) begin
          cmd_lane_2_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_2_0_req && cmd_lane_2_0_m_ack)) begin
          cmd_lane_2_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_2_0_m_ack) begin
          cmd_lane_2_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_2_0_eb_en0 = (cmd_lane_2_0_eb_state[2] && cmd_lane_2_0_req);
  assign cmd_lane_2_0_eb_en1 = (cmd_lane_2_0_eb_state[1] && cmd_lane_2_0_req);
  assign cmd_lane_2_0_eb_sel = cmd_lane_2_0_eb_state[0];
  assign cmd_lane_2_0_ack = cmd_lane_2_0_eb_state[4];
  assign cmd_lane_2_0_m_req = cmd_lane_2_0_eb_state[3];
  assign cmd_lane_2_0 = (cmd_lane_2_0_eb_sel ? cmd_lane_2_0_eb_r1 : cmd_lane_2_0_eb_r0);
  assign cmd_lane_2_0_to_vector_req = cmd_lane_2_0_m_req;
  assign cmd_lane_2_0_m_ack = cmd_lane_2_0_to_vector_ack;
  always @(*) begin
    cmd_lane_3_0_eb_state_nxt = cmd_lane_3_0_eb_state;
    case(cmd_lane_3_0_eb_state)
      5'h14 : begin
        if(cmd_lane_3_0_req) begin
          cmd_lane_3_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_3_0_req) && cmd_lane_3_0_m_ack)) begin
          cmd_lane_3_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_3_0_req && (! cmd_lane_3_0_m_ack))) begin
          cmd_lane_3_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_3_0_req && cmd_lane_3_0_m_ack)) begin
          cmd_lane_3_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_3_0_m_ack) begin
          cmd_lane_3_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_3_0_req) && cmd_lane_3_0_m_ack)) begin
          cmd_lane_3_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_3_0_req && (! cmd_lane_3_0_m_ack))) begin
          cmd_lane_3_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_3_0_req && cmd_lane_3_0_m_ack)) begin
          cmd_lane_3_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_3_0_m_ack) begin
          cmd_lane_3_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_3_0_eb_en0 = (cmd_lane_3_0_eb_state[2] && cmd_lane_3_0_req);
  assign cmd_lane_3_0_eb_en1 = (cmd_lane_3_0_eb_state[1] && cmd_lane_3_0_req);
  assign cmd_lane_3_0_eb_sel = cmd_lane_3_0_eb_state[0];
  assign cmd_lane_3_0_ack = cmd_lane_3_0_eb_state[4];
  assign cmd_lane_3_0_m_req = cmd_lane_3_0_eb_state[3];
  assign cmd_lane_3_0 = (cmd_lane_3_0_eb_sel ? cmd_lane_3_0_eb_r1 : cmd_lane_3_0_eb_r0);
  assign cmd_lane_3_0_to_vector_req = cmd_lane_3_0_m_req;
  assign cmd_lane_3_0_m_ack = cmd_lane_3_0_to_vector_ack;
  always @(*) begin
    cmd_s3_2_0_eb_state_nxt = cmd_s3_2_0_eb_state;
    case(cmd_s3_2_0_eb_state)
      5'h14 : begin
        if(cmd_s3_2_0_req) begin
          cmd_s3_2_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s3_2_0_req) && cmd_s3_2_0_m_ack)) begin
          cmd_s3_2_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_2_0_req && (! cmd_s3_2_0_m_ack))) begin
          cmd_s3_2_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s3_2_0_req && cmd_s3_2_0_m_ack)) begin
          cmd_s3_2_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s3_2_0_m_ack) begin
          cmd_s3_2_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s3_2_0_req) && cmd_s3_2_0_m_ack)) begin
          cmd_s3_2_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_2_0_req && (! cmd_s3_2_0_m_ack))) begin
          cmd_s3_2_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s3_2_0_req && cmd_s3_2_0_m_ack)) begin
          cmd_s3_2_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s3_2_0_m_ack) begin
          cmd_s3_2_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s3_2_0_eb_en0 = (cmd_s3_2_0_eb_state[2] && cmd_s3_2_0_req);
  assign cmd_s3_2_0_eb_en1 = (cmd_s3_2_0_eb_state[1] && cmd_s3_2_0_req);
  assign cmd_s3_2_0_eb_sel = cmd_s3_2_0_eb_state[0];
  assign cmd_s3_2_0_ack = cmd_s3_2_0_eb_state[4];
  assign cmd_s3_2_0_m_req = cmd_s3_2_0_eb_state[3];
  assign cmd_s3_2_0 = (cmd_s3_2_0_eb_sel ? cmd_s3_2_0_eb_r1 : cmd_s3_2_0_eb_r0);
  assign cmd_s3_2_0_to_cmd_lane_4_req = (cmd_s3_2_0_m_req && (! cmd_s3_2_0_fork_ack_r_0));
  assign cmd_s3_2_0_fork_ack_s_0 = (cmd_s3_2_0_to_cmd_lane_4_ack || (! cmd_s3_2_0_to_cmd_lane_4_req));
  assign cmd_s3_2_0_to_cmd_lane_5_req = (cmd_s3_2_0_m_req && (! cmd_s3_2_0_fork_ack_r_1));
  assign cmd_s3_2_0_fork_ack_s_1 = (cmd_s3_2_0_to_cmd_lane_5_ack || (! cmd_s3_2_0_to_cmd_lane_5_req));
  assign cmd_s3_2_0_m_ack = (cmd_s3_2_0_fork_ack_s_0 && cmd_s3_2_0_fork_ack_s_1);
  always @(*) begin
    cmd_lane_4_0_eb_state_nxt = cmd_lane_4_0_eb_state;
    case(cmd_lane_4_0_eb_state)
      5'h14 : begin
        if(cmd_lane_4_0_req) begin
          cmd_lane_4_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_4_0_req) && cmd_lane_4_0_m_ack)) begin
          cmd_lane_4_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_4_0_req && (! cmd_lane_4_0_m_ack))) begin
          cmd_lane_4_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_4_0_req && cmd_lane_4_0_m_ack)) begin
          cmd_lane_4_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_4_0_m_ack) begin
          cmd_lane_4_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_4_0_req) && cmd_lane_4_0_m_ack)) begin
          cmd_lane_4_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_4_0_req && (! cmd_lane_4_0_m_ack))) begin
          cmd_lane_4_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_4_0_req && cmd_lane_4_0_m_ack)) begin
          cmd_lane_4_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_4_0_m_ack) begin
          cmd_lane_4_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_4_0_eb_en0 = (cmd_lane_4_0_eb_state[2] && cmd_lane_4_0_req);
  assign cmd_lane_4_0_eb_en1 = (cmd_lane_4_0_eb_state[1] && cmd_lane_4_0_req);
  assign cmd_lane_4_0_eb_sel = cmd_lane_4_0_eb_state[0];
  assign cmd_lane_4_0_ack = cmd_lane_4_0_eb_state[4];
  assign cmd_lane_4_0_m_req = cmd_lane_4_0_eb_state[3];
  assign cmd_lane_4_0 = (cmd_lane_4_0_eb_sel ? cmd_lane_4_0_eb_r1 : cmd_lane_4_0_eb_r0);
  assign cmd_lane_4_0_to_vector_req = cmd_lane_4_0_m_req;
  assign cmd_lane_4_0_m_ack = cmd_lane_4_0_to_vector_ack;
  always @(*) begin
    cmd_lane_5_0_eb_state_nxt = cmd_lane_5_0_eb_state;
    case(cmd_lane_5_0_eb_state)
      5'h14 : begin
        if(cmd_lane_5_0_req) begin
          cmd_lane_5_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_5_0_req) && cmd_lane_5_0_m_ack)) begin
          cmd_lane_5_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_5_0_req && (! cmd_lane_5_0_m_ack))) begin
          cmd_lane_5_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_5_0_req && cmd_lane_5_0_m_ack)) begin
          cmd_lane_5_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_5_0_m_ack) begin
          cmd_lane_5_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_5_0_req) && cmd_lane_5_0_m_ack)) begin
          cmd_lane_5_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_5_0_req && (! cmd_lane_5_0_m_ack))) begin
          cmd_lane_5_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_5_0_req && cmd_lane_5_0_m_ack)) begin
          cmd_lane_5_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_5_0_m_ack) begin
          cmd_lane_5_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_5_0_eb_en0 = (cmd_lane_5_0_eb_state[2] && cmd_lane_5_0_req);
  assign cmd_lane_5_0_eb_en1 = (cmd_lane_5_0_eb_state[1] && cmd_lane_5_0_req);
  assign cmd_lane_5_0_eb_sel = cmd_lane_5_0_eb_state[0];
  assign cmd_lane_5_0_ack = cmd_lane_5_0_eb_state[4];
  assign cmd_lane_5_0_m_req = cmd_lane_5_0_eb_state[3];
  assign cmd_lane_5_0 = (cmd_lane_5_0_eb_sel ? cmd_lane_5_0_eb_r1 : cmd_lane_5_0_eb_r0);
  assign cmd_lane_5_0_to_vector_req = cmd_lane_5_0_m_req;
  assign cmd_lane_5_0_m_ack = cmd_lane_5_0_to_vector_ack;
  always @(*) begin
    cmd_s3_3_0_eb_state_nxt = cmd_s3_3_0_eb_state;
    case(cmd_s3_3_0_eb_state)
      5'h14 : begin
        if(cmd_s3_3_0_req) begin
          cmd_s3_3_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s3_3_0_req) && cmd_s3_3_0_m_ack)) begin
          cmd_s3_3_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_3_0_req && (! cmd_s3_3_0_m_ack))) begin
          cmd_s3_3_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s3_3_0_req && cmd_s3_3_0_m_ack)) begin
          cmd_s3_3_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s3_3_0_m_ack) begin
          cmd_s3_3_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s3_3_0_req) && cmd_s3_3_0_m_ack)) begin
          cmd_s3_3_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_3_0_req && (! cmd_s3_3_0_m_ack))) begin
          cmd_s3_3_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s3_3_0_req && cmd_s3_3_0_m_ack)) begin
          cmd_s3_3_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s3_3_0_m_ack) begin
          cmd_s3_3_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s3_3_0_eb_en0 = (cmd_s3_3_0_eb_state[2] && cmd_s3_3_0_req);
  assign cmd_s3_3_0_eb_en1 = (cmd_s3_3_0_eb_state[1] && cmd_s3_3_0_req);
  assign cmd_s3_3_0_eb_sel = cmd_s3_3_0_eb_state[0];
  assign cmd_s3_3_0_ack = cmd_s3_3_0_eb_state[4];
  assign cmd_s3_3_0_m_req = cmd_s3_3_0_eb_state[3];
  assign cmd_s3_3_0 = (cmd_s3_3_0_eb_sel ? cmd_s3_3_0_eb_r1 : cmd_s3_3_0_eb_r0);
  assign cmd_s3_3_0_to_cmd_lane_6_req = (cmd_s3_3_0_m_req && (! cmd_s3_3_0_fork_ack_r_0));
  assign cmd_s3_3_0_fork_ack_s_0 = (cmd_s3_3_0_to_cmd_lane_6_ack || (! cmd_s3_3_0_to_cmd_lane_6_req));
  assign cmd_s3_3_0_to_cmd_lane_7_req = (cmd_s3_3_0_m_req && (! cmd_s3_3_0_fork_ack_r_1));
  assign cmd_s3_3_0_fork_ack_s_1 = (cmd_s3_3_0_to_cmd_lane_7_ack || (! cmd_s3_3_0_to_cmd_lane_7_req));
  assign cmd_s3_3_0_m_ack = (cmd_s3_3_0_fork_ack_s_0 && cmd_s3_3_0_fork_ack_s_1);
  always @(*) begin
    cmd_lane_6_0_eb_state_nxt = cmd_lane_6_0_eb_state;
    case(cmd_lane_6_0_eb_state)
      5'h14 : begin
        if(cmd_lane_6_0_req) begin
          cmd_lane_6_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_6_0_req) && cmd_lane_6_0_m_ack)) begin
          cmd_lane_6_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_6_0_req && (! cmd_lane_6_0_m_ack))) begin
          cmd_lane_6_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_6_0_req && cmd_lane_6_0_m_ack)) begin
          cmd_lane_6_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_6_0_m_ack) begin
          cmd_lane_6_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_6_0_req) && cmd_lane_6_0_m_ack)) begin
          cmd_lane_6_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_6_0_req && (! cmd_lane_6_0_m_ack))) begin
          cmd_lane_6_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_6_0_req && cmd_lane_6_0_m_ack)) begin
          cmd_lane_6_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_6_0_m_ack) begin
          cmd_lane_6_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_6_0_eb_en0 = (cmd_lane_6_0_eb_state[2] && cmd_lane_6_0_req);
  assign cmd_lane_6_0_eb_en1 = (cmd_lane_6_0_eb_state[1] && cmd_lane_6_0_req);
  assign cmd_lane_6_0_eb_sel = cmd_lane_6_0_eb_state[0];
  assign cmd_lane_6_0_ack = cmd_lane_6_0_eb_state[4];
  assign cmd_lane_6_0_m_req = cmd_lane_6_0_eb_state[3];
  assign cmd_lane_6_0 = (cmd_lane_6_0_eb_sel ? cmd_lane_6_0_eb_r1 : cmd_lane_6_0_eb_r0);
  assign cmd_lane_6_0_to_vector_req = cmd_lane_6_0_m_req;
  assign cmd_lane_6_0_m_ack = cmd_lane_6_0_to_vector_ack;
  always @(*) begin
    cmd_lane_7_0_eb_state_nxt = cmd_lane_7_0_eb_state;
    case(cmd_lane_7_0_eb_state)
      5'h14 : begin
        if(cmd_lane_7_0_req) begin
          cmd_lane_7_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_7_0_req) && cmd_lane_7_0_m_ack)) begin
          cmd_lane_7_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_7_0_req && (! cmd_lane_7_0_m_ack))) begin
          cmd_lane_7_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_7_0_req && cmd_lane_7_0_m_ack)) begin
          cmd_lane_7_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_7_0_m_ack) begin
          cmd_lane_7_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_7_0_req) && cmd_lane_7_0_m_ack)) begin
          cmd_lane_7_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_7_0_req && (! cmd_lane_7_0_m_ack))) begin
          cmd_lane_7_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_7_0_req && cmd_lane_7_0_m_ack)) begin
          cmd_lane_7_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_7_0_m_ack) begin
          cmd_lane_7_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_7_0_eb_en0 = (cmd_lane_7_0_eb_state[2] && cmd_lane_7_0_req);
  assign cmd_lane_7_0_eb_en1 = (cmd_lane_7_0_eb_state[1] && cmd_lane_7_0_req);
  assign cmd_lane_7_0_eb_sel = cmd_lane_7_0_eb_state[0];
  assign cmd_lane_7_0_ack = cmd_lane_7_0_eb_state[4];
  assign cmd_lane_7_0_m_req = cmd_lane_7_0_eb_state[3];
  assign cmd_lane_7_0 = (cmd_lane_7_0_eb_sel ? cmd_lane_7_0_eb_r1 : cmd_lane_7_0_eb_r0);
  assign cmd_lane_7_0_to_vector_req = cmd_lane_7_0_m_req;
  assign cmd_lane_7_0_m_ack = cmd_lane_7_0_to_vector_ack;
  always @(*) begin
    cmd_s3_4_0_eb_state_nxt = cmd_s3_4_0_eb_state;
    case(cmd_s3_4_0_eb_state)
      5'h14 : begin
        if(cmd_s3_4_0_req) begin
          cmd_s3_4_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s3_4_0_req) && cmd_s3_4_0_m_ack)) begin
          cmd_s3_4_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_4_0_req && (! cmd_s3_4_0_m_ack))) begin
          cmd_s3_4_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s3_4_0_req && cmd_s3_4_0_m_ack)) begin
          cmd_s3_4_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s3_4_0_m_ack) begin
          cmd_s3_4_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s3_4_0_req) && cmd_s3_4_0_m_ack)) begin
          cmd_s3_4_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_4_0_req && (! cmd_s3_4_0_m_ack))) begin
          cmd_s3_4_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s3_4_0_req && cmd_s3_4_0_m_ack)) begin
          cmd_s3_4_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s3_4_0_m_ack) begin
          cmd_s3_4_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s3_4_0_eb_en0 = (cmd_s3_4_0_eb_state[2] && cmd_s3_4_0_req);
  assign cmd_s3_4_0_eb_en1 = (cmd_s3_4_0_eb_state[1] && cmd_s3_4_0_req);
  assign cmd_s3_4_0_eb_sel = cmd_s3_4_0_eb_state[0];
  assign cmd_s3_4_0_ack = cmd_s3_4_0_eb_state[4];
  assign cmd_s3_4_0_m_req = cmd_s3_4_0_eb_state[3];
  assign cmd_s3_4_0 = (cmd_s3_4_0_eb_sel ? cmd_s3_4_0_eb_r1 : cmd_s3_4_0_eb_r0);
  assign cmd_s3_4_0_to_cmd_lane_8_req = (cmd_s3_4_0_m_req && (! cmd_s3_4_0_fork_ack_r_0));
  assign cmd_s3_4_0_fork_ack_s_0 = (cmd_s3_4_0_to_cmd_lane_8_ack || (! cmd_s3_4_0_to_cmd_lane_8_req));
  assign cmd_s3_4_0_to_cmd_lane_9_req = (cmd_s3_4_0_m_req && (! cmd_s3_4_0_fork_ack_r_1));
  assign cmd_s3_4_0_fork_ack_s_1 = (cmd_s3_4_0_to_cmd_lane_9_ack || (! cmd_s3_4_0_to_cmd_lane_9_req));
  assign cmd_s3_4_0_m_ack = (cmd_s3_4_0_fork_ack_s_0 && cmd_s3_4_0_fork_ack_s_1);
  always @(*) begin
    cmd_lane_8_0_eb_state_nxt = cmd_lane_8_0_eb_state;
    case(cmd_lane_8_0_eb_state)
      5'h14 : begin
        if(cmd_lane_8_0_req) begin
          cmd_lane_8_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_8_0_req) && cmd_lane_8_0_m_ack)) begin
          cmd_lane_8_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_8_0_req && (! cmd_lane_8_0_m_ack))) begin
          cmd_lane_8_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_8_0_req && cmd_lane_8_0_m_ack)) begin
          cmd_lane_8_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_8_0_m_ack) begin
          cmd_lane_8_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_8_0_req) && cmd_lane_8_0_m_ack)) begin
          cmd_lane_8_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_8_0_req && (! cmd_lane_8_0_m_ack))) begin
          cmd_lane_8_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_8_0_req && cmd_lane_8_0_m_ack)) begin
          cmd_lane_8_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_8_0_m_ack) begin
          cmd_lane_8_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_8_0_eb_en0 = (cmd_lane_8_0_eb_state[2] && cmd_lane_8_0_req);
  assign cmd_lane_8_0_eb_en1 = (cmd_lane_8_0_eb_state[1] && cmd_lane_8_0_req);
  assign cmd_lane_8_0_eb_sel = cmd_lane_8_0_eb_state[0];
  assign cmd_lane_8_0_ack = cmd_lane_8_0_eb_state[4];
  assign cmd_lane_8_0_m_req = cmd_lane_8_0_eb_state[3];
  assign cmd_lane_8_0 = (cmd_lane_8_0_eb_sel ? cmd_lane_8_0_eb_r1 : cmd_lane_8_0_eb_r0);
  assign cmd_lane_8_0_to_vector_req = cmd_lane_8_0_m_req;
  assign cmd_lane_8_0_m_ack = cmd_lane_8_0_to_vector_ack;
  always @(*) begin
    cmd_lane_9_0_eb_state_nxt = cmd_lane_9_0_eb_state;
    case(cmd_lane_9_0_eb_state)
      5'h14 : begin
        if(cmd_lane_9_0_req) begin
          cmd_lane_9_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_9_0_req) && cmd_lane_9_0_m_ack)) begin
          cmd_lane_9_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_9_0_req && (! cmd_lane_9_0_m_ack))) begin
          cmd_lane_9_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_9_0_req && cmd_lane_9_0_m_ack)) begin
          cmd_lane_9_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_9_0_m_ack) begin
          cmd_lane_9_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_9_0_req) && cmd_lane_9_0_m_ack)) begin
          cmd_lane_9_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_9_0_req && (! cmd_lane_9_0_m_ack))) begin
          cmd_lane_9_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_9_0_req && cmd_lane_9_0_m_ack)) begin
          cmd_lane_9_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_9_0_m_ack) begin
          cmd_lane_9_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_9_0_eb_en0 = (cmd_lane_9_0_eb_state[2] && cmd_lane_9_0_req);
  assign cmd_lane_9_0_eb_en1 = (cmd_lane_9_0_eb_state[1] && cmd_lane_9_0_req);
  assign cmd_lane_9_0_eb_sel = cmd_lane_9_0_eb_state[0];
  assign cmd_lane_9_0_ack = cmd_lane_9_0_eb_state[4];
  assign cmd_lane_9_0_m_req = cmd_lane_9_0_eb_state[3];
  assign cmd_lane_9_0 = (cmd_lane_9_0_eb_sel ? cmd_lane_9_0_eb_r1 : cmd_lane_9_0_eb_r0);
  assign cmd_lane_9_0_to_vector_req = cmd_lane_9_0_m_req;
  assign cmd_lane_9_0_m_ack = cmd_lane_9_0_to_vector_ack;
  always @(*) begin
    cmd_s3_5_0_eb_state_nxt = cmd_s3_5_0_eb_state;
    case(cmd_s3_5_0_eb_state)
      5'h14 : begin
        if(cmd_s3_5_0_req) begin
          cmd_s3_5_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s3_5_0_req) && cmd_s3_5_0_m_ack)) begin
          cmd_s3_5_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_5_0_req && (! cmd_s3_5_0_m_ack))) begin
          cmd_s3_5_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s3_5_0_req && cmd_s3_5_0_m_ack)) begin
          cmd_s3_5_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s3_5_0_m_ack) begin
          cmd_s3_5_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s3_5_0_req) && cmd_s3_5_0_m_ack)) begin
          cmd_s3_5_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_5_0_req && (! cmd_s3_5_0_m_ack))) begin
          cmd_s3_5_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s3_5_0_req && cmd_s3_5_0_m_ack)) begin
          cmd_s3_5_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s3_5_0_m_ack) begin
          cmd_s3_5_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s3_5_0_eb_en0 = (cmd_s3_5_0_eb_state[2] && cmd_s3_5_0_req);
  assign cmd_s3_5_0_eb_en1 = (cmd_s3_5_0_eb_state[1] && cmd_s3_5_0_req);
  assign cmd_s3_5_0_eb_sel = cmd_s3_5_0_eb_state[0];
  assign cmd_s3_5_0_ack = cmd_s3_5_0_eb_state[4];
  assign cmd_s3_5_0_m_req = cmd_s3_5_0_eb_state[3];
  assign cmd_s3_5_0 = (cmd_s3_5_0_eb_sel ? cmd_s3_5_0_eb_r1 : cmd_s3_5_0_eb_r0);
  assign cmd_s3_5_0_to_cmd_lane_10_req = (cmd_s3_5_0_m_req && (! cmd_s3_5_0_fork_ack_r_0));
  assign cmd_s3_5_0_fork_ack_s_0 = (cmd_s3_5_0_to_cmd_lane_10_ack || (! cmd_s3_5_0_to_cmd_lane_10_req));
  assign cmd_s3_5_0_to_cmd_lane_11_req = (cmd_s3_5_0_m_req && (! cmd_s3_5_0_fork_ack_r_1));
  assign cmd_s3_5_0_fork_ack_s_1 = (cmd_s3_5_0_to_cmd_lane_11_ack || (! cmd_s3_5_0_to_cmd_lane_11_req));
  assign cmd_s3_5_0_m_ack = (cmd_s3_5_0_fork_ack_s_0 && cmd_s3_5_0_fork_ack_s_1);
  always @(*) begin
    cmd_lane_10_0_eb_state_nxt = cmd_lane_10_0_eb_state;
    case(cmd_lane_10_0_eb_state)
      5'h14 : begin
        if(cmd_lane_10_0_req) begin
          cmd_lane_10_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_10_0_req) && cmd_lane_10_0_m_ack)) begin
          cmd_lane_10_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_10_0_req && (! cmd_lane_10_0_m_ack))) begin
          cmd_lane_10_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_10_0_req && cmd_lane_10_0_m_ack)) begin
          cmd_lane_10_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_10_0_m_ack) begin
          cmd_lane_10_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_10_0_req) && cmd_lane_10_0_m_ack)) begin
          cmd_lane_10_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_10_0_req && (! cmd_lane_10_0_m_ack))) begin
          cmd_lane_10_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_10_0_req && cmd_lane_10_0_m_ack)) begin
          cmd_lane_10_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_10_0_m_ack) begin
          cmd_lane_10_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_10_0_eb_en0 = (cmd_lane_10_0_eb_state[2] && cmd_lane_10_0_req);
  assign cmd_lane_10_0_eb_en1 = (cmd_lane_10_0_eb_state[1] && cmd_lane_10_0_req);
  assign cmd_lane_10_0_eb_sel = cmd_lane_10_0_eb_state[0];
  assign cmd_lane_10_0_ack = cmd_lane_10_0_eb_state[4];
  assign cmd_lane_10_0_m_req = cmd_lane_10_0_eb_state[3];
  assign cmd_lane_10_0 = (cmd_lane_10_0_eb_sel ? cmd_lane_10_0_eb_r1 : cmd_lane_10_0_eb_r0);
  assign cmd_lane_10_0_to_vector_req = cmd_lane_10_0_m_req;
  assign cmd_lane_10_0_m_ack = cmd_lane_10_0_to_vector_ack;
  always @(*) begin
    cmd_lane_11_0_eb_state_nxt = cmd_lane_11_0_eb_state;
    case(cmd_lane_11_0_eb_state)
      5'h14 : begin
        if(cmd_lane_11_0_req) begin
          cmd_lane_11_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_11_0_req) && cmd_lane_11_0_m_ack)) begin
          cmd_lane_11_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_11_0_req && (! cmd_lane_11_0_m_ack))) begin
          cmd_lane_11_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_11_0_req && cmd_lane_11_0_m_ack)) begin
          cmd_lane_11_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_11_0_m_ack) begin
          cmd_lane_11_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_11_0_req) && cmd_lane_11_0_m_ack)) begin
          cmd_lane_11_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_11_0_req && (! cmd_lane_11_0_m_ack))) begin
          cmd_lane_11_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_11_0_req && cmd_lane_11_0_m_ack)) begin
          cmd_lane_11_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_11_0_m_ack) begin
          cmd_lane_11_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_11_0_eb_en0 = (cmd_lane_11_0_eb_state[2] && cmd_lane_11_0_req);
  assign cmd_lane_11_0_eb_en1 = (cmd_lane_11_0_eb_state[1] && cmd_lane_11_0_req);
  assign cmd_lane_11_0_eb_sel = cmd_lane_11_0_eb_state[0];
  assign cmd_lane_11_0_ack = cmd_lane_11_0_eb_state[4];
  assign cmd_lane_11_0_m_req = cmd_lane_11_0_eb_state[3];
  assign cmd_lane_11_0 = (cmd_lane_11_0_eb_sel ? cmd_lane_11_0_eb_r1 : cmd_lane_11_0_eb_r0);
  assign cmd_lane_11_0_to_vector_req = cmd_lane_11_0_m_req;
  assign cmd_lane_11_0_m_ack = cmd_lane_11_0_to_vector_ack;
  always @(*) begin
    cmd_s3_6_0_eb_state_nxt = cmd_s3_6_0_eb_state;
    case(cmd_s3_6_0_eb_state)
      5'h14 : begin
        if(cmd_s3_6_0_req) begin
          cmd_s3_6_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s3_6_0_req) && cmd_s3_6_0_m_ack)) begin
          cmd_s3_6_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_6_0_req && (! cmd_s3_6_0_m_ack))) begin
          cmd_s3_6_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s3_6_0_req && cmd_s3_6_0_m_ack)) begin
          cmd_s3_6_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s3_6_0_m_ack) begin
          cmd_s3_6_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s3_6_0_req) && cmd_s3_6_0_m_ack)) begin
          cmd_s3_6_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_6_0_req && (! cmd_s3_6_0_m_ack))) begin
          cmd_s3_6_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s3_6_0_req && cmd_s3_6_0_m_ack)) begin
          cmd_s3_6_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s3_6_0_m_ack) begin
          cmd_s3_6_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s3_6_0_eb_en0 = (cmd_s3_6_0_eb_state[2] && cmd_s3_6_0_req);
  assign cmd_s3_6_0_eb_en1 = (cmd_s3_6_0_eb_state[1] && cmd_s3_6_0_req);
  assign cmd_s3_6_0_eb_sel = cmd_s3_6_0_eb_state[0];
  assign cmd_s3_6_0_ack = cmd_s3_6_0_eb_state[4];
  assign cmd_s3_6_0_m_req = cmd_s3_6_0_eb_state[3];
  assign cmd_s3_6_0 = (cmd_s3_6_0_eb_sel ? cmd_s3_6_0_eb_r1 : cmd_s3_6_0_eb_r0);
  assign cmd_s3_6_0_to_cmd_lane_12_req = (cmd_s3_6_0_m_req && (! cmd_s3_6_0_fork_ack_r_0));
  assign cmd_s3_6_0_fork_ack_s_0 = (cmd_s3_6_0_to_cmd_lane_12_ack || (! cmd_s3_6_0_to_cmd_lane_12_req));
  assign cmd_s3_6_0_to_cmd_lane_13_req = (cmd_s3_6_0_m_req && (! cmd_s3_6_0_fork_ack_r_1));
  assign cmd_s3_6_0_fork_ack_s_1 = (cmd_s3_6_0_to_cmd_lane_13_ack || (! cmd_s3_6_0_to_cmd_lane_13_req));
  assign cmd_s3_6_0_m_ack = (cmd_s3_6_0_fork_ack_s_0 && cmd_s3_6_0_fork_ack_s_1);
  always @(*) begin
    cmd_lane_12_0_eb_state_nxt = cmd_lane_12_0_eb_state;
    case(cmd_lane_12_0_eb_state)
      5'h14 : begin
        if(cmd_lane_12_0_req) begin
          cmd_lane_12_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_12_0_req) && cmd_lane_12_0_m_ack)) begin
          cmd_lane_12_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_12_0_req && (! cmd_lane_12_0_m_ack))) begin
          cmd_lane_12_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_12_0_req && cmd_lane_12_0_m_ack)) begin
          cmd_lane_12_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_12_0_m_ack) begin
          cmd_lane_12_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_12_0_req) && cmd_lane_12_0_m_ack)) begin
          cmd_lane_12_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_12_0_req && (! cmd_lane_12_0_m_ack))) begin
          cmd_lane_12_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_12_0_req && cmd_lane_12_0_m_ack)) begin
          cmd_lane_12_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_12_0_m_ack) begin
          cmd_lane_12_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_12_0_eb_en0 = (cmd_lane_12_0_eb_state[2] && cmd_lane_12_0_req);
  assign cmd_lane_12_0_eb_en1 = (cmd_lane_12_0_eb_state[1] && cmd_lane_12_0_req);
  assign cmd_lane_12_0_eb_sel = cmd_lane_12_0_eb_state[0];
  assign cmd_lane_12_0_ack = cmd_lane_12_0_eb_state[4];
  assign cmd_lane_12_0_m_req = cmd_lane_12_0_eb_state[3];
  assign cmd_lane_12_0 = (cmd_lane_12_0_eb_sel ? cmd_lane_12_0_eb_r1 : cmd_lane_12_0_eb_r0);
  assign cmd_lane_12_0_to_vector_req = cmd_lane_12_0_m_req;
  assign cmd_lane_12_0_m_ack = cmd_lane_12_0_to_vector_ack;
  always @(*) begin
    cmd_lane_13_0_eb_state_nxt = cmd_lane_13_0_eb_state;
    case(cmd_lane_13_0_eb_state)
      5'h14 : begin
        if(cmd_lane_13_0_req) begin
          cmd_lane_13_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_13_0_req) && cmd_lane_13_0_m_ack)) begin
          cmd_lane_13_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_13_0_req && (! cmd_lane_13_0_m_ack))) begin
          cmd_lane_13_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_13_0_req && cmd_lane_13_0_m_ack)) begin
          cmd_lane_13_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_13_0_m_ack) begin
          cmd_lane_13_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_13_0_req) && cmd_lane_13_0_m_ack)) begin
          cmd_lane_13_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_13_0_req && (! cmd_lane_13_0_m_ack))) begin
          cmd_lane_13_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_13_0_req && cmd_lane_13_0_m_ack)) begin
          cmd_lane_13_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_13_0_m_ack) begin
          cmd_lane_13_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_13_0_eb_en0 = (cmd_lane_13_0_eb_state[2] && cmd_lane_13_0_req);
  assign cmd_lane_13_0_eb_en1 = (cmd_lane_13_0_eb_state[1] && cmd_lane_13_0_req);
  assign cmd_lane_13_0_eb_sel = cmd_lane_13_0_eb_state[0];
  assign cmd_lane_13_0_ack = cmd_lane_13_0_eb_state[4];
  assign cmd_lane_13_0_m_req = cmd_lane_13_0_eb_state[3];
  assign cmd_lane_13_0 = (cmd_lane_13_0_eb_sel ? cmd_lane_13_0_eb_r1 : cmd_lane_13_0_eb_r0);
  assign cmd_lane_13_0_to_vector_req = cmd_lane_13_0_m_req;
  assign cmd_lane_13_0_m_ack = cmd_lane_13_0_to_vector_ack;
  always @(*) begin
    cmd_s3_7_0_eb_state_nxt = cmd_s3_7_0_eb_state;
    case(cmd_s3_7_0_eb_state)
      5'h14 : begin
        if(cmd_s3_7_0_req) begin
          cmd_s3_7_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_s3_7_0_req) && cmd_s3_7_0_m_ack)) begin
          cmd_s3_7_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_7_0_req && (! cmd_s3_7_0_m_ack))) begin
          cmd_s3_7_0_eb_state_nxt = 5'h08;
        end
        if((cmd_s3_7_0_req && cmd_s3_7_0_m_ack)) begin
          cmd_s3_7_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_s3_7_0_m_ack) begin
          cmd_s3_7_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_s3_7_0_req) && cmd_s3_7_0_m_ack)) begin
          cmd_s3_7_0_eb_state_nxt = 5'h14;
        end
        if((cmd_s3_7_0_req && (! cmd_s3_7_0_m_ack))) begin
          cmd_s3_7_0_eb_state_nxt = 5'h09;
        end
        if((cmd_s3_7_0_req && cmd_s3_7_0_m_ack)) begin
          cmd_s3_7_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_s3_7_0_m_ack) begin
          cmd_s3_7_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_s3_7_0_eb_en0 = (cmd_s3_7_0_eb_state[2] && cmd_s3_7_0_req);
  assign cmd_s3_7_0_eb_en1 = (cmd_s3_7_0_eb_state[1] && cmd_s3_7_0_req);
  assign cmd_s3_7_0_eb_sel = cmd_s3_7_0_eb_state[0];
  assign cmd_s3_7_0_ack = cmd_s3_7_0_eb_state[4];
  assign cmd_s3_7_0_m_req = cmd_s3_7_0_eb_state[3];
  assign cmd_s3_7_0 = (cmd_s3_7_0_eb_sel ? cmd_s3_7_0_eb_r1 : cmd_s3_7_0_eb_r0);
  assign cmd_s3_7_0_to_cmd_lane_14_req = (cmd_s3_7_0_m_req && (! cmd_s3_7_0_fork_ack_r_0));
  assign cmd_s3_7_0_fork_ack_s_0 = (cmd_s3_7_0_to_cmd_lane_14_ack || (! cmd_s3_7_0_to_cmd_lane_14_req));
  assign cmd_s3_7_0_to_cmd_lane_15_req = (cmd_s3_7_0_m_req && (! cmd_s3_7_0_fork_ack_r_1));
  assign cmd_s3_7_0_fork_ack_s_1 = (cmd_s3_7_0_to_cmd_lane_15_ack || (! cmd_s3_7_0_to_cmd_lane_15_req));
  assign cmd_s3_7_0_m_ack = (cmd_s3_7_0_fork_ack_s_0 && cmd_s3_7_0_fork_ack_s_1);
  always @(*) begin
    cmd_lane_14_0_eb_state_nxt = cmd_lane_14_0_eb_state;
    case(cmd_lane_14_0_eb_state)
      5'h14 : begin
        if(cmd_lane_14_0_req) begin
          cmd_lane_14_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_14_0_req) && cmd_lane_14_0_m_ack)) begin
          cmd_lane_14_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_14_0_req && (! cmd_lane_14_0_m_ack))) begin
          cmd_lane_14_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_14_0_req && cmd_lane_14_0_m_ack)) begin
          cmd_lane_14_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_14_0_m_ack) begin
          cmd_lane_14_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_14_0_req) && cmd_lane_14_0_m_ack)) begin
          cmd_lane_14_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_14_0_req && (! cmd_lane_14_0_m_ack))) begin
          cmd_lane_14_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_14_0_req && cmd_lane_14_0_m_ack)) begin
          cmd_lane_14_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_14_0_m_ack) begin
          cmd_lane_14_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_14_0_eb_en0 = (cmd_lane_14_0_eb_state[2] && cmd_lane_14_0_req);
  assign cmd_lane_14_0_eb_en1 = (cmd_lane_14_0_eb_state[1] && cmd_lane_14_0_req);
  assign cmd_lane_14_0_eb_sel = cmd_lane_14_0_eb_state[0];
  assign cmd_lane_14_0_ack = cmd_lane_14_0_eb_state[4];
  assign cmd_lane_14_0_m_req = cmd_lane_14_0_eb_state[3];
  assign cmd_lane_14_0 = (cmd_lane_14_0_eb_sel ? cmd_lane_14_0_eb_r1 : cmd_lane_14_0_eb_r0);
  assign cmd_lane_14_0_to_vector_req = cmd_lane_14_0_m_req;
  assign cmd_lane_14_0_m_ack = cmd_lane_14_0_to_vector_ack;
  always @(*) begin
    cmd_lane_15_0_eb_state_nxt = cmd_lane_15_0_eb_state;
    case(cmd_lane_15_0_eb_state)
      5'h14 : begin
        if(cmd_lane_15_0_req) begin
          cmd_lane_15_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! cmd_lane_15_0_req) && cmd_lane_15_0_m_ack)) begin
          cmd_lane_15_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_15_0_req && (! cmd_lane_15_0_m_ack))) begin
          cmd_lane_15_0_eb_state_nxt = 5'h08;
        end
        if((cmd_lane_15_0_req && cmd_lane_15_0_m_ack)) begin
          cmd_lane_15_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(cmd_lane_15_0_m_ack) begin
          cmd_lane_15_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! cmd_lane_15_0_req) && cmd_lane_15_0_m_ack)) begin
          cmd_lane_15_0_eb_state_nxt = 5'h14;
        end
        if((cmd_lane_15_0_req && (! cmd_lane_15_0_m_ack))) begin
          cmd_lane_15_0_eb_state_nxt = 5'h09;
        end
        if((cmd_lane_15_0_req && cmd_lane_15_0_m_ack)) begin
          cmd_lane_15_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(cmd_lane_15_0_m_ack) begin
          cmd_lane_15_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign cmd_lane_15_0_eb_en0 = (cmd_lane_15_0_eb_state[2] && cmd_lane_15_0_req);
  assign cmd_lane_15_0_eb_en1 = (cmd_lane_15_0_eb_state[1] && cmd_lane_15_0_req);
  assign cmd_lane_15_0_eb_sel = cmd_lane_15_0_eb_state[0];
  assign cmd_lane_15_0_ack = cmd_lane_15_0_eb_state[4];
  assign cmd_lane_15_0_m_req = cmd_lane_15_0_eb_state[3];
  assign cmd_lane_15_0 = (cmd_lane_15_0_eb_sel ? cmd_lane_15_0_eb_r1 : cmd_lane_15_0_eb_r0);
  assign cmd_lane_15_0_to_vector_req = cmd_lane_15_0_m_req;
  assign cmd_lane_15_0_m_ack = cmd_lane_15_0_to_vector_ack;
  always @(*) begin
    vector_k15_eb_state_nxt = vector_k15_eb_state;
    case(vector_k15_eb_state)
      5'h14 : begin
        if(vector_k15_req) begin
          vector_k15_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! vector_k15_req) && vector_k15_m_ack)) begin
          vector_k15_eb_state_nxt = 5'h14;
        end
        if((vector_k15_req && (! vector_k15_m_ack))) begin
          vector_k15_eb_state_nxt = 5'h08;
        end
        if((vector_k15_req && vector_k15_m_ack)) begin
          vector_k15_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(vector_k15_m_ack) begin
          vector_k15_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! vector_k15_req) && vector_k15_m_ack)) begin
          vector_k15_eb_state_nxt = 5'h14;
        end
        if((vector_k15_req && (! vector_k15_m_ack))) begin
          vector_k15_eb_state_nxt = 5'h09;
        end
        if((vector_k15_req && vector_k15_m_ack)) begin
          vector_k15_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(vector_k15_m_ack) begin
          vector_k15_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign vector_k15_eb_en0 = (vector_k15_eb_state[2] && vector_k15_req);
  assign vector_k15_eb_en1 = (vector_k15_eb_state[1] && vector_k15_req);
  assign vector_k15_eb_sel = vector_k15_eb_state[0];
  assign vector_k15_ack = vector_k15_eb_state[4];
  assign vector_k15_m_req = vector_k15_eb_state[3];
  assign vector_k15 = (vector_k15_eb_sel ? vector_k15_eb_r1 : vector_k15_eb_r0);
  assign vector_k15_to_inmux_req = vector_k15_m_req;
  assign vector_k15_m_ack = vector_k15_to_inmux_ack;
  assign inmux_inmux_ack = ((! inmux_inmux_eb_valid) || inmux_inmux_m_ack);
  assign inmux_inmux_eb_en = (inmux_inmux_req && inmux_inmux_ack);
  assign inmux_inmux_m_req = inmux_inmux_eb_valid;
  assign inmux_inmux = inmux_inmux_eb_r;
  assign inmux_inmux_to_iperm_data_req = inmux_inmux_m_req;
  assign inmux_inmux_m_ack = inmux_inmux_to_iperm_data_ack;
  assign iperm_data_data_ack = ((! iperm_data_data_eb_valid) || iperm_data_data_m_ack);
  assign iperm_data_data_eb_en = (iperm_data_data_req && iperm_data_data_ack);
  assign iperm_data_data_m_req = iperm_data_data_eb_valid;
  assign iperm_data_data = iperm_data_data_eb_r;
  assign iperm_data_data_to_vmem_req = iperm_data_data_m_req;
  assign iperm_data_data_m_ack = iperm_data_data_to_vmem_ack;
  assign vmem_ovs_m_req = vmem_ovs_req;
  assign vmem_ovs_ack = vmem_ovs_m_ack;
  assign vmem_ovs_to_vmem_ovs_req = vmem_ovs_m_req;
  assign vmem_ovs_m_ack = vmem_ovs_to_vmem_ovs_ack;
  assign vmem_ovs_0_ack = ((! vmem_ovs_0_eb_valid) || vmem_ovs_0_m_ack);
  assign vmem_ovs_0_eb_en = (vmem_ovs_0_req && vmem_ovs_0_ack);
  assign vmem_ovs_0_m_req = vmem_ovs_0_eb_valid;
  assign vmem_ovs_0 = vmem_ovs_0_eb_r;
  assign vmem_ovs_0_to_operm_data_req = vmem_ovs_0_m_req;
  assign vmem_ovs_0_m_ack = vmem_ovs_0_to_operm_data_ack;
  always @(*) begin
    operm_data_data_eb_state_nxt = operm_data_data_eb_state;
    case(operm_data_data_eb_state)
      5'h14 : begin
        if(operm_data_data_req) begin
          operm_data_data_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! operm_data_data_req) && operm_data_data_m_ack)) begin
          operm_data_data_eb_state_nxt = 5'h14;
        end
        if((operm_data_data_req && (! operm_data_data_m_ack))) begin
          operm_data_data_eb_state_nxt = 5'h08;
        end
        if((operm_data_data_req && operm_data_data_m_ack)) begin
          operm_data_data_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(operm_data_data_m_ack) begin
          operm_data_data_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! operm_data_data_req) && operm_data_data_m_ack)) begin
          operm_data_data_eb_state_nxt = 5'h14;
        end
        if((operm_data_data_req && (! operm_data_data_m_ack))) begin
          operm_data_data_eb_state_nxt = 5'h09;
        end
        if((operm_data_data_req && operm_data_data_m_ack)) begin
          operm_data_data_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(operm_data_data_m_ack) begin
          operm_data_data_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign operm_data_data_eb_en0 = (operm_data_data_eb_state[2] && operm_data_data_req);
  assign operm_data_data_eb_en1 = (operm_data_data_eb_state[1] && operm_data_data_req);
  assign operm_data_data_eb_sel = operm_data_data_eb_state[0];
  assign operm_data_data_ack = operm_data_data_eb_state[4];
  assign operm_data_data_m_req = operm_data_data_eb_state[3];
  assign operm_data_data = (operm_data_data_eb_sel ? operm_data_data_eb_r1 : operm_data_data_eb_r0);
  assign operm_data_data_to_oumux_req = operm_data_data_m_req;
  assign operm_data_data_m_ack = operm_data_data_to_oumux_ack;
  always @(*) begin
    oumux_k15_eb_state_nxt = oumux_k15_eb_state;
    case(oumux_k15_eb_state)
      5'h14 : begin
        if(oumux_k15_req) begin
          oumux_k15_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! oumux_k15_req) && oumux_k15_m_ack)) begin
          oumux_k15_eb_state_nxt = 5'h14;
        end
        if((oumux_k15_req && (! oumux_k15_m_ack))) begin
          oumux_k15_eb_state_nxt = 5'h08;
        end
        if((oumux_k15_req && oumux_k15_m_ack)) begin
          oumux_k15_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(oumux_k15_m_ack) begin
          oumux_k15_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! oumux_k15_req) && oumux_k15_m_ack)) begin
          oumux_k15_eb_state_nxt = 5'h14;
        end
        if((oumux_k15_req && (! oumux_k15_m_ack))) begin
          oumux_k15_eb_state_nxt = 5'h09;
        end
        if((oumux_k15_req && oumux_k15_m_ack)) begin
          oumux_k15_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(oumux_k15_m_ack) begin
          oumux_k15_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign oumux_k15_eb_en0 = (oumux_k15_eb_state[2] && oumux_k15_req);
  assign oumux_k15_eb_en1 = (oumux_k15_eb_state[1] && oumux_k15_req);
  assign oumux_k15_eb_sel = oumux_k15_eb_state[0];
  assign oumux_k15_ack = oumux_k15_eb_state[4];
  assign oumux_k15_m_req = oumux_k15_eb_state[3];
  assign oumux_k15 = (oumux_k15_eb_sel ? oumux_k15_eb_r1 : oumux_k15_eb_r0);
  assign oumux_k15_to_vector_req = oumux_k15_m_req;
  assign oumux_k15_m_ack = oumux_k15_to_vector_ack;
  always @(*) begin
    oumux_k8_eb_state_nxt = oumux_k8_eb_state;
    case(oumux_k8_eb_state)
      5'h14 : begin
        if(oumux_k8_req) begin
          oumux_k8_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! oumux_k8_req) && oumux_k8_m_ack)) begin
          oumux_k8_eb_state_nxt = 5'h14;
        end
        if((oumux_k8_req && (! oumux_k8_m_ack))) begin
          oumux_k8_eb_state_nxt = 5'h08;
        end
        if((oumux_k8_req && oumux_k8_m_ack)) begin
          oumux_k8_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(oumux_k8_m_ack) begin
          oumux_k8_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! oumux_k8_req) && oumux_k8_m_ack)) begin
          oumux_k8_eb_state_nxt = 5'h14;
        end
        if((oumux_k8_req && (! oumux_k8_m_ack))) begin
          oumux_k8_eb_state_nxt = 5'h09;
        end
        if((oumux_k8_req && oumux_k8_m_ack)) begin
          oumux_k8_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(oumux_k8_m_ack) begin
          oumux_k8_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign oumux_k8_eb_en0 = (oumux_k8_eb_state[2] && oumux_k8_req);
  assign oumux_k8_eb_en1 = (oumux_k8_eb_state[1] && oumux_k8_req);
  assign oumux_k8_eb_sel = oumux_k8_eb_state[0];
  assign oumux_k8_ack = oumux_k8_eb_state[4];
  assign oumux_k8_m_req = oumux_k8_eb_state[3];
  assign oumux_k8 = (oumux_k8_eb_sel ? oumux_k8_eb_r1 : oumux_k8_eb_r0);
  assign oumux_k8_to_dp_req = oumux_k8_m_req;
  assign oumux_k8_m_ack = oumux_k8_to_dp_ack;
  always @(*) begin
    oumux_k9_eb_state_nxt = oumux_k9_eb_state;
    case(oumux_k9_eb_state)
      5'h14 : begin
        if(oumux_k9_req) begin
          oumux_k9_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! oumux_k9_req) && oumux_k9_m_ack)) begin
          oumux_k9_eb_state_nxt = 5'h14;
        end
        if((oumux_k9_req && (! oumux_k9_m_ack))) begin
          oumux_k9_eb_state_nxt = 5'h08;
        end
        if((oumux_k9_req && oumux_k9_m_ack)) begin
          oumux_k9_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(oumux_k9_m_ack) begin
          oumux_k9_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! oumux_k9_req) && oumux_k9_m_ack)) begin
          oumux_k9_eb_state_nxt = 5'h14;
        end
        if((oumux_k9_req && (! oumux_k9_m_ack))) begin
          oumux_k9_eb_state_nxt = 5'h09;
        end
        if((oumux_k9_req && oumux_k9_m_ack)) begin
          oumux_k9_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(oumux_k9_m_ack) begin
          oumux_k9_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign oumux_k9_eb_en0 = (oumux_k9_eb_state[2] && oumux_k9_req);
  assign oumux_k9_eb_en1 = (oumux_k9_eb_state[1] && oumux_k9_req);
  assign oumux_k9_eb_sel = oumux_k9_eb_state[0];
  assign oumux_k9_ack = oumux_k9_eb_state[4];
  assign oumux_k9_m_req = oumux_k9_eb_state[3];
  assign oumux_k9 = (oumux_k9_eb_sel ? oumux_k9_eb_r1 : oumux_k9_eb_r0);
  assign oumux_k9_to_dp_req = oumux_k9_m_req;
  assign oumux_k9_m_ack = oumux_k9_to_dp_ack;
  assign oumux_k14_ack = ((! oumux_k14_eb_valid) || oumux_k14_m_ack);
  assign oumux_k14_eb_en = (oumux_k14_req && oumux_k14_ack);
  assign oumux_k14_m_req = oumux_k14_eb_valid;
  assign oumux_k14 = oumux_k14_eb_r;
  assign oumux_k14_to_dp_req = oumux_k14_m_req;
  assign oumux_k14_m_ack = oumux_k14_to_dp_ack;
  assign _zz_oumux_k13_ack = 2'b11;
  assign oumux_k13_ack = (! (oumux_k13_eb_cnt == _zz_oumux_k13_ack));
  assign oumux_k13_eb_ren = 1'b1;
  assign oumux_k13_eb_wen = (oumux_k13_req && oumux_k13_ack);
  assign _zz_oumux_k13_eb_rd_ptr = (oumux_k13_eb_valid && oumux_k13_m_ack);
  assign _zz_oumux_k13_eb_q_rd_ptr = (((oumux_k13_eb_q_rd_ptr == _zz_oumux_k13_ack) && (oumux_k13_eb_cnt != 2'b00)) ? 2'b00 : _zz__zz_oumux_k13_eb_q_rd_ptr);
  assign oumux_k13_eb_rd_ptr = (_zz_oumux_k13_eb_rd_ptr ? _zz_oumux_k13_eb_q_rd_ptr : oumux_k13_eb_q_rd_ptr);
  assign oumux_k13_m_req = oumux_k13_eb_valid;
  assign oumux_k13_eb_r0 = oumux_k13_eb_mem_spinal_port1;
  assign oumux_k13 = oumux_k13_eb_r0;
  assign oumux_k13_to_inmux_req = oumux_k13_m_req;
  assign oumux_k13_m_ack = oumux_k13_to_inmux_ack;
  assign dp_k1_m_req = dp_k1_req;
  assign dp_k1_ack = dp_k1_m_ack;
  assign dp_k1_to_inmux_req = dp_k1_m_req;
  assign dp_k1_m_ack = dp_k1_to_inmux_ack;
  always @(*) begin
    vector_kap_eb_state_nxt = vector_kap_eb_state;
    case(vector_kap_eb_state)
      5'h14 : begin
        if(vector_kap_req) begin
          vector_kap_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! vector_kap_req) && vector_kap_m_ack)) begin
          vector_kap_eb_state_nxt = 5'h14;
        end
        if((vector_kap_req && (! vector_kap_m_ack))) begin
          vector_kap_eb_state_nxt = 5'h08;
        end
        if((vector_kap_req && vector_kap_m_ack)) begin
          vector_kap_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(vector_kap_m_ack) begin
          vector_kap_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! vector_kap_req) && vector_kap_m_ack)) begin
          vector_kap_eb_state_nxt = 5'h14;
        end
        if((vector_kap_req && (! vector_kap_m_ack))) begin
          vector_kap_eb_state_nxt = 5'h09;
        end
        if((vector_kap_req && vector_kap_m_ack)) begin
          vector_kap_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(vector_kap_m_ack) begin
          vector_kap_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign vector_kap_eb_en0 = (vector_kap_eb_state[2] && vector_kap_req);
  assign vector_kap_eb_en1 = (vector_kap_eb_state[1] && vector_kap_req);
  assign vector_kap_eb_sel = vector_kap_eb_state[0];
  assign vector_kap_ack = vector_kap_eb_state[4];
  assign vector_kap_m_req = vector_kap_eb_state[3];
  assign vector_kap = (vector_kap_eb_sel ? vector_kap_eb_r1 : vector_kap_eb_r0);
  assign vector_kap_to_kap_deconcat_req = vector_kap_m_req;
  assign vector_kap_m_ack = vector_kap_to_kap_deconcat_ack;
  assign kap_deconcat_0_ack = ((! kap_deconcat_0_eb_valid) || kap_deconcat_0_m_ack);
  assign kap_deconcat_0_eb_en = (kap_deconcat_0_req && kap_deconcat_0_ack);
  assign kap_deconcat_0_m_req = kap_deconcat_0_eb_valid;
  assign kap_deconcat_0 = kap_deconcat_0_eb_r;
  assign kap_deconcat_0_to_perm_full_addr_req = kap_deconcat_0_m_req;
  assign kap_deconcat_0_m_ack = kap_deconcat_0_to_perm_full_addr_ack;
  assign kap_deconcat_1_ack = ((! kap_deconcat_1_eb_valid) || kap_deconcat_1_m_ack);
  assign kap_deconcat_1_eb_en = (kap_deconcat_1_req && kap_deconcat_1_ack);
  assign kap_deconcat_1_m_req = kap_deconcat_1_eb_valid;
  assign kap_deconcat_1 = kap_deconcat_1_eb_r;
  assign kap_deconcat_1_to_ka_decode_req = kap_deconcat_1_m_req;
  assign kap_deconcat_1_m_ack = kap_deconcat_1_to_ka_decode_ack;
  assign _zz_ka_decode_ka_ack = 2'b11;
  assign ka_decode_ka_ack = (! (ka_decode_ka_eb_cnt == _zz_ka_decode_ka_ack));
  assign ka_decode_ka_eb_ren = 1'b1;
  assign ka_decode_ka_eb_wen = (ka_decode_ka_req && ka_decode_ka_ack);
  assign _zz_ka_decode_ka_eb_rd_ptr = (ka_decode_ka_eb_valid && ka_decode_ka_m_ack);
  assign _zz_ka_decode_ka_eb_q_rd_ptr = (((ka_decode_ka_eb_q_rd_ptr == _zz_ka_decode_ka_ack) && (ka_decode_ka_eb_cnt != 2'b00)) ? 2'b00 : _zz__zz_ka_decode_ka_eb_q_rd_ptr);
  assign ka_decode_ka_eb_rd_ptr = (_zz_ka_decode_ka_eb_rd_ptr ? _zz_ka_decode_ka_eb_q_rd_ptr : ka_decode_ka_eb_q_rd_ptr);
  assign ka_decode_ka_m_req = ka_decode_ka_eb_valid;
  assign ka_decode_ka_eb_r0 = ka_decode_ka_eb_mem_spinal_port1;
  assign ka_decode_ka = ka_decode_ka_eb_r0;
  assign ka_decode_ka_to_vmem_req = ka_decode_ka_m_req;
  assign ka_decode_ka_m_ack = ka_decode_ka_to_vmem_ack;
  assign _zz_ka_decode_k_sk_ack = 1'b1;
  assign ka_decode_k_sk_ack = (! (ka_decode_k_sk_eb_cnt == _zz_ka_decode_k_sk_ack));
  assign ka_decode_k_sk_eb_ren = 1'b1;
  assign ka_decode_k_sk_eb_wen = (ka_decode_k_sk_req && ka_decode_k_sk_ack);
  assign _zz_ka_decode_k_sk_eb_rd_ptr = (ka_decode_k_sk_eb_valid && ka_decode_k_sk_m_ack);
  assign _zz_ka_decode_k_sk_eb_q_rd_ptr = (((ka_decode_k_sk_eb_q_rd_ptr == _zz_ka_decode_k_sk_ack) && (ka_decode_k_sk_eb_cnt != 1'b0)) ? 1'b0 : _zz__zz_ka_decode_k_sk_eb_q_rd_ptr);
  assign ka_decode_k_sk_eb_rd_ptr = (_zz_ka_decode_k_sk_eb_rd_ptr ? _zz_ka_decode_k_sk_eb_q_rd_ptr : ka_decode_k_sk_eb_q_rd_ptr);
  assign ka_decode_k_sk_m_req = ka_decode_k_sk_eb_valid;
  assign ka_decode_k_sk_eb_r0 = ka_decode_k_sk_eb_mem_spinal_port1;
  assign ka_decode_k_sk = ka_decode_k_sk_eb_r0;
  assign ka_decode_k_sk_to_inmux_req = ka_decode_k_sk_m_req;
  assign ka_decode_k_sk_m_ack = ka_decode_k_sk_to_inmux_ack;
  assign perm_full_addr_0_ack = ((! perm_full_addr_0_eb_valid) || perm_full_addr_0_m_ack);
  assign perm_full_addr_0_eb_en = (perm_full_addr_0_req && perm_full_addr_0_ack);
  assign perm_full_addr_0_m_req = perm_full_addr_0_eb_valid;
  assign perm_full_addr_0 = perm_full_addr_0_eb_r;
  assign perm_full_addr_0_to_p_decode_req = perm_full_addr_0_m_req;
  assign perm_full_addr_0_m_ack = perm_full_addr_0_to_p_decode_ack;
  assign _zz_ka_decode_k_lk_ack = 2'b11;
  assign ka_decode_k_lk_ack = (! (ka_decode_k_lk_eb_cnt == _zz_ka_decode_k_lk_ack));
  assign ka_decode_k_lk_eb_ren = 1'b1;
  assign ka_decode_k_lk_eb_wen = (ka_decode_k_lk_req && ka_decode_k_lk_ack);
  assign _zz_ka_decode_k_lk_eb_rd_ptr = (ka_decode_k_lk_eb_valid && ka_decode_k_lk_m_ack);
  assign _zz_ka_decode_k_lk_eb_q_rd_ptr = (((ka_decode_k_lk_eb_q_rd_ptr == _zz_ka_decode_k_lk_ack) && (ka_decode_k_lk_eb_cnt != 2'b00)) ? 2'b00 : _zz__zz_ka_decode_k_lk_eb_q_rd_ptr);
  assign ka_decode_k_lk_eb_rd_ptr = (_zz_ka_decode_k_lk_eb_rd_ptr ? _zz_ka_decode_k_lk_eb_q_rd_ptr : ka_decode_k_lk_eb_q_rd_ptr);
  assign ka_decode_k_lk_m_req = ka_decode_k_lk_eb_valid;
  assign ka_decode_k_lk_eb_r0 = ka_decode_k_lk_eb_mem_spinal_port1;
  assign ka_decode_k_lk = ka_decode_k_lk_eb_r0;
  assign ka_decode_k_lk_to_oumux_req = ka_decode_k_lk_m_req;
  assign ka_decode_k_lk_m_ack = ka_decode_k_lk_to_oumux_ack;
  assign _zz_p_decode_p_sk_ack = 2'b10;
  assign p_decode_p_sk_ack = (! (p_decode_p_sk_eb_cnt == _zz_p_decode_p_sk_ack));
  assign p_decode_p_sk_eb_ren = 1'b1;
  assign p_decode_p_sk_eb_wen = (p_decode_p_sk_req && p_decode_p_sk_ack);
  assign _zz_p_decode_p_sk_eb_rd_ptr = (p_decode_p_sk_eb_valid && p_decode_p_sk_m_ack);
  assign _zz_p_decode_p_sk_eb_q_rd_ptr = (((p_decode_p_sk_eb_q_rd_ptr == _zz_p_decode_p_sk_ack) && (p_decode_p_sk_eb_cnt != 2'b00)) ? 2'b00 : _zz__zz_p_decode_p_sk_eb_q_rd_ptr);
  assign p_decode_p_sk_eb_rd_ptr = (_zz_p_decode_p_sk_eb_rd_ptr ? _zz_p_decode_p_sk_eb_q_rd_ptr : p_decode_p_sk_eb_q_rd_ptr);
  assign p_decode_p_sk_m_req = p_decode_p_sk_eb_valid;
  assign p_decode_p_sk_eb_r0 = p_decode_p_sk_eb_mem_spinal_port1;
  assign p_decode_p_sk = p_decode_p_sk_eb_r0;
  assign p_decode_p_sk_to_iperm_data_req = p_decode_p_sk_m_req;
  assign p_decode_p_sk_m_ack = p_decode_p_sk_to_iperm_data_ack;
  assign _zz_p_decode_p_lk_ack = 2'b10;
  assign p_decode_p_lk_ack = (! (p_decode_p_lk_eb_cnt == _zz_p_decode_p_lk_ack));
  assign p_decode_p_lk_eb_ren = 1'b1;
  assign p_decode_p_lk_eb_wen = (p_decode_p_lk_req && p_decode_p_lk_ack);
  assign _zz_p_decode_p_lk_eb_rd_ptr = (p_decode_p_lk_eb_valid && p_decode_p_lk_m_ack);
  assign _zz_p_decode_p_lk_eb_q_rd_ptr = (((p_decode_p_lk_eb_q_rd_ptr == _zz_p_decode_p_lk_ack) && (p_decode_p_lk_eb_cnt != 2'b00)) ? 2'b00 : _zz__zz_p_decode_p_lk_eb_q_rd_ptr);
  assign p_decode_p_lk_eb_rd_ptr = (_zz_p_decode_p_lk_eb_rd_ptr ? _zz_p_decode_p_lk_eb_q_rd_ptr : p_decode_p_lk_eb_q_rd_ptr);
  assign p_decode_p_lk_m_req = p_decode_p_lk_eb_valid;
  assign p_decode_p_lk_eb_r0 = p_decode_p_lk_eb_mem_spinal_port1;
  assign p_decode_p_lk = p_decode_p_lk_eb_r0;
  assign p_decode_p_lk_to_operm_data_req = p_decode_p_lk_m_req;
  assign p_decode_p_lk_m_ack = p_decode_p_lk_to_operm_data_ack;
  always @(*) begin
    t_idma_0_idma_0_eb_state_nxt = t_idma_0_idma_0_eb_state;
    case(t_idma_0_idma_0_eb_state)
      5'h14 : begin
        if(t_idma_0_idma_0_req) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! t_idma_0_idma_0_req) && t_idma_0_idma_0_m_ack)) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h14;
        end
        if((t_idma_0_idma_0_req && (! t_idma_0_idma_0_m_ack))) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h08;
        end
        if((t_idma_0_idma_0_req && t_idma_0_idma_0_m_ack)) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(t_idma_0_idma_0_m_ack) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! t_idma_0_idma_0_req) && t_idma_0_idma_0_m_ack)) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h14;
        end
        if((t_idma_0_idma_0_req && (! t_idma_0_idma_0_m_ack))) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h09;
        end
        if((t_idma_0_idma_0_req && t_idma_0_idma_0_m_ack)) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(t_idma_0_idma_0_m_ack) begin
          t_idma_0_idma_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign t_idma_0_idma_0_eb_en0 = (t_idma_0_idma_0_eb_state[2] && t_idma_0_idma_0_req);
  assign t_idma_0_idma_0_eb_en1 = (t_idma_0_idma_0_eb_state[1] && t_idma_0_idma_0_req);
  assign t_idma_0_idma_0_eb_sel = t_idma_0_idma_0_eb_state[0];
  assign t_idma_0_idma_0_ack = t_idma_0_idma_0_eb_state[4];
  assign t_idma_0_idma_0_m_req = t_idma_0_idma_0_eb_state[3];
  assign t_idma_0_idma_0 = (t_idma_0_idma_0_eb_sel ? t_idma_0_idma_0_eb_r1 : t_idma_0_idma_0_eb_r0);
  assign t_idma_0_idma_0_to_vmem_req = t_idma_0_idma_0_m_req;
  assign t_idma_0_idma_0_m_ack = t_idma_0_idma_0_to_vmem_ack;
  always @(*) begin
    t_idma_1_idma_1_eb_state_nxt = t_idma_1_idma_1_eb_state;
    case(t_idma_1_idma_1_eb_state)
      5'h14 : begin
        if(t_idma_1_idma_1_req) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! t_idma_1_idma_1_req) && t_idma_1_idma_1_m_ack)) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h14;
        end
        if((t_idma_1_idma_1_req && (! t_idma_1_idma_1_m_ack))) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h08;
        end
        if((t_idma_1_idma_1_req && t_idma_1_idma_1_m_ack)) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(t_idma_1_idma_1_m_ack) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! t_idma_1_idma_1_req) && t_idma_1_idma_1_m_ack)) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h14;
        end
        if((t_idma_1_idma_1_req && (! t_idma_1_idma_1_m_ack))) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h09;
        end
        if((t_idma_1_idma_1_req && t_idma_1_idma_1_m_ack)) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(t_idma_1_idma_1_m_ack) begin
          t_idma_1_idma_1_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign t_idma_1_idma_1_eb_en0 = (t_idma_1_idma_1_eb_state[2] && t_idma_1_idma_1_req);
  assign t_idma_1_idma_1_eb_en1 = (t_idma_1_idma_1_eb_state[1] && t_idma_1_idma_1_req);
  assign t_idma_1_idma_1_eb_sel = t_idma_1_idma_1_eb_state[0];
  assign t_idma_1_idma_1_ack = t_idma_1_idma_1_eb_state[4];
  assign t_idma_1_idma_1_m_req = t_idma_1_idma_1_eb_state[3];
  assign t_idma_1_idma_1 = (t_idma_1_idma_1_eb_sel ? t_idma_1_idma_1_eb_r1 : t_idma_1_idma_1_eb_r0);
  assign t_idma_1_idma_1_to_idma_1_s1_req = t_idma_1_idma_1_m_req;
  assign t_idma_1_idma_1_m_ack = t_idma_1_idma_1_to_idma_1_s1_ack;
  always @(*) begin
    idma_1_s1_0_eb_state_nxt = idma_1_s1_0_eb_state;
    case(idma_1_s1_0_eb_state)
      5'h14 : begin
        if(idma_1_s1_0_req) begin
          idma_1_s1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! idma_1_s1_0_req) && idma_1_s1_0_m_ack)) begin
          idma_1_s1_0_eb_state_nxt = 5'h14;
        end
        if((idma_1_s1_0_req && (! idma_1_s1_0_m_ack))) begin
          idma_1_s1_0_eb_state_nxt = 5'h08;
        end
        if((idma_1_s1_0_req && idma_1_s1_0_m_ack)) begin
          idma_1_s1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(idma_1_s1_0_m_ack) begin
          idma_1_s1_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! idma_1_s1_0_req) && idma_1_s1_0_m_ack)) begin
          idma_1_s1_0_eb_state_nxt = 5'h14;
        end
        if((idma_1_s1_0_req && (! idma_1_s1_0_m_ack))) begin
          idma_1_s1_0_eb_state_nxt = 5'h09;
        end
        if((idma_1_s1_0_req && idma_1_s1_0_m_ack)) begin
          idma_1_s1_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(idma_1_s1_0_m_ack) begin
          idma_1_s1_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign idma_1_s1_0_eb_en0 = (idma_1_s1_0_eb_state[2] && idma_1_s1_0_req);
  assign idma_1_s1_0_eb_en1 = (idma_1_s1_0_eb_state[1] && idma_1_s1_0_req);
  assign idma_1_s1_0_eb_sel = idma_1_s1_0_eb_state[0];
  assign idma_1_s1_0_ack = idma_1_s1_0_eb_state[4];
  assign idma_1_s1_0_m_req = idma_1_s1_0_eb_state[3];
  assign idma_1_s1_0 = (idma_1_s1_0_eb_sel ? idma_1_s1_0_eb_r1 : idma_1_s1_0_eb_r0);
  assign idma_1_s1_0_to_vmem_req = idma_1_s1_0_m_req;
  assign idma_1_s1_0_m_ack = idma_1_s1_0_to_vmem_ack;
  always @(*) begin
    t_idma_2_idma_2_eb_state_nxt = t_idma_2_idma_2_eb_state;
    case(t_idma_2_idma_2_eb_state)
      5'h14 : begin
        if(t_idma_2_idma_2_req) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! t_idma_2_idma_2_req) && t_idma_2_idma_2_m_ack)) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h14;
        end
        if((t_idma_2_idma_2_req && (! t_idma_2_idma_2_m_ack))) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h08;
        end
        if((t_idma_2_idma_2_req && t_idma_2_idma_2_m_ack)) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(t_idma_2_idma_2_m_ack) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! t_idma_2_idma_2_req) && t_idma_2_idma_2_m_ack)) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h14;
        end
        if((t_idma_2_idma_2_req && (! t_idma_2_idma_2_m_ack))) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h09;
        end
        if((t_idma_2_idma_2_req && t_idma_2_idma_2_m_ack)) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(t_idma_2_idma_2_m_ack) begin
          t_idma_2_idma_2_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign t_idma_2_idma_2_eb_en0 = (t_idma_2_idma_2_eb_state[2] && t_idma_2_idma_2_req);
  assign t_idma_2_idma_2_eb_en1 = (t_idma_2_idma_2_eb_state[1] && t_idma_2_idma_2_req);
  assign t_idma_2_idma_2_eb_sel = t_idma_2_idma_2_eb_state[0];
  assign t_idma_2_idma_2_ack = t_idma_2_idma_2_eb_state[4];
  assign t_idma_2_idma_2_m_req = t_idma_2_idma_2_eb_state[3];
  assign t_idma_2_idma_2 = (t_idma_2_idma_2_eb_sel ? t_idma_2_idma_2_eb_r1 : t_idma_2_idma_2_eb_r0);
  assign t_idma_2_idma_2_to_vmem_req = t_idma_2_idma_2_m_req;
  assign t_idma_2_idma_2_m_ack = t_idma_2_idma_2_to_vmem_ack;
  always @(*) begin
    t_idma_3_idma_3_eb_state_nxt = t_idma_3_idma_3_eb_state;
    case(t_idma_3_idma_3_eb_state)
      5'h14 : begin
        if(t_idma_3_idma_3_req) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! t_idma_3_idma_3_req) && t_idma_3_idma_3_m_ack)) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h14;
        end
        if((t_idma_3_idma_3_req && (! t_idma_3_idma_3_m_ack))) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h08;
        end
        if((t_idma_3_idma_3_req && t_idma_3_idma_3_m_ack)) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(t_idma_3_idma_3_m_ack) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! t_idma_3_idma_3_req) && t_idma_3_idma_3_m_ack)) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h14;
        end
        if((t_idma_3_idma_3_req && (! t_idma_3_idma_3_m_ack))) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h09;
        end
        if((t_idma_3_idma_3_req && t_idma_3_idma_3_m_ack)) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(t_idma_3_idma_3_m_ack) begin
          t_idma_3_idma_3_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign t_idma_3_idma_3_eb_en0 = (t_idma_3_idma_3_eb_state[2] && t_idma_3_idma_3_req);
  assign t_idma_3_idma_3_eb_en1 = (t_idma_3_idma_3_eb_state[1] && t_idma_3_idma_3_req);
  assign t_idma_3_idma_3_eb_sel = t_idma_3_idma_3_eb_state[0];
  assign t_idma_3_idma_3_ack = t_idma_3_idma_3_eb_state[4];
  assign t_idma_3_idma_3_m_req = t_idma_3_idma_3_eb_state[3];
  assign t_idma_3_idma_3 = (t_idma_3_idma_3_eb_sel ? t_idma_3_idma_3_eb_r1 : t_idma_3_idma_3_eb_r0);
  assign t_idma_3_idma_3_to_vmem_req = t_idma_3_idma_3_m_req;
  assign t_idma_3_idma_3_m_ack = t_idma_3_idma_3_to_vmem_ack;
  always @(*) begin
    vmem_odma_0_eb_state_nxt = vmem_odma_0_eb_state;
    case(vmem_odma_0_eb_state)
      7'h48 : begin
        if(vmem_odma_0_req) begin
          vmem_odma_0_eb_state_nxt = 7'h66;
        end
      end
      7'h66 : begin
        if(((! vmem_odma_0_req) && vmem_odma_0_m_ack)) begin
          vmem_odma_0_eb_state_nxt = 7'h48;
        end
        if((vmem_odma_0_req && (! vmem_odma_0_m_ack))) begin
          vmem_odma_0_eb_state_nxt = 7'h35;
        end
      end
      7'h35 : begin
        if(vmem_odma_0_m_ack) begin
          vmem_odma_0_eb_state_nxt = 7'h66;
        end
      end
      default : begin
      end
    endcase
  end

  assign vmem_odma_0_eb_en0 = ((vmem_odma_0_eb_state[4] || vmem_odma_0_req) && (vmem_odma_0_eb_state[3] || vmem_odma_0_m_ack));
  assign vmem_odma_0_eb_en1 = ((vmem_odma_0_eb_state[2] && vmem_odma_0_req) && (vmem_odma_0_eb_state[1] ^ vmem_odma_0_m_ack));
  assign vmem_odma_0_eb_sel = vmem_odma_0_eb_state[0];
  assign vmem_odma_0_ack = vmem_odma_0_eb_state[6];
  assign vmem_odma_0_m_req = vmem_odma_0_eb_state[5];
  assign vmem_odma_0 = vmem_odma_0_eb_r0;
  assign vmem_odma_0_to_i_odma_0_req = vmem_odma_0_m_req;
  assign vmem_odma_0_m_ack = vmem_odma_0_to_i_odma_0_ack;
  always @(*) begin
    vmem_odma_1_eb_state_nxt = vmem_odma_1_eb_state;
    case(vmem_odma_1_eb_state)
      7'h48 : begin
        if(vmem_odma_1_req) begin
          vmem_odma_1_eb_state_nxt = 7'h66;
        end
      end
      7'h66 : begin
        if(((! vmem_odma_1_req) && vmem_odma_1_m_ack)) begin
          vmem_odma_1_eb_state_nxt = 7'h48;
        end
        if((vmem_odma_1_req && (! vmem_odma_1_m_ack))) begin
          vmem_odma_1_eb_state_nxt = 7'h35;
        end
      end
      7'h35 : begin
        if(vmem_odma_1_m_ack) begin
          vmem_odma_1_eb_state_nxt = 7'h66;
        end
      end
      default : begin
      end
    endcase
  end

  assign vmem_odma_1_eb_en0 = ((vmem_odma_1_eb_state[4] || vmem_odma_1_req) && (vmem_odma_1_eb_state[3] || vmem_odma_1_m_ack));
  assign vmem_odma_1_eb_en1 = ((vmem_odma_1_eb_state[2] && vmem_odma_1_req) && (vmem_odma_1_eb_state[1] ^ vmem_odma_1_m_ack));
  assign vmem_odma_1_eb_sel = vmem_odma_1_eb_state[0];
  assign vmem_odma_1_ack = vmem_odma_1_eb_state[6];
  assign vmem_odma_1_m_req = vmem_odma_1_eb_state[5];
  assign vmem_odma_1 = vmem_odma_1_eb_r0;
  assign vmem_odma_1_to_odma_1_s1_req = vmem_odma_1_m_req;
  assign vmem_odma_1_m_ack = vmem_odma_1_to_odma_1_s1_ack;
  assign odma_1_s1_0_ack = ((! odma_1_s1_0_eb_valid) || odma_1_s1_0_m_ack);
  assign odma_1_s1_0_eb_en = (odma_1_s1_0_req && odma_1_s1_0_ack);
  assign odma_1_s1_0_m_req = odma_1_s1_0_eb_valid;
  assign odma_1_s1_0 = odma_1_s1_0_eb_r;
  assign odma_1_s1_0_to_i_odma_1_req = odma_1_s1_0_m_req;
  assign odma_1_s1_0_m_ack = odma_1_s1_0_to_i_odma_1_ack;
  always @(*) begin
    vmem_odma_2_eb_state_nxt = vmem_odma_2_eb_state;
    case(vmem_odma_2_eb_state)
      7'h48 : begin
        if(vmem_odma_2_req) begin
          vmem_odma_2_eb_state_nxt = 7'h66;
        end
      end
      7'h66 : begin
        if(((! vmem_odma_2_req) && vmem_odma_2_m_ack)) begin
          vmem_odma_2_eb_state_nxt = 7'h48;
        end
        if((vmem_odma_2_req && (! vmem_odma_2_m_ack))) begin
          vmem_odma_2_eb_state_nxt = 7'h35;
        end
      end
      7'h35 : begin
        if(vmem_odma_2_m_ack) begin
          vmem_odma_2_eb_state_nxt = 7'h66;
        end
      end
      default : begin
      end
    endcase
  end

  assign vmem_odma_2_eb_en0 = ((vmem_odma_2_eb_state[4] || vmem_odma_2_req) && (vmem_odma_2_eb_state[3] || vmem_odma_2_m_ack));
  assign vmem_odma_2_eb_en1 = ((vmem_odma_2_eb_state[2] && vmem_odma_2_req) && (vmem_odma_2_eb_state[1] ^ vmem_odma_2_m_ack));
  assign vmem_odma_2_eb_sel = vmem_odma_2_eb_state[0];
  assign vmem_odma_2_ack = vmem_odma_2_eb_state[6];
  assign vmem_odma_2_m_req = vmem_odma_2_eb_state[5];
  assign vmem_odma_2 = vmem_odma_2_eb_r0;
  assign vmem_odma_2_to_odma_2_s1_req = vmem_odma_2_m_req;
  assign vmem_odma_2_m_ack = vmem_odma_2_to_odma_2_s1_ack;
  assign odma_2_s1_0_ack = ((! odma_2_s1_0_eb_valid) || odma_2_s1_0_m_ack);
  assign odma_2_s1_0_eb_en = (odma_2_s1_0_req && odma_2_s1_0_ack);
  assign odma_2_s1_0_m_req = odma_2_s1_0_eb_valid;
  assign odma_2_s1_0 = odma_2_s1_0_eb_r;
  assign odma_2_s1_0_to_i_odma_2_req = odma_2_s1_0_m_req;
  assign odma_2_s1_0_m_ack = odma_2_s1_0_to_i_odma_2_ack;
  always @(*) begin
    vmem_odma_3_eb_state_nxt = vmem_odma_3_eb_state;
    case(vmem_odma_3_eb_state)
      7'h48 : begin
        if(vmem_odma_3_req) begin
          vmem_odma_3_eb_state_nxt = 7'h66;
        end
      end
      7'h66 : begin
        if(((! vmem_odma_3_req) && vmem_odma_3_m_ack)) begin
          vmem_odma_3_eb_state_nxt = 7'h48;
        end
        if((vmem_odma_3_req && (! vmem_odma_3_m_ack))) begin
          vmem_odma_3_eb_state_nxt = 7'h35;
        end
      end
      7'h35 : begin
        if(vmem_odma_3_m_ack) begin
          vmem_odma_3_eb_state_nxt = 7'h66;
        end
      end
      default : begin
      end
    endcase
  end

  assign vmem_odma_3_eb_en0 = ((vmem_odma_3_eb_state[4] || vmem_odma_3_req) && (vmem_odma_3_eb_state[3] || vmem_odma_3_m_ack));
  assign vmem_odma_3_eb_en1 = ((vmem_odma_3_eb_state[2] && vmem_odma_3_req) && (vmem_odma_3_eb_state[1] ^ vmem_odma_3_m_ack));
  assign vmem_odma_3_eb_sel = vmem_odma_3_eb_state[0];
  assign vmem_odma_3_ack = vmem_odma_3_eb_state[6];
  assign vmem_odma_3_m_req = vmem_odma_3_eb_state[5];
  assign vmem_odma_3 = vmem_odma_3_eb_r0;
  assign vmem_odma_3_to_i_odma_3_req = vmem_odma_3_m_req;
  assign vmem_odma_3_m_ack = vmem_odma_3_to_i_odma_3_ack;
  always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
      kap_deconcat_i_0_req_reg <= 1'b0;
      kap_deconcat_i_1_req_reg <= 1'b0;
      t_instr_0_eb_state <= 5'h14;
      t_instr_0_fork_ack_r_0 <= 1'b0;
      t_instr_0_fork_ack_r_1 <= 1'b0;
      cmd_s1_0_0_eb_state <= 5'h14;
      cmd_s1_0_0_fork_ack_r_0 <= 1'b0;
      cmd_s1_0_0_fork_ack_r_1 <= 1'b0;
      cmd_s1_1_0_eb_state <= 5'h14;
      cmd_s1_1_0_fork_ack_r_0 <= 1'b0;
      cmd_s1_1_0_fork_ack_r_1 <= 1'b0;
      cmd_s2_0_0_eb_state <= 5'h14;
      cmd_s2_0_0_fork_ack_r_0 <= 1'b0;
      cmd_s2_0_0_fork_ack_r_1 <= 1'b0;
      cmd_s2_1_0_eb_state <= 5'h14;
      cmd_s2_1_0_fork_ack_r_0 <= 1'b0;
      cmd_s2_1_0_fork_ack_r_1 <= 1'b0;
      cmd_s2_2_0_eb_state <= 5'h14;
      cmd_s2_2_0_fork_ack_r_0 <= 1'b0;
      cmd_s2_2_0_fork_ack_r_1 <= 1'b0;
      cmd_s2_3_0_eb_state <= 5'h14;
      cmd_s2_3_0_fork_ack_r_0 <= 1'b0;
      cmd_s2_3_0_fork_ack_r_1 <= 1'b0;
      cmd_s3_0_0_eb_state <= 5'h14;
      cmd_s3_0_0_fork_ack_r_0 <= 1'b0;
      cmd_s3_0_0_fork_ack_r_1 <= 1'b0;
      cmd_lane_0_0_eb_state <= 5'h14;
      cmd_lane_1_0_eb_state <= 5'h14;
      cmd_s3_1_0_eb_state <= 5'h14;
      cmd_s3_1_0_fork_ack_r_0 <= 1'b0;
      cmd_s3_1_0_fork_ack_r_1 <= 1'b0;
      cmd_lane_2_0_eb_state <= 5'h14;
      cmd_lane_3_0_eb_state <= 5'h14;
      cmd_s3_2_0_eb_state <= 5'h14;
      cmd_s3_2_0_fork_ack_r_0 <= 1'b0;
      cmd_s3_2_0_fork_ack_r_1 <= 1'b0;
      cmd_lane_4_0_eb_state <= 5'h14;
      cmd_lane_5_0_eb_state <= 5'h14;
      cmd_s3_3_0_eb_state <= 5'h14;
      cmd_s3_3_0_fork_ack_r_0 <= 1'b0;
      cmd_s3_3_0_fork_ack_r_1 <= 1'b0;
      cmd_lane_6_0_eb_state <= 5'h14;
      cmd_lane_7_0_eb_state <= 5'h14;
      cmd_s3_4_0_eb_state <= 5'h14;
      cmd_s3_4_0_fork_ack_r_0 <= 1'b0;
      cmd_s3_4_0_fork_ack_r_1 <= 1'b0;
      cmd_lane_8_0_eb_state <= 5'h14;
      cmd_lane_9_0_eb_state <= 5'h14;
      cmd_s3_5_0_eb_state <= 5'h14;
      cmd_s3_5_0_fork_ack_r_0 <= 1'b0;
      cmd_s3_5_0_fork_ack_r_1 <= 1'b0;
      cmd_lane_10_0_eb_state <= 5'h14;
      cmd_lane_11_0_eb_state <= 5'h14;
      cmd_s3_6_0_eb_state <= 5'h14;
      cmd_s3_6_0_fork_ack_r_0 <= 1'b0;
      cmd_s3_6_0_fork_ack_r_1 <= 1'b0;
      cmd_lane_12_0_eb_state <= 5'h14;
      cmd_lane_13_0_eb_state <= 5'h14;
      cmd_s3_7_0_eb_state <= 5'h14;
      cmd_s3_7_0_fork_ack_r_0 <= 1'b0;
      cmd_s3_7_0_fork_ack_r_1 <= 1'b0;
      cmd_lane_14_0_eb_state <= 5'h14;
      cmd_lane_15_0_eb_state <= 5'h14;
      vector_k15_eb_state <= 5'h14;
      inmux_inmux_eb_valid <= 1'b0;
      iperm_data_data_eb_valid <= 1'b0;
      vmem_ovs_0_eb_valid <= 1'b0;
      operm_data_data_eb_state <= 5'h14;
      oumux_k15_eb_state <= 5'h14;
      oumux_k8_eb_state <= 5'h14;
      oumux_k9_eb_state <= 5'h14;
      oumux_k14_eb_valid <= 1'b0;
      oumux_k13_eb_cnt <= 2'b00;
      oumux_k13_eb_wr_ptr <= 2'b00;
      oumux_k13_eb_q_rd_ptr <= 2'b00;
      oumux_k13_eb_valid <= 1'b0;
      vector_kap_eb_state <= 5'h14;
      kap_deconcat_0_eb_valid <= 1'b0;
      kap_deconcat_1_eb_valid <= 1'b0;
      ka_decode_ka_eb_cnt <= 2'b00;
      ka_decode_ka_eb_wr_ptr <= 2'b00;
      ka_decode_ka_eb_q_rd_ptr <= 2'b00;
      ka_decode_ka_eb_valid <= 1'b0;
      ka_decode_k_sk_eb_cnt <= 1'b0;
      ka_decode_k_sk_eb_wr_ptr <= 1'b0;
      ka_decode_k_sk_eb_q_rd_ptr <= 1'b0;
      ka_decode_k_sk_eb_valid <= 1'b0;
      perm_full_addr_0_eb_valid <= 1'b0;
      ka_decode_k_lk_eb_cnt <= 2'b00;
      ka_decode_k_lk_eb_wr_ptr <= 2'b00;
      ka_decode_k_lk_eb_q_rd_ptr <= 2'b00;
      ka_decode_k_lk_eb_valid <= 1'b0;
      p_decode_p_sk_eb_cnt <= 2'b00;
      p_decode_p_sk_eb_wr_ptr <= 2'b00;
      p_decode_p_sk_eb_q_rd_ptr <= 2'b00;
      p_decode_p_sk_eb_valid <= 1'b0;
      p_decode_p_lk_eb_cnt <= 2'b00;
      p_decode_p_lk_eb_wr_ptr <= 2'b00;
      p_decode_p_lk_eb_q_rd_ptr <= 2'b00;
      p_decode_p_lk_eb_valid <= 1'b0;
      t_idma_0_idma_0_eb_state <= 5'h14;
      t_idma_1_idma_1_eb_state <= 5'h14;
      idma_1_s1_0_eb_state <= 5'h14;
      t_idma_2_idma_2_eb_state <= 5'h14;
      t_idma_3_idma_3_eb_state <= 5'h14;
      vmem_odma_0_eb_state <= 7'h48;
      vmem_odma_1_eb_state <= 7'h48;
      odma_1_s1_0_eb_valid <= 1'b0;
      vmem_odma_2_eb_state <= 7'h48;
      odma_2_s1_0_eb_valid <= 1'b0;
      vmem_odma_3_eb_state <= 7'h48;
    end else begin
      kap_deconcat_i_0_req_reg <= (kap_deconcat_i_0_ack_g && (! vector_kap_to_kap_deconcat_ack));
      kap_deconcat_i_1_req_reg <= (kap_deconcat_i_1_ack_g && (! vector_kap_to_kap_deconcat_ack));
      t_instr_0_eb_state <= t_instr_0_eb_state_nxt;
      t_instr_0_fork_ack_r_0 <= (t_instr_0_fork_ack_s_0 && (! t_instr_0_m_ack));
      t_instr_0_fork_ack_r_1 <= (t_instr_0_fork_ack_s_1 && (! t_instr_0_m_ack));
      cmd_s1_0_0_eb_state <= cmd_s1_0_0_eb_state_nxt;
      cmd_s1_0_0_fork_ack_r_0 <= (cmd_s1_0_0_fork_ack_s_0 && (! cmd_s1_0_0_m_ack));
      cmd_s1_0_0_fork_ack_r_1 <= (cmd_s1_0_0_fork_ack_s_1 && (! cmd_s1_0_0_m_ack));
      cmd_s1_1_0_eb_state <= cmd_s1_1_0_eb_state_nxt;
      cmd_s1_1_0_fork_ack_r_0 <= (cmd_s1_1_0_fork_ack_s_0 && (! cmd_s1_1_0_m_ack));
      cmd_s1_1_0_fork_ack_r_1 <= (cmd_s1_1_0_fork_ack_s_1 && (! cmd_s1_1_0_m_ack));
      cmd_s2_0_0_eb_state <= cmd_s2_0_0_eb_state_nxt;
      cmd_s2_0_0_fork_ack_r_0 <= (cmd_s2_0_0_fork_ack_s_0 && (! cmd_s2_0_0_m_ack));
      cmd_s2_0_0_fork_ack_r_1 <= (cmd_s2_0_0_fork_ack_s_1 && (! cmd_s2_0_0_m_ack));
      cmd_s2_1_0_eb_state <= cmd_s2_1_0_eb_state_nxt;
      cmd_s2_1_0_fork_ack_r_0 <= (cmd_s2_1_0_fork_ack_s_0 && (! cmd_s2_1_0_m_ack));
      cmd_s2_1_0_fork_ack_r_1 <= (cmd_s2_1_0_fork_ack_s_1 && (! cmd_s2_1_0_m_ack));
      cmd_s2_2_0_eb_state <= cmd_s2_2_0_eb_state_nxt;
      cmd_s2_2_0_fork_ack_r_0 <= (cmd_s2_2_0_fork_ack_s_0 && (! cmd_s2_2_0_m_ack));
      cmd_s2_2_0_fork_ack_r_1 <= (cmd_s2_2_0_fork_ack_s_1 && (! cmd_s2_2_0_m_ack));
      cmd_s2_3_0_eb_state <= cmd_s2_3_0_eb_state_nxt;
      cmd_s2_3_0_fork_ack_r_0 <= (cmd_s2_3_0_fork_ack_s_0 && (! cmd_s2_3_0_m_ack));
      cmd_s2_3_0_fork_ack_r_1 <= (cmd_s2_3_0_fork_ack_s_1 && (! cmd_s2_3_0_m_ack));
      cmd_s3_0_0_eb_state <= cmd_s3_0_0_eb_state_nxt;
      cmd_s3_0_0_fork_ack_r_0 <= (cmd_s3_0_0_fork_ack_s_0 && (! cmd_s3_0_0_m_ack));
      cmd_s3_0_0_fork_ack_r_1 <= (cmd_s3_0_0_fork_ack_s_1 && (! cmd_s3_0_0_m_ack));
      cmd_lane_0_0_eb_state <= cmd_lane_0_0_eb_state_nxt;
      cmd_lane_1_0_eb_state <= cmd_lane_1_0_eb_state_nxt;
      cmd_s3_1_0_eb_state <= cmd_s3_1_0_eb_state_nxt;
      cmd_s3_1_0_fork_ack_r_0 <= (cmd_s3_1_0_fork_ack_s_0 && (! cmd_s3_1_0_m_ack));
      cmd_s3_1_0_fork_ack_r_1 <= (cmd_s3_1_0_fork_ack_s_1 && (! cmd_s3_1_0_m_ack));
      cmd_lane_2_0_eb_state <= cmd_lane_2_0_eb_state_nxt;
      cmd_lane_3_0_eb_state <= cmd_lane_3_0_eb_state_nxt;
      cmd_s3_2_0_eb_state <= cmd_s3_2_0_eb_state_nxt;
      cmd_s3_2_0_fork_ack_r_0 <= (cmd_s3_2_0_fork_ack_s_0 && (! cmd_s3_2_0_m_ack));
      cmd_s3_2_0_fork_ack_r_1 <= (cmd_s3_2_0_fork_ack_s_1 && (! cmd_s3_2_0_m_ack));
      cmd_lane_4_0_eb_state <= cmd_lane_4_0_eb_state_nxt;
      cmd_lane_5_0_eb_state <= cmd_lane_5_0_eb_state_nxt;
      cmd_s3_3_0_eb_state <= cmd_s3_3_0_eb_state_nxt;
      cmd_s3_3_0_fork_ack_r_0 <= (cmd_s3_3_0_fork_ack_s_0 && (! cmd_s3_3_0_m_ack));
      cmd_s3_3_0_fork_ack_r_1 <= (cmd_s3_3_0_fork_ack_s_1 && (! cmd_s3_3_0_m_ack));
      cmd_lane_6_0_eb_state <= cmd_lane_6_0_eb_state_nxt;
      cmd_lane_7_0_eb_state <= cmd_lane_7_0_eb_state_nxt;
      cmd_s3_4_0_eb_state <= cmd_s3_4_0_eb_state_nxt;
      cmd_s3_4_0_fork_ack_r_0 <= (cmd_s3_4_0_fork_ack_s_0 && (! cmd_s3_4_0_m_ack));
      cmd_s3_4_0_fork_ack_r_1 <= (cmd_s3_4_0_fork_ack_s_1 && (! cmd_s3_4_0_m_ack));
      cmd_lane_8_0_eb_state <= cmd_lane_8_0_eb_state_nxt;
      cmd_lane_9_0_eb_state <= cmd_lane_9_0_eb_state_nxt;
      cmd_s3_5_0_eb_state <= cmd_s3_5_0_eb_state_nxt;
      cmd_s3_5_0_fork_ack_r_0 <= (cmd_s3_5_0_fork_ack_s_0 && (! cmd_s3_5_0_m_ack));
      cmd_s3_5_0_fork_ack_r_1 <= (cmd_s3_5_0_fork_ack_s_1 && (! cmd_s3_5_0_m_ack));
      cmd_lane_10_0_eb_state <= cmd_lane_10_0_eb_state_nxt;
      cmd_lane_11_0_eb_state <= cmd_lane_11_0_eb_state_nxt;
      cmd_s3_6_0_eb_state <= cmd_s3_6_0_eb_state_nxt;
      cmd_s3_6_0_fork_ack_r_0 <= (cmd_s3_6_0_fork_ack_s_0 && (! cmd_s3_6_0_m_ack));
      cmd_s3_6_0_fork_ack_r_1 <= (cmd_s3_6_0_fork_ack_s_1 && (! cmd_s3_6_0_m_ack));
      cmd_lane_12_0_eb_state <= cmd_lane_12_0_eb_state_nxt;
      cmd_lane_13_0_eb_state <= cmd_lane_13_0_eb_state_nxt;
      cmd_s3_7_0_eb_state <= cmd_s3_7_0_eb_state_nxt;
      cmd_s3_7_0_fork_ack_r_0 <= (cmd_s3_7_0_fork_ack_s_0 && (! cmd_s3_7_0_m_ack));
      cmd_s3_7_0_fork_ack_r_1 <= (cmd_s3_7_0_fork_ack_s_1 && (! cmd_s3_7_0_m_ack));
      cmd_lane_14_0_eb_state <= cmd_lane_14_0_eb_state_nxt;
      cmd_lane_15_0_eb_state <= cmd_lane_15_0_eb_state_nxt;
      vector_k15_eb_state <= vector_k15_eb_state_nxt;
      inmux_inmux_eb_valid <= ((! inmux_inmux_ack) || inmux_inmux_req);
      iperm_data_data_eb_valid <= ((! iperm_data_data_ack) || iperm_data_data_req);
      vmem_ovs_0_eb_valid <= ((! vmem_ovs_0_ack) || vmem_ovs_0_req);
      operm_data_data_eb_state <= operm_data_data_eb_state_nxt;
      oumux_k15_eb_state <= oumux_k15_eb_state_nxt;
      oumux_k8_eb_state <= oumux_k8_eb_state_nxt;
      oumux_k9_eb_state <= oumux_k9_eb_state_nxt;
      oumux_k14_eb_valid <= ((! oumux_k14_ack) || oumux_k14_req);
      if((oumux_k13_eb_cnt == 2'b00)) begin
        oumux_k13_eb_valid <= 1'b0;
      end else begin
        if((_zz_oumux_k13_eb_rd_ptr && (oumux_k13_eb_cnt == 2'b01))) begin
          oumux_k13_eb_valid <= 1'b0;
        end else begin
          oumux_k13_eb_valid <= 1'b1;
        end
      end
      if(oumux_k13_eb_wen) begin
        oumux_k13_eb_wr_ptr <= ((oumux_k13_eb_wr_ptr == _zz_oumux_k13_ack) ? 2'b00 : _zz_oumux_k13_eb_wr_ptr);
      end
      if(_zz_oumux_k13_eb_rd_ptr) begin
        oumux_k13_eb_q_rd_ptr <= _zz_oumux_k13_eb_q_rd_ptr;
      end
      if(!(_zz_oumux_k13_eb_rd_ptr && oumux_k13_eb_wen)) begin
        if((_zz_oumux_k13_eb_rd_ptr && (oumux_k13_eb_cnt != 2'b00))) begin
          oumux_k13_eb_cnt <= (oumux_k13_eb_cnt - 2'b01);
        end else begin
          if(oumux_k13_eb_wen) begin
            oumux_k13_eb_cnt <= (oumux_k13_eb_cnt + 2'b01);
          end
        end
      end
      vector_kap_eb_state <= vector_kap_eb_state_nxt;
      kap_deconcat_0_eb_valid <= ((! kap_deconcat_0_ack) || kap_deconcat_0_req);
      kap_deconcat_1_eb_valid <= ((! kap_deconcat_1_ack) || kap_deconcat_1_req);
      if((ka_decode_ka_eb_cnt == 2'b00)) begin
        ka_decode_ka_eb_valid <= 1'b0;
      end else begin
        if((_zz_ka_decode_ka_eb_rd_ptr && (ka_decode_ka_eb_cnt == 2'b01))) begin
          ka_decode_ka_eb_valid <= 1'b0;
        end else begin
          ka_decode_ka_eb_valid <= 1'b1;
        end
      end
      if(ka_decode_ka_eb_wen) begin
        ka_decode_ka_eb_wr_ptr <= ((ka_decode_ka_eb_wr_ptr == _zz_ka_decode_ka_ack) ? 2'b00 : _zz_ka_decode_ka_eb_wr_ptr);
      end
      if(_zz_ka_decode_ka_eb_rd_ptr) begin
        ka_decode_ka_eb_q_rd_ptr <= _zz_ka_decode_ka_eb_q_rd_ptr;
      end
      if(!(_zz_ka_decode_ka_eb_rd_ptr && ka_decode_ka_eb_wen)) begin
        if((_zz_ka_decode_ka_eb_rd_ptr && (ka_decode_ka_eb_cnt != 2'b00))) begin
          ka_decode_ka_eb_cnt <= (ka_decode_ka_eb_cnt - 2'b01);
        end else begin
          if(ka_decode_ka_eb_wen) begin
            ka_decode_ka_eb_cnt <= (ka_decode_ka_eb_cnt + 2'b01);
          end
        end
      end
      if((ka_decode_k_sk_eb_cnt == 1'b0)) begin
        ka_decode_k_sk_eb_valid <= 1'b0;
      end else begin
        if((_zz_ka_decode_k_sk_eb_rd_ptr && (ka_decode_k_sk_eb_cnt == 1'b1))) begin
          ka_decode_k_sk_eb_valid <= 1'b0;
        end else begin
          ka_decode_k_sk_eb_valid <= 1'b1;
        end
      end
      if(ka_decode_k_sk_eb_wen) begin
        ka_decode_k_sk_eb_wr_ptr <= ((ka_decode_k_sk_eb_wr_ptr == _zz_ka_decode_k_sk_ack) ? 1'b0 : _zz_ka_decode_k_sk_eb_wr_ptr);
      end
      if(_zz_ka_decode_k_sk_eb_rd_ptr) begin
        ka_decode_k_sk_eb_q_rd_ptr <= _zz_ka_decode_k_sk_eb_q_rd_ptr;
      end
      if(!(_zz_ka_decode_k_sk_eb_rd_ptr && ka_decode_k_sk_eb_wen)) begin
        if((_zz_ka_decode_k_sk_eb_rd_ptr && (ka_decode_k_sk_eb_cnt != 1'b0))) begin
          ka_decode_k_sk_eb_cnt <= (ka_decode_k_sk_eb_cnt - 1'b1);
        end else begin
          if(ka_decode_k_sk_eb_wen) begin
            ka_decode_k_sk_eb_cnt <= (ka_decode_k_sk_eb_cnt + 1'b1);
          end
        end
      end
      perm_full_addr_0_eb_valid <= ((! perm_full_addr_0_ack) || perm_full_addr_0_req);
      if((ka_decode_k_lk_eb_cnt == 2'b00)) begin
        ka_decode_k_lk_eb_valid <= 1'b0;
      end else begin
        if((_zz_ka_decode_k_lk_eb_rd_ptr && (ka_decode_k_lk_eb_cnt == 2'b01))) begin
          ka_decode_k_lk_eb_valid <= 1'b0;
        end else begin
          ka_decode_k_lk_eb_valid <= 1'b1;
        end
      end
      if(ka_decode_k_lk_eb_wen) begin
        ka_decode_k_lk_eb_wr_ptr <= ((ka_decode_k_lk_eb_wr_ptr == _zz_ka_decode_k_lk_ack) ? 2'b00 : _zz_ka_decode_k_lk_eb_wr_ptr);
      end
      if(_zz_ka_decode_k_lk_eb_rd_ptr) begin
        ka_decode_k_lk_eb_q_rd_ptr <= _zz_ka_decode_k_lk_eb_q_rd_ptr;
      end
      if(!(_zz_ka_decode_k_lk_eb_rd_ptr && ka_decode_k_lk_eb_wen)) begin
        if((_zz_ka_decode_k_lk_eb_rd_ptr && (ka_decode_k_lk_eb_cnt != 2'b00))) begin
          ka_decode_k_lk_eb_cnt <= (ka_decode_k_lk_eb_cnt - 2'b01);
        end else begin
          if(ka_decode_k_lk_eb_wen) begin
            ka_decode_k_lk_eb_cnt <= (ka_decode_k_lk_eb_cnt + 2'b01);
          end
        end
      end
      if((p_decode_p_sk_eb_cnt == 2'b00)) begin
        p_decode_p_sk_eb_valid <= 1'b0;
      end else begin
        if((_zz_p_decode_p_sk_eb_rd_ptr && (p_decode_p_sk_eb_cnt == 2'b01))) begin
          p_decode_p_sk_eb_valid <= 1'b0;
        end else begin
          p_decode_p_sk_eb_valid <= 1'b1;
        end
      end
      if(p_decode_p_sk_eb_wen) begin
        p_decode_p_sk_eb_wr_ptr <= ((p_decode_p_sk_eb_wr_ptr == _zz_p_decode_p_sk_ack) ? 2'b00 : _zz_p_decode_p_sk_eb_wr_ptr);
      end
      if(_zz_p_decode_p_sk_eb_rd_ptr) begin
        p_decode_p_sk_eb_q_rd_ptr <= _zz_p_decode_p_sk_eb_q_rd_ptr;
      end
      if(!(_zz_p_decode_p_sk_eb_rd_ptr && p_decode_p_sk_eb_wen)) begin
        if((_zz_p_decode_p_sk_eb_rd_ptr && (p_decode_p_sk_eb_cnt != 2'b00))) begin
          p_decode_p_sk_eb_cnt <= (p_decode_p_sk_eb_cnt - 2'b01);
        end else begin
          if(p_decode_p_sk_eb_wen) begin
            p_decode_p_sk_eb_cnt <= (p_decode_p_sk_eb_cnt + 2'b01);
          end
        end
      end
      if((p_decode_p_lk_eb_cnt == 2'b00)) begin
        p_decode_p_lk_eb_valid <= 1'b0;
      end else begin
        if((_zz_p_decode_p_lk_eb_rd_ptr && (p_decode_p_lk_eb_cnt == 2'b01))) begin
          p_decode_p_lk_eb_valid <= 1'b0;
        end else begin
          p_decode_p_lk_eb_valid <= 1'b1;
        end
      end
      if(p_decode_p_lk_eb_wen) begin
        p_decode_p_lk_eb_wr_ptr <= ((p_decode_p_lk_eb_wr_ptr == _zz_p_decode_p_lk_ack) ? 2'b00 : _zz_p_decode_p_lk_eb_wr_ptr);
      end
      if(_zz_p_decode_p_lk_eb_rd_ptr) begin
        p_decode_p_lk_eb_q_rd_ptr <= _zz_p_decode_p_lk_eb_q_rd_ptr;
      end
      if(!(_zz_p_decode_p_lk_eb_rd_ptr && p_decode_p_lk_eb_wen)) begin
        if((_zz_p_decode_p_lk_eb_rd_ptr && (p_decode_p_lk_eb_cnt != 2'b00))) begin
          p_decode_p_lk_eb_cnt <= (p_decode_p_lk_eb_cnt - 2'b01);
        end else begin
          if(p_decode_p_lk_eb_wen) begin
            p_decode_p_lk_eb_cnt <= (p_decode_p_lk_eb_cnt + 2'b01);
          end
        end
      end
      t_idma_0_idma_0_eb_state <= t_idma_0_idma_0_eb_state_nxt;
      t_idma_1_idma_1_eb_state <= t_idma_1_idma_1_eb_state_nxt;
      idma_1_s1_0_eb_state <= idma_1_s1_0_eb_state_nxt;
      t_idma_2_idma_2_eb_state <= t_idma_2_idma_2_eb_state_nxt;
      t_idma_3_idma_3_eb_state <= t_idma_3_idma_3_eb_state_nxt;
      vmem_odma_0_eb_state <= vmem_odma_0_eb_state_nxt;
      vmem_odma_1_eb_state <= vmem_odma_1_eb_state_nxt;
      odma_1_s1_0_eb_valid <= ((! odma_1_s1_0_ack) || odma_1_s1_0_req);
      vmem_odma_2_eb_state <= vmem_odma_2_eb_state_nxt;
      odma_2_s1_0_eb_valid <= ((! odma_2_s1_0_ack) || odma_2_s1_0_req);
      vmem_odma_3_eb_state <= vmem_odma_3_eb_state_nxt;
    end
  end

  always @(posedge clk) begin
    if(t_instr_0_eb_en0) begin
      t_instr_0_eb_r0 <= t_instr_0_nxt;
    end
    if(t_instr_0_eb_en1) begin
      t_instr_0_eb_r1 <= t_instr_0_nxt;
    end
    if(cmd_s1_0_0_eb_en0) begin
      cmd_s1_0_0_eb_r0 <= cmd_s1_0_0_nxt;
    end
    if(cmd_s1_0_0_eb_en1) begin
      cmd_s1_0_0_eb_r1 <= cmd_s1_0_0_nxt;
    end
    if(cmd_s1_1_0_eb_en0) begin
      cmd_s1_1_0_eb_r0 <= cmd_s1_1_0_nxt;
    end
    if(cmd_s1_1_0_eb_en1) begin
      cmd_s1_1_0_eb_r1 <= cmd_s1_1_0_nxt;
    end
    if(cmd_s2_0_0_eb_en0) begin
      cmd_s2_0_0_eb_r0 <= cmd_s2_0_0_nxt;
    end
    if(cmd_s2_0_0_eb_en1) begin
      cmd_s2_0_0_eb_r1 <= cmd_s2_0_0_nxt;
    end
    if(cmd_s2_1_0_eb_en0) begin
      cmd_s2_1_0_eb_r0 <= cmd_s2_1_0_nxt;
    end
    if(cmd_s2_1_0_eb_en1) begin
      cmd_s2_1_0_eb_r1 <= cmd_s2_1_0_nxt;
    end
    if(cmd_s2_2_0_eb_en0) begin
      cmd_s2_2_0_eb_r0 <= cmd_s2_2_0_nxt;
    end
    if(cmd_s2_2_0_eb_en1) begin
      cmd_s2_2_0_eb_r1 <= cmd_s2_2_0_nxt;
    end
    if(cmd_s2_3_0_eb_en0) begin
      cmd_s2_3_0_eb_r0 <= cmd_s2_3_0_nxt;
    end
    if(cmd_s2_3_0_eb_en1) begin
      cmd_s2_3_0_eb_r1 <= cmd_s2_3_0_nxt;
    end
    if(cmd_s3_0_0_eb_en0) begin
      cmd_s3_0_0_eb_r0 <= cmd_s3_0_0_nxt;
    end
    if(cmd_s3_0_0_eb_en1) begin
      cmd_s3_0_0_eb_r1 <= cmd_s3_0_0_nxt;
    end
    if(cmd_lane_0_0_eb_en0) begin
      cmd_lane_0_0_eb_r0 <= cmd_lane_0_0_nxt;
    end
    if(cmd_lane_0_0_eb_en1) begin
      cmd_lane_0_0_eb_r1 <= cmd_lane_0_0_nxt;
    end
    if(cmd_lane_1_0_eb_en0) begin
      cmd_lane_1_0_eb_r0 <= cmd_lane_1_0_nxt;
    end
    if(cmd_lane_1_0_eb_en1) begin
      cmd_lane_1_0_eb_r1 <= cmd_lane_1_0_nxt;
    end
    if(cmd_s3_1_0_eb_en0) begin
      cmd_s3_1_0_eb_r0 <= cmd_s3_1_0_nxt;
    end
    if(cmd_s3_1_0_eb_en1) begin
      cmd_s3_1_0_eb_r1 <= cmd_s3_1_0_nxt;
    end
    if(cmd_lane_2_0_eb_en0) begin
      cmd_lane_2_0_eb_r0 <= cmd_lane_2_0_nxt;
    end
    if(cmd_lane_2_0_eb_en1) begin
      cmd_lane_2_0_eb_r1 <= cmd_lane_2_0_nxt;
    end
    if(cmd_lane_3_0_eb_en0) begin
      cmd_lane_3_0_eb_r0 <= cmd_lane_3_0_nxt;
    end
    if(cmd_lane_3_0_eb_en1) begin
      cmd_lane_3_0_eb_r1 <= cmd_lane_3_0_nxt;
    end
    if(cmd_s3_2_0_eb_en0) begin
      cmd_s3_2_0_eb_r0 <= cmd_s3_2_0_nxt;
    end
    if(cmd_s3_2_0_eb_en1) begin
      cmd_s3_2_0_eb_r1 <= cmd_s3_2_0_nxt;
    end
    if(cmd_lane_4_0_eb_en0) begin
      cmd_lane_4_0_eb_r0 <= cmd_lane_4_0_nxt;
    end
    if(cmd_lane_4_0_eb_en1) begin
      cmd_lane_4_0_eb_r1 <= cmd_lane_4_0_nxt;
    end
    if(cmd_lane_5_0_eb_en0) begin
      cmd_lane_5_0_eb_r0 <= cmd_lane_5_0_nxt;
    end
    if(cmd_lane_5_0_eb_en1) begin
      cmd_lane_5_0_eb_r1 <= cmd_lane_5_0_nxt;
    end
    if(cmd_s3_3_0_eb_en0) begin
      cmd_s3_3_0_eb_r0 <= cmd_s3_3_0_nxt;
    end
    if(cmd_s3_3_0_eb_en1) begin
      cmd_s3_3_0_eb_r1 <= cmd_s3_3_0_nxt;
    end
    if(cmd_lane_6_0_eb_en0) begin
      cmd_lane_6_0_eb_r0 <= cmd_lane_6_0_nxt;
    end
    if(cmd_lane_6_0_eb_en1) begin
      cmd_lane_6_0_eb_r1 <= cmd_lane_6_0_nxt;
    end
    if(cmd_lane_7_0_eb_en0) begin
      cmd_lane_7_0_eb_r0 <= cmd_lane_7_0_nxt;
    end
    if(cmd_lane_7_0_eb_en1) begin
      cmd_lane_7_0_eb_r1 <= cmd_lane_7_0_nxt;
    end
    if(cmd_s3_4_0_eb_en0) begin
      cmd_s3_4_0_eb_r0 <= cmd_s3_4_0_nxt;
    end
    if(cmd_s3_4_0_eb_en1) begin
      cmd_s3_4_0_eb_r1 <= cmd_s3_4_0_nxt;
    end
    if(cmd_lane_8_0_eb_en0) begin
      cmd_lane_8_0_eb_r0 <= cmd_lane_8_0_nxt;
    end
    if(cmd_lane_8_0_eb_en1) begin
      cmd_lane_8_0_eb_r1 <= cmd_lane_8_0_nxt;
    end
    if(cmd_lane_9_0_eb_en0) begin
      cmd_lane_9_0_eb_r0 <= cmd_lane_9_0_nxt;
    end
    if(cmd_lane_9_0_eb_en1) begin
      cmd_lane_9_0_eb_r1 <= cmd_lane_9_0_nxt;
    end
    if(cmd_s3_5_0_eb_en0) begin
      cmd_s3_5_0_eb_r0 <= cmd_s3_5_0_nxt;
    end
    if(cmd_s3_5_0_eb_en1) begin
      cmd_s3_5_0_eb_r1 <= cmd_s3_5_0_nxt;
    end
    if(cmd_lane_10_0_eb_en0) begin
      cmd_lane_10_0_eb_r0 <= cmd_lane_10_0_nxt;
    end
    if(cmd_lane_10_0_eb_en1) begin
      cmd_lane_10_0_eb_r1 <= cmd_lane_10_0_nxt;
    end
    if(cmd_lane_11_0_eb_en0) begin
      cmd_lane_11_0_eb_r0 <= cmd_lane_11_0_nxt;
    end
    if(cmd_lane_11_0_eb_en1) begin
      cmd_lane_11_0_eb_r1 <= cmd_lane_11_0_nxt;
    end
    if(cmd_s3_6_0_eb_en0) begin
      cmd_s3_6_0_eb_r0 <= cmd_s3_6_0_nxt;
    end
    if(cmd_s3_6_0_eb_en1) begin
      cmd_s3_6_0_eb_r1 <= cmd_s3_6_0_nxt;
    end
    if(cmd_lane_12_0_eb_en0) begin
      cmd_lane_12_0_eb_r0 <= cmd_lane_12_0_nxt;
    end
    if(cmd_lane_12_0_eb_en1) begin
      cmd_lane_12_0_eb_r1 <= cmd_lane_12_0_nxt;
    end
    if(cmd_lane_13_0_eb_en0) begin
      cmd_lane_13_0_eb_r0 <= cmd_lane_13_0_nxt;
    end
    if(cmd_lane_13_0_eb_en1) begin
      cmd_lane_13_0_eb_r1 <= cmd_lane_13_0_nxt;
    end
    if(cmd_s3_7_0_eb_en0) begin
      cmd_s3_7_0_eb_r0 <= cmd_s3_7_0_nxt;
    end
    if(cmd_s3_7_0_eb_en1) begin
      cmd_s3_7_0_eb_r1 <= cmd_s3_7_0_nxt;
    end
    if(cmd_lane_14_0_eb_en0) begin
      cmd_lane_14_0_eb_r0 <= cmd_lane_14_0_nxt;
    end
    if(cmd_lane_14_0_eb_en1) begin
      cmd_lane_14_0_eb_r1 <= cmd_lane_14_0_nxt;
    end
    if(cmd_lane_15_0_eb_en0) begin
      cmd_lane_15_0_eb_r0 <= cmd_lane_15_0_nxt;
    end
    if(cmd_lane_15_0_eb_en1) begin
      cmd_lane_15_0_eb_r1 <= cmd_lane_15_0_nxt;
    end
    if(vector_k15_eb_en0) begin
      vector_k15_eb_r0 <= vector_k15_nxt;
    end
    if(vector_k15_eb_en1) begin
      vector_k15_eb_r1 <= vector_k15_nxt;
    end
    if(inmux_inmux_eb_en) begin
      inmux_inmux_eb_r <= inmux_inmux_nxt;
    end
    if(iperm_data_data_eb_en) begin
      iperm_data_data_eb_r <= iperm_data_data_nxt;
    end
    if(vmem_ovs_0_eb_en) begin
      vmem_ovs_0_eb_r <= vmem_ovs_0_nxt;
    end
    if(operm_data_data_eb_en0) begin
      operm_data_data_eb_r0 <= operm_data_data_nxt;
    end
    if(operm_data_data_eb_en1) begin
      operm_data_data_eb_r1 <= operm_data_data_nxt;
    end
    if(oumux_k15_eb_en0) begin
      oumux_k15_eb_r0 <= oumux_k15_nxt;
    end
    if(oumux_k15_eb_en1) begin
      oumux_k15_eb_r1 <= oumux_k15_nxt;
    end
    if(oumux_k8_eb_en0) begin
      oumux_k8_eb_r0 <= oumux_k8_nxt;
    end
    if(oumux_k8_eb_en1) begin
      oumux_k8_eb_r1 <= oumux_k8_nxt;
    end
    if(oumux_k9_eb_en0) begin
      oumux_k9_eb_r0 <= oumux_k9_nxt;
    end
    if(oumux_k9_eb_en1) begin
      oumux_k9_eb_r1 <= oumux_k9_nxt;
    end
    if(oumux_k14_eb_en) begin
      oumux_k14_eb_r <= oumux_k14_nxt;
    end
    if(vector_kap_eb_en0) begin
      vector_kap_eb_r0 <= vector_kap_nxt;
    end
    if(vector_kap_eb_en1) begin
      vector_kap_eb_r1 <= vector_kap_nxt;
    end
    if(kap_deconcat_0_eb_en) begin
      kap_deconcat_0_eb_r <= kap_deconcat_0_nxt;
    end
    if(kap_deconcat_1_eb_en) begin
      kap_deconcat_1_eb_r <= kap_deconcat_1_nxt;
    end
    if(perm_full_addr_0_eb_en) begin
      perm_full_addr_0_eb_r <= perm_full_addr_0_nxt;
    end
    if(t_idma_0_idma_0_eb_en0) begin
      t_idma_0_idma_0_eb_r0 <= t_idma_0_idma_0_nxt;
    end
    if(t_idma_0_idma_0_eb_en1) begin
      t_idma_0_idma_0_eb_r1 <= t_idma_0_idma_0_nxt;
    end
    if(t_idma_1_idma_1_eb_en0) begin
      t_idma_1_idma_1_eb_r0 <= t_idma_1_idma_1_nxt;
    end
    if(t_idma_1_idma_1_eb_en1) begin
      t_idma_1_idma_1_eb_r1 <= t_idma_1_idma_1_nxt;
    end
    if(idma_1_s1_0_eb_en0) begin
      idma_1_s1_0_eb_r0 <= idma_1_s1_0_nxt;
    end
    if(idma_1_s1_0_eb_en1) begin
      idma_1_s1_0_eb_r1 <= idma_1_s1_0_nxt;
    end
    if(t_idma_2_idma_2_eb_en0) begin
      t_idma_2_idma_2_eb_r0 <= t_idma_2_idma_2_nxt;
    end
    if(t_idma_2_idma_2_eb_en1) begin
      t_idma_2_idma_2_eb_r1 <= t_idma_2_idma_2_nxt;
    end
    if(t_idma_3_idma_3_eb_en0) begin
      t_idma_3_idma_3_eb_r0 <= t_idma_3_idma_3_nxt;
    end
    if(t_idma_3_idma_3_eb_en1) begin
      t_idma_3_idma_3_eb_r1 <= t_idma_3_idma_3_nxt;
    end
    if(vmem_odma_0_eb_en0) begin
      vmem_odma_0_eb_r0 <= (vmem_odma_0_eb_sel ? vmem_odma_0_eb_r1 : vmem_odma_0_nxt);
    end
    if(vmem_odma_0_eb_en1) begin
      vmem_odma_0_eb_r1 <= vmem_odma_0_nxt;
    end
    if(vmem_odma_1_eb_en0) begin
      vmem_odma_1_eb_r0 <= (vmem_odma_1_eb_sel ? vmem_odma_1_eb_r1 : vmem_odma_1_nxt);
    end
    if(vmem_odma_1_eb_en1) begin
      vmem_odma_1_eb_r1 <= vmem_odma_1_nxt;
    end
    if(odma_1_s1_0_eb_en) begin
      odma_1_s1_0_eb_r <= odma_1_s1_0_nxt;
    end
    if(vmem_odma_2_eb_en0) begin
      vmem_odma_2_eb_r0 <= (vmem_odma_2_eb_sel ? vmem_odma_2_eb_r1 : vmem_odma_2_nxt);
    end
    if(vmem_odma_2_eb_en1) begin
      vmem_odma_2_eb_r1 <= vmem_odma_2_nxt;
    end
    if(odma_2_s1_0_eb_en) begin
      odma_2_s1_0_eb_r <= odma_2_s1_0_nxt;
    end
    if(vmem_odma_3_eb_en0) begin
      vmem_odma_3_eb_r0 <= (vmem_odma_3_eb_sel ? vmem_odma_3_eb_r1 : vmem_odma_3_nxt);
    end
    if(vmem_odma_3_eb_en1) begin
      vmem_odma_3_eb_r1 <= vmem_odma_3_nxt;
    end
  end


endmodule

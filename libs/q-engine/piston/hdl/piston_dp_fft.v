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

  wire       [0:0]    k8_funnel_clk;
  wire       [0:0]    k8_funnel_reset_n;
  wire       [0:0]    k8_funnel_ctrl_t_0_req;
  wire       [0:0]    k8_funnel_ctrl_t_cfg_req;
  wire       [0:0]    k8_funnel_ctrl_i_0_ack;
  wire       [0:0]    k8_funnel_ctrl_i_1_ack;
  wire       [0:0]    k8_funnel_ctrl_clk;
  wire       [0:0]    k8_funnel_ctrl_reset_n;
  wire       [0:0]    k9_funnel_clk;
  wire       [0:0]    k9_funnel_reset_n;
  wire       [0:0]    k9_funnel_ctrl_t_0_req;
  wire       [0:0]    k9_funnel_ctrl_t_cfg_req;
  wire       [0:0]    k9_funnel_ctrl_i_0_ack;
  wire       [0:0]    k9_funnel_ctrl_i_1_ack;
  wire       [0:0]    k9_funnel_ctrl_clk;
  wire       [0:0]    k9_funnel_ctrl_reset_n;
  wire       [0:0]    k1_defunnel_clk;
  wire       [0:0]    k1_defunnel_reset_n;
  wire       [0:0]    k1_defunnel_ctrl_t_0_req;
  wire       [0:0]    k1_defunnel_ctrl_t_1_req;
  wire       [0:0]    k1_defunnel_ctrl_t_cfg_req;
  wire       [0:0]    k1_defunnel_ctrl_i_0_ack;
  wire       [0:0]    k1_defunnel_ctrl_clk;
  wire       [0:0]    k1_defunnel_ctrl_reset_n;
  wire       [0:0]    s0_cmul0_mas_re_CLK0;
  wire       [0:0]    s0_cmul0_mas_re_CE0;
  wire       [0:0]    s0_cmul0_mas_re_CE1;
  wire       [0:0]    s0_cmul0_mas_re_CE2;
  wire       [0:0]    s0_cmul0_mas_re_RST0;
  wire       [0:0]    s0_cmul0_mas_re_ADDNSUB;
  wire       [17:0]   s0_cmul0_mas_re_A0;
  wire       [17:0]   s0_cmul0_mas_re_A1;
  wire       [17:0]   s0_cmul0_mas_re_B0;
  wire       [17:0]   s0_cmul0_mas_re_B1;
  wire       [0:0]    s0_cmul0_mas_im_CLK0;
  wire       [0:0]    s0_cmul0_mas_im_CE0;
  wire       [0:0]    s0_cmul0_mas_im_CE1;
  wire       [0:0]    s0_cmul0_mas_im_CE2;
  wire       [0:0]    s0_cmul0_mas_im_RST0;
  wire       [0:0]    s0_cmul0_mas_im_ADDNSUB;
  wire       [17:0]   s0_cmul0_mas_im_A0;
  wire       [17:0]   s0_cmul0_mas_im_A1;
  wire       [17:0]   s0_cmul0_mas_im_B0;
  wire       [17:0]   s0_cmul0_mas_im_B1;
  wire       [0:0]    s0_cmul1_mas_re_CLK0;
  wire       [0:0]    s0_cmul1_mas_re_CE0;
  wire       [0:0]    s0_cmul1_mas_re_CE1;
  wire       [0:0]    s0_cmul1_mas_re_CE2;
  wire       [0:0]    s0_cmul1_mas_re_RST0;
  wire       [0:0]    s0_cmul1_mas_re_ADDNSUB;
  wire       [17:0]   s0_cmul1_mas_re_A0;
  wire       [17:0]   s0_cmul1_mas_re_A1;
  wire       [17:0]   s0_cmul1_mas_re_B0;
  wire       [17:0]   s0_cmul1_mas_re_B1;
  wire       [0:0]    s0_cmul1_mas_im_CLK0;
  wire       [0:0]    s0_cmul1_mas_im_CE0;
  wire       [0:0]    s0_cmul1_mas_im_CE1;
  wire       [0:0]    s0_cmul1_mas_im_CE2;
  wire       [0:0]    s0_cmul1_mas_im_RST0;
  wire       [0:0]    s0_cmul1_mas_im_ADDNSUB;
  wire       [17:0]   s0_cmul1_mas_im_A0;
  wire       [17:0]   s0_cmul1_mas_im_A1;
  wire       [17:0]   s0_cmul1_mas_im_B0;
  wire       [17:0]   s0_cmul1_mas_im_B1;
  wire       [0:0]    s0_cmul2_mas_re_CLK0;
  wire       [0:0]    s0_cmul2_mas_re_CE0;
  wire       [0:0]    s0_cmul2_mas_re_CE1;
  wire       [0:0]    s0_cmul2_mas_re_CE2;
  wire       [0:0]    s0_cmul2_mas_re_RST0;
  wire       [0:0]    s0_cmul2_mas_re_ADDNSUB;
  wire       [17:0]   s0_cmul2_mas_re_A0;
  wire       [17:0]   s0_cmul2_mas_re_A1;
  wire       [17:0]   s0_cmul2_mas_re_B0;
  wire       [17:0]   s0_cmul2_mas_re_B1;
  wire       [0:0]    s0_cmul2_mas_im_CLK0;
  wire       [0:0]    s0_cmul2_mas_im_CE0;
  wire       [0:0]    s0_cmul2_mas_im_CE1;
  wire       [0:0]    s0_cmul2_mas_im_CE2;
  wire       [0:0]    s0_cmul2_mas_im_RST0;
  wire       [0:0]    s0_cmul2_mas_im_ADDNSUB;
  wire       [17:0]   s0_cmul2_mas_im_A0;
  wire       [17:0]   s0_cmul2_mas_im_A1;
  wire       [17:0]   s0_cmul2_mas_im_B0;
  wire       [17:0]   s0_cmul2_mas_im_B1;
  wire       [0:0]    s0_cmul3_mas_re_CLK0;
  wire       [0:0]    s0_cmul3_mas_re_CE0;
  wire       [0:0]    s0_cmul3_mas_re_CE1;
  wire       [0:0]    s0_cmul3_mas_re_CE2;
  wire       [0:0]    s0_cmul3_mas_re_RST0;
  wire       [0:0]    s0_cmul3_mas_re_ADDNSUB;
  wire       [17:0]   s0_cmul3_mas_re_A0;
  wire       [17:0]   s0_cmul3_mas_re_A1;
  wire       [17:0]   s0_cmul3_mas_re_B0;
  wire       [17:0]   s0_cmul3_mas_re_B1;
  wire       [0:0]    s0_cmul3_mas_im_CLK0;
  wire       [0:0]    s0_cmul3_mas_im_CE0;
  wire       [0:0]    s0_cmul3_mas_im_CE1;
  wire       [0:0]    s0_cmul3_mas_im_CE2;
  wire       [0:0]    s0_cmul3_mas_im_RST0;
  wire       [0:0]    s0_cmul3_mas_im_ADDNSUB;
  wire       [17:0]   s0_cmul3_mas_im_A0;
  wire       [17:0]   s0_cmul3_mas_im_A1;
  wire       [17:0]   s0_cmul3_mas_im_B0;
  wire       [17:0]   s0_cmul3_mas_im_B1;
  wire       [0:0]    s1_cmul0_mas_re_CLK0;
  wire       [0:0]    s1_cmul0_mas_re_CE0;
  wire       [0:0]    s1_cmul0_mas_re_CE1;
  wire       [0:0]    s1_cmul0_mas_re_CE2;
  wire       [0:0]    s1_cmul0_mas_re_RST0;
  wire       [0:0]    s1_cmul0_mas_re_ADDNSUB;
  wire       [17:0]   s1_cmul0_mas_re_A0;
  wire       [17:0]   s1_cmul0_mas_re_A1;
  wire       [17:0]   s1_cmul0_mas_re_B0;
  wire       [17:0]   s1_cmul0_mas_re_B1;
  wire       [0:0]    s1_cmul0_mas_im_CLK0;
  wire       [0:0]    s1_cmul0_mas_im_CE0;
  wire       [0:0]    s1_cmul0_mas_im_CE1;
  wire       [0:0]    s1_cmul0_mas_im_CE2;
  wire       [0:0]    s1_cmul0_mas_im_RST0;
  wire       [0:0]    s1_cmul0_mas_im_ADDNSUB;
  wire       [17:0]   s1_cmul0_mas_im_A0;
  wire       [17:0]   s1_cmul0_mas_im_A1;
  wire       [17:0]   s1_cmul0_mas_im_B0;
  wire       [17:0]   s1_cmul0_mas_im_B1;
  wire       [0:0]    s1_cmul1_mas_re_CLK0;
  wire       [0:0]    s1_cmul1_mas_re_CE0;
  wire       [0:0]    s1_cmul1_mas_re_CE1;
  wire       [0:0]    s1_cmul1_mas_re_CE2;
  wire       [0:0]    s1_cmul1_mas_re_RST0;
  wire       [0:0]    s1_cmul1_mas_re_ADDNSUB;
  wire       [17:0]   s1_cmul1_mas_re_A0;
  wire       [17:0]   s1_cmul1_mas_re_A1;
  wire       [17:0]   s1_cmul1_mas_re_B0;
  wire       [17:0]   s1_cmul1_mas_re_B1;
  wire       [0:0]    s1_cmul1_mas_im_CLK0;
  wire       [0:0]    s1_cmul1_mas_im_CE0;
  wire       [0:0]    s1_cmul1_mas_im_CE1;
  wire       [0:0]    s1_cmul1_mas_im_CE2;
  wire       [0:0]    s1_cmul1_mas_im_RST0;
  wire       [0:0]    s1_cmul1_mas_im_ADDNSUB;
  wire       [17:0]   s1_cmul1_mas_im_A0;
  wire       [17:0]   s1_cmul1_mas_im_A1;
  wire       [17:0]   s1_cmul1_mas_im_B0;
  wire       [17:0]   s1_cmul1_mas_im_B1;
  wire       [0:0]    s1_cmul2_mas_re_CLK0;
  wire       [0:0]    s1_cmul2_mas_re_CE0;
  wire       [0:0]    s1_cmul2_mas_re_CE1;
  wire       [0:0]    s1_cmul2_mas_re_CE2;
  wire       [0:0]    s1_cmul2_mas_re_RST0;
  wire       [0:0]    s1_cmul2_mas_re_ADDNSUB;
  wire       [17:0]   s1_cmul2_mas_re_A0;
  wire       [17:0]   s1_cmul2_mas_re_A1;
  wire       [17:0]   s1_cmul2_mas_re_B0;
  wire       [17:0]   s1_cmul2_mas_re_B1;
  wire       [0:0]    s1_cmul2_mas_im_CLK0;
  wire       [0:0]    s1_cmul2_mas_im_CE0;
  wire       [0:0]    s1_cmul2_mas_im_CE1;
  wire       [0:0]    s1_cmul2_mas_im_CE2;
  wire       [0:0]    s1_cmul2_mas_im_RST0;
  wire       [0:0]    s1_cmul2_mas_im_ADDNSUB;
  wire       [17:0]   s1_cmul2_mas_im_A0;
  wire       [17:0]   s1_cmul2_mas_im_A1;
  wire       [17:0]   s1_cmul2_mas_im_B0;
  wire       [17:0]   s1_cmul2_mas_im_B1;
  wire       [0:0]    s1_cmul3_mas_re_CLK0;
  wire       [0:0]    s1_cmul3_mas_re_CE0;
  wire       [0:0]    s1_cmul3_mas_re_CE1;
  wire       [0:0]    s1_cmul3_mas_re_CE2;
  wire       [0:0]    s1_cmul3_mas_re_RST0;
  wire       [0:0]    s1_cmul3_mas_re_ADDNSUB;
  wire       [17:0]   s1_cmul3_mas_re_A0;
  wire       [17:0]   s1_cmul3_mas_re_A1;
  wire       [17:0]   s1_cmul3_mas_re_B0;
  wire       [17:0]   s1_cmul3_mas_re_B1;
  wire       [0:0]    s1_cmul3_mas_im_CLK0;
  wire       [0:0]    s1_cmul3_mas_im_CE0;
  wire       [0:0]    s1_cmul3_mas_im_CE1;
  wire       [0:0]    s1_cmul3_mas_im_CE2;
  wire       [0:0]    s1_cmul3_mas_im_RST0;
  wire       [0:0]    s1_cmul3_mas_im_ADDNSUB;
  wire       [17:0]   s1_cmul3_mas_im_A0;
  wire       [17:0]   s1_cmul3_mas_im_A1;
  wire       [17:0]   s1_cmul3_mas_im_B0;
  wire       [17:0]   s1_cmul3_mas_im_B1;
  wire       [0:0]    s0_bs0_re_clk;
  wire       [0:0]    s0_bs0_re_reset_n;
  wire       [0:0]    s0_bs0_im_clk;
  wire       [0:0]    s0_bs0_im_reset_n;
  wire       [0:0]    s0_rsat0_re_clk;
  wire       [0:0]    s0_rsat0_re_reset_n;
  wire       [0:0]    s0_rsat0_im_clk;
  wire       [0:0]    s0_rsat0_im_reset_n;
  wire       [0:0]    s0_bs1_re_clk;
  wire       [0:0]    s0_bs1_re_reset_n;
  wire       [0:0]    s0_bs1_im_clk;
  wire       [0:0]    s0_bs1_im_reset_n;
  wire       [0:0]    s0_rsat1_re_clk;
  wire       [0:0]    s0_rsat1_re_reset_n;
  wire       [0:0]    s0_rsat1_im_clk;
  wire       [0:0]    s0_rsat1_im_reset_n;
  wire       [0:0]    s0_bs2_re_clk;
  wire       [0:0]    s0_bs2_re_reset_n;
  wire       [0:0]    s0_bs2_im_clk;
  wire       [0:0]    s0_bs2_im_reset_n;
  wire       [0:0]    s0_rsat2_re_clk;
  wire       [0:0]    s0_rsat2_re_reset_n;
  wire       [0:0]    s0_rsat2_im_clk;
  wire       [0:0]    s0_rsat2_im_reset_n;
  wire       [0:0]    s0_bs3_re_clk;
  wire       [0:0]    s0_bs3_re_reset_n;
  wire       [0:0]    s0_bs3_im_clk;
  wire       [0:0]    s0_bs3_im_reset_n;
  wire       [0:0]    s0_rsat3_re_clk;
  wire       [0:0]    s0_rsat3_re_reset_n;
  wire       [0:0]    s0_rsat3_im_clk;
  wire       [0:0]    s0_rsat3_im_reset_n;
  wire       [0:0]    s1_bs0_re_clk;
  wire       [0:0]    s1_bs0_re_reset_n;
  wire       [0:0]    s1_bs0_im_clk;
  wire       [0:0]    s1_bs0_im_reset_n;
  wire       [0:0]    s1_rsat0_re_clk;
  wire       [0:0]    s1_rsat0_re_reset_n;
  wire       [0:0]    s1_rsat0_im_clk;
  wire       [0:0]    s1_rsat0_im_reset_n;
  wire       [0:0]    s1_bs1_re_clk;
  wire       [0:0]    s1_bs1_re_reset_n;
  wire       [0:0]    s1_bs1_im_clk;
  wire       [0:0]    s1_bs1_im_reset_n;
  wire       [0:0]    s1_rsat1_re_clk;
  wire       [0:0]    s1_rsat1_re_reset_n;
  wire       [0:0]    s1_rsat1_im_clk;
  wire       [0:0]    s1_rsat1_im_reset_n;
  wire       [0:0]    s1_bs2_re_clk;
  wire       [0:0]    s1_bs2_re_reset_n;
  wire       [0:0]    s1_bs2_im_clk;
  wire       [0:0]    s1_bs2_im_reset_n;
  wire       [0:0]    s1_rsat2_re_clk;
  wire       [0:0]    s1_rsat2_re_reset_n;
  wire       [0:0]    s1_rsat2_im_clk;
  wire       [0:0]    s1_rsat2_im_reset_n;
  wire       [0:0]    s1_bs3_re_clk;
  wire       [0:0]    s1_bs3_re_reset_n;
  wire       [0:0]    s1_bs3_im_clk;
  wire       [0:0]    s1_bs3_im_reset_n;
  wire       [0:0]    s1_rsat3_re_clk;
  wire       [0:0]    s1_rsat3_re_reset_n;
  wire       [0:0]    s1_rsat3_im_clk;
  wire       [0:0]    s1_rsat3_im_reset_n;
  wire       [127:0]  k8_funnel_i_0_dat;
  wire       [127:0]  k8_funnel_i_1_dat;
  wire       [7:0]    k8_funnel_mode;
  wire       [0:0]    k8_funnel_ctrl_t_0_ack;
  wire       [0:0]    k8_funnel_ctrl_t_cfg_ack;
  wire       [0:0]    k8_funnel_ctrl_i_0_req;
  wire       [0:0]    k8_funnel_ctrl_i_1_req;
  wire       [7:0]    k8_funnel_ctrl_sel;
  wire       [127:0]  k9_funnel_i_0_dat;
  wire       [127:0]  k9_funnel_i_1_dat;
  wire       [7:0]    k9_funnel_mode;
  wire       [0:0]    k9_funnel_ctrl_t_0_ack;
  wire       [0:0]    k9_funnel_ctrl_t_cfg_ack;
  wire       [0:0]    k9_funnel_ctrl_i_0_req;
  wire       [0:0]    k9_funnel_ctrl_i_1_req;
  wire       [7:0]    k9_funnel_ctrl_sel;
  wire       [511:0]  k1_defunnel_i_0_dat;
  wire       [7:0]    k1_defunnel_mode;
  wire       [0:0]    k1_defunnel_ctrl_t_0_ack;
  wire       [0:0]    k1_defunnel_ctrl_t_1_ack;
  wire       [0:0]    k1_defunnel_ctrl_t_cfg_ack;
  wire       [0:0]    k1_defunnel_ctrl_i_0_req;
  wire       [7:0]    k1_defunnel_ctrl_enable;
  wire       [35:0]   s0_cmul0_mas_re_SUM;
  wire       [35:0]   s0_cmul0_mas_im_SUM;
  wire       [35:0]   s0_cmul1_mas_re_SUM;
  wire       [35:0]   s0_cmul1_mas_im_SUM;
  wire       [35:0]   s0_cmul2_mas_re_SUM;
  wire       [35:0]   s0_cmul2_mas_im_SUM;
  wire       [35:0]   s0_cmul3_mas_re_SUM;
  wire       [35:0]   s0_cmul3_mas_im_SUM;
  wire       [35:0]   s1_cmul0_mas_re_SUM;
  wire       [35:0]   s1_cmul0_mas_im_SUM;
  wire       [35:0]   s1_cmul1_mas_re_SUM;
  wire       [35:0]   s1_cmul1_mas_im_SUM;
  wire       [35:0]   s1_cmul2_mas_re_SUM;
  wire       [35:0]   s1_cmul2_mas_im_SUM;
  wire       [35:0]   s1_cmul3_mas_re_SUM;
  wire       [35:0]   s1_cmul3_mas_im_SUM;
  wire       [19:0]   s0_bs0_re_i_0_dat;
  wire       [19:0]   s0_bs0_im_i_0_dat;
  wire       [15:0]   s0_rsat0_re_i_0_dat;
  wire       [15:0]   s0_rsat0_im_i_0_dat;
  wire       [19:0]   s0_bs1_re_i_0_dat;
  wire       [19:0]   s0_bs1_im_i_0_dat;
  wire       [15:0]   s0_rsat1_re_i_0_dat;
  wire       [15:0]   s0_rsat1_im_i_0_dat;
  wire       [19:0]   s0_bs2_re_i_0_dat;
  wire       [19:0]   s0_bs2_im_i_0_dat;
  wire       [15:0]   s0_rsat2_re_i_0_dat;
  wire       [15:0]   s0_rsat2_im_i_0_dat;
  wire       [19:0]   s0_bs3_re_i_0_dat;
  wire       [19:0]   s0_bs3_im_i_0_dat;
  wire       [15:0]   s0_rsat3_re_i_0_dat;
  wire       [15:0]   s0_rsat3_im_i_0_dat;
  wire       [19:0]   s1_bs0_re_i_0_dat;
  wire       [19:0]   s1_bs0_im_i_0_dat;
  wire       [15:0]   s1_rsat0_re_i_0_dat;
  wire       [15:0]   s1_rsat0_im_i_0_dat;
  wire       [19:0]   s1_bs1_re_i_0_dat;
  wire       [19:0]   s1_bs1_im_i_0_dat;
  wire       [15:0]   s1_rsat1_re_i_0_dat;
  wire       [15:0]   s1_rsat1_im_i_0_dat;
  wire       [19:0]   s1_bs2_re_i_0_dat;
  wire       [19:0]   s1_bs2_im_i_0_dat;
  wire       [15:0]   s1_rsat2_re_i_0_dat;
  wire       [15:0]   s1_rsat2_im_i_0_dat;
  wire       [19:0]   s1_bs3_re_i_0_dat;
  wire       [19:0]   s1_bs3_im_i_0_dat;
  wire       [15:0]   s1_rsat3_re_i_0_dat;
  wire       [15:0]   s1_rsat3_im_i_0_dat;
  wire                _zz_t_k14_0_to_cfg_ack;
  wire                _zz_t_k14_0_to_cfg_ack_1;
  wire                _zz_t_k14_0_to_cfg_ack_2;
  wire                _zz_t_k14_0_to_cfg_ack_3;
  wire                _zz_t_k14_0_to_cfg_ack_4;
  wire                _zz_t_k14_0_to_cfg_ack_5;
  wire       [17:0]   _zz_s0_k8_slice_0;
  wire       [15:0]   _zz_s0_k8_slice_0_1;
  wire       [17:0]   _zz_s0_k8_slice_1;
  wire       [15:0]   _zz_s0_k8_slice_1_1;
  wire       [17:0]   _zz_s0_k8_slice_2;
  wire       [15:0]   _zz_s0_k8_slice_2_1;
  wire       [17:0]   _zz_s0_k8_slice_3;
  wire       [15:0]   _zz_s0_k8_slice_3_1;
  wire       [17:0]   _zz_s0_k8_slice_4;
  wire       [15:0]   _zz_s0_k8_slice_4_1;
  wire       [17:0]   _zz_s0_k8_slice_5;
  wire       [15:0]   _zz_s0_k8_slice_5_1;
  wire       [17:0]   _zz_s0_k8_slice_6;
  wire       [15:0]   _zz_s0_k8_slice_6_1;
  wire       [17:0]   _zz_s0_k8_slice_7;
  wire       [15:0]   _zz_s0_k8_slice_7_1;
  wire       [17:0]   _zz_s0_k9_slice_0;
  wire       [15:0]   _zz_s0_k9_slice_0_1;
  wire       [17:0]   _zz_s0_k9_slice_1;
  wire       [15:0]   _zz_s0_k9_slice_1_1;
  wire       [17:0]   _zz_s0_k9_slice_2;
  wire       [15:0]   _zz_s0_k9_slice_2_1;
  wire       [17:0]   _zz_s0_k9_slice_3;
  wire       [15:0]   _zz_s0_k9_slice_3_1;
  wire       [17:0]   _zz_s0_k9_slice_4;
  wire       [15:0]   _zz_s0_k9_slice_4_1;
  wire       [17:0]   _zz_s0_k9_slice_5;
  wire       [15:0]   _zz_s0_k9_slice_5_1;
  wire       [17:0]   _zz_s0_k9_slice_6;
  wire       [15:0]   _zz_s0_k9_slice_6_1;
  wire       [17:0]   _zz_s0_k9_slice_7;
  wire       [15:0]   _zz_s0_k9_slice_7_1;
  wire       [15:0]   _zz_s0_cmul0_recip_norm_mag;
  wire       [15:0]   _zz_s0_cmul0_recip_norm_mag_1;
  wire       [15:0]   _zz_s0_cmul0_recip_norm_mag_2;
  wire       [0:0]    _zz_s0_cmul0_recip_norm_mag_3;
  wire       [15:0]   _zz_s0_cmul0_recip_norm_xn;
  wire       [10:0]   _zz_s0_cmul0_recip_mul_y0_1;
  wire       [20:0]   _zz_s0_cmul0_recip_mul_t;
  wire       [21:0]   _zz_s0_cmul0_recip_out_r;
  wire       [13:0]   _zz_s0_cmul0_recip_out_rn_1;
  wire       [4:0]    _zz_s0_cmul0_recip_out_rn_2;
  wire       [17:0]   _zz_s0_cmul0_recip_out_rn_3;
  wire       [4:0]    _zz_s0_cmul0_recip_out_rn_4;
  wire       [17:0]   _zz_s0_cmul0_recip_out_0_nxt;
  wire       [17:0]   _zz_s0_cmul0_recip_out_0_nxt_1;
  wire       [15:0]   _zz_s0_cmul1_recip_norm_mag;
  wire       [15:0]   _zz_s0_cmul1_recip_norm_mag_1;
  wire       [15:0]   _zz_s0_cmul1_recip_norm_mag_2;
  wire       [0:0]    _zz_s0_cmul1_recip_norm_mag_3;
  wire       [15:0]   _zz_s0_cmul1_recip_norm_xn;
  wire       [10:0]   _zz_s0_cmul1_recip_mul_y0_1;
  wire       [20:0]   _zz_s0_cmul1_recip_mul_t;
  wire       [21:0]   _zz_s0_cmul1_recip_out_r;
  wire       [13:0]   _zz_s0_cmul1_recip_out_rn_1;
  wire       [4:0]    _zz_s0_cmul1_recip_out_rn_2;
  wire       [17:0]   _zz_s0_cmul1_recip_out_rn_3;
  wire       [4:0]    _zz_s0_cmul1_recip_out_rn_4;
  wire       [17:0]   _zz_s0_cmul1_recip_out_0_nxt;
  wire       [17:0]   _zz_s0_cmul1_recip_out_0_nxt_1;
  wire       [15:0]   _zz_s0_cmul2_recip_norm_mag;
  wire       [15:0]   _zz_s0_cmul2_recip_norm_mag_1;
  wire       [15:0]   _zz_s0_cmul2_recip_norm_mag_2;
  wire       [0:0]    _zz_s0_cmul2_recip_norm_mag_3;
  wire       [15:0]   _zz_s0_cmul2_recip_norm_xn;
  wire       [10:0]   _zz_s0_cmul2_recip_mul_y0_1;
  wire       [20:0]   _zz_s0_cmul2_recip_mul_t;
  wire       [21:0]   _zz_s0_cmul2_recip_out_r;
  wire       [13:0]   _zz_s0_cmul2_recip_out_rn_1;
  wire       [4:0]    _zz_s0_cmul2_recip_out_rn_2;
  wire       [17:0]   _zz_s0_cmul2_recip_out_rn_3;
  wire       [4:0]    _zz_s0_cmul2_recip_out_rn_4;
  wire       [17:0]   _zz_s0_cmul2_recip_out_0_nxt;
  wire       [17:0]   _zz_s0_cmul2_recip_out_0_nxt_1;
  wire       [15:0]   _zz_s0_cmul3_recip_norm_mag;
  wire       [15:0]   _zz_s0_cmul3_recip_norm_mag_1;
  wire       [15:0]   _zz_s0_cmul3_recip_norm_mag_2;
  wire       [0:0]    _zz_s0_cmul3_recip_norm_mag_3;
  wire       [15:0]   _zz_s0_cmul3_recip_norm_xn;
  wire       [10:0]   _zz_s0_cmul3_recip_mul_y0_1;
  wire       [20:0]   _zz_s0_cmul3_recip_mul_t;
  wire       [21:0]   _zz_s0_cmul3_recip_out_r;
  wire       [13:0]   _zz_s0_cmul3_recip_out_rn_1;
  wire       [4:0]    _zz_s0_cmul3_recip_out_rn_2;
  wire       [17:0]   _zz_s0_cmul3_recip_out_rn_3;
  wire       [4:0]    _zz_s0_cmul3_recip_out_rn_4;
  wire       [17:0]   _zz_s0_cmul3_recip_out_0_nxt;
  wire       [17:0]   _zz_s0_cmul3_recip_out_0_nxt_1;
  wire       [17:0]   _zz_s1_k8_slice_0;
  wire       [15:0]   _zz_s1_k8_slice_0_1;
  wire       [17:0]   _zz_s1_k8_slice_1;
  wire       [15:0]   _zz_s1_k8_slice_1_1;
  wire       [17:0]   _zz_s1_k8_slice_2;
  wire       [15:0]   _zz_s1_k8_slice_2_1;
  wire       [17:0]   _zz_s1_k8_slice_3;
  wire       [15:0]   _zz_s1_k8_slice_3_1;
  wire       [17:0]   _zz_s1_k8_slice_4;
  wire       [15:0]   _zz_s1_k8_slice_4_1;
  wire       [17:0]   _zz_s1_k8_slice_5;
  wire       [15:0]   _zz_s1_k8_slice_5_1;
  wire       [17:0]   _zz_s1_k8_slice_6;
  wire       [15:0]   _zz_s1_k8_slice_6_1;
  wire       [17:0]   _zz_s1_k8_slice_7;
  wire       [15:0]   _zz_s1_k8_slice_7_1;
  wire       [17:0]   _zz_s1_k9_slice_0;
  wire       [15:0]   _zz_s1_k9_slice_0_1;
  wire       [17:0]   _zz_s1_k9_slice_1;
  wire       [15:0]   _zz_s1_k9_slice_1_1;
  wire       [17:0]   _zz_s1_k9_slice_2;
  wire       [15:0]   _zz_s1_k9_slice_2_1;
  wire       [17:0]   _zz_s1_k9_slice_3;
  wire       [15:0]   _zz_s1_k9_slice_3_1;
  wire       [17:0]   _zz_s1_k9_slice_4;
  wire       [15:0]   _zz_s1_k9_slice_4_1;
  wire       [17:0]   _zz_s1_k9_slice_5;
  wire       [15:0]   _zz_s1_k9_slice_5_1;
  wire       [17:0]   _zz_s1_k9_slice_6;
  wire       [15:0]   _zz_s1_k9_slice_6_1;
  wire       [17:0]   _zz_s1_k9_slice_7;
  wire       [15:0]   _zz_s1_k9_slice_7_1;
  wire       [15:0]   _zz_s1_cmul0_recip_norm_mag;
  wire       [15:0]   _zz_s1_cmul0_recip_norm_mag_1;
  wire       [15:0]   _zz_s1_cmul0_recip_norm_mag_2;
  wire       [0:0]    _zz_s1_cmul0_recip_norm_mag_3;
  wire       [15:0]   _zz_s1_cmul0_recip_norm_xn;
  wire       [10:0]   _zz_s1_cmul0_recip_mul_y0_1;
  wire       [20:0]   _zz_s1_cmul0_recip_mul_t;
  wire       [21:0]   _zz_s1_cmul0_recip_out_r;
  wire       [13:0]   _zz_s1_cmul0_recip_out_rn_1;
  wire       [4:0]    _zz_s1_cmul0_recip_out_rn_2;
  wire       [17:0]   _zz_s1_cmul0_recip_out_rn_3;
  wire       [4:0]    _zz_s1_cmul0_recip_out_rn_4;
  wire       [17:0]   _zz_s1_cmul0_recip_out_0_nxt;
  wire       [17:0]   _zz_s1_cmul0_recip_out_0_nxt_1;
  wire       [15:0]   _zz_s1_cmul1_recip_norm_mag;
  wire       [15:0]   _zz_s1_cmul1_recip_norm_mag_1;
  wire       [15:0]   _zz_s1_cmul1_recip_norm_mag_2;
  wire       [0:0]    _zz_s1_cmul1_recip_norm_mag_3;
  wire       [15:0]   _zz_s1_cmul1_recip_norm_xn;
  wire       [10:0]   _zz_s1_cmul1_recip_mul_y0_1;
  wire       [20:0]   _zz_s1_cmul1_recip_mul_t;
  wire       [21:0]   _zz_s1_cmul1_recip_out_r;
  wire       [13:0]   _zz_s1_cmul1_recip_out_rn_1;
  wire       [4:0]    _zz_s1_cmul1_recip_out_rn_2;
  wire       [17:0]   _zz_s1_cmul1_recip_out_rn_3;
  wire       [4:0]    _zz_s1_cmul1_recip_out_rn_4;
  wire       [17:0]   _zz_s1_cmul1_recip_out_0_nxt;
  wire       [17:0]   _zz_s1_cmul1_recip_out_0_nxt_1;
  wire       [15:0]   _zz_s1_cmul2_recip_norm_mag;
  wire       [15:0]   _zz_s1_cmul2_recip_norm_mag_1;
  wire       [15:0]   _zz_s1_cmul2_recip_norm_mag_2;
  wire       [0:0]    _zz_s1_cmul2_recip_norm_mag_3;
  wire       [15:0]   _zz_s1_cmul2_recip_norm_xn;
  wire       [10:0]   _zz_s1_cmul2_recip_mul_y0_1;
  wire       [20:0]   _zz_s1_cmul2_recip_mul_t;
  wire       [21:0]   _zz_s1_cmul2_recip_out_r;
  wire       [13:0]   _zz_s1_cmul2_recip_out_rn_1;
  wire       [4:0]    _zz_s1_cmul2_recip_out_rn_2;
  wire       [17:0]   _zz_s1_cmul2_recip_out_rn_3;
  wire       [4:0]    _zz_s1_cmul2_recip_out_rn_4;
  wire       [17:0]   _zz_s1_cmul2_recip_out_0_nxt;
  wire       [17:0]   _zz_s1_cmul2_recip_out_0_nxt_1;
  wire       [15:0]   _zz_s1_cmul3_recip_norm_mag;
  wire       [15:0]   _zz_s1_cmul3_recip_norm_mag_1;
  wire       [15:0]   _zz_s1_cmul3_recip_norm_mag_2;
  wire       [0:0]    _zz_s1_cmul3_recip_norm_mag_3;
  wire       [15:0]   _zz_s1_cmul3_recip_norm_xn;
  wire       [10:0]   _zz_s1_cmul3_recip_mul_y0_1;
  wire       [20:0]   _zz_s1_cmul3_recip_mul_t;
  wire       [21:0]   _zz_s1_cmul3_recip_out_r;
  wire       [13:0]   _zz_s1_cmul3_recip_out_rn_1;
  wire       [4:0]    _zz_s1_cmul3_recip_out_rn_2;
  wire       [17:0]   _zz_s1_cmul3_recip_out_rn_3;
  wire       [4:0]    _zz_s1_cmul3_recip_out_rn_4;
  wire       [17:0]   _zz_s1_cmul3_recip_out_0_nxt;
  wire       [17:0]   _zz_s1_cmul3_recip_out_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a0_re_0_nxt;
  wire       [35:0]   _zz_s0_r4_a0_re_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a0_re_0_nxt_2;
  wire       [35:0]   _zz_s0_r4_a0_im_0_nxt;
  wire       [35:0]   _zz_s0_r4_a0_im_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a0_im_0_nxt_2;
  wire       [35:0]   _zz_s0_r4_a1_re_0_nxt;
  wire       [35:0]   _zz_s0_r4_a1_re_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a1_re_0_nxt_2;
  wire       [35:0]   _zz_s0_r4_a1_im_0_nxt;
  wire       [35:0]   _zz_s0_r4_a1_im_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a1_im_0_nxt_2;
  wire       [35:0]   _zz_s0_r4_a2_re_0_nxt;
  wire       [35:0]   _zz_s0_r4_a2_re_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a2_re_0_nxt_2;
  wire       [35:0]   _zz_s0_r4_a2_im_0_nxt;
  wire       [35:0]   _zz_s0_r4_a2_im_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a2_im_0_nxt_2;
  wire       [35:0]   _zz_s0_r4_a3_re_0_nxt;
  wire       [35:0]   _zz_s0_r4_a3_re_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a3_re_0_nxt_2;
  wire       [35:0]   _zz_s0_r4_a3_im_0_nxt;
  wire       [35:0]   _zz_s0_r4_a3_im_0_nxt_1;
  wire       [35:0]   _zz_s0_r4_a3_im_0_nxt_2;
  wire       [35:0]   _zz_s0_r4_c0_re_0;
  wire       [35:0]   _zz_s0_r4_c0_re_0_1;
  wire       [35:0]   _zz_s0_r4_c0_re_0_2;
  wire       [35:0]   _zz_s0_r4_c0_im_0;
  wire       [35:0]   _zz_s0_r4_c0_im_0_1;
  wire       [35:0]   _zz_s0_r4_c0_im_0_2;
  wire       [35:0]   _zz_s0_r4_c1_re_0;
  wire       [35:0]   _zz_s0_r4_c1_re_0_1;
  wire       [35:0]   _zz_s0_r4_c1_re_0_2;
  wire       [35:0]   _zz_s0_r4_c1_im_0;
  wire       [35:0]   _zz_s0_r4_c1_im_0_1;
  wire       [35:0]   _zz_s0_r4_c1_im_0_2;
  wire       [35:0]   _zz_s0_r4_c2_re_0;
  wire       [35:0]   _zz_s0_r4_c2_re_0_1;
  wire       [35:0]   _zz_s0_r4_c2_re_0_2;
  wire       [35:0]   _zz_s0_r4_c2_im_0;
  wire       [35:0]   _zz_s0_r4_c2_im_0_1;
  wire       [35:0]   _zz_s0_r4_c2_im_0_2;
  wire       [35:0]   _zz_s0_r4_c3_re_0;
  wire       [35:0]   _zz_s0_r4_c3_re_0_1;
  wire       [35:0]   _zz_s0_r4_c3_re_0_2;
  wire       [35:0]   _zz_s0_r4_c3_im_0;
  wire       [35:0]   _zz_s0_r4_c3_im_0_1;
  wire       [35:0]   _zz_s0_r4_c3_im_0_2;
  wire       [35:0]   _zz_s1_r4_a0_re_0_nxt;
  wire       [35:0]   _zz_s1_r4_a0_re_0_nxt_1;
  wire       [35:0]   _zz_s1_r4_a0_re_0_nxt_2;
  wire       [35:0]   _zz_s1_r4_a0_im_0_nxt;
  wire       [35:0]   _zz_s1_r4_a0_im_0_nxt_1;
  wire       [35:0]   _zz_s1_r4_a0_im_0_nxt_2;
  wire       [35:0]   _zz_s1_r4_a1_re_0_nxt;
  wire       [35:0]   _zz_s1_r4_a1_re_0_nxt_1;
  wire       [35:0]   _zz_s1_r4_a1_re_0_nxt_2;
  wire       [35:0]   _zz_s1_r4_a1_im_0_nxt;
  wire       [35:0]   _zz_s1_r4_a1_im_0_nxt_1;
  wire       [35:0]   _zz_s1_r4_a1_im_0_nxt_2;
  wire       [35:0]   _zz_s1_r4_a2_re_0_nxt;
  wire       [35:0]   _zz_s1_r4_a2_re_0_nxt_1;
  wire       [35:0]   _zz_s1_r4_a2_re_0_nxt_2;
  wire       [35:0]   _zz_s1_r4_a2_im_0_nxt;
  wire       [35:0]   _zz_s1_r4_a2_im_0_nxt_1;
  wire       [35:0]   _zz_s1_r4_a2_im_0_nxt_2;
  wire       [35:0]   _zz_s1_r4_a3_re_0_nxt;
  wire       [35:0]   _zz_s1_r4_a3_re_0_nxt_1;
  wire       [35:0]   _zz_s1_r4_a3_re_0_nxt_2;
  wire       [35:0]   _zz_s1_r4_a3_im_0_nxt;
  wire       [35:0]   _zz_s1_r4_a3_im_0_nxt_1;
  wire       [35:0]   _zz_s1_r4_a3_im_0_nxt_2;
  wire       [35:0]   _zz_s1_r4_c0_re_0;
  wire       [35:0]   _zz_s1_r4_c0_re_0_1;
  wire       [35:0]   _zz_s1_r4_c0_re_0_2;
  wire       [35:0]   _zz_s1_r4_c0_im_0;
  wire       [35:0]   _zz_s1_r4_c0_im_0_1;
  wire       [35:0]   _zz_s1_r4_c0_im_0_2;
  wire       [35:0]   _zz_s1_r4_c1_re_0;
  wire       [35:0]   _zz_s1_r4_c1_re_0_1;
  wire       [35:0]   _zz_s1_r4_c1_re_0_2;
  wire       [35:0]   _zz_s1_r4_c1_im_0;
  wire       [35:0]   _zz_s1_r4_c1_im_0_1;
  wire       [35:0]   _zz_s1_r4_c1_im_0_2;
  wire       [35:0]   _zz_s1_r4_c2_re_0;
  wire       [35:0]   _zz_s1_r4_c2_re_0_1;
  wire       [35:0]   _zz_s1_r4_c2_re_0_2;
  wire       [35:0]   _zz_s1_r4_c2_im_0;
  wire       [35:0]   _zz_s1_r4_c2_im_0_1;
  wire       [35:0]   _zz_s1_r4_c2_im_0_2;
  wire       [35:0]   _zz_s1_r4_c3_re_0;
  wire       [35:0]   _zz_s1_r4_c3_re_0_1;
  wire       [35:0]   _zz_s1_r4_c3_re_0_2;
  wire       [35:0]   _zz_s1_r4_c3_im_0;
  wire       [35:0]   _zz_s1_r4_c3_im_0_1;
  wire       [35:0]   _zz_s1_r4_c3_im_0_2;
  wire       [511:0]  t_k8_0;
  wire                t_k8_0_req;
  wire                t_k8_0_ack;
  wire                t_k8_0_m_req;
  wire                t_k8_0_m_ack;
  wire                t_k8_0_to_k8_funnel_req;
  wire                t_k8_0_to_k8_funnel_ack;
  wire       [511:0]  t_k9_0;
  wire                t_k9_0_req;
  wire                t_k9_0_ack;
  wire                t_k9_0_m_req;
  wire                t_k9_0_m_ack;
  wire                t_k9_0_to_k9_funnel_req;
  wire                t_k9_0_to_k9_funnel_ack;
  wire       [511:0]  t_k14_0;
  wire                t_k14_0_req;
  wire                t_k14_0_ack;
  wire                t_k14_0_m_req;
  wire                t_k14_0_m_ack;
  wire                t_k14_0_to_cfg_req;
  wire                t_k14_0_to_cfg_ack;
  wire       [511:0]  k1_defunnel_0;
  wire       [511:0]  k1_defunnel_0_nxt;
  wire                k1_defunnel_0_req;
  wire                k1_defunnel_0_ack;
  wire                k1_defunnel_0_m_req;
  wire                k1_defunnel_0_m_ack;
  wire                k1_defunnel_0_to_i_k1_req;
  wire                k1_defunnel_0_to_i_k1_ack;
  wire       [127:0]  k8_funnel_0;
  wire       [127:0]  k8_funnel_0_nxt;
  wire                k8_funnel_0_req;
  wire                k8_funnel_0_ack;
  wire                k8_funnel_0_m_req;
  wire                k8_funnel_0_m_ack;
  wire                k8_funnel_0_to_s0_k8_slice_req;
  wire                k8_funnel_0_to_s0_k8_slice_ack;
  wire       [127:0]  k9_funnel_0;
  wire       [127:0]  k9_funnel_0_nxt;
  wire                k9_funnel_0_req;
  wire                k9_funnel_0_ack;
  wire                k9_funnel_0_m_req;
  wire                k9_funnel_0_m_ack;
  wire                k9_funnel_0_to_s0_k9_slice_req;
  wire                k9_funnel_0_to_s0_k9_slice_ack;
  wire       [17:0]   s0_k8_slice_0;
  wire                s0_k8_slice_0_req;
  wire                s0_k8_slice_0_ack;
  wire                s0_k8_slice_0_m_req;
  wire                s0_k8_slice_0_m_ack;
  wire                s0_k8_slice_0_to_s0_cmul0_m2c_ac_req;
  wire                s0_k8_slice_0_to_s0_cmul0_m2c_da_req;
  wire                s0_k8_slice_0_to_s0_cmul0_cat_re_req;
  wire                s0_k8_slice_0_to_s0_cmul0_m2c_ac_ack;
  wire                s0_k8_slice_0_to_s0_cmul0_m2c_da_ack;
  wire                s0_k8_slice_0_to_s0_cmul0_cat_re_ack;
  wire       [17:0]   s0_k8_slice_1;
  wire                s0_k8_slice_1_req;
  wire                s0_k8_slice_1_ack;
  wire                s0_k8_slice_1_m_req;
  wire                s0_k8_slice_1_m_ack;
  wire                s0_k8_slice_1_to_s0_cmul0_m2c_bc_req;
  wire                s0_k8_slice_1_to_s0_cmul0_m2c_bd_req;
  wire                s0_k8_slice_1_to_s0_cmul0_m2c_cb_req;
  wire                s0_k8_slice_1_to_s0_cmul0_m2c_bc_ack;
  wire                s0_k8_slice_1_to_s0_cmul0_m2c_bd_ack;
  wire                s0_k8_slice_1_to_s0_cmul0_m2c_cb_ack;
  wire       [17:0]   s0_k9_slice_0;
  wire                s0_k9_slice_0_req;
  wire                s0_k9_slice_0_ack;
  wire                s0_k9_slice_0_m_req;
  wire                s0_k9_slice_0_m_ack;
  wire                s0_k9_slice_0_to_s0_cmul0_m2c_ac_req;
  wire                s0_k9_slice_0_to_s0_cmul0_m2c_bc_req;
  wire                s0_k9_slice_0_to_s0_cmul0_m2c_cb_req;
  wire                s0_k9_slice_0_to_s0_cmul0_m2c_cd_req;
  wire                s0_k9_slice_0_to_s0_cmul0_recip_norm_req;
  wire                s0_k9_slice_0_to_s0_cmul0_m2c_ac_ack;
  wire                s0_k9_slice_0_to_s0_cmul0_m2c_bc_ack;
  wire                s0_k9_slice_0_to_s0_cmul0_m2c_cb_ack;
  wire                s0_k9_slice_0_to_s0_cmul0_m2c_cd_ack;
  wire                s0_k9_slice_0_to_s0_cmul0_recip_norm_ack;
  wire       [17:0]   s0_k9_slice_1;
  wire                s0_k9_slice_1_req;
  wire                s0_k9_slice_1_ack;
  wire                s0_k9_slice_1_m_req;
  wire                s0_k9_slice_1_m_ack;
  wire                s0_k9_slice_1_to_s0_cmul0_m2c_bd_req;
  wire                s0_k9_slice_1_to_s0_cmul0_m2c_cd_req;
  wire                s0_k9_slice_1_to_s0_cmul0_m2c_da_req;
  wire                s0_k9_slice_1_to_s0_cmul0_cat_im_req;
  wire                s0_k9_slice_1_to_s0_cmul0_m2c_bd_ack;
  wire                s0_k9_slice_1_to_s0_cmul0_m2c_cd_ack;
  wire                s0_k9_slice_1_to_s0_cmul0_m2c_da_ack;
  wire                s0_k9_slice_1_to_s0_cmul0_cat_im_ack;
  wire       [17:0]   s0_k8_slice_2;
  wire                s0_k8_slice_2_req;
  wire                s0_k8_slice_2_ack;
  wire                s0_k8_slice_2_m_req;
  wire                s0_k8_slice_2_m_ack;
  wire                s0_k8_slice_2_to_s0_cmul1_m2c_ac_req;
  wire                s0_k8_slice_2_to_s0_cmul1_m2c_da_req;
  wire                s0_k8_slice_2_to_s0_cmul1_cat_re_req;
  wire                s0_k8_slice_2_to_s0_cmul1_m2c_ac_ack;
  wire                s0_k8_slice_2_to_s0_cmul1_m2c_da_ack;
  wire                s0_k8_slice_2_to_s0_cmul1_cat_re_ack;
  wire       [17:0]   s0_k8_slice_3;
  wire                s0_k8_slice_3_req;
  wire                s0_k8_slice_3_ack;
  wire                s0_k8_slice_3_m_req;
  wire                s0_k8_slice_3_m_ack;
  wire                s0_k8_slice_3_to_s0_cmul1_m2c_bc_req;
  wire                s0_k8_slice_3_to_s0_cmul1_m2c_bd_req;
  wire                s0_k8_slice_3_to_s0_cmul1_m2c_cb_req;
  wire                s0_k8_slice_3_to_s0_cmul1_m2c_bc_ack;
  wire                s0_k8_slice_3_to_s0_cmul1_m2c_bd_ack;
  wire                s0_k8_slice_3_to_s0_cmul1_m2c_cb_ack;
  wire       [17:0]   s0_k9_slice_2;
  wire                s0_k9_slice_2_req;
  wire                s0_k9_slice_2_ack;
  wire                s0_k9_slice_2_m_req;
  wire                s0_k9_slice_2_m_ack;
  wire                s0_k9_slice_2_to_s0_cmul1_m2c_ac_req;
  wire                s0_k9_slice_2_to_s0_cmul1_m2c_bc_req;
  wire                s0_k9_slice_2_to_s0_cmul1_m2c_cb_req;
  wire                s0_k9_slice_2_to_s0_cmul1_m2c_cd_req;
  wire                s0_k9_slice_2_to_s0_cmul1_recip_norm_req;
  wire                s0_k9_slice_2_to_s0_cmul1_m2c_ac_ack;
  wire                s0_k9_slice_2_to_s0_cmul1_m2c_bc_ack;
  wire                s0_k9_slice_2_to_s0_cmul1_m2c_cb_ack;
  wire                s0_k9_slice_2_to_s0_cmul1_m2c_cd_ack;
  wire                s0_k9_slice_2_to_s0_cmul1_recip_norm_ack;
  wire       [17:0]   s0_k9_slice_3;
  wire                s0_k9_slice_3_req;
  wire                s0_k9_slice_3_ack;
  wire                s0_k9_slice_3_m_req;
  wire                s0_k9_slice_3_m_ack;
  wire                s0_k9_slice_3_to_s0_cmul1_m2c_bd_req;
  wire                s0_k9_slice_3_to_s0_cmul1_m2c_cd_req;
  wire                s0_k9_slice_3_to_s0_cmul1_m2c_da_req;
  wire                s0_k9_slice_3_to_s0_cmul1_cat_im_req;
  wire                s0_k9_slice_3_to_s0_cmul1_m2c_bd_ack;
  wire                s0_k9_slice_3_to_s0_cmul1_m2c_cd_ack;
  wire                s0_k9_slice_3_to_s0_cmul1_m2c_da_ack;
  wire                s0_k9_slice_3_to_s0_cmul1_cat_im_ack;
  wire       [17:0]   s0_k8_slice_4;
  wire                s0_k8_slice_4_req;
  wire                s0_k8_slice_4_ack;
  wire                s0_k8_slice_4_m_req;
  wire                s0_k8_slice_4_m_ack;
  wire                s0_k8_slice_4_to_s0_cmul2_m2c_ac_req;
  wire                s0_k8_slice_4_to_s0_cmul2_m2c_da_req;
  wire                s0_k8_slice_4_to_s0_cmul2_cat_re_req;
  wire                s0_k8_slice_4_to_s0_cmul2_m2c_ac_ack;
  wire                s0_k8_slice_4_to_s0_cmul2_m2c_da_ack;
  wire                s0_k8_slice_4_to_s0_cmul2_cat_re_ack;
  wire       [17:0]   s0_k8_slice_5;
  wire                s0_k8_slice_5_req;
  wire                s0_k8_slice_5_ack;
  wire                s0_k8_slice_5_m_req;
  wire                s0_k8_slice_5_m_ack;
  wire                s0_k8_slice_5_to_s0_cmul2_m2c_bc_req;
  wire                s0_k8_slice_5_to_s0_cmul2_m2c_bd_req;
  wire                s0_k8_slice_5_to_s0_cmul2_m2c_cb_req;
  wire                s0_k8_slice_5_to_s0_cmul2_m2c_bc_ack;
  wire                s0_k8_slice_5_to_s0_cmul2_m2c_bd_ack;
  wire                s0_k8_slice_5_to_s0_cmul2_m2c_cb_ack;
  wire       [17:0]   s0_k9_slice_4;
  wire                s0_k9_slice_4_req;
  wire                s0_k9_slice_4_ack;
  wire                s0_k9_slice_4_m_req;
  wire                s0_k9_slice_4_m_ack;
  wire                s0_k9_slice_4_to_s0_cmul2_m2c_ac_req;
  wire                s0_k9_slice_4_to_s0_cmul2_m2c_bc_req;
  wire                s0_k9_slice_4_to_s0_cmul2_m2c_cb_req;
  wire                s0_k9_slice_4_to_s0_cmul2_m2c_cd_req;
  wire                s0_k9_slice_4_to_s0_cmul2_recip_norm_req;
  wire                s0_k9_slice_4_to_s0_cmul2_m2c_ac_ack;
  wire                s0_k9_slice_4_to_s0_cmul2_m2c_bc_ack;
  wire                s0_k9_slice_4_to_s0_cmul2_m2c_cb_ack;
  wire                s0_k9_slice_4_to_s0_cmul2_m2c_cd_ack;
  wire                s0_k9_slice_4_to_s0_cmul2_recip_norm_ack;
  wire       [17:0]   s0_k9_slice_5;
  wire                s0_k9_slice_5_req;
  wire                s0_k9_slice_5_ack;
  wire                s0_k9_slice_5_m_req;
  wire                s0_k9_slice_5_m_ack;
  wire                s0_k9_slice_5_to_s0_cmul2_m2c_bd_req;
  wire                s0_k9_slice_5_to_s0_cmul2_m2c_cd_req;
  wire                s0_k9_slice_5_to_s0_cmul2_m2c_da_req;
  wire                s0_k9_slice_5_to_s0_cmul2_cat_im_req;
  wire                s0_k9_slice_5_to_s0_cmul2_m2c_bd_ack;
  wire                s0_k9_slice_5_to_s0_cmul2_m2c_cd_ack;
  wire                s0_k9_slice_5_to_s0_cmul2_m2c_da_ack;
  wire                s0_k9_slice_5_to_s0_cmul2_cat_im_ack;
  wire       [17:0]   s0_k8_slice_6;
  wire                s0_k8_slice_6_req;
  wire                s0_k8_slice_6_ack;
  wire                s0_k8_slice_6_m_req;
  wire                s0_k8_slice_6_m_ack;
  wire                s0_k8_slice_6_to_s0_cmul3_m2c_ac_req;
  wire                s0_k8_slice_6_to_s0_cmul3_m2c_da_req;
  wire                s0_k8_slice_6_to_s0_cmul3_cat_re_req;
  wire                s0_k8_slice_6_to_s0_cmul3_m2c_ac_ack;
  wire                s0_k8_slice_6_to_s0_cmul3_m2c_da_ack;
  wire                s0_k8_slice_6_to_s0_cmul3_cat_re_ack;
  wire       [17:0]   s0_k8_slice_7;
  wire                s0_k8_slice_7_req;
  wire                s0_k8_slice_7_ack;
  wire                s0_k8_slice_7_m_req;
  wire                s0_k8_slice_7_m_ack;
  wire                s0_k8_slice_7_to_s0_cmul3_m2c_bc_req;
  wire                s0_k8_slice_7_to_s0_cmul3_m2c_bd_req;
  wire                s0_k8_slice_7_to_s0_cmul3_m2c_cb_req;
  wire                s0_k8_slice_7_to_s0_cmul3_m2c_bc_ack;
  wire                s0_k8_slice_7_to_s0_cmul3_m2c_bd_ack;
  wire                s0_k8_slice_7_to_s0_cmul3_m2c_cb_ack;
  wire       [17:0]   s0_k9_slice_6;
  wire                s0_k9_slice_6_req;
  wire                s0_k9_slice_6_ack;
  wire                s0_k9_slice_6_m_req;
  wire                s0_k9_slice_6_m_ack;
  wire                s0_k9_slice_6_to_s0_cmul3_m2c_ac_req;
  wire                s0_k9_slice_6_to_s0_cmul3_m2c_bc_req;
  wire                s0_k9_slice_6_to_s0_cmul3_m2c_cb_req;
  wire                s0_k9_slice_6_to_s0_cmul3_m2c_cd_req;
  wire                s0_k9_slice_6_to_s0_cmul3_recip_norm_req;
  wire                s0_k9_slice_6_to_s0_cmul3_m2c_ac_ack;
  wire                s0_k9_slice_6_to_s0_cmul3_m2c_bc_ack;
  wire                s0_k9_slice_6_to_s0_cmul3_m2c_cb_ack;
  wire                s0_k9_slice_6_to_s0_cmul3_m2c_cd_ack;
  wire                s0_k9_slice_6_to_s0_cmul3_recip_norm_ack;
  wire       [17:0]   s0_k9_slice_7;
  wire                s0_k9_slice_7_req;
  wire                s0_k9_slice_7_ack;
  wire                s0_k9_slice_7_m_req;
  wire                s0_k9_slice_7_m_ack;
  wire                s0_k9_slice_7_to_s0_cmul3_m2c_bd_req;
  wire                s0_k9_slice_7_to_s0_cmul3_m2c_cd_req;
  wire                s0_k9_slice_7_to_s0_cmul3_m2c_da_req;
  wire                s0_k9_slice_7_to_s0_cmul3_cat_im_req;
  wire                s0_k9_slice_7_to_s0_cmul3_m2c_bd_ack;
  wire                s0_k9_slice_7_to_s0_cmul3_m2c_cd_ack;
  wire                s0_k9_slice_7_to_s0_cmul3_m2c_da_ack;
  wire                s0_k9_slice_7_to_s0_cmul3_cat_im_ack;
  wire       [16:0]   s0_cmul0_recip_norm_0;
  wire       [16:0]   s0_cmul0_recip_norm_0_nxt;
  wire                s0_cmul0_recip_norm_0_req;
  wire                s0_cmul0_recip_norm_0_ack;
  wire                s0_cmul0_recip_norm_0_m_req;
  wire                s0_cmul0_recip_norm_0_m_ack;
  wire                s0_cmul0_recip_norm_0_to_s0_cmul0_recip_mul_req;
  wire                s0_cmul0_recip_norm_0_to_s0_cmul0_recip_mul_ack;
  wire       [28:0]   s0_cmul0_recip_mul_0;
  wire       [28:0]   s0_cmul0_recip_mul_0_nxt;
  wire                s0_cmul0_recip_mul_0_req;
  wire                s0_cmul0_recip_mul_0_ack;
  wire                s0_cmul0_recip_mul_0_m_req;
  wire                s0_cmul0_recip_mul_0_m_ack;
  wire                s0_cmul0_recip_mul_0_to_s0_cmul0_recip_out_req;
  wire                s0_cmul0_recip_mul_0_to_s0_cmul0_recip_out_ack;
  wire       [17:0]   s0_cmul0_recip_out_0;
  wire       [17:0]   s0_cmul0_recip_out_0_nxt;
  wire                s0_cmul0_recip_out_0_req;
  wire                s0_cmul0_recip_out_0_ack;
  wire                s0_cmul0_recip_out_0_m_req;
  wire                s0_cmul0_recip_out_0_m_ack;
  wire                s0_cmul0_recip_out_0_to_s0_cmul0_m2c_ac_req;
  wire                s0_cmul0_recip_out_0_to_s0_cmul0_m2c_cd_req;
  wire                s0_cmul0_recip_out_0_to_s0_cmul0_m2c_ac_ack;
  wire                s0_cmul0_recip_out_0_to_s0_cmul0_m2c_cd_ack;
  wire       [1:0]    cfg_s0_cmul0_m2c_ac;
  wire                cfg_s0_cmul0_m2c_ac_req;
  wire                cfg_s0_cmul0_m2c_ac_ack;
  wire                cfg_s0_cmul0_m2c_ac_m_req;
  wire                cfg_s0_cmul0_m2c_ac_m_ack;
  wire                cfg_s0_cmul0_m2c_ac_to_s0_cmul0_m2c_ac_req;
  wire                cfg_s0_cmul0_m2c_ac_to_s0_cmul0_m2c_ac_ack;
  wire       [17:0]   s0_cmul0_m2c_ac_0;
  wire                s0_cmul0_m2c_ac_0_req;
  wire                s0_cmul0_m2c_ac_0_ack;
  wire                s0_cmul0_m2c_ac_0_m_req;
  wire                s0_cmul0_m2c_ac_0_m_ack;
  wire                s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_req;
  wire                s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul0_m2c_bc;
  wire                cfg_s0_cmul0_m2c_bc_req;
  wire                cfg_s0_cmul0_m2c_bc_ack;
  wire                cfg_s0_cmul0_m2c_bc_m_req;
  wire                cfg_s0_cmul0_m2c_bc_m_ack;
  wire                cfg_s0_cmul0_m2c_bc_to_s0_cmul0_m2c_bc_req;
  wire                cfg_s0_cmul0_m2c_bc_to_s0_cmul0_m2c_bc_ack;
  wire       [17:0]   s0_cmul0_m2c_bc_0;
  wire                s0_cmul0_m2c_bc_0_req;
  wire                s0_cmul0_m2c_bc_0_ack;
  wire                s0_cmul0_m2c_bc_0_m_req;
  wire                s0_cmul0_m2c_bc_0_m_ack;
  wire                s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_req;
  wire                s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul0_m2c_bd;
  wire                cfg_s0_cmul0_m2c_bd_req;
  wire                cfg_s0_cmul0_m2c_bd_ack;
  wire                cfg_s0_cmul0_m2c_bd_m_req;
  wire                cfg_s0_cmul0_m2c_bd_m_ack;
  wire                cfg_s0_cmul0_m2c_bd_to_s0_cmul0_m2c_bd_req;
  wire                cfg_s0_cmul0_m2c_bd_to_s0_cmul0_m2c_bd_ack;
  wire       [17:0]   s0_cmul0_m2c_bd_0;
  wire                s0_cmul0_m2c_bd_0_req;
  wire                s0_cmul0_m2c_bd_0_ack;
  wire                s0_cmul0_m2c_bd_0_m_req;
  wire                s0_cmul0_m2c_bd_0_m_ack;
  wire                s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_req;
  wire                s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul0_m2c_cb;
  wire                cfg_s0_cmul0_m2c_cb_req;
  wire                cfg_s0_cmul0_m2c_cb_ack;
  wire                cfg_s0_cmul0_m2c_cb_m_req;
  wire                cfg_s0_cmul0_m2c_cb_m_ack;
  wire                cfg_s0_cmul0_m2c_cb_to_s0_cmul0_m2c_cb_req;
  wire                cfg_s0_cmul0_m2c_cb_to_s0_cmul0_m2c_cb_ack;
  wire       [17:0]   s0_cmul0_m2c_cb_0;
  wire                s0_cmul0_m2c_cb_0_req;
  wire                s0_cmul0_m2c_cb_0_ack;
  wire                s0_cmul0_m2c_cb_0_m_req;
  wire                s0_cmul0_m2c_cb_0_m_ack;
  wire                s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_req;
  wire                s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_ack;
  wire       [1:0]    cfg_s0_cmul0_m2c_cd;
  wire                cfg_s0_cmul0_m2c_cd_req;
  wire                cfg_s0_cmul0_m2c_cd_ack;
  wire                cfg_s0_cmul0_m2c_cd_m_req;
  wire                cfg_s0_cmul0_m2c_cd_m_ack;
  wire                cfg_s0_cmul0_m2c_cd_to_s0_cmul0_m2c_cd_req;
  wire                cfg_s0_cmul0_m2c_cd_to_s0_cmul0_m2c_cd_ack;
  wire       [17:0]   s0_cmul0_m2c_cd_0;
  wire                s0_cmul0_m2c_cd_0_req;
  wire                s0_cmul0_m2c_cd_0_ack;
  wire                s0_cmul0_m2c_cd_0_m_req;
  wire                s0_cmul0_m2c_cd_0_m_ack;
  wire                s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_req;
  wire                s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_ack;
  wire       [1:0]    cfg_s0_cmul0_m2c_da;
  wire                cfg_s0_cmul0_m2c_da_req;
  wire                cfg_s0_cmul0_m2c_da_ack;
  wire                cfg_s0_cmul0_m2c_da_m_req;
  wire                cfg_s0_cmul0_m2c_da_m_ack;
  wire                cfg_s0_cmul0_m2c_da_to_s0_cmul0_m2c_da_req;
  wire                cfg_s0_cmul0_m2c_da_to_s0_cmul0_m2c_da_ack;
  wire       [17:0]   s0_cmul0_m2c_da_0;
  wire                s0_cmul0_m2c_da_0_req;
  wire                s0_cmul0_m2c_da_0_ack;
  wire                s0_cmul0_m2c_da_0_m_req;
  wire                s0_cmul0_m2c_da_0_m_ack;
  wire                s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_req;
  wire                s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_ack;
  wire       [71:0]   s0_cmul0_cat_re_0;
  wire       [71:0]   s0_cmul0_cat_re_0_nxt;
  wire                s0_cmul0_cat_re_0_req;
  wire                s0_cmul0_cat_re_0_ack;
  wire                s0_cmul0_cat_re_0_m_req;
  wire                s0_cmul0_cat_re_0_m_ack;
  wire                s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_req;
  wire                s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_ack;
  wire       [71:0]   s0_cmul0_cat_im_0;
  wire       [71:0]   s0_cmul0_cat_im_0_nxt;
  wire                s0_cmul0_cat_im_0_req;
  wire                s0_cmul0_cat_im_0_ack;
  wire                s0_cmul0_cat_im_0_m_req;
  wire                s0_cmul0_cat_im_0_m_ack;
  wire                s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_req;
  wire                s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_ack;
  wire       [1:0]    cfg_s0_cmul0_mas_re;
  wire                cfg_s0_cmul0_mas_re_req;
  wire                cfg_s0_cmul0_mas_re_ack;
  wire                cfg_s0_cmul0_mas_re_m_req;
  wire                cfg_s0_cmul0_mas_re_m_ack;
  wire                cfg_s0_cmul0_mas_re_to_s0_cmul0_mas_re_req;
  wire                cfg_s0_cmul0_mas_re_to_s0_cmul0_mas_re_ack;
  wire       [35:0]   s0_cmul0_mas_re_0;
  wire                s0_cmul0_mas_re_0_req;
  wire                s0_cmul0_mas_re_0_ack;
  wire                s0_cmul0_mas_re_0_m_req;
  wire                s0_cmul0_mas_re_0_m_ack;
  wire                s0_cmul0_mas_re_0_to_s0_r4_a0_re_req;
  wire                s0_cmul0_mas_re_0_to_s0_r4_a2_re_req;
  wire                s0_cmul0_mas_re_0_to_s0_r4_byp0_re_req;
  wire                s0_cmul0_mas_re_0_to_s0_r4_a0_re_ack;
  wire                s0_cmul0_mas_re_0_to_s0_r4_a2_re_ack;
  wire                s0_cmul0_mas_re_0_to_s0_r4_byp0_re_ack;
  wire       [1:0]    cfg_s0_cmul0_mas_im;
  wire                cfg_s0_cmul0_mas_im_req;
  wire                cfg_s0_cmul0_mas_im_ack;
  wire                cfg_s0_cmul0_mas_im_m_req;
  wire                cfg_s0_cmul0_mas_im_m_ack;
  wire                cfg_s0_cmul0_mas_im_to_s0_cmul0_mas_im_req;
  wire                cfg_s0_cmul0_mas_im_to_s0_cmul0_mas_im_ack;
  wire       [35:0]   s0_cmul0_mas_im_0;
  wire                s0_cmul0_mas_im_0_req;
  wire                s0_cmul0_mas_im_0_ack;
  wire                s0_cmul0_mas_im_0_m_req;
  wire                s0_cmul0_mas_im_0_m_ack;
  wire                s0_cmul0_mas_im_0_to_s0_r4_a0_im_req;
  wire                s0_cmul0_mas_im_0_to_s0_r4_a2_im_req;
  wire                s0_cmul0_mas_im_0_to_s0_r4_byp0_im_req;
  wire                s0_cmul0_mas_im_0_to_s0_r4_a0_im_ack;
  wire                s0_cmul0_mas_im_0_to_s0_r4_a2_im_ack;
  wire                s0_cmul0_mas_im_0_to_s0_r4_byp0_im_ack;
  wire       [16:0]   s0_cmul1_recip_norm_0;
  wire       [16:0]   s0_cmul1_recip_norm_0_nxt;
  wire                s0_cmul1_recip_norm_0_req;
  wire                s0_cmul1_recip_norm_0_ack;
  wire                s0_cmul1_recip_norm_0_m_req;
  wire                s0_cmul1_recip_norm_0_m_ack;
  wire                s0_cmul1_recip_norm_0_to_s0_cmul1_recip_mul_req;
  wire                s0_cmul1_recip_norm_0_to_s0_cmul1_recip_mul_ack;
  wire       [28:0]   s0_cmul1_recip_mul_0;
  wire       [28:0]   s0_cmul1_recip_mul_0_nxt;
  wire                s0_cmul1_recip_mul_0_req;
  wire                s0_cmul1_recip_mul_0_ack;
  wire                s0_cmul1_recip_mul_0_m_req;
  wire                s0_cmul1_recip_mul_0_m_ack;
  wire                s0_cmul1_recip_mul_0_to_s0_cmul1_recip_out_req;
  wire                s0_cmul1_recip_mul_0_to_s0_cmul1_recip_out_ack;
  wire       [17:0]   s0_cmul1_recip_out_0;
  wire       [17:0]   s0_cmul1_recip_out_0_nxt;
  wire                s0_cmul1_recip_out_0_req;
  wire                s0_cmul1_recip_out_0_ack;
  wire                s0_cmul1_recip_out_0_m_req;
  wire                s0_cmul1_recip_out_0_m_ack;
  wire                s0_cmul1_recip_out_0_to_s0_cmul1_m2c_ac_req;
  wire                s0_cmul1_recip_out_0_to_s0_cmul1_m2c_cd_req;
  wire                s0_cmul1_recip_out_0_to_s0_cmul1_m2c_ac_ack;
  wire                s0_cmul1_recip_out_0_to_s0_cmul1_m2c_cd_ack;
  wire       [1:0]    cfg_s0_cmul1_m2c_ac;
  wire                cfg_s0_cmul1_m2c_ac_req;
  wire                cfg_s0_cmul1_m2c_ac_ack;
  wire                cfg_s0_cmul1_m2c_ac_m_req;
  wire                cfg_s0_cmul1_m2c_ac_m_ack;
  wire                cfg_s0_cmul1_m2c_ac_to_s0_cmul1_m2c_ac_req;
  wire                cfg_s0_cmul1_m2c_ac_to_s0_cmul1_m2c_ac_ack;
  wire       [17:0]   s0_cmul1_m2c_ac_0;
  wire                s0_cmul1_m2c_ac_0_req;
  wire                s0_cmul1_m2c_ac_0_ack;
  wire                s0_cmul1_m2c_ac_0_m_req;
  wire                s0_cmul1_m2c_ac_0_m_ack;
  wire                s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_req;
  wire                s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul1_m2c_bc;
  wire                cfg_s0_cmul1_m2c_bc_req;
  wire                cfg_s0_cmul1_m2c_bc_ack;
  wire                cfg_s0_cmul1_m2c_bc_m_req;
  wire                cfg_s0_cmul1_m2c_bc_m_ack;
  wire                cfg_s0_cmul1_m2c_bc_to_s0_cmul1_m2c_bc_req;
  wire                cfg_s0_cmul1_m2c_bc_to_s0_cmul1_m2c_bc_ack;
  wire       [17:0]   s0_cmul1_m2c_bc_0;
  wire                s0_cmul1_m2c_bc_0_req;
  wire                s0_cmul1_m2c_bc_0_ack;
  wire                s0_cmul1_m2c_bc_0_m_req;
  wire                s0_cmul1_m2c_bc_0_m_ack;
  wire                s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_req;
  wire                s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul1_m2c_bd;
  wire                cfg_s0_cmul1_m2c_bd_req;
  wire                cfg_s0_cmul1_m2c_bd_ack;
  wire                cfg_s0_cmul1_m2c_bd_m_req;
  wire                cfg_s0_cmul1_m2c_bd_m_ack;
  wire                cfg_s0_cmul1_m2c_bd_to_s0_cmul1_m2c_bd_req;
  wire                cfg_s0_cmul1_m2c_bd_to_s0_cmul1_m2c_bd_ack;
  wire       [17:0]   s0_cmul1_m2c_bd_0;
  wire                s0_cmul1_m2c_bd_0_req;
  wire                s0_cmul1_m2c_bd_0_ack;
  wire                s0_cmul1_m2c_bd_0_m_req;
  wire                s0_cmul1_m2c_bd_0_m_ack;
  wire                s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_req;
  wire                s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul1_m2c_cb;
  wire                cfg_s0_cmul1_m2c_cb_req;
  wire                cfg_s0_cmul1_m2c_cb_ack;
  wire                cfg_s0_cmul1_m2c_cb_m_req;
  wire                cfg_s0_cmul1_m2c_cb_m_ack;
  wire                cfg_s0_cmul1_m2c_cb_to_s0_cmul1_m2c_cb_req;
  wire                cfg_s0_cmul1_m2c_cb_to_s0_cmul1_m2c_cb_ack;
  wire       [17:0]   s0_cmul1_m2c_cb_0;
  wire                s0_cmul1_m2c_cb_0_req;
  wire                s0_cmul1_m2c_cb_0_ack;
  wire                s0_cmul1_m2c_cb_0_m_req;
  wire                s0_cmul1_m2c_cb_0_m_ack;
  wire                s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_req;
  wire                s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_ack;
  wire       [1:0]    cfg_s0_cmul1_m2c_cd;
  wire                cfg_s0_cmul1_m2c_cd_req;
  wire                cfg_s0_cmul1_m2c_cd_ack;
  wire                cfg_s0_cmul1_m2c_cd_m_req;
  wire                cfg_s0_cmul1_m2c_cd_m_ack;
  wire                cfg_s0_cmul1_m2c_cd_to_s0_cmul1_m2c_cd_req;
  wire                cfg_s0_cmul1_m2c_cd_to_s0_cmul1_m2c_cd_ack;
  wire       [17:0]   s0_cmul1_m2c_cd_0;
  wire                s0_cmul1_m2c_cd_0_req;
  wire                s0_cmul1_m2c_cd_0_ack;
  wire                s0_cmul1_m2c_cd_0_m_req;
  wire                s0_cmul1_m2c_cd_0_m_ack;
  wire                s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_req;
  wire                s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_ack;
  wire       [1:0]    cfg_s0_cmul1_m2c_da;
  wire                cfg_s0_cmul1_m2c_da_req;
  wire                cfg_s0_cmul1_m2c_da_ack;
  wire                cfg_s0_cmul1_m2c_da_m_req;
  wire                cfg_s0_cmul1_m2c_da_m_ack;
  wire                cfg_s0_cmul1_m2c_da_to_s0_cmul1_m2c_da_req;
  wire                cfg_s0_cmul1_m2c_da_to_s0_cmul1_m2c_da_ack;
  wire       [17:0]   s0_cmul1_m2c_da_0;
  wire                s0_cmul1_m2c_da_0_req;
  wire                s0_cmul1_m2c_da_0_ack;
  wire                s0_cmul1_m2c_da_0_m_req;
  wire                s0_cmul1_m2c_da_0_m_ack;
  wire                s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_req;
  wire                s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_ack;
  wire       [71:0]   s0_cmul1_cat_re_0;
  wire       [71:0]   s0_cmul1_cat_re_0_nxt;
  wire                s0_cmul1_cat_re_0_req;
  wire                s0_cmul1_cat_re_0_ack;
  wire                s0_cmul1_cat_re_0_m_req;
  wire                s0_cmul1_cat_re_0_m_ack;
  wire                s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_req;
  wire                s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_ack;
  wire       [71:0]   s0_cmul1_cat_im_0;
  wire       [71:0]   s0_cmul1_cat_im_0_nxt;
  wire                s0_cmul1_cat_im_0_req;
  wire                s0_cmul1_cat_im_0_ack;
  wire                s0_cmul1_cat_im_0_m_req;
  wire                s0_cmul1_cat_im_0_m_ack;
  wire                s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_req;
  wire                s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_ack;
  wire       [1:0]    cfg_s0_cmul1_mas_re;
  wire                cfg_s0_cmul1_mas_re_req;
  wire                cfg_s0_cmul1_mas_re_ack;
  wire                cfg_s0_cmul1_mas_re_m_req;
  wire                cfg_s0_cmul1_mas_re_m_ack;
  wire                cfg_s0_cmul1_mas_re_to_s0_cmul1_mas_re_req;
  wire                cfg_s0_cmul1_mas_re_to_s0_cmul1_mas_re_ack;
  wire       [35:0]   s0_cmul1_mas_re_0;
  wire                s0_cmul1_mas_re_0_req;
  wire                s0_cmul1_mas_re_0_ack;
  wire                s0_cmul1_mas_re_0_m_req;
  wire                s0_cmul1_mas_re_0_m_ack;
  wire                s0_cmul1_mas_re_0_to_s0_r4_a1_re_req;
  wire                s0_cmul1_mas_re_0_to_s0_r4_a3_re_req;
  wire                s0_cmul1_mas_re_0_to_s0_r4_byp1_re_req;
  wire                s0_cmul1_mas_re_0_to_s0_r4_a1_re_ack;
  wire                s0_cmul1_mas_re_0_to_s0_r4_a3_re_ack;
  wire                s0_cmul1_mas_re_0_to_s0_r4_byp1_re_ack;
  wire       [1:0]    cfg_s0_cmul1_mas_im;
  wire                cfg_s0_cmul1_mas_im_req;
  wire                cfg_s0_cmul1_mas_im_ack;
  wire                cfg_s0_cmul1_mas_im_m_req;
  wire                cfg_s0_cmul1_mas_im_m_ack;
  wire                cfg_s0_cmul1_mas_im_to_s0_cmul1_mas_im_req;
  wire                cfg_s0_cmul1_mas_im_to_s0_cmul1_mas_im_ack;
  wire       [35:0]   s0_cmul1_mas_im_0;
  wire                s0_cmul1_mas_im_0_req;
  wire                s0_cmul1_mas_im_0_ack;
  wire                s0_cmul1_mas_im_0_m_req;
  wire                s0_cmul1_mas_im_0_m_ack;
  wire                s0_cmul1_mas_im_0_to_s0_r4_a1_im_req;
  wire                s0_cmul1_mas_im_0_to_s0_r4_a3_im_req;
  wire                s0_cmul1_mas_im_0_to_s0_r4_byp1_im_req;
  wire                s0_cmul1_mas_im_0_to_s0_r4_a1_im_ack;
  wire                s0_cmul1_mas_im_0_to_s0_r4_a3_im_ack;
  wire                s0_cmul1_mas_im_0_to_s0_r4_byp1_im_ack;
  wire       [16:0]   s0_cmul2_recip_norm_0;
  wire       [16:0]   s0_cmul2_recip_norm_0_nxt;
  wire                s0_cmul2_recip_norm_0_req;
  wire                s0_cmul2_recip_norm_0_ack;
  wire                s0_cmul2_recip_norm_0_m_req;
  wire                s0_cmul2_recip_norm_0_m_ack;
  wire                s0_cmul2_recip_norm_0_to_s0_cmul2_recip_mul_req;
  wire                s0_cmul2_recip_norm_0_to_s0_cmul2_recip_mul_ack;
  wire       [28:0]   s0_cmul2_recip_mul_0;
  wire       [28:0]   s0_cmul2_recip_mul_0_nxt;
  wire                s0_cmul2_recip_mul_0_req;
  wire                s0_cmul2_recip_mul_0_ack;
  wire                s0_cmul2_recip_mul_0_m_req;
  wire                s0_cmul2_recip_mul_0_m_ack;
  wire                s0_cmul2_recip_mul_0_to_s0_cmul2_recip_out_req;
  wire                s0_cmul2_recip_mul_0_to_s0_cmul2_recip_out_ack;
  wire       [17:0]   s0_cmul2_recip_out_0;
  wire       [17:0]   s0_cmul2_recip_out_0_nxt;
  wire                s0_cmul2_recip_out_0_req;
  wire                s0_cmul2_recip_out_0_ack;
  wire                s0_cmul2_recip_out_0_m_req;
  wire                s0_cmul2_recip_out_0_m_ack;
  wire                s0_cmul2_recip_out_0_to_s0_cmul2_m2c_ac_req;
  wire                s0_cmul2_recip_out_0_to_s0_cmul2_m2c_cd_req;
  wire                s0_cmul2_recip_out_0_to_s0_cmul2_m2c_ac_ack;
  wire                s0_cmul2_recip_out_0_to_s0_cmul2_m2c_cd_ack;
  wire       [1:0]    cfg_s0_cmul2_m2c_ac;
  wire                cfg_s0_cmul2_m2c_ac_req;
  wire                cfg_s0_cmul2_m2c_ac_ack;
  wire                cfg_s0_cmul2_m2c_ac_m_req;
  wire                cfg_s0_cmul2_m2c_ac_m_ack;
  wire                cfg_s0_cmul2_m2c_ac_to_s0_cmul2_m2c_ac_req;
  wire                cfg_s0_cmul2_m2c_ac_to_s0_cmul2_m2c_ac_ack;
  wire       [17:0]   s0_cmul2_m2c_ac_0;
  wire                s0_cmul2_m2c_ac_0_req;
  wire                s0_cmul2_m2c_ac_0_ack;
  wire                s0_cmul2_m2c_ac_0_m_req;
  wire                s0_cmul2_m2c_ac_0_m_ack;
  wire                s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_req;
  wire                s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul2_m2c_bc;
  wire                cfg_s0_cmul2_m2c_bc_req;
  wire                cfg_s0_cmul2_m2c_bc_ack;
  wire                cfg_s0_cmul2_m2c_bc_m_req;
  wire                cfg_s0_cmul2_m2c_bc_m_ack;
  wire                cfg_s0_cmul2_m2c_bc_to_s0_cmul2_m2c_bc_req;
  wire                cfg_s0_cmul2_m2c_bc_to_s0_cmul2_m2c_bc_ack;
  wire       [17:0]   s0_cmul2_m2c_bc_0;
  wire                s0_cmul2_m2c_bc_0_req;
  wire                s0_cmul2_m2c_bc_0_ack;
  wire                s0_cmul2_m2c_bc_0_m_req;
  wire                s0_cmul2_m2c_bc_0_m_ack;
  wire                s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_req;
  wire                s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul2_m2c_bd;
  wire                cfg_s0_cmul2_m2c_bd_req;
  wire                cfg_s0_cmul2_m2c_bd_ack;
  wire                cfg_s0_cmul2_m2c_bd_m_req;
  wire                cfg_s0_cmul2_m2c_bd_m_ack;
  wire                cfg_s0_cmul2_m2c_bd_to_s0_cmul2_m2c_bd_req;
  wire                cfg_s0_cmul2_m2c_bd_to_s0_cmul2_m2c_bd_ack;
  wire       [17:0]   s0_cmul2_m2c_bd_0;
  wire                s0_cmul2_m2c_bd_0_req;
  wire                s0_cmul2_m2c_bd_0_ack;
  wire                s0_cmul2_m2c_bd_0_m_req;
  wire                s0_cmul2_m2c_bd_0_m_ack;
  wire                s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_req;
  wire                s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul2_m2c_cb;
  wire                cfg_s0_cmul2_m2c_cb_req;
  wire                cfg_s0_cmul2_m2c_cb_ack;
  wire                cfg_s0_cmul2_m2c_cb_m_req;
  wire                cfg_s0_cmul2_m2c_cb_m_ack;
  wire                cfg_s0_cmul2_m2c_cb_to_s0_cmul2_m2c_cb_req;
  wire                cfg_s0_cmul2_m2c_cb_to_s0_cmul2_m2c_cb_ack;
  wire       [17:0]   s0_cmul2_m2c_cb_0;
  wire                s0_cmul2_m2c_cb_0_req;
  wire                s0_cmul2_m2c_cb_0_ack;
  wire                s0_cmul2_m2c_cb_0_m_req;
  wire                s0_cmul2_m2c_cb_0_m_ack;
  wire                s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_req;
  wire                s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_ack;
  wire       [1:0]    cfg_s0_cmul2_m2c_cd;
  wire                cfg_s0_cmul2_m2c_cd_req;
  wire                cfg_s0_cmul2_m2c_cd_ack;
  wire                cfg_s0_cmul2_m2c_cd_m_req;
  wire                cfg_s0_cmul2_m2c_cd_m_ack;
  wire                cfg_s0_cmul2_m2c_cd_to_s0_cmul2_m2c_cd_req;
  wire                cfg_s0_cmul2_m2c_cd_to_s0_cmul2_m2c_cd_ack;
  wire       [17:0]   s0_cmul2_m2c_cd_0;
  wire                s0_cmul2_m2c_cd_0_req;
  wire                s0_cmul2_m2c_cd_0_ack;
  wire                s0_cmul2_m2c_cd_0_m_req;
  wire                s0_cmul2_m2c_cd_0_m_ack;
  wire                s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_req;
  wire                s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_ack;
  wire       [1:0]    cfg_s0_cmul2_m2c_da;
  wire                cfg_s0_cmul2_m2c_da_req;
  wire                cfg_s0_cmul2_m2c_da_ack;
  wire                cfg_s0_cmul2_m2c_da_m_req;
  wire                cfg_s0_cmul2_m2c_da_m_ack;
  wire                cfg_s0_cmul2_m2c_da_to_s0_cmul2_m2c_da_req;
  wire                cfg_s0_cmul2_m2c_da_to_s0_cmul2_m2c_da_ack;
  wire       [17:0]   s0_cmul2_m2c_da_0;
  wire                s0_cmul2_m2c_da_0_req;
  wire                s0_cmul2_m2c_da_0_ack;
  wire                s0_cmul2_m2c_da_0_m_req;
  wire                s0_cmul2_m2c_da_0_m_ack;
  wire                s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_req;
  wire                s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_ack;
  wire       [71:0]   s0_cmul2_cat_re_0;
  wire       [71:0]   s0_cmul2_cat_re_0_nxt;
  wire                s0_cmul2_cat_re_0_req;
  wire                s0_cmul2_cat_re_0_ack;
  wire                s0_cmul2_cat_re_0_m_req;
  wire                s0_cmul2_cat_re_0_m_ack;
  wire                s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_req;
  wire                s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_ack;
  wire       [71:0]   s0_cmul2_cat_im_0;
  wire       [71:0]   s0_cmul2_cat_im_0_nxt;
  wire                s0_cmul2_cat_im_0_req;
  wire                s0_cmul2_cat_im_0_ack;
  wire                s0_cmul2_cat_im_0_m_req;
  wire                s0_cmul2_cat_im_0_m_ack;
  wire                s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_req;
  wire                s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_ack;
  wire       [1:0]    cfg_s0_cmul2_mas_re;
  wire                cfg_s0_cmul2_mas_re_req;
  wire                cfg_s0_cmul2_mas_re_ack;
  wire                cfg_s0_cmul2_mas_re_m_req;
  wire                cfg_s0_cmul2_mas_re_m_ack;
  wire                cfg_s0_cmul2_mas_re_to_s0_cmul2_mas_re_req;
  wire                cfg_s0_cmul2_mas_re_to_s0_cmul2_mas_re_ack;
  wire       [35:0]   s0_cmul2_mas_re_0;
  wire                s0_cmul2_mas_re_0_req;
  wire                s0_cmul2_mas_re_0_ack;
  wire                s0_cmul2_mas_re_0_m_req;
  wire                s0_cmul2_mas_re_0_m_ack;
  wire                s0_cmul2_mas_re_0_to_s0_r4_a0_re_req;
  wire                s0_cmul2_mas_re_0_to_s0_r4_a2_re_req;
  wire                s0_cmul2_mas_re_0_to_s0_r4_byp2_re_req;
  wire                s0_cmul2_mas_re_0_to_s0_r4_a0_re_ack;
  wire                s0_cmul2_mas_re_0_to_s0_r4_a2_re_ack;
  wire                s0_cmul2_mas_re_0_to_s0_r4_byp2_re_ack;
  wire       [1:0]    cfg_s0_cmul2_mas_im;
  wire                cfg_s0_cmul2_mas_im_req;
  wire                cfg_s0_cmul2_mas_im_ack;
  wire                cfg_s0_cmul2_mas_im_m_req;
  wire                cfg_s0_cmul2_mas_im_m_ack;
  wire                cfg_s0_cmul2_mas_im_to_s0_cmul2_mas_im_req;
  wire                cfg_s0_cmul2_mas_im_to_s0_cmul2_mas_im_ack;
  wire       [35:0]   s0_cmul2_mas_im_0;
  wire                s0_cmul2_mas_im_0_req;
  wire                s0_cmul2_mas_im_0_ack;
  wire                s0_cmul2_mas_im_0_m_req;
  wire                s0_cmul2_mas_im_0_m_ack;
  wire                s0_cmul2_mas_im_0_to_s0_r4_a0_im_req;
  wire                s0_cmul2_mas_im_0_to_s0_r4_a2_im_req;
  wire                s0_cmul2_mas_im_0_to_s0_r4_byp2_im_req;
  wire                s0_cmul2_mas_im_0_to_s0_r4_a0_im_ack;
  wire                s0_cmul2_mas_im_0_to_s0_r4_a2_im_ack;
  wire                s0_cmul2_mas_im_0_to_s0_r4_byp2_im_ack;
  wire       [16:0]   s0_cmul3_recip_norm_0;
  wire       [16:0]   s0_cmul3_recip_norm_0_nxt;
  wire                s0_cmul3_recip_norm_0_req;
  wire                s0_cmul3_recip_norm_0_ack;
  wire                s0_cmul3_recip_norm_0_m_req;
  wire                s0_cmul3_recip_norm_0_m_ack;
  wire                s0_cmul3_recip_norm_0_to_s0_cmul3_recip_mul_req;
  wire                s0_cmul3_recip_norm_0_to_s0_cmul3_recip_mul_ack;
  wire       [28:0]   s0_cmul3_recip_mul_0;
  wire       [28:0]   s0_cmul3_recip_mul_0_nxt;
  wire                s0_cmul3_recip_mul_0_req;
  wire                s0_cmul3_recip_mul_0_ack;
  wire                s0_cmul3_recip_mul_0_m_req;
  wire                s0_cmul3_recip_mul_0_m_ack;
  wire                s0_cmul3_recip_mul_0_to_s0_cmul3_recip_out_req;
  wire                s0_cmul3_recip_mul_0_to_s0_cmul3_recip_out_ack;
  wire       [17:0]   s0_cmul3_recip_out_0;
  wire       [17:0]   s0_cmul3_recip_out_0_nxt;
  wire                s0_cmul3_recip_out_0_req;
  wire                s0_cmul3_recip_out_0_ack;
  wire                s0_cmul3_recip_out_0_m_req;
  wire                s0_cmul3_recip_out_0_m_ack;
  wire                s0_cmul3_recip_out_0_to_s0_cmul3_m2c_ac_req;
  wire                s0_cmul3_recip_out_0_to_s0_cmul3_m2c_cd_req;
  wire                s0_cmul3_recip_out_0_to_s0_cmul3_m2c_ac_ack;
  wire                s0_cmul3_recip_out_0_to_s0_cmul3_m2c_cd_ack;
  wire       [1:0]    cfg_s0_cmul3_m2c_ac;
  wire                cfg_s0_cmul3_m2c_ac_req;
  wire                cfg_s0_cmul3_m2c_ac_ack;
  wire                cfg_s0_cmul3_m2c_ac_m_req;
  wire                cfg_s0_cmul3_m2c_ac_m_ack;
  wire                cfg_s0_cmul3_m2c_ac_to_s0_cmul3_m2c_ac_req;
  wire                cfg_s0_cmul3_m2c_ac_to_s0_cmul3_m2c_ac_ack;
  wire       [17:0]   s0_cmul3_m2c_ac_0;
  wire                s0_cmul3_m2c_ac_0_req;
  wire                s0_cmul3_m2c_ac_0_ack;
  wire                s0_cmul3_m2c_ac_0_m_req;
  wire                s0_cmul3_m2c_ac_0_m_ack;
  wire                s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_req;
  wire                s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul3_m2c_bc;
  wire                cfg_s0_cmul3_m2c_bc_req;
  wire                cfg_s0_cmul3_m2c_bc_ack;
  wire                cfg_s0_cmul3_m2c_bc_m_req;
  wire                cfg_s0_cmul3_m2c_bc_m_ack;
  wire                cfg_s0_cmul3_m2c_bc_to_s0_cmul3_m2c_bc_req;
  wire                cfg_s0_cmul3_m2c_bc_to_s0_cmul3_m2c_bc_ack;
  wire       [17:0]   s0_cmul3_m2c_bc_0;
  wire                s0_cmul3_m2c_bc_0_req;
  wire                s0_cmul3_m2c_bc_0_ack;
  wire                s0_cmul3_m2c_bc_0_m_req;
  wire                s0_cmul3_m2c_bc_0_m_ack;
  wire                s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_req;
  wire                s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul3_m2c_bd;
  wire                cfg_s0_cmul3_m2c_bd_req;
  wire                cfg_s0_cmul3_m2c_bd_ack;
  wire                cfg_s0_cmul3_m2c_bd_m_req;
  wire                cfg_s0_cmul3_m2c_bd_m_ack;
  wire                cfg_s0_cmul3_m2c_bd_to_s0_cmul3_m2c_bd_req;
  wire                cfg_s0_cmul3_m2c_bd_to_s0_cmul3_m2c_bd_ack;
  wire       [17:0]   s0_cmul3_m2c_bd_0;
  wire                s0_cmul3_m2c_bd_0_req;
  wire                s0_cmul3_m2c_bd_0_ack;
  wire                s0_cmul3_m2c_bd_0_m_req;
  wire                s0_cmul3_m2c_bd_0_m_ack;
  wire                s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_req;
  wire                s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_ack;
  wire       [1:0]    cfg_s0_cmul3_m2c_cb;
  wire                cfg_s0_cmul3_m2c_cb_req;
  wire                cfg_s0_cmul3_m2c_cb_ack;
  wire                cfg_s0_cmul3_m2c_cb_m_req;
  wire                cfg_s0_cmul3_m2c_cb_m_ack;
  wire                cfg_s0_cmul3_m2c_cb_to_s0_cmul3_m2c_cb_req;
  wire                cfg_s0_cmul3_m2c_cb_to_s0_cmul3_m2c_cb_ack;
  wire       [17:0]   s0_cmul3_m2c_cb_0;
  wire                s0_cmul3_m2c_cb_0_req;
  wire                s0_cmul3_m2c_cb_0_ack;
  wire                s0_cmul3_m2c_cb_0_m_req;
  wire                s0_cmul3_m2c_cb_0_m_ack;
  wire                s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_req;
  wire                s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_ack;
  wire       [1:0]    cfg_s0_cmul3_m2c_cd;
  wire                cfg_s0_cmul3_m2c_cd_req;
  wire                cfg_s0_cmul3_m2c_cd_ack;
  wire                cfg_s0_cmul3_m2c_cd_m_req;
  wire                cfg_s0_cmul3_m2c_cd_m_ack;
  wire                cfg_s0_cmul3_m2c_cd_to_s0_cmul3_m2c_cd_req;
  wire                cfg_s0_cmul3_m2c_cd_to_s0_cmul3_m2c_cd_ack;
  wire       [17:0]   s0_cmul3_m2c_cd_0;
  wire                s0_cmul3_m2c_cd_0_req;
  wire                s0_cmul3_m2c_cd_0_ack;
  wire                s0_cmul3_m2c_cd_0_m_req;
  wire                s0_cmul3_m2c_cd_0_m_ack;
  wire                s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_req;
  wire                s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_ack;
  wire       [1:0]    cfg_s0_cmul3_m2c_da;
  wire                cfg_s0_cmul3_m2c_da_req;
  wire                cfg_s0_cmul3_m2c_da_ack;
  wire                cfg_s0_cmul3_m2c_da_m_req;
  wire                cfg_s0_cmul3_m2c_da_m_ack;
  wire                cfg_s0_cmul3_m2c_da_to_s0_cmul3_m2c_da_req;
  wire                cfg_s0_cmul3_m2c_da_to_s0_cmul3_m2c_da_ack;
  wire       [17:0]   s0_cmul3_m2c_da_0;
  wire                s0_cmul3_m2c_da_0_req;
  wire                s0_cmul3_m2c_da_0_ack;
  wire                s0_cmul3_m2c_da_0_m_req;
  wire                s0_cmul3_m2c_da_0_m_ack;
  wire                s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_req;
  wire                s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_ack;
  wire       [71:0]   s0_cmul3_cat_re_0;
  wire       [71:0]   s0_cmul3_cat_re_0_nxt;
  wire                s0_cmul3_cat_re_0_req;
  wire                s0_cmul3_cat_re_0_ack;
  wire                s0_cmul3_cat_re_0_m_req;
  wire                s0_cmul3_cat_re_0_m_ack;
  wire                s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_req;
  wire                s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_ack;
  wire       [71:0]   s0_cmul3_cat_im_0;
  wire       [71:0]   s0_cmul3_cat_im_0_nxt;
  wire                s0_cmul3_cat_im_0_req;
  wire                s0_cmul3_cat_im_0_ack;
  wire                s0_cmul3_cat_im_0_m_req;
  wire                s0_cmul3_cat_im_0_m_ack;
  wire                s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_req;
  wire                s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_ack;
  wire       [1:0]    cfg_s0_cmul3_mas_re;
  wire                cfg_s0_cmul3_mas_re_req;
  wire                cfg_s0_cmul3_mas_re_ack;
  wire                cfg_s0_cmul3_mas_re_m_req;
  wire                cfg_s0_cmul3_mas_re_m_ack;
  wire                cfg_s0_cmul3_mas_re_to_s0_cmul3_mas_re_req;
  wire                cfg_s0_cmul3_mas_re_to_s0_cmul3_mas_re_ack;
  wire       [35:0]   s0_cmul3_mas_re_0;
  wire                s0_cmul3_mas_re_0_req;
  wire                s0_cmul3_mas_re_0_ack;
  wire                s0_cmul3_mas_re_0_m_req;
  wire                s0_cmul3_mas_re_0_m_ack;
  wire                s0_cmul3_mas_re_0_to_s0_r4_a1_re_req;
  wire                s0_cmul3_mas_re_0_to_s0_r4_a3_re_req;
  wire                s0_cmul3_mas_re_0_to_s0_r4_byp3_re_req;
  wire                s0_cmul3_mas_re_0_to_s0_r4_a1_re_ack;
  wire                s0_cmul3_mas_re_0_to_s0_r4_a3_re_ack;
  wire                s0_cmul3_mas_re_0_to_s0_r4_byp3_re_ack;
  wire       [1:0]    cfg_s0_cmul3_mas_im;
  wire                cfg_s0_cmul3_mas_im_req;
  wire                cfg_s0_cmul3_mas_im_ack;
  wire                cfg_s0_cmul3_mas_im_m_req;
  wire                cfg_s0_cmul3_mas_im_m_ack;
  wire                cfg_s0_cmul3_mas_im_to_s0_cmul3_mas_im_req;
  wire                cfg_s0_cmul3_mas_im_to_s0_cmul3_mas_im_ack;
  wire       [35:0]   s0_cmul3_mas_im_0;
  wire                s0_cmul3_mas_im_0_req;
  wire                s0_cmul3_mas_im_0_ack;
  wire                s0_cmul3_mas_im_0_m_req;
  wire                s0_cmul3_mas_im_0_m_ack;
  wire                s0_cmul3_mas_im_0_to_s0_r4_a1_im_req;
  wire                s0_cmul3_mas_im_0_to_s0_r4_a3_im_req;
  wire                s0_cmul3_mas_im_0_to_s0_r4_byp3_im_req;
  wire                s0_cmul3_mas_im_0_to_s0_r4_a1_im_ack;
  wire                s0_cmul3_mas_im_0_to_s0_r4_a3_im_ack;
  wire                s0_cmul3_mas_im_0_to_s0_r4_byp3_im_ack;
  wire       [127:0]  k8_funnel_1;
  wire       [127:0]  k8_funnel_1_nxt;
  wire                k8_funnel_1_req;
  wire                k8_funnel_1_ack;
  wire                k8_funnel_1_m_req;
  wire                k8_funnel_1_m_ack;
  wire                k8_funnel_1_to_s1_k8_slice_req;
  wire                k8_funnel_1_to_s1_k8_slice_ack;
  wire       [127:0]  k9_funnel_1;
  wire       [127:0]  k9_funnel_1_nxt;
  wire                k9_funnel_1_req;
  wire                k9_funnel_1_ack;
  wire                k9_funnel_1_m_req;
  wire                k9_funnel_1_m_ack;
  wire                k9_funnel_1_to_s1_k9_slice_req;
  wire                k9_funnel_1_to_s1_k9_slice_ack;
  wire       [17:0]   s1_k8_slice_0;
  wire                s1_k8_slice_0_req;
  wire                s1_k8_slice_0_ack;
  wire                s1_k8_slice_0_m_req;
  wire                s1_k8_slice_0_m_ack;
  wire                s1_k8_slice_0_to_s1_cmul0_m2c_ac_req;
  wire                s1_k8_slice_0_to_s1_cmul0_m2c_da_req;
  wire                s1_k8_slice_0_to_s1_cmul0_cat_re_req;
  wire                s1_k8_slice_0_to_s1_cmul0_m2c_ac_ack;
  wire                s1_k8_slice_0_to_s1_cmul0_m2c_da_ack;
  wire                s1_k8_slice_0_to_s1_cmul0_cat_re_ack;
  wire       [17:0]   s1_k8_slice_1;
  wire                s1_k8_slice_1_req;
  wire                s1_k8_slice_1_ack;
  wire                s1_k8_slice_1_m_req;
  wire                s1_k8_slice_1_m_ack;
  wire                s1_k8_slice_1_to_s1_cmul0_m2c_bc_req;
  wire                s1_k8_slice_1_to_s1_cmul0_m2c_bd_req;
  wire                s1_k8_slice_1_to_s1_cmul0_m2c_cb_req;
  wire                s1_k8_slice_1_to_s1_cmul0_m2c_bc_ack;
  wire                s1_k8_slice_1_to_s1_cmul0_m2c_bd_ack;
  wire                s1_k8_slice_1_to_s1_cmul0_m2c_cb_ack;
  wire       [17:0]   s1_k9_slice_0;
  wire                s1_k9_slice_0_req;
  wire                s1_k9_slice_0_ack;
  wire                s1_k9_slice_0_m_req;
  wire                s1_k9_slice_0_m_ack;
  wire                s1_k9_slice_0_to_s1_cmul0_m2c_ac_req;
  wire                s1_k9_slice_0_to_s1_cmul0_m2c_bc_req;
  wire                s1_k9_slice_0_to_s1_cmul0_m2c_cb_req;
  wire                s1_k9_slice_0_to_s1_cmul0_m2c_cd_req;
  wire                s1_k9_slice_0_to_s1_cmul0_recip_norm_req;
  wire                s1_k9_slice_0_to_s1_cmul0_m2c_ac_ack;
  wire                s1_k9_slice_0_to_s1_cmul0_m2c_bc_ack;
  wire                s1_k9_slice_0_to_s1_cmul0_m2c_cb_ack;
  wire                s1_k9_slice_0_to_s1_cmul0_m2c_cd_ack;
  wire                s1_k9_slice_0_to_s1_cmul0_recip_norm_ack;
  wire       [17:0]   s1_k9_slice_1;
  wire                s1_k9_slice_1_req;
  wire                s1_k9_slice_1_ack;
  wire                s1_k9_slice_1_m_req;
  wire                s1_k9_slice_1_m_ack;
  wire                s1_k9_slice_1_to_s1_cmul0_m2c_bd_req;
  wire                s1_k9_slice_1_to_s1_cmul0_m2c_cd_req;
  wire                s1_k9_slice_1_to_s1_cmul0_m2c_da_req;
  wire                s1_k9_slice_1_to_s1_cmul0_cat_im_req;
  wire                s1_k9_slice_1_to_s1_cmul0_m2c_bd_ack;
  wire                s1_k9_slice_1_to_s1_cmul0_m2c_cd_ack;
  wire                s1_k9_slice_1_to_s1_cmul0_m2c_da_ack;
  wire                s1_k9_slice_1_to_s1_cmul0_cat_im_ack;
  wire       [17:0]   s1_k8_slice_2;
  wire                s1_k8_slice_2_req;
  wire                s1_k8_slice_2_ack;
  wire                s1_k8_slice_2_m_req;
  wire                s1_k8_slice_2_m_ack;
  wire                s1_k8_slice_2_to_s1_cmul1_m2c_ac_req;
  wire                s1_k8_slice_2_to_s1_cmul1_m2c_da_req;
  wire                s1_k8_slice_2_to_s1_cmul1_cat_re_req;
  wire                s1_k8_slice_2_to_s1_cmul1_m2c_ac_ack;
  wire                s1_k8_slice_2_to_s1_cmul1_m2c_da_ack;
  wire                s1_k8_slice_2_to_s1_cmul1_cat_re_ack;
  wire       [17:0]   s1_k8_slice_3;
  wire                s1_k8_slice_3_req;
  wire                s1_k8_slice_3_ack;
  wire                s1_k8_slice_3_m_req;
  wire                s1_k8_slice_3_m_ack;
  wire                s1_k8_slice_3_to_s1_cmul1_m2c_bc_req;
  wire                s1_k8_slice_3_to_s1_cmul1_m2c_bd_req;
  wire                s1_k8_slice_3_to_s1_cmul1_m2c_cb_req;
  wire                s1_k8_slice_3_to_s1_cmul1_m2c_bc_ack;
  wire                s1_k8_slice_3_to_s1_cmul1_m2c_bd_ack;
  wire                s1_k8_slice_3_to_s1_cmul1_m2c_cb_ack;
  wire       [17:0]   s1_k9_slice_2;
  wire                s1_k9_slice_2_req;
  wire                s1_k9_slice_2_ack;
  wire                s1_k9_slice_2_m_req;
  wire                s1_k9_slice_2_m_ack;
  wire                s1_k9_slice_2_to_s1_cmul1_m2c_ac_req;
  wire                s1_k9_slice_2_to_s1_cmul1_m2c_bc_req;
  wire                s1_k9_slice_2_to_s1_cmul1_m2c_cb_req;
  wire                s1_k9_slice_2_to_s1_cmul1_m2c_cd_req;
  wire                s1_k9_slice_2_to_s1_cmul1_recip_norm_req;
  wire                s1_k9_slice_2_to_s1_cmul1_m2c_ac_ack;
  wire                s1_k9_slice_2_to_s1_cmul1_m2c_bc_ack;
  wire                s1_k9_slice_2_to_s1_cmul1_m2c_cb_ack;
  wire                s1_k9_slice_2_to_s1_cmul1_m2c_cd_ack;
  wire                s1_k9_slice_2_to_s1_cmul1_recip_norm_ack;
  wire       [17:0]   s1_k9_slice_3;
  wire                s1_k9_slice_3_req;
  wire                s1_k9_slice_3_ack;
  wire                s1_k9_slice_3_m_req;
  wire                s1_k9_slice_3_m_ack;
  wire                s1_k9_slice_3_to_s1_cmul1_m2c_bd_req;
  wire                s1_k9_slice_3_to_s1_cmul1_m2c_cd_req;
  wire                s1_k9_slice_3_to_s1_cmul1_m2c_da_req;
  wire                s1_k9_slice_3_to_s1_cmul1_cat_im_req;
  wire                s1_k9_slice_3_to_s1_cmul1_m2c_bd_ack;
  wire                s1_k9_slice_3_to_s1_cmul1_m2c_cd_ack;
  wire                s1_k9_slice_3_to_s1_cmul1_m2c_da_ack;
  wire                s1_k9_slice_3_to_s1_cmul1_cat_im_ack;
  wire       [17:0]   s1_k8_slice_4;
  wire                s1_k8_slice_4_req;
  wire                s1_k8_slice_4_ack;
  wire                s1_k8_slice_4_m_req;
  wire                s1_k8_slice_4_m_ack;
  wire                s1_k8_slice_4_to_s1_cmul2_m2c_ac_req;
  wire                s1_k8_slice_4_to_s1_cmul2_m2c_da_req;
  wire                s1_k8_slice_4_to_s1_cmul2_cat_re_req;
  wire                s1_k8_slice_4_to_s1_cmul2_m2c_ac_ack;
  wire                s1_k8_slice_4_to_s1_cmul2_m2c_da_ack;
  wire                s1_k8_slice_4_to_s1_cmul2_cat_re_ack;
  wire       [17:0]   s1_k8_slice_5;
  wire                s1_k8_slice_5_req;
  wire                s1_k8_slice_5_ack;
  wire                s1_k8_slice_5_m_req;
  wire                s1_k8_slice_5_m_ack;
  wire                s1_k8_slice_5_to_s1_cmul2_m2c_bc_req;
  wire                s1_k8_slice_5_to_s1_cmul2_m2c_bd_req;
  wire                s1_k8_slice_5_to_s1_cmul2_m2c_cb_req;
  wire                s1_k8_slice_5_to_s1_cmul2_m2c_bc_ack;
  wire                s1_k8_slice_5_to_s1_cmul2_m2c_bd_ack;
  wire                s1_k8_slice_5_to_s1_cmul2_m2c_cb_ack;
  wire       [17:0]   s1_k9_slice_4;
  wire                s1_k9_slice_4_req;
  wire                s1_k9_slice_4_ack;
  wire                s1_k9_slice_4_m_req;
  wire                s1_k9_slice_4_m_ack;
  wire                s1_k9_slice_4_to_s1_cmul2_m2c_ac_req;
  wire                s1_k9_slice_4_to_s1_cmul2_m2c_bc_req;
  wire                s1_k9_slice_4_to_s1_cmul2_m2c_cb_req;
  wire                s1_k9_slice_4_to_s1_cmul2_m2c_cd_req;
  wire                s1_k9_slice_4_to_s1_cmul2_recip_norm_req;
  wire                s1_k9_slice_4_to_s1_cmul2_m2c_ac_ack;
  wire                s1_k9_slice_4_to_s1_cmul2_m2c_bc_ack;
  wire                s1_k9_slice_4_to_s1_cmul2_m2c_cb_ack;
  wire                s1_k9_slice_4_to_s1_cmul2_m2c_cd_ack;
  wire                s1_k9_slice_4_to_s1_cmul2_recip_norm_ack;
  wire       [17:0]   s1_k9_slice_5;
  wire                s1_k9_slice_5_req;
  wire                s1_k9_slice_5_ack;
  wire                s1_k9_slice_5_m_req;
  wire                s1_k9_slice_5_m_ack;
  wire                s1_k9_slice_5_to_s1_cmul2_m2c_bd_req;
  wire                s1_k9_slice_5_to_s1_cmul2_m2c_cd_req;
  wire                s1_k9_slice_5_to_s1_cmul2_m2c_da_req;
  wire                s1_k9_slice_5_to_s1_cmul2_cat_im_req;
  wire                s1_k9_slice_5_to_s1_cmul2_m2c_bd_ack;
  wire                s1_k9_slice_5_to_s1_cmul2_m2c_cd_ack;
  wire                s1_k9_slice_5_to_s1_cmul2_m2c_da_ack;
  wire                s1_k9_slice_5_to_s1_cmul2_cat_im_ack;
  wire       [17:0]   s1_k8_slice_6;
  wire                s1_k8_slice_6_req;
  wire                s1_k8_slice_6_ack;
  wire                s1_k8_slice_6_m_req;
  wire                s1_k8_slice_6_m_ack;
  wire                s1_k8_slice_6_to_s1_cmul3_m2c_ac_req;
  wire                s1_k8_slice_6_to_s1_cmul3_m2c_da_req;
  wire                s1_k8_slice_6_to_s1_cmul3_cat_re_req;
  wire                s1_k8_slice_6_to_s1_cmul3_m2c_ac_ack;
  wire                s1_k8_slice_6_to_s1_cmul3_m2c_da_ack;
  wire                s1_k8_slice_6_to_s1_cmul3_cat_re_ack;
  wire       [17:0]   s1_k8_slice_7;
  wire                s1_k8_slice_7_req;
  wire                s1_k8_slice_7_ack;
  wire                s1_k8_slice_7_m_req;
  wire                s1_k8_slice_7_m_ack;
  wire                s1_k8_slice_7_to_s1_cmul3_m2c_bc_req;
  wire                s1_k8_slice_7_to_s1_cmul3_m2c_bd_req;
  wire                s1_k8_slice_7_to_s1_cmul3_m2c_cb_req;
  wire                s1_k8_slice_7_to_s1_cmul3_m2c_bc_ack;
  wire                s1_k8_slice_7_to_s1_cmul3_m2c_bd_ack;
  wire                s1_k8_slice_7_to_s1_cmul3_m2c_cb_ack;
  wire       [17:0]   s1_k9_slice_6;
  wire                s1_k9_slice_6_req;
  wire                s1_k9_slice_6_ack;
  wire                s1_k9_slice_6_m_req;
  wire                s1_k9_slice_6_m_ack;
  wire                s1_k9_slice_6_to_s1_cmul3_m2c_ac_req;
  wire                s1_k9_slice_6_to_s1_cmul3_m2c_bc_req;
  wire                s1_k9_slice_6_to_s1_cmul3_m2c_cb_req;
  wire                s1_k9_slice_6_to_s1_cmul3_m2c_cd_req;
  wire                s1_k9_slice_6_to_s1_cmul3_recip_norm_req;
  wire                s1_k9_slice_6_to_s1_cmul3_m2c_ac_ack;
  wire                s1_k9_slice_6_to_s1_cmul3_m2c_bc_ack;
  wire                s1_k9_slice_6_to_s1_cmul3_m2c_cb_ack;
  wire                s1_k9_slice_6_to_s1_cmul3_m2c_cd_ack;
  wire                s1_k9_slice_6_to_s1_cmul3_recip_norm_ack;
  wire       [17:0]   s1_k9_slice_7;
  wire                s1_k9_slice_7_req;
  wire                s1_k9_slice_7_ack;
  wire                s1_k9_slice_7_m_req;
  wire                s1_k9_slice_7_m_ack;
  wire                s1_k9_slice_7_to_s1_cmul3_m2c_bd_req;
  wire                s1_k9_slice_7_to_s1_cmul3_m2c_cd_req;
  wire                s1_k9_slice_7_to_s1_cmul3_m2c_da_req;
  wire                s1_k9_slice_7_to_s1_cmul3_cat_im_req;
  wire                s1_k9_slice_7_to_s1_cmul3_m2c_bd_ack;
  wire                s1_k9_slice_7_to_s1_cmul3_m2c_cd_ack;
  wire                s1_k9_slice_7_to_s1_cmul3_m2c_da_ack;
  wire                s1_k9_slice_7_to_s1_cmul3_cat_im_ack;
  wire       [16:0]   s1_cmul0_recip_norm_0;
  wire       [16:0]   s1_cmul0_recip_norm_0_nxt;
  wire                s1_cmul0_recip_norm_0_req;
  wire                s1_cmul0_recip_norm_0_ack;
  wire                s1_cmul0_recip_norm_0_m_req;
  wire                s1_cmul0_recip_norm_0_m_ack;
  wire                s1_cmul0_recip_norm_0_to_s1_cmul0_recip_mul_req;
  wire                s1_cmul0_recip_norm_0_to_s1_cmul0_recip_mul_ack;
  wire       [28:0]   s1_cmul0_recip_mul_0;
  wire       [28:0]   s1_cmul0_recip_mul_0_nxt;
  wire                s1_cmul0_recip_mul_0_req;
  wire                s1_cmul0_recip_mul_0_ack;
  wire                s1_cmul0_recip_mul_0_m_req;
  wire                s1_cmul0_recip_mul_0_m_ack;
  wire                s1_cmul0_recip_mul_0_to_s1_cmul0_recip_out_req;
  wire                s1_cmul0_recip_mul_0_to_s1_cmul0_recip_out_ack;
  wire       [17:0]   s1_cmul0_recip_out_0;
  wire       [17:0]   s1_cmul0_recip_out_0_nxt;
  wire                s1_cmul0_recip_out_0_req;
  wire                s1_cmul0_recip_out_0_ack;
  wire                s1_cmul0_recip_out_0_m_req;
  wire                s1_cmul0_recip_out_0_m_ack;
  wire                s1_cmul0_recip_out_0_to_s1_cmul0_m2c_ac_req;
  wire                s1_cmul0_recip_out_0_to_s1_cmul0_m2c_cd_req;
  wire                s1_cmul0_recip_out_0_to_s1_cmul0_m2c_ac_ack;
  wire                s1_cmul0_recip_out_0_to_s1_cmul0_m2c_cd_ack;
  wire       [1:0]    cfg_s1_cmul0_m2c_ac;
  wire                cfg_s1_cmul0_m2c_ac_req;
  wire                cfg_s1_cmul0_m2c_ac_ack;
  wire                cfg_s1_cmul0_m2c_ac_m_req;
  wire                cfg_s1_cmul0_m2c_ac_m_ack;
  wire                cfg_s1_cmul0_m2c_ac_to_s1_cmul0_m2c_ac_req;
  wire                cfg_s1_cmul0_m2c_ac_to_s1_cmul0_m2c_ac_ack;
  wire       [17:0]   s1_cmul0_m2c_ac_0;
  wire                s1_cmul0_m2c_ac_0_req;
  wire                s1_cmul0_m2c_ac_0_ack;
  wire                s1_cmul0_m2c_ac_0_m_req;
  wire                s1_cmul0_m2c_ac_0_m_ack;
  wire                s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_req;
  wire                s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul0_m2c_bc;
  wire                cfg_s1_cmul0_m2c_bc_req;
  wire                cfg_s1_cmul0_m2c_bc_ack;
  wire                cfg_s1_cmul0_m2c_bc_m_req;
  wire                cfg_s1_cmul0_m2c_bc_m_ack;
  wire                cfg_s1_cmul0_m2c_bc_to_s1_cmul0_m2c_bc_req;
  wire                cfg_s1_cmul0_m2c_bc_to_s1_cmul0_m2c_bc_ack;
  wire       [17:0]   s1_cmul0_m2c_bc_0;
  wire                s1_cmul0_m2c_bc_0_req;
  wire                s1_cmul0_m2c_bc_0_ack;
  wire                s1_cmul0_m2c_bc_0_m_req;
  wire                s1_cmul0_m2c_bc_0_m_ack;
  wire                s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_req;
  wire                s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul0_m2c_bd;
  wire                cfg_s1_cmul0_m2c_bd_req;
  wire                cfg_s1_cmul0_m2c_bd_ack;
  wire                cfg_s1_cmul0_m2c_bd_m_req;
  wire                cfg_s1_cmul0_m2c_bd_m_ack;
  wire                cfg_s1_cmul0_m2c_bd_to_s1_cmul0_m2c_bd_req;
  wire                cfg_s1_cmul0_m2c_bd_to_s1_cmul0_m2c_bd_ack;
  wire       [17:0]   s1_cmul0_m2c_bd_0;
  wire                s1_cmul0_m2c_bd_0_req;
  wire                s1_cmul0_m2c_bd_0_ack;
  wire                s1_cmul0_m2c_bd_0_m_req;
  wire                s1_cmul0_m2c_bd_0_m_ack;
  wire                s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_req;
  wire                s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul0_m2c_cb;
  wire                cfg_s1_cmul0_m2c_cb_req;
  wire                cfg_s1_cmul0_m2c_cb_ack;
  wire                cfg_s1_cmul0_m2c_cb_m_req;
  wire                cfg_s1_cmul0_m2c_cb_m_ack;
  wire                cfg_s1_cmul0_m2c_cb_to_s1_cmul0_m2c_cb_req;
  wire                cfg_s1_cmul0_m2c_cb_to_s1_cmul0_m2c_cb_ack;
  wire       [17:0]   s1_cmul0_m2c_cb_0;
  wire                s1_cmul0_m2c_cb_0_req;
  wire                s1_cmul0_m2c_cb_0_ack;
  wire                s1_cmul0_m2c_cb_0_m_req;
  wire                s1_cmul0_m2c_cb_0_m_ack;
  wire                s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_req;
  wire                s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_ack;
  wire       [1:0]    cfg_s1_cmul0_m2c_cd;
  wire                cfg_s1_cmul0_m2c_cd_req;
  wire                cfg_s1_cmul0_m2c_cd_ack;
  wire                cfg_s1_cmul0_m2c_cd_m_req;
  wire                cfg_s1_cmul0_m2c_cd_m_ack;
  wire                cfg_s1_cmul0_m2c_cd_to_s1_cmul0_m2c_cd_req;
  wire                cfg_s1_cmul0_m2c_cd_to_s1_cmul0_m2c_cd_ack;
  wire       [17:0]   s1_cmul0_m2c_cd_0;
  wire                s1_cmul0_m2c_cd_0_req;
  wire                s1_cmul0_m2c_cd_0_ack;
  wire                s1_cmul0_m2c_cd_0_m_req;
  wire                s1_cmul0_m2c_cd_0_m_ack;
  wire                s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_req;
  wire                s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_ack;
  wire       [1:0]    cfg_s1_cmul0_m2c_da;
  wire                cfg_s1_cmul0_m2c_da_req;
  wire                cfg_s1_cmul0_m2c_da_ack;
  wire                cfg_s1_cmul0_m2c_da_m_req;
  wire                cfg_s1_cmul0_m2c_da_m_ack;
  wire                cfg_s1_cmul0_m2c_da_to_s1_cmul0_m2c_da_req;
  wire                cfg_s1_cmul0_m2c_da_to_s1_cmul0_m2c_da_ack;
  wire       [17:0]   s1_cmul0_m2c_da_0;
  wire                s1_cmul0_m2c_da_0_req;
  wire                s1_cmul0_m2c_da_0_ack;
  wire                s1_cmul0_m2c_da_0_m_req;
  wire                s1_cmul0_m2c_da_0_m_ack;
  wire                s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_req;
  wire                s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_ack;
  wire       [71:0]   s1_cmul0_cat_re_0;
  wire       [71:0]   s1_cmul0_cat_re_0_nxt;
  wire                s1_cmul0_cat_re_0_req;
  wire                s1_cmul0_cat_re_0_ack;
  wire                s1_cmul0_cat_re_0_m_req;
  wire                s1_cmul0_cat_re_0_m_ack;
  wire                s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_req;
  wire                s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_ack;
  wire       [71:0]   s1_cmul0_cat_im_0;
  wire       [71:0]   s1_cmul0_cat_im_0_nxt;
  wire                s1_cmul0_cat_im_0_req;
  wire                s1_cmul0_cat_im_0_ack;
  wire                s1_cmul0_cat_im_0_m_req;
  wire                s1_cmul0_cat_im_0_m_ack;
  wire                s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_req;
  wire                s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_ack;
  wire       [1:0]    cfg_s1_cmul0_mas_re;
  wire                cfg_s1_cmul0_mas_re_req;
  wire                cfg_s1_cmul0_mas_re_ack;
  wire                cfg_s1_cmul0_mas_re_m_req;
  wire                cfg_s1_cmul0_mas_re_m_ack;
  wire                cfg_s1_cmul0_mas_re_to_s1_cmul0_mas_re_req;
  wire                cfg_s1_cmul0_mas_re_to_s1_cmul0_mas_re_ack;
  wire       [35:0]   s1_cmul0_mas_re_0;
  wire                s1_cmul0_mas_re_0_req;
  wire                s1_cmul0_mas_re_0_ack;
  wire                s1_cmul0_mas_re_0_m_req;
  wire                s1_cmul0_mas_re_0_m_ack;
  wire                s1_cmul0_mas_re_0_to_s1_r4_a0_re_req;
  wire                s1_cmul0_mas_re_0_to_s1_r4_a2_re_req;
  wire                s1_cmul0_mas_re_0_to_s1_r4_byp0_re_req;
  wire                s1_cmul0_mas_re_0_to_s1_r4_a0_re_ack;
  wire                s1_cmul0_mas_re_0_to_s1_r4_a2_re_ack;
  wire                s1_cmul0_mas_re_0_to_s1_r4_byp0_re_ack;
  wire       [1:0]    cfg_s1_cmul0_mas_im;
  wire                cfg_s1_cmul0_mas_im_req;
  wire                cfg_s1_cmul0_mas_im_ack;
  wire                cfg_s1_cmul0_mas_im_m_req;
  wire                cfg_s1_cmul0_mas_im_m_ack;
  wire                cfg_s1_cmul0_mas_im_to_s1_cmul0_mas_im_req;
  wire                cfg_s1_cmul0_mas_im_to_s1_cmul0_mas_im_ack;
  wire       [35:0]   s1_cmul0_mas_im_0;
  wire                s1_cmul0_mas_im_0_req;
  wire                s1_cmul0_mas_im_0_ack;
  wire                s1_cmul0_mas_im_0_m_req;
  wire                s1_cmul0_mas_im_0_m_ack;
  wire                s1_cmul0_mas_im_0_to_s1_r4_a0_im_req;
  wire                s1_cmul0_mas_im_0_to_s1_r4_a2_im_req;
  wire                s1_cmul0_mas_im_0_to_s1_r4_byp0_im_req;
  wire                s1_cmul0_mas_im_0_to_s1_r4_a0_im_ack;
  wire                s1_cmul0_mas_im_0_to_s1_r4_a2_im_ack;
  wire                s1_cmul0_mas_im_0_to_s1_r4_byp0_im_ack;
  wire       [16:0]   s1_cmul1_recip_norm_0;
  wire       [16:0]   s1_cmul1_recip_norm_0_nxt;
  wire                s1_cmul1_recip_norm_0_req;
  wire                s1_cmul1_recip_norm_0_ack;
  wire                s1_cmul1_recip_norm_0_m_req;
  wire                s1_cmul1_recip_norm_0_m_ack;
  wire                s1_cmul1_recip_norm_0_to_s1_cmul1_recip_mul_req;
  wire                s1_cmul1_recip_norm_0_to_s1_cmul1_recip_mul_ack;
  wire       [28:0]   s1_cmul1_recip_mul_0;
  wire       [28:0]   s1_cmul1_recip_mul_0_nxt;
  wire                s1_cmul1_recip_mul_0_req;
  wire                s1_cmul1_recip_mul_0_ack;
  wire                s1_cmul1_recip_mul_0_m_req;
  wire                s1_cmul1_recip_mul_0_m_ack;
  wire                s1_cmul1_recip_mul_0_to_s1_cmul1_recip_out_req;
  wire                s1_cmul1_recip_mul_0_to_s1_cmul1_recip_out_ack;
  wire       [17:0]   s1_cmul1_recip_out_0;
  wire       [17:0]   s1_cmul1_recip_out_0_nxt;
  wire                s1_cmul1_recip_out_0_req;
  wire                s1_cmul1_recip_out_0_ack;
  wire                s1_cmul1_recip_out_0_m_req;
  wire                s1_cmul1_recip_out_0_m_ack;
  wire                s1_cmul1_recip_out_0_to_s1_cmul1_m2c_ac_req;
  wire                s1_cmul1_recip_out_0_to_s1_cmul1_m2c_cd_req;
  wire                s1_cmul1_recip_out_0_to_s1_cmul1_m2c_ac_ack;
  wire                s1_cmul1_recip_out_0_to_s1_cmul1_m2c_cd_ack;
  wire       [1:0]    cfg_s1_cmul1_m2c_ac;
  wire                cfg_s1_cmul1_m2c_ac_req;
  wire                cfg_s1_cmul1_m2c_ac_ack;
  wire                cfg_s1_cmul1_m2c_ac_m_req;
  wire                cfg_s1_cmul1_m2c_ac_m_ack;
  wire                cfg_s1_cmul1_m2c_ac_to_s1_cmul1_m2c_ac_req;
  wire                cfg_s1_cmul1_m2c_ac_to_s1_cmul1_m2c_ac_ack;
  wire       [17:0]   s1_cmul1_m2c_ac_0;
  wire                s1_cmul1_m2c_ac_0_req;
  wire                s1_cmul1_m2c_ac_0_ack;
  wire                s1_cmul1_m2c_ac_0_m_req;
  wire                s1_cmul1_m2c_ac_0_m_ack;
  wire                s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_req;
  wire                s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul1_m2c_bc;
  wire                cfg_s1_cmul1_m2c_bc_req;
  wire                cfg_s1_cmul1_m2c_bc_ack;
  wire                cfg_s1_cmul1_m2c_bc_m_req;
  wire                cfg_s1_cmul1_m2c_bc_m_ack;
  wire                cfg_s1_cmul1_m2c_bc_to_s1_cmul1_m2c_bc_req;
  wire                cfg_s1_cmul1_m2c_bc_to_s1_cmul1_m2c_bc_ack;
  wire       [17:0]   s1_cmul1_m2c_bc_0;
  wire                s1_cmul1_m2c_bc_0_req;
  wire                s1_cmul1_m2c_bc_0_ack;
  wire                s1_cmul1_m2c_bc_0_m_req;
  wire                s1_cmul1_m2c_bc_0_m_ack;
  wire                s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_req;
  wire                s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul1_m2c_bd;
  wire                cfg_s1_cmul1_m2c_bd_req;
  wire                cfg_s1_cmul1_m2c_bd_ack;
  wire                cfg_s1_cmul1_m2c_bd_m_req;
  wire                cfg_s1_cmul1_m2c_bd_m_ack;
  wire                cfg_s1_cmul1_m2c_bd_to_s1_cmul1_m2c_bd_req;
  wire                cfg_s1_cmul1_m2c_bd_to_s1_cmul1_m2c_bd_ack;
  wire       [17:0]   s1_cmul1_m2c_bd_0;
  wire                s1_cmul1_m2c_bd_0_req;
  wire                s1_cmul1_m2c_bd_0_ack;
  wire                s1_cmul1_m2c_bd_0_m_req;
  wire                s1_cmul1_m2c_bd_0_m_ack;
  wire                s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_req;
  wire                s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul1_m2c_cb;
  wire                cfg_s1_cmul1_m2c_cb_req;
  wire                cfg_s1_cmul1_m2c_cb_ack;
  wire                cfg_s1_cmul1_m2c_cb_m_req;
  wire                cfg_s1_cmul1_m2c_cb_m_ack;
  wire                cfg_s1_cmul1_m2c_cb_to_s1_cmul1_m2c_cb_req;
  wire                cfg_s1_cmul1_m2c_cb_to_s1_cmul1_m2c_cb_ack;
  wire       [17:0]   s1_cmul1_m2c_cb_0;
  wire                s1_cmul1_m2c_cb_0_req;
  wire                s1_cmul1_m2c_cb_0_ack;
  wire                s1_cmul1_m2c_cb_0_m_req;
  wire                s1_cmul1_m2c_cb_0_m_ack;
  wire                s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_req;
  wire                s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_ack;
  wire       [1:0]    cfg_s1_cmul1_m2c_cd;
  wire                cfg_s1_cmul1_m2c_cd_req;
  wire                cfg_s1_cmul1_m2c_cd_ack;
  wire                cfg_s1_cmul1_m2c_cd_m_req;
  wire                cfg_s1_cmul1_m2c_cd_m_ack;
  wire                cfg_s1_cmul1_m2c_cd_to_s1_cmul1_m2c_cd_req;
  wire                cfg_s1_cmul1_m2c_cd_to_s1_cmul1_m2c_cd_ack;
  wire       [17:0]   s1_cmul1_m2c_cd_0;
  wire                s1_cmul1_m2c_cd_0_req;
  wire                s1_cmul1_m2c_cd_0_ack;
  wire                s1_cmul1_m2c_cd_0_m_req;
  wire                s1_cmul1_m2c_cd_0_m_ack;
  wire                s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_req;
  wire                s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_ack;
  wire       [1:0]    cfg_s1_cmul1_m2c_da;
  wire                cfg_s1_cmul1_m2c_da_req;
  wire                cfg_s1_cmul1_m2c_da_ack;
  wire                cfg_s1_cmul1_m2c_da_m_req;
  wire                cfg_s1_cmul1_m2c_da_m_ack;
  wire                cfg_s1_cmul1_m2c_da_to_s1_cmul1_m2c_da_req;
  wire                cfg_s1_cmul1_m2c_da_to_s1_cmul1_m2c_da_ack;
  wire       [17:0]   s1_cmul1_m2c_da_0;
  wire                s1_cmul1_m2c_da_0_req;
  wire                s1_cmul1_m2c_da_0_ack;
  wire                s1_cmul1_m2c_da_0_m_req;
  wire                s1_cmul1_m2c_da_0_m_ack;
  wire                s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_req;
  wire                s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_ack;
  wire       [71:0]   s1_cmul1_cat_re_0;
  wire       [71:0]   s1_cmul1_cat_re_0_nxt;
  wire                s1_cmul1_cat_re_0_req;
  wire                s1_cmul1_cat_re_0_ack;
  wire                s1_cmul1_cat_re_0_m_req;
  wire                s1_cmul1_cat_re_0_m_ack;
  wire                s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_req;
  wire                s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_ack;
  wire       [71:0]   s1_cmul1_cat_im_0;
  wire       [71:0]   s1_cmul1_cat_im_0_nxt;
  wire                s1_cmul1_cat_im_0_req;
  wire                s1_cmul1_cat_im_0_ack;
  wire                s1_cmul1_cat_im_0_m_req;
  wire                s1_cmul1_cat_im_0_m_ack;
  wire                s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_req;
  wire                s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_ack;
  wire       [1:0]    cfg_s1_cmul1_mas_re;
  wire                cfg_s1_cmul1_mas_re_req;
  wire                cfg_s1_cmul1_mas_re_ack;
  wire                cfg_s1_cmul1_mas_re_m_req;
  wire                cfg_s1_cmul1_mas_re_m_ack;
  wire                cfg_s1_cmul1_mas_re_to_s1_cmul1_mas_re_req;
  wire                cfg_s1_cmul1_mas_re_to_s1_cmul1_mas_re_ack;
  wire       [35:0]   s1_cmul1_mas_re_0;
  wire                s1_cmul1_mas_re_0_req;
  wire                s1_cmul1_mas_re_0_ack;
  wire                s1_cmul1_mas_re_0_m_req;
  wire                s1_cmul1_mas_re_0_m_ack;
  wire                s1_cmul1_mas_re_0_to_s1_r4_a1_re_req;
  wire                s1_cmul1_mas_re_0_to_s1_r4_a3_re_req;
  wire                s1_cmul1_mas_re_0_to_s1_r4_byp1_re_req;
  wire                s1_cmul1_mas_re_0_to_s1_r4_a1_re_ack;
  wire                s1_cmul1_mas_re_0_to_s1_r4_a3_re_ack;
  wire                s1_cmul1_mas_re_0_to_s1_r4_byp1_re_ack;
  wire       [1:0]    cfg_s1_cmul1_mas_im;
  wire                cfg_s1_cmul1_mas_im_req;
  wire                cfg_s1_cmul1_mas_im_ack;
  wire                cfg_s1_cmul1_mas_im_m_req;
  wire                cfg_s1_cmul1_mas_im_m_ack;
  wire                cfg_s1_cmul1_mas_im_to_s1_cmul1_mas_im_req;
  wire                cfg_s1_cmul1_mas_im_to_s1_cmul1_mas_im_ack;
  wire       [35:0]   s1_cmul1_mas_im_0;
  wire                s1_cmul1_mas_im_0_req;
  wire                s1_cmul1_mas_im_0_ack;
  wire                s1_cmul1_mas_im_0_m_req;
  wire                s1_cmul1_mas_im_0_m_ack;
  wire                s1_cmul1_mas_im_0_to_s1_r4_a1_im_req;
  wire                s1_cmul1_mas_im_0_to_s1_r4_a3_im_req;
  wire                s1_cmul1_mas_im_0_to_s1_r4_byp1_im_req;
  wire                s1_cmul1_mas_im_0_to_s1_r4_a1_im_ack;
  wire                s1_cmul1_mas_im_0_to_s1_r4_a3_im_ack;
  wire                s1_cmul1_mas_im_0_to_s1_r4_byp1_im_ack;
  wire       [16:0]   s1_cmul2_recip_norm_0;
  wire       [16:0]   s1_cmul2_recip_norm_0_nxt;
  wire                s1_cmul2_recip_norm_0_req;
  wire                s1_cmul2_recip_norm_0_ack;
  wire                s1_cmul2_recip_norm_0_m_req;
  wire                s1_cmul2_recip_norm_0_m_ack;
  wire                s1_cmul2_recip_norm_0_to_s1_cmul2_recip_mul_req;
  wire                s1_cmul2_recip_norm_0_to_s1_cmul2_recip_mul_ack;
  wire       [28:0]   s1_cmul2_recip_mul_0;
  wire       [28:0]   s1_cmul2_recip_mul_0_nxt;
  wire                s1_cmul2_recip_mul_0_req;
  wire                s1_cmul2_recip_mul_0_ack;
  wire                s1_cmul2_recip_mul_0_m_req;
  wire                s1_cmul2_recip_mul_0_m_ack;
  wire                s1_cmul2_recip_mul_0_to_s1_cmul2_recip_out_req;
  wire                s1_cmul2_recip_mul_0_to_s1_cmul2_recip_out_ack;
  wire       [17:0]   s1_cmul2_recip_out_0;
  wire       [17:0]   s1_cmul2_recip_out_0_nxt;
  wire                s1_cmul2_recip_out_0_req;
  wire                s1_cmul2_recip_out_0_ack;
  wire                s1_cmul2_recip_out_0_m_req;
  wire                s1_cmul2_recip_out_0_m_ack;
  wire                s1_cmul2_recip_out_0_to_s1_cmul2_m2c_ac_req;
  wire                s1_cmul2_recip_out_0_to_s1_cmul2_m2c_cd_req;
  wire                s1_cmul2_recip_out_0_to_s1_cmul2_m2c_ac_ack;
  wire                s1_cmul2_recip_out_0_to_s1_cmul2_m2c_cd_ack;
  wire       [1:0]    cfg_s1_cmul2_m2c_ac;
  wire                cfg_s1_cmul2_m2c_ac_req;
  wire                cfg_s1_cmul2_m2c_ac_ack;
  wire                cfg_s1_cmul2_m2c_ac_m_req;
  wire                cfg_s1_cmul2_m2c_ac_m_ack;
  wire                cfg_s1_cmul2_m2c_ac_to_s1_cmul2_m2c_ac_req;
  wire                cfg_s1_cmul2_m2c_ac_to_s1_cmul2_m2c_ac_ack;
  wire       [17:0]   s1_cmul2_m2c_ac_0;
  wire                s1_cmul2_m2c_ac_0_req;
  wire                s1_cmul2_m2c_ac_0_ack;
  wire                s1_cmul2_m2c_ac_0_m_req;
  wire                s1_cmul2_m2c_ac_0_m_ack;
  wire                s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_req;
  wire                s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul2_m2c_bc;
  wire                cfg_s1_cmul2_m2c_bc_req;
  wire                cfg_s1_cmul2_m2c_bc_ack;
  wire                cfg_s1_cmul2_m2c_bc_m_req;
  wire                cfg_s1_cmul2_m2c_bc_m_ack;
  wire                cfg_s1_cmul2_m2c_bc_to_s1_cmul2_m2c_bc_req;
  wire                cfg_s1_cmul2_m2c_bc_to_s1_cmul2_m2c_bc_ack;
  wire       [17:0]   s1_cmul2_m2c_bc_0;
  wire                s1_cmul2_m2c_bc_0_req;
  wire                s1_cmul2_m2c_bc_0_ack;
  wire                s1_cmul2_m2c_bc_0_m_req;
  wire                s1_cmul2_m2c_bc_0_m_ack;
  wire                s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_req;
  wire                s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul2_m2c_bd;
  wire                cfg_s1_cmul2_m2c_bd_req;
  wire                cfg_s1_cmul2_m2c_bd_ack;
  wire                cfg_s1_cmul2_m2c_bd_m_req;
  wire                cfg_s1_cmul2_m2c_bd_m_ack;
  wire                cfg_s1_cmul2_m2c_bd_to_s1_cmul2_m2c_bd_req;
  wire                cfg_s1_cmul2_m2c_bd_to_s1_cmul2_m2c_bd_ack;
  wire       [17:0]   s1_cmul2_m2c_bd_0;
  wire                s1_cmul2_m2c_bd_0_req;
  wire                s1_cmul2_m2c_bd_0_ack;
  wire                s1_cmul2_m2c_bd_0_m_req;
  wire                s1_cmul2_m2c_bd_0_m_ack;
  wire                s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_req;
  wire                s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul2_m2c_cb;
  wire                cfg_s1_cmul2_m2c_cb_req;
  wire                cfg_s1_cmul2_m2c_cb_ack;
  wire                cfg_s1_cmul2_m2c_cb_m_req;
  wire                cfg_s1_cmul2_m2c_cb_m_ack;
  wire                cfg_s1_cmul2_m2c_cb_to_s1_cmul2_m2c_cb_req;
  wire                cfg_s1_cmul2_m2c_cb_to_s1_cmul2_m2c_cb_ack;
  wire       [17:0]   s1_cmul2_m2c_cb_0;
  wire                s1_cmul2_m2c_cb_0_req;
  wire                s1_cmul2_m2c_cb_0_ack;
  wire                s1_cmul2_m2c_cb_0_m_req;
  wire                s1_cmul2_m2c_cb_0_m_ack;
  wire                s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_req;
  wire                s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_ack;
  wire       [1:0]    cfg_s1_cmul2_m2c_cd;
  wire                cfg_s1_cmul2_m2c_cd_req;
  wire                cfg_s1_cmul2_m2c_cd_ack;
  wire                cfg_s1_cmul2_m2c_cd_m_req;
  wire                cfg_s1_cmul2_m2c_cd_m_ack;
  wire                cfg_s1_cmul2_m2c_cd_to_s1_cmul2_m2c_cd_req;
  wire                cfg_s1_cmul2_m2c_cd_to_s1_cmul2_m2c_cd_ack;
  wire       [17:0]   s1_cmul2_m2c_cd_0;
  wire                s1_cmul2_m2c_cd_0_req;
  wire                s1_cmul2_m2c_cd_0_ack;
  wire                s1_cmul2_m2c_cd_0_m_req;
  wire                s1_cmul2_m2c_cd_0_m_ack;
  wire                s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_req;
  wire                s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_ack;
  wire       [1:0]    cfg_s1_cmul2_m2c_da;
  wire                cfg_s1_cmul2_m2c_da_req;
  wire                cfg_s1_cmul2_m2c_da_ack;
  wire                cfg_s1_cmul2_m2c_da_m_req;
  wire                cfg_s1_cmul2_m2c_da_m_ack;
  wire                cfg_s1_cmul2_m2c_da_to_s1_cmul2_m2c_da_req;
  wire                cfg_s1_cmul2_m2c_da_to_s1_cmul2_m2c_da_ack;
  wire       [17:0]   s1_cmul2_m2c_da_0;
  wire                s1_cmul2_m2c_da_0_req;
  wire                s1_cmul2_m2c_da_0_ack;
  wire                s1_cmul2_m2c_da_0_m_req;
  wire                s1_cmul2_m2c_da_0_m_ack;
  wire                s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_req;
  wire                s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_ack;
  wire       [71:0]   s1_cmul2_cat_re_0;
  wire       [71:0]   s1_cmul2_cat_re_0_nxt;
  wire                s1_cmul2_cat_re_0_req;
  wire                s1_cmul2_cat_re_0_ack;
  wire                s1_cmul2_cat_re_0_m_req;
  wire                s1_cmul2_cat_re_0_m_ack;
  wire                s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_req;
  wire                s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_ack;
  wire       [71:0]   s1_cmul2_cat_im_0;
  wire       [71:0]   s1_cmul2_cat_im_0_nxt;
  wire                s1_cmul2_cat_im_0_req;
  wire                s1_cmul2_cat_im_0_ack;
  wire                s1_cmul2_cat_im_0_m_req;
  wire                s1_cmul2_cat_im_0_m_ack;
  wire                s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_req;
  wire                s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_ack;
  wire       [1:0]    cfg_s1_cmul2_mas_re;
  wire                cfg_s1_cmul2_mas_re_req;
  wire                cfg_s1_cmul2_mas_re_ack;
  wire                cfg_s1_cmul2_mas_re_m_req;
  wire                cfg_s1_cmul2_mas_re_m_ack;
  wire                cfg_s1_cmul2_mas_re_to_s1_cmul2_mas_re_req;
  wire                cfg_s1_cmul2_mas_re_to_s1_cmul2_mas_re_ack;
  wire       [35:0]   s1_cmul2_mas_re_0;
  wire                s1_cmul2_mas_re_0_req;
  wire                s1_cmul2_mas_re_0_ack;
  wire                s1_cmul2_mas_re_0_m_req;
  wire                s1_cmul2_mas_re_0_m_ack;
  wire                s1_cmul2_mas_re_0_to_s1_r4_a0_re_req;
  wire                s1_cmul2_mas_re_0_to_s1_r4_a2_re_req;
  wire                s1_cmul2_mas_re_0_to_s1_r4_byp2_re_req;
  wire                s1_cmul2_mas_re_0_to_s1_r4_a0_re_ack;
  wire                s1_cmul2_mas_re_0_to_s1_r4_a2_re_ack;
  wire                s1_cmul2_mas_re_0_to_s1_r4_byp2_re_ack;
  wire       [1:0]    cfg_s1_cmul2_mas_im;
  wire                cfg_s1_cmul2_mas_im_req;
  wire                cfg_s1_cmul2_mas_im_ack;
  wire                cfg_s1_cmul2_mas_im_m_req;
  wire                cfg_s1_cmul2_mas_im_m_ack;
  wire                cfg_s1_cmul2_mas_im_to_s1_cmul2_mas_im_req;
  wire                cfg_s1_cmul2_mas_im_to_s1_cmul2_mas_im_ack;
  wire       [35:0]   s1_cmul2_mas_im_0;
  wire                s1_cmul2_mas_im_0_req;
  wire                s1_cmul2_mas_im_0_ack;
  wire                s1_cmul2_mas_im_0_m_req;
  wire                s1_cmul2_mas_im_0_m_ack;
  wire                s1_cmul2_mas_im_0_to_s1_r4_a0_im_req;
  wire                s1_cmul2_mas_im_0_to_s1_r4_a2_im_req;
  wire                s1_cmul2_mas_im_0_to_s1_r4_byp2_im_req;
  wire                s1_cmul2_mas_im_0_to_s1_r4_a0_im_ack;
  wire                s1_cmul2_mas_im_0_to_s1_r4_a2_im_ack;
  wire                s1_cmul2_mas_im_0_to_s1_r4_byp2_im_ack;
  wire       [16:0]   s1_cmul3_recip_norm_0;
  wire       [16:0]   s1_cmul3_recip_norm_0_nxt;
  wire                s1_cmul3_recip_norm_0_req;
  wire                s1_cmul3_recip_norm_0_ack;
  wire                s1_cmul3_recip_norm_0_m_req;
  wire                s1_cmul3_recip_norm_0_m_ack;
  wire                s1_cmul3_recip_norm_0_to_s1_cmul3_recip_mul_req;
  wire                s1_cmul3_recip_norm_0_to_s1_cmul3_recip_mul_ack;
  wire       [28:0]   s1_cmul3_recip_mul_0;
  wire       [28:0]   s1_cmul3_recip_mul_0_nxt;
  wire                s1_cmul3_recip_mul_0_req;
  wire                s1_cmul3_recip_mul_0_ack;
  wire                s1_cmul3_recip_mul_0_m_req;
  wire                s1_cmul3_recip_mul_0_m_ack;
  wire                s1_cmul3_recip_mul_0_to_s1_cmul3_recip_out_req;
  wire                s1_cmul3_recip_mul_0_to_s1_cmul3_recip_out_ack;
  wire       [17:0]   s1_cmul3_recip_out_0;
  wire       [17:0]   s1_cmul3_recip_out_0_nxt;
  wire                s1_cmul3_recip_out_0_req;
  wire                s1_cmul3_recip_out_0_ack;
  wire                s1_cmul3_recip_out_0_m_req;
  wire                s1_cmul3_recip_out_0_m_ack;
  wire                s1_cmul3_recip_out_0_to_s1_cmul3_m2c_ac_req;
  wire                s1_cmul3_recip_out_0_to_s1_cmul3_m2c_cd_req;
  wire                s1_cmul3_recip_out_0_to_s1_cmul3_m2c_ac_ack;
  wire                s1_cmul3_recip_out_0_to_s1_cmul3_m2c_cd_ack;
  wire       [1:0]    cfg_s1_cmul3_m2c_ac;
  wire                cfg_s1_cmul3_m2c_ac_req;
  wire                cfg_s1_cmul3_m2c_ac_ack;
  wire                cfg_s1_cmul3_m2c_ac_m_req;
  wire                cfg_s1_cmul3_m2c_ac_m_ack;
  wire                cfg_s1_cmul3_m2c_ac_to_s1_cmul3_m2c_ac_req;
  wire                cfg_s1_cmul3_m2c_ac_to_s1_cmul3_m2c_ac_ack;
  wire       [17:0]   s1_cmul3_m2c_ac_0;
  wire                s1_cmul3_m2c_ac_0_req;
  wire                s1_cmul3_m2c_ac_0_ack;
  wire                s1_cmul3_m2c_ac_0_m_req;
  wire                s1_cmul3_m2c_ac_0_m_ack;
  wire                s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_req;
  wire                s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul3_m2c_bc;
  wire                cfg_s1_cmul3_m2c_bc_req;
  wire                cfg_s1_cmul3_m2c_bc_ack;
  wire                cfg_s1_cmul3_m2c_bc_m_req;
  wire                cfg_s1_cmul3_m2c_bc_m_ack;
  wire                cfg_s1_cmul3_m2c_bc_to_s1_cmul3_m2c_bc_req;
  wire                cfg_s1_cmul3_m2c_bc_to_s1_cmul3_m2c_bc_ack;
  wire       [17:0]   s1_cmul3_m2c_bc_0;
  wire                s1_cmul3_m2c_bc_0_req;
  wire                s1_cmul3_m2c_bc_0_ack;
  wire                s1_cmul3_m2c_bc_0_m_req;
  wire                s1_cmul3_m2c_bc_0_m_ack;
  wire                s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_req;
  wire                s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul3_m2c_bd;
  wire                cfg_s1_cmul3_m2c_bd_req;
  wire                cfg_s1_cmul3_m2c_bd_ack;
  wire                cfg_s1_cmul3_m2c_bd_m_req;
  wire                cfg_s1_cmul3_m2c_bd_m_ack;
  wire                cfg_s1_cmul3_m2c_bd_to_s1_cmul3_m2c_bd_req;
  wire                cfg_s1_cmul3_m2c_bd_to_s1_cmul3_m2c_bd_ack;
  wire       [17:0]   s1_cmul3_m2c_bd_0;
  wire                s1_cmul3_m2c_bd_0_req;
  wire                s1_cmul3_m2c_bd_0_ack;
  wire                s1_cmul3_m2c_bd_0_m_req;
  wire                s1_cmul3_m2c_bd_0_m_ack;
  wire                s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_req;
  wire                s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_ack;
  wire       [1:0]    cfg_s1_cmul3_m2c_cb;
  wire                cfg_s1_cmul3_m2c_cb_req;
  wire                cfg_s1_cmul3_m2c_cb_ack;
  wire                cfg_s1_cmul3_m2c_cb_m_req;
  wire                cfg_s1_cmul3_m2c_cb_m_ack;
  wire                cfg_s1_cmul3_m2c_cb_to_s1_cmul3_m2c_cb_req;
  wire                cfg_s1_cmul3_m2c_cb_to_s1_cmul3_m2c_cb_ack;
  wire       [17:0]   s1_cmul3_m2c_cb_0;
  wire                s1_cmul3_m2c_cb_0_req;
  wire                s1_cmul3_m2c_cb_0_ack;
  wire                s1_cmul3_m2c_cb_0_m_req;
  wire                s1_cmul3_m2c_cb_0_m_ack;
  wire                s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_req;
  wire                s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_ack;
  wire       [1:0]    cfg_s1_cmul3_m2c_cd;
  wire                cfg_s1_cmul3_m2c_cd_req;
  wire                cfg_s1_cmul3_m2c_cd_ack;
  wire                cfg_s1_cmul3_m2c_cd_m_req;
  wire                cfg_s1_cmul3_m2c_cd_m_ack;
  wire                cfg_s1_cmul3_m2c_cd_to_s1_cmul3_m2c_cd_req;
  wire                cfg_s1_cmul3_m2c_cd_to_s1_cmul3_m2c_cd_ack;
  wire       [17:0]   s1_cmul3_m2c_cd_0;
  wire                s1_cmul3_m2c_cd_0_req;
  wire                s1_cmul3_m2c_cd_0_ack;
  wire                s1_cmul3_m2c_cd_0_m_req;
  wire                s1_cmul3_m2c_cd_0_m_ack;
  wire                s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_req;
  wire                s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_ack;
  wire       [1:0]    cfg_s1_cmul3_m2c_da;
  wire                cfg_s1_cmul3_m2c_da_req;
  wire                cfg_s1_cmul3_m2c_da_ack;
  wire                cfg_s1_cmul3_m2c_da_m_req;
  wire                cfg_s1_cmul3_m2c_da_m_ack;
  wire                cfg_s1_cmul3_m2c_da_to_s1_cmul3_m2c_da_req;
  wire                cfg_s1_cmul3_m2c_da_to_s1_cmul3_m2c_da_ack;
  wire       [17:0]   s1_cmul3_m2c_da_0;
  wire                s1_cmul3_m2c_da_0_req;
  wire                s1_cmul3_m2c_da_0_ack;
  wire                s1_cmul3_m2c_da_0_m_req;
  wire                s1_cmul3_m2c_da_0_m_ack;
  wire                s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_req;
  wire                s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_ack;
  wire       [71:0]   s1_cmul3_cat_re_0;
  wire       [71:0]   s1_cmul3_cat_re_0_nxt;
  wire                s1_cmul3_cat_re_0_req;
  wire                s1_cmul3_cat_re_0_ack;
  wire                s1_cmul3_cat_re_0_m_req;
  wire                s1_cmul3_cat_re_0_m_ack;
  wire                s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_req;
  wire                s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_ack;
  wire       [71:0]   s1_cmul3_cat_im_0;
  wire       [71:0]   s1_cmul3_cat_im_0_nxt;
  wire                s1_cmul3_cat_im_0_req;
  wire                s1_cmul3_cat_im_0_ack;
  wire                s1_cmul3_cat_im_0_m_req;
  wire                s1_cmul3_cat_im_0_m_ack;
  wire                s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_req;
  wire                s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_ack;
  wire       [1:0]    cfg_s1_cmul3_mas_re;
  wire                cfg_s1_cmul3_mas_re_req;
  wire                cfg_s1_cmul3_mas_re_ack;
  wire                cfg_s1_cmul3_mas_re_m_req;
  wire                cfg_s1_cmul3_mas_re_m_ack;
  wire                cfg_s1_cmul3_mas_re_to_s1_cmul3_mas_re_req;
  wire                cfg_s1_cmul3_mas_re_to_s1_cmul3_mas_re_ack;
  wire       [35:0]   s1_cmul3_mas_re_0;
  wire                s1_cmul3_mas_re_0_req;
  wire                s1_cmul3_mas_re_0_ack;
  wire                s1_cmul3_mas_re_0_m_req;
  wire                s1_cmul3_mas_re_0_m_ack;
  wire                s1_cmul3_mas_re_0_to_s1_r4_a1_re_req;
  wire                s1_cmul3_mas_re_0_to_s1_r4_a3_re_req;
  wire                s1_cmul3_mas_re_0_to_s1_r4_byp3_re_req;
  wire                s1_cmul3_mas_re_0_to_s1_r4_a1_re_ack;
  wire                s1_cmul3_mas_re_0_to_s1_r4_a3_re_ack;
  wire                s1_cmul3_mas_re_0_to_s1_r4_byp3_re_ack;
  wire       [1:0]    cfg_s1_cmul3_mas_im;
  wire                cfg_s1_cmul3_mas_im_req;
  wire                cfg_s1_cmul3_mas_im_ack;
  wire                cfg_s1_cmul3_mas_im_m_req;
  wire                cfg_s1_cmul3_mas_im_m_ack;
  wire                cfg_s1_cmul3_mas_im_to_s1_cmul3_mas_im_req;
  wire                cfg_s1_cmul3_mas_im_to_s1_cmul3_mas_im_ack;
  wire       [35:0]   s1_cmul3_mas_im_0;
  wire                s1_cmul3_mas_im_0_req;
  wire                s1_cmul3_mas_im_0_ack;
  wire                s1_cmul3_mas_im_0_m_req;
  wire                s1_cmul3_mas_im_0_m_ack;
  wire                s1_cmul3_mas_im_0_to_s1_r4_a1_im_req;
  wire                s1_cmul3_mas_im_0_to_s1_r4_a3_im_req;
  wire                s1_cmul3_mas_im_0_to_s1_r4_byp3_im_req;
  wire                s1_cmul3_mas_im_0_to_s1_r4_a1_im_ack;
  wire                s1_cmul3_mas_im_0_to_s1_r4_a3_im_ack;
  wire                s1_cmul3_mas_im_0_to_s1_r4_byp3_im_ack;
  wire       [35:0]   s0_r4_a0_re_0;
  wire       [35:0]   s0_r4_a0_re_0_nxt;
  wire                s0_r4_a0_re_0_req;
  wire                s0_r4_a0_re_0_ack;
  wire                s0_r4_a0_re_0_m_req;
  wire                s0_r4_a0_re_0_m_ack;
  wire                s0_r4_a0_re_0_to_s0_r4_c0_re_req;
  wire                s0_r4_a0_re_0_to_s0_r4_c2_re_req;
  wire                s0_r4_a0_re_0_to_s0_r4_c0_re_ack;
  wire                s0_r4_a0_re_0_to_s0_r4_c2_re_ack;
  wire       [35:0]   s0_r4_a0_im_0;
  wire       [35:0]   s0_r4_a0_im_0_nxt;
  wire                s0_r4_a0_im_0_req;
  wire                s0_r4_a0_im_0_ack;
  wire                s0_r4_a0_im_0_m_req;
  wire                s0_r4_a0_im_0_m_ack;
  wire                s0_r4_a0_im_0_to_s0_r4_c0_im_req;
  wire                s0_r4_a0_im_0_to_s0_r4_c2_im_req;
  wire                s0_r4_a0_im_0_to_s0_r4_c0_im_ack;
  wire                s0_r4_a0_im_0_to_s0_r4_c2_im_ack;
  wire       [35:0]   s0_r4_a1_re_0;
  wire       [35:0]   s0_r4_a1_re_0_nxt;
  wire                s0_r4_a1_re_0_req;
  wire                s0_r4_a1_re_0_ack;
  wire                s0_r4_a1_re_0_m_req;
  wire                s0_r4_a1_re_0_m_ack;
  wire                s0_r4_a1_re_0_to_s0_r4_c0_re_req;
  wire                s0_r4_a1_re_0_to_s0_r4_c2_re_req;
  wire                s0_r4_a1_re_0_to_s0_r4_c0_re_ack;
  wire                s0_r4_a1_re_0_to_s0_r4_c2_re_ack;
  wire       [35:0]   s0_r4_a1_im_0;
  wire       [35:0]   s0_r4_a1_im_0_nxt;
  wire                s0_r4_a1_im_0_req;
  wire                s0_r4_a1_im_0_ack;
  wire                s0_r4_a1_im_0_m_req;
  wire                s0_r4_a1_im_0_m_ack;
  wire                s0_r4_a1_im_0_to_s0_r4_c0_im_req;
  wire                s0_r4_a1_im_0_to_s0_r4_c2_im_req;
  wire                s0_r4_a1_im_0_to_s0_r4_c0_im_ack;
  wire                s0_r4_a1_im_0_to_s0_r4_c2_im_ack;
  wire       [35:0]   s0_r4_a2_re_0;
  wire       [35:0]   s0_r4_a2_re_0_nxt;
  wire                s0_r4_a2_re_0_req;
  wire                s0_r4_a2_re_0_ack;
  wire                s0_r4_a2_re_0_m_req;
  wire                s0_r4_a2_re_0_m_ack;
  wire                s0_r4_a2_re_0_to_s0_r4_c1_re_req;
  wire                s0_r4_a2_re_0_to_s0_r4_c3_re_req;
  wire                s0_r4_a2_re_0_to_s0_r4_c1_re_ack;
  wire                s0_r4_a2_re_0_to_s0_r4_c3_re_ack;
  wire       [35:0]   s0_r4_a2_im_0;
  wire       [35:0]   s0_r4_a2_im_0_nxt;
  wire                s0_r4_a2_im_0_req;
  wire                s0_r4_a2_im_0_ack;
  wire                s0_r4_a2_im_0_m_req;
  wire                s0_r4_a2_im_0_m_ack;
  wire                s0_r4_a2_im_0_to_s0_r4_c1_im_req;
  wire                s0_r4_a2_im_0_to_s0_r4_c3_im_req;
  wire                s0_r4_a2_im_0_to_s0_r4_c1_im_ack;
  wire                s0_r4_a2_im_0_to_s0_r4_c3_im_ack;
  wire       [35:0]   s0_r4_a3_re_0;
  wire       [35:0]   s0_r4_a3_re_0_nxt;
  wire                s0_r4_a3_re_0_req;
  wire                s0_r4_a3_re_0_ack;
  wire                s0_r4_a3_re_0_m_req;
  wire                s0_r4_a3_re_0_m_ack;
  wire                s0_r4_a3_re_0_to_s0_r4_c1_im_req;
  wire                s0_r4_a3_re_0_to_s0_r4_c3_im_req;
  wire                s0_r4_a3_re_0_to_s0_r4_c1_im_ack;
  wire                s0_r4_a3_re_0_to_s0_r4_c3_im_ack;
  wire       [35:0]   s0_r4_a3_im_0;
  wire       [35:0]   s0_r4_a3_im_0_nxt;
  wire                s0_r4_a3_im_0_req;
  wire                s0_r4_a3_im_0_ack;
  wire                s0_r4_a3_im_0_m_req;
  wire                s0_r4_a3_im_0_m_ack;
  wire                s0_r4_a3_im_0_to_s0_r4_c1_re_req;
  wire                s0_r4_a3_im_0_to_s0_r4_c3_re_req;
  wire                s0_r4_a3_im_0_to_s0_r4_c1_re_ack;
  wire                s0_r4_a3_im_0_to_s0_r4_c3_re_ack;
  wire       [35:0]   s0_r4_c0_re_0;
  wire                s0_r4_c0_re_0_req;
  wire                s0_r4_c0_re_0_ack;
  wire                s0_r4_c0_re_0_m_req;
  wire                s0_r4_c0_re_0_m_ack;
  wire                s0_r4_c0_re_0_to_s0_r4_byp0_re_req;
  wire                s0_r4_c0_re_0_to_s0_r4_byp0_re_ack;
  wire       [35:0]   s0_r4_c0_im_0;
  wire                s0_r4_c0_im_0_req;
  wire                s0_r4_c0_im_0_ack;
  wire                s0_r4_c0_im_0_m_req;
  wire                s0_r4_c0_im_0_m_ack;
  wire                s0_r4_c0_im_0_to_s0_r4_byp0_im_req;
  wire                s0_r4_c0_im_0_to_s0_r4_byp0_im_ack;
  wire       [35:0]   s0_r4_c1_re_0;
  wire                s0_r4_c1_re_0_req;
  wire                s0_r4_c1_re_0_ack;
  wire                s0_r4_c1_re_0_m_req;
  wire                s0_r4_c1_re_0_m_ack;
  wire                s0_r4_c1_re_0_to_s0_r4_byp1_re_req;
  wire                s0_r4_c1_re_0_to_s0_r4_byp1_re_ack;
  wire       [35:0]   s0_r4_c1_im_0;
  wire                s0_r4_c1_im_0_req;
  wire                s0_r4_c1_im_0_ack;
  wire                s0_r4_c1_im_0_m_req;
  wire                s0_r4_c1_im_0_m_ack;
  wire                s0_r4_c1_im_0_to_s0_r4_byp1_im_req;
  wire                s0_r4_c1_im_0_to_s0_r4_byp1_im_ack;
  wire       [35:0]   s0_r4_c2_re_0;
  wire                s0_r4_c2_re_0_req;
  wire                s0_r4_c2_re_0_ack;
  wire                s0_r4_c2_re_0_m_req;
  wire                s0_r4_c2_re_0_m_ack;
  wire                s0_r4_c2_re_0_to_s0_r4_byp2_re_req;
  wire                s0_r4_c2_re_0_to_s0_r4_byp2_re_ack;
  wire       [35:0]   s0_r4_c2_im_0;
  wire                s0_r4_c2_im_0_req;
  wire                s0_r4_c2_im_0_ack;
  wire                s0_r4_c2_im_0_m_req;
  wire                s0_r4_c2_im_0_m_ack;
  wire                s0_r4_c2_im_0_to_s0_r4_byp2_im_req;
  wire                s0_r4_c2_im_0_to_s0_r4_byp2_im_ack;
  wire       [35:0]   s0_r4_c3_re_0;
  wire                s0_r4_c3_re_0_req;
  wire                s0_r4_c3_re_0_ack;
  wire                s0_r4_c3_re_0_m_req;
  wire                s0_r4_c3_re_0_m_ack;
  wire                s0_r4_c3_re_0_to_s0_r4_byp3_re_req;
  wire                s0_r4_c3_re_0_to_s0_r4_byp3_re_ack;
  wire       [35:0]   s0_r4_c3_im_0;
  wire                s0_r4_c3_im_0_req;
  wire                s0_r4_c3_im_0_ack;
  wire                s0_r4_c3_im_0_m_req;
  wire                s0_r4_c3_im_0_m_ack;
  wire                s0_r4_c3_im_0_to_s0_r4_byp3_im_req;
  wire                s0_r4_c3_im_0_to_s0_r4_byp3_im_ack;
  wire       [1:0]    cfg_s0_r4_byp0_re;
  wire                cfg_s0_r4_byp0_re_req;
  wire                cfg_s0_r4_byp0_re_ack;
  wire                cfg_s0_r4_byp0_re_m_req;
  wire                cfg_s0_r4_byp0_re_m_ack;
  wire                cfg_s0_r4_byp0_re_to_s0_r4_byp0_re_req;
  wire                cfg_s0_r4_byp0_re_to_s0_r4_byp0_re_ack;
  wire       [1:0]    cfg_s0_r4_byp0_im;
  wire                cfg_s0_r4_byp0_im_req;
  wire                cfg_s0_r4_byp0_im_ack;
  wire                cfg_s0_r4_byp0_im_m_req;
  wire                cfg_s0_r4_byp0_im_m_ack;
  wire                cfg_s0_r4_byp0_im_to_s0_r4_byp0_im_req;
  wire                cfg_s0_r4_byp0_im_to_s0_r4_byp0_im_ack;
  wire       [35:0]   s0_r4_byp0_re_0;
  wire       [35:0]   s0_r4_byp0_re_0_nxt;
  wire                s0_r4_byp0_re_0_req;
  wire                s0_r4_byp0_re_0_ack;
  wire                s0_r4_byp0_re_0_m_req;
  wire                s0_r4_byp0_re_0_m_ack;
  wire                s0_r4_byp0_re_0_to_s0_bs0_re_req;
  wire                s0_r4_byp0_re_0_to_s0_bs0_re_ack;
  wire       [35:0]   s0_r4_byp0_im_0;
  wire       [35:0]   s0_r4_byp0_im_0_nxt;
  wire                s0_r4_byp0_im_0_req;
  wire                s0_r4_byp0_im_0_ack;
  wire                s0_r4_byp0_im_0_m_req;
  wire                s0_r4_byp0_im_0_m_ack;
  wire                s0_r4_byp0_im_0_to_s0_bs0_im_req;
  wire                s0_r4_byp0_im_0_to_s0_bs0_im_ack;
  wire       [1:0]    cfg_s0_r4_byp1_re;
  wire                cfg_s0_r4_byp1_re_req;
  wire                cfg_s0_r4_byp1_re_ack;
  wire                cfg_s0_r4_byp1_re_m_req;
  wire                cfg_s0_r4_byp1_re_m_ack;
  wire                cfg_s0_r4_byp1_re_to_s0_r4_byp1_re_req;
  wire                cfg_s0_r4_byp1_re_to_s0_r4_byp1_re_ack;
  wire       [1:0]    cfg_s0_r4_byp1_im;
  wire                cfg_s0_r4_byp1_im_req;
  wire                cfg_s0_r4_byp1_im_ack;
  wire                cfg_s0_r4_byp1_im_m_req;
  wire                cfg_s0_r4_byp1_im_m_ack;
  wire                cfg_s0_r4_byp1_im_to_s0_r4_byp1_im_req;
  wire                cfg_s0_r4_byp1_im_to_s0_r4_byp1_im_ack;
  wire       [35:0]   s0_r4_byp1_re_0;
  wire       [35:0]   s0_r4_byp1_re_0_nxt;
  wire                s0_r4_byp1_re_0_req;
  wire                s0_r4_byp1_re_0_ack;
  wire                s0_r4_byp1_re_0_m_req;
  wire                s0_r4_byp1_re_0_m_ack;
  wire                s0_r4_byp1_re_0_to_s0_bs1_re_req;
  wire                s0_r4_byp1_re_0_to_s0_bs1_re_ack;
  wire       [35:0]   s0_r4_byp1_im_0;
  wire       [35:0]   s0_r4_byp1_im_0_nxt;
  wire                s0_r4_byp1_im_0_req;
  wire                s0_r4_byp1_im_0_ack;
  wire                s0_r4_byp1_im_0_m_req;
  wire                s0_r4_byp1_im_0_m_ack;
  wire                s0_r4_byp1_im_0_to_s0_bs1_im_req;
  wire                s0_r4_byp1_im_0_to_s0_bs1_im_ack;
  wire       [1:0]    cfg_s0_r4_byp2_re;
  wire                cfg_s0_r4_byp2_re_req;
  wire                cfg_s0_r4_byp2_re_ack;
  wire                cfg_s0_r4_byp2_re_m_req;
  wire                cfg_s0_r4_byp2_re_m_ack;
  wire                cfg_s0_r4_byp2_re_to_s0_r4_byp2_re_req;
  wire                cfg_s0_r4_byp2_re_to_s0_r4_byp2_re_ack;
  wire       [1:0]    cfg_s0_r4_byp2_im;
  wire                cfg_s0_r4_byp2_im_req;
  wire                cfg_s0_r4_byp2_im_ack;
  wire                cfg_s0_r4_byp2_im_m_req;
  wire                cfg_s0_r4_byp2_im_m_ack;
  wire                cfg_s0_r4_byp2_im_to_s0_r4_byp2_im_req;
  wire                cfg_s0_r4_byp2_im_to_s0_r4_byp2_im_ack;
  wire       [35:0]   s0_r4_byp2_re_0;
  wire       [35:0]   s0_r4_byp2_re_0_nxt;
  wire                s0_r4_byp2_re_0_req;
  wire                s0_r4_byp2_re_0_ack;
  wire                s0_r4_byp2_re_0_m_req;
  wire                s0_r4_byp2_re_0_m_ack;
  wire                s0_r4_byp2_re_0_to_s0_bs2_re_req;
  wire                s0_r4_byp2_re_0_to_s0_bs2_re_ack;
  wire       [35:0]   s0_r4_byp2_im_0;
  wire       [35:0]   s0_r4_byp2_im_0_nxt;
  wire                s0_r4_byp2_im_0_req;
  wire                s0_r4_byp2_im_0_ack;
  wire                s0_r4_byp2_im_0_m_req;
  wire                s0_r4_byp2_im_0_m_ack;
  wire                s0_r4_byp2_im_0_to_s0_bs2_im_req;
  wire                s0_r4_byp2_im_0_to_s0_bs2_im_ack;
  wire       [1:0]    cfg_s0_r4_byp3_re;
  wire                cfg_s0_r4_byp3_re_req;
  wire                cfg_s0_r4_byp3_re_ack;
  wire                cfg_s0_r4_byp3_re_m_req;
  wire                cfg_s0_r4_byp3_re_m_ack;
  wire                cfg_s0_r4_byp3_re_to_s0_r4_byp3_re_req;
  wire                cfg_s0_r4_byp3_re_to_s0_r4_byp3_re_ack;
  wire       [1:0]    cfg_s0_r4_byp3_im;
  wire                cfg_s0_r4_byp3_im_req;
  wire                cfg_s0_r4_byp3_im_ack;
  wire                cfg_s0_r4_byp3_im_m_req;
  wire                cfg_s0_r4_byp3_im_m_ack;
  wire                cfg_s0_r4_byp3_im_to_s0_r4_byp3_im_req;
  wire                cfg_s0_r4_byp3_im_to_s0_r4_byp3_im_ack;
  wire       [35:0]   s0_r4_byp3_re_0;
  wire       [35:0]   s0_r4_byp3_re_0_nxt;
  wire                s0_r4_byp3_re_0_req;
  wire                s0_r4_byp3_re_0_ack;
  wire                s0_r4_byp3_re_0_m_req;
  wire                s0_r4_byp3_re_0_m_ack;
  wire                s0_r4_byp3_re_0_to_s0_bs3_re_req;
  wire                s0_r4_byp3_re_0_to_s0_bs3_re_ack;
  wire       [35:0]   s0_r4_byp3_im_0;
  wire       [35:0]   s0_r4_byp3_im_0_nxt;
  wire                s0_r4_byp3_im_0_req;
  wire                s0_r4_byp3_im_0_ack;
  wire                s0_r4_byp3_im_0_m_req;
  wire                s0_r4_byp3_im_0_m_ack;
  wire                s0_r4_byp3_im_0_to_s0_bs3_im_req;
  wire                s0_r4_byp3_im_0_to_s0_bs3_im_ack;
  wire       [35:0]   s1_r4_a0_re_0;
  wire       [35:0]   s1_r4_a0_re_0_nxt;
  wire                s1_r4_a0_re_0_req;
  wire                s1_r4_a0_re_0_ack;
  wire                s1_r4_a0_re_0_m_req;
  wire                s1_r4_a0_re_0_m_ack;
  wire                s1_r4_a0_re_0_to_s1_r4_c0_re_req;
  wire                s1_r4_a0_re_0_to_s1_r4_c2_re_req;
  wire                s1_r4_a0_re_0_to_s1_r4_c0_re_ack;
  wire                s1_r4_a0_re_0_to_s1_r4_c2_re_ack;
  wire       [35:0]   s1_r4_a0_im_0;
  wire       [35:0]   s1_r4_a0_im_0_nxt;
  wire                s1_r4_a0_im_0_req;
  wire                s1_r4_a0_im_0_ack;
  wire                s1_r4_a0_im_0_m_req;
  wire                s1_r4_a0_im_0_m_ack;
  wire                s1_r4_a0_im_0_to_s1_r4_c0_im_req;
  wire                s1_r4_a0_im_0_to_s1_r4_c2_im_req;
  wire                s1_r4_a0_im_0_to_s1_r4_c0_im_ack;
  wire                s1_r4_a0_im_0_to_s1_r4_c2_im_ack;
  wire       [35:0]   s1_r4_a1_re_0;
  wire       [35:0]   s1_r4_a1_re_0_nxt;
  wire                s1_r4_a1_re_0_req;
  wire                s1_r4_a1_re_0_ack;
  wire                s1_r4_a1_re_0_m_req;
  wire                s1_r4_a1_re_0_m_ack;
  wire                s1_r4_a1_re_0_to_s1_r4_c0_re_req;
  wire                s1_r4_a1_re_0_to_s1_r4_c2_re_req;
  wire                s1_r4_a1_re_0_to_s1_r4_c0_re_ack;
  wire                s1_r4_a1_re_0_to_s1_r4_c2_re_ack;
  wire       [35:0]   s1_r4_a1_im_0;
  wire       [35:0]   s1_r4_a1_im_0_nxt;
  wire                s1_r4_a1_im_0_req;
  wire                s1_r4_a1_im_0_ack;
  wire                s1_r4_a1_im_0_m_req;
  wire                s1_r4_a1_im_0_m_ack;
  wire                s1_r4_a1_im_0_to_s1_r4_c0_im_req;
  wire                s1_r4_a1_im_0_to_s1_r4_c2_im_req;
  wire                s1_r4_a1_im_0_to_s1_r4_c0_im_ack;
  wire                s1_r4_a1_im_0_to_s1_r4_c2_im_ack;
  wire       [35:0]   s1_r4_a2_re_0;
  wire       [35:0]   s1_r4_a2_re_0_nxt;
  wire                s1_r4_a2_re_0_req;
  wire                s1_r4_a2_re_0_ack;
  wire                s1_r4_a2_re_0_m_req;
  wire                s1_r4_a2_re_0_m_ack;
  wire                s1_r4_a2_re_0_to_s1_r4_c1_re_req;
  wire                s1_r4_a2_re_0_to_s1_r4_c3_re_req;
  wire                s1_r4_a2_re_0_to_s1_r4_c1_re_ack;
  wire                s1_r4_a2_re_0_to_s1_r4_c3_re_ack;
  wire       [35:0]   s1_r4_a2_im_0;
  wire       [35:0]   s1_r4_a2_im_0_nxt;
  wire                s1_r4_a2_im_0_req;
  wire                s1_r4_a2_im_0_ack;
  wire                s1_r4_a2_im_0_m_req;
  wire                s1_r4_a2_im_0_m_ack;
  wire                s1_r4_a2_im_0_to_s1_r4_c1_im_req;
  wire                s1_r4_a2_im_0_to_s1_r4_c3_im_req;
  wire                s1_r4_a2_im_0_to_s1_r4_c1_im_ack;
  wire                s1_r4_a2_im_0_to_s1_r4_c3_im_ack;
  wire       [35:0]   s1_r4_a3_re_0;
  wire       [35:0]   s1_r4_a3_re_0_nxt;
  wire                s1_r4_a3_re_0_req;
  wire                s1_r4_a3_re_0_ack;
  wire                s1_r4_a3_re_0_m_req;
  wire                s1_r4_a3_re_0_m_ack;
  wire                s1_r4_a3_re_0_to_s1_r4_c1_im_req;
  wire                s1_r4_a3_re_0_to_s1_r4_c3_im_req;
  wire                s1_r4_a3_re_0_to_s1_r4_c1_im_ack;
  wire                s1_r4_a3_re_0_to_s1_r4_c3_im_ack;
  wire       [35:0]   s1_r4_a3_im_0;
  wire       [35:0]   s1_r4_a3_im_0_nxt;
  wire                s1_r4_a3_im_0_req;
  wire                s1_r4_a3_im_0_ack;
  wire                s1_r4_a3_im_0_m_req;
  wire                s1_r4_a3_im_0_m_ack;
  wire                s1_r4_a3_im_0_to_s1_r4_c1_re_req;
  wire                s1_r4_a3_im_0_to_s1_r4_c3_re_req;
  wire                s1_r4_a3_im_0_to_s1_r4_c1_re_ack;
  wire                s1_r4_a3_im_0_to_s1_r4_c3_re_ack;
  wire       [35:0]   s1_r4_c0_re_0;
  wire                s1_r4_c0_re_0_req;
  wire                s1_r4_c0_re_0_ack;
  wire                s1_r4_c0_re_0_m_req;
  wire                s1_r4_c0_re_0_m_ack;
  wire                s1_r4_c0_re_0_to_s1_r4_byp0_re_req;
  wire                s1_r4_c0_re_0_to_s1_r4_byp0_re_ack;
  wire       [35:0]   s1_r4_c0_im_0;
  wire                s1_r4_c0_im_0_req;
  wire                s1_r4_c0_im_0_ack;
  wire                s1_r4_c0_im_0_m_req;
  wire                s1_r4_c0_im_0_m_ack;
  wire                s1_r4_c0_im_0_to_s1_r4_byp0_im_req;
  wire                s1_r4_c0_im_0_to_s1_r4_byp0_im_ack;
  wire       [35:0]   s1_r4_c1_re_0;
  wire                s1_r4_c1_re_0_req;
  wire                s1_r4_c1_re_0_ack;
  wire                s1_r4_c1_re_0_m_req;
  wire                s1_r4_c1_re_0_m_ack;
  wire                s1_r4_c1_re_0_to_s1_r4_byp1_re_req;
  wire                s1_r4_c1_re_0_to_s1_r4_byp1_re_ack;
  wire       [35:0]   s1_r4_c1_im_0;
  wire                s1_r4_c1_im_0_req;
  wire                s1_r4_c1_im_0_ack;
  wire                s1_r4_c1_im_0_m_req;
  wire                s1_r4_c1_im_0_m_ack;
  wire                s1_r4_c1_im_0_to_s1_r4_byp1_im_req;
  wire                s1_r4_c1_im_0_to_s1_r4_byp1_im_ack;
  wire       [35:0]   s1_r4_c2_re_0;
  wire                s1_r4_c2_re_0_req;
  wire                s1_r4_c2_re_0_ack;
  wire                s1_r4_c2_re_0_m_req;
  wire                s1_r4_c2_re_0_m_ack;
  wire                s1_r4_c2_re_0_to_s1_r4_byp2_re_req;
  wire                s1_r4_c2_re_0_to_s1_r4_byp2_re_ack;
  wire       [35:0]   s1_r4_c2_im_0;
  wire                s1_r4_c2_im_0_req;
  wire                s1_r4_c2_im_0_ack;
  wire                s1_r4_c2_im_0_m_req;
  wire                s1_r4_c2_im_0_m_ack;
  wire                s1_r4_c2_im_0_to_s1_r4_byp2_im_req;
  wire                s1_r4_c2_im_0_to_s1_r4_byp2_im_ack;
  wire       [35:0]   s1_r4_c3_re_0;
  wire                s1_r4_c3_re_0_req;
  wire                s1_r4_c3_re_0_ack;
  wire                s1_r4_c3_re_0_m_req;
  wire                s1_r4_c3_re_0_m_ack;
  wire                s1_r4_c3_re_0_to_s1_r4_byp3_re_req;
  wire                s1_r4_c3_re_0_to_s1_r4_byp3_re_ack;
  wire       [35:0]   s1_r4_c3_im_0;
  wire                s1_r4_c3_im_0_req;
  wire                s1_r4_c3_im_0_ack;
  wire                s1_r4_c3_im_0_m_req;
  wire                s1_r4_c3_im_0_m_ack;
  wire                s1_r4_c3_im_0_to_s1_r4_byp3_im_req;
  wire                s1_r4_c3_im_0_to_s1_r4_byp3_im_ack;
  wire       [1:0]    cfg_s1_r4_byp0_re;
  wire                cfg_s1_r4_byp0_re_req;
  wire                cfg_s1_r4_byp0_re_ack;
  wire                cfg_s1_r4_byp0_re_m_req;
  wire                cfg_s1_r4_byp0_re_m_ack;
  wire                cfg_s1_r4_byp0_re_to_s1_r4_byp0_re_req;
  wire                cfg_s1_r4_byp0_re_to_s1_r4_byp0_re_ack;
  wire       [1:0]    cfg_s1_r4_byp0_im;
  wire                cfg_s1_r4_byp0_im_req;
  wire                cfg_s1_r4_byp0_im_ack;
  wire                cfg_s1_r4_byp0_im_m_req;
  wire                cfg_s1_r4_byp0_im_m_ack;
  wire                cfg_s1_r4_byp0_im_to_s1_r4_byp0_im_req;
  wire                cfg_s1_r4_byp0_im_to_s1_r4_byp0_im_ack;
  wire       [35:0]   s1_r4_byp0_re_0;
  wire       [35:0]   s1_r4_byp0_re_0_nxt;
  wire                s1_r4_byp0_re_0_req;
  wire                s1_r4_byp0_re_0_ack;
  wire                s1_r4_byp0_re_0_m_req;
  wire                s1_r4_byp0_re_0_m_ack;
  wire                s1_r4_byp0_re_0_to_s1_bs0_re_req;
  wire                s1_r4_byp0_re_0_to_s1_bs0_re_ack;
  wire       [35:0]   s1_r4_byp0_im_0;
  wire       [35:0]   s1_r4_byp0_im_0_nxt;
  wire                s1_r4_byp0_im_0_req;
  wire                s1_r4_byp0_im_0_ack;
  wire                s1_r4_byp0_im_0_m_req;
  wire                s1_r4_byp0_im_0_m_ack;
  wire                s1_r4_byp0_im_0_to_s1_bs0_im_req;
  wire                s1_r4_byp0_im_0_to_s1_bs0_im_ack;
  wire       [1:0]    cfg_s1_r4_byp1_re;
  wire                cfg_s1_r4_byp1_re_req;
  wire                cfg_s1_r4_byp1_re_ack;
  wire                cfg_s1_r4_byp1_re_m_req;
  wire                cfg_s1_r4_byp1_re_m_ack;
  wire                cfg_s1_r4_byp1_re_to_s1_r4_byp1_re_req;
  wire                cfg_s1_r4_byp1_re_to_s1_r4_byp1_re_ack;
  wire       [1:0]    cfg_s1_r4_byp1_im;
  wire                cfg_s1_r4_byp1_im_req;
  wire                cfg_s1_r4_byp1_im_ack;
  wire                cfg_s1_r4_byp1_im_m_req;
  wire                cfg_s1_r4_byp1_im_m_ack;
  wire                cfg_s1_r4_byp1_im_to_s1_r4_byp1_im_req;
  wire                cfg_s1_r4_byp1_im_to_s1_r4_byp1_im_ack;
  wire       [35:0]   s1_r4_byp1_re_0;
  wire       [35:0]   s1_r4_byp1_re_0_nxt;
  wire                s1_r4_byp1_re_0_req;
  wire                s1_r4_byp1_re_0_ack;
  wire                s1_r4_byp1_re_0_m_req;
  wire                s1_r4_byp1_re_0_m_ack;
  wire                s1_r4_byp1_re_0_to_s1_bs1_re_req;
  wire                s1_r4_byp1_re_0_to_s1_bs1_re_ack;
  wire       [35:0]   s1_r4_byp1_im_0;
  wire       [35:0]   s1_r4_byp1_im_0_nxt;
  wire                s1_r4_byp1_im_0_req;
  wire                s1_r4_byp1_im_0_ack;
  wire                s1_r4_byp1_im_0_m_req;
  wire                s1_r4_byp1_im_0_m_ack;
  wire                s1_r4_byp1_im_0_to_s1_bs1_im_req;
  wire                s1_r4_byp1_im_0_to_s1_bs1_im_ack;
  wire       [1:0]    cfg_s1_r4_byp2_re;
  wire                cfg_s1_r4_byp2_re_req;
  wire                cfg_s1_r4_byp2_re_ack;
  wire                cfg_s1_r4_byp2_re_m_req;
  wire                cfg_s1_r4_byp2_re_m_ack;
  wire                cfg_s1_r4_byp2_re_to_s1_r4_byp2_re_req;
  wire                cfg_s1_r4_byp2_re_to_s1_r4_byp2_re_ack;
  wire       [1:0]    cfg_s1_r4_byp2_im;
  wire                cfg_s1_r4_byp2_im_req;
  wire                cfg_s1_r4_byp2_im_ack;
  wire                cfg_s1_r4_byp2_im_m_req;
  wire                cfg_s1_r4_byp2_im_m_ack;
  wire                cfg_s1_r4_byp2_im_to_s1_r4_byp2_im_req;
  wire                cfg_s1_r4_byp2_im_to_s1_r4_byp2_im_ack;
  wire       [35:0]   s1_r4_byp2_re_0;
  wire       [35:0]   s1_r4_byp2_re_0_nxt;
  wire                s1_r4_byp2_re_0_req;
  wire                s1_r4_byp2_re_0_ack;
  wire                s1_r4_byp2_re_0_m_req;
  wire                s1_r4_byp2_re_0_m_ack;
  wire                s1_r4_byp2_re_0_to_s1_bs2_re_req;
  wire                s1_r4_byp2_re_0_to_s1_bs2_re_ack;
  wire       [35:0]   s1_r4_byp2_im_0;
  wire       [35:0]   s1_r4_byp2_im_0_nxt;
  wire                s1_r4_byp2_im_0_req;
  wire                s1_r4_byp2_im_0_ack;
  wire                s1_r4_byp2_im_0_m_req;
  wire                s1_r4_byp2_im_0_m_ack;
  wire                s1_r4_byp2_im_0_to_s1_bs2_im_req;
  wire                s1_r4_byp2_im_0_to_s1_bs2_im_ack;
  wire       [1:0]    cfg_s1_r4_byp3_re;
  wire                cfg_s1_r4_byp3_re_req;
  wire                cfg_s1_r4_byp3_re_ack;
  wire                cfg_s1_r4_byp3_re_m_req;
  wire                cfg_s1_r4_byp3_re_m_ack;
  wire                cfg_s1_r4_byp3_re_to_s1_r4_byp3_re_req;
  wire                cfg_s1_r4_byp3_re_to_s1_r4_byp3_re_ack;
  wire       [1:0]    cfg_s1_r4_byp3_im;
  wire                cfg_s1_r4_byp3_im_req;
  wire                cfg_s1_r4_byp3_im_ack;
  wire                cfg_s1_r4_byp3_im_m_req;
  wire                cfg_s1_r4_byp3_im_m_ack;
  wire                cfg_s1_r4_byp3_im_to_s1_r4_byp3_im_req;
  wire                cfg_s1_r4_byp3_im_to_s1_r4_byp3_im_ack;
  wire       [35:0]   s1_r4_byp3_re_0;
  wire       [35:0]   s1_r4_byp3_re_0_nxt;
  wire                s1_r4_byp3_re_0_req;
  wire                s1_r4_byp3_re_0_ack;
  wire                s1_r4_byp3_re_0_m_req;
  wire                s1_r4_byp3_re_0_m_ack;
  wire                s1_r4_byp3_re_0_to_s1_bs3_re_req;
  wire                s1_r4_byp3_re_0_to_s1_bs3_re_ack;
  wire       [35:0]   s1_r4_byp3_im_0;
  wire       [35:0]   s1_r4_byp3_im_0_nxt;
  wire                s1_r4_byp3_im_0_req;
  wire                s1_r4_byp3_im_0_ack;
  wire                s1_r4_byp3_im_0_m_req;
  wire                s1_r4_byp3_im_0_m_ack;
  wire                s1_r4_byp3_im_0_to_s1_bs3_im_req;
  wire                s1_r4_byp3_im_0_to_s1_bs3_im_ack;
  wire       [127:0]  s0_k1_cat_0;
  wire                s0_k1_cat_0_req;
  wire                s0_k1_cat_0_ack;
  wire                s0_k1_cat_0_m_req;
  wire                s0_k1_cat_0_m_ack;
  wire                s0_k1_cat_0_to_k1_defunnel_req;
  wire                s0_k1_cat_0_to_k1_defunnel_ack;
  wire       [7:0]    cfg_s0_bs0_re;
  wire                cfg_s0_bs0_re_req;
  wire                cfg_s0_bs0_re_ack;
  wire                cfg_s0_bs0_re_m_req;
  wire                cfg_s0_bs0_re_m_ack;
  wire                cfg_s0_bs0_re_to_s0_bs0_re_req;
  wire                cfg_s0_bs0_re_to_s0_bs0_re_ack;
  wire       [7:0]    cfg_s0_bs0_im;
  wire                cfg_s0_bs0_im_req;
  wire                cfg_s0_bs0_im_ack;
  wire                cfg_s0_bs0_im_m_req;
  wire                cfg_s0_bs0_im_m_ack;
  wire                cfg_s0_bs0_im_to_s0_bs0_im_req;
  wire                cfg_s0_bs0_im_to_s0_bs0_im_ack;
  wire       [19:0]   s0_bs0_re_0;
  wire       [19:0]   s0_bs0_re_0_nxt;
  wire                s0_bs0_re_0_req;
  wire                s0_bs0_re_0_ack;
  wire                s0_bs0_re_0_m_req;
  wire                s0_bs0_re_0_m_ack;
  wire                s0_bs0_re_0_to_s0_rsat0_re_req;
  wire                s0_bs0_re_0_to_s0_rsat0_re_ack;
  wire       [19:0]   s0_bs0_im_0;
  wire       [19:0]   s0_bs0_im_0_nxt;
  wire                s0_bs0_im_0_req;
  wire                s0_bs0_im_0_ack;
  wire                s0_bs0_im_0_m_req;
  wire                s0_bs0_im_0_m_ack;
  wire                s0_bs0_im_0_to_s0_rsat0_im_req;
  wire                s0_bs0_im_0_to_s0_rsat0_im_ack;
  wire       [15:0]   s0_rsat0_re_0;
  wire       [15:0]   s0_rsat0_re_0_nxt;
  wire                s0_rsat0_re_0_req;
  wire                s0_rsat0_re_0_ack;
  wire                s0_rsat0_re_0_m_req;
  wire                s0_rsat0_re_0_m_ack;
  wire                s0_rsat0_re_0_to_s0_k1_cat_req;
  wire                s0_rsat0_re_0_to_s0_k1_cat_ack;
  wire       [15:0]   s0_rsat0_im_0;
  wire       [15:0]   s0_rsat0_im_0_nxt;
  wire                s0_rsat0_im_0_req;
  wire                s0_rsat0_im_0_ack;
  wire                s0_rsat0_im_0_m_req;
  wire                s0_rsat0_im_0_m_ack;
  wire                s0_rsat0_im_0_to_s0_k1_cat_req;
  wire                s0_rsat0_im_0_to_s0_k1_cat_ack;
  wire       [7:0]    cfg_s0_bs1_re;
  wire                cfg_s0_bs1_re_req;
  wire                cfg_s0_bs1_re_ack;
  wire                cfg_s0_bs1_re_m_req;
  wire                cfg_s0_bs1_re_m_ack;
  wire                cfg_s0_bs1_re_to_s0_bs1_re_req;
  wire                cfg_s0_bs1_re_to_s0_bs1_re_ack;
  wire       [7:0]    cfg_s0_bs1_im;
  wire                cfg_s0_bs1_im_req;
  wire                cfg_s0_bs1_im_ack;
  wire                cfg_s0_bs1_im_m_req;
  wire                cfg_s0_bs1_im_m_ack;
  wire                cfg_s0_bs1_im_to_s0_bs1_im_req;
  wire                cfg_s0_bs1_im_to_s0_bs1_im_ack;
  wire       [19:0]   s0_bs1_re_0;
  wire       [19:0]   s0_bs1_re_0_nxt;
  wire                s0_bs1_re_0_req;
  wire                s0_bs1_re_0_ack;
  wire                s0_bs1_re_0_m_req;
  wire                s0_bs1_re_0_m_ack;
  wire                s0_bs1_re_0_to_s0_rsat1_re_req;
  wire                s0_bs1_re_0_to_s0_rsat1_re_ack;
  wire       [19:0]   s0_bs1_im_0;
  wire       [19:0]   s0_bs1_im_0_nxt;
  wire                s0_bs1_im_0_req;
  wire                s0_bs1_im_0_ack;
  wire                s0_bs1_im_0_m_req;
  wire                s0_bs1_im_0_m_ack;
  wire                s0_bs1_im_0_to_s0_rsat1_im_req;
  wire                s0_bs1_im_0_to_s0_rsat1_im_ack;
  wire       [15:0]   s0_rsat1_re_0;
  wire       [15:0]   s0_rsat1_re_0_nxt;
  wire                s0_rsat1_re_0_req;
  wire                s0_rsat1_re_0_ack;
  wire                s0_rsat1_re_0_m_req;
  wire                s0_rsat1_re_0_m_ack;
  wire                s0_rsat1_re_0_to_s0_k1_cat_req;
  wire                s0_rsat1_re_0_to_s0_k1_cat_ack;
  wire       [15:0]   s0_rsat1_im_0;
  wire       [15:0]   s0_rsat1_im_0_nxt;
  wire                s0_rsat1_im_0_req;
  wire                s0_rsat1_im_0_ack;
  wire                s0_rsat1_im_0_m_req;
  wire                s0_rsat1_im_0_m_ack;
  wire                s0_rsat1_im_0_to_s0_k1_cat_req;
  wire                s0_rsat1_im_0_to_s0_k1_cat_ack;
  wire       [7:0]    cfg_s0_bs2_re;
  wire                cfg_s0_bs2_re_req;
  wire                cfg_s0_bs2_re_ack;
  wire                cfg_s0_bs2_re_m_req;
  wire                cfg_s0_bs2_re_m_ack;
  wire                cfg_s0_bs2_re_to_s0_bs2_re_req;
  wire                cfg_s0_bs2_re_to_s0_bs2_re_ack;
  wire       [7:0]    cfg_s0_bs2_im;
  wire                cfg_s0_bs2_im_req;
  wire                cfg_s0_bs2_im_ack;
  wire                cfg_s0_bs2_im_m_req;
  wire                cfg_s0_bs2_im_m_ack;
  wire                cfg_s0_bs2_im_to_s0_bs2_im_req;
  wire                cfg_s0_bs2_im_to_s0_bs2_im_ack;
  wire       [19:0]   s0_bs2_re_0;
  wire       [19:0]   s0_bs2_re_0_nxt;
  wire                s0_bs2_re_0_req;
  wire                s0_bs2_re_0_ack;
  wire                s0_bs2_re_0_m_req;
  wire                s0_bs2_re_0_m_ack;
  wire                s0_bs2_re_0_to_s0_rsat2_re_req;
  wire                s0_bs2_re_0_to_s0_rsat2_re_ack;
  wire       [19:0]   s0_bs2_im_0;
  wire       [19:0]   s0_bs2_im_0_nxt;
  wire                s0_bs2_im_0_req;
  wire                s0_bs2_im_0_ack;
  wire                s0_bs2_im_0_m_req;
  wire                s0_bs2_im_0_m_ack;
  wire                s0_bs2_im_0_to_s0_rsat2_im_req;
  wire                s0_bs2_im_0_to_s0_rsat2_im_ack;
  wire       [15:0]   s0_rsat2_re_0;
  wire       [15:0]   s0_rsat2_re_0_nxt;
  wire                s0_rsat2_re_0_req;
  wire                s0_rsat2_re_0_ack;
  wire                s0_rsat2_re_0_m_req;
  wire                s0_rsat2_re_0_m_ack;
  wire                s0_rsat2_re_0_to_s0_k1_cat_req;
  wire                s0_rsat2_re_0_to_s0_k1_cat_ack;
  wire       [15:0]   s0_rsat2_im_0;
  wire       [15:0]   s0_rsat2_im_0_nxt;
  wire                s0_rsat2_im_0_req;
  wire                s0_rsat2_im_0_ack;
  wire                s0_rsat2_im_0_m_req;
  wire                s0_rsat2_im_0_m_ack;
  wire                s0_rsat2_im_0_to_s0_k1_cat_req;
  wire                s0_rsat2_im_0_to_s0_k1_cat_ack;
  wire       [7:0]    cfg_s0_bs3_re;
  wire                cfg_s0_bs3_re_req;
  wire                cfg_s0_bs3_re_ack;
  wire                cfg_s0_bs3_re_m_req;
  wire                cfg_s0_bs3_re_m_ack;
  wire                cfg_s0_bs3_re_to_s0_bs3_re_req;
  wire                cfg_s0_bs3_re_to_s0_bs3_re_ack;
  wire       [7:0]    cfg_s0_bs3_im;
  wire                cfg_s0_bs3_im_req;
  wire                cfg_s0_bs3_im_ack;
  wire                cfg_s0_bs3_im_m_req;
  wire                cfg_s0_bs3_im_m_ack;
  wire                cfg_s0_bs3_im_to_s0_bs3_im_req;
  wire                cfg_s0_bs3_im_to_s0_bs3_im_ack;
  wire       [19:0]   s0_bs3_re_0;
  wire       [19:0]   s0_bs3_re_0_nxt;
  wire                s0_bs3_re_0_req;
  wire                s0_bs3_re_0_ack;
  wire                s0_bs3_re_0_m_req;
  wire                s0_bs3_re_0_m_ack;
  wire                s0_bs3_re_0_to_s0_rsat3_re_req;
  wire                s0_bs3_re_0_to_s0_rsat3_re_ack;
  wire       [19:0]   s0_bs3_im_0;
  wire       [19:0]   s0_bs3_im_0_nxt;
  wire                s0_bs3_im_0_req;
  wire                s0_bs3_im_0_ack;
  wire                s0_bs3_im_0_m_req;
  wire                s0_bs3_im_0_m_ack;
  wire                s0_bs3_im_0_to_s0_rsat3_im_req;
  wire                s0_bs3_im_0_to_s0_rsat3_im_ack;
  wire       [15:0]   s0_rsat3_re_0;
  wire       [15:0]   s0_rsat3_re_0_nxt;
  wire                s0_rsat3_re_0_req;
  wire                s0_rsat3_re_0_ack;
  wire                s0_rsat3_re_0_m_req;
  wire                s0_rsat3_re_0_m_ack;
  wire                s0_rsat3_re_0_to_s0_k1_cat_req;
  wire                s0_rsat3_re_0_to_s0_k1_cat_ack;
  wire       [15:0]   s0_rsat3_im_0;
  wire       [15:0]   s0_rsat3_im_0_nxt;
  wire                s0_rsat3_im_0_req;
  wire                s0_rsat3_im_0_ack;
  wire                s0_rsat3_im_0_m_req;
  wire                s0_rsat3_im_0_m_ack;
  wire                s0_rsat3_im_0_to_s0_k1_cat_req;
  wire                s0_rsat3_im_0_to_s0_k1_cat_ack;
  wire       [127:0]  s1_k1_cat_0;
  wire                s1_k1_cat_0_req;
  wire                s1_k1_cat_0_ack;
  wire                s1_k1_cat_0_m_req;
  wire                s1_k1_cat_0_m_ack;
  wire                s1_k1_cat_0_to_k1_defunnel_req;
  wire                s1_k1_cat_0_to_k1_defunnel_ack;
  wire       [7:0]    cfg_s1_bs0_re;
  wire                cfg_s1_bs0_re_req;
  wire                cfg_s1_bs0_re_ack;
  wire                cfg_s1_bs0_re_m_req;
  wire                cfg_s1_bs0_re_m_ack;
  wire                cfg_s1_bs0_re_to_s1_bs0_re_req;
  wire                cfg_s1_bs0_re_to_s1_bs0_re_ack;
  wire       [7:0]    cfg_s1_bs0_im;
  wire                cfg_s1_bs0_im_req;
  wire                cfg_s1_bs0_im_ack;
  wire                cfg_s1_bs0_im_m_req;
  wire                cfg_s1_bs0_im_m_ack;
  wire                cfg_s1_bs0_im_to_s1_bs0_im_req;
  wire                cfg_s1_bs0_im_to_s1_bs0_im_ack;
  wire       [19:0]   s1_bs0_re_0;
  wire       [19:0]   s1_bs0_re_0_nxt;
  wire                s1_bs0_re_0_req;
  wire                s1_bs0_re_0_ack;
  wire                s1_bs0_re_0_m_req;
  wire                s1_bs0_re_0_m_ack;
  wire                s1_bs0_re_0_to_s1_rsat0_re_req;
  wire                s1_bs0_re_0_to_s1_rsat0_re_ack;
  wire       [19:0]   s1_bs0_im_0;
  wire       [19:0]   s1_bs0_im_0_nxt;
  wire                s1_bs0_im_0_req;
  wire                s1_bs0_im_0_ack;
  wire                s1_bs0_im_0_m_req;
  wire                s1_bs0_im_0_m_ack;
  wire                s1_bs0_im_0_to_s1_rsat0_im_req;
  wire                s1_bs0_im_0_to_s1_rsat0_im_ack;
  wire       [15:0]   s1_rsat0_re_0;
  wire       [15:0]   s1_rsat0_re_0_nxt;
  wire                s1_rsat0_re_0_req;
  wire                s1_rsat0_re_0_ack;
  wire                s1_rsat0_re_0_m_req;
  wire                s1_rsat0_re_0_m_ack;
  wire                s1_rsat0_re_0_to_s1_k1_cat_req;
  wire                s1_rsat0_re_0_to_s1_k1_cat_ack;
  wire       [15:0]   s1_rsat0_im_0;
  wire       [15:0]   s1_rsat0_im_0_nxt;
  wire                s1_rsat0_im_0_req;
  wire                s1_rsat0_im_0_ack;
  wire                s1_rsat0_im_0_m_req;
  wire                s1_rsat0_im_0_m_ack;
  wire                s1_rsat0_im_0_to_s1_k1_cat_req;
  wire                s1_rsat0_im_0_to_s1_k1_cat_ack;
  wire       [7:0]    cfg_s1_bs1_re;
  wire                cfg_s1_bs1_re_req;
  wire                cfg_s1_bs1_re_ack;
  wire                cfg_s1_bs1_re_m_req;
  wire                cfg_s1_bs1_re_m_ack;
  wire                cfg_s1_bs1_re_to_s1_bs1_re_req;
  wire                cfg_s1_bs1_re_to_s1_bs1_re_ack;
  wire       [7:0]    cfg_s1_bs1_im;
  wire                cfg_s1_bs1_im_req;
  wire                cfg_s1_bs1_im_ack;
  wire                cfg_s1_bs1_im_m_req;
  wire                cfg_s1_bs1_im_m_ack;
  wire                cfg_s1_bs1_im_to_s1_bs1_im_req;
  wire                cfg_s1_bs1_im_to_s1_bs1_im_ack;
  wire       [19:0]   s1_bs1_re_0;
  wire       [19:0]   s1_bs1_re_0_nxt;
  wire                s1_bs1_re_0_req;
  wire                s1_bs1_re_0_ack;
  wire                s1_bs1_re_0_m_req;
  wire                s1_bs1_re_0_m_ack;
  wire                s1_bs1_re_0_to_s1_rsat1_re_req;
  wire                s1_bs1_re_0_to_s1_rsat1_re_ack;
  wire       [19:0]   s1_bs1_im_0;
  wire       [19:0]   s1_bs1_im_0_nxt;
  wire                s1_bs1_im_0_req;
  wire                s1_bs1_im_0_ack;
  wire                s1_bs1_im_0_m_req;
  wire                s1_bs1_im_0_m_ack;
  wire                s1_bs1_im_0_to_s1_rsat1_im_req;
  wire                s1_bs1_im_0_to_s1_rsat1_im_ack;
  wire       [15:0]   s1_rsat1_re_0;
  wire       [15:0]   s1_rsat1_re_0_nxt;
  wire                s1_rsat1_re_0_req;
  wire                s1_rsat1_re_0_ack;
  wire                s1_rsat1_re_0_m_req;
  wire                s1_rsat1_re_0_m_ack;
  wire                s1_rsat1_re_0_to_s1_k1_cat_req;
  wire                s1_rsat1_re_0_to_s1_k1_cat_ack;
  wire       [15:0]   s1_rsat1_im_0;
  wire       [15:0]   s1_rsat1_im_0_nxt;
  wire                s1_rsat1_im_0_req;
  wire                s1_rsat1_im_0_ack;
  wire                s1_rsat1_im_0_m_req;
  wire                s1_rsat1_im_0_m_ack;
  wire                s1_rsat1_im_0_to_s1_k1_cat_req;
  wire                s1_rsat1_im_0_to_s1_k1_cat_ack;
  wire       [7:0]    cfg_s1_bs2_re;
  wire                cfg_s1_bs2_re_req;
  wire                cfg_s1_bs2_re_ack;
  wire                cfg_s1_bs2_re_m_req;
  wire                cfg_s1_bs2_re_m_ack;
  wire                cfg_s1_bs2_re_to_s1_bs2_re_req;
  wire                cfg_s1_bs2_re_to_s1_bs2_re_ack;
  wire       [7:0]    cfg_s1_bs2_im;
  wire                cfg_s1_bs2_im_req;
  wire                cfg_s1_bs2_im_ack;
  wire                cfg_s1_bs2_im_m_req;
  wire                cfg_s1_bs2_im_m_ack;
  wire                cfg_s1_bs2_im_to_s1_bs2_im_req;
  wire                cfg_s1_bs2_im_to_s1_bs2_im_ack;
  wire       [19:0]   s1_bs2_re_0;
  wire       [19:0]   s1_bs2_re_0_nxt;
  wire                s1_bs2_re_0_req;
  wire                s1_bs2_re_0_ack;
  wire                s1_bs2_re_0_m_req;
  wire                s1_bs2_re_0_m_ack;
  wire                s1_bs2_re_0_to_s1_rsat2_re_req;
  wire                s1_bs2_re_0_to_s1_rsat2_re_ack;
  wire       [19:0]   s1_bs2_im_0;
  wire       [19:0]   s1_bs2_im_0_nxt;
  wire                s1_bs2_im_0_req;
  wire                s1_bs2_im_0_ack;
  wire                s1_bs2_im_0_m_req;
  wire                s1_bs2_im_0_m_ack;
  wire                s1_bs2_im_0_to_s1_rsat2_im_req;
  wire                s1_bs2_im_0_to_s1_rsat2_im_ack;
  wire       [15:0]   s1_rsat2_re_0;
  wire       [15:0]   s1_rsat2_re_0_nxt;
  wire                s1_rsat2_re_0_req;
  wire                s1_rsat2_re_0_ack;
  wire                s1_rsat2_re_0_m_req;
  wire                s1_rsat2_re_0_m_ack;
  wire                s1_rsat2_re_0_to_s1_k1_cat_req;
  wire                s1_rsat2_re_0_to_s1_k1_cat_ack;
  wire       [15:0]   s1_rsat2_im_0;
  wire       [15:0]   s1_rsat2_im_0_nxt;
  wire                s1_rsat2_im_0_req;
  wire                s1_rsat2_im_0_ack;
  wire                s1_rsat2_im_0_m_req;
  wire                s1_rsat2_im_0_m_ack;
  wire                s1_rsat2_im_0_to_s1_k1_cat_req;
  wire                s1_rsat2_im_0_to_s1_k1_cat_ack;
  wire       [7:0]    cfg_s1_bs3_re;
  wire                cfg_s1_bs3_re_req;
  wire                cfg_s1_bs3_re_ack;
  wire                cfg_s1_bs3_re_m_req;
  wire                cfg_s1_bs3_re_m_ack;
  wire                cfg_s1_bs3_re_to_s1_bs3_re_req;
  wire                cfg_s1_bs3_re_to_s1_bs3_re_ack;
  wire       [7:0]    cfg_s1_bs3_im;
  wire                cfg_s1_bs3_im_req;
  wire                cfg_s1_bs3_im_ack;
  wire                cfg_s1_bs3_im_m_req;
  wire                cfg_s1_bs3_im_m_ack;
  wire                cfg_s1_bs3_im_to_s1_bs3_im_req;
  wire                cfg_s1_bs3_im_to_s1_bs3_im_ack;
  wire       [19:0]   s1_bs3_re_0;
  wire       [19:0]   s1_bs3_re_0_nxt;
  wire                s1_bs3_re_0_req;
  wire                s1_bs3_re_0_ack;
  wire                s1_bs3_re_0_m_req;
  wire                s1_bs3_re_0_m_ack;
  wire                s1_bs3_re_0_to_s1_rsat3_re_req;
  wire                s1_bs3_re_0_to_s1_rsat3_re_ack;
  wire       [19:0]   s1_bs3_im_0;
  wire       [19:0]   s1_bs3_im_0_nxt;
  wire                s1_bs3_im_0_req;
  wire                s1_bs3_im_0_ack;
  wire                s1_bs3_im_0_m_req;
  wire                s1_bs3_im_0_m_ack;
  wire                s1_bs3_im_0_to_s1_rsat3_im_req;
  wire                s1_bs3_im_0_to_s1_rsat3_im_ack;
  wire       [15:0]   s1_rsat3_re_0;
  wire       [15:0]   s1_rsat3_re_0_nxt;
  wire                s1_rsat3_re_0_req;
  wire                s1_rsat3_re_0_ack;
  wire                s1_rsat3_re_0_m_req;
  wire                s1_rsat3_re_0_m_ack;
  wire                s1_rsat3_re_0_to_s1_k1_cat_req;
  wire                s1_rsat3_re_0_to_s1_k1_cat_ack;
  wire       [15:0]   s1_rsat3_im_0;
  wire       [15:0]   s1_rsat3_im_0_nxt;
  wire                s1_rsat3_im_0_req;
  wire                s1_rsat3_im_0_ack;
  wire                s1_rsat3_im_0_m_req;
  wire                s1_rsat3_im_0_m_ack;
  wire                s1_rsat3_im_0_to_s1_k1_cat_req;
  wire                s1_rsat3_im_0_to_s1_k1_cat_ack;
  wire       [7:0]    cfg_k8_funnel;
  wire                cfg_k8_funnel_req;
  wire                cfg_k8_funnel_ack;
  wire                cfg_k8_funnel_m_req;
  wire                cfg_k8_funnel_m_ack;
  wire                cfg_k8_funnel_to_k8_funnel_req;
  wire                cfg_k8_funnel_to_k8_funnel_ack;
  wire       [7:0]    cfg_k9_funnel;
  wire                cfg_k9_funnel_req;
  wire                cfg_k9_funnel_ack;
  wire                cfg_k9_funnel_m_req;
  wire                cfg_k9_funnel_m_ack;
  wire                cfg_k9_funnel_to_k9_funnel_req;
  wire                cfg_k9_funnel_to_k9_funnel_ack;
  wire       [7:0]    cfg_k1_defunnel;
  wire                cfg_k1_defunnel_req;
  wire                cfg_k1_defunnel_ack;
  wire                cfg_k1_defunnel_m_req;
  wire                cfg_k1_defunnel_m_ack;
  wire                cfg_k1_defunnel_to_k1_defunnel_req;
  wire                cfg_k1_defunnel_to_k1_defunnel_ack;
  reg                 cfg_i_0_req_reg;
  wire                cfg_i_0_ack_g;
  reg                 cfg_i_1_req_reg;
  wire                cfg_i_1_ack_g;
  reg                 cfg_i_2_req_reg;
  wire                cfg_i_2_ack_g;
  reg                 cfg_i_3_req_reg;
  wire                cfg_i_3_ack_g;
  reg                 cfg_i_4_req_reg;
  wire                cfg_i_4_ack_g;
  reg                 cfg_i_5_req_reg;
  wire                cfg_i_5_ack_g;
  reg                 cfg_i_6_req_reg;
  wire                cfg_i_6_ack_g;
  reg                 cfg_i_7_req_reg;
  wire                cfg_i_7_ack_g;
  reg                 cfg_i_8_req_reg;
  wire                cfg_i_8_ack_g;
  reg                 cfg_i_9_req_reg;
  wire                cfg_i_9_ack_g;
  reg                 cfg_i_10_req_reg;
  wire                cfg_i_10_ack_g;
  reg                 cfg_i_11_req_reg;
  wire                cfg_i_11_ack_g;
  reg                 cfg_i_12_req_reg;
  wire                cfg_i_12_ack_g;
  reg                 cfg_i_13_req_reg;
  wire                cfg_i_13_ack_g;
  reg                 cfg_i_14_req_reg;
  wire                cfg_i_14_ack_g;
  reg                 cfg_i_15_req_reg;
  wire                cfg_i_15_ack_g;
  reg                 cfg_i_16_req_reg;
  wire                cfg_i_16_ack_g;
  reg                 cfg_i_17_req_reg;
  wire                cfg_i_17_ack_g;
  reg                 cfg_i_18_req_reg;
  wire                cfg_i_18_ack_g;
  reg                 cfg_i_19_req_reg;
  wire                cfg_i_19_ack_g;
  reg                 cfg_i_20_req_reg;
  wire                cfg_i_20_ack_g;
  reg                 cfg_i_21_req_reg;
  wire                cfg_i_21_ack_g;
  reg                 cfg_i_22_req_reg;
  wire                cfg_i_22_ack_g;
  reg                 cfg_i_23_req_reg;
  wire                cfg_i_23_ack_g;
  reg                 cfg_i_24_req_reg;
  wire                cfg_i_24_ack_g;
  reg                 cfg_i_25_req_reg;
  wire                cfg_i_25_ack_g;
  reg                 cfg_i_26_req_reg;
  wire                cfg_i_26_ack_g;
  reg                 cfg_i_27_req_reg;
  wire                cfg_i_27_ack_g;
  reg                 cfg_i_28_req_reg;
  wire                cfg_i_28_ack_g;
  reg                 cfg_i_29_req_reg;
  wire                cfg_i_29_ack_g;
  reg                 cfg_i_30_req_reg;
  wire                cfg_i_30_ack_g;
  reg                 cfg_i_31_req_reg;
  wire                cfg_i_31_ack_g;
  reg                 cfg_i_32_req_reg;
  wire                cfg_i_32_ack_g;
  reg                 cfg_i_33_req_reg;
  wire                cfg_i_33_ack_g;
  reg                 cfg_i_34_req_reg;
  wire                cfg_i_34_ack_g;
  reg                 cfg_i_35_req_reg;
  wire                cfg_i_35_ack_g;
  reg                 cfg_i_36_req_reg;
  wire                cfg_i_36_ack_g;
  reg                 cfg_i_37_req_reg;
  wire                cfg_i_37_ack_g;
  reg                 cfg_i_38_req_reg;
  wire                cfg_i_38_ack_g;
  reg                 cfg_i_39_req_reg;
  wire                cfg_i_39_ack_g;
  reg                 cfg_i_40_req_reg;
  wire                cfg_i_40_ack_g;
  reg                 cfg_i_41_req_reg;
  wire                cfg_i_41_ack_g;
  reg                 cfg_i_42_req_reg;
  wire                cfg_i_42_ack_g;
  reg                 cfg_i_43_req_reg;
  wire                cfg_i_43_ack_g;
  reg                 cfg_i_44_req_reg;
  wire                cfg_i_44_ack_g;
  reg                 cfg_i_45_req_reg;
  wire                cfg_i_45_ack_g;
  reg                 cfg_i_46_req_reg;
  wire                cfg_i_46_ack_g;
  reg                 cfg_i_47_req_reg;
  wire                cfg_i_47_ack_g;
  reg                 cfg_i_48_req_reg;
  wire                cfg_i_48_ack_g;
  reg                 cfg_i_49_req_reg;
  wire                cfg_i_49_ack_g;
  reg                 cfg_i_50_req_reg;
  wire                cfg_i_50_ack_g;
  reg                 cfg_i_51_req_reg;
  wire                cfg_i_51_ack_g;
  reg                 cfg_i_52_req_reg;
  wire                cfg_i_52_ack_g;
  reg                 cfg_i_53_req_reg;
  wire                cfg_i_53_ack_g;
  reg                 cfg_i_54_req_reg;
  wire                cfg_i_54_ack_g;
  reg                 cfg_i_55_req_reg;
  wire                cfg_i_55_ack_g;
  reg                 cfg_i_56_req_reg;
  wire                cfg_i_56_ack_g;
  reg                 cfg_i_57_req_reg;
  wire                cfg_i_57_ack_g;
  reg                 cfg_i_58_req_reg;
  wire                cfg_i_58_ack_g;
  reg                 cfg_i_59_req_reg;
  wire                cfg_i_59_ack_g;
  reg                 cfg_i_60_req_reg;
  wire                cfg_i_60_ack_g;
  reg                 cfg_i_61_req_reg;
  wire                cfg_i_61_ack_g;
  reg                 cfg_i_62_req_reg;
  wire                cfg_i_62_ack_g;
  reg                 cfg_i_63_req_reg;
  wire                cfg_i_63_ack_g;
  reg                 cfg_i_64_req_reg;
  wire                cfg_i_64_ack_g;
  reg                 cfg_i_65_req_reg;
  wire                cfg_i_65_ack_g;
  reg                 cfg_i_66_req_reg;
  wire                cfg_i_66_ack_g;
  reg                 cfg_i_67_req_reg;
  wire                cfg_i_67_ack_g;
  reg                 cfg_i_68_req_reg;
  wire                cfg_i_68_ack_g;
  reg                 cfg_i_69_req_reg;
  wire                cfg_i_69_ack_g;
  reg                 cfg_i_70_req_reg;
  wire                cfg_i_70_ack_g;
  reg                 cfg_i_71_req_reg;
  wire                cfg_i_71_ack_g;
  reg                 cfg_i_72_req_reg;
  wire                cfg_i_72_ack_g;
  reg                 cfg_i_73_req_reg;
  wire                cfg_i_73_ack_g;
  reg                 cfg_i_74_req_reg;
  wire                cfg_i_74_ack_g;
  reg                 cfg_i_75_req_reg;
  wire                cfg_i_75_ack_g;
  reg                 cfg_i_76_req_reg;
  wire                cfg_i_76_ack_g;
  reg                 cfg_i_77_req_reg;
  wire                cfg_i_77_ack_g;
  reg                 cfg_i_78_req_reg;
  wire                cfg_i_78_ack_g;
  reg                 cfg_i_79_req_reg;
  wire                cfg_i_79_ack_g;
  reg                 cfg_i_80_req_reg;
  wire                cfg_i_80_ack_g;
  reg                 cfg_i_81_req_reg;
  wire                cfg_i_81_ack_g;
  reg                 cfg_i_82_req_reg;
  wire                cfg_i_82_ack_g;
  reg                 cfg_i_83_req_reg;
  wire                cfg_i_83_ack_g;
  reg                 cfg_i_84_req_reg;
  wire                cfg_i_84_ack_g;
  reg                 cfg_i_85_req_reg;
  wire                cfg_i_85_ack_g;
  reg                 cfg_i_86_req_reg;
  wire                cfg_i_86_ack_g;
  reg                 cfg_i_87_req_reg;
  wire                cfg_i_87_ack_g;
  reg                 cfg_i_88_req_reg;
  wire                cfg_i_88_ack_g;
  reg                 cfg_i_89_req_reg;
  wire                cfg_i_89_ack_g;
  reg                 cfg_i_90_req_reg;
  wire                cfg_i_90_ack_g;
  reg                 cfg_i_91_req_reg;
  wire                cfg_i_91_ack_g;
  reg                 cfg_i_92_req_reg;
  wire                cfg_i_92_ack_g;
  reg                 cfg_i_93_req_reg;
  wire                cfg_i_93_ack_g;
  reg                 cfg_i_94_req_reg;
  wire                cfg_i_94_ack_g;
  reg                 cfg_i_95_req_reg;
  wire                cfg_i_95_ack_g;
  reg                 cfg_i_96_req_reg;
  wire                cfg_i_96_ack_g;
  reg                 cfg_i_97_req_reg;
  wire                cfg_i_97_ack_g;
  reg                 cfg_i_98_req_reg;
  wire                cfg_i_98_ack_g;
  reg                 s0_k8_slice_i_0_req_reg;
  wire                s0_k8_slice_i_0_ack_g;
  reg                 s0_k8_slice_i_1_req_reg;
  wire                s0_k8_slice_i_1_ack_g;
  reg                 s0_k8_slice_i_2_req_reg;
  wire                s0_k8_slice_i_2_ack_g;
  reg                 s0_k8_slice_i_3_req_reg;
  wire                s0_k8_slice_i_3_ack_g;
  reg                 s0_k8_slice_i_4_req_reg;
  wire                s0_k8_slice_i_4_ack_g;
  reg                 s0_k8_slice_i_5_req_reg;
  wire                s0_k8_slice_i_5_ack_g;
  reg                 s0_k8_slice_i_6_req_reg;
  wire                s0_k8_slice_i_6_ack_g;
  reg                 s0_k8_slice_i_7_req_reg;
  wire                s0_k8_slice_i_7_ack_g;
  reg                 s0_k9_slice_i_0_req_reg;
  wire                s0_k9_slice_i_0_ack_g;
  reg                 s0_k9_slice_i_1_req_reg;
  wire                s0_k9_slice_i_1_ack_g;
  reg                 s0_k9_slice_i_2_req_reg;
  wire                s0_k9_slice_i_2_ack_g;
  reg                 s0_k9_slice_i_3_req_reg;
  wire                s0_k9_slice_i_3_ack_g;
  reg                 s0_k9_slice_i_4_req_reg;
  wire                s0_k9_slice_i_4_ack_g;
  reg                 s0_k9_slice_i_5_req_reg;
  wire                s0_k9_slice_i_5_ack_g;
  reg                 s0_k9_slice_i_6_req_reg;
  wire                s0_k9_slice_i_6_ack_g;
  reg                 s0_k9_slice_i_7_req_reg;
  wire                s0_k9_slice_i_7_ack_g;
  wire       [15:0]   s0_cmul0_recip_norm_x;
  wire       [15:0]   s0_cmul0_recip_norm_mag;
  reg        [4:0]    s0_cmul0_recip_norm_lz;
  wire                s0_cmul0_recip_norm_sat;
  wire       [9:0]    s0_cmul0_recip_norm_xn;
  wire       [9:0]    _zz_s0_cmul0_recip_mul_y0;
  wire       [10:0]   s0_cmul0_recip_mul_y0;
  wire       [10:0]   s0_cmul0_recip_mul_t;
  wire       [10:0]   s0_cmul0_recip_mul_u;
  wire       [4:0]    _zz_s0_cmul0_recip_out_rn;
  wire       [13:0]   s0_cmul0_recip_out_r;
  reg        [17:0]   s0_cmul0_recip_out_rn;
  wire       [17:0]   s0_cmul0_recip_out_rmag;
  wire       [1:0]    s0_cmul0_m2c_ac_sel;
  reg        [17:0]   _zz_s0_cmul0_m2c_ac_0;
  reg                 _zz_s0_cmul0_m2c_ac_0_req;
  wire       [1:0]    s0_cmul0_m2c_bc_sel;
  reg        [17:0]   _zz_s0_cmul0_m2c_bc_0;
  reg                 _zz_s0_cmul0_m2c_bc_0_req;
  wire       [1:0]    s0_cmul0_m2c_bd_sel;
  reg        [17:0]   _zz_s0_cmul0_m2c_bd_0;
  reg                 _zz_s0_cmul0_m2c_bd_0_req;
  wire       [1:0]    s0_cmul0_m2c_cb_sel;
  reg        [17:0]   _zz_s0_cmul0_m2c_cb_0;
  reg                 _zz_s0_cmul0_m2c_cb_0_req;
  wire       [1:0]    s0_cmul0_m2c_cd_sel;
  reg        [17:0]   _zz_s0_cmul0_m2c_cd_0;
  reg                 _zz_s0_cmul0_m2c_cd_0_req;
  wire       [1:0]    s0_cmul0_m2c_da_sel;
  reg        [17:0]   _zz_s0_cmul0_m2c_da_0;
  reg                 _zz_s0_cmul0_m2c_da_0_req;
  reg        [3:0]    s0_cmul0_mas_re_cfg_valid;
  wire                s0_cmul0_mas_re_s1_ack;
  wire                s0_cmul0_mas_re_s2_ack;
  reg                 s0_cmul0_mas_re_s1_valid;
  wire                s0_cmul0_mas_re_s1_en;
  reg                 s0_cmul0_mas_re_s2_valid;
  wire                s0_cmul0_mas_re_s2_en;
  reg                 s0_cmul0_mas_re_s3_valid;
  wire                s0_cmul0_mas_re_s3_en;
  reg        [3:0]    s0_cmul0_mas_im_cfg_valid;
  wire                s0_cmul0_mas_im_s1_ack;
  wire                s0_cmul0_mas_im_s2_ack;
  reg                 s0_cmul0_mas_im_s1_valid;
  wire                s0_cmul0_mas_im_s1_en;
  reg                 s0_cmul0_mas_im_s2_valid;
  wire                s0_cmul0_mas_im_s2_en;
  reg                 s0_cmul0_mas_im_s3_valid;
  wire                s0_cmul0_mas_im_s3_en;
  wire       [15:0]   s0_cmul1_recip_norm_x;
  wire       [15:0]   s0_cmul1_recip_norm_mag;
  reg        [4:0]    s0_cmul1_recip_norm_lz;
  wire                s0_cmul1_recip_norm_sat;
  wire       [9:0]    s0_cmul1_recip_norm_xn;
  wire       [9:0]    _zz_s0_cmul1_recip_mul_y0;
  wire       [10:0]   s0_cmul1_recip_mul_y0;
  wire       [10:0]   s0_cmul1_recip_mul_t;
  wire       [10:0]   s0_cmul1_recip_mul_u;
  wire       [4:0]    _zz_s0_cmul1_recip_out_rn;
  wire       [13:0]   s0_cmul1_recip_out_r;
  reg        [17:0]   s0_cmul1_recip_out_rn;
  wire       [17:0]   s0_cmul1_recip_out_rmag;
  wire       [1:0]    s0_cmul1_m2c_ac_sel;
  reg        [17:0]   _zz_s0_cmul1_m2c_ac_0;
  reg                 _zz_s0_cmul1_m2c_ac_0_req;
  wire       [1:0]    s0_cmul1_m2c_bc_sel;
  reg        [17:0]   _zz_s0_cmul1_m2c_bc_0;
  reg                 _zz_s0_cmul1_m2c_bc_0_req;
  wire       [1:0]    s0_cmul1_m2c_bd_sel;
  reg        [17:0]   _zz_s0_cmul1_m2c_bd_0;
  reg                 _zz_s0_cmul1_m2c_bd_0_req;
  wire       [1:0]    s0_cmul1_m2c_cb_sel;
  reg        [17:0]   _zz_s0_cmul1_m2c_cb_0;
  reg                 _zz_s0_cmul1_m2c_cb_0_req;
  wire       [1:0]    s0_cmul1_m2c_cd_sel;
  reg        [17:0]   _zz_s0_cmul1_m2c_cd_0;
  reg                 _zz_s0_cmul1_m2c_cd_0_req;
  wire       [1:0]    s0_cmul1_m2c_da_sel;
  reg        [17:0]   _zz_s0_cmul1_m2c_da_0;
  reg                 _zz_s0_cmul1_m2c_da_0_req;
  reg        [3:0]    s0_cmul1_mas_re_cfg_valid;
  wire                s0_cmul1_mas_re_s1_ack;
  wire                s0_cmul1_mas_re_s2_ack;
  reg                 s0_cmul1_mas_re_s1_valid;
  wire                s0_cmul1_mas_re_s1_en;
  reg                 s0_cmul1_mas_re_s2_valid;
  wire                s0_cmul1_mas_re_s2_en;
  reg                 s0_cmul1_mas_re_s3_valid;
  wire                s0_cmul1_mas_re_s3_en;
  reg        [3:0]    s0_cmul1_mas_im_cfg_valid;
  wire                s0_cmul1_mas_im_s1_ack;
  wire                s0_cmul1_mas_im_s2_ack;
  reg                 s0_cmul1_mas_im_s1_valid;
  wire                s0_cmul1_mas_im_s1_en;
  reg                 s0_cmul1_mas_im_s2_valid;
  wire                s0_cmul1_mas_im_s2_en;
  reg                 s0_cmul1_mas_im_s3_valid;
  wire                s0_cmul1_mas_im_s3_en;
  wire       [15:0]   s0_cmul2_recip_norm_x;
  wire       [15:0]   s0_cmul2_recip_norm_mag;
  reg        [4:0]    s0_cmul2_recip_norm_lz;
  wire                s0_cmul2_recip_norm_sat;
  wire       [9:0]    s0_cmul2_recip_norm_xn;
  wire       [9:0]    _zz_s0_cmul2_recip_mul_y0;
  wire       [10:0]   s0_cmul2_recip_mul_y0;
  wire       [10:0]   s0_cmul2_recip_mul_t;
  wire       [10:0]   s0_cmul2_recip_mul_u;
  wire       [4:0]    _zz_s0_cmul2_recip_out_rn;
  wire       [13:0]   s0_cmul2_recip_out_r;
  reg        [17:0]   s0_cmul2_recip_out_rn;
  wire       [17:0]   s0_cmul2_recip_out_rmag;
  wire       [1:0]    s0_cmul2_m2c_ac_sel;
  reg        [17:0]   _zz_s0_cmul2_m2c_ac_0;
  reg                 _zz_s0_cmul2_m2c_ac_0_req;
  wire       [1:0]    s0_cmul2_m2c_bc_sel;
  reg        [17:0]   _zz_s0_cmul2_m2c_bc_0;
  reg                 _zz_s0_cmul2_m2c_bc_0_req;
  wire       [1:0]    s0_cmul2_m2c_bd_sel;
  reg        [17:0]   _zz_s0_cmul2_m2c_bd_0;
  reg                 _zz_s0_cmul2_m2c_bd_0_req;
  wire       [1:0]    s0_cmul2_m2c_cb_sel;
  reg        [17:0]   _zz_s0_cmul2_m2c_cb_0;
  reg                 _zz_s0_cmul2_m2c_cb_0_req;
  wire       [1:0]    s0_cmul2_m2c_cd_sel;
  reg        [17:0]   _zz_s0_cmul2_m2c_cd_0;
  reg                 _zz_s0_cmul2_m2c_cd_0_req;
  wire       [1:0]    s0_cmul2_m2c_da_sel;
  reg        [17:0]   _zz_s0_cmul2_m2c_da_0;
  reg                 _zz_s0_cmul2_m2c_da_0_req;
  reg        [3:0]    s0_cmul2_mas_re_cfg_valid;
  wire                s0_cmul2_mas_re_s1_ack;
  wire                s0_cmul2_mas_re_s2_ack;
  reg                 s0_cmul2_mas_re_s1_valid;
  wire                s0_cmul2_mas_re_s1_en;
  reg                 s0_cmul2_mas_re_s2_valid;
  wire                s0_cmul2_mas_re_s2_en;
  reg                 s0_cmul2_mas_re_s3_valid;
  wire                s0_cmul2_mas_re_s3_en;
  reg        [3:0]    s0_cmul2_mas_im_cfg_valid;
  wire                s0_cmul2_mas_im_s1_ack;
  wire                s0_cmul2_mas_im_s2_ack;
  reg                 s0_cmul2_mas_im_s1_valid;
  wire                s0_cmul2_mas_im_s1_en;
  reg                 s0_cmul2_mas_im_s2_valid;
  wire                s0_cmul2_mas_im_s2_en;
  reg                 s0_cmul2_mas_im_s3_valid;
  wire                s0_cmul2_mas_im_s3_en;
  wire       [15:0]   s0_cmul3_recip_norm_x;
  wire       [15:0]   s0_cmul3_recip_norm_mag;
  reg        [4:0]    s0_cmul3_recip_norm_lz;
  wire                s0_cmul3_recip_norm_sat;
  wire       [9:0]    s0_cmul3_recip_norm_xn;
  wire       [9:0]    _zz_s0_cmul3_recip_mul_y0;
  wire       [10:0]   s0_cmul3_recip_mul_y0;
  wire       [10:0]   s0_cmul3_recip_mul_t;
  wire       [10:0]   s0_cmul3_recip_mul_u;
  wire       [4:0]    _zz_s0_cmul3_recip_out_rn;
  wire       [13:0]   s0_cmul3_recip_out_r;
  reg        [17:0]   s0_cmul3_recip_out_rn;
  wire       [17:0]   s0_cmul3_recip_out_rmag;
  wire       [1:0]    s0_cmul3_m2c_ac_sel;
  reg        [17:0]   _zz_s0_cmul3_m2c_ac_0;
  reg                 _zz_s0_cmul3_m2c_ac_0_req;
  wire       [1:0]    s0_cmul3_m2c_bc_sel;
  reg        [17:0]   _zz_s0_cmul3_m2c_bc_0;
  reg                 _zz_s0_cmul3_m2c_bc_0_req;
  wire       [1:0]    s0_cmul3_m2c_bd_sel;
  reg        [17:0]   _zz_s0_cmul3_m2c_bd_0;
  reg                 _zz_s0_cmul3_m2c_bd_0_req;
  wire       [1:0]    s0_cmul3_m2c_cb_sel;
  reg        [17:0]   _zz_s0_cmul3_m2c_cb_0;
  reg                 _zz_s0_cmul3_m2c_cb_0_req;
  wire       [1:0]    s0_cmul3_m2c_cd_sel;
  reg        [17:0]   _zz_s0_cmul3_m2c_cd_0;
  reg                 _zz_s0_cmul3_m2c_cd_0_req;
  wire       [1:0]    s0_cmul3_m2c_da_sel;
  reg        [17:0]   _zz_s0_cmul3_m2c_da_0;
  reg                 _zz_s0_cmul3_m2c_da_0_req;
  reg        [3:0]    s0_cmul3_mas_re_cfg_valid;
  wire                s0_cmul3_mas_re_s1_ack;
  wire                s0_cmul3_mas_re_s2_ack;
  reg                 s0_cmul3_mas_re_s1_valid;
  wire                s0_cmul3_mas_re_s1_en;
  reg                 s0_cmul3_mas_re_s2_valid;
  wire                s0_cmul3_mas_re_s2_en;
  reg                 s0_cmul3_mas_re_s3_valid;
  wire                s0_cmul3_mas_re_s3_en;
  reg        [3:0]    s0_cmul3_mas_im_cfg_valid;
  wire                s0_cmul3_mas_im_s1_ack;
  wire                s0_cmul3_mas_im_s2_ack;
  reg                 s0_cmul3_mas_im_s1_valid;
  wire                s0_cmul3_mas_im_s1_en;
  reg                 s0_cmul3_mas_im_s2_valid;
  wire                s0_cmul3_mas_im_s2_en;
  reg                 s0_cmul3_mas_im_s3_valid;
  wire                s0_cmul3_mas_im_s3_en;
  reg                 s1_k8_slice_i_0_req_reg;
  wire                s1_k8_slice_i_0_ack_g;
  reg                 s1_k8_slice_i_1_req_reg;
  wire                s1_k8_slice_i_1_ack_g;
  reg                 s1_k8_slice_i_2_req_reg;
  wire                s1_k8_slice_i_2_ack_g;
  reg                 s1_k8_slice_i_3_req_reg;
  wire                s1_k8_slice_i_3_ack_g;
  reg                 s1_k8_slice_i_4_req_reg;
  wire                s1_k8_slice_i_4_ack_g;
  reg                 s1_k8_slice_i_5_req_reg;
  wire                s1_k8_slice_i_5_ack_g;
  reg                 s1_k8_slice_i_6_req_reg;
  wire                s1_k8_slice_i_6_ack_g;
  reg                 s1_k8_slice_i_7_req_reg;
  wire                s1_k8_slice_i_7_ack_g;
  reg                 s1_k9_slice_i_0_req_reg;
  wire                s1_k9_slice_i_0_ack_g;
  reg                 s1_k9_slice_i_1_req_reg;
  wire                s1_k9_slice_i_1_ack_g;
  reg                 s1_k9_slice_i_2_req_reg;
  wire                s1_k9_slice_i_2_ack_g;
  reg                 s1_k9_slice_i_3_req_reg;
  wire                s1_k9_slice_i_3_ack_g;
  reg                 s1_k9_slice_i_4_req_reg;
  wire                s1_k9_slice_i_4_ack_g;
  reg                 s1_k9_slice_i_5_req_reg;
  wire                s1_k9_slice_i_5_ack_g;
  reg                 s1_k9_slice_i_6_req_reg;
  wire                s1_k9_slice_i_6_ack_g;
  reg                 s1_k9_slice_i_7_req_reg;
  wire                s1_k9_slice_i_7_ack_g;
  wire       [15:0]   s1_cmul0_recip_norm_x;
  wire       [15:0]   s1_cmul0_recip_norm_mag;
  reg        [4:0]    s1_cmul0_recip_norm_lz;
  wire                s1_cmul0_recip_norm_sat;
  wire       [9:0]    s1_cmul0_recip_norm_xn;
  wire       [9:0]    _zz_s1_cmul0_recip_mul_y0;
  wire       [10:0]   s1_cmul0_recip_mul_y0;
  wire       [10:0]   s1_cmul0_recip_mul_t;
  wire       [10:0]   s1_cmul0_recip_mul_u;
  wire       [4:0]    _zz_s1_cmul0_recip_out_rn;
  wire       [13:0]   s1_cmul0_recip_out_r;
  reg        [17:0]   s1_cmul0_recip_out_rn;
  wire       [17:0]   s1_cmul0_recip_out_rmag;
  wire       [1:0]    s1_cmul0_m2c_ac_sel;
  reg        [17:0]   _zz_s1_cmul0_m2c_ac_0;
  reg                 _zz_s1_cmul0_m2c_ac_0_req;
  wire       [1:0]    s1_cmul0_m2c_bc_sel;
  reg        [17:0]   _zz_s1_cmul0_m2c_bc_0;
  reg                 _zz_s1_cmul0_m2c_bc_0_req;
  wire       [1:0]    s1_cmul0_m2c_bd_sel;
  reg        [17:0]   _zz_s1_cmul0_m2c_bd_0;
  reg                 _zz_s1_cmul0_m2c_bd_0_req;
  wire       [1:0]    s1_cmul0_m2c_cb_sel;
  reg        [17:0]   _zz_s1_cmul0_m2c_cb_0;
  reg                 _zz_s1_cmul0_m2c_cb_0_req;
  wire       [1:0]    s1_cmul0_m2c_cd_sel;
  reg        [17:0]   _zz_s1_cmul0_m2c_cd_0;
  reg                 _zz_s1_cmul0_m2c_cd_0_req;
  wire       [1:0]    s1_cmul0_m2c_da_sel;
  reg        [17:0]   _zz_s1_cmul0_m2c_da_0;
  reg                 _zz_s1_cmul0_m2c_da_0_req;
  reg        [3:0]    s1_cmul0_mas_re_cfg_valid;
  wire                s1_cmul0_mas_re_s1_ack;
  wire                s1_cmul0_mas_re_s2_ack;
  reg                 s1_cmul0_mas_re_s1_valid;
  wire                s1_cmul0_mas_re_s1_en;
  reg                 s1_cmul0_mas_re_s2_valid;
  wire                s1_cmul0_mas_re_s2_en;
  reg                 s1_cmul0_mas_re_s3_valid;
  wire                s1_cmul0_mas_re_s3_en;
  reg        [3:0]    s1_cmul0_mas_im_cfg_valid;
  wire                s1_cmul0_mas_im_s1_ack;
  wire                s1_cmul0_mas_im_s2_ack;
  reg                 s1_cmul0_mas_im_s1_valid;
  wire                s1_cmul0_mas_im_s1_en;
  reg                 s1_cmul0_mas_im_s2_valid;
  wire                s1_cmul0_mas_im_s2_en;
  reg                 s1_cmul0_mas_im_s3_valid;
  wire                s1_cmul0_mas_im_s3_en;
  wire       [15:0]   s1_cmul1_recip_norm_x;
  wire       [15:0]   s1_cmul1_recip_norm_mag;
  reg        [4:0]    s1_cmul1_recip_norm_lz;
  wire                s1_cmul1_recip_norm_sat;
  wire       [9:0]    s1_cmul1_recip_norm_xn;
  wire       [9:0]    _zz_s1_cmul1_recip_mul_y0;
  wire       [10:0]   s1_cmul1_recip_mul_y0;
  wire       [10:0]   s1_cmul1_recip_mul_t;
  wire       [10:0]   s1_cmul1_recip_mul_u;
  wire       [4:0]    _zz_s1_cmul1_recip_out_rn;
  wire       [13:0]   s1_cmul1_recip_out_r;
  reg        [17:0]   s1_cmul1_recip_out_rn;
  wire       [17:0]   s1_cmul1_recip_out_rmag;
  wire       [1:0]    s1_cmul1_m2c_ac_sel;
  reg        [17:0]   _zz_s1_cmul1_m2c_ac_0;
  reg                 _zz_s1_cmul1_m2c_ac_0_req;
  wire       [1:0]    s1_cmul1_m2c_bc_sel;
  reg        [17:0]   _zz_s1_cmul1_m2c_bc_0;
  reg                 _zz_s1_cmul1_m2c_bc_0_req;
  wire       [1:0]    s1_cmul1_m2c_bd_sel;
  reg        [17:0]   _zz_s1_cmul1_m2c_bd_0;
  reg                 _zz_s1_cmul1_m2c_bd_0_req;
  wire       [1:0]    s1_cmul1_m2c_cb_sel;
  reg        [17:0]   _zz_s1_cmul1_m2c_cb_0;
  reg                 _zz_s1_cmul1_m2c_cb_0_req;
  wire       [1:0]    s1_cmul1_m2c_cd_sel;
  reg        [17:0]   _zz_s1_cmul1_m2c_cd_0;
  reg                 _zz_s1_cmul1_m2c_cd_0_req;
  wire       [1:0]    s1_cmul1_m2c_da_sel;
  reg        [17:0]   _zz_s1_cmul1_m2c_da_0;
  reg                 _zz_s1_cmul1_m2c_da_0_req;
  reg        [3:0]    s1_cmul1_mas_re_cfg_valid;
  wire                s1_cmul1_mas_re_s1_ack;
  wire                s1_cmul1_mas_re_s2_ack;
  reg                 s1_cmul1_mas_re_s1_valid;
  wire                s1_cmul1_mas_re_s1_en;
  reg                 s1_cmul1_mas_re_s2_valid;
  wire                s1_cmul1_mas_re_s2_en;
  reg                 s1_cmul1_mas_re_s3_valid;
  wire                s1_cmul1_mas_re_s3_en;
  reg        [3:0]    s1_cmul1_mas_im_cfg_valid;
  wire                s1_cmul1_mas_im_s1_ack;
  wire                s1_cmul1_mas_im_s2_ack;
  reg                 s1_cmul1_mas_im_s1_valid;
  wire                s1_cmul1_mas_im_s1_en;
  reg                 s1_cmul1_mas_im_s2_valid;
  wire                s1_cmul1_mas_im_s2_en;
  reg                 s1_cmul1_mas_im_s3_valid;
  wire                s1_cmul1_mas_im_s3_en;
  wire       [15:0]   s1_cmul2_recip_norm_x;
  wire       [15:0]   s1_cmul2_recip_norm_mag;
  reg        [4:0]    s1_cmul2_recip_norm_lz;
  wire                s1_cmul2_recip_norm_sat;
  wire       [9:0]    s1_cmul2_recip_norm_xn;
  wire       [9:0]    _zz_s1_cmul2_recip_mul_y0;
  wire       [10:0]   s1_cmul2_recip_mul_y0;
  wire       [10:0]   s1_cmul2_recip_mul_t;
  wire       [10:0]   s1_cmul2_recip_mul_u;
  wire       [4:0]    _zz_s1_cmul2_recip_out_rn;
  wire       [13:0]   s1_cmul2_recip_out_r;
  reg        [17:0]   s1_cmul2_recip_out_rn;
  wire       [17:0]   s1_cmul2_recip_out_rmag;
  wire       [1:0]    s1_cmul2_m2c_ac_sel;
  reg        [17:0]   _zz_s1_cmul2_m2c_ac_0;
  reg                 _zz_s1_cmul2_m2c_ac_0_req;
  wire       [1:0]    s1_cmul2_m2c_bc_sel;
  reg        [17:0]   _zz_s1_cmul2_m2c_bc_0;
  reg                 _zz_s1_cmul2_m2c_bc_0_req;
  wire       [1:0]    s1_cmul2_m2c_bd_sel;
  reg        [17:0]   _zz_s1_cmul2_m2c_bd_0;
  reg                 _zz_s1_cmul2_m2c_bd_0_req;
  wire       [1:0]    s1_cmul2_m2c_cb_sel;
  reg        [17:0]   _zz_s1_cmul2_m2c_cb_0;
  reg                 _zz_s1_cmul2_m2c_cb_0_req;
  wire       [1:0]    s1_cmul2_m2c_cd_sel;
  reg        [17:0]   _zz_s1_cmul2_m2c_cd_0;
  reg                 _zz_s1_cmul2_m2c_cd_0_req;
  wire       [1:0]    s1_cmul2_m2c_da_sel;
  reg        [17:0]   _zz_s1_cmul2_m2c_da_0;
  reg                 _zz_s1_cmul2_m2c_da_0_req;
  reg        [3:0]    s1_cmul2_mas_re_cfg_valid;
  wire                s1_cmul2_mas_re_s1_ack;
  wire                s1_cmul2_mas_re_s2_ack;
  reg                 s1_cmul2_mas_re_s1_valid;
  wire                s1_cmul2_mas_re_s1_en;
  reg                 s1_cmul2_mas_re_s2_valid;
  wire                s1_cmul2_mas_re_s2_en;
  reg                 s1_cmul2_mas_re_s3_valid;
  wire                s1_cmul2_mas_re_s3_en;
  reg        [3:0]    s1_cmul2_mas_im_cfg_valid;
  wire                s1_cmul2_mas_im_s1_ack;
  wire                s1_cmul2_mas_im_s2_ack;
  reg                 s1_cmul2_mas_im_s1_valid;
  wire                s1_cmul2_mas_im_s1_en;
  reg                 s1_cmul2_mas_im_s2_valid;
  wire                s1_cmul2_mas_im_s2_en;
  reg                 s1_cmul2_mas_im_s3_valid;
  wire                s1_cmul2_mas_im_s3_en;
  wire       [15:0]   s1_cmul3_recip_norm_x;
  wire       [15:0]   s1_cmul3_recip_norm_mag;
  reg        [4:0]    s1_cmul3_recip_norm_lz;
  wire                s1_cmul3_recip_norm_sat;
  wire       [9:0]    s1_cmul3_recip_norm_xn;
  wire       [9:0]    _zz_s1_cmul3_recip_mul_y0;
  wire       [10:0]   s1_cmul3_recip_mul_y0;
  wire       [10:0]   s1_cmul3_recip_mul_t;
  wire       [10:0]   s1_cmul3_recip_mul_u;
  wire       [4:0]    _zz_s1_cmul3_recip_out_rn;
  wire       [13:0]   s1_cmul3_recip_out_r;
  reg        [17:0]   s1_cmul3_recip_out_rn;
  wire       [17:0]   s1_cmul3_recip_out_rmag;
  wire       [1:0]    s1_cmul3_m2c_ac_sel;
  reg        [17:0]   _zz_s1_cmul3_m2c_ac_0;
  reg                 _zz_s1_cmul3_m2c_ac_0_req;
  wire       [1:0]    s1_cmul3_m2c_bc_sel;
  reg        [17:0]   _zz_s1_cmul3_m2c_bc_0;
  reg                 _zz_s1_cmul3_m2c_bc_0_req;
  wire       [1:0]    s1_cmul3_m2c_bd_sel;
  reg        [17:0]   _zz_s1_cmul3_m2c_bd_0;
  reg                 _zz_s1_cmul3_m2c_bd_0_req;
  wire       [1:0]    s1_cmul3_m2c_cb_sel;
  reg        [17:0]   _zz_s1_cmul3_m2c_cb_0;
  reg                 _zz_s1_cmul3_m2c_cb_0_req;
  wire       [1:0]    s1_cmul3_m2c_cd_sel;
  reg        [17:0]   _zz_s1_cmul3_m2c_cd_0;
  reg                 _zz_s1_cmul3_m2c_cd_0_req;
  wire       [1:0]    s1_cmul3_m2c_da_sel;
  reg        [17:0]   _zz_s1_cmul3_m2c_da_0;
  reg                 _zz_s1_cmul3_m2c_da_0_req;
  reg        [3:0]    s1_cmul3_mas_re_cfg_valid;
  wire                s1_cmul3_mas_re_s1_ack;
  wire                s1_cmul3_mas_re_s2_ack;
  reg                 s1_cmul3_mas_re_s1_valid;
  wire                s1_cmul3_mas_re_s1_en;
  reg                 s1_cmul3_mas_re_s2_valid;
  wire                s1_cmul3_mas_re_s2_en;
  reg                 s1_cmul3_mas_re_s3_valid;
  wire                s1_cmul3_mas_re_s3_en;
  reg        [3:0]    s1_cmul3_mas_im_cfg_valid;
  wire                s1_cmul3_mas_im_s1_ack;
  wire                s1_cmul3_mas_im_s2_ack;
  reg                 s1_cmul3_mas_im_s1_valid;
  wire                s1_cmul3_mas_im_s1_en;
  reg                 s1_cmul3_mas_im_s2_valid;
  wire                s1_cmul3_mas_im_s2_en;
  reg                 s1_cmul3_mas_im_s3_valid;
  wire                s1_cmul3_mas_im_s3_en;
  wire       [1:0]    s0_r4_byp0_re_sel;
  reg        [35:0]   _zz_s0_r4_byp0_re_0_nxt;
  reg                 _zz_s0_r4_byp0_re_0_req;
  wire       [1:0]    s0_r4_byp0_im_sel;
  reg        [35:0]   _zz_s0_r4_byp0_im_0_nxt;
  reg                 _zz_s0_r4_byp0_im_0_req;
  wire       [1:0]    s0_r4_byp1_re_sel;
  reg        [35:0]   _zz_s0_r4_byp1_re_0_nxt;
  reg                 _zz_s0_r4_byp1_re_0_req;
  wire       [1:0]    s0_r4_byp1_im_sel;
  reg        [35:0]   _zz_s0_r4_byp1_im_0_nxt;
  reg                 _zz_s0_r4_byp1_im_0_req;
  wire       [1:0]    s0_r4_byp2_re_sel;
  reg        [35:0]   _zz_s0_r4_byp2_re_0_nxt;
  reg                 _zz_s0_r4_byp2_re_0_req;
  wire       [1:0]    s0_r4_byp2_im_sel;
  reg        [35:0]   _zz_s0_r4_byp2_im_0_nxt;
  reg                 _zz_s0_r4_byp2_im_0_req;
  wire       [1:0]    s0_r4_byp3_re_sel;
  reg        [35:0]   _zz_s0_r4_byp3_re_0_nxt;
  reg                 _zz_s0_r4_byp3_re_0_req;
  wire       [1:0]    s0_r4_byp3_im_sel;
  reg        [35:0]   _zz_s0_r4_byp3_im_0_nxt;
  reg                 _zz_s0_r4_byp3_im_0_req;
  wire       [1:0]    s1_r4_byp0_re_sel;
  reg        [35:0]   _zz_s1_r4_byp0_re_0_nxt;
  reg                 _zz_s1_r4_byp0_re_0_req;
  wire       [1:0]    s1_r4_byp0_im_sel;
  reg        [35:0]   _zz_s1_r4_byp0_im_0_nxt;
  reg                 _zz_s1_r4_byp0_im_0_req;
  wire       [1:0]    s1_r4_byp1_re_sel;
  reg        [35:0]   _zz_s1_r4_byp1_re_0_nxt;
  reg                 _zz_s1_r4_byp1_re_0_req;
  wire       [1:0]    s1_r4_byp1_im_sel;
  reg        [35:0]   _zz_s1_r4_byp1_im_0_nxt;
  reg                 _zz_s1_r4_byp1_im_0_req;
  wire       [1:0]    s1_r4_byp2_re_sel;
  reg        [35:0]   _zz_s1_r4_byp2_re_0_nxt;
  reg                 _zz_s1_r4_byp2_re_0_req;
  wire       [1:0]    s1_r4_byp2_im_sel;
  reg        [35:0]   _zz_s1_r4_byp2_im_0_nxt;
  reg                 _zz_s1_r4_byp2_im_0_req;
  wire       [1:0]    s1_r4_byp3_re_sel;
  reg        [35:0]   _zz_s1_r4_byp3_re_0_nxt;
  reg                 _zz_s1_r4_byp3_re_0_req;
  wire       [1:0]    s1_r4_byp3_im_sel;
  reg        [35:0]   _zz_s1_r4_byp3_im_0_nxt;
  reg                 _zz_s1_r4_byp3_im_0_req;
  reg        [4:0]    k1_defunnel_0_eb_state;
  reg        [4:0]    k1_defunnel_0_eb_state_nxt;
  wire                k1_defunnel_0_eb_en0;
  wire                k1_defunnel_0_eb_en1;
  wire                k1_defunnel_0_eb_sel;
  reg        [511:0]  k1_defunnel_0_eb_r0;
  reg        [511:0]  k1_defunnel_0_eb_r1;
  reg                 k8_funnel_0_eb_valid;
  wire                k8_funnel_0_eb_en;
  reg        [127:0]  k8_funnel_0_eb_r;
  reg                 k9_funnel_0_eb_valid;
  wire                k9_funnel_0_eb_en;
  reg        [127:0]  k9_funnel_0_eb_r;
  reg                 s0_k8_slice_0_fork_ack_r_0;
  wire                s0_k8_slice_0_fork_ack_s_0;
  reg                 s0_k8_slice_0_fork_ack_r_1;
  wire                s0_k8_slice_0_fork_ack_s_1;
  reg                 s0_k8_slice_0_fork_ack_r_2;
  wire                s0_k8_slice_0_fork_ack_s_2;
  reg                 s0_k8_slice_1_fork_ack_r_0;
  wire                s0_k8_slice_1_fork_ack_s_0;
  reg                 s0_k8_slice_1_fork_ack_r_1;
  wire                s0_k8_slice_1_fork_ack_s_1;
  reg                 s0_k8_slice_1_fork_ack_r_2;
  wire                s0_k8_slice_1_fork_ack_s_2;
  reg                 s0_k9_slice_0_fork_ack_r_0;
  wire                s0_k9_slice_0_fork_ack_s_0;
  reg                 s0_k9_slice_0_fork_ack_r_1;
  wire                s0_k9_slice_0_fork_ack_s_1;
  reg                 s0_k9_slice_0_fork_ack_r_2;
  wire                s0_k9_slice_0_fork_ack_s_2;
  reg                 s0_k9_slice_0_fork_ack_r_3;
  wire                s0_k9_slice_0_fork_ack_s_3;
  reg                 s0_k9_slice_0_fork_ack_r_4;
  wire                s0_k9_slice_0_fork_ack_s_4;
  reg                 s0_k9_slice_1_fork_ack_r_0;
  wire                s0_k9_slice_1_fork_ack_s_0;
  reg                 s0_k9_slice_1_fork_ack_r_1;
  wire                s0_k9_slice_1_fork_ack_s_1;
  reg                 s0_k9_slice_1_fork_ack_r_2;
  wire                s0_k9_slice_1_fork_ack_s_2;
  reg                 s0_k9_slice_1_fork_ack_r_3;
  wire                s0_k9_slice_1_fork_ack_s_3;
  reg                 s0_k8_slice_2_fork_ack_r_0;
  wire                s0_k8_slice_2_fork_ack_s_0;
  reg                 s0_k8_slice_2_fork_ack_r_1;
  wire                s0_k8_slice_2_fork_ack_s_1;
  reg                 s0_k8_slice_2_fork_ack_r_2;
  wire                s0_k8_slice_2_fork_ack_s_2;
  reg                 s0_k8_slice_3_fork_ack_r_0;
  wire                s0_k8_slice_3_fork_ack_s_0;
  reg                 s0_k8_slice_3_fork_ack_r_1;
  wire                s0_k8_slice_3_fork_ack_s_1;
  reg                 s0_k8_slice_3_fork_ack_r_2;
  wire                s0_k8_slice_3_fork_ack_s_2;
  reg                 s0_k9_slice_2_fork_ack_r_0;
  wire                s0_k9_slice_2_fork_ack_s_0;
  reg                 s0_k9_slice_2_fork_ack_r_1;
  wire                s0_k9_slice_2_fork_ack_s_1;
  reg                 s0_k9_slice_2_fork_ack_r_2;
  wire                s0_k9_slice_2_fork_ack_s_2;
  reg                 s0_k9_slice_2_fork_ack_r_3;
  wire                s0_k9_slice_2_fork_ack_s_3;
  reg                 s0_k9_slice_2_fork_ack_r_4;
  wire                s0_k9_slice_2_fork_ack_s_4;
  reg                 s0_k9_slice_3_fork_ack_r_0;
  wire                s0_k9_slice_3_fork_ack_s_0;
  reg                 s0_k9_slice_3_fork_ack_r_1;
  wire                s0_k9_slice_3_fork_ack_s_1;
  reg                 s0_k9_slice_3_fork_ack_r_2;
  wire                s0_k9_slice_3_fork_ack_s_2;
  reg                 s0_k9_slice_3_fork_ack_r_3;
  wire                s0_k9_slice_3_fork_ack_s_3;
  reg                 s0_k8_slice_4_fork_ack_r_0;
  wire                s0_k8_slice_4_fork_ack_s_0;
  reg                 s0_k8_slice_4_fork_ack_r_1;
  wire                s0_k8_slice_4_fork_ack_s_1;
  reg                 s0_k8_slice_4_fork_ack_r_2;
  wire                s0_k8_slice_4_fork_ack_s_2;
  reg                 s0_k8_slice_5_fork_ack_r_0;
  wire                s0_k8_slice_5_fork_ack_s_0;
  reg                 s0_k8_slice_5_fork_ack_r_1;
  wire                s0_k8_slice_5_fork_ack_s_1;
  reg                 s0_k8_slice_5_fork_ack_r_2;
  wire                s0_k8_slice_5_fork_ack_s_2;
  reg                 s0_k9_slice_4_fork_ack_r_0;
  wire                s0_k9_slice_4_fork_ack_s_0;
  reg                 s0_k9_slice_4_fork_ack_r_1;
  wire                s0_k9_slice_4_fork_ack_s_1;
  reg                 s0_k9_slice_4_fork_ack_r_2;
  wire                s0_k9_slice_4_fork_ack_s_2;
  reg                 s0_k9_slice_4_fork_ack_r_3;
  wire                s0_k9_slice_4_fork_ack_s_3;
  reg                 s0_k9_slice_4_fork_ack_r_4;
  wire                s0_k9_slice_4_fork_ack_s_4;
  reg                 s0_k9_slice_5_fork_ack_r_0;
  wire                s0_k9_slice_5_fork_ack_s_0;
  reg                 s0_k9_slice_5_fork_ack_r_1;
  wire                s0_k9_slice_5_fork_ack_s_1;
  reg                 s0_k9_slice_5_fork_ack_r_2;
  wire                s0_k9_slice_5_fork_ack_s_2;
  reg                 s0_k9_slice_5_fork_ack_r_3;
  wire                s0_k9_slice_5_fork_ack_s_3;
  reg                 s0_k8_slice_6_fork_ack_r_0;
  wire                s0_k8_slice_6_fork_ack_s_0;
  reg                 s0_k8_slice_6_fork_ack_r_1;
  wire                s0_k8_slice_6_fork_ack_s_1;
  reg                 s0_k8_slice_6_fork_ack_r_2;
  wire                s0_k8_slice_6_fork_ack_s_2;
  reg                 s0_k8_slice_7_fork_ack_r_0;
  wire                s0_k8_slice_7_fork_ack_s_0;
  reg                 s0_k8_slice_7_fork_ack_r_1;
  wire                s0_k8_slice_7_fork_ack_s_1;
  reg                 s0_k8_slice_7_fork_ack_r_2;
  wire                s0_k8_slice_7_fork_ack_s_2;
  reg                 s0_k9_slice_6_fork_ack_r_0;
  wire                s0_k9_slice_6_fork_ack_s_0;
  reg                 s0_k9_slice_6_fork_ack_r_1;
  wire                s0_k9_slice_6_fork_ack_s_1;
  reg                 s0_k9_slice_6_fork_ack_r_2;
  wire                s0_k9_slice_6_fork_ack_s_2;
  reg                 s0_k9_slice_6_fork_ack_r_3;
  wire                s0_k9_slice_6_fork_ack_s_3;
  reg                 s0_k9_slice_6_fork_ack_r_4;
  wire                s0_k9_slice_6_fork_ack_s_4;
  reg                 s0_k9_slice_7_fork_ack_r_0;
  wire                s0_k9_slice_7_fork_ack_s_0;
  reg                 s0_k9_slice_7_fork_ack_r_1;
  wire                s0_k9_slice_7_fork_ack_s_1;
  reg                 s0_k9_slice_7_fork_ack_r_2;
  wire                s0_k9_slice_7_fork_ack_s_2;
  reg                 s0_k9_slice_7_fork_ack_r_3;
  wire                s0_k9_slice_7_fork_ack_s_3;
  reg                 s0_cmul0_recip_norm_0_eb_valid;
  wire                s0_cmul0_recip_norm_0_eb_en;
  reg        [16:0]   s0_cmul0_recip_norm_0_eb_r;
  reg                 s0_cmul0_recip_mul_0_eb_valid;
  wire                s0_cmul0_recip_mul_0_eb_en;
  reg        [28:0]   s0_cmul0_recip_mul_0_eb_r;
  reg                 s0_cmul0_recip_out_0_eb_valid;
  wire                s0_cmul0_recip_out_0_eb_en;
  reg        [17:0]   s0_cmul0_recip_out_0_eb_r;
  reg                 s0_cmul0_recip_out_0_fork_ack_r_0;
  wire                s0_cmul0_recip_out_0_fork_ack_s_0;
  reg                 s0_cmul0_recip_out_0_fork_ack_r_1;
  wire                s0_cmul0_recip_out_0_fork_ack_s_1;
  reg        [4:0]    s0_cmul0_cat_re_0_eb_state;
  reg        [4:0]    s0_cmul0_cat_re_0_eb_state_nxt;
  wire                s0_cmul0_cat_re_0_eb_en0;
  wire                s0_cmul0_cat_re_0_eb_en1;
  wire                s0_cmul0_cat_re_0_eb_sel;
  reg        [71:0]   s0_cmul0_cat_re_0_eb_r0;
  reg        [71:0]   s0_cmul0_cat_re_0_eb_r1;
  reg        [4:0]    s0_cmul0_cat_im_0_eb_state;
  reg        [4:0]    s0_cmul0_cat_im_0_eb_state_nxt;
  wire                s0_cmul0_cat_im_0_eb_en0;
  wire                s0_cmul0_cat_im_0_eb_en1;
  wire                s0_cmul0_cat_im_0_eb_sel;
  reg        [71:0]   s0_cmul0_cat_im_0_eb_r0;
  reg        [71:0]   s0_cmul0_cat_im_0_eb_r1;
  reg                 s0_cmul0_mas_re_0_fork_ack_r_0;
  wire                s0_cmul0_mas_re_0_fork_ack_s_0;
  reg                 s0_cmul0_mas_re_0_fork_ack_r_1;
  wire                s0_cmul0_mas_re_0_fork_ack_s_1;
  reg                 s0_cmul0_mas_re_0_fork_ack_r_2;
  wire                s0_cmul0_mas_re_0_fork_ack_s_2;
  reg                 s0_cmul0_mas_im_0_fork_ack_r_0;
  wire                s0_cmul0_mas_im_0_fork_ack_s_0;
  reg                 s0_cmul0_mas_im_0_fork_ack_r_1;
  wire                s0_cmul0_mas_im_0_fork_ack_s_1;
  reg                 s0_cmul0_mas_im_0_fork_ack_r_2;
  wire                s0_cmul0_mas_im_0_fork_ack_s_2;
  reg                 s0_cmul1_recip_norm_0_eb_valid;
  wire                s0_cmul1_recip_norm_0_eb_en;
  reg        [16:0]   s0_cmul1_recip_norm_0_eb_r;
  reg                 s0_cmul1_recip_mul_0_eb_valid;
  wire                s0_cmul1_recip_mul_0_eb_en;
  reg        [28:0]   s0_cmul1_recip_mul_0_eb_r;
  reg                 s0_cmul1_recip_out_0_eb_valid;
  wire                s0_cmul1_recip_out_0_eb_en;
  reg        [17:0]   s0_cmul1_recip_out_0_eb_r;
  reg                 s0_cmul1_recip_out_0_fork_ack_r_0;
  wire                s0_cmul1_recip_out_0_fork_ack_s_0;
  reg                 s0_cmul1_recip_out_0_fork_ack_r_1;
  wire                s0_cmul1_recip_out_0_fork_ack_s_1;
  reg        [4:0]    s0_cmul1_cat_re_0_eb_state;
  reg        [4:0]    s0_cmul1_cat_re_0_eb_state_nxt;
  wire                s0_cmul1_cat_re_0_eb_en0;
  wire                s0_cmul1_cat_re_0_eb_en1;
  wire                s0_cmul1_cat_re_0_eb_sel;
  reg        [71:0]   s0_cmul1_cat_re_0_eb_r0;
  reg        [71:0]   s0_cmul1_cat_re_0_eb_r1;
  reg        [4:0]    s0_cmul1_cat_im_0_eb_state;
  reg        [4:0]    s0_cmul1_cat_im_0_eb_state_nxt;
  wire                s0_cmul1_cat_im_0_eb_en0;
  wire                s0_cmul1_cat_im_0_eb_en1;
  wire                s0_cmul1_cat_im_0_eb_sel;
  reg        [71:0]   s0_cmul1_cat_im_0_eb_r0;
  reg        [71:0]   s0_cmul1_cat_im_0_eb_r1;
  reg                 s0_cmul1_mas_re_0_fork_ack_r_0;
  wire                s0_cmul1_mas_re_0_fork_ack_s_0;
  reg                 s0_cmul1_mas_re_0_fork_ack_r_1;
  wire                s0_cmul1_mas_re_0_fork_ack_s_1;
  reg                 s0_cmul1_mas_re_0_fork_ack_r_2;
  wire                s0_cmul1_mas_re_0_fork_ack_s_2;
  reg                 s0_cmul1_mas_im_0_fork_ack_r_0;
  wire                s0_cmul1_mas_im_0_fork_ack_s_0;
  reg                 s0_cmul1_mas_im_0_fork_ack_r_1;
  wire                s0_cmul1_mas_im_0_fork_ack_s_1;
  reg                 s0_cmul1_mas_im_0_fork_ack_r_2;
  wire                s0_cmul1_mas_im_0_fork_ack_s_2;
  reg                 s0_cmul2_recip_norm_0_eb_valid;
  wire                s0_cmul2_recip_norm_0_eb_en;
  reg        [16:0]   s0_cmul2_recip_norm_0_eb_r;
  reg                 s0_cmul2_recip_mul_0_eb_valid;
  wire                s0_cmul2_recip_mul_0_eb_en;
  reg        [28:0]   s0_cmul2_recip_mul_0_eb_r;
  reg                 s0_cmul2_recip_out_0_eb_valid;
  wire                s0_cmul2_recip_out_0_eb_en;
  reg        [17:0]   s0_cmul2_recip_out_0_eb_r;
  reg                 s0_cmul2_recip_out_0_fork_ack_r_0;
  wire                s0_cmul2_recip_out_0_fork_ack_s_0;
  reg                 s0_cmul2_recip_out_0_fork_ack_r_1;
  wire                s0_cmul2_recip_out_0_fork_ack_s_1;
  reg        [4:0]    s0_cmul2_cat_re_0_eb_state;
  reg        [4:0]    s0_cmul2_cat_re_0_eb_state_nxt;
  wire                s0_cmul2_cat_re_0_eb_en0;
  wire                s0_cmul2_cat_re_0_eb_en1;
  wire                s0_cmul2_cat_re_0_eb_sel;
  reg        [71:0]   s0_cmul2_cat_re_0_eb_r0;
  reg        [71:0]   s0_cmul2_cat_re_0_eb_r1;
  reg        [4:0]    s0_cmul2_cat_im_0_eb_state;
  reg        [4:0]    s0_cmul2_cat_im_0_eb_state_nxt;
  wire                s0_cmul2_cat_im_0_eb_en0;
  wire                s0_cmul2_cat_im_0_eb_en1;
  wire                s0_cmul2_cat_im_0_eb_sel;
  reg        [71:0]   s0_cmul2_cat_im_0_eb_r0;
  reg        [71:0]   s0_cmul2_cat_im_0_eb_r1;
  reg                 s0_cmul2_mas_re_0_fork_ack_r_0;
  wire                s0_cmul2_mas_re_0_fork_ack_s_0;
  reg                 s0_cmul2_mas_re_0_fork_ack_r_1;
  wire                s0_cmul2_mas_re_0_fork_ack_s_1;
  reg                 s0_cmul2_mas_re_0_fork_ack_r_2;
  wire                s0_cmul2_mas_re_0_fork_ack_s_2;
  reg                 s0_cmul2_mas_im_0_fork_ack_r_0;
  wire                s0_cmul2_mas_im_0_fork_ack_s_0;
  reg                 s0_cmul2_mas_im_0_fork_ack_r_1;
  wire                s0_cmul2_mas_im_0_fork_ack_s_1;
  reg                 s0_cmul2_mas_im_0_fork_ack_r_2;
  wire                s0_cmul2_mas_im_0_fork_ack_s_2;
  reg                 s0_cmul3_recip_norm_0_eb_valid;
  wire                s0_cmul3_recip_norm_0_eb_en;
  reg        [16:0]   s0_cmul3_recip_norm_0_eb_r;
  reg                 s0_cmul3_recip_mul_0_eb_valid;
  wire                s0_cmul3_recip_mul_0_eb_en;
  reg        [28:0]   s0_cmul3_recip_mul_0_eb_r;
  reg                 s0_cmul3_recip_out_0_eb_valid;
  wire                s0_cmul3_recip_out_0_eb_en;
  reg        [17:0]   s0_cmul3_recip_out_0_eb_r;
  reg                 s0_cmul3_recip_out_0_fork_ack_r_0;
  wire                s0_cmul3_recip_out_0_fork_ack_s_0;
  reg                 s0_cmul3_recip_out_0_fork_ack_r_1;
  wire                s0_cmul3_recip_out_0_fork_ack_s_1;
  reg        [4:0]    s0_cmul3_cat_re_0_eb_state;
  reg        [4:0]    s0_cmul3_cat_re_0_eb_state_nxt;
  wire                s0_cmul3_cat_re_0_eb_en0;
  wire                s0_cmul3_cat_re_0_eb_en1;
  wire                s0_cmul3_cat_re_0_eb_sel;
  reg        [71:0]   s0_cmul3_cat_re_0_eb_r0;
  reg        [71:0]   s0_cmul3_cat_re_0_eb_r1;
  reg        [4:0]    s0_cmul3_cat_im_0_eb_state;
  reg        [4:0]    s0_cmul3_cat_im_0_eb_state_nxt;
  wire                s0_cmul3_cat_im_0_eb_en0;
  wire                s0_cmul3_cat_im_0_eb_en1;
  wire                s0_cmul3_cat_im_0_eb_sel;
  reg        [71:0]   s0_cmul3_cat_im_0_eb_r0;
  reg        [71:0]   s0_cmul3_cat_im_0_eb_r1;
  reg                 s0_cmul3_mas_re_0_fork_ack_r_0;
  wire                s0_cmul3_mas_re_0_fork_ack_s_0;
  reg                 s0_cmul3_mas_re_0_fork_ack_r_1;
  wire                s0_cmul3_mas_re_0_fork_ack_s_1;
  reg                 s0_cmul3_mas_re_0_fork_ack_r_2;
  wire                s0_cmul3_mas_re_0_fork_ack_s_2;
  reg                 s0_cmul3_mas_im_0_fork_ack_r_0;
  wire                s0_cmul3_mas_im_0_fork_ack_s_0;
  reg                 s0_cmul3_mas_im_0_fork_ack_r_1;
  wire                s0_cmul3_mas_im_0_fork_ack_s_1;
  reg                 s0_cmul3_mas_im_0_fork_ack_r_2;
  wire                s0_cmul3_mas_im_0_fork_ack_s_2;
  reg                 k8_funnel_1_eb_valid;
  wire                k8_funnel_1_eb_en;
  reg        [127:0]  k8_funnel_1_eb_r;
  reg                 k9_funnel_1_eb_valid;
  wire                k9_funnel_1_eb_en;
  reg        [127:0]  k9_funnel_1_eb_r;
  reg                 s1_k8_slice_0_fork_ack_r_0;
  wire                s1_k8_slice_0_fork_ack_s_0;
  reg                 s1_k8_slice_0_fork_ack_r_1;
  wire                s1_k8_slice_0_fork_ack_s_1;
  reg                 s1_k8_slice_0_fork_ack_r_2;
  wire                s1_k8_slice_0_fork_ack_s_2;
  reg                 s1_k8_slice_1_fork_ack_r_0;
  wire                s1_k8_slice_1_fork_ack_s_0;
  reg                 s1_k8_slice_1_fork_ack_r_1;
  wire                s1_k8_slice_1_fork_ack_s_1;
  reg                 s1_k8_slice_1_fork_ack_r_2;
  wire                s1_k8_slice_1_fork_ack_s_2;
  reg                 s1_k9_slice_0_fork_ack_r_0;
  wire                s1_k9_slice_0_fork_ack_s_0;
  reg                 s1_k9_slice_0_fork_ack_r_1;
  wire                s1_k9_slice_0_fork_ack_s_1;
  reg                 s1_k9_slice_0_fork_ack_r_2;
  wire                s1_k9_slice_0_fork_ack_s_2;
  reg                 s1_k9_slice_0_fork_ack_r_3;
  wire                s1_k9_slice_0_fork_ack_s_3;
  reg                 s1_k9_slice_0_fork_ack_r_4;
  wire                s1_k9_slice_0_fork_ack_s_4;
  reg                 s1_k9_slice_1_fork_ack_r_0;
  wire                s1_k9_slice_1_fork_ack_s_0;
  reg                 s1_k9_slice_1_fork_ack_r_1;
  wire                s1_k9_slice_1_fork_ack_s_1;
  reg                 s1_k9_slice_1_fork_ack_r_2;
  wire                s1_k9_slice_1_fork_ack_s_2;
  reg                 s1_k9_slice_1_fork_ack_r_3;
  wire                s1_k9_slice_1_fork_ack_s_3;
  reg                 s1_k8_slice_2_fork_ack_r_0;
  wire                s1_k8_slice_2_fork_ack_s_0;
  reg                 s1_k8_slice_2_fork_ack_r_1;
  wire                s1_k8_slice_2_fork_ack_s_1;
  reg                 s1_k8_slice_2_fork_ack_r_2;
  wire                s1_k8_slice_2_fork_ack_s_2;
  reg                 s1_k8_slice_3_fork_ack_r_0;
  wire                s1_k8_slice_3_fork_ack_s_0;
  reg                 s1_k8_slice_3_fork_ack_r_1;
  wire                s1_k8_slice_3_fork_ack_s_1;
  reg                 s1_k8_slice_3_fork_ack_r_2;
  wire                s1_k8_slice_3_fork_ack_s_2;
  reg                 s1_k9_slice_2_fork_ack_r_0;
  wire                s1_k9_slice_2_fork_ack_s_0;
  reg                 s1_k9_slice_2_fork_ack_r_1;
  wire                s1_k9_slice_2_fork_ack_s_1;
  reg                 s1_k9_slice_2_fork_ack_r_2;
  wire                s1_k9_slice_2_fork_ack_s_2;
  reg                 s1_k9_slice_2_fork_ack_r_3;
  wire                s1_k9_slice_2_fork_ack_s_3;
  reg                 s1_k9_slice_2_fork_ack_r_4;
  wire                s1_k9_slice_2_fork_ack_s_4;
  reg                 s1_k9_slice_3_fork_ack_r_0;
  wire                s1_k9_slice_3_fork_ack_s_0;
  reg                 s1_k9_slice_3_fork_ack_r_1;
  wire                s1_k9_slice_3_fork_ack_s_1;
  reg                 s1_k9_slice_3_fork_ack_r_2;
  wire                s1_k9_slice_3_fork_ack_s_2;
  reg                 s1_k9_slice_3_fork_ack_r_3;
  wire                s1_k9_slice_3_fork_ack_s_3;
  reg                 s1_k8_slice_4_fork_ack_r_0;
  wire                s1_k8_slice_4_fork_ack_s_0;
  reg                 s1_k8_slice_4_fork_ack_r_1;
  wire                s1_k8_slice_4_fork_ack_s_1;
  reg                 s1_k8_slice_4_fork_ack_r_2;
  wire                s1_k8_slice_4_fork_ack_s_2;
  reg                 s1_k8_slice_5_fork_ack_r_0;
  wire                s1_k8_slice_5_fork_ack_s_0;
  reg                 s1_k8_slice_5_fork_ack_r_1;
  wire                s1_k8_slice_5_fork_ack_s_1;
  reg                 s1_k8_slice_5_fork_ack_r_2;
  wire                s1_k8_slice_5_fork_ack_s_2;
  reg                 s1_k9_slice_4_fork_ack_r_0;
  wire                s1_k9_slice_4_fork_ack_s_0;
  reg                 s1_k9_slice_4_fork_ack_r_1;
  wire                s1_k9_slice_4_fork_ack_s_1;
  reg                 s1_k9_slice_4_fork_ack_r_2;
  wire                s1_k9_slice_4_fork_ack_s_2;
  reg                 s1_k9_slice_4_fork_ack_r_3;
  wire                s1_k9_slice_4_fork_ack_s_3;
  reg                 s1_k9_slice_4_fork_ack_r_4;
  wire                s1_k9_slice_4_fork_ack_s_4;
  reg                 s1_k9_slice_5_fork_ack_r_0;
  wire                s1_k9_slice_5_fork_ack_s_0;
  reg                 s1_k9_slice_5_fork_ack_r_1;
  wire                s1_k9_slice_5_fork_ack_s_1;
  reg                 s1_k9_slice_5_fork_ack_r_2;
  wire                s1_k9_slice_5_fork_ack_s_2;
  reg                 s1_k9_slice_5_fork_ack_r_3;
  wire                s1_k9_slice_5_fork_ack_s_3;
  reg                 s1_k8_slice_6_fork_ack_r_0;
  wire                s1_k8_slice_6_fork_ack_s_0;
  reg                 s1_k8_slice_6_fork_ack_r_1;
  wire                s1_k8_slice_6_fork_ack_s_1;
  reg                 s1_k8_slice_6_fork_ack_r_2;
  wire                s1_k8_slice_6_fork_ack_s_2;
  reg                 s1_k8_slice_7_fork_ack_r_0;
  wire                s1_k8_slice_7_fork_ack_s_0;
  reg                 s1_k8_slice_7_fork_ack_r_1;
  wire                s1_k8_slice_7_fork_ack_s_1;
  reg                 s1_k8_slice_7_fork_ack_r_2;
  wire                s1_k8_slice_7_fork_ack_s_2;
  reg                 s1_k9_slice_6_fork_ack_r_0;
  wire                s1_k9_slice_6_fork_ack_s_0;
  reg                 s1_k9_slice_6_fork_ack_r_1;
  wire                s1_k9_slice_6_fork_ack_s_1;
  reg                 s1_k9_slice_6_fork_ack_r_2;
  wire                s1_k9_slice_6_fork_ack_s_2;
  reg                 s1_k9_slice_6_fork_ack_r_3;
  wire                s1_k9_slice_6_fork_ack_s_3;
  reg                 s1_k9_slice_6_fork_ack_r_4;
  wire                s1_k9_slice_6_fork_ack_s_4;
  reg                 s1_k9_slice_7_fork_ack_r_0;
  wire                s1_k9_slice_7_fork_ack_s_0;
  reg                 s1_k9_slice_7_fork_ack_r_1;
  wire                s1_k9_slice_7_fork_ack_s_1;
  reg                 s1_k9_slice_7_fork_ack_r_2;
  wire                s1_k9_slice_7_fork_ack_s_2;
  reg                 s1_k9_slice_7_fork_ack_r_3;
  wire                s1_k9_slice_7_fork_ack_s_3;
  reg                 s1_cmul0_recip_norm_0_eb_valid;
  wire                s1_cmul0_recip_norm_0_eb_en;
  reg        [16:0]   s1_cmul0_recip_norm_0_eb_r;
  reg                 s1_cmul0_recip_mul_0_eb_valid;
  wire                s1_cmul0_recip_mul_0_eb_en;
  reg        [28:0]   s1_cmul0_recip_mul_0_eb_r;
  reg                 s1_cmul0_recip_out_0_eb_valid;
  wire                s1_cmul0_recip_out_0_eb_en;
  reg        [17:0]   s1_cmul0_recip_out_0_eb_r;
  reg                 s1_cmul0_recip_out_0_fork_ack_r_0;
  wire                s1_cmul0_recip_out_0_fork_ack_s_0;
  reg                 s1_cmul0_recip_out_0_fork_ack_r_1;
  wire                s1_cmul0_recip_out_0_fork_ack_s_1;
  reg        [4:0]    s1_cmul0_cat_re_0_eb_state;
  reg        [4:0]    s1_cmul0_cat_re_0_eb_state_nxt;
  wire                s1_cmul0_cat_re_0_eb_en0;
  wire                s1_cmul0_cat_re_0_eb_en1;
  wire                s1_cmul0_cat_re_0_eb_sel;
  reg        [71:0]   s1_cmul0_cat_re_0_eb_r0;
  reg        [71:0]   s1_cmul0_cat_re_0_eb_r1;
  reg        [4:0]    s1_cmul0_cat_im_0_eb_state;
  reg        [4:0]    s1_cmul0_cat_im_0_eb_state_nxt;
  wire                s1_cmul0_cat_im_0_eb_en0;
  wire                s1_cmul0_cat_im_0_eb_en1;
  wire                s1_cmul0_cat_im_0_eb_sel;
  reg        [71:0]   s1_cmul0_cat_im_0_eb_r0;
  reg        [71:0]   s1_cmul0_cat_im_0_eb_r1;
  reg                 s1_cmul0_mas_re_0_fork_ack_r_0;
  wire                s1_cmul0_mas_re_0_fork_ack_s_0;
  reg                 s1_cmul0_mas_re_0_fork_ack_r_1;
  wire                s1_cmul0_mas_re_0_fork_ack_s_1;
  reg                 s1_cmul0_mas_re_0_fork_ack_r_2;
  wire                s1_cmul0_mas_re_0_fork_ack_s_2;
  reg                 s1_cmul0_mas_im_0_fork_ack_r_0;
  wire                s1_cmul0_mas_im_0_fork_ack_s_0;
  reg                 s1_cmul0_mas_im_0_fork_ack_r_1;
  wire                s1_cmul0_mas_im_0_fork_ack_s_1;
  reg                 s1_cmul0_mas_im_0_fork_ack_r_2;
  wire                s1_cmul0_mas_im_0_fork_ack_s_2;
  reg                 s1_cmul1_recip_norm_0_eb_valid;
  wire                s1_cmul1_recip_norm_0_eb_en;
  reg        [16:0]   s1_cmul1_recip_norm_0_eb_r;
  reg                 s1_cmul1_recip_mul_0_eb_valid;
  wire                s1_cmul1_recip_mul_0_eb_en;
  reg        [28:0]   s1_cmul1_recip_mul_0_eb_r;
  reg                 s1_cmul1_recip_out_0_eb_valid;
  wire                s1_cmul1_recip_out_0_eb_en;
  reg        [17:0]   s1_cmul1_recip_out_0_eb_r;
  reg                 s1_cmul1_recip_out_0_fork_ack_r_0;
  wire                s1_cmul1_recip_out_0_fork_ack_s_0;
  reg                 s1_cmul1_recip_out_0_fork_ack_r_1;
  wire                s1_cmul1_recip_out_0_fork_ack_s_1;
  reg        [4:0]    s1_cmul1_cat_re_0_eb_state;
  reg        [4:0]    s1_cmul1_cat_re_0_eb_state_nxt;
  wire                s1_cmul1_cat_re_0_eb_en0;
  wire                s1_cmul1_cat_re_0_eb_en1;
  wire                s1_cmul1_cat_re_0_eb_sel;
  reg        [71:0]   s1_cmul1_cat_re_0_eb_r0;
  reg        [71:0]   s1_cmul1_cat_re_0_eb_r1;
  reg        [4:0]    s1_cmul1_cat_im_0_eb_state;
  reg        [4:0]    s1_cmul1_cat_im_0_eb_state_nxt;
  wire                s1_cmul1_cat_im_0_eb_en0;
  wire                s1_cmul1_cat_im_0_eb_en1;
  wire                s1_cmul1_cat_im_0_eb_sel;
  reg        [71:0]   s1_cmul1_cat_im_0_eb_r0;
  reg        [71:0]   s1_cmul1_cat_im_0_eb_r1;
  reg                 s1_cmul1_mas_re_0_fork_ack_r_0;
  wire                s1_cmul1_mas_re_0_fork_ack_s_0;
  reg                 s1_cmul1_mas_re_0_fork_ack_r_1;
  wire                s1_cmul1_mas_re_0_fork_ack_s_1;
  reg                 s1_cmul1_mas_re_0_fork_ack_r_2;
  wire                s1_cmul1_mas_re_0_fork_ack_s_2;
  reg                 s1_cmul1_mas_im_0_fork_ack_r_0;
  wire                s1_cmul1_mas_im_0_fork_ack_s_0;
  reg                 s1_cmul1_mas_im_0_fork_ack_r_1;
  wire                s1_cmul1_mas_im_0_fork_ack_s_1;
  reg                 s1_cmul1_mas_im_0_fork_ack_r_2;
  wire                s1_cmul1_mas_im_0_fork_ack_s_2;
  reg                 s1_cmul2_recip_norm_0_eb_valid;
  wire                s1_cmul2_recip_norm_0_eb_en;
  reg        [16:0]   s1_cmul2_recip_norm_0_eb_r;
  reg                 s1_cmul2_recip_mul_0_eb_valid;
  wire                s1_cmul2_recip_mul_0_eb_en;
  reg        [28:0]   s1_cmul2_recip_mul_0_eb_r;
  reg                 s1_cmul2_recip_out_0_eb_valid;
  wire                s1_cmul2_recip_out_0_eb_en;
  reg        [17:0]   s1_cmul2_recip_out_0_eb_r;
  reg                 s1_cmul2_recip_out_0_fork_ack_r_0;
  wire                s1_cmul2_recip_out_0_fork_ack_s_0;
  reg                 s1_cmul2_recip_out_0_fork_ack_r_1;
  wire                s1_cmul2_recip_out_0_fork_ack_s_1;
  reg        [4:0]    s1_cmul2_cat_re_0_eb_state;
  reg        [4:0]    s1_cmul2_cat_re_0_eb_state_nxt;
  wire                s1_cmul2_cat_re_0_eb_en0;
  wire                s1_cmul2_cat_re_0_eb_en1;
  wire                s1_cmul2_cat_re_0_eb_sel;
  reg        [71:0]   s1_cmul2_cat_re_0_eb_r0;
  reg        [71:0]   s1_cmul2_cat_re_0_eb_r1;
  reg        [4:0]    s1_cmul2_cat_im_0_eb_state;
  reg        [4:0]    s1_cmul2_cat_im_0_eb_state_nxt;
  wire                s1_cmul2_cat_im_0_eb_en0;
  wire                s1_cmul2_cat_im_0_eb_en1;
  wire                s1_cmul2_cat_im_0_eb_sel;
  reg        [71:0]   s1_cmul2_cat_im_0_eb_r0;
  reg        [71:0]   s1_cmul2_cat_im_0_eb_r1;
  reg                 s1_cmul2_mas_re_0_fork_ack_r_0;
  wire                s1_cmul2_mas_re_0_fork_ack_s_0;
  reg                 s1_cmul2_mas_re_0_fork_ack_r_1;
  wire                s1_cmul2_mas_re_0_fork_ack_s_1;
  reg                 s1_cmul2_mas_re_0_fork_ack_r_2;
  wire                s1_cmul2_mas_re_0_fork_ack_s_2;
  reg                 s1_cmul2_mas_im_0_fork_ack_r_0;
  wire                s1_cmul2_mas_im_0_fork_ack_s_0;
  reg                 s1_cmul2_mas_im_0_fork_ack_r_1;
  wire                s1_cmul2_mas_im_0_fork_ack_s_1;
  reg                 s1_cmul2_mas_im_0_fork_ack_r_2;
  wire                s1_cmul2_mas_im_0_fork_ack_s_2;
  reg                 s1_cmul3_recip_norm_0_eb_valid;
  wire                s1_cmul3_recip_norm_0_eb_en;
  reg        [16:0]   s1_cmul3_recip_norm_0_eb_r;
  reg                 s1_cmul3_recip_mul_0_eb_valid;
  wire                s1_cmul3_recip_mul_0_eb_en;
  reg        [28:0]   s1_cmul3_recip_mul_0_eb_r;
  reg                 s1_cmul3_recip_out_0_eb_valid;
  wire                s1_cmul3_recip_out_0_eb_en;
  reg        [17:0]   s1_cmul3_recip_out_0_eb_r;
  reg                 s1_cmul3_recip_out_0_fork_ack_r_0;
  wire                s1_cmul3_recip_out_0_fork_ack_s_0;
  reg                 s1_cmul3_recip_out_0_fork_ack_r_1;
  wire                s1_cmul3_recip_out_0_fork_ack_s_1;
  reg        [4:0]    s1_cmul3_cat_re_0_eb_state;
  reg        [4:0]    s1_cmul3_cat_re_0_eb_state_nxt;
  wire                s1_cmul3_cat_re_0_eb_en0;
  wire                s1_cmul3_cat_re_0_eb_en1;
  wire                s1_cmul3_cat_re_0_eb_sel;
  reg        [71:0]   s1_cmul3_cat_re_0_eb_r0;
  reg        [71:0]   s1_cmul3_cat_re_0_eb_r1;
  reg        [4:0]    s1_cmul3_cat_im_0_eb_state;
  reg        [4:0]    s1_cmul3_cat_im_0_eb_state_nxt;
  wire                s1_cmul3_cat_im_0_eb_en0;
  wire                s1_cmul3_cat_im_0_eb_en1;
  wire                s1_cmul3_cat_im_0_eb_sel;
  reg        [71:0]   s1_cmul3_cat_im_0_eb_r0;
  reg        [71:0]   s1_cmul3_cat_im_0_eb_r1;
  reg                 s1_cmul3_mas_re_0_fork_ack_r_0;
  wire                s1_cmul3_mas_re_0_fork_ack_s_0;
  reg                 s1_cmul3_mas_re_0_fork_ack_r_1;
  wire                s1_cmul3_mas_re_0_fork_ack_s_1;
  reg                 s1_cmul3_mas_re_0_fork_ack_r_2;
  wire                s1_cmul3_mas_re_0_fork_ack_s_2;
  reg                 s1_cmul3_mas_im_0_fork_ack_r_0;
  wire                s1_cmul3_mas_im_0_fork_ack_s_0;
  reg                 s1_cmul3_mas_im_0_fork_ack_r_1;
  wire                s1_cmul3_mas_im_0_fork_ack_s_1;
  reg                 s1_cmul3_mas_im_0_fork_ack_r_2;
  wire                s1_cmul3_mas_im_0_fork_ack_s_2;
  reg        [4:0]    s0_r4_a0_re_0_eb_state;
  reg        [4:0]    s0_r4_a0_re_0_eb_state_nxt;
  wire                s0_r4_a0_re_0_eb_en0;
  wire                s0_r4_a0_re_0_eb_en1;
  wire                s0_r4_a0_re_0_eb_sel;
  reg        [35:0]   s0_r4_a0_re_0_eb_r0;
  reg        [35:0]   s0_r4_a0_re_0_eb_r1;
  reg                 s0_r4_a0_re_0_fork_ack_r_0;
  wire                s0_r4_a0_re_0_fork_ack_s_0;
  reg                 s0_r4_a0_re_0_fork_ack_r_1;
  wire                s0_r4_a0_re_0_fork_ack_s_1;
  reg        [4:0]    s0_r4_a0_im_0_eb_state;
  reg        [4:0]    s0_r4_a0_im_0_eb_state_nxt;
  wire                s0_r4_a0_im_0_eb_en0;
  wire                s0_r4_a0_im_0_eb_en1;
  wire                s0_r4_a0_im_0_eb_sel;
  reg        [35:0]   s0_r4_a0_im_0_eb_r0;
  reg        [35:0]   s0_r4_a0_im_0_eb_r1;
  reg                 s0_r4_a0_im_0_fork_ack_r_0;
  wire                s0_r4_a0_im_0_fork_ack_s_0;
  reg                 s0_r4_a0_im_0_fork_ack_r_1;
  wire                s0_r4_a0_im_0_fork_ack_s_1;
  reg        [4:0]    s0_r4_a1_re_0_eb_state;
  reg        [4:0]    s0_r4_a1_re_0_eb_state_nxt;
  wire                s0_r4_a1_re_0_eb_en0;
  wire                s0_r4_a1_re_0_eb_en1;
  wire                s0_r4_a1_re_0_eb_sel;
  reg        [35:0]   s0_r4_a1_re_0_eb_r0;
  reg        [35:0]   s0_r4_a1_re_0_eb_r1;
  reg                 s0_r4_a1_re_0_fork_ack_r_0;
  wire                s0_r4_a1_re_0_fork_ack_s_0;
  reg                 s0_r4_a1_re_0_fork_ack_r_1;
  wire                s0_r4_a1_re_0_fork_ack_s_1;
  reg        [4:0]    s0_r4_a1_im_0_eb_state;
  reg        [4:0]    s0_r4_a1_im_0_eb_state_nxt;
  wire                s0_r4_a1_im_0_eb_en0;
  wire                s0_r4_a1_im_0_eb_en1;
  wire                s0_r4_a1_im_0_eb_sel;
  reg        [35:0]   s0_r4_a1_im_0_eb_r0;
  reg        [35:0]   s0_r4_a1_im_0_eb_r1;
  reg                 s0_r4_a1_im_0_fork_ack_r_0;
  wire                s0_r4_a1_im_0_fork_ack_s_0;
  reg                 s0_r4_a1_im_0_fork_ack_r_1;
  wire                s0_r4_a1_im_0_fork_ack_s_1;
  reg        [4:0]    s0_r4_a2_re_0_eb_state;
  reg        [4:0]    s0_r4_a2_re_0_eb_state_nxt;
  wire                s0_r4_a2_re_0_eb_en0;
  wire                s0_r4_a2_re_0_eb_en1;
  wire                s0_r4_a2_re_0_eb_sel;
  reg        [35:0]   s0_r4_a2_re_0_eb_r0;
  reg        [35:0]   s0_r4_a2_re_0_eb_r1;
  reg                 s0_r4_a2_re_0_fork_ack_r_0;
  wire                s0_r4_a2_re_0_fork_ack_s_0;
  reg                 s0_r4_a2_re_0_fork_ack_r_1;
  wire                s0_r4_a2_re_0_fork_ack_s_1;
  reg        [4:0]    s0_r4_a2_im_0_eb_state;
  reg        [4:0]    s0_r4_a2_im_0_eb_state_nxt;
  wire                s0_r4_a2_im_0_eb_en0;
  wire                s0_r4_a2_im_0_eb_en1;
  wire                s0_r4_a2_im_0_eb_sel;
  reg        [35:0]   s0_r4_a2_im_0_eb_r0;
  reg        [35:0]   s0_r4_a2_im_0_eb_r1;
  reg                 s0_r4_a2_im_0_fork_ack_r_0;
  wire                s0_r4_a2_im_0_fork_ack_s_0;
  reg                 s0_r4_a2_im_0_fork_ack_r_1;
  wire                s0_r4_a2_im_0_fork_ack_s_1;
  reg        [4:0]    s0_r4_a3_re_0_eb_state;
  reg        [4:0]    s0_r4_a3_re_0_eb_state_nxt;
  wire                s0_r4_a3_re_0_eb_en0;
  wire                s0_r4_a3_re_0_eb_en1;
  wire                s0_r4_a3_re_0_eb_sel;
  reg        [35:0]   s0_r4_a3_re_0_eb_r0;
  reg        [35:0]   s0_r4_a3_re_0_eb_r1;
  reg                 s0_r4_a3_re_0_fork_ack_r_0;
  wire                s0_r4_a3_re_0_fork_ack_s_0;
  reg                 s0_r4_a3_re_0_fork_ack_r_1;
  wire                s0_r4_a3_re_0_fork_ack_s_1;
  reg        [4:0]    s0_r4_a3_im_0_eb_state;
  reg        [4:0]    s0_r4_a3_im_0_eb_state_nxt;
  wire                s0_r4_a3_im_0_eb_en0;
  wire                s0_r4_a3_im_0_eb_en1;
  wire                s0_r4_a3_im_0_eb_sel;
  reg        [35:0]   s0_r4_a3_im_0_eb_r0;
  reg        [35:0]   s0_r4_a3_im_0_eb_r1;
  reg                 s0_r4_a3_im_0_fork_ack_r_0;
  wire                s0_r4_a3_im_0_fork_ack_s_0;
  reg                 s0_r4_a3_im_0_fork_ack_r_1;
  wire                s0_r4_a3_im_0_fork_ack_s_1;
  reg                 s0_r4_byp0_re_0_eb_valid;
  wire                s0_r4_byp0_re_0_eb_en;
  reg        [35:0]   s0_r4_byp0_re_0_eb_r;
  reg                 s0_r4_byp0_im_0_eb_valid;
  wire                s0_r4_byp0_im_0_eb_en;
  reg        [35:0]   s0_r4_byp0_im_0_eb_r;
  reg                 s0_r4_byp1_re_0_eb_valid;
  wire                s0_r4_byp1_re_0_eb_en;
  reg        [35:0]   s0_r4_byp1_re_0_eb_r;
  reg                 s0_r4_byp1_im_0_eb_valid;
  wire                s0_r4_byp1_im_0_eb_en;
  reg        [35:0]   s0_r4_byp1_im_0_eb_r;
  reg                 s0_r4_byp2_re_0_eb_valid;
  wire                s0_r4_byp2_re_0_eb_en;
  reg        [35:0]   s0_r4_byp2_re_0_eb_r;
  reg                 s0_r4_byp2_im_0_eb_valid;
  wire                s0_r4_byp2_im_0_eb_en;
  reg        [35:0]   s0_r4_byp2_im_0_eb_r;
  reg                 s0_r4_byp3_re_0_eb_valid;
  wire                s0_r4_byp3_re_0_eb_en;
  reg        [35:0]   s0_r4_byp3_re_0_eb_r;
  reg                 s0_r4_byp3_im_0_eb_valid;
  wire                s0_r4_byp3_im_0_eb_en;
  reg        [35:0]   s0_r4_byp3_im_0_eb_r;
  reg        [4:0]    s1_r4_a0_re_0_eb_state;
  reg        [4:0]    s1_r4_a0_re_0_eb_state_nxt;
  wire                s1_r4_a0_re_0_eb_en0;
  wire                s1_r4_a0_re_0_eb_en1;
  wire                s1_r4_a0_re_0_eb_sel;
  reg        [35:0]   s1_r4_a0_re_0_eb_r0;
  reg        [35:0]   s1_r4_a0_re_0_eb_r1;
  reg                 s1_r4_a0_re_0_fork_ack_r_0;
  wire                s1_r4_a0_re_0_fork_ack_s_0;
  reg                 s1_r4_a0_re_0_fork_ack_r_1;
  wire                s1_r4_a0_re_0_fork_ack_s_1;
  reg        [4:0]    s1_r4_a0_im_0_eb_state;
  reg        [4:0]    s1_r4_a0_im_0_eb_state_nxt;
  wire                s1_r4_a0_im_0_eb_en0;
  wire                s1_r4_a0_im_0_eb_en1;
  wire                s1_r4_a0_im_0_eb_sel;
  reg        [35:0]   s1_r4_a0_im_0_eb_r0;
  reg        [35:0]   s1_r4_a0_im_0_eb_r1;
  reg                 s1_r4_a0_im_0_fork_ack_r_0;
  wire                s1_r4_a0_im_0_fork_ack_s_0;
  reg                 s1_r4_a0_im_0_fork_ack_r_1;
  wire                s1_r4_a0_im_0_fork_ack_s_1;
  reg        [4:0]    s1_r4_a1_re_0_eb_state;
  reg        [4:0]    s1_r4_a1_re_0_eb_state_nxt;
  wire                s1_r4_a1_re_0_eb_en0;
  wire                s1_r4_a1_re_0_eb_en1;
  wire                s1_r4_a1_re_0_eb_sel;
  reg        [35:0]   s1_r4_a1_re_0_eb_r0;
  reg        [35:0]   s1_r4_a1_re_0_eb_r1;
  reg                 s1_r4_a1_re_0_fork_ack_r_0;
  wire                s1_r4_a1_re_0_fork_ack_s_0;
  reg                 s1_r4_a1_re_0_fork_ack_r_1;
  wire                s1_r4_a1_re_0_fork_ack_s_1;
  reg        [4:0]    s1_r4_a1_im_0_eb_state;
  reg        [4:0]    s1_r4_a1_im_0_eb_state_nxt;
  wire                s1_r4_a1_im_0_eb_en0;
  wire                s1_r4_a1_im_0_eb_en1;
  wire                s1_r4_a1_im_0_eb_sel;
  reg        [35:0]   s1_r4_a1_im_0_eb_r0;
  reg        [35:0]   s1_r4_a1_im_0_eb_r1;
  reg                 s1_r4_a1_im_0_fork_ack_r_0;
  wire                s1_r4_a1_im_0_fork_ack_s_0;
  reg                 s1_r4_a1_im_0_fork_ack_r_1;
  wire                s1_r4_a1_im_0_fork_ack_s_1;
  reg        [4:0]    s1_r4_a2_re_0_eb_state;
  reg        [4:0]    s1_r4_a2_re_0_eb_state_nxt;
  wire                s1_r4_a2_re_0_eb_en0;
  wire                s1_r4_a2_re_0_eb_en1;
  wire                s1_r4_a2_re_0_eb_sel;
  reg        [35:0]   s1_r4_a2_re_0_eb_r0;
  reg        [35:0]   s1_r4_a2_re_0_eb_r1;
  reg                 s1_r4_a2_re_0_fork_ack_r_0;
  wire                s1_r4_a2_re_0_fork_ack_s_0;
  reg                 s1_r4_a2_re_0_fork_ack_r_1;
  wire                s1_r4_a2_re_0_fork_ack_s_1;
  reg        [4:0]    s1_r4_a2_im_0_eb_state;
  reg        [4:0]    s1_r4_a2_im_0_eb_state_nxt;
  wire                s1_r4_a2_im_0_eb_en0;
  wire                s1_r4_a2_im_0_eb_en1;
  wire                s1_r4_a2_im_0_eb_sel;
  reg        [35:0]   s1_r4_a2_im_0_eb_r0;
  reg        [35:0]   s1_r4_a2_im_0_eb_r1;
  reg                 s1_r4_a2_im_0_fork_ack_r_0;
  wire                s1_r4_a2_im_0_fork_ack_s_0;
  reg                 s1_r4_a2_im_0_fork_ack_r_1;
  wire                s1_r4_a2_im_0_fork_ack_s_1;
  reg        [4:0]    s1_r4_a3_re_0_eb_state;
  reg        [4:0]    s1_r4_a3_re_0_eb_state_nxt;
  wire                s1_r4_a3_re_0_eb_en0;
  wire                s1_r4_a3_re_0_eb_en1;
  wire                s1_r4_a3_re_0_eb_sel;
  reg        [35:0]   s1_r4_a3_re_0_eb_r0;
  reg        [35:0]   s1_r4_a3_re_0_eb_r1;
  reg                 s1_r4_a3_re_0_fork_ack_r_0;
  wire                s1_r4_a3_re_0_fork_ack_s_0;
  reg                 s1_r4_a3_re_0_fork_ack_r_1;
  wire                s1_r4_a3_re_0_fork_ack_s_1;
  reg        [4:0]    s1_r4_a3_im_0_eb_state;
  reg        [4:0]    s1_r4_a3_im_0_eb_state_nxt;
  wire                s1_r4_a3_im_0_eb_en0;
  wire                s1_r4_a3_im_0_eb_en1;
  wire                s1_r4_a3_im_0_eb_sel;
  reg        [35:0]   s1_r4_a3_im_0_eb_r0;
  reg        [35:0]   s1_r4_a3_im_0_eb_r1;
  reg                 s1_r4_a3_im_0_fork_ack_r_0;
  wire                s1_r4_a3_im_0_fork_ack_s_0;
  reg                 s1_r4_a3_im_0_fork_ack_r_1;
  wire                s1_r4_a3_im_0_fork_ack_s_1;
  reg                 s1_r4_byp0_re_0_eb_valid;
  wire                s1_r4_byp0_re_0_eb_en;
  reg        [35:0]   s1_r4_byp0_re_0_eb_r;
  reg                 s1_r4_byp0_im_0_eb_valid;
  wire                s1_r4_byp0_im_0_eb_en;
  reg        [35:0]   s1_r4_byp0_im_0_eb_r;
  reg                 s1_r4_byp1_re_0_eb_valid;
  wire                s1_r4_byp1_re_0_eb_en;
  reg        [35:0]   s1_r4_byp1_re_0_eb_r;
  reg                 s1_r4_byp1_im_0_eb_valid;
  wire                s1_r4_byp1_im_0_eb_en;
  reg        [35:0]   s1_r4_byp1_im_0_eb_r;
  reg                 s1_r4_byp2_re_0_eb_valid;
  wire                s1_r4_byp2_re_0_eb_en;
  reg        [35:0]   s1_r4_byp2_re_0_eb_r;
  reg                 s1_r4_byp2_im_0_eb_valid;
  wire                s1_r4_byp2_im_0_eb_en;
  reg        [35:0]   s1_r4_byp2_im_0_eb_r;
  reg                 s1_r4_byp3_re_0_eb_valid;
  wire                s1_r4_byp3_re_0_eb_en;
  reg        [35:0]   s1_r4_byp3_re_0_eb_r;
  reg                 s1_r4_byp3_im_0_eb_valid;
  wire                s1_r4_byp3_im_0_eb_en;
  reg        [35:0]   s1_r4_byp3_im_0_eb_r;
  reg        [4:0]    s0_bs0_re_0_eb_state;
  reg        [4:0]    s0_bs0_re_0_eb_state_nxt;
  wire                s0_bs0_re_0_eb_en0;
  wire                s0_bs0_re_0_eb_en1;
  wire                s0_bs0_re_0_eb_sel;
  reg        [19:0]   s0_bs0_re_0_eb_r0;
  reg        [19:0]   s0_bs0_re_0_eb_r1;
  reg        [4:0]    s0_bs0_im_0_eb_state;
  reg        [4:0]    s0_bs0_im_0_eb_state_nxt;
  wire                s0_bs0_im_0_eb_en0;
  wire                s0_bs0_im_0_eb_en1;
  wire                s0_bs0_im_0_eb_sel;
  reg        [19:0]   s0_bs0_im_0_eb_r0;
  reg        [19:0]   s0_bs0_im_0_eb_r1;
  reg                 s0_rsat0_re_0_eb_valid;
  wire                s0_rsat0_re_0_eb_en;
  reg        [15:0]   s0_rsat0_re_0_eb_r;
  reg                 s0_rsat0_im_0_eb_valid;
  wire                s0_rsat0_im_0_eb_en;
  reg        [15:0]   s0_rsat0_im_0_eb_r;
  reg        [4:0]    s0_bs1_re_0_eb_state;
  reg        [4:0]    s0_bs1_re_0_eb_state_nxt;
  wire                s0_bs1_re_0_eb_en0;
  wire                s0_bs1_re_0_eb_en1;
  wire                s0_bs1_re_0_eb_sel;
  reg        [19:0]   s0_bs1_re_0_eb_r0;
  reg        [19:0]   s0_bs1_re_0_eb_r1;
  reg        [4:0]    s0_bs1_im_0_eb_state;
  reg        [4:0]    s0_bs1_im_0_eb_state_nxt;
  wire                s0_bs1_im_0_eb_en0;
  wire                s0_bs1_im_0_eb_en1;
  wire                s0_bs1_im_0_eb_sel;
  reg        [19:0]   s0_bs1_im_0_eb_r0;
  reg        [19:0]   s0_bs1_im_0_eb_r1;
  reg                 s0_rsat1_re_0_eb_valid;
  wire                s0_rsat1_re_0_eb_en;
  reg        [15:0]   s0_rsat1_re_0_eb_r;
  reg                 s0_rsat1_im_0_eb_valid;
  wire                s0_rsat1_im_0_eb_en;
  reg        [15:0]   s0_rsat1_im_0_eb_r;
  reg        [4:0]    s0_bs2_re_0_eb_state;
  reg        [4:0]    s0_bs2_re_0_eb_state_nxt;
  wire                s0_bs2_re_0_eb_en0;
  wire                s0_bs2_re_0_eb_en1;
  wire                s0_bs2_re_0_eb_sel;
  reg        [19:0]   s0_bs2_re_0_eb_r0;
  reg        [19:0]   s0_bs2_re_0_eb_r1;
  reg        [4:0]    s0_bs2_im_0_eb_state;
  reg        [4:0]    s0_bs2_im_0_eb_state_nxt;
  wire                s0_bs2_im_0_eb_en0;
  wire                s0_bs2_im_0_eb_en1;
  wire                s0_bs2_im_0_eb_sel;
  reg        [19:0]   s0_bs2_im_0_eb_r0;
  reg        [19:0]   s0_bs2_im_0_eb_r1;
  reg                 s0_rsat2_re_0_eb_valid;
  wire                s0_rsat2_re_0_eb_en;
  reg        [15:0]   s0_rsat2_re_0_eb_r;
  reg                 s0_rsat2_im_0_eb_valid;
  wire                s0_rsat2_im_0_eb_en;
  reg        [15:0]   s0_rsat2_im_0_eb_r;
  reg        [4:0]    s0_bs3_re_0_eb_state;
  reg        [4:0]    s0_bs3_re_0_eb_state_nxt;
  wire                s0_bs3_re_0_eb_en0;
  wire                s0_bs3_re_0_eb_en1;
  wire                s0_bs3_re_0_eb_sel;
  reg        [19:0]   s0_bs3_re_0_eb_r0;
  reg        [19:0]   s0_bs3_re_0_eb_r1;
  reg        [4:0]    s0_bs3_im_0_eb_state;
  reg        [4:0]    s0_bs3_im_0_eb_state_nxt;
  wire                s0_bs3_im_0_eb_en0;
  wire                s0_bs3_im_0_eb_en1;
  wire                s0_bs3_im_0_eb_sel;
  reg        [19:0]   s0_bs3_im_0_eb_r0;
  reg        [19:0]   s0_bs3_im_0_eb_r1;
  reg                 s0_rsat3_re_0_eb_valid;
  wire                s0_rsat3_re_0_eb_en;
  reg        [15:0]   s0_rsat3_re_0_eb_r;
  reg                 s0_rsat3_im_0_eb_valid;
  wire                s0_rsat3_im_0_eb_en;
  reg        [15:0]   s0_rsat3_im_0_eb_r;
  reg        [4:0]    s1_bs0_re_0_eb_state;
  reg        [4:0]    s1_bs0_re_0_eb_state_nxt;
  wire                s1_bs0_re_0_eb_en0;
  wire                s1_bs0_re_0_eb_en1;
  wire                s1_bs0_re_0_eb_sel;
  reg        [19:0]   s1_bs0_re_0_eb_r0;
  reg        [19:0]   s1_bs0_re_0_eb_r1;
  reg        [4:0]    s1_bs0_im_0_eb_state;
  reg        [4:0]    s1_bs0_im_0_eb_state_nxt;
  wire                s1_bs0_im_0_eb_en0;
  wire                s1_bs0_im_0_eb_en1;
  wire                s1_bs0_im_0_eb_sel;
  reg        [19:0]   s1_bs0_im_0_eb_r0;
  reg        [19:0]   s1_bs0_im_0_eb_r1;
  reg                 s1_rsat0_re_0_eb_valid;
  wire                s1_rsat0_re_0_eb_en;
  reg        [15:0]   s1_rsat0_re_0_eb_r;
  reg                 s1_rsat0_im_0_eb_valid;
  wire                s1_rsat0_im_0_eb_en;
  reg        [15:0]   s1_rsat0_im_0_eb_r;
  reg        [4:0]    s1_bs1_re_0_eb_state;
  reg        [4:0]    s1_bs1_re_0_eb_state_nxt;
  wire                s1_bs1_re_0_eb_en0;
  wire                s1_bs1_re_0_eb_en1;
  wire                s1_bs1_re_0_eb_sel;
  reg        [19:0]   s1_bs1_re_0_eb_r0;
  reg        [19:0]   s1_bs1_re_0_eb_r1;
  reg        [4:0]    s1_bs1_im_0_eb_state;
  reg        [4:0]    s1_bs1_im_0_eb_state_nxt;
  wire                s1_bs1_im_0_eb_en0;
  wire                s1_bs1_im_0_eb_en1;
  wire                s1_bs1_im_0_eb_sel;
  reg        [19:0]   s1_bs1_im_0_eb_r0;
  reg        [19:0]   s1_bs1_im_0_eb_r1;
  reg                 s1_rsat1_re_0_eb_valid;
  wire                s1_rsat1_re_0_eb_en;
  reg        [15:0]   s1_rsat1_re_0_eb_r;
  reg                 s1_rsat1_im_0_eb_valid;
  wire                s1_rsat1_im_0_eb_en;
  reg        [15:0]   s1_rsat1_im_0_eb_r;
  reg        [4:0]    s1_bs2_re_0_eb_state;
  reg        [4:0]    s1_bs2_re_0_eb_state_nxt;
  wire                s1_bs2_re_0_eb_en0;
  wire                s1_bs2_re_0_eb_en1;
  wire                s1_bs2_re_0_eb_sel;
  reg        [19:0]   s1_bs2_re_0_eb_r0;
  reg        [19:0]   s1_bs2_re_0_eb_r1;
  reg        [4:0]    s1_bs2_im_0_eb_state;
  reg        [4:0]    s1_bs2_im_0_eb_state_nxt;
  wire                s1_bs2_im_0_eb_en0;
  wire                s1_bs2_im_0_eb_en1;
  wire                s1_bs2_im_0_eb_sel;
  reg        [19:0]   s1_bs2_im_0_eb_r0;
  reg        [19:0]   s1_bs2_im_0_eb_r1;
  reg                 s1_rsat2_re_0_eb_valid;
  wire                s1_rsat2_re_0_eb_en;
  reg        [15:0]   s1_rsat2_re_0_eb_r;
  reg                 s1_rsat2_im_0_eb_valid;
  wire                s1_rsat2_im_0_eb_en;
  reg        [15:0]   s1_rsat2_im_0_eb_r;
  reg        [4:0]    s1_bs3_re_0_eb_state;
  reg        [4:0]    s1_bs3_re_0_eb_state_nxt;
  wire                s1_bs3_re_0_eb_en0;
  wire                s1_bs3_re_0_eb_en1;
  wire                s1_bs3_re_0_eb_sel;
  reg        [19:0]   s1_bs3_re_0_eb_r0;
  reg        [19:0]   s1_bs3_re_0_eb_r1;
  reg        [4:0]    s1_bs3_im_0_eb_state;
  reg        [4:0]    s1_bs3_im_0_eb_state_nxt;
  wire                s1_bs3_im_0_eb_en0;
  wire                s1_bs3_im_0_eb_en1;
  wire                s1_bs3_im_0_eb_sel;
  reg        [19:0]   s1_bs3_im_0_eb_r0;
  reg        [19:0]   s1_bs3_im_0_eb_r1;
  reg                 s1_rsat3_re_0_eb_valid;
  wire                s1_rsat3_re_0_eb_en;
  reg        [15:0]   s1_rsat3_re_0_eb_r;
  reg                 s1_rsat3_im_0_eb_valid;
  wire                s1_rsat3_im_0_eb_en;
  reg        [15:0]   s1_rsat3_im_0_eb_r;

  assign _zz_s0_k8_slice_0_1 = k8_funnel_0[15 : 0];
  assign _zz_s0_k8_slice_0 = {{2{_zz_s0_k8_slice_0_1[15]}}, _zz_s0_k8_slice_0_1};
  assign _zz_s0_k8_slice_1_1 = k8_funnel_0[31 : 16];
  assign _zz_s0_k8_slice_1 = {{2{_zz_s0_k8_slice_1_1[15]}}, _zz_s0_k8_slice_1_1};
  assign _zz_s0_k8_slice_2_1 = k8_funnel_0[47 : 32];
  assign _zz_s0_k8_slice_2 = {{2{_zz_s0_k8_slice_2_1[15]}}, _zz_s0_k8_slice_2_1};
  assign _zz_s0_k8_slice_3_1 = k8_funnel_0[63 : 48];
  assign _zz_s0_k8_slice_3 = {{2{_zz_s0_k8_slice_3_1[15]}}, _zz_s0_k8_slice_3_1};
  assign _zz_s0_k8_slice_4_1 = k8_funnel_0[79 : 64];
  assign _zz_s0_k8_slice_4 = {{2{_zz_s0_k8_slice_4_1[15]}}, _zz_s0_k8_slice_4_1};
  assign _zz_s0_k8_slice_5_1 = k8_funnel_0[95 : 80];
  assign _zz_s0_k8_slice_5 = {{2{_zz_s0_k8_slice_5_1[15]}}, _zz_s0_k8_slice_5_1};
  assign _zz_s0_k8_slice_6_1 = k8_funnel_0[111 : 96];
  assign _zz_s0_k8_slice_6 = {{2{_zz_s0_k8_slice_6_1[15]}}, _zz_s0_k8_slice_6_1};
  assign _zz_s0_k8_slice_7_1 = k8_funnel_0[127 : 112];
  assign _zz_s0_k8_slice_7 = {{2{_zz_s0_k8_slice_7_1[15]}}, _zz_s0_k8_slice_7_1};
  assign _zz_s0_k9_slice_0_1 = k9_funnel_0[15 : 0];
  assign _zz_s0_k9_slice_0 = {{2{_zz_s0_k9_slice_0_1[15]}}, _zz_s0_k9_slice_0_1};
  assign _zz_s0_k9_slice_1_1 = k9_funnel_0[31 : 16];
  assign _zz_s0_k9_slice_1 = {{2{_zz_s0_k9_slice_1_1[15]}}, _zz_s0_k9_slice_1_1};
  assign _zz_s0_k9_slice_2_1 = k9_funnel_0[47 : 32];
  assign _zz_s0_k9_slice_2 = {{2{_zz_s0_k9_slice_2_1[15]}}, _zz_s0_k9_slice_2_1};
  assign _zz_s0_k9_slice_3_1 = k9_funnel_0[63 : 48];
  assign _zz_s0_k9_slice_3 = {{2{_zz_s0_k9_slice_3_1[15]}}, _zz_s0_k9_slice_3_1};
  assign _zz_s0_k9_slice_4_1 = k9_funnel_0[79 : 64];
  assign _zz_s0_k9_slice_4 = {{2{_zz_s0_k9_slice_4_1[15]}}, _zz_s0_k9_slice_4_1};
  assign _zz_s0_k9_slice_5_1 = k9_funnel_0[95 : 80];
  assign _zz_s0_k9_slice_5 = {{2{_zz_s0_k9_slice_5_1[15]}}, _zz_s0_k9_slice_5_1};
  assign _zz_s0_k9_slice_6_1 = k9_funnel_0[111 : 96];
  assign _zz_s0_k9_slice_6 = {{2{_zz_s0_k9_slice_6_1[15]}}, _zz_s0_k9_slice_6_1};
  assign _zz_s0_k9_slice_7_1 = k9_funnel_0[127 : 112];
  assign _zz_s0_k9_slice_7 = {{2{_zz_s0_k9_slice_7_1[15]}}, _zz_s0_k9_slice_7_1};
  assign _zz_s0_cmul0_recip_norm_mag = (s0_cmul0_recip_norm_x[15] ? _zz_s0_cmul0_recip_norm_mag_1 : s0_cmul0_recip_norm_x);
  assign _zz_s0_cmul0_recip_norm_mag_1 = (~ s0_cmul0_recip_norm_x);
  assign _zz_s0_cmul0_recip_norm_mag_3 = s0_cmul0_recip_norm_x[15];
  assign _zz_s0_cmul0_recip_norm_mag_2 = {15'd0, _zz_s0_cmul0_recip_norm_mag_3};
  assign _zz_s0_cmul0_recip_norm_xn = (s0_cmul0_recip_norm_mag <<< s0_cmul0_recip_norm_lz);
  assign _zz_s0_cmul0_recip_mul_y0_1 = {1'd0, _zz_s0_cmul0_recip_mul_y0};
  assign _zz_s0_cmul0_recip_mul_t = (_zz_s0_cmul0_recip_mul_y0 * s0_cmul0_recip_mul_y0);
  assign _zz_s0_cmul0_recip_out_r = (s0_cmul0_recip_mul_0[21 : 11] * s0_cmul0_recip_mul_0[10 : 0]);
  assign _zz_s0_cmul0_recip_out_rn_1 = (s0_cmul0_recip_out_r >>> _zz_s0_cmul0_recip_out_rn_2);
  assign _zz_s0_cmul0_recip_out_rn_2 = (5'h06 - _zz_s0_cmul0_recip_out_rn);
  assign _zz_s0_cmul0_recip_out_rn_3 = {4'd0, s0_cmul0_recip_out_r};
  assign _zz_s0_cmul0_recip_out_rn_4 = (_zz_s0_cmul0_recip_out_rn - 5'h06);
  assign _zz_s0_cmul0_recip_out_0_nxt = (s0_cmul0_recip_mul_0[28] ? _zz_s0_cmul0_recip_out_0_nxt_1 : s0_cmul0_recip_out_rmag);
  assign _zz_s0_cmul0_recip_out_0_nxt_1 = (- s0_cmul0_recip_out_rmag);
  assign _zz_s0_cmul1_recip_norm_mag = (s0_cmul1_recip_norm_x[15] ? _zz_s0_cmul1_recip_norm_mag_1 : s0_cmul1_recip_norm_x);
  assign _zz_s0_cmul1_recip_norm_mag_1 = (~ s0_cmul1_recip_norm_x);
  assign _zz_s0_cmul1_recip_norm_mag_3 = s0_cmul1_recip_norm_x[15];
  assign _zz_s0_cmul1_recip_norm_mag_2 = {15'd0, _zz_s0_cmul1_recip_norm_mag_3};
  assign _zz_s0_cmul1_recip_norm_xn = (s0_cmul1_recip_norm_mag <<< s0_cmul1_recip_norm_lz);
  assign _zz_s0_cmul1_recip_mul_y0_1 = {1'd0, _zz_s0_cmul1_recip_mul_y0};
  assign _zz_s0_cmul1_recip_mul_t = (_zz_s0_cmul1_recip_mul_y0 * s0_cmul1_recip_mul_y0);
  assign _zz_s0_cmul1_recip_out_r = (s0_cmul1_recip_mul_0[21 : 11] * s0_cmul1_recip_mul_0[10 : 0]);
  assign _zz_s0_cmul1_recip_out_rn_1 = (s0_cmul1_recip_out_r >>> _zz_s0_cmul1_recip_out_rn_2);
  assign _zz_s0_cmul1_recip_out_rn_2 = (5'h06 - _zz_s0_cmul1_recip_out_rn);
  assign _zz_s0_cmul1_recip_out_rn_3 = {4'd0, s0_cmul1_recip_out_r};
  assign _zz_s0_cmul1_recip_out_rn_4 = (_zz_s0_cmul1_recip_out_rn - 5'h06);
  assign _zz_s0_cmul1_recip_out_0_nxt = (s0_cmul1_recip_mul_0[28] ? _zz_s0_cmul1_recip_out_0_nxt_1 : s0_cmul1_recip_out_rmag);
  assign _zz_s0_cmul1_recip_out_0_nxt_1 = (- s0_cmul1_recip_out_rmag);
  assign _zz_s0_cmul2_recip_norm_mag = (s0_cmul2_recip_norm_x[15] ? _zz_s0_cmul2_recip_norm_mag_1 : s0_cmul2_recip_norm_x);
  assign _zz_s0_cmul2_recip_norm_mag_1 = (~ s0_cmul2_recip_norm_x);
  assign _zz_s0_cmul2_recip_norm_mag_3 = s0_cmul2_recip_norm_x[15];
  assign _zz_s0_cmul2_recip_norm_mag_2 = {15'd0, _zz_s0_cmul2_recip_norm_mag_3};
  assign _zz_s0_cmul2_recip_norm_xn = (s0_cmul2_recip_norm_mag <<< s0_cmul2_recip_norm_lz);
  assign _zz_s0_cmul2_recip_mul_y0_1 = {1'd0, _zz_s0_cmul2_recip_mul_y0};
  assign _zz_s0_cmul2_recip_mul_t = (_zz_s0_cmul2_recip_mul_y0 * s0_cmul2_recip_mul_y0);
  assign _zz_s0_cmul2_recip_out_r = (s0_cmul2_recip_mul_0[21 : 11] * s0_cmul2_recip_mul_0[10 : 0]);
  assign _zz_s0_cmul2_recip_out_rn_1 = (s0_cmul2_recip_out_r >>> _zz_s0_cmul2_recip_out_rn_2);
  assign _zz_s0_cmul2_recip_out_rn_2 = (5'h06 - _zz_s0_cmul2_recip_out_rn);
  assign _zz_s0_cmul2_recip_out_rn_3 = {4'd0, s0_cmul2_recip_out_r};
  assign _zz_s0_cmul2_recip_out_rn_4 = (_zz_s0_cmul2_recip_out_rn - 5'h06);
  assign _zz_s0_cmul2_recip_out_0_nxt = (s0_cmul2_recip_mul_0[28] ? _zz_s0_cmul2_recip_out_0_nxt_1 : s0_cmul2_recip_out_rmag);
  assign _zz_s0_cmul2_recip_out_0_nxt_1 = (- s0_cmul2_recip_out_rmag);
  assign _zz_s0_cmul3_recip_norm_mag = (s0_cmul3_recip_norm_x[15] ? _zz_s0_cmul3_recip_norm_mag_1 : s0_cmul3_recip_norm_x);
  assign _zz_s0_cmul3_recip_norm_mag_1 = (~ s0_cmul3_recip_norm_x);
  assign _zz_s0_cmul3_recip_norm_mag_3 = s0_cmul3_recip_norm_x[15];
  assign _zz_s0_cmul3_recip_norm_mag_2 = {15'd0, _zz_s0_cmul3_recip_norm_mag_3};
  assign _zz_s0_cmul3_recip_norm_xn = (s0_cmul3_recip_norm_mag <<< s0_cmul3_recip_norm_lz);
  assign _zz_s0_cmul3_recip_mul_y0_1 = {1'd0, _zz_s0_cmul3_recip_mul_y0};
  assign _zz_s0_cmul3_recip_mul_t = (_zz_s0_cmul3_recip_mul_y0 * s0_cmul3_recip_mul_y0);
  assign _zz_s0_cmul3_recip_out_r = (s0_cmul3_recip_mul_0[21 : 11] * s0_cmul3_recip_mul_0[10 : 0]);
  assign _zz_s0_cmul3_recip_out_rn_1 = (s0_cmul3_recip_out_r >>> _zz_s0_cmul3_recip_out_rn_2);
  assign _zz_s0_cmul3_recip_out_rn_2 = (5'h06 - _zz_s0_cmul3_recip_out_rn);
  assign _zz_s0_cmul3_recip_out_rn_3 = {4'd0, s0_cmul3_recip_out_r};
  assign _zz_s0_cmul3_recip_out_rn_4 = (_zz_s0_cmul3_recip_out_rn - 5'h06);
  assign _zz_s0_cmul3_recip_out_0_nxt = (s0_cmul3_recip_mul_0[28] ? _zz_s0_cmul3_recip_out_0_nxt_1 : s0_cmul3_recip_out_rmag);
  assign _zz_s0_cmul3_recip_out_0_nxt_1 = (- s0_cmul3_recip_out_rmag);
  assign _zz_s1_k8_slice_0_1 = k8_funnel_1[15 : 0];
  assign _zz_s1_k8_slice_0 = {{2{_zz_s1_k8_slice_0_1[15]}}, _zz_s1_k8_slice_0_1};
  assign _zz_s1_k8_slice_1_1 = k8_funnel_1[31 : 16];
  assign _zz_s1_k8_slice_1 = {{2{_zz_s1_k8_slice_1_1[15]}}, _zz_s1_k8_slice_1_1};
  assign _zz_s1_k8_slice_2_1 = k8_funnel_1[47 : 32];
  assign _zz_s1_k8_slice_2 = {{2{_zz_s1_k8_slice_2_1[15]}}, _zz_s1_k8_slice_2_1};
  assign _zz_s1_k8_slice_3_1 = k8_funnel_1[63 : 48];
  assign _zz_s1_k8_slice_3 = {{2{_zz_s1_k8_slice_3_1[15]}}, _zz_s1_k8_slice_3_1};
  assign _zz_s1_k8_slice_4_1 = k8_funnel_1[79 : 64];
  assign _zz_s1_k8_slice_4 = {{2{_zz_s1_k8_slice_4_1[15]}}, _zz_s1_k8_slice_4_1};
  assign _zz_s1_k8_slice_5_1 = k8_funnel_1[95 : 80];
  assign _zz_s1_k8_slice_5 = {{2{_zz_s1_k8_slice_5_1[15]}}, _zz_s1_k8_slice_5_1};
  assign _zz_s1_k8_slice_6_1 = k8_funnel_1[111 : 96];
  assign _zz_s1_k8_slice_6 = {{2{_zz_s1_k8_slice_6_1[15]}}, _zz_s1_k8_slice_6_1};
  assign _zz_s1_k8_slice_7_1 = k8_funnel_1[127 : 112];
  assign _zz_s1_k8_slice_7 = {{2{_zz_s1_k8_slice_7_1[15]}}, _zz_s1_k8_slice_7_1};
  assign _zz_s1_k9_slice_0_1 = k9_funnel_1[15 : 0];
  assign _zz_s1_k9_slice_0 = {{2{_zz_s1_k9_slice_0_1[15]}}, _zz_s1_k9_slice_0_1};
  assign _zz_s1_k9_slice_1_1 = k9_funnel_1[31 : 16];
  assign _zz_s1_k9_slice_1 = {{2{_zz_s1_k9_slice_1_1[15]}}, _zz_s1_k9_slice_1_1};
  assign _zz_s1_k9_slice_2_1 = k9_funnel_1[47 : 32];
  assign _zz_s1_k9_slice_2 = {{2{_zz_s1_k9_slice_2_1[15]}}, _zz_s1_k9_slice_2_1};
  assign _zz_s1_k9_slice_3_1 = k9_funnel_1[63 : 48];
  assign _zz_s1_k9_slice_3 = {{2{_zz_s1_k9_slice_3_1[15]}}, _zz_s1_k9_slice_3_1};
  assign _zz_s1_k9_slice_4_1 = k9_funnel_1[79 : 64];
  assign _zz_s1_k9_slice_4 = {{2{_zz_s1_k9_slice_4_1[15]}}, _zz_s1_k9_slice_4_1};
  assign _zz_s1_k9_slice_5_1 = k9_funnel_1[95 : 80];
  assign _zz_s1_k9_slice_5 = {{2{_zz_s1_k9_slice_5_1[15]}}, _zz_s1_k9_slice_5_1};
  assign _zz_s1_k9_slice_6_1 = k9_funnel_1[111 : 96];
  assign _zz_s1_k9_slice_6 = {{2{_zz_s1_k9_slice_6_1[15]}}, _zz_s1_k9_slice_6_1};
  assign _zz_s1_k9_slice_7_1 = k9_funnel_1[127 : 112];
  assign _zz_s1_k9_slice_7 = {{2{_zz_s1_k9_slice_7_1[15]}}, _zz_s1_k9_slice_7_1};
  assign _zz_s1_cmul0_recip_norm_mag = (s1_cmul0_recip_norm_x[15] ? _zz_s1_cmul0_recip_norm_mag_1 : s1_cmul0_recip_norm_x);
  assign _zz_s1_cmul0_recip_norm_mag_1 = (~ s1_cmul0_recip_norm_x);
  assign _zz_s1_cmul0_recip_norm_mag_3 = s1_cmul0_recip_norm_x[15];
  assign _zz_s1_cmul0_recip_norm_mag_2 = {15'd0, _zz_s1_cmul0_recip_norm_mag_3};
  assign _zz_s1_cmul0_recip_norm_xn = (s1_cmul0_recip_norm_mag <<< s1_cmul0_recip_norm_lz);
  assign _zz_s1_cmul0_recip_mul_y0_1 = {1'd0, _zz_s1_cmul0_recip_mul_y0};
  assign _zz_s1_cmul0_recip_mul_t = (_zz_s1_cmul0_recip_mul_y0 * s1_cmul0_recip_mul_y0);
  assign _zz_s1_cmul0_recip_out_r = (s1_cmul0_recip_mul_0[21 : 11] * s1_cmul0_recip_mul_0[10 : 0]);
  assign _zz_s1_cmul0_recip_out_rn_1 = (s1_cmul0_recip_out_r >>> _zz_s1_cmul0_recip_out_rn_2);
  assign _zz_s1_cmul0_recip_out_rn_2 = (5'h06 - _zz_s1_cmul0_recip_out_rn);
  assign _zz_s1_cmul0_recip_out_rn_3 = {4'd0, s1_cmul0_recip_out_r};
  assign _zz_s1_cmul0_recip_out_rn_4 = (_zz_s1_cmul0_recip_out_rn - 5'h06);
  assign _zz_s1_cmul0_recip_out_0_nxt = (s1_cmul0_recip_mul_0[28] ? _zz_s1_cmul0_recip_out_0_nxt_1 : s1_cmul0_recip_out_rmag);
  assign _zz_s1_cmul0_recip_out_0_nxt_1 = (- s1_cmul0_recip_out_rmag);
  assign _zz_s1_cmul1_recip_norm_mag = (s1_cmul1_recip_norm_x[15] ? _zz_s1_cmul1_recip_norm_mag_1 : s1_cmul1_recip_norm_x);
  assign _zz_s1_cmul1_recip_norm_mag_1 = (~ s1_cmul1_recip_norm_x);
  assign _zz_s1_cmul1_recip_norm_mag_3 = s1_cmul1_recip_norm_x[15];
  assign _zz_s1_cmul1_recip_norm_mag_2 = {15'd0, _zz_s1_cmul1_recip_norm_mag_3};
  assign _zz_s1_cmul1_recip_norm_xn = (s1_cmul1_recip_norm_mag <<< s1_cmul1_recip_norm_lz);
  assign _zz_s1_cmul1_recip_mul_y0_1 = {1'd0, _zz_s1_cmul1_recip_mul_y0};
  assign _zz_s1_cmul1_recip_mul_t = (_zz_s1_cmul1_recip_mul_y0 * s1_cmul1_recip_mul_y0);
  assign _zz_s1_cmul1_recip_out_r = (s1_cmul1_recip_mul_0[21 : 11] * s1_cmul1_recip_mul_0[10 : 0]);
  assign _zz_s1_cmul1_recip_out_rn_1 = (s1_cmul1_recip_out_r >>> _zz_s1_cmul1_recip_out_rn_2);
  assign _zz_s1_cmul1_recip_out_rn_2 = (5'h06 - _zz_s1_cmul1_recip_out_rn);
  assign _zz_s1_cmul1_recip_out_rn_3 = {4'd0, s1_cmul1_recip_out_r};
  assign _zz_s1_cmul1_recip_out_rn_4 = (_zz_s1_cmul1_recip_out_rn - 5'h06);
  assign _zz_s1_cmul1_recip_out_0_nxt = (s1_cmul1_recip_mul_0[28] ? _zz_s1_cmul1_recip_out_0_nxt_1 : s1_cmul1_recip_out_rmag);
  assign _zz_s1_cmul1_recip_out_0_nxt_1 = (- s1_cmul1_recip_out_rmag);
  assign _zz_s1_cmul2_recip_norm_mag = (s1_cmul2_recip_norm_x[15] ? _zz_s1_cmul2_recip_norm_mag_1 : s1_cmul2_recip_norm_x);
  assign _zz_s1_cmul2_recip_norm_mag_1 = (~ s1_cmul2_recip_norm_x);
  assign _zz_s1_cmul2_recip_norm_mag_3 = s1_cmul2_recip_norm_x[15];
  assign _zz_s1_cmul2_recip_norm_mag_2 = {15'd0, _zz_s1_cmul2_recip_norm_mag_3};
  assign _zz_s1_cmul2_recip_norm_xn = (s1_cmul2_recip_norm_mag <<< s1_cmul2_recip_norm_lz);
  assign _zz_s1_cmul2_recip_mul_y0_1 = {1'd0, _zz_s1_cmul2_recip_mul_y0};
  assign _zz_s1_cmul2_recip_mul_t = (_zz_s1_cmul2_recip_mul_y0 * s1_cmul2_recip_mul_y0);
  assign _zz_s1_cmul2_recip_out_r = (s1_cmul2_recip_mul_0[21 : 11] * s1_cmul2_recip_mul_0[10 : 0]);
  assign _zz_s1_cmul2_recip_out_rn_1 = (s1_cmul2_recip_out_r >>> _zz_s1_cmul2_recip_out_rn_2);
  assign _zz_s1_cmul2_recip_out_rn_2 = (5'h06 - _zz_s1_cmul2_recip_out_rn);
  assign _zz_s1_cmul2_recip_out_rn_3 = {4'd0, s1_cmul2_recip_out_r};
  assign _zz_s1_cmul2_recip_out_rn_4 = (_zz_s1_cmul2_recip_out_rn - 5'h06);
  assign _zz_s1_cmul2_recip_out_0_nxt = (s1_cmul2_recip_mul_0[28] ? _zz_s1_cmul2_recip_out_0_nxt_1 : s1_cmul2_recip_out_rmag);
  assign _zz_s1_cmul2_recip_out_0_nxt_1 = (- s1_cmul2_recip_out_rmag);
  assign _zz_s1_cmul3_recip_norm_mag = (s1_cmul3_recip_norm_x[15] ? _zz_s1_cmul3_recip_norm_mag_1 : s1_cmul3_recip_norm_x);
  assign _zz_s1_cmul3_recip_norm_mag_1 = (~ s1_cmul3_recip_norm_x);
  assign _zz_s1_cmul3_recip_norm_mag_3 = s1_cmul3_recip_norm_x[15];
  assign _zz_s1_cmul3_recip_norm_mag_2 = {15'd0, _zz_s1_cmul3_recip_norm_mag_3};
  assign _zz_s1_cmul3_recip_norm_xn = (s1_cmul3_recip_norm_mag <<< s1_cmul3_recip_norm_lz);
  assign _zz_s1_cmul3_recip_mul_y0_1 = {1'd0, _zz_s1_cmul3_recip_mul_y0};
  assign _zz_s1_cmul3_recip_mul_t = (_zz_s1_cmul3_recip_mul_y0 * s1_cmul3_recip_mul_y0);
  assign _zz_s1_cmul3_recip_out_r = (s1_cmul3_recip_mul_0[21 : 11] * s1_cmul3_recip_mul_0[10 : 0]);
  assign _zz_s1_cmul3_recip_out_rn_1 = (s1_cmul3_recip_out_r >>> _zz_s1_cmul3_recip_out_rn_2);
  assign _zz_s1_cmul3_recip_out_rn_2 = (5'h06 - _zz_s1_cmul3_recip_out_rn);
  assign _zz_s1_cmul3_recip_out_rn_3 = {4'd0, s1_cmul3_recip_out_r};
  assign _zz_s1_cmul3_recip_out_rn_4 = (_zz_s1_cmul3_recip_out_rn - 5'h06);
  assign _zz_s1_cmul3_recip_out_0_nxt = (s1_cmul3_recip_mul_0[28] ? _zz_s1_cmul3_recip_out_0_nxt_1 : s1_cmul3_recip_out_rmag);
  assign _zz_s1_cmul3_recip_out_0_nxt_1 = (- s1_cmul3_recip_out_rmag);
  assign _zz_s0_r4_a0_re_0_nxt = ($signed(_zz_s0_r4_a0_re_0_nxt_1) + $signed(_zz_s0_r4_a0_re_0_nxt_2));
  assign _zz_s0_r4_a0_re_0_nxt_1 = s0_cmul0_mas_re_0;
  assign _zz_s0_r4_a0_re_0_nxt_2 = s0_cmul2_mas_re_0;
  assign _zz_s0_r4_a0_im_0_nxt = ($signed(_zz_s0_r4_a0_im_0_nxt_1) + $signed(_zz_s0_r4_a0_im_0_nxt_2));
  assign _zz_s0_r4_a0_im_0_nxt_1 = s0_cmul0_mas_im_0;
  assign _zz_s0_r4_a0_im_0_nxt_2 = s0_cmul2_mas_im_0;
  assign _zz_s0_r4_a1_re_0_nxt = ($signed(_zz_s0_r4_a1_re_0_nxt_1) + $signed(_zz_s0_r4_a1_re_0_nxt_2));
  assign _zz_s0_r4_a1_re_0_nxt_1 = s0_cmul1_mas_re_0;
  assign _zz_s0_r4_a1_re_0_nxt_2 = s0_cmul3_mas_re_0;
  assign _zz_s0_r4_a1_im_0_nxt = ($signed(_zz_s0_r4_a1_im_0_nxt_1) + $signed(_zz_s0_r4_a1_im_0_nxt_2));
  assign _zz_s0_r4_a1_im_0_nxt_1 = s0_cmul1_mas_im_0;
  assign _zz_s0_r4_a1_im_0_nxt_2 = s0_cmul3_mas_im_0;
  assign _zz_s0_r4_a2_re_0_nxt = ($signed(_zz_s0_r4_a2_re_0_nxt_1) - $signed(_zz_s0_r4_a2_re_0_nxt_2));
  assign _zz_s0_r4_a2_re_0_nxt_1 = s0_cmul0_mas_re_0;
  assign _zz_s0_r4_a2_re_0_nxt_2 = s0_cmul2_mas_re_0;
  assign _zz_s0_r4_a2_im_0_nxt = ($signed(_zz_s0_r4_a2_im_0_nxt_1) - $signed(_zz_s0_r4_a2_im_0_nxt_2));
  assign _zz_s0_r4_a2_im_0_nxt_1 = s0_cmul0_mas_im_0;
  assign _zz_s0_r4_a2_im_0_nxt_2 = s0_cmul2_mas_im_0;
  assign _zz_s0_r4_a3_re_0_nxt = ($signed(_zz_s0_r4_a3_re_0_nxt_1) - $signed(_zz_s0_r4_a3_re_0_nxt_2));
  assign _zz_s0_r4_a3_re_0_nxt_1 = s0_cmul1_mas_re_0;
  assign _zz_s0_r4_a3_re_0_nxt_2 = s0_cmul3_mas_re_0;
  assign _zz_s0_r4_a3_im_0_nxt = ($signed(_zz_s0_r4_a3_im_0_nxt_1) - $signed(_zz_s0_r4_a3_im_0_nxt_2));
  assign _zz_s0_r4_a3_im_0_nxt_1 = s0_cmul1_mas_im_0;
  assign _zz_s0_r4_a3_im_0_nxt_2 = s0_cmul3_mas_im_0;
  assign _zz_s0_r4_c0_re_0 = ($signed(_zz_s0_r4_c0_re_0_1) + $signed(_zz_s0_r4_c0_re_0_2));
  assign _zz_s0_r4_c0_re_0_1 = s0_r4_a0_re_0;
  assign _zz_s0_r4_c0_re_0_2 = s0_r4_a1_re_0;
  assign _zz_s0_r4_c0_im_0 = ($signed(_zz_s0_r4_c0_im_0_1) + $signed(_zz_s0_r4_c0_im_0_2));
  assign _zz_s0_r4_c0_im_0_1 = s0_r4_a0_im_0;
  assign _zz_s0_r4_c0_im_0_2 = s0_r4_a1_im_0;
  assign _zz_s0_r4_c1_re_0 = ($signed(_zz_s0_r4_c1_re_0_1) + $signed(_zz_s0_r4_c1_re_0_2));
  assign _zz_s0_r4_c1_re_0_1 = s0_r4_a2_re_0;
  assign _zz_s0_r4_c1_re_0_2 = s0_r4_a3_im_0;
  assign _zz_s0_r4_c1_im_0 = ($signed(_zz_s0_r4_c1_im_0_1) - $signed(_zz_s0_r4_c1_im_0_2));
  assign _zz_s0_r4_c1_im_0_1 = s0_r4_a2_im_0;
  assign _zz_s0_r4_c1_im_0_2 = s0_r4_a3_re_0;
  assign _zz_s0_r4_c2_re_0 = ($signed(_zz_s0_r4_c2_re_0_1) - $signed(_zz_s0_r4_c2_re_0_2));
  assign _zz_s0_r4_c2_re_0_1 = s0_r4_a0_re_0;
  assign _zz_s0_r4_c2_re_0_2 = s0_r4_a1_re_0;
  assign _zz_s0_r4_c2_im_0 = ($signed(_zz_s0_r4_c2_im_0_1) - $signed(_zz_s0_r4_c2_im_0_2));
  assign _zz_s0_r4_c2_im_0_1 = s0_r4_a0_im_0;
  assign _zz_s0_r4_c2_im_0_2 = s0_r4_a1_im_0;
  assign _zz_s0_r4_c3_re_0 = ($signed(_zz_s0_r4_c3_re_0_1) - $signed(_zz_s0_r4_c3_re_0_2));
  assign _zz_s0_r4_c3_re_0_1 = s0_r4_a2_re_0;
  assign _zz_s0_r4_c3_re_0_2 = s0_r4_a3_im_0;
  assign _zz_s0_r4_c3_im_0 = ($signed(_zz_s0_r4_c3_im_0_1) + $signed(_zz_s0_r4_c3_im_0_2));
  assign _zz_s0_r4_c3_im_0_1 = s0_r4_a2_im_0;
  assign _zz_s0_r4_c3_im_0_2 = s0_r4_a3_re_0;
  assign _zz_s1_r4_a0_re_0_nxt = ($signed(_zz_s1_r4_a0_re_0_nxt_1) + $signed(_zz_s1_r4_a0_re_0_nxt_2));
  assign _zz_s1_r4_a0_re_0_nxt_1 = s1_cmul0_mas_re_0;
  assign _zz_s1_r4_a0_re_0_nxt_2 = s1_cmul2_mas_re_0;
  assign _zz_s1_r4_a0_im_0_nxt = ($signed(_zz_s1_r4_a0_im_0_nxt_1) + $signed(_zz_s1_r4_a0_im_0_nxt_2));
  assign _zz_s1_r4_a0_im_0_nxt_1 = s1_cmul0_mas_im_0;
  assign _zz_s1_r4_a0_im_0_nxt_2 = s1_cmul2_mas_im_0;
  assign _zz_s1_r4_a1_re_0_nxt = ($signed(_zz_s1_r4_a1_re_0_nxt_1) + $signed(_zz_s1_r4_a1_re_0_nxt_2));
  assign _zz_s1_r4_a1_re_0_nxt_1 = s1_cmul1_mas_re_0;
  assign _zz_s1_r4_a1_re_0_nxt_2 = s1_cmul3_mas_re_0;
  assign _zz_s1_r4_a1_im_0_nxt = ($signed(_zz_s1_r4_a1_im_0_nxt_1) + $signed(_zz_s1_r4_a1_im_0_nxt_2));
  assign _zz_s1_r4_a1_im_0_nxt_1 = s1_cmul1_mas_im_0;
  assign _zz_s1_r4_a1_im_0_nxt_2 = s1_cmul3_mas_im_0;
  assign _zz_s1_r4_a2_re_0_nxt = ($signed(_zz_s1_r4_a2_re_0_nxt_1) - $signed(_zz_s1_r4_a2_re_0_nxt_2));
  assign _zz_s1_r4_a2_re_0_nxt_1 = s1_cmul0_mas_re_0;
  assign _zz_s1_r4_a2_re_0_nxt_2 = s1_cmul2_mas_re_0;
  assign _zz_s1_r4_a2_im_0_nxt = ($signed(_zz_s1_r4_a2_im_0_nxt_1) - $signed(_zz_s1_r4_a2_im_0_nxt_2));
  assign _zz_s1_r4_a2_im_0_nxt_1 = s1_cmul0_mas_im_0;
  assign _zz_s1_r4_a2_im_0_nxt_2 = s1_cmul2_mas_im_0;
  assign _zz_s1_r4_a3_re_0_nxt = ($signed(_zz_s1_r4_a3_re_0_nxt_1) - $signed(_zz_s1_r4_a3_re_0_nxt_2));
  assign _zz_s1_r4_a3_re_0_nxt_1 = s1_cmul1_mas_re_0;
  assign _zz_s1_r4_a3_re_0_nxt_2 = s1_cmul3_mas_re_0;
  assign _zz_s1_r4_a3_im_0_nxt = ($signed(_zz_s1_r4_a3_im_0_nxt_1) - $signed(_zz_s1_r4_a3_im_0_nxt_2));
  assign _zz_s1_r4_a3_im_0_nxt_1 = s1_cmul1_mas_im_0;
  assign _zz_s1_r4_a3_im_0_nxt_2 = s1_cmul3_mas_im_0;
  assign _zz_s1_r4_c0_re_0 = ($signed(_zz_s1_r4_c0_re_0_1) + $signed(_zz_s1_r4_c0_re_0_2));
  assign _zz_s1_r4_c0_re_0_1 = s1_r4_a0_re_0;
  assign _zz_s1_r4_c0_re_0_2 = s1_r4_a1_re_0;
  assign _zz_s1_r4_c0_im_0 = ($signed(_zz_s1_r4_c0_im_0_1) + $signed(_zz_s1_r4_c0_im_0_2));
  assign _zz_s1_r4_c0_im_0_1 = s1_r4_a0_im_0;
  assign _zz_s1_r4_c0_im_0_2 = s1_r4_a1_im_0;
  assign _zz_s1_r4_c1_re_0 = ($signed(_zz_s1_r4_c1_re_0_1) + $signed(_zz_s1_r4_c1_re_0_2));
  assign _zz_s1_r4_c1_re_0_1 = s1_r4_a2_re_0;
  assign _zz_s1_r4_c1_re_0_2 = s1_r4_a3_im_0;
  assign _zz_s1_r4_c1_im_0 = ($signed(_zz_s1_r4_c1_im_0_1) - $signed(_zz_s1_r4_c1_im_0_2));
  assign _zz_s1_r4_c1_im_0_1 = s1_r4_a2_im_0;
  assign _zz_s1_r4_c1_im_0_2 = s1_r4_a3_re_0;
  assign _zz_s1_r4_c2_re_0 = ($signed(_zz_s1_r4_c2_re_0_1) - $signed(_zz_s1_r4_c2_re_0_2));
  assign _zz_s1_r4_c2_re_0_1 = s1_r4_a0_re_0;
  assign _zz_s1_r4_c2_re_0_2 = s1_r4_a1_re_0;
  assign _zz_s1_r4_c2_im_0 = ($signed(_zz_s1_r4_c2_im_0_1) - $signed(_zz_s1_r4_c2_im_0_2));
  assign _zz_s1_r4_c2_im_0_1 = s1_r4_a0_im_0;
  assign _zz_s1_r4_c2_im_0_2 = s1_r4_a1_im_0;
  assign _zz_s1_r4_c3_re_0 = ($signed(_zz_s1_r4_c3_re_0_1) - $signed(_zz_s1_r4_c3_re_0_2));
  assign _zz_s1_r4_c3_re_0_1 = s1_r4_a2_re_0;
  assign _zz_s1_r4_c3_re_0_2 = s1_r4_a3_im_0;
  assign _zz_s1_r4_c3_im_0 = ($signed(_zz_s1_r4_c3_im_0_1) + $signed(_zz_s1_r4_c3_im_0_2));
  assign _zz_s1_r4_c3_im_0_1 = s1_r4_a2_im_0;
  assign _zz_s1_r4_c3_im_0_2 = s1_r4_a3_re_0;
  assign _zz_t_k14_0_to_cfg_ack = ((((((((((((((((_zz_t_k14_0_to_cfg_ack_1 && cfg_i_67_ack_g) && cfg_i_68_ack_g) && cfg_i_69_ack_g) && cfg_i_70_ack_g) && cfg_i_71_ack_g) && cfg_i_72_ack_g) && cfg_i_73_ack_g) && cfg_i_74_ack_g) && cfg_i_75_ack_g) && cfg_i_76_ack_g) && cfg_i_77_ack_g) && cfg_i_78_ack_g) && cfg_i_79_ack_g) && cfg_i_80_ack_g) && cfg_i_81_ack_g) && cfg_i_82_ack_g);
  assign _zz_t_k14_0_to_cfg_ack_1 = ((((((((((((((((_zz_t_k14_0_to_cfg_ack_2 && cfg_i_51_ack_g) && cfg_i_52_ack_g) && cfg_i_53_ack_g) && cfg_i_54_ack_g) && cfg_i_55_ack_g) && cfg_i_56_ack_g) && cfg_i_57_ack_g) && cfg_i_58_ack_g) && cfg_i_59_ack_g) && cfg_i_60_ack_g) && cfg_i_61_ack_g) && cfg_i_62_ack_g) && cfg_i_63_ack_g) && cfg_i_64_ack_g) && cfg_i_65_ack_g) && cfg_i_66_ack_g);
  assign _zz_t_k14_0_to_cfg_ack_2 = ((((((((((((((((_zz_t_k14_0_to_cfg_ack_3 && cfg_i_35_ack_g) && cfg_i_36_ack_g) && cfg_i_37_ack_g) && cfg_i_38_ack_g) && cfg_i_39_ack_g) && cfg_i_40_ack_g) && cfg_i_41_ack_g) && cfg_i_42_ack_g) && cfg_i_43_ack_g) && cfg_i_44_ack_g) && cfg_i_45_ack_g) && cfg_i_46_ack_g) && cfg_i_47_ack_g) && cfg_i_48_ack_g) && cfg_i_49_ack_g) && cfg_i_50_ack_g);
  assign _zz_t_k14_0_to_cfg_ack_3 = ((((((((((((((((_zz_t_k14_0_to_cfg_ack_4 && cfg_i_19_ack_g) && cfg_i_20_ack_g) && cfg_i_21_ack_g) && cfg_i_22_ack_g) && cfg_i_23_ack_g) && cfg_i_24_ack_g) && cfg_i_25_ack_g) && cfg_i_26_ack_g) && cfg_i_27_ack_g) && cfg_i_28_ack_g) && cfg_i_29_ack_g) && cfg_i_30_ack_g) && cfg_i_31_ack_g) && cfg_i_32_ack_g) && cfg_i_33_ack_g) && cfg_i_34_ack_g);
  assign _zz_t_k14_0_to_cfg_ack_4 = ((((((((((((((((_zz_t_k14_0_to_cfg_ack_5 && cfg_i_3_ack_g) && cfg_i_4_ack_g) && cfg_i_5_ack_g) && cfg_i_6_ack_g) && cfg_i_7_ack_g) && cfg_i_8_ack_g) && cfg_i_9_ack_g) && cfg_i_10_ack_g) && cfg_i_11_ack_g) && cfg_i_12_ack_g) && cfg_i_13_ack_g) && cfg_i_14_ack_g) && cfg_i_15_ack_g) && cfg_i_16_ack_g) && cfg_i_17_ack_g) && cfg_i_18_ack_g);
  assign _zz_t_k14_0_to_cfg_ack_5 = ((cfg_i_0_ack_g && cfg_i_1_ack_g) && cfg_i_2_ack_g);
  funnel_dat_2_2 k8_funnel (
    .t_0_dat   (t_k8_0[511:0]           ), //i
    .t_cfg_dat (cfg_k8_funnel[7:0]      ), //i
    .i_0_dat   (k8_funnel_i_0_dat[127:0]), //o
    .i_1_dat   (k8_funnel_i_1_dat[127:0]), //o
    .sel       (k8_funnel_ctrl_sel[7:0] ), //i
    .mode      (k8_funnel_mode[7:0]     ), //o
    .clk       (k8_funnel_clk           ), //i
    .reset_n   (k8_funnel_reset_n       )  //i
  );
  funnel_ctrl_2_2 k8_funnel_ctrl (
    .t_0_req   (k8_funnel_ctrl_t_0_req  ), //i
    .t_0_ack   (k8_funnel_ctrl_t_0_ack  ), //o
    .t_cfg_req (k8_funnel_ctrl_t_cfg_req), //i
    .t_cfg_ack (k8_funnel_ctrl_t_cfg_ack), //o
    .i_0_req   (k8_funnel_ctrl_i_0_req  ), //o
    .i_0_ack   (k8_funnel_ctrl_i_0_ack  ), //i
    .i_1_req   (k8_funnel_ctrl_i_1_req  ), //o
    .i_1_ack   (k8_funnel_ctrl_i_1_ack  ), //i
    .sel       (k8_funnel_ctrl_sel[7:0] ), //o
    .mode      (k8_funnel_mode[7:0]     ), //i
    .clk       (k8_funnel_ctrl_clk      ), //i
    .reset_n   (k8_funnel_ctrl_reset_n  )  //i
  );
  funnel_dat_2_2 k9_funnel (
    .t_0_dat   (t_k9_0[511:0]           ), //i
    .t_cfg_dat (cfg_k9_funnel[7:0]      ), //i
    .i_0_dat   (k9_funnel_i_0_dat[127:0]), //o
    .i_1_dat   (k9_funnel_i_1_dat[127:0]), //o
    .sel       (k9_funnel_ctrl_sel[7:0] ), //i
    .mode      (k9_funnel_mode[7:0]     ), //o
    .clk       (k9_funnel_clk           ), //i
    .reset_n   (k9_funnel_reset_n       )  //i
  );
  funnel_ctrl_2_2 k9_funnel_ctrl (
    .t_0_req   (k9_funnel_ctrl_t_0_req  ), //i
    .t_0_ack   (k9_funnel_ctrl_t_0_ack  ), //o
    .t_cfg_req (k9_funnel_ctrl_t_cfg_req), //i
    .t_cfg_ack (k9_funnel_ctrl_t_cfg_ack), //o
    .i_0_req   (k9_funnel_ctrl_i_0_req  ), //o
    .i_0_ack   (k9_funnel_ctrl_i_0_ack  ), //i
    .i_1_req   (k9_funnel_ctrl_i_1_req  ), //o
    .i_1_ack   (k9_funnel_ctrl_i_1_ack  ), //i
    .sel       (k9_funnel_ctrl_sel[7:0] ), //o
    .mode      (k9_funnel_mode[7:0]     ), //i
    .clk       (k9_funnel_ctrl_clk      ), //i
    .reset_n   (k9_funnel_ctrl_reset_n  )  //i
  );
  defunnel_dat_3_1 k1_defunnel (
    .t_0_dat   (s0_k1_cat_0[127:0]          ), //i
    .t_1_dat   (s1_k1_cat_0[127:0]          ), //i
    .t_cfg_dat (cfg_k1_defunnel[7:0]        ), //i
    .i_0_dat   (k1_defunnel_i_0_dat[511:0]  ), //o
    .enable    (k1_defunnel_ctrl_enable[7:0]), //i
    .mode      (k1_defunnel_mode[7:0]       ), //o
    .clk       (k1_defunnel_clk             ), //i
    .reset_n   (k1_defunnel_reset_n         )  //i
  );
  defunnel_ctrl_3_1 k1_defunnel_ctrl (
    .t_0_req   (k1_defunnel_ctrl_t_0_req    ), //i
    .t_0_ack   (k1_defunnel_ctrl_t_0_ack    ), //o
    .t_1_req   (k1_defunnel_ctrl_t_1_req    ), //i
    .t_1_ack   (k1_defunnel_ctrl_t_1_ack    ), //o
    .t_cfg_req (k1_defunnel_ctrl_t_cfg_req  ), //i
    .t_cfg_ack (k1_defunnel_ctrl_t_cfg_ack  ), //o
    .i_0_req   (k1_defunnel_ctrl_i_0_req    ), //o
    .i_0_ack   (k1_defunnel_ctrl_i_0_ack    ), //i
    .enable    (k1_defunnel_ctrl_enable[7:0]), //o
    .mode      (k1_defunnel_mode[7:0]       ), //i
    .clk       (k1_defunnel_ctrl_clk        ), //i
    .reset_n   (k1_defunnel_ctrl_reset_n    )  //i
  );
  muladdsub s0_cmul0_mas_re (
    .CLK0    (s0_cmul0_mas_re_CLK0     ), //i
    .CE0     (s0_cmul0_mas_re_CE0      ), //i
    .CE1     (s0_cmul0_mas_re_CE1      ), //i
    .CE2     (s0_cmul0_mas_re_CE2      ), //i
    .RST0    (s0_cmul0_mas_re_RST0     ), //i
    .ADDNSUB (s0_cmul0_mas_re_ADDNSUB  ), //i
    .A0      (s0_cmul0_mas_re_A0[17:0] ), //i
    .A1      (s0_cmul0_mas_re_A1[17:0] ), //i
    .B0      (s0_cmul0_mas_re_B0[17:0] ), //i
    .B1      (s0_cmul0_mas_re_B1[17:0] ), //i
    .SUM     (s0_cmul0_mas_re_SUM[35:0])  //o
  );
  muladdsub s0_cmul0_mas_im (
    .CLK0    (s0_cmul0_mas_im_CLK0     ), //i
    .CE0     (s0_cmul0_mas_im_CE0      ), //i
    .CE1     (s0_cmul0_mas_im_CE1      ), //i
    .CE2     (s0_cmul0_mas_im_CE2      ), //i
    .RST0    (s0_cmul0_mas_im_RST0     ), //i
    .ADDNSUB (s0_cmul0_mas_im_ADDNSUB  ), //i
    .A0      (s0_cmul0_mas_im_A0[17:0] ), //i
    .A1      (s0_cmul0_mas_im_A1[17:0] ), //i
    .B0      (s0_cmul0_mas_im_B0[17:0] ), //i
    .B1      (s0_cmul0_mas_im_B1[17:0] ), //i
    .SUM     (s0_cmul0_mas_im_SUM[35:0])  //o
  );
  muladdsub s0_cmul1_mas_re (
    .CLK0    (s0_cmul1_mas_re_CLK0     ), //i
    .CE0     (s0_cmul1_mas_re_CE0      ), //i
    .CE1     (s0_cmul1_mas_re_CE1      ), //i
    .CE2     (s0_cmul1_mas_re_CE2      ), //i
    .RST0    (s0_cmul1_mas_re_RST0     ), //i
    .ADDNSUB (s0_cmul1_mas_re_ADDNSUB  ), //i
    .A0      (s0_cmul1_mas_re_A0[17:0] ), //i
    .A1      (s0_cmul1_mas_re_A1[17:0] ), //i
    .B0      (s0_cmul1_mas_re_B0[17:0] ), //i
    .B1      (s0_cmul1_mas_re_B1[17:0] ), //i
    .SUM     (s0_cmul1_mas_re_SUM[35:0])  //o
  );
  muladdsub s0_cmul1_mas_im (
    .CLK0    (s0_cmul1_mas_im_CLK0     ), //i
    .CE0     (s0_cmul1_mas_im_CE0      ), //i
    .CE1     (s0_cmul1_mas_im_CE1      ), //i
    .CE2     (s0_cmul1_mas_im_CE2      ), //i
    .RST0    (s0_cmul1_mas_im_RST0     ), //i
    .ADDNSUB (s0_cmul1_mas_im_ADDNSUB  ), //i
    .A0      (s0_cmul1_mas_im_A0[17:0] ), //i
    .A1      (s0_cmul1_mas_im_A1[17:0] ), //i
    .B0      (s0_cmul1_mas_im_B0[17:0] ), //i
    .B1      (s0_cmul1_mas_im_B1[17:0] ), //i
    .SUM     (s0_cmul1_mas_im_SUM[35:0])  //o
  );
  muladdsub s0_cmul2_mas_re (
    .CLK0    (s0_cmul2_mas_re_CLK0     ), //i
    .CE0     (s0_cmul2_mas_re_CE0      ), //i
    .CE1     (s0_cmul2_mas_re_CE1      ), //i
    .CE2     (s0_cmul2_mas_re_CE2      ), //i
    .RST0    (s0_cmul2_mas_re_RST0     ), //i
    .ADDNSUB (s0_cmul2_mas_re_ADDNSUB  ), //i
    .A0      (s0_cmul2_mas_re_A0[17:0] ), //i
    .A1      (s0_cmul2_mas_re_A1[17:0] ), //i
    .B0      (s0_cmul2_mas_re_B0[17:0] ), //i
    .B1      (s0_cmul2_mas_re_B1[17:0] ), //i
    .SUM     (s0_cmul2_mas_re_SUM[35:0])  //o
  );
  muladdsub s0_cmul2_mas_im (
    .CLK0    (s0_cmul2_mas_im_CLK0     ), //i
    .CE0     (s0_cmul2_mas_im_CE0      ), //i
    .CE1     (s0_cmul2_mas_im_CE1      ), //i
    .CE2     (s0_cmul2_mas_im_CE2      ), //i
    .RST0    (s0_cmul2_mas_im_RST0     ), //i
    .ADDNSUB (s0_cmul2_mas_im_ADDNSUB  ), //i
    .A0      (s0_cmul2_mas_im_A0[17:0] ), //i
    .A1      (s0_cmul2_mas_im_A1[17:0] ), //i
    .B0      (s0_cmul2_mas_im_B0[17:0] ), //i
    .B1      (s0_cmul2_mas_im_B1[17:0] ), //i
    .SUM     (s0_cmul2_mas_im_SUM[35:0])  //o
  );
  muladdsub s0_cmul3_mas_re (
    .CLK0    (s0_cmul3_mas_re_CLK0     ), //i
    .CE0     (s0_cmul3_mas_re_CE0      ), //i
    .CE1     (s0_cmul3_mas_re_CE1      ), //i
    .CE2     (s0_cmul3_mas_re_CE2      ), //i
    .RST0    (s0_cmul3_mas_re_RST0     ), //i
    .ADDNSUB (s0_cmul3_mas_re_ADDNSUB  ), //i
    .A0      (s0_cmul3_mas_re_A0[17:0] ), //i
    .A1      (s0_cmul3_mas_re_A1[17:0] ), //i
    .B0      (s0_cmul3_mas_re_B0[17:0] ), //i
    .B1      (s0_cmul3_mas_re_B1[17:0] ), //i
    .SUM     (s0_cmul3_mas_re_SUM[35:0])  //o
  );
  muladdsub s0_cmul3_mas_im (
    .CLK0    (s0_cmul3_mas_im_CLK0     ), //i
    .CE0     (s0_cmul3_mas_im_CE0      ), //i
    .CE1     (s0_cmul3_mas_im_CE1      ), //i
    .CE2     (s0_cmul3_mas_im_CE2      ), //i
    .RST0    (s0_cmul3_mas_im_RST0     ), //i
    .ADDNSUB (s0_cmul3_mas_im_ADDNSUB  ), //i
    .A0      (s0_cmul3_mas_im_A0[17:0] ), //i
    .A1      (s0_cmul3_mas_im_A1[17:0] ), //i
    .B0      (s0_cmul3_mas_im_B0[17:0] ), //i
    .B1      (s0_cmul3_mas_im_B1[17:0] ), //i
    .SUM     (s0_cmul3_mas_im_SUM[35:0])  //o
  );
  muladdsub s1_cmul0_mas_re (
    .CLK0    (s1_cmul0_mas_re_CLK0     ), //i
    .CE0     (s1_cmul0_mas_re_CE0      ), //i
    .CE1     (s1_cmul0_mas_re_CE1      ), //i
    .CE2     (s1_cmul0_mas_re_CE2      ), //i
    .RST0    (s1_cmul0_mas_re_RST0     ), //i
    .ADDNSUB (s1_cmul0_mas_re_ADDNSUB  ), //i
    .A0      (s1_cmul0_mas_re_A0[17:0] ), //i
    .A1      (s1_cmul0_mas_re_A1[17:0] ), //i
    .B0      (s1_cmul0_mas_re_B0[17:0] ), //i
    .B1      (s1_cmul0_mas_re_B1[17:0] ), //i
    .SUM     (s1_cmul0_mas_re_SUM[35:0])  //o
  );
  muladdsub s1_cmul0_mas_im (
    .CLK0    (s1_cmul0_mas_im_CLK0     ), //i
    .CE0     (s1_cmul0_mas_im_CE0      ), //i
    .CE1     (s1_cmul0_mas_im_CE1      ), //i
    .CE2     (s1_cmul0_mas_im_CE2      ), //i
    .RST0    (s1_cmul0_mas_im_RST0     ), //i
    .ADDNSUB (s1_cmul0_mas_im_ADDNSUB  ), //i
    .A0      (s1_cmul0_mas_im_A0[17:0] ), //i
    .A1      (s1_cmul0_mas_im_A1[17:0] ), //i
    .B0      (s1_cmul0_mas_im_B0[17:0] ), //i
    .B1      (s1_cmul0_mas_im_B1[17:0] ), //i
    .SUM     (s1_cmul0_mas_im_SUM[35:0])  //o
  );
  muladdsub s1_cmul1_mas_re (
    .CLK0    (s1_cmul1_mas_re_CLK0     ), //i
    .CE0     (s1_cmul1_mas_re_CE0      ), //i
    .CE1     (s1_cmul1_mas_re_CE1      ), //i
    .CE2     (s1_cmul1_mas_re_CE2      ), //i
    .RST0    (s1_cmul1_mas_re_RST0     ), //i
    .ADDNSUB (s1_cmul1_mas_re_ADDNSUB  ), //i
    .A0      (s1_cmul1_mas_re_A0[17:0] ), //i
    .A1      (s1_cmul1_mas_re_A1[17:0] ), //i
    .B0      (s1_cmul1_mas_re_B0[17:0] ), //i
    .B1      (s1_cmul1_mas_re_B1[17:0] ), //i
    .SUM     (s1_cmul1_mas_re_SUM[35:0])  //o
  );
  muladdsub s1_cmul1_mas_im (
    .CLK0    (s1_cmul1_mas_im_CLK0     ), //i
    .CE0     (s1_cmul1_mas_im_CE0      ), //i
    .CE1     (s1_cmul1_mas_im_CE1      ), //i
    .CE2     (s1_cmul1_mas_im_CE2      ), //i
    .RST0    (s1_cmul1_mas_im_RST0     ), //i
    .ADDNSUB (s1_cmul1_mas_im_ADDNSUB  ), //i
    .A0      (s1_cmul1_mas_im_A0[17:0] ), //i
    .A1      (s1_cmul1_mas_im_A1[17:0] ), //i
    .B0      (s1_cmul1_mas_im_B0[17:0] ), //i
    .B1      (s1_cmul1_mas_im_B1[17:0] ), //i
    .SUM     (s1_cmul1_mas_im_SUM[35:0])  //o
  );
  muladdsub s1_cmul2_mas_re (
    .CLK0    (s1_cmul2_mas_re_CLK0     ), //i
    .CE0     (s1_cmul2_mas_re_CE0      ), //i
    .CE1     (s1_cmul2_mas_re_CE1      ), //i
    .CE2     (s1_cmul2_mas_re_CE2      ), //i
    .RST0    (s1_cmul2_mas_re_RST0     ), //i
    .ADDNSUB (s1_cmul2_mas_re_ADDNSUB  ), //i
    .A0      (s1_cmul2_mas_re_A0[17:0] ), //i
    .A1      (s1_cmul2_mas_re_A1[17:0] ), //i
    .B0      (s1_cmul2_mas_re_B0[17:0] ), //i
    .B1      (s1_cmul2_mas_re_B1[17:0] ), //i
    .SUM     (s1_cmul2_mas_re_SUM[35:0])  //o
  );
  muladdsub s1_cmul2_mas_im (
    .CLK0    (s1_cmul2_mas_im_CLK0     ), //i
    .CE0     (s1_cmul2_mas_im_CE0      ), //i
    .CE1     (s1_cmul2_mas_im_CE1      ), //i
    .CE2     (s1_cmul2_mas_im_CE2      ), //i
    .RST0    (s1_cmul2_mas_im_RST0     ), //i
    .ADDNSUB (s1_cmul2_mas_im_ADDNSUB  ), //i
    .A0      (s1_cmul2_mas_im_A0[17:0] ), //i
    .A1      (s1_cmul2_mas_im_A1[17:0] ), //i
    .B0      (s1_cmul2_mas_im_B0[17:0] ), //i
    .B1      (s1_cmul2_mas_im_B1[17:0] ), //i
    .SUM     (s1_cmul2_mas_im_SUM[35:0])  //o
  );
  muladdsub s1_cmul3_mas_re (
    .CLK0    (s1_cmul3_mas_re_CLK0     ), //i
    .CE0     (s1_cmul3_mas_re_CE0      ), //i
    .CE1     (s1_cmul3_mas_re_CE1      ), //i
    .CE2     (s1_cmul3_mas_re_CE2      ), //i
    .RST0    (s1_cmul3_mas_re_RST0     ), //i
    .ADDNSUB (s1_cmul3_mas_re_ADDNSUB  ), //i
    .A0      (s1_cmul3_mas_re_A0[17:0] ), //i
    .A1      (s1_cmul3_mas_re_A1[17:0] ), //i
    .B0      (s1_cmul3_mas_re_B0[17:0] ), //i
    .B1      (s1_cmul3_mas_re_B1[17:0] ), //i
    .SUM     (s1_cmul3_mas_re_SUM[35:0])  //o
  );
  muladdsub s1_cmul3_mas_im (
    .CLK0    (s1_cmul3_mas_im_CLK0     ), //i
    .CE0     (s1_cmul3_mas_im_CE0      ), //i
    .CE1     (s1_cmul3_mas_im_CE1      ), //i
    .CE2     (s1_cmul3_mas_im_CE2      ), //i
    .RST0    (s1_cmul3_mas_im_RST0     ), //i
    .ADDNSUB (s1_cmul3_mas_im_ADDNSUB  ), //i
    .A0      (s1_cmul3_mas_im_A0[17:0] ), //i
    .A1      (s1_cmul3_mas_im_A1[17:0] ), //i
    .B0      (s1_cmul3_mas_im_B0[17:0] ), //i
    .B1      (s1_cmul3_mas_im_B1[17:0] ), //i
    .SUM     (s1_cmul3_mas_im_SUM[35:0])  //o
  );
  bs_dat_2_1 s0_bs0_re (
    .t_0_dat   (s0_r4_byp0_re_0[35:0]  ), //i
    .t_cfg_dat (cfg_s0_bs0_re[7:0]     ), //i
    .i_0_dat   (s0_bs0_re_i_0_dat[19:0]), //o
    .clk       (s0_bs0_re_clk          ), //i
    .reset_n   (s0_bs0_re_reset_n      )  //i
  );
  bs_dat_2_1 s0_bs0_im (
    .t_0_dat   (s0_r4_byp0_im_0[35:0]  ), //i
    .t_cfg_dat (cfg_s0_bs0_im[7:0]     ), //i
    .i_0_dat   (s0_bs0_im_i_0_dat[19:0]), //o
    .clk       (s0_bs0_im_clk          ), //i
    .reset_n   (s0_bs0_im_reset_n      )  //i
  );
  round_sat_dat_1_1 s0_rsat0_re (
    .t_0_dat (s0_bs0_re_0[19:0]        ), //i
    .i_0_dat (s0_rsat0_re_i_0_dat[15:0]), //o
    .clk     (s0_rsat0_re_clk          ), //i
    .reset_n (s0_rsat0_re_reset_n      )  //i
  );
  round_sat_dat_1_1 s0_rsat0_im (
    .t_0_dat (s0_bs0_im_0[19:0]        ), //i
    .i_0_dat (s0_rsat0_im_i_0_dat[15:0]), //o
    .clk     (s0_rsat0_im_clk          ), //i
    .reset_n (s0_rsat0_im_reset_n      )  //i
  );
  bs_dat_2_1 s0_bs1_re (
    .t_0_dat   (s0_r4_byp1_re_0[35:0]  ), //i
    .t_cfg_dat (cfg_s0_bs1_re[7:0]     ), //i
    .i_0_dat   (s0_bs1_re_i_0_dat[19:0]), //o
    .clk       (s0_bs1_re_clk          ), //i
    .reset_n   (s0_bs1_re_reset_n      )  //i
  );
  bs_dat_2_1 s0_bs1_im (
    .t_0_dat   (s0_r4_byp1_im_0[35:0]  ), //i
    .t_cfg_dat (cfg_s0_bs1_im[7:0]     ), //i
    .i_0_dat   (s0_bs1_im_i_0_dat[19:0]), //o
    .clk       (s0_bs1_im_clk          ), //i
    .reset_n   (s0_bs1_im_reset_n      )  //i
  );
  round_sat_dat_1_1 s0_rsat1_re (
    .t_0_dat (s0_bs1_re_0[19:0]        ), //i
    .i_0_dat (s0_rsat1_re_i_0_dat[15:0]), //o
    .clk     (s0_rsat1_re_clk          ), //i
    .reset_n (s0_rsat1_re_reset_n      )  //i
  );
  round_sat_dat_1_1 s0_rsat1_im (
    .t_0_dat (s0_bs1_im_0[19:0]        ), //i
    .i_0_dat (s0_rsat1_im_i_0_dat[15:0]), //o
    .clk     (s0_rsat1_im_clk          ), //i
    .reset_n (s0_rsat1_im_reset_n      )  //i
  );
  bs_dat_2_1 s0_bs2_re (
    .t_0_dat   (s0_r4_byp2_re_0[35:0]  ), //i
    .t_cfg_dat (cfg_s0_bs2_re[7:0]     ), //i
    .i_0_dat   (s0_bs2_re_i_0_dat[19:0]), //o
    .clk       (s0_bs2_re_clk          ), //i
    .reset_n   (s0_bs2_re_reset_n      )  //i
  );
  bs_dat_2_1 s0_bs2_im (
    .t_0_dat   (s0_r4_byp2_im_0[35:0]  ), //i
    .t_cfg_dat (cfg_s0_bs2_im[7:0]     ), //i
    .i_0_dat   (s0_bs2_im_i_0_dat[19:0]), //o
    .clk       (s0_bs2_im_clk          ), //i
    .reset_n   (s0_bs2_im_reset_n      )  //i
  );
  round_sat_dat_1_1 s0_rsat2_re (
    .t_0_dat (s0_bs2_re_0[19:0]        ), //i
    .i_0_dat (s0_rsat2_re_i_0_dat[15:0]), //o
    .clk     (s0_rsat2_re_clk          ), //i
    .reset_n (s0_rsat2_re_reset_n      )  //i
  );
  round_sat_dat_1_1 s0_rsat2_im (
    .t_0_dat (s0_bs2_im_0[19:0]        ), //i
    .i_0_dat (s0_rsat2_im_i_0_dat[15:0]), //o
    .clk     (s0_rsat2_im_clk          ), //i
    .reset_n (s0_rsat2_im_reset_n      )  //i
  );
  bs_dat_2_1 s0_bs3_re (
    .t_0_dat   (s0_r4_byp3_re_0[35:0]  ), //i
    .t_cfg_dat (cfg_s0_bs3_re[7:0]     ), //i
    .i_0_dat   (s0_bs3_re_i_0_dat[19:0]), //o
    .clk       (s0_bs3_re_clk          ), //i
    .reset_n   (s0_bs3_re_reset_n      )  //i
  );
  bs_dat_2_1 s0_bs3_im (
    .t_0_dat   (s0_r4_byp3_im_0[35:0]  ), //i
    .t_cfg_dat (cfg_s0_bs3_im[7:0]     ), //i
    .i_0_dat   (s0_bs3_im_i_0_dat[19:0]), //o
    .clk       (s0_bs3_im_clk          ), //i
    .reset_n   (s0_bs3_im_reset_n      )  //i
  );
  round_sat_dat_1_1 s0_rsat3_re (
    .t_0_dat (s0_bs3_re_0[19:0]        ), //i
    .i_0_dat (s0_rsat3_re_i_0_dat[15:0]), //o
    .clk     (s0_rsat3_re_clk          ), //i
    .reset_n (s0_rsat3_re_reset_n      )  //i
  );
  round_sat_dat_1_1 s0_rsat3_im (
    .t_0_dat (s0_bs3_im_0[19:0]        ), //i
    .i_0_dat (s0_rsat3_im_i_0_dat[15:0]), //o
    .clk     (s0_rsat3_im_clk          ), //i
    .reset_n (s0_rsat3_im_reset_n      )  //i
  );
  bs_dat_2_1 s1_bs0_re (
    .t_0_dat   (s1_r4_byp0_re_0[35:0]  ), //i
    .t_cfg_dat (cfg_s1_bs0_re[7:0]     ), //i
    .i_0_dat   (s1_bs0_re_i_0_dat[19:0]), //o
    .clk       (s1_bs0_re_clk          ), //i
    .reset_n   (s1_bs0_re_reset_n      )  //i
  );
  bs_dat_2_1 s1_bs0_im (
    .t_0_dat   (s1_r4_byp0_im_0[35:0]  ), //i
    .t_cfg_dat (cfg_s1_bs0_im[7:0]     ), //i
    .i_0_dat   (s1_bs0_im_i_0_dat[19:0]), //o
    .clk       (s1_bs0_im_clk          ), //i
    .reset_n   (s1_bs0_im_reset_n      )  //i
  );
  round_sat_dat_1_1 s1_rsat0_re (
    .t_0_dat (s1_bs0_re_0[19:0]        ), //i
    .i_0_dat (s1_rsat0_re_i_0_dat[15:0]), //o
    .clk     (s1_rsat0_re_clk          ), //i
    .reset_n (s1_rsat0_re_reset_n      )  //i
  );
  round_sat_dat_1_1 s1_rsat0_im (
    .t_0_dat (s1_bs0_im_0[19:0]        ), //i
    .i_0_dat (s1_rsat0_im_i_0_dat[15:0]), //o
    .clk     (s1_rsat0_im_clk          ), //i
    .reset_n (s1_rsat0_im_reset_n      )  //i
  );
  bs_dat_2_1 s1_bs1_re (
    .t_0_dat   (s1_r4_byp1_re_0[35:0]  ), //i
    .t_cfg_dat (cfg_s1_bs1_re[7:0]     ), //i
    .i_0_dat   (s1_bs1_re_i_0_dat[19:0]), //o
    .clk       (s1_bs1_re_clk          ), //i
    .reset_n   (s1_bs1_re_reset_n      )  //i
  );
  bs_dat_2_1 s1_bs1_im (
    .t_0_dat   (s1_r4_byp1_im_0[35:0]  ), //i
    .t_cfg_dat (cfg_s1_bs1_im[7:0]     ), //i
    .i_0_dat   (s1_bs1_im_i_0_dat[19:0]), //o
    .clk       (s1_bs1_im_clk          ), //i
    .reset_n   (s1_bs1_im_reset_n      )  //i
  );
  round_sat_dat_1_1 s1_rsat1_re (
    .t_0_dat (s1_bs1_re_0[19:0]        ), //i
    .i_0_dat (s1_rsat1_re_i_0_dat[15:0]), //o
    .clk     (s1_rsat1_re_clk          ), //i
    .reset_n (s1_rsat1_re_reset_n      )  //i
  );
  round_sat_dat_1_1 s1_rsat1_im (
    .t_0_dat (s1_bs1_im_0[19:0]        ), //i
    .i_0_dat (s1_rsat1_im_i_0_dat[15:0]), //o
    .clk     (s1_rsat1_im_clk          ), //i
    .reset_n (s1_rsat1_im_reset_n      )  //i
  );
  bs_dat_2_1 s1_bs2_re (
    .t_0_dat   (s1_r4_byp2_re_0[35:0]  ), //i
    .t_cfg_dat (cfg_s1_bs2_re[7:0]     ), //i
    .i_0_dat   (s1_bs2_re_i_0_dat[19:0]), //o
    .clk       (s1_bs2_re_clk          ), //i
    .reset_n   (s1_bs2_re_reset_n      )  //i
  );
  bs_dat_2_1 s1_bs2_im (
    .t_0_dat   (s1_r4_byp2_im_0[35:0]  ), //i
    .t_cfg_dat (cfg_s1_bs2_im[7:0]     ), //i
    .i_0_dat   (s1_bs2_im_i_0_dat[19:0]), //o
    .clk       (s1_bs2_im_clk          ), //i
    .reset_n   (s1_bs2_im_reset_n      )  //i
  );
  round_sat_dat_1_1 s1_rsat2_re (
    .t_0_dat (s1_bs2_re_0[19:0]        ), //i
    .i_0_dat (s1_rsat2_re_i_0_dat[15:0]), //o
    .clk     (s1_rsat2_re_clk          ), //i
    .reset_n (s1_rsat2_re_reset_n      )  //i
  );
  round_sat_dat_1_1 s1_rsat2_im (
    .t_0_dat (s1_bs2_im_0[19:0]        ), //i
    .i_0_dat (s1_rsat2_im_i_0_dat[15:0]), //o
    .clk     (s1_rsat2_im_clk          ), //i
    .reset_n (s1_rsat2_im_reset_n      )  //i
  );
  bs_dat_2_1 s1_bs3_re (
    .t_0_dat   (s1_r4_byp3_re_0[35:0]  ), //i
    .t_cfg_dat (cfg_s1_bs3_re[7:0]     ), //i
    .i_0_dat   (s1_bs3_re_i_0_dat[19:0]), //o
    .clk       (s1_bs3_re_clk          ), //i
    .reset_n   (s1_bs3_re_reset_n      )  //i
  );
  bs_dat_2_1 s1_bs3_im (
    .t_0_dat   (s1_r4_byp3_im_0[35:0]  ), //i
    .t_cfg_dat (cfg_s1_bs3_im[7:0]     ), //i
    .i_0_dat   (s1_bs3_im_i_0_dat[19:0]), //o
    .clk       (s1_bs3_im_clk          ), //i
    .reset_n   (s1_bs3_im_reset_n      )  //i
  );
  round_sat_dat_1_1 s1_rsat3_re (
    .t_0_dat (s1_bs3_re_0[19:0]        ), //i
    .i_0_dat (s1_rsat3_re_i_0_dat[15:0]), //o
    .clk     (s1_rsat3_re_clk          ), //i
    .reset_n (s1_rsat3_re_reset_n      )  //i
  );
  round_sat_dat_1_1 s1_rsat3_im (
    .t_0_dat (s1_bs3_im_0[19:0]        ), //i
    .i_0_dat (s1_rsat3_im_i_0_dat[15:0]), //o
    .clk     (s1_rsat3_im_clk          ), //i
    .reset_n (s1_rsat3_im_reset_n      )  //i
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
  assign k8_funnel_0_nxt = k8_funnel_i_0_dat;
  assign k8_funnel_1_nxt = k8_funnel_i_1_dat;
  assign k8_funnel_clk = clk;
  assign k8_funnel_reset_n = reset_n;
  assign k8_funnel_ctrl_t_0_req = t_k8_0_to_k8_funnel_req;
  assign t_k8_0_to_k8_funnel_ack = k8_funnel_ctrl_t_0_ack[0];
  assign k8_funnel_ctrl_t_cfg_req = cfg_k8_funnel_to_k8_funnel_req;
  assign cfg_k8_funnel_to_k8_funnel_ack = k8_funnel_ctrl_t_cfg_ack[0];
  assign k8_funnel_0_req = k8_funnel_ctrl_i_0_req[0];
  assign k8_funnel_ctrl_i_0_ack = k8_funnel_0_ack;
  assign k8_funnel_1_req = k8_funnel_ctrl_i_1_req[0];
  assign k8_funnel_ctrl_i_1_ack = k8_funnel_1_ack;
  assign k8_funnel_ctrl_clk = clk;
  assign k8_funnel_ctrl_reset_n = reset_n;
  assign k9_funnel_0_nxt = k9_funnel_i_0_dat;
  assign k9_funnel_1_nxt = k9_funnel_i_1_dat;
  assign k9_funnel_clk = clk;
  assign k9_funnel_reset_n = reset_n;
  assign k9_funnel_ctrl_t_0_req = t_k9_0_to_k9_funnel_req;
  assign t_k9_0_to_k9_funnel_ack = k9_funnel_ctrl_t_0_ack[0];
  assign k9_funnel_ctrl_t_cfg_req = cfg_k9_funnel_to_k9_funnel_req;
  assign cfg_k9_funnel_to_k9_funnel_ack = k9_funnel_ctrl_t_cfg_ack[0];
  assign k9_funnel_0_req = k9_funnel_ctrl_i_0_req[0];
  assign k9_funnel_ctrl_i_0_ack = k9_funnel_0_ack;
  assign k9_funnel_1_req = k9_funnel_ctrl_i_1_req[0];
  assign k9_funnel_ctrl_i_1_ack = k9_funnel_1_ack;
  assign k9_funnel_ctrl_clk = clk;
  assign k9_funnel_ctrl_reset_n = reset_n;
  assign k1_defunnel_0_nxt = k1_defunnel_i_0_dat;
  assign k1_defunnel_clk = clk;
  assign k1_defunnel_reset_n = reset_n;
  assign k1_defunnel_ctrl_t_0_req = s0_k1_cat_0_to_k1_defunnel_req;
  assign s0_k1_cat_0_to_k1_defunnel_ack = k1_defunnel_ctrl_t_0_ack[0];
  assign k1_defunnel_ctrl_t_1_req = s1_k1_cat_0_to_k1_defunnel_req;
  assign s1_k1_cat_0_to_k1_defunnel_ack = k1_defunnel_ctrl_t_1_ack[0];
  assign k1_defunnel_ctrl_t_cfg_req = cfg_k1_defunnel_to_k1_defunnel_req;
  assign cfg_k1_defunnel_to_k1_defunnel_ack = k1_defunnel_ctrl_t_cfg_ack[0];
  assign k1_defunnel_0_req = k1_defunnel_ctrl_i_0_req[0];
  assign k1_defunnel_ctrl_i_0_ack = k1_defunnel_0_ack;
  assign k1_defunnel_ctrl_clk = clk;
  assign k1_defunnel_ctrl_reset_n = reset_n;
  assign cfg_s0_cmul0_m2c_ac = t_k14_0[1 : 0];
  assign cfg_s0_cmul0_m2c_bc = t_k14_0[3 : 2];
  assign cfg_s0_cmul0_m2c_bd = t_k14_0[5 : 4];
  assign cfg_s0_cmul0_m2c_cb = t_k14_0[7 : 6];
  assign cfg_s0_cmul0_m2c_cd = t_k14_0[9 : 8];
  assign cfg_s0_cmul0_m2c_da = t_k14_0[11 : 10];
  assign cfg_s0_cmul0_mas_re = t_k14_0[13 : 12];
  assign cfg_s0_cmul0_mas_im = t_k14_0[15 : 14];
  assign cfg_s0_cmul1_m2c_ac = t_k14_0[17 : 16];
  assign cfg_s0_cmul1_m2c_bc = t_k14_0[19 : 18];
  assign cfg_s0_cmul1_m2c_bd = t_k14_0[21 : 20];
  assign cfg_s0_cmul1_m2c_cb = t_k14_0[23 : 22];
  assign cfg_s0_cmul1_m2c_cd = t_k14_0[25 : 24];
  assign cfg_s0_cmul1_m2c_da = t_k14_0[27 : 26];
  assign cfg_s0_cmul1_mas_re = t_k14_0[29 : 28];
  assign cfg_s0_cmul1_mas_im = t_k14_0[31 : 30];
  assign cfg_s0_cmul2_m2c_ac = t_k14_0[33 : 32];
  assign cfg_s0_cmul2_m2c_bc = t_k14_0[35 : 34];
  assign cfg_s0_cmul2_m2c_bd = t_k14_0[37 : 36];
  assign cfg_s0_cmul2_m2c_cb = t_k14_0[39 : 38];
  assign cfg_s0_cmul2_m2c_cd = t_k14_0[41 : 40];
  assign cfg_s0_cmul2_m2c_da = t_k14_0[43 : 42];
  assign cfg_s0_cmul2_mas_re = t_k14_0[45 : 44];
  assign cfg_s0_cmul2_mas_im = t_k14_0[47 : 46];
  assign cfg_s0_cmul3_m2c_ac = t_k14_0[49 : 48];
  assign cfg_s0_cmul3_m2c_bc = t_k14_0[51 : 50];
  assign cfg_s0_cmul3_m2c_bd = t_k14_0[53 : 52];
  assign cfg_s0_cmul3_m2c_cb = t_k14_0[55 : 54];
  assign cfg_s0_cmul3_m2c_cd = t_k14_0[57 : 56];
  assign cfg_s0_cmul3_m2c_da = t_k14_0[59 : 58];
  assign cfg_s0_cmul3_mas_re = t_k14_0[61 : 60];
  assign cfg_s0_cmul3_mas_im = t_k14_0[63 : 62];
  assign cfg_s1_cmul0_m2c_ac = t_k14_0[65 : 64];
  assign cfg_s1_cmul0_m2c_bc = t_k14_0[67 : 66];
  assign cfg_s1_cmul0_m2c_bd = t_k14_0[69 : 68];
  assign cfg_s1_cmul0_m2c_cb = t_k14_0[71 : 70];
  assign cfg_s1_cmul0_m2c_cd = t_k14_0[73 : 72];
  assign cfg_s1_cmul0_m2c_da = t_k14_0[75 : 74];
  assign cfg_s1_cmul0_mas_re = t_k14_0[77 : 76];
  assign cfg_s1_cmul0_mas_im = t_k14_0[79 : 78];
  assign cfg_s1_cmul1_m2c_ac = t_k14_0[81 : 80];
  assign cfg_s1_cmul1_m2c_bc = t_k14_0[83 : 82];
  assign cfg_s1_cmul1_m2c_bd = t_k14_0[85 : 84];
  assign cfg_s1_cmul1_m2c_cb = t_k14_0[87 : 86];
  assign cfg_s1_cmul1_m2c_cd = t_k14_0[89 : 88];
  assign cfg_s1_cmul1_m2c_da = t_k14_0[91 : 90];
  assign cfg_s1_cmul1_mas_re = t_k14_0[93 : 92];
  assign cfg_s1_cmul1_mas_im = t_k14_0[95 : 94];
  assign cfg_s1_cmul2_m2c_ac = t_k14_0[97 : 96];
  assign cfg_s1_cmul2_m2c_bc = t_k14_0[99 : 98];
  assign cfg_s1_cmul2_m2c_bd = t_k14_0[101 : 100];
  assign cfg_s1_cmul2_m2c_cb = t_k14_0[103 : 102];
  assign cfg_s1_cmul2_m2c_cd = t_k14_0[105 : 104];
  assign cfg_s1_cmul2_m2c_da = t_k14_0[107 : 106];
  assign cfg_s1_cmul2_mas_re = t_k14_0[109 : 108];
  assign cfg_s1_cmul2_mas_im = t_k14_0[111 : 110];
  assign cfg_s1_cmul3_m2c_ac = t_k14_0[113 : 112];
  assign cfg_s1_cmul3_m2c_bc = t_k14_0[115 : 114];
  assign cfg_s1_cmul3_m2c_bd = t_k14_0[117 : 116];
  assign cfg_s1_cmul3_m2c_cb = t_k14_0[119 : 118];
  assign cfg_s1_cmul3_m2c_cd = t_k14_0[121 : 120];
  assign cfg_s1_cmul3_m2c_da = t_k14_0[123 : 122];
  assign cfg_s1_cmul3_mas_re = t_k14_0[125 : 124];
  assign cfg_s1_cmul3_mas_im = t_k14_0[127 : 126];
  assign cfg_s0_r4_byp0_re = t_k14_0[129 : 128];
  assign cfg_s0_r4_byp0_im = t_k14_0[131 : 130];
  assign cfg_s0_r4_byp1_re = t_k14_0[133 : 132];
  assign cfg_s0_r4_byp1_im = t_k14_0[135 : 134];
  assign cfg_s0_r4_byp2_re = t_k14_0[137 : 136];
  assign cfg_s0_r4_byp2_im = t_k14_0[139 : 138];
  assign cfg_s0_r4_byp3_re = t_k14_0[141 : 140];
  assign cfg_s0_r4_byp3_im = t_k14_0[143 : 142];
  assign cfg_s1_r4_byp0_re = t_k14_0[145 : 144];
  assign cfg_s1_r4_byp0_im = t_k14_0[147 : 146];
  assign cfg_s1_r4_byp1_re = t_k14_0[149 : 148];
  assign cfg_s1_r4_byp1_im = t_k14_0[151 : 150];
  assign cfg_s1_r4_byp2_re = t_k14_0[153 : 152];
  assign cfg_s1_r4_byp2_im = t_k14_0[155 : 154];
  assign cfg_s1_r4_byp3_re = t_k14_0[157 : 156];
  assign cfg_s1_r4_byp3_im = t_k14_0[159 : 158];
  assign cfg_s0_bs0_re = t_k14_0[167 : 160];
  assign cfg_s0_bs0_im = t_k14_0[175 : 168];
  assign cfg_s0_bs1_re = t_k14_0[183 : 176];
  assign cfg_s0_bs1_im = t_k14_0[191 : 184];
  assign cfg_s0_bs2_re = t_k14_0[199 : 192];
  assign cfg_s0_bs2_im = t_k14_0[207 : 200];
  assign cfg_s0_bs3_re = t_k14_0[215 : 208];
  assign cfg_s0_bs3_im = t_k14_0[223 : 216];
  assign cfg_s1_bs0_re = t_k14_0[231 : 224];
  assign cfg_s1_bs0_im = t_k14_0[239 : 232];
  assign cfg_s1_bs1_re = t_k14_0[247 : 240];
  assign cfg_s1_bs1_im = t_k14_0[255 : 248];
  assign cfg_s1_bs2_re = t_k14_0[263 : 256];
  assign cfg_s1_bs2_im = t_k14_0[271 : 264];
  assign cfg_s1_bs3_re = t_k14_0[279 : 272];
  assign cfg_s1_bs3_im = t_k14_0[287 : 280];
  assign cfg_k8_funnel = t_k14_0[295 : 288];
  assign cfg_k9_funnel = t_k14_0[303 : 296];
  assign cfg_k1_defunnel = t_k14_0[311 : 304];
  assign cfg_s0_cmul0_m2c_ac_req = (t_k14_0_to_cfg_req && (! cfg_i_0_req_reg));
  assign cfg_i_0_ack_g = (cfg_s0_cmul0_m2c_ac_ack || (! cfg_s0_cmul0_m2c_ac_req));
  assign cfg_s0_cmul0_m2c_bc_req = (t_k14_0_to_cfg_req && (! cfg_i_1_req_reg));
  assign cfg_i_1_ack_g = (cfg_s0_cmul0_m2c_bc_ack || (! cfg_s0_cmul0_m2c_bc_req));
  assign cfg_s0_cmul0_m2c_bd_req = (t_k14_0_to_cfg_req && (! cfg_i_2_req_reg));
  assign cfg_i_2_ack_g = (cfg_s0_cmul0_m2c_bd_ack || (! cfg_s0_cmul0_m2c_bd_req));
  assign cfg_s0_cmul0_m2c_cb_req = (t_k14_0_to_cfg_req && (! cfg_i_3_req_reg));
  assign cfg_i_3_ack_g = (cfg_s0_cmul0_m2c_cb_ack || (! cfg_s0_cmul0_m2c_cb_req));
  assign cfg_s0_cmul0_m2c_cd_req = (t_k14_0_to_cfg_req && (! cfg_i_4_req_reg));
  assign cfg_i_4_ack_g = (cfg_s0_cmul0_m2c_cd_ack || (! cfg_s0_cmul0_m2c_cd_req));
  assign cfg_s0_cmul0_m2c_da_req = (t_k14_0_to_cfg_req && (! cfg_i_5_req_reg));
  assign cfg_i_5_ack_g = (cfg_s0_cmul0_m2c_da_ack || (! cfg_s0_cmul0_m2c_da_req));
  assign cfg_s0_cmul0_mas_re_req = (t_k14_0_to_cfg_req && (! cfg_i_6_req_reg));
  assign cfg_i_6_ack_g = (cfg_s0_cmul0_mas_re_ack || (! cfg_s0_cmul0_mas_re_req));
  assign cfg_s0_cmul0_mas_im_req = (t_k14_0_to_cfg_req && (! cfg_i_7_req_reg));
  assign cfg_i_7_ack_g = (cfg_s0_cmul0_mas_im_ack || (! cfg_s0_cmul0_mas_im_req));
  assign cfg_s0_cmul1_m2c_ac_req = (t_k14_0_to_cfg_req && (! cfg_i_8_req_reg));
  assign cfg_i_8_ack_g = (cfg_s0_cmul1_m2c_ac_ack || (! cfg_s0_cmul1_m2c_ac_req));
  assign cfg_s0_cmul1_m2c_bc_req = (t_k14_0_to_cfg_req && (! cfg_i_9_req_reg));
  assign cfg_i_9_ack_g = (cfg_s0_cmul1_m2c_bc_ack || (! cfg_s0_cmul1_m2c_bc_req));
  assign cfg_s0_cmul1_m2c_bd_req = (t_k14_0_to_cfg_req && (! cfg_i_10_req_reg));
  assign cfg_i_10_ack_g = (cfg_s0_cmul1_m2c_bd_ack || (! cfg_s0_cmul1_m2c_bd_req));
  assign cfg_s0_cmul1_m2c_cb_req = (t_k14_0_to_cfg_req && (! cfg_i_11_req_reg));
  assign cfg_i_11_ack_g = (cfg_s0_cmul1_m2c_cb_ack || (! cfg_s0_cmul1_m2c_cb_req));
  assign cfg_s0_cmul1_m2c_cd_req = (t_k14_0_to_cfg_req && (! cfg_i_12_req_reg));
  assign cfg_i_12_ack_g = (cfg_s0_cmul1_m2c_cd_ack || (! cfg_s0_cmul1_m2c_cd_req));
  assign cfg_s0_cmul1_m2c_da_req = (t_k14_0_to_cfg_req && (! cfg_i_13_req_reg));
  assign cfg_i_13_ack_g = (cfg_s0_cmul1_m2c_da_ack || (! cfg_s0_cmul1_m2c_da_req));
  assign cfg_s0_cmul1_mas_re_req = (t_k14_0_to_cfg_req && (! cfg_i_14_req_reg));
  assign cfg_i_14_ack_g = (cfg_s0_cmul1_mas_re_ack || (! cfg_s0_cmul1_mas_re_req));
  assign cfg_s0_cmul1_mas_im_req = (t_k14_0_to_cfg_req && (! cfg_i_15_req_reg));
  assign cfg_i_15_ack_g = (cfg_s0_cmul1_mas_im_ack || (! cfg_s0_cmul1_mas_im_req));
  assign cfg_s0_cmul2_m2c_ac_req = (t_k14_0_to_cfg_req && (! cfg_i_16_req_reg));
  assign cfg_i_16_ack_g = (cfg_s0_cmul2_m2c_ac_ack || (! cfg_s0_cmul2_m2c_ac_req));
  assign cfg_s0_cmul2_m2c_bc_req = (t_k14_0_to_cfg_req && (! cfg_i_17_req_reg));
  assign cfg_i_17_ack_g = (cfg_s0_cmul2_m2c_bc_ack || (! cfg_s0_cmul2_m2c_bc_req));
  assign cfg_s0_cmul2_m2c_bd_req = (t_k14_0_to_cfg_req && (! cfg_i_18_req_reg));
  assign cfg_i_18_ack_g = (cfg_s0_cmul2_m2c_bd_ack || (! cfg_s0_cmul2_m2c_bd_req));
  assign cfg_s0_cmul2_m2c_cb_req = (t_k14_0_to_cfg_req && (! cfg_i_19_req_reg));
  assign cfg_i_19_ack_g = (cfg_s0_cmul2_m2c_cb_ack || (! cfg_s0_cmul2_m2c_cb_req));
  assign cfg_s0_cmul2_m2c_cd_req = (t_k14_0_to_cfg_req && (! cfg_i_20_req_reg));
  assign cfg_i_20_ack_g = (cfg_s0_cmul2_m2c_cd_ack || (! cfg_s0_cmul2_m2c_cd_req));
  assign cfg_s0_cmul2_m2c_da_req = (t_k14_0_to_cfg_req && (! cfg_i_21_req_reg));
  assign cfg_i_21_ack_g = (cfg_s0_cmul2_m2c_da_ack || (! cfg_s0_cmul2_m2c_da_req));
  assign cfg_s0_cmul2_mas_re_req = (t_k14_0_to_cfg_req && (! cfg_i_22_req_reg));
  assign cfg_i_22_ack_g = (cfg_s0_cmul2_mas_re_ack || (! cfg_s0_cmul2_mas_re_req));
  assign cfg_s0_cmul2_mas_im_req = (t_k14_0_to_cfg_req && (! cfg_i_23_req_reg));
  assign cfg_i_23_ack_g = (cfg_s0_cmul2_mas_im_ack || (! cfg_s0_cmul2_mas_im_req));
  assign cfg_s0_cmul3_m2c_ac_req = (t_k14_0_to_cfg_req && (! cfg_i_24_req_reg));
  assign cfg_i_24_ack_g = (cfg_s0_cmul3_m2c_ac_ack || (! cfg_s0_cmul3_m2c_ac_req));
  assign cfg_s0_cmul3_m2c_bc_req = (t_k14_0_to_cfg_req && (! cfg_i_25_req_reg));
  assign cfg_i_25_ack_g = (cfg_s0_cmul3_m2c_bc_ack || (! cfg_s0_cmul3_m2c_bc_req));
  assign cfg_s0_cmul3_m2c_bd_req = (t_k14_0_to_cfg_req && (! cfg_i_26_req_reg));
  assign cfg_i_26_ack_g = (cfg_s0_cmul3_m2c_bd_ack || (! cfg_s0_cmul3_m2c_bd_req));
  assign cfg_s0_cmul3_m2c_cb_req = (t_k14_0_to_cfg_req && (! cfg_i_27_req_reg));
  assign cfg_i_27_ack_g = (cfg_s0_cmul3_m2c_cb_ack || (! cfg_s0_cmul3_m2c_cb_req));
  assign cfg_s0_cmul3_m2c_cd_req = (t_k14_0_to_cfg_req && (! cfg_i_28_req_reg));
  assign cfg_i_28_ack_g = (cfg_s0_cmul3_m2c_cd_ack || (! cfg_s0_cmul3_m2c_cd_req));
  assign cfg_s0_cmul3_m2c_da_req = (t_k14_0_to_cfg_req && (! cfg_i_29_req_reg));
  assign cfg_i_29_ack_g = (cfg_s0_cmul3_m2c_da_ack || (! cfg_s0_cmul3_m2c_da_req));
  assign cfg_s0_cmul3_mas_re_req = (t_k14_0_to_cfg_req && (! cfg_i_30_req_reg));
  assign cfg_i_30_ack_g = (cfg_s0_cmul3_mas_re_ack || (! cfg_s0_cmul3_mas_re_req));
  assign cfg_s0_cmul3_mas_im_req = (t_k14_0_to_cfg_req && (! cfg_i_31_req_reg));
  assign cfg_i_31_ack_g = (cfg_s0_cmul3_mas_im_ack || (! cfg_s0_cmul3_mas_im_req));
  assign cfg_s1_cmul0_m2c_ac_req = (t_k14_0_to_cfg_req && (! cfg_i_32_req_reg));
  assign cfg_i_32_ack_g = (cfg_s1_cmul0_m2c_ac_ack || (! cfg_s1_cmul0_m2c_ac_req));
  assign cfg_s1_cmul0_m2c_bc_req = (t_k14_0_to_cfg_req && (! cfg_i_33_req_reg));
  assign cfg_i_33_ack_g = (cfg_s1_cmul0_m2c_bc_ack || (! cfg_s1_cmul0_m2c_bc_req));
  assign cfg_s1_cmul0_m2c_bd_req = (t_k14_0_to_cfg_req && (! cfg_i_34_req_reg));
  assign cfg_i_34_ack_g = (cfg_s1_cmul0_m2c_bd_ack || (! cfg_s1_cmul0_m2c_bd_req));
  assign cfg_s1_cmul0_m2c_cb_req = (t_k14_0_to_cfg_req && (! cfg_i_35_req_reg));
  assign cfg_i_35_ack_g = (cfg_s1_cmul0_m2c_cb_ack || (! cfg_s1_cmul0_m2c_cb_req));
  assign cfg_s1_cmul0_m2c_cd_req = (t_k14_0_to_cfg_req && (! cfg_i_36_req_reg));
  assign cfg_i_36_ack_g = (cfg_s1_cmul0_m2c_cd_ack || (! cfg_s1_cmul0_m2c_cd_req));
  assign cfg_s1_cmul0_m2c_da_req = (t_k14_0_to_cfg_req && (! cfg_i_37_req_reg));
  assign cfg_i_37_ack_g = (cfg_s1_cmul0_m2c_da_ack || (! cfg_s1_cmul0_m2c_da_req));
  assign cfg_s1_cmul0_mas_re_req = (t_k14_0_to_cfg_req && (! cfg_i_38_req_reg));
  assign cfg_i_38_ack_g = (cfg_s1_cmul0_mas_re_ack || (! cfg_s1_cmul0_mas_re_req));
  assign cfg_s1_cmul0_mas_im_req = (t_k14_0_to_cfg_req && (! cfg_i_39_req_reg));
  assign cfg_i_39_ack_g = (cfg_s1_cmul0_mas_im_ack || (! cfg_s1_cmul0_mas_im_req));
  assign cfg_s1_cmul1_m2c_ac_req = (t_k14_0_to_cfg_req && (! cfg_i_40_req_reg));
  assign cfg_i_40_ack_g = (cfg_s1_cmul1_m2c_ac_ack || (! cfg_s1_cmul1_m2c_ac_req));
  assign cfg_s1_cmul1_m2c_bc_req = (t_k14_0_to_cfg_req && (! cfg_i_41_req_reg));
  assign cfg_i_41_ack_g = (cfg_s1_cmul1_m2c_bc_ack || (! cfg_s1_cmul1_m2c_bc_req));
  assign cfg_s1_cmul1_m2c_bd_req = (t_k14_0_to_cfg_req && (! cfg_i_42_req_reg));
  assign cfg_i_42_ack_g = (cfg_s1_cmul1_m2c_bd_ack || (! cfg_s1_cmul1_m2c_bd_req));
  assign cfg_s1_cmul1_m2c_cb_req = (t_k14_0_to_cfg_req && (! cfg_i_43_req_reg));
  assign cfg_i_43_ack_g = (cfg_s1_cmul1_m2c_cb_ack || (! cfg_s1_cmul1_m2c_cb_req));
  assign cfg_s1_cmul1_m2c_cd_req = (t_k14_0_to_cfg_req && (! cfg_i_44_req_reg));
  assign cfg_i_44_ack_g = (cfg_s1_cmul1_m2c_cd_ack || (! cfg_s1_cmul1_m2c_cd_req));
  assign cfg_s1_cmul1_m2c_da_req = (t_k14_0_to_cfg_req && (! cfg_i_45_req_reg));
  assign cfg_i_45_ack_g = (cfg_s1_cmul1_m2c_da_ack || (! cfg_s1_cmul1_m2c_da_req));
  assign cfg_s1_cmul1_mas_re_req = (t_k14_0_to_cfg_req && (! cfg_i_46_req_reg));
  assign cfg_i_46_ack_g = (cfg_s1_cmul1_mas_re_ack || (! cfg_s1_cmul1_mas_re_req));
  assign cfg_s1_cmul1_mas_im_req = (t_k14_0_to_cfg_req && (! cfg_i_47_req_reg));
  assign cfg_i_47_ack_g = (cfg_s1_cmul1_mas_im_ack || (! cfg_s1_cmul1_mas_im_req));
  assign cfg_s1_cmul2_m2c_ac_req = (t_k14_0_to_cfg_req && (! cfg_i_48_req_reg));
  assign cfg_i_48_ack_g = (cfg_s1_cmul2_m2c_ac_ack || (! cfg_s1_cmul2_m2c_ac_req));
  assign cfg_s1_cmul2_m2c_bc_req = (t_k14_0_to_cfg_req && (! cfg_i_49_req_reg));
  assign cfg_i_49_ack_g = (cfg_s1_cmul2_m2c_bc_ack || (! cfg_s1_cmul2_m2c_bc_req));
  assign cfg_s1_cmul2_m2c_bd_req = (t_k14_0_to_cfg_req && (! cfg_i_50_req_reg));
  assign cfg_i_50_ack_g = (cfg_s1_cmul2_m2c_bd_ack || (! cfg_s1_cmul2_m2c_bd_req));
  assign cfg_s1_cmul2_m2c_cb_req = (t_k14_0_to_cfg_req && (! cfg_i_51_req_reg));
  assign cfg_i_51_ack_g = (cfg_s1_cmul2_m2c_cb_ack || (! cfg_s1_cmul2_m2c_cb_req));
  assign cfg_s1_cmul2_m2c_cd_req = (t_k14_0_to_cfg_req && (! cfg_i_52_req_reg));
  assign cfg_i_52_ack_g = (cfg_s1_cmul2_m2c_cd_ack || (! cfg_s1_cmul2_m2c_cd_req));
  assign cfg_s1_cmul2_m2c_da_req = (t_k14_0_to_cfg_req && (! cfg_i_53_req_reg));
  assign cfg_i_53_ack_g = (cfg_s1_cmul2_m2c_da_ack || (! cfg_s1_cmul2_m2c_da_req));
  assign cfg_s1_cmul2_mas_re_req = (t_k14_0_to_cfg_req && (! cfg_i_54_req_reg));
  assign cfg_i_54_ack_g = (cfg_s1_cmul2_mas_re_ack || (! cfg_s1_cmul2_mas_re_req));
  assign cfg_s1_cmul2_mas_im_req = (t_k14_0_to_cfg_req && (! cfg_i_55_req_reg));
  assign cfg_i_55_ack_g = (cfg_s1_cmul2_mas_im_ack || (! cfg_s1_cmul2_mas_im_req));
  assign cfg_s1_cmul3_m2c_ac_req = (t_k14_0_to_cfg_req && (! cfg_i_56_req_reg));
  assign cfg_i_56_ack_g = (cfg_s1_cmul3_m2c_ac_ack || (! cfg_s1_cmul3_m2c_ac_req));
  assign cfg_s1_cmul3_m2c_bc_req = (t_k14_0_to_cfg_req && (! cfg_i_57_req_reg));
  assign cfg_i_57_ack_g = (cfg_s1_cmul3_m2c_bc_ack || (! cfg_s1_cmul3_m2c_bc_req));
  assign cfg_s1_cmul3_m2c_bd_req = (t_k14_0_to_cfg_req && (! cfg_i_58_req_reg));
  assign cfg_i_58_ack_g = (cfg_s1_cmul3_m2c_bd_ack || (! cfg_s1_cmul3_m2c_bd_req));
  assign cfg_s1_cmul3_m2c_cb_req = (t_k14_0_to_cfg_req && (! cfg_i_59_req_reg));
  assign cfg_i_59_ack_g = (cfg_s1_cmul3_m2c_cb_ack || (! cfg_s1_cmul3_m2c_cb_req));
  assign cfg_s1_cmul3_m2c_cd_req = (t_k14_0_to_cfg_req && (! cfg_i_60_req_reg));
  assign cfg_i_60_ack_g = (cfg_s1_cmul3_m2c_cd_ack || (! cfg_s1_cmul3_m2c_cd_req));
  assign cfg_s1_cmul3_m2c_da_req = (t_k14_0_to_cfg_req && (! cfg_i_61_req_reg));
  assign cfg_i_61_ack_g = (cfg_s1_cmul3_m2c_da_ack || (! cfg_s1_cmul3_m2c_da_req));
  assign cfg_s1_cmul3_mas_re_req = (t_k14_0_to_cfg_req && (! cfg_i_62_req_reg));
  assign cfg_i_62_ack_g = (cfg_s1_cmul3_mas_re_ack || (! cfg_s1_cmul3_mas_re_req));
  assign cfg_s1_cmul3_mas_im_req = (t_k14_0_to_cfg_req && (! cfg_i_63_req_reg));
  assign cfg_i_63_ack_g = (cfg_s1_cmul3_mas_im_ack || (! cfg_s1_cmul3_mas_im_req));
  assign cfg_s0_r4_byp0_re_req = (t_k14_0_to_cfg_req && (! cfg_i_64_req_reg));
  assign cfg_i_64_ack_g = (cfg_s0_r4_byp0_re_ack || (! cfg_s0_r4_byp0_re_req));
  assign cfg_s0_r4_byp0_im_req = (t_k14_0_to_cfg_req && (! cfg_i_65_req_reg));
  assign cfg_i_65_ack_g = (cfg_s0_r4_byp0_im_ack || (! cfg_s0_r4_byp0_im_req));
  assign cfg_s0_r4_byp1_re_req = (t_k14_0_to_cfg_req && (! cfg_i_66_req_reg));
  assign cfg_i_66_ack_g = (cfg_s0_r4_byp1_re_ack || (! cfg_s0_r4_byp1_re_req));
  assign cfg_s0_r4_byp1_im_req = (t_k14_0_to_cfg_req && (! cfg_i_67_req_reg));
  assign cfg_i_67_ack_g = (cfg_s0_r4_byp1_im_ack || (! cfg_s0_r4_byp1_im_req));
  assign cfg_s0_r4_byp2_re_req = (t_k14_0_to_cfg_req && (! cfg_i_68_req_reg));
  assign cfg_i_68_ack_g = (cfg_s0_r4_byp2_re_ack || (! cfg_s0_r4_byp2_re_req));
  assign cfg_s0_r4_byp2_im_req = (t_k14_0_to_cfg_req && (! cfg_i_69_req_reg));
  assign cfg_i_69_ack_g = (cfg_s0_r4_byp2_im_ack || (! cfg_s0_r4_byp2_im_req));
  assign cfg_s0_r4_byp3_re_req = (t_k14_0_to_cfg_req && (! cfg_i_70_req_reg));
  assign cfg_i_70_ack_g = (cfg_s0_r4_byp3_re_ack || (! cfg_s0_r4_byp3_re_req));
  assign cfg_s0_r4_byp3_im_req = (t_k14_0_to_cfg_req && (! cfg_i_71_req_reg));
  assign cfg_i_71_ack_g = (cfg_s0_r4_byp3_im_ack || (! cfg_s0_r4_byp3_im_req));
  assign cfg_s1_r4_byp0_re_req = (t_k14_0_to_cfg_req && (! cfg_i_72_req_reg));
  assign cfg_i_72_ack_g = (cfg_s1_r4_byp0_re_ack || (! cfg_s1_r4_byp0_re_req));
  assign cfg_s1_r4_byp0_im_req = (t_k14_0_to_cfg_req && (! cfg_i_73_req_reg));
  assign cfg_i_73_ack_g = (cfg_s1_r4_byp0_im_ack || (! cfg_s1_r4_byp0_im_req));
  assign cfg_s1_r4_byp1_re_req = (t_k14_0_to_cfg_req && (! cfg_i_74_req_reg));
  assign cfg_i_74_ack_g = (cfg_s1_r4_byp1_re_ack || (! cfg_s1_r4_byp1_re_req));
  assign cfg_s1_r4_byp1_im_req = (t_k14_0_to_cfg_req && (! cfg_i_75_req_reg));
  assign cfg_i_75_ack_g = (cfg_s1_r4_byp1_im_ack || (! cfg_s1_r4_byp1_im_req));
  assign cfg_s1_r4_byp2_re_req = (t_k14_0_to_cfg_req && (! cfg_i_76_req_reg));
  assign cfg_i_76_ack_g = (cfg_s1_r4_byp2_re_ack || (! cfg_s1_r4_byp2_re_req));
  assign cfg_s1_r4_byp2_im_req = (t_k14_0_to_cfg_req && (! cfg_i_77_req_reg));
  assign cfg_i_77_ack_g = (cfg_s1_r4_byp2_im_ack || (! cfg_s1_r4_byp2_im_req));
  assign cfg_s1_r4_byp3_re_req = (t_k14_0_to_cfg_req && (! cfg_i_78_req_reg));
  assign cfg_i_78_ack_g = (cfg_s1_r4_byp3_re_ack || (! cfg_s1_r4_byp3_re_req));
  assign cfg_s1_r4_byp3_im_req = (t_k14_0_to_cfg_req && (! cfg_i_79_req_reg));
  assign cfg_i_79_ack_g = (cfg_s1_r4_byp3_im_ack || (! cfg_s1_r4_byp3_im_req));
  assign cfg_s0_bs0_re_req = (t_k14_0_to_cfg_req && (! cfg_i_80_req_reg));
  assign cfg_i_80_ack_g = (cfg_s0_bs0_re_ack || (! cfg_s0_bs0_re_req));
  assign cfg_s0_bs0_im_req = (t_k14_0_to_cfg_req && (! cfg_i_81_req_reg));
  assign cfg_i_81_ack_g = (cfg_s0_bs0_im_ack || (! cfg_s0_bs0_im_req));
  assign cfg_s0_bs1_re_req = (t_k14_0_to_cfg_req && (! cfg_i_82_req_reg));
  assign cfg_i_82_ack_g = (cfg_s0_bs1_re_ack || (! cfg_s0_bs1_re_req));
  assign cfg_s0_bs1_im_req = (t_k14_0_to_cfg_req && (! cfg_i_83_req_reg));
  assign cfg_i_83_ack_g = (cfg_s0_bs1_im_ack || (! cfg_s0_bs1_im_req));
  assign cfg_s0_bs2_re_req = (t_k14_0_to_cfg_req && (! cfg_i_84_req_reg));
  assign cfg_i_84_ack_g = (cfg_s0_bs2_re_ack || (! cfg_s0_bs2_re_req));
  assign cfg_s0_bs2_im_req = (t_k14_0_to_cfg_req && (! cfg_i_85_req_reg));
  assign cfg_i_85_ack_g = (cfg_s0_bs2_im_ack || (! cfg_s0_bs2_im_req));
  assign cfg_s0_bs3_re_req = (t_k14_0_to_cfg_req && (! cfg_i_86_req_reg));
  assign cfg_i_86_ack_g = (cfg_s0_bs3_re_ack || (! cfg_s0_bs3_re_req));
  assign cfg_s0_bs3_im_req = (t_k14_0_to_cfg_req && (! cfg_i_87_req_reg));
  assign cfg_i_87_ack_g = (cfg_s0_bs3_im_ack || (! cfg_s0_bs3_im_req));
  assign cfg_s1_bs0_re_req = (t_k14_0_to_cfg_req && (! cfg_i_88_req_reg));
  assign cfg_i_88_ack_g = (cfg_s1_bs0_re_ack || (! cfg_s1_bs0_re_req));
  assign cfg_s1_bs0_im_req = (t_k14_0_to_cfg_req && (! cfg_i_89_req_reg));
  assign cfg_i_89_ack_g = (cfg_s1_bs0_im_ack || (! cfg_s1_bs0_im_req));
  assign cfg_s1_bs1_re_req = (t_k14_0_to_cfg_req && (! cfg_i_90_req_reg));
  assign cfg_i_90_ack_g = (cfg_s1_bs1_re_ack || (! cfg_s1_bs1_re_req));
  assign cfg_s1_bs1_im_req = (t_k14_0_to_cfg_req && (! cfg_i_91_req_reg));
  assign cfg_i_91_ack_g = (cfg_s1_bs1_im_ack || (! cfg_s1_bs1_im_req));
  assign cfg_s1_bs2_re_req = (t_k14_0_to_cfg_req && (! cfg_i_92_req_reg));
  assign cfg_i_92_ack_g = (cfg_s1_bs2_re_ack || (! cfg_s1_bs2_re_req));
  assign cfg_s1_bs2_im_req = (t_k14_0_to_cfg_req && (! cfg_i_93_req_reg));
  assign cfg_i_93_ack_g = (cfg_s1_bs2_im_ack || (! cfg_s1_bs2_im_req));
  assign cfg_s1_bs3_re_req = (t_k14_0_to_cfg_req && (! cfg_i_94_req_reg));
  assign cfg_i_94_ack_g = (cfg_s1_bs3_re_ack || (! cfg_s1_bs3_re_req));
  assign cfg_s1_bs3_im_req = (t_k14_0_to_cfg_req && (! cfg_i_95_req_reg));
  assign cfg_i_95_ack_g = (cfg_s1_bs3_im_ack || (! cfg_s1_bs3_im_req));
  assign cfg_k8_funnel_req = (t_k14_0_to_cfg_req && (! cfg_i_96_req_reg));
  assign cfg_i_96_ack_g = (cfg_k8_funnel_ack || (! cfg_k8_funnel_req));
  assign cfg_k9_funnel_req = (t_k14_0_to_cfg_req && (! cfg_i_97_req_reg));
  assign cfg_i_97_ack_g = (cfg_k9_funnel_ack || (! cfg_k9_funnel_req));
  assign cfg_k1_defunnel_req = (t_k14_0_to_cfg_req && (! cfg_i_98_req_reg));
  assign cfg_i_98_ack_g = (cfg_k1_defunnel_ack || (! cfg_k1_defunnel_req));
  assign t_k14_0_to_cfg_ack = ((((((((((((((((_zz_t_k14_0_to_cfg_ack && cfg_i_83_ack_g) && cfg_i_84_ack_g) && cfg_i_85_ack_g) && cfg_i_86_ack_g) && cfg_i_87_ack_g) && cfg_i_88_ack_g) && cfg_i_89_ack_g) && cfg_i_90_ack_g) && cfg_i_91_ack_g) && cfg_i_92_ack_g) && cfg_i_93_ack_g) && cfg_i_94_ack_g) && cfg_i_95_ack_g) && cfg_i_96_ack_g) && cfg_i_97_ack_g) && cfg_i_98_ack_g);
  assign s0_k8_slice_0 = _zz_s0_k8_slice_0;
  assign s0_k8_slice_1 = _zz_s0_k8_slice_1;
  assign s0_k8_slice_2 = _zz_s0_k8_slice_2;
  assign s0_k8_slice_3 = _zz_s0_k8_slice_3;
  assign s0_k8_slice_4 = _zz_s0_k8_slice_4;
  assign s0_k8_slice_5 = _zz_s0_k8_slice_5;
  assign s0_k8_slice_6 = _zz_s0_k8_slice_6;
  assign s0_k8_slice_7 = _zz_s0_k8_slice_7;
  assign s0_k8_slice_0_req = (k8_funnel_0_to_s0_k8_slice_req && (! s0_k8_slice_i_0_req_reg));
  assign s0_k8_slice_i_0_ack_g = (s0_k8_slice_0_ack || (! s0_k8_slice_0_req));
  assign s0_k8_slice_1_req = (k8_funnel_0_to_s0_k8_slice_req && (! s0_k8_slice_i_1_req_reg));
  assign s0_k8_slice_i_1_ack_g = (s0_k8_slice_1_ack || (! s0_k8_slice_1_req));
  assign s0_k8_slice_2_req = (k8_funnel_0_to_s0_k8_slice_req && (! s0_k8_slice_i_2_req_reg));
  assign s0_k8_slice_i_2_ack_g = (s0_k8_slice_2_ack || (! s0_k8_slice_2_req));
  assign s0_k8_slice_3_req = (k8_funnel_0_to_s0_k8_slice_req && (! s0_k8_slice_i_3_req_reg));
  assign s0_k8_slice_i_3_ack_g = (s0_k8_slice_3_ack || (! s0_k8_slice_3_req));
  assign s0_k8_slice_4_req = (k8_funnel_0_to_s0_k8_slice_req && (! s0_k8_slice_i_4_req_reg));
  assign s0_k8_slice_i_4_ack_g = (s0_k8_slice_4_ack || (! s0_k8_slice_4_req));
  assign s0_k8_slice_5_req = (k8_funnel_0_to_s0_k8_slice_req && (! s0_k8_slice_i_5_req_reg));
  assign s0_k8_slice_i_5_ack_g = (s0_k8_slice_5_ack || (! s0_k8_slice_5_req));
  assign s0_k8_slice_6_req = (k8_funnel_0_to_s0_k8_slice_req && (! s0_k8_slice_i_6_req_reg));
  assign s0_k8_slice_i_6_ack_g = (s0_k8_slice_6_ack || (! s0_k8_slice_6_req));
  assign s0_k8_slice_7_req = (k8_funnel_0_to_s0_k8_slice_req && (! s0_k8_slice_i_7_req_reg));
  assign s0_k8_slice_i_7_ack_g = (s0_k8_slice_7_ack || (! s0_k8_slice_7_req));
  assign k8_funnel_0_to_s0_k8_slice_ack = (((((((s0_k8_slice_i_0_ack_g && s0_k8_slice_i_1_ack_g) && s0_k8_slice_i_2_ack_g) && s0_k8_slice_i_3_ack_g) && s0_k8_slice_i_4_ack_g) && s0_k8_slice_i_5_ack_g) && s0_k8_slice_i_6_ack_g) && s0_k8_slice_i_7_ack_g);
  assign s0_k9_slice_0 = _zz_s0_k9_slice_0;
  assign s0_k9_slice_1 = _zz_s0_k9_slice_1;
  assign s0_k9_slice_2 = _zz_s0_k9_slice_2;
  assign s0_k9_slice_3 = _zz_s0_k9_slice_3;
  assign s0_k9_slice_4 = _zz_s0_k9_slice_4;
  assign s0_k9_slice_5 = _zz_s0_k9_slice_5;
  assign s0_k9_slice_6 = _zz_s0_k9_slice_6;
  assign s0_k9_slice_7 = _zz_s0_k9_slice_7;
  assign s0_k9_slice_0_req = (k9_funnel_0_to_s0_k9_slice_req && (! s0_k9_slice_i_0_req_reg));
  assign s0_k9_slice_i_0_ack_g = (s0_k9_slice_0_ack || (! s0_k9_slice_0_req));
  assign s0_k9_slice_1_req = (k9_funnel_0_to_s0_k9_slice_req && (! s0_k9_slice_i_1_req_reg));
  assign s0_k9_slice_i_1_ack_g = (s0_k9_slice_1_ack || (! s0_k9_slice_1_req));
  assign s0_k9_slice_2_req = (k9_funnel_0_to_s0_k9_slice_req && (! s0_k9_slice_i_2_req_reg));
  assign s0_k9_slice_i_2_ack_g = (s0_k9_slice_2_ack || (! s0_k9_slice_2_req));
  assign s0_k9_slice_3_req = (k9_funnel_0_to_s0_k9_slice_req && (! s0_k9_slice_i_3_req_reg));
  assign s0_k9_slice_i_3_ack_g = (s0_k9_slice_3_ack || (! s0_k9_slice_3_req));
  assign s0_k9_slice_4_req = (k9_funnel_0_to_s0_k9_slice_req && (! s0_k9_slice_i_4_req_reg));
  assign s0_k9_slice_i_4_ack_g = (s0_k9_slice_4_ack || (! s0_k9_slice_4_req));
  assign s0_k9_slice_5_req = (k9_funnel_0_to_s0_k9_slice_req && (! s0_k9_slice_i_5_req_reg));
  assign s0_k9_slice_i_5_ack_g = (s0_k9_slice_5_ack || (! s0_k9_slice_5_req));
  assign s0_k9_slice_6_req = (k9_funnel_0_to_s0_k9_slice_req && (! s0_k9_slice_i_6_req_reg));
  assign s0_k9_slice_i_6_ack_g = (s0_k9_slice_6_ack || (! s0_k9_slice_6_req));
  assign s0_k9_slice_7_req = (k9_funnel_0_to_s0_k9_slice_req && (! s0_k9_slice_i_7_req_reg));
  assign s0_k9_slice_i_7_ack_g = (s0_k9_slice_7_ack || (! s0_k9_slice_7_req));
  assign k9_funnel_0_to_s0_k9_slice_ack = (((((((s0_k9_slice_i_0_ack_g && s0_k9_slice_i_1_ack_g) && s0_k9_slice_i_2_ack_g) && s0_k9_slice_i_3_ack_g) && s0_k9_slice_i_4_ack_g) && s0_k9_slice_i_5_ack_g) && s0_k9_slice_i_6_ack_g) && s0_k9_slice_i_7_ack_g);
  assign s0_cmul0_recip_norm_x = s0_k9_slice_0[15 : 0];
  assign s0_cmul0_recip_norm_mag = (_zz_s0_cmul0_recip_norm_mag + _zz_s0_cmul0_recip_norm_mag_2);
  always @(*) begin
    s0_cmul0_recip_norm_lz = 5'h10;
    if(s0_cmul0_recip_norm_mag[0]) begin
      s0_cmul0_recip_norm_lz = 5'h0f;
    end
    if(s0_cmul0_recip_norm_mag[1]) begin
      s0_cmul0_recip_norm_lz = 5'h0e;
    end
    if(s0_cmul0_recip_norm_mag[2]) begin
      s0_cmul0_recip_norm_lz = 5'h0d;
    end
    if(s0_cmul0_recip_norm_mag[3]) begin
      s0_cmul0_recip_norm_lz = 5'h0c;
    end
    if(s0_cmul0_recip_norm_mag[4]) begin
      s0_cmul0_recip_norm_lz = 5'h0b;
    end
    if(s0_cmul0_recip_norm_mag[5]) begin
      s0_cmul0_recip_norm_lz = 5'h0a;
    end
    if(s0_cmul0_recip_norm_mag[6]) begin
      s0_cmul0_recip_norm_lz = 5'h09;
    end
    if(s0_cmul0_recip_norm_mag[7]) begin
      s0_cmul0_recip_norm_lz = 5'h08;
    end
    if(s0_cmul0_recip_norm_mag[8]) begin
      s0_cmul0_recip_norm_lz = 5'h07;
    end
    if(s0_cmul0_recip_norm_mag[9]) begin
      s0_cmul0_recip_norm_lz = 5'h06;
    end
    if(s0_cmul0_recip_norm_mag[10]) begin
      s0_cmul0_recip_norm_lz = 5'h05;
    end
    if(s0_cmul0_recip_norm_mag[11]) begin
      s0_cmul0_recip_norm_lz = 5'h04;
    end
    if(s0_cmul0_recip_norm_mag[12]) begin
      s0_cmul0_recip_norm_lz = 5'h03;
    end
    if(s0_cmul0_recip_norm_mag[13]) begin
      s0_cmul0_recip_norm_lz = 5'h02;
    end
    if(s0_cmul0_recip_norm_mag[14]) begin
      s0_cmul0_recip_norm_lz = 5'h01;
    end
    if(s0_cmul0_recip_norm_mag[15]) begin
      s0_cmul0_recip_norm_lz = 5'h0;
    end
  end

  assign s0_cmul0_recip_norm_sat = (s0_cmul0_recip_norm_mag < 16'h0020);
  assign s0_cmul0_recip_norm_xn = (_zz_s0_cmul0_recip_norm_xn >>> 3'd6);
  assign s0_cmul0_recip_norm_0_nxt = {{{s0_cmul0_recip_norm_x[15],s0_cmul0_recip_norm_sat},s0_cmul0_recip_norm_lz},s0_cmul0_recip_norm_xn};
  assign s0_cmul0_recip_norm_0_req = s0_k9_slice_0_to_s0_cmul0_recip_norm_req;
  assign s0_k9_slice_0_to_s0_cmul0_recip_norm_ack = s0_cmul0_recip_norm_0_ack;
  assign _zz_s0_cmul0_recip_mul_y0 = s0_cmul0_recip_norm_0[9 : 0];
  assign s0_cmul0_recip_mul_y0 = (11'h5dd - _zz_s0_cmul0_recip_mul_y0_1);
  assign s0_cmul0_recip_mul_t = _zz_s0_cmul0_recip_mul_t[20 : 10];
  assign s0_cmul0_recip_mul_u = (11'h401 - s0_cmul0_recip_mul_t);
  assign s0_cmul0_recip_mul_0_nxt = {{s0_cmul0_recip_norm_0[16 : 10],s0_cmul0_recip_mul_u},s0_cmul0_recip_mul_y0};
  assign s0_cmul0_recip_mul_0_req = s0_cmul0_recip_norm_0_to_s0_cmul0_recip_mul_req;
  assign s0_cmul0_recip_norm_0_to_s0_cmul0_recip_mul_ack = s0_cmul0_recip_mul_0_ack;
  assign _zz_s0_cmul0_recip_out_rn = s0_cmul0_recip_mul_0[26 : 22];
  assign s0_cmul0_recip_out_r = {_zz_s0_cmul0_recip_out_r[21 : 10],2'b00};
  always @(*) begin
    if((_zz_s0_cmul0_recip_out_rn <= 5'h06)) begin
      s0_cmul0_recip_out_rn = {4'd0, _zz_s0_cmul0_recip_out_rn_1};
    end else begin
      s0_cmul0_recip_out_rn = (_zz_s0_cmul0_recip_out_rn_3 <<< _zz_s0_cmul0_recip_out_rn_4);
    end
  end

  assign s0_cmul0_recip_out_rmag = ((s0_cmul0_recip_mul_0[27] || (18'h08000 <= s0_cmul0_recip_out_rn)) ? 18'h07fff : s0_cmul0_recip_out_rn);
  assign s0_cmul0_recip_out_0_nxt = _zz_s0_cmul0_recip_out_0_nxt;
  assign s0_cmul0_recip_out_0_req = s0_cmul0_recip_mul_0_to_s0_cmul0_recip_out_req;
  assign s0_cmul0_recip_mul_0_to_s0_cmul0_recip_out_ack = s0_cmul0_recip_out_0_ack;
  assign s0_cmul0_m2c_ac_sel = cfg_s0_cmul0_m2c_ac;
  always @(*) begin
    case(s0_cmul0_m2c_ac_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_ac_0 = s0_k8_slice_0;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_ac_0 = s0_k9_slice_0;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_ac_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul0_m2c_ac_0 = s0_cmul0_recip_out_0;
      end
    endcase
  end

  assign s0_cmul0_m2c_ac_0 = _zz_s0_cmul0_m2c_ac_0;
  always @(*) begin
    case(s0_cmul0_m2c_ac_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_ac_0_req = s0_k8_slice_0_to_s0_cmul0_m2c_ac_req;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_ac_0_req = s0_k9_slice_0_to_s0_cmul0_m2c_ac_req;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_ac_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul0_m2c_ac_0_req = s0_cmul0_recip_out_0_to_s0_cmul0_m2c_ac_req;
      end
    endcase
  end

  assign s0_cmul0_m2c_ac_0_req = _zz_s0_cmul0_m2c_ac_0_req;
  assign s0_k8_slice_0_to_s0_cmul0_m2c_ac_ack = ((s0_cmul0_m2c_ac_sel != 2'b00) || s0_cmul0_m2c_ac_0_ack);
  assign s0_k9_slice_0_to_s0_cmul0_m2c_ac_ack = ((s0_cmul0_m2c_ac_sel != 2'b01) || s0_cmul0_m2c_ac_0_ack);
  assign s0_cmul0_recip_out_0_to_s0_cmul0_m2c_ac_ack = ((s0_cmul0_m2c_ac_sel != 2'b11) || s0_cmul0_m2c_ac_0_ack);
  assign cfg_s0_cmul0_m2c_ac_to_s0_cmul0_m2c_ac_ack = 1'b1;
  assign s0_cmul0_m2c_bc_sel = cfg_s0_cmul0_m2c_bc;
  always @(*) begin
    case(s0_cmul0_m2c_bc_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_bc_0 = s0_k8_slice_1;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_bc_0 = s0_k9_slice_0;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_bc_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul0_m2c_bc_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul0_m2c_bc_0 = _zz_s0_cmul0_m2c_bc_0;
  always @(*) begin
    case(s0_cmul0_m2c_bc_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_bc_0_req = s0_k8_slice_1_to_s0_cmul0_m2c_bc_req;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_bc_0_req = s0_k9_slice_0_to_s0_cmul0_m2c_bc_req;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_bc_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul0_m2c_bc_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul0_m2c_bc_0_req = _zz_s0_cmul0_m2c_bc_0_req;
  assign s0_k8_slice_1_to_s0_cmul0_m2c_bc_ack = ((s0_cmul0_m2c_bc_sel != 2'b00) || s0_cmul0_m2c_bc_0_ack);
  assign s0_k9_slice_0_to_s0_cmul0_m2c_bc_ack = ((s0_cmul0_m2c_bc_sel != 2'b01) || s0_cmul0_m2c_bc_0_ack);
  assign cfg_s0_cmul0_m2c_bc_to_s0_cmul0_m2c_bc_ack = 1'b1;
  assign s0_cmul0_m2c_bd_sel = cfg_s0_cmul0_m2c_bd;
  always @(*) begin
    case(s0_cmul0_m2c_bd_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_bd_0 = s0_k8_slice_1;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_bd_0 = s0_k9_slice_1;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_bd_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul0_m2c_bd_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul0_m2c_bd_0 = _zz_s0_cmul0_m2c_bd_0;
  always @(*) begin
    case(s0_cmul0_m2c_bd_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_bd_0_req = s0_k8_slice_1_to_s0_cmul0_m2c_bd_req;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_bd_0_req = s0_k9_slice_1_to_s0_cmul0_m2c_bd_req;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_bd_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul0_m2c_bd_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul0_m2c_bd_0_req = _zz_s0_cmul0_m2c_bd_0_req;
  assign s0_k8_slice_1_to_s0_cmul0_m2c_bd_ack = ((s0_cmul0_m2c_bd_sel != 2'b00) || s0_cmul0_m2c_bd_0_ack);
  assign s0_k9_slice_1_to_s0_cmul0_m2c_bd_ack = ((s0_cmul0_m2c_bd_sel != 2'b01) || s0_cmul0_m2c_bd_0_ack);
  assign cfg_s0_cmul0_m2c_bd_to_s0_cmul0_m2c_bd_ack = 1'b1;
  assign s0_cmul0_m2c_cb_sel = cfg_s0_cmul0_m2c_cb;
  always @(*) begin
    case(s0_cmul0_m2c_cb_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_cb_0 = s0_k9_slice_0;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_cb_0 = s0_k8_slice_1;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_cb_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul0_m2c_cb_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul0_m2c_cb_0 = _zz_s0_cmul0_m2c_cb_0;
  always @(*) begin
    case(s0_cmul0_m2c_cb_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_cb_0_req = s0_k9_slice_0_to_s0_cmul0_m2c_cb_req;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_cb_0_req = s0_k8_slice_1_to_s0_cmul0_m2c_cb_req;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_cb_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul0_m2c_cb_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul0_m2c_cb_0_req = _zz_s0_cmul0_m2c_cb_0_req;
  assign s0_k9_slice_0_to_s0_cmul0_m2c_cb_ack = ((s0_cmul0_m2c_cb_sel != 2'b00) || s0_cmul0_m2c_cb_0_ack);
  assign s0_k8_slice_1_to_s0_cmul0_m2c_cb_ack = ((s0_cmul0_m2c_cb_sel != 2'b01) || s0_cmul0_m2c_cb_0_ack);
  assign cfg_s0_cmul0_m2c_cb_to_s0_cmul0_m2c_cb_ack = 1'b1;
  assign s0_cmul0_m2c_cd_sel = cfg_s0_cmul0_m2c_cd;
  always @(*) begin
    case(s0_cmul0_m2c_cd_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_cd_0 = s0_k9_slice_0;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_cd_0 = s0_k9_slice_1;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_cd_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul0_m2c_cd_0 = s0_cmul0_recip_out_0;
      end
    endcase
  end

  assign s0_cmul0_m2c_cd_0 = _zz_s0_cmul0_m2c_cd_0;
  always @(*) begin
    case(s0_cmul0_m2c_cd_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_cd_0_req = s0_k9_slice_0_to_s0_cmul0_m2c_cd_req;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_cd_0_req = s0_k9_slice_1_to_s0_cmul0_m2c_cd_req;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_cd_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul0_m2c_cd_0_req = s0_cmul0_recip_out_0_to_s0_cmul0_m2c_cd_req;
      end
    endcase
  end

  assign s0_cmul0_m2c_cd_0_req = _zz_s0_cmul0_m2c_cd_0_req;
  assign s0_k9_slice_0_to_s0_cmul0_m2c_cd_ack = ((s0_cmul0_m2c_cd_sel != 2'b00) || s0_cmul0_m2c_cd_0_ack);
  assign s0_k9_slice_1_to_s0_cmul0_m2c_cd_ack = ((s0_cmul0_m2c_cd_sel != 2'b01) || s0_cmul0_m2c_cd_0_ack);
  assign s0_cmul0_recip_out_0_to_s0_cmul0_m2c_cd_ack = ((s0_cmul0_m2c_cd_sel != 2'b11) || s0_cmul0_m2c_cd_0_ack);
  assign cfg_s0_cmul0_m2c_cd_to_s0_cmul0_m2c_cd_ack = 1'b1;
  assign s0_cmul0_m2c_da_sel = cfg_s0_cmul0_m2c_da;
  always @(*) begin
    case(s0_cmul0_m2c_da_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_da_0 = s0_k9_slice_1;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_da_0 = s0_k8_slice_0;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_da_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul0_m2c_da_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul0_m2c_da_0 = _zz_s0_cmul0_m2c_da_0;
  always @(*) begin
    case(s0_cmul0_m2c_da_sel)
      2'b00 : begin
        _zz_s0_cmul0_m2c_da_0_req = s0_k9_slice_1_to_s0_cmul0_m2c_da_req;
      end
      2'b01 : begin
        _zz_s0_cmul0_m2c_da_0_req = s0_k8_slice_0_to_s0_cmul0_m2c_da_req;
      end
      2'b10 : begin
        _zz_s0_cmul0_m2c_da_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul0_m2c_da_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul0_m2c_da_0_req = _zz_s0_cmul0_m2c_da_0_req;
  assign s0_k9_slice_1_to_s0_cmul0_m2c_da_ack = ((s0_cmul0_m2c_da_sel != 2'b00) || s0_cmul0_m2c_da_0_ack);
  assign s0_k8_slice_0_to_s0_cmul0_m2c_da_ack = ((s0_cmul0_m2c_da_sel != 2'b01) || s0_cmul0_m2c_da_0_ack);
  assign cfg_s0_cmul0_m2c_da_to_s0_cmul0_m2c_da_ack = 1'b1;
  assign s0_cmul0_cat_re_0_nxt = {s0_cmul0_m2c_bd_0,{s0_cmul0_m2c_bc_0,{s0_cmul0_m2c_ac_0,s0_k8_slice_0}}};
  assign s0_cmul0_cat_re_0_req = (((s0_k8_slice_0_to_s0_cmul0_cat_re_req && s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_req);
  assign s0_k8_slice_0_to_s0_cmul0_cat_re_ack = (((s0_cmul0_cat_re_0_ack && s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_req);
  assign s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_ack = (((s0_cmul0_cat_re_0_ack && s0_k8_slice_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_req);
  assign s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_ack = (((s0_cmul0_cat_re_0_ack && s0_k8_slice_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_req);
  assign s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_ack = (((s0_cmul0_cat_re_0_ack && s0_k8_slice_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_req) && s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_req);
  assign s0_cmul0_cat_im_0_nxt = {s0_cmul0_m2c_da_0,{s0_k9_slice_1,{s0_cmul0_m2c_cd_0,s0_cmul0_m2c_cb_0}}};
  assign s0_cmul0_cat_im_0_req = (((s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_req && s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_req) && s0_k9_slice_1_to_s0_cmul0_cat_im_req) && s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_req);
  assign s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_ack = (((s0_cmul0_cat_im_0_ack && s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_req) && s0_k9_slice_1_to_s0_cmul0_cat_im_req) && s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_req);
  assign s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_ack = (((s0_cmul0_cat_im_0_ack && s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_req) && s0_k9_slice_1_to_s0_cmul0_cat_im_req) && s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_req);
  assign s0_k9_slice_1_to_s0_cmul0_cat_im_ack = (((s0_cmul0_cat_im_0_ack && s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_req) && s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_req) && s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_req);
  assign s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_ack = (((s0_cmul0_cat_im_0_ack && s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_req) && s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_req) && s0_k9_slice_1_to_s0_cmul0_cat_im_req);
  assign cfg_s0_cmul0_mas_re_to_s0_cmul0_mas_re_ack = 1'b1;
  assign s0_cmul0_mas_re_s1_en = ((s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_req && s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_ack) || s0_cmul0_mas_re_cfg_valid[3]);
  assign s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_ack = ((! s0_cmul0_mas_re_s1_valid) || s0_cmul0_mas_re_s1_ack);
  assign s0_cmul0_mas_re_s2_en = ((s0_cmul0_mas_re_s1_valid && s0_cmul0_mas_re_s1_ack) || s0_cmul0_mas_re_cfg_valid[3]);
  assign s0_cmul0_mas_re_s1_ack = ((! s0_cmul0_mas_re_s2_valid) || s0_cmul0_mas_re_s2_ack);
  assign s0_cmul0_mas_re_s3_en = ((s0_cmul0_mas_re_s2_valid && s0_cmul0_mas_re_s2_ack) || s0_cmul0_mas_re_cfg_valid[3]);
  assign s0_cmul0_mas_re_s2_ack = ((! s0_cmul0_mas_re_s3_valid) || s0_cmul0_mas_re_0_ack);
  assign s0_cmul0_mas_re_0_req = s0_cmul0_mas_re_s3_valid;
  assign s0_cmul0_mas_re_CLK0 = clk;
  assign s0_cmul0_mas_re_RST0 = (! reset_n);
  assign s0_cmul0_mas_re_CE0 = s0_cmul0_mas_re_s1_en;
  assign s0_cmul0_mas_re_CE1 = s0_cmul0_mas_re_s2_en;
  assign s0_cmul0_mas_re_CE2 = s0_cmul0_mas_re_s3_en;
  assign s0_cmul0_mas_re_ADDNSUB = cfg_s0_cmul0_mas_re[0];
  assign s0_cmul0_mas_re_A0 = s0_cmul0_cat_re_0[17 : 0];
  assign s0_cmul0_mas_re_B0 = s0_cmul0_cat_re_0[35 : 18];
  assign s0_cmul0_mas_re_A1 = s0_cmul0_cat_re_0[53 : 36];
  assign s0_cmul0_mas_re_B1 = s0_cmul0_cat_re_0[71 : 54];
  assign s0_cmul0_mas_re_0 = s0_cmul0_mas_re_SUM;
  assign cfg_s0_cmul0_mas_im_to_s0_cmul0_mas_im_ack = 1'b1;
  assign s0_cmul0_mas_im_s1_en = ((s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_req && s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_ack) || s0_cmul0_mas_im_cfg_valid[3]);
  assign s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_ack = ((! s0_cmul0_mas_im_s1_valid) || s0_cmul0_mas_im_s1_ack);
  assign s0_cmul0_mas_im_s2_en = ((s0_cmul0_mas_im_s1_valid && s0_cmul0_mas_im_s1_ack) || s0_cmul0_mas_im_cfg_valid[3]);
  assign s0_cmul0_mas_im_s1_ack = ((! s0_cmul0_mas_im_s2_valid) || s0_cmul0_mas_im_s2_ack);
  assign s0_cmul0_mas_im_s3_en = ((s0_cmul0_mas_im_s2_valid && s0_cmul0_mas_im_s2_ack) || s0_cmul0_mas_im_cfg_valid[3]);
  assign s0_cmul0_mas_im_s2_ack = ((! s0_cmul0_mas_im_s3_valid) || s0_cmul0_mas_im_0_ack);
  assign s0_cmul0_mas_im_0_req = s0_cmul0_mas_im_s3_valid;
  assign s0_cmul0_mas_im_CLK0 = clk;
  assign s0_cmul0_mas_im_RST0 = (! reset_n);
  assign s0_cmul0_mas_im_CE0 = s0_cmul0_mas_im_s1_en;
  assign s0_cmul0_mas_im_CE1 = s0_cmul0_mas_im_s2_en;
  assign s0_cmul0_mas_im_CE2 = s0_cmul0_mas_im_s3_en;
  assign s0_cmul0_mas_im_ADDNSUB = cfg_s0_cmul0_mas_im[0];
  assign s0_cmul0_mas_im_A0 = s0_cmul0_cat_im_0[17 : 0];
  assign s0_cmul0_mas_im_B0 = s0_cmul0_cat_im_0[35 : 18];
  assign s0_cmul0_mas_im_A1 = s0_cmul0_cat_im_0[53 : 36];
  assign s0_cmul0_mas_im_B1 = s0_cmul0_cat_im_0[71 : 54];
  assign s0_cmul0_mas_im_0 = s0_cmul0_mas_im_SUM;
  assign s0_cmul1_recip_norm_x = s0_k9_slice_2[15 : 0];
  assign s0_cmul1_recip_norm_mag = (_zz_s0_cmul1_recip_norm_mag + _zz_s0_cmul1_recip_norm_mag_2);
  always @(*) begin
    s0_cmul1_recip_norm_lz = 5'h10;
    if(s0_cmul1_recip_norm_mag[0]) begin
      s0_cmul1_recip_norm_lz = 5'h0f;
    end
    if(s0_cmul1_recip_norm_mag[1]) begin
      s0_cmul1_recip_norm_lz = 5'h0e;
    end
    if(s0_cmul1_recip_norm_mag[2]) begin
      s0_cmul1_recip_norm_lz = 5'h0d;
    end
    if(s0_cmul1_recip_norm_mag[3]) begin
      s0_cmul1_recip_norm_lz = 5'h0c;
    end
    if(s0_cmul1_recip_norm_mag[4]) begin
      s0_cmul1_recip_norm_lz = 5'h0b;
    end
    if(s0_cmul1_recip_norm_mag[5]) begin
      s0_cmul1_recip_norm_lz = 5'h0a;
    end
    if(s0_cmul1_recip_norm_mag[6]) begin
      s0_cmul1_recip_norm_lz = 5'h09;
    end
    if(s0_cmul1_recip_norm_mag[7]) begin
      s0_cmul1_recip_norm_lz = 5'h08;
    end
    if(s0_cmul1_recip_norm_mag[8]) begin
      s0_cmul1_recip_norm_lz = 5'h07;
    end
    if(s0_cmul1_recip_norm_mag[9]) begin
      s0_cmul1_recip_norm_lz = 5'h06;
    end
    if(s0_cmul1_recip_norm_mag[10]) begin
      s0_cmul1_recip_norm_lz = 5'h05;
    end
    if(s0_cmul1_recip_norm_mag[11]) begin
      s0_cmul1_recip_norm_lz = 5'h04;
    end
    if(s0_cmul1_recip_norm_mag[12]) begin
      s0_cmul1_recip_norm_lz = 5'h03;
    end
    if(s0_cmul1_recip_norm_mag[13]) begin
      s0_cmul1_recip_norm_lz = 5'h02;
    end
    if(s0_cmul1_recip_norm_mag[14]) begin
      s0_cmul1_recip_norm_lz = 5'h01;
    end
    if(s0_cmul1_recip_norm_mag[15]) begin
      s0_cmul1_recip_norm_lz = 5'h0;
    end
  end

  assign s0_cmul1_recip_norm_sat = (s0_cmul1_recip_norm_mag < 16'h0020);
  assign s0_cmul1_recip_norm_xn = (_zz_s0_cmul1_recip_norm_xn >>> 3'd6);
  assign s0_cmul1_recip_norm_0_nxt = {{{s0_cmul1_recip_norm_x[15],s0_cmul1_recip_norm_sat},s0_cmul1_recip_norm_lz},s0_cmul1_recip_norm_xn};
  assign s0_cmul1_recip_norm_0_req = s0_k9_slice_2_to_s0_cmul1_recip_norm_req;
  assign s0_k9_slice_2_to_s0_cmul1_recip_norm_ack = s0_cmul1_recip_norm_0_ack;
  assign _zz_s0_cmul1_recip_mul_y0 = s0_cmul1_recip_norm_0[9 : 0];
  assign s0_cmul1_recip_mul_y0 = (11'h5dd - _zz_s0_cmul1_recip_mul_y0_1);
  assign s0_cmul1_recip_mul_t = _zz_s0_cmul1_recip_mul_t[20 : 10];
  assign s0_cmul1_recip_mul_u = (11'h401 - s0_cmul1_recip_mul_t);
  assign s0_cmul1_recip_mul_0_nxt = {{s0_cmul1_recip_norm_0[16 : 10],s0_cmul1_recip_mul_u},s0_cmul1_recip_mul_y0};
  assign s0_cmul1_recip_mul_0_req = s0_cmul1_recip_norm_0_to_s0_cmul1_recip_mul_req;
  assign s0_cmul1_recip_norm_0_to_s0_cmul1_recip_mul_ack = s0_cmul1_recip_mul_0_ack;
  assign _zz_s0_cmul1_recip_out_rn = s0_cmul1_recip_mul_0[26 : 22];
  assign s0_cmul1_recip_out_r = {_zz_s0_cmul1_recip_out_r[21 : 10],2'b00};
  always @(*) begin
    if((_zz_s0_cmul1_recip_out_rn <= 5'h06)) begin
      s0_cmul1_recip_out_rn = {4'd0, _zz_s0_cmul1_recip_out_rn_1};
    end else begin
      s0_cmul1_recip_out_rn = (_zz_s0_cmul1_recip_out_rn_3 <<< _zz_s0_cmul1_recip_out_rn_4);
    end
  end

  assign s0_cmul1_recip_out_rmag = ((s0_cmul1_recip_mul_0[27] || (18'h08000 <= s0_cmul1_recip_out_rn)) ? 18'h07fff : s0_cmul1_recip_out_rn);
  assign s0_cmul1_recip_out_0_nxt = _zz_s0_cmul1_recip_out_0_nxt;
  assign s0_cmul1_recip_out_0_req = s0_cmul1_recip_mul_0_to_s0_cmul1_recip_out_req;
  assign s0_cmul1_recip_mul_0_to_s0_cmul1_recip_out_ack = s0_cmul1_recip_out_0_ack;
  assign s0_cmul1_m2c_ac_sel = cfg_s0_cmul1_m2c_ac;
  always @(*) begin
    case(s0_cmul1_m2c_ac_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_ac_0 = s0_k8_slice_2;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_ac_0 = s0_k9_slice_2;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_ac_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul1_m2c_ac_0 = s0_cmul1_recip_out_0;
      end
    endcase
  end

  assign s0_cmul1_m2c_ac_0 = _zz_s0_cmul1_m2c_ac_0;
  always @(*) begin
    case(s0_cmul1_m2c_ac_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_ac_0_req = s0_k8_slice_2_to_s0_cmul1_m2c_ac_req;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_ac_0_req = s0_k9_slice_2_to_s0_cmul1_m2c_ac_req;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_ac_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul1_m2c_ac_0_req = s0_cmul1_recip_out_0_to_s0_cmul1_m2c_ac_req;
      end
    endcase
  end

  assign s0_cmul1_m2c_ac_0_req = _zz_s0_cmul1_m2c_ac_0_req;
  assign s0_k8_slice_2_to_s0_cmul1_m2c_ac_ack = ((s0_cmul1_m2c_ac_sel != 2'b00) || s0_cmul1_m2c_ac_0_ack);
  assign s0_k9_slice_2_to_s0_cmul1_m2c_ac_ack = ((s0_cmul1_m2c_ac_sel != 2'b01) || s0_cmul1_m2c_ac_0_ack);
  assign s0_cmul1_recip_out_0_to_s0_cmul1_m2c_ac_ack = ((s0_cmul1_m2c_ac_sel != 2'b11) || s0_cmul1_m2c_ac_0_ack);
  assign cfg_s0_cmul1_m2c_ac_to_s0_cmul1_m2c_ac_ack = 1'b1;
  assign s0_cmul1_m2c_bc_sel = cfg_s0_cmul1_m2c_bc;
  always @(*) begin
    case(s0_cmul1_m2c_bc_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_bc_0 = s0_k8_slice_3;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_bc_0 = s0_k9_slice_2;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_bc_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul1_m2c_bc_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul1_m2c_bc_0 = _zz_s0_cmul1_m2c_bc_0;
  always @(*) begin
    case(s0_cmul1_m2c_bc_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_bc_0_req = s0_k8_slice_3_to_s0_cmul1_m2c_bc_req;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_bc_0_req = s0_k9_slice_2_to_s0_cmul1_m2c_bc_req;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_bc_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul1_m2c_bc_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul1_m2c_bc_0_req = _zz_s0_cmul1_m2c_bc_0_req;
  assign s0_k8_slice_3_to_s0_cmul1_m2c_bc_ack = ((s0_cmul1_m2c_bc_sel != 2'b00) || s0_cmul1_m2c_bc_0_ack);
  assign s0_k9_slice_2_to_s0_cmul1_m2c_bc_ack = ((s0_cmul1_m2c_bc_sel != 2'b01) || s0_cmul1_m2c_bc_0_ack);
  assign cfg_s0_cmul1_m2c_bc_to_s0_cmul1_m2c_bc_ack = 1'b1;
  assign s0_cmul1_m2c_bd_sel = cfg_s0_cmul1_m2c_bd;
  always @(*) begin
    case(s0_cmul1_m2c_bd_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_bd_0 = s0_k8_slice_3;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_bd_0 = s0_k9_slice_3;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_bd_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul1_m2c_bd_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul1_m2c_bd_0 = _zz_s0_cmul1_m2c_bd_0;
  always @(*) begin
    case(s0_cmul1_m2c_bd_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_bd_0_req = s0_k8_slice_3_to_s0_cmul1_m2c_bd_req;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_bd_0_req = s0_k9_slice_3_to_s0_cmul1_m2c_bd_req;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_bd_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul1_m2c_bd_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul1_m2c_bd_0_req = _zz_s0_cmul1_m2c_bd_0_req;
  assign s0_k8_slice_3_to_s0_cmul1_m2c_bd_ack = ((s0_cmul1_m2c_bd_sel != 2'b00) || s0_cmul1_m2c_bd_0_ack);
  assign s0_k9_slice_3_to_s0_cmul1_m2c_bd_ack = ((s0_cmul1_m2c_bd_sel != 2'b01) || s0_cmul1_m2c_bd_0_ack);
  assign cfg_s0_cmul1_m2c_bd_to_s0_cmul1_m2c_bd_ack = 1'b1;
  assign s0_cmul1_m2c_cb_sel = cfg_s0_cmul1_m2c_cb;
  always @(*) begin
    case(s0_cmul1_m2c_cb_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_cb_0 = s0_k9_slice_2;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_cb_0 = s0_k8_slice_3;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_cb_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul1_m2c_cb_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul1_m2c_cb_0 = _zz_s0_cmul1_m2c_cb_0;
  always @(*) begin
    case(s0_cmul1_m2c_cb_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_cb_0_req = s0_k9_slice_2_to_s0_cmul1_m2c_cb_req;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_cb_0_req = s0_k8_slice_3_to_s0_cmul1_m2c_cb_req;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_cb_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul1_m2c_cb_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul1_m2c_cb_0_req = _zz_s0_cmul1_m2c_cb_0_req;
  assign s0_k9_slice_2_to_s0_cmul1_m2c_cb_ack = ((s0_cmul1_m2c_cb_sel != 2'b00) || s0_cmul1_m2c_cb_0_ack);
  assign s0_k8_slice_3_to_s0_cmul1_m2c_cb_ack = ((s0_cmul1_m2c_cb_sel != 2'b01) || s0_cmul1_m2c_cb_0_ack);
  assign cfg_s0_cmul1_m2c_cb_to_s0_cmul1_m2c_cb_ack = 1'b1;
  assign s0_cmul1_m2c_cd_sel = cfg_s0_cmul1_m2c_cd;
  always @(*) begin
    case(s0_cmul1_m2c_cd_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_cd_0 = s0_k9_slice_2;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_cd_0 = s0_k9_slice_3;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_cd_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul1_m2c_cd_0 = s0_cmul1_recip_out_0;
      end
    endcase
  end

  assign s0_cmul1_m2c_cd_0 = _zz_s0_cmul1_m2c_cd_0;
  always @(*) begin
    case(s0_cmul1_m2c_cd_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_cd_0_req = s0_k9_slice_2_to_s0_cmul1_m2c_cd_req;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_cd_0_req = s0_k9_slice_3_to_s0_cmul1_m2c_cd_req;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_cd_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul1_m2c_cd_0_req = s0_cmul1_recip_out_0_to_s0_cmul1_m2c_cd_req;
      end
    endcase
  end

  assign s0_cmul1_m2c_cd_0_req = _zz_s0_cmul1_m2c_cd_0_req;
  assign s0_k9_slice_2_to_s0_cmul1_m2c_cd_ack = ((s0_cmul1_m2c_cd_sel != 2'b00) || s0_cmul1_m2c_cd_0_ack);
  assign s0_k9_slice_3_to_s0_cmul1_m2c_cd_ack = ((s0_cmul1_m2c_cd_sel != 2'b01) || s0_cmul1_m2c_cd_0_ack);
  assign s0_cmul1_recip_out_0_to_s0_cmul1_m2c_cd_ack = ((s0_cmul1_m2c_cd_sel != 2'b11) || s0_cmul1_m2c_cd_0_ack);
  assign cfg_s0_cmul1_m2c_cd_to_s0_cmul1_m2c_cd_ack = 1'b1;
  assign s0_cmul1_m2c_da_sel = cfg_s0_cmul1_m2c_da;
  always @(*) begin
    case(s0_cmul1_m2c_da_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_da_0 = s0_k9_slice_3;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_da_0 = s0_k8_slice_2;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_da_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul1_m2c_da_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul1_m2c_da_0 = _zz_s0_cmul1_m2c_da_0;
  always @(*) begin
    case(s0_cmul1_m2c_da_sel)
      2'b00 : begin
        _zz_s0_cmul1_m2c_da_0_req = s0_k9_slice_3_to_s0_cmul1_m2c_da_req;
      end
      2'b01 : begin
        _zz_s0_cmul1_m2c_da_0_req = s0_k8_slice_2_to_s0_cmul1_m2c_da_req;
      end
      2'b10 : begin
        _zz_s0_cmul1_m2c_da_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul1_m2c_da_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul1_m2c_da_0_req = _zz_s0_cmul1_m2c_da_0_req;
  assign s0_k9_slice_3_to_s0_cmul1_m2c_da_ack = ((s0_cmul1_m2c_da_sel != 2'b00) || s0_cmul1_m2c_da_0_ack);
  assign s0_k8_slice_2_to_s0_cmul1_m2c_da_ack = ((s0_cmul1_m2c_da_sel != 2'b01) || s0_cmul1_m2c_da_0_ack);
  assign cfg_s0_cmul1_m2c_da_to_s0_cmul1_m2c_da_ack = 1'b1;
  assign s0_cmul1_cat_re_0_nxt = {s0_cmul1_m2c_bd_0,{s0_cmul1_m2c_bc_0,{s0_cmul1_m2c_ac_0,s0_k8_slice_2}}};
  assign s0_cmul1_cat_re_0_req = (((s0_k8_slice_2_to_s0_cmul1_cat_re_req && s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_req);
  assign s0_k8_slice_2_to_s0_cmul1_cat_re_ack = (((s0_cmul1_cat_re_0_ack && s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_req);
  assign s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_ack = (((s0_cmul1_cat_re_0_ack && s0_k8_slice_2_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_req);
  assign s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_ack = (((s0_cmul1_cat_re_0_ack && s0_k8_slice_2_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_req);
  assign s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_ack = (((s0_cmul1_cat_re_0_ack && s0_k8_slice_2_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_req) && s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_req);
  assign s0_cmul1_cat_im_0_nxt = {s0_cmul1_m2c_da_0,{s0_k9_slice_3,{s0_cmul1_m2c_cd_0,s0_cmul1_m2c_cb_0}}};
  assign s0_cmul1_cat_im_0_req = (((s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_req && s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_req) && s0_k9_slice_3_to_s0_cmul1_cat_im_req) && s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_req);
  assign s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_ack = (((s0_cmul1_cat_im_0_ack && s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_req) && s0_k9_slice_3_to_s0_cmul1_cat_im_req) && s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_req);
  assign s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_ack = (((s0_cmul1_cat_im_0_ack && s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_req) && s0_k9_slice_3_to_s0_cmul1_cat_im_req) && s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_req);
  assign s0_k9_slice_3_to_s0_cmul1_cat_im_ack = (((s0_cmul1_cat_im_0_ack && s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_req) && s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_req) && s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_req);
  assign s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_ack = (((s0_cmul1_cat_im_0_ack && s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_req) && s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_req) && s0_k9_slice_3_to_s0_cmul1_cat_im_req);
  assign cfg_s0_cmul1_mas_re_to_s0_cmul1_mas_re_ack = 1'b1;
  assign s0_cmul1_mas_re_s1_en = ((s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_req && s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_ack) || s0_cmul1_mas_re_cfg_valid[3]);
  assign s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_ack = ((! s0_cmul1_mas_re_s1_valid) || s0_cmul1_mas_re_s1_ack);
  assign s0_cmul1_mas_re_s2_en = ((s0_cmul1_mas_re_s1_valid && s0_cmul1_mas_re_s1_ack) || s0_cmul1_mas_re_cfg_valid[3]);
  assign s0_cmul1_mas_re_s1_ack = ((! s0_cmul1_mas_re_s2_valid) || s0_cmul1_mas_re_s2_ack);
  assign s0_cmul1_mas_re_s3_en = ((s0_cmul1_mas_re_s2_valid && s0_cmul1_mas_re_s2_ack) || s0_cmul1_mas_re_cfg_valid[3]);
  assign s0_cmul1_mas_re_s2_ack = ((! s0_cmul1_mas_re_s3_valid) || s0_cmul1_mas_re_0_ack);
  assign s0_cmul1_mas_re_0_req = s0_cmul1_mas_re_s3_valid;
  assign s0_cmul1_mas_re_CLK0 = clk;
  assign s0_cmul1_mas_re_RST0 = (! reset_n);
  assign s0_cmul1_mas_re_CE0 = s0_cmul1_mas_re_s1_en;
  assign s0_cmul1_mas_re_CE1 = s0_cmul1_mas_re_s2_en;
  assign s0_cmul1_mas_re_CE2 = s0_cmul1_mas_re_s3_en;
  assign s0_cmul1_mas_re_ADDNSUB = cfg_s0_cmul1_mas_re[0];
  assign s0_cmul1_mas_re_A0 = s0_cmul1_cat_re_0[17 : 0];
  assign s0_cmul1_mas_re_B0 = s0_cmul1_cat_re_0[35 : 18];
  assign s0_cmul1_mas_re_A1 = s0_cmul1_cat_re_0[53 : 36];
  assign s0_cmul1_mas_re_B1 = s0_cmul1_cat_re_0[71 : 54];
  assign s0_cmul1_mas_re_0 = s0_cmul1_mas_re_SUM;
  assign cfg_s0_cmul1_mas_im_to_s0_cmul1_mas_im_ack = 1'b1;
  assign s0_cmul1_mas_im_s1_en = ((s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_req && s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_ack) || s0_cmul1_mas_im_cfg_valid[3]);
  assign s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_ack = ((! s0_cmul1_mas_im_s1_valid) || s0_cmul1_mas_im_s1_ack);
  assign s0_cmul1_mas_im_s2_en = ((s0_cmul1_mas_im_s1_valid && s0_cmul1_mas_im_s1_ack) || s0_cmul1_mas_im_cfg_valid[3]);
  assign s0_cmul1_mas_im_s1_ack = ((! s0_cmul1_mas_im_s2_valid) || s0_cmul1_mas_im_s2_ack);
  assign s0_cmul1_mas_im_s3_en = ((s0_cmul1_mas_im_s2_valid && s0_cmul1_mas_im_s2_ack) || s0_cmul1_mas_im_cfg_valid[3]);
  assign s0_cmul1_mas_im_s2_ack = ((! s0_cmul1_mas_im_s3_valid) || s0_cmul1_mas_im_0_ack);
  assign s0_cmul1_mas_im_0_req = s0_cmul1_mas_im_s3_valid;
  assign s0_cmul1_mas_im_CLK0 = clk;
  assign s0_cmul1_mas_im_RST0 = (! reset_n);
  assign s0_cmul1_mas_im_CE0 = s0_cmul1_mas_im_s1_en;
  assign s0_cmul1_mas_im_CE1 = s0_cmul1_mas_im_s2_en;
  assign s0_cmul1_mas_im_CE2 = s0_cmul1_mas_im_s3_en;
  assign s0_cmul1_mas_im_ADDNSUB = cfg_s0_cmul1_mas_im[0];
  assign s0_cmul1_mas_im_A0 = s0_cmul1_cat_im_0[17 : 0];
  assign s0_cmul1_mas_im_B0 = s0_cmul1_cat_im_0[35 : 18];
  assign s0_cmul1_mas_im_A1 = s0_cmul1_cat_im_0[53 : 36];
  assign s0_cmul1_mas_im_B1 = s0_cmul1_cat_im_0[71 : 54];
  assign s0_cmul1_mas_im_0 = s0_cmul1_mas_im_SUM;
  assign s0_cmul2_recip_norm_x = s0_k9_slice_4[15 : 0];
  assign s0_cmul2_recip_norm_mag = (_zz_s0_cmul2_recip_norm_mag + _zz_s0_cmul2_recip_norm_mag_2);
  always @(*) begin
    s0_cmul2_recip_norm_lz = 5'h10;
    if(s0_cmul2_recip_norm_mag[0]) begin
      s0_cmul2_recip_norm_lz = 5'h0f;
    end
    if(s0_cmul2_recip_norm_mag[1]) begin
      s0_cmul2_recip_norm_lz = 5'h0e;
    end
    if(s0_cmul2_recip_norm_mag[2]) begin
      s0_cmul2_recip_norm_lz = 5'h0d;
    end
    if(s0_cmul2_recip_norm_mag[3]) begin
      s0_cmul2_recip_norm_lz = 5'h0c;
    end
    if(s0_cmul2_recip_norm_mag[4]) begin
      s0_cmul2_recip_norm_lz = 5'h0b;
    end
    if(s0_cmul2_recip_norm_mag[5]) begin
      s0_cmul2_recip_norm_lz = 5'h0a;
    end
    if(s0_cmul2_recip_norm_mag[6]) begin
      s0_cmul2_recip_norm_lz = 5'h09;
    end
    if(s0_cmul2_recip_norm_mag[7]) begin
      s0_cmul2_recip_norm_lz = 5'h08;
    end
    if(s0_cmul2_recip_norm_mag[8]) begin
      s0_cmul2_recip_norm_lz = 5'h07;
    end
    if(s0_cmul2_recip_norm_mag[9]) begin
      s0_cmul2_recip_norm_lz = 5'h06;
    end
    if(s0_cmul2_recip_norm_mag[10]) begin
      s0_cmul2_recip_norm_lz = 5'h05;
    end
    if(s0_cmul2_recip_norm_mag[11]) begin
      s0_cmul2_recip_norm_lz = 5'h04;
    end
    if(s0_cmul2_recip_norm_mag[12]) begin
      s0_cmul2_recip_norm_lz = 5'h03;
    end
    if(s0_cmul2_recip_norm_mag[13]) begin
      s0_cmul2_recip_norm_lz = 5'h02;
    end
    if(s0_cmul2_recip_norm_mag[14]) begin
      s0_cmul2_recip_norm_lz = 5'h01;
    end
    if(s0_cmul2_recip_norm_mag[15]) begin
      s0_cmul2_recip_norm_lz = 5'h0;
    end
  end

  assign s0_cmul2_recip_norm_sat = (s0_cmul2_recip_norm_mag < 16'h0020);
  assign s0_cmul2_recip_norm_xn = (_zz_s0_cmul2_recip_norm_xn >>> 3'd6);
  assign s0_cmul2_recip_norm_0_nxt = {{{s0_cmul2_recip_norm_x[15],s0_cmul2_recip_norm_sat},s0_cmul2_recip_norm_lz},s0_cmul2_recip_norm_xn};
  assign s0_cmul2_recip_norm_0_req = s0_k9_slice_4_to_s0_cmul2_recip_norm_req;
  assign s0_k9_slice_4_to_s0_cmul2_recip_norm_ack = s0_cmul2_recip_norm_0_ack;
  assign _zz_s0_cmul2_recip_mul_y0 = s0_cmul2_recip_norm_0[9 : 0];
  assign s0_cmul2_recip_mul_y0 = (11'h5dd - _zz_s0_cmul2_recip_mul_y0_1);
  assign s0_cmul2_recip_mul_t = _zz_s0_cmul2_recip_mul_t[20 : 10];
  assign s0_cmul2_recip_mul_u = (11'h401 - s0_cmul2_recip_mul_t);
  assign s0_cmul2_recip_mul_0_nxt = {{s0_cmul2_recip_norm_0[16 : 10],s0_cmul2_recip_mul_u},s0_cmul2_recip_mul_y0};
  assign s0_cmul2_recip_mul_0_req = s0_cmul2_recip_norm_0_to_s0_cmul2_recip_mul_req;
  assign s0_cmul2_recip_norm_0_to_s0_cmul2_recip_mul_ack = s0_cmul2_recip_mul_0_ack;
  assign _zz_s0_cmul2_recip_out_rn = s0_cmul2_recip_mul_0[26 : 22];
  assign s0_cmul2_recip_out_r = {_zz_s0_cmul2_recip_out_r[21 : 10],2'b00};
  always @(*) begin
    if((_zz_s0_cmul2_recip_out_rn <= 5'h06)) begin
      s0_cmul2_recip_out_rn = {4'd0, _zz_s0_cmul2_recip_out_rn_1};
    end else begin
      s0_cmul2_recip_out_rn = (_zz_s0_cmul2_recip_out_rn_3 <<< _zz_s0_cmul2_recip_out_rn_4);
    end
  end

  assign s0_cmul2_recip_out_rmag = ((s0_cmul2_recip_mul_0[27] || (18'h08000 <= s0_cmul2_recip_out_rn)) ? 18'h07fff : s0_cmul2_recip_out_rn);
  assign s0_cmul2_recip_out_0_nxt = _zz_s0_cmul2_recip_out_0_nxt;
  assign s0_cmul2_recip_out_0_req = s0_cmul2_recip_mul_0_to_s0_cmul2_recip_out_req;
  assign s0_cmul2_recip_mul_0_to_s0_cmul2_recip_out_ack = s0_cmul2_recip_out_0_ack;
  assign s0_cmul2_m2c_ac_sel = cfg_s0_cmul2_m2c_ac;
  always @(*) begin
    case(s0_cmul2_m2c_ac_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_ac_0 = s0_k8_slice_4;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_ac_0 = s0_k9_slice_4;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_ac_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul2_m2c_ac_0 = s0_cmul2_recip_out_0;
      end
    endcase
  end

  assign s0_cmul2_m2c_ac_0 = _zz_s0_cmul2_m2c_ac_0;
  always @(*) begin
    case(s0_cmul2_m2c_ac_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_ac_0_req = s0_k8_slice_4_to_s0_cmul2_m2c_ac_req;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_ac_0_req = s0_k9_slice_4_to_s0_cmul2_m2c_ac_req;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_ac_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul2_m2c_ac_0_req = s0_cmul2_recip_out_0_to_s0_cmul2_m2c_ac_req;
      end
    endcase
  end

  assign s0_cmul2_m2c_ac_0_req = _zz_s0_cmul2_m2c_ac_0_req;
  assign s0_k8_slice_4_to_s0_cmul2_m2c_ac_ack = ((s0_cmul2_m2c_ac_sel != 2'b00) || s0_cmul2_m2c_ac_0_ack);
  assign s0_k9_slice_4_to_s0_cmul2_m2c_ac_ack = ((s0_cmul2_m2c_ac_sel != 2'b01) || s0_cmul2_m2c_ac_0_ack);
  assign s0_cmul2_recip_out_0_to_s0_cmul2_m2c_ac_ack = ((s0_cmul2_m2c_ac_sel != 2'b11) || s0_cmul2_m2c_ac_0_ack);
  assign cfg_s0_cmul2_m2c_ac_to_s0_cmul2_m2c_ac_ack = 1'b1;
  assign s0_cmul2_m2c_bc_sel = cfg_s0_cmul2_m2c_bc;
  always @(*) begin
    case(s0_cmul2_m2c_bc_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_bc_0 = s0_k8_slice_5;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_bc_0 = s0_k9_slice_4;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_bc_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul2_m2c_bc_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul2_m2c_bc_0 = _zz_s0_cmul2_m2c_bc_0;
  always @(*) begin
    case(s0_cmul2_m2c_bc_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_bc_0_req = s0_k8_slice_5_to_s0_cmul2_m2c_bc_req;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_bc_0_req = s0_k9_slice_4_to_s0_cmul2_m2c_bc_req;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_bc_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul2_m2c_bc_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul2_m2c_bc_0_req = _zz_s0_cmul2_m2c_bc_0_req;
  assign s0_k8_slice_5_to_s0_cmul2_m2c_bc_ack = ((s0_cmul2_m2c_bc_sel != 2'b00) || s0_cmul2_m2c_bc_0_ack);
  assign s0_k9_slice_4_to_s0_cmul2_m2c_bc_ack = ((s0_cmul2_m2c_bc_sel != 2'b01) || s0_cmul2_m2c_bc_0_ack);
  assign cfg_s0_cmul2_m2c_bc_to_s0_cmul2_m2c_bc_ack = 1'b1;
  assign s0_cmul2_m2c_bd_sel = cfg_s0_cmul2_m2c_bd;
  always @(*) begin
    case(s0_cmul2_m2c_bd_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_bd_0 = s0_k8_slice_5;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_bd_0 = s0_k9_slice_5;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_bd_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul2_m2c_bd_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul2_m2c_bd_0 = _zz_s0_cmul2_m2c_bd_0;
  always @(*) begin
    case(s0_cmul2_m2c_bd_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_bd_0_req = s0_k8_slice_5_to_s0_cmul2_m2c_bd_req;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_bd_0_req = s0_k9_slice_5_to_s0_cmul2_m2c_bd_req;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_bd_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul2_m2c_bd_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul2_m2c_bd_0_req = _zz_s0_cmul2_m2c_bd_0_req;
  assign s0_k8_slice_5_to_s0_cmul2_m2c_bd_ack = ((s0_cmul2_m2c_bd_sel != 2'b00) || s0_cmul2_m2c_bd_0_ack);
  assign s0_k9_slice_5_to_s0_cmul2_m2c_bd_ack = ((s0_cmul2_m2c_bd_sel != 2'b01) || s0_cmul2_m2c_bd_0_ack);
  assign cfg_s0_cmul2_m2c_bd_to_s0_cmul2_m2c_bd_ack = 1'b1;
  assign s0_cmul2_m2c_cb_sel = cfg_s0_cmul2_m2c_cb;
  always @(*) begin
    case(s0_cmul2_m2c_cb_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_cb_0 = s0_k9_slice_4;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_cb_0 = s0_k8_slice_5;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_cb_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul2_m2c_cb_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul2_m2c_cb_0 = _zz_s0_cmul2_m2c_cb_0;
  always @(*) begin
    case(s0_cmul2_m2c_cb_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_cb_0_req = s0_k9_slice_4_to_s0_cmul2_m2c_cb_req;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_cb_0_req = s0_k8_slice_5_to_s0_cmul2_m2c_cb_req;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_cb_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul2_m2c_cb_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul2_m2c_cb_0_req = _zz_s0_cmul2_m2c_cb_0_req;
  assign s0_k9_slice_4_to_s0_cmul2_m2c_cb_ack = ((s0_cmul2_m2c_cb_sel != 2'b00) || s0_cmul2_m2c_cb_0_ack);
  assign s0_k8_slice_5_to_s0_cmul2_m2c_cb_ack = ((s0_cmul2_m2c_cb_sel != 2'b01) || s0_cmul2_m2c_cb_0_ack);
  assign cfg_s0_cmul2_m2c_cb_to_s0_cmul2_m2c_cb_ack = 1'b1;
  assign s0_cmul2_m2c_cd_sel = cfg_s0_cmul2_m2c_cd;
  always @(*) begin
    case(s0_cmul2_m2c_cd_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_cd_0 = s0_k9_slice_4;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_cd_0 = s0_k9_slice_5;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_cd_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul2_m2c_cd_0 = s0_cmul2_recip_out_0;
      end
    endcase
  end

  assign s0_cmul2_m2c_cd_0 = _zz_s0_cmul2_m2c_cd_0;
  always @(*) begin
    case(s0_cmul2_m2c_cd_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_cd_0_req = s0_k9_slice_4_to_s0_cmul2_m2c_cd_req;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_cd_0_req = s0_k9_slice_5_to_s0_cmul2_m2c_cd_req;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_cd_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul2_m2c_cd_0_req = s0_cmul2_recip_out_0_to_s0_cmul2_m2c_cd_req;
      end
    endcase
  end

  assign s0_cmul2_m2c_cd_0_req = _zz_s0_cmul2_m2c_cd_0_req;
  assign s0_k9_slice_4_to_s0_cmul2_m2c_cd_ack = ((s0_cmul2_m2c_cd_sel != 2'b00) || s0_cmul2_m2c_cd_0_ack);
  assign s0_k9_slice_5_to_s0_cmul2_m2c_cd_ack = ((s0_cmul2_m2c_cd_sel != 2'b01) || s0_cmul2_m2c_cd_0_ack);
  assign s0_cmul2_recip_out_0_to_s0_cmul2_m2c_cd_ack = ((s0_cmul2_m2c_cd_sel != 2'b11) || s0_cmul2_m2c_cd_0_ack);
  assign cfg_s0_cmul2_m2c_cd_to_s0_cmul2_m2c_cd_ack = 1'b1;
  assign s0_cmul2_m2c_da_sel = cfg_s0_cmul2_m2c_da;
  always @(*) begin
    case(s0_cmul2_m2c_da_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_da_0 = s0_k9_slice_5;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_da_0 = s0_k8_slice_4;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_da_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul2_m2c_da_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul2_m2c_da_0 = _zz_s0_cmul2_m2c_da_0;
  always @(*) begin
    case(s0_cmul2_m2c_da_sel)
      2'b00 : begin
        _zz_s0_cmul2_m2c_da_0_req = s0_k9_slice_5_to_s0_cmul2_m2c_da_req;
      end
      2'b01 : begin
        _zz_s0_cmul2_m2c_da_0_req = s0_k8_slice_4_to_s0_cmul2_m2c_da_req;
      end
      2'b10 : begin
        _zz_s0_cmul2_m2c_da_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul2_m2c_da_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul2_m2c_da_0_req = _zz_s0_cmul2_m2c_da_0_req;
  assign s0_k9_slice_5_to_s0_cmul2_m2c_da_ack = ((s0_cmul2_m2c_da_sel != 2'b00) || s0_cmul2_m2c_da_0_ack);
  assign s0_k8_slice_4_to_s0_cmul2_m2c_da_ack = ((s0_cmul2_m2c_da_sel != 2'b01) || s0_cmul2_m2c_da_0_ack);
  assign cfg_s0_cmul2_m2c_da_to_s0_cmul2_m2c_da_ack = 1'b1;
  assign s0_cmul2_cat_re_0_nxt = {s0_cmul2_m2c_bd_0,{s0_cmul2_m2c_bc_0,{s0_cmul2_m2c_ac_0,s0_k8_slice_4}}};
  assign s0_cmul2_cat_re_0_req = (((s0_k8_slice_4_to_s0_cmul2_cat_re_req && s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_req);
  assign s0_k8_slice_4_to_s0_cmul2_cat_re_ack = (((s0_cmul2_cat_re_0_ack && s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_req);
  assign s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_ack = (((s0_cmul2_cat_re_0_ack && s0_k8_slice_4_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_req);
  assign s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_ack = (((s0_cmul2_cat_re_0_ack && s0_k8_slice_4_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_req);
  assign s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_ack = (((s0_cmul2_cat_re_0_ack && s0_k8_slice_4_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_req) && s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_req);
  assign s0_cmul2_cat_im_0_nxt = {s0_cmul2_m2c_da_0,{s0_k9_slice_5,{s0_cmul2_m2c_cd_0,s0_cmul2_m2c_cb_0}}};
  assign s0_cmul2_cat_im_0_req = (((s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_req && s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_req) && s0_k9_slice_5_to_s0_cmul2_cat_im_req) && s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_req);
  assign s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_ack = (((s0_cmul2_cat_im_0_ack && s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_req) && s0_k9_slice_5_to_s0_cmul2_cat_im_req) && s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_req);
  assign s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_ack = (((s0_cmul2_cat_im_0_ack && s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_req) && s0_k9_slice_5_to_s0_cmul2_cat_im_req) && s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_req);
  assign s0_k9_slice_5_to_s0_cmul2_cat_im_ack = (((s0_cmul2_cat_im_0_ack && s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_req) && s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_req) && s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_req);
  assign s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_ack = (((s0_cmul2_cat_im_0_ack && s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_req) && s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_req) && s0_k9_slice_5_to_s0_cmul2_cat_im_req);
  assign cfg_s0_cmul2_mas_re_to_s0_cmul2_mas_re_ack = 1'b1;
  assign s0_cmul2_mas_re_s1_en = ((s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_req && s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_ack) || s0_cmul2_mas_re_cfg_valid[3]);
  assign s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_ack = ((! s0_cmul2_mas_re_s1_valid) || s0_cmul2_mas_re_s1_ack);
  assign s0_cmul2_mas_re_s2_en = ((s0_cmul2_mas_re_s1_valid && s0_cmul2_mas_re_s1_ack) || s0_cmul2_mas_re_cfg_valid[3]);
  assign s0_cmul2_mas_re_s1_ack = ((! s0_cmul2_mas_re_s2_valid) || s0_cmul2_mas_re_s2_ack);
  assign s0_cmul2_mas_re_s3_en = ((s0_cmul2_mas_re_s2_valid && s0_cmul2_mas_re_s2_ack) || s0_cmul2_mas_re_cfg_valid[3]);
  assign s0_cmul2_mas_re_s2_ack = ((! s0_cmul2_mas_re_s3_valid) || s0_cmul2_mas_re_0_ack);
  assign s0_cmul2_mas_re_0_req = s0_cmul2_mas_re_s3_valid;
  assign s0_cmul2_mas_re_CLK0 = clk;
  assign s0_cmul2_mas_re_RST0 = (! reset_n);
  assign s0_cmul2_mas_re_CE0 = s0_cmul2_mas_re_s1_en;
  assign s0_cmul2_mas_re_CE1 = s0_cmul2_mas_re_s2_en;
  assign s0_cmul2_mas_re_CE2 = s0_cmul2_mas_re_s3_en;
  assign s0_cmul2_mas_re_ADDNSUB = cfg_s0_cmul2_mas_re[0];
  assign s0_cmul2_mas_re_A0 = s0_cmul2_cat_re_0[17 : 0];
  assign s0_cmul2_mas_re_B0 = s0_cmul2_cat_re_0[35 : 18];
  assign s0_cmul2_mas_re_A1 = s0_cmul2_cat_re_0[53 : 36];
  assign s0_cmul2_mas_re_B1 = s0_cmul2_cat_re_0[71 : 54];
  assign s0_cmul2_mas_re_0 = s0_cmul2_mas_re_SUM;
  assign cfg_s0_cmul2_mas_im_to_s0_cmul2_mas_im_ack = 1'b1;
  assign s0_cmul2_mas_im_s1_en = ((s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_req && s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_ack) || s0_cmul2_mas_im_cfg_valid[3]);
  assign s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_ack = ((! s0_cmul2_mas_im_s1_valid) || s0_cmul2_mas_im_s1_ack);
  assign s0_cmul2_mas_im_s2_en = ((s0_cmul2_mas_im_s1_valid && s0_cmul2_mas_im_s1_ack) || s0_cmul2_mas_im_cfg_valid[3]);
  assign s0_cmul2_mas_im_s1_ack = ((! s0_cmul2_mas_im_s2_valid) || s0_cmul2_mas_im_s2_ack);
  assign s0_cmul2_mas_im_s3_en = ((s0_cmul2_mas_im_s2_valid && s0_cmul2_mas_im_s2_ack) || s0_cmul2_mas_im_cfg_valid[3]);
  assign s0_cmul2_mas_im_s2_ack = ((! s0_cmul2_mas_im_s3_valid) || s0_cmul2_mas_im_0_ack);
  assign s0_cmul2_mas_im_0_req = s0_cmul2_mas_im_s3_valid;
  assign s0_cmul2_mas_im_CLK0 = clk;
  assign s0_cmul2_mas_im_RST0 = (! reset_n);
  assign s0_cmul2_mas_im_CE0 = s0_cmul2_mas_im_s1_en;
  assign s0_cmul2_mas_im_CE1 = s0_cmul2_mas_im_s2_en;
  assign s0_cmul2_mas_im_CE2 = s0_cmul2_mas_im_s3_en;
  assign s0_cmul2_mas_im_ADDNSUB = cfg_s0_cmul2_mas_im[0];
  assign s0_cmul2_mas_im_A0 = s0_cmul2_cat_im_0[17 : 0];
  assign s0_cmul2_mas_im_B0 = s0_cmul2_cat_im_0[35 : 18];
  assign s0_cmul2_mas_im_A1 = s0_cmul2_cat_im_0[53 : 36];
  assign s0_cmul2_mas_im_B1 = s0_cmul2_cat_im_0[71 : 54];
  assign s0_cmul2_mas_im_0 = s0_cmul2_mas_im_SUM;
  assign s0_cmul3_recip_norm_x = s0_k9_slice_6[15 : 0];
  assign s0_cmul3_recip_norm_mag = (_zz_s0_cmul3_recip_norm_mag + _zz_s0_cmul3_recip_norm_mag_2);
  always @(*) begin
    s0_cmul3_recip_norm_lz = 5'h10;
    if(s0_cmul3_recip_norm_mag[0]) begin
      s0_cmul3_recip_norm_lz = 5'h0f;
    end
    if(s0_cmul3_recip_norm_mag[1]) begin
      s0_cmul3_recip_norm_lz = 5'h0e;
    end
    if(s0_cmul3_recip_norm_mag[2]) begin
      s0_cmul3_recip_norm_lz = 5'h0d;
    end
    if(s0_cmul3_recip_norm_mag[3]) begin
      s0_cmul3_recip_norm_lz = 5'h0c;
    end
    if(s0_cmul3_recip_norm_mag[4]) begin
      s0_cmul3_recip_norm_lz = 5'h0b;
    end
    if(s0_cmul3_recip_norm_mag[5]) begin
      s0_cmul3_recip_norm_lz = 5'h0a;
    end
    if(s0_cmul3_recip_norm_mag[6]) begin
      s0_cmul3_recip_norm_lz = 5'h09;
    end
    if(s0_cmul3_recip_norm_mag[7]) begin
      s0_cmul3_recip_norm_lz = 5'h08;
    end
    if(s0_cmul3_recip_norm_mag[8]) begin
      s0_cmul3_recip_norm_lz = 5'h07;
    end
    if(s0_cmul3_recip_norm_mag[9]) begin
      s0_cmul3_recip_norm_lz = 5'h06;
    end
    if(s0_cmul3_recip_norm_mag[10]) begin
      s0_cmul3_recip_norm_lz = 5'h05;
    end
    if(s0_cmul3_recip_norm_mag[11]) begin
      s0_cmul3_recip_norm_lz = 5'h04;
    end
    if(s0_cmul3_recip_norm_mag[12]) begin
      s0_cmul3_recip_norm_lz = 5'h03;
    end
    if(s0_cmul3_recip_norm_mag[13]) begin
      s0_cmul3_recip_norm_lz = 5'h02;
    end
    if(s0_cmul3_recip_norm_mag[14]) begin
      s0_cmul3_recip_norm_lz = 5'h01;
    end
    if(s0_cmul3_recip_norm_mag[15]) begin
      s0_cmul3_recip_norm_lz = 5'h0;
    end
  end

  assign s0_cmul3_recip_norm_sat = (s0_cmul3_recip_norm_mag < 16'h0020);
  assign s0_cmul3_recip_norm_xn = (_zz_s0_cmul3_recip_norm_xn >>> 3'd6);
  assign s0_cmul3_recip_norm_0_nxt = {{{s0_cmul3_recip_norm_x[15],s0_cmul3_recip_norm_sat},s0_cmul3_recip_norm_lz},s0_cmul3_recip_norm_xn};
  assign s0_cmul3_recip_norm_0_req = s0_k9_slice_6_to_s0_cmul3_recip_norm_req;
  assign s0_k9_slice_6_to_s0_cmul3_recip_norm_ack = s0_cmul3_recip_norm_0_ack;
  assign _zz_s0_cmul3_recip_mul_y0 = s0_cmul3_recip_norm_0[9 : 0];
  assign s0_cmul3_recip_mul_y0 = (11'h5dd - _zz_s0_cmul3_recip_mul_y0_1);
  assign s0_cmul3_recip_mul_t = _zz_s0_cmul3_recip_mul_t[20 : 10];
  assign s0_cmul3_recip_mul_u = (11'h401 - s0_cmul3_recip_mul_t);
  assign s0_cmul3_recip_mul_0_nxt = {{s0_cmul3_recip_norm_0[16 : 10],s0_cmul3_recip_mul_u},s0_cmul3_recip_mul_y0};
  assign s0_cmul3_recip_mul_0_req = s0_cmul3_recip_norm_0_to_s0_cmul3_recip_mul_req;
  assign s0_cmul3_recip_norm_0_to_s0_cmul3_recip_mul_ack = s0_cmul3_recip_mul_0_ack;
  assign _zz_s0_cmul3_recip_out_rn = s0_cmul3_recip_mul_0[26 : 22];
  assign s0_cmul3_recip_out_r = {_zz_s0_cmul3_recip_out_r[21 : 10],2'b00};
  always @(*) begin
    if((_zz_s0_cmul3_recip_out_rn <= 5'h06)) begin
      s0_cmul3_recip_out_rn = {4'd0, _zz_s0_cmul3_recip_out_rn_1};
    end else begin
      s0_cmul3_recip_out_rn = (_zz_s0_cmul3_recip_out_rn_3 <<< _zz_s0_cmul3_recip_out_rn_4);
    end
  end

  assign s0_cmul3_recip_out_rmag = ((s0_cmul3_recip_mul_0[27] || (18'h08000 <= s0_cmul3_recip_out_rn)) ? 18'h07fff : s0_cmul3_recip_out_rn);
  assign s0_cmul3_recip_out_0_nxt = _zz_s0_cmul3_recip_out_0_nxt;
  assign s0_cmul3_recip_out_0_req = s0_cmul3_recip_mul_0_to_s0_cmul3_recip_out_req;
  assign s0_cmul3_recip_mul_0_to_s0_cmul3_recip_out_ack = s0_cmul3_recip_out_0_ack;
  assign s0_cmul3_m2c_ac_sel = cfg_s0_cmul3_m2c_ac;
  always @(*) begin
    case(s0_cmul3_m2c_ac_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_ac_0 = s0_k8_slice_6;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_ac_0 = s0_k9_slice_6;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_ac_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul3_m2c_ac_0 = s0_cmul3_recip_out_0;
      end
    endcase
  end

  assign s0_cmul3_m2c_ac_0 = _zz_s0_cmul3_m2c_ac_0;
  always @(*) begin
    case(s0_cmul3_m2c_ac_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_ac_0_req = s0_k8_slice_6_to_s0_cmul3_m2c_ac_req;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_ac_0_req = s0_k9_slice_6_to_s0_cmul3_m2c_ac_req;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_ac_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul3_m2c_ac_0_req = s0_cmul3_recip_out_0_to_s0_cmul3_m2c_ac_req;
      end
    endcase
  end

  assign s0_cmul3_m2c_ac_0_req = _zz_s0_cmul3_m2c_ac_0_req;
  assign s0_k8_slice_6_to_s0_cmul3_m2c_ac_ack = ((s0_cmul3_m2c_ac_sel != 2'b00) || s0_cmul3_m2c_ac_0_ack);
  assign s0_k9_slice_6_to_s0_cmul3_m2c_ac_ack = ((s0_cmul3_m2c_ac_sel != 2'b01) || s0_cmul3_m2c_ac_0_ack);
  assign s0_cmul3_recip_out_0_to_s0_cmul3_m2c_ac_ack = ((s0_cmul3_m2c_ac_sel != 2'b11) || s0_cmul3_m2c_ac_0_ack);
  assign cfg_s0_cmul3_m2c_ac_to_s0_cmul3_m2c_ac_ack = 1'b1;
  assign s0_cmul3_m2c_bc_sel = cfg_s0_cmul3_m2c_bc;
  always @(*) begin
    case(s0_cmul3_m2c_bc_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_bc_0 = s0_k8_slice_7;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_bc_0 = s0_k9_slice_6;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_bc_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul3_m2c_bc_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul3_m2c_bc_0 = _zz_s0_cmul3_m2c_bc_0;
  always @(*) begin
    case(s0_cmul3_m2c_bc_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_bc_0_req = s0_k8_slice_7_to_s0_cmul3_m2c_bc_req;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_bc_0_req = s0_k9_slice_6_to_s0_cmul3_m2c_bc_req;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_bc_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul3_m2c_bc_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul3_m2c_bc_0_req = _zz_s0_cmul3_m2c_bc_0_req;
  assign s0_k8_slice_7_to_s0_cmul3_m2c_bc_ack = ((s0_cmul3_m2c_bc_sel != 2'b00) || s0_cmul3_m2c_bc_0_ack);
  assign s0_k9_slice_6_to_s0_cmul3_m2c_bc_ack = ((s0_cmul3_m2c_bc_sel != 2'b01) || s0_cmul3_m2c_bc_0_ack);
  assign cfg_s0_cmul3_m2c_bc_to_s0_cmul3_m2c_bc_ack = 1'b1;
  assign s0_cmul3_m2c_bd_sel = cfg_s0_cmul3_m2c_bd;
  always @(*) begin
    case(s0_cmul3_m2c_bd_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_bd_0 = s0_k8_slice_7;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_bd_0 = s0_k9_slice_7;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_bd_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul3_m2c_bd_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul3_m2c_bd_0 = _zz_s0_cmul3_m2c_bd_0;
  always @(*) begin
    case(s0_cmul3_m2c_bd_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_bd_0_req = s0_k8_slice_7_to_s0_cmul3_m2c_bd_req;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_bd_0_req = s0_k9_slice_7_to_s0_cmul3_m2c_bd_req;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_bd_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul3_m2c_bd_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul3_m2c_bd_0_req = _zz_s0_cmul3_m2c_bd_0_req;
  assign s0_k8_slice_7_to_s0_cmul3_m2c_bd_ack = ((s0_cmul3_m2c_bd_sel != 2'b00) || s0_cmul3_m2c_bd_0_ack);
  assign s0_k9_slice_7_to_s0_cmul3_m2c_bd_ack = ((s0_cmul3_m2c_bd_sel != 2'b01) || s0_cmul3_m2c_bd_0_ack);
  assign cfg_s0_cmul3_m2c_bd_to_s0_cmul3_m2c_bd_ack = 1'b1;
  assign s0_cmul3_m2c_cb_sel = cfg_s0_cmul3_m2c_cb;
  always @(*) begin
    case(s0_cmul3_m2c_cb_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_cb_0 = s0_k9_slice_6;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_cb_0 = s0_k8_slice_7;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_cb_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul3_m2c_cb_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul3_m2c_cb_0 = _zz_s0_cmul3_m2c_cb_0;
  always @(*) begin
    case(s0_cmul3_m2c_cb_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_cb_0_req = s0_k9_slice_6_to_s0_cmul3_m2c_cb_req;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_cb_0_req = s0_k8_slice_7_to_s0_cmul3_m2c_cb_req;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_cb_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul3_m2c_cb_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul3_m2c_cb_0_req = _zz_s0_cmul3_m2c_cb_0_req;
  assign s0_k9_slice_6_to_s0_cmul3_m2c_cb_ack = ((s0_cmul3_m2c_cb_sel != 2'b00) || s0_cmul3_m2c_cb_0_ack);
  assign s0_k8_slice_7_to_s0_cmul3_m2c_cb_ack = ((s0_cmul3_m2c_cb_sel != 2'b01) || s0_cmul3_m2c_cb_0_ack);
  assign cfg_s0_cmul3_m2c_cb_to_s0_cmul3_m2c_cb_ack = 1'b1;
  assign s0_cmul3_m2c_cd_sel = cfg_s0_cmul3_m2c_cd;
  always @(*) begin
    case(s0_cmul3_m2c_cd_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_cd_0 = s0_k9_slice_6;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_cd_0 = s0_k9_slice_7;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_cd_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul3_m2c_cd_0 = s0_cmul3_recip_out_0;
      end
    endcase
  end

  assign s0_cmul3_m2c_cd_0 = _zz_s0_cmul3_m2c_cd_0;
  always @(*) begin
    case(s0_cmul3_m2c_cd_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_cd_0_req = s0_k9_slice_6_to_s0_cmul3_m2c_cd_req;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_cd_0_req = s0_k9_slice_7_to_s0_cmul3_m2c_cd_req;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_cd_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul3_m2c_cd_0_req = s0_cmul3_recip_out_0_to_s0_cmul3_m2c_cd_req;
      end
    endcase
  end

  assign s0_cmul3_m2c_cd_0_req = _zz_s0_cmul3_m2c_cd_0_req;
  assign s0_k9_slice_6_to_s0_cmul3_m2c_cd_ack = ((s0_cmul3_m2c_cd_sel != 2'b00) || s0_cmul3_m2c_cd_0_ack);
  assign s0_k9_slice_7_to_s0_cmul3_m2c_cd_ack = ((s0_cmul3_m2c_cd_sel != 2'b01) || s0_cmul3_m2c_cd_0_ack);
  assign s0_cmul3_recip_out_0_to_s0_cmul3_m2c_cd_ack = ((s0_cmul3_m2c_cd_sel != 2'b11) || s0_cmul3_m2c_cd_0_ack);
  assign cfg_s0_cmul3_m2c_cd_to_s0_cmul3_m2c_cd_ack = 1'b1;
  assign s0_cmul3_m2c_da_sel = cfg_s0_cmul3_m2c_da;
  always @(*) begin
    case(s0_cmul3_m2c_da_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_da_0 = s0_k9_slice_7;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_da_0 = s0_k8_slice_6;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_da_0 = 18'h00001;
      end
      default : begin
        _zz_s0_cmul3_m2c_da_0 = 18'h00001;
      end
    endcase
  end

  assign s0_cmul3_m2c_da_0 = _zz_s0_cmul3_m2c_da_0;
  always @(*) begin
    case(s0_cmul3_m2c_da_sel)
      2'b00 : begin
        _zz_s0_cmul3_m2c_da_0_req = s0_k9_slice_7_to_s0_cmul3_m2c_da_req;
      end
      2'b01 : begin
        _zz_s0_cmul3_m2c_da_0_req = s0_k8_slice_6_to_s0_cmul3_m2c_da_req;
      end
      2'b10 : begin
        _zz_s0_cmul3_m2c_da_0_req = 1'b1;
      end
      default : begin
        _zz_s0_cmul3_m2c_da_0_req = 1'b1;
      end
    endcase
  end

  assign s0_cmul3_m2c_da_0_req = _zz_s0_cmul3_m2c_da_0_req;
  assign s0_k9_slice_7_to_s0_cmul3_m2c_da_ack = ((s0_cmul3_m2c_da_sel != 2'b00) || s0_cmul3_m2c_da_0_ack);
  assign s0_k8_slice_6_to_s0_cmul3_m2c_da_ack = ((s0_cmul3_m2c_da_sel != 2'b01) || s0_cmul3_m2c_da_0_ack);
  assign cfg_s0_cmul3_m2c_da_to_s0_cmul3_m2c_da_ack = 1'b1;
  assign s0_cmul3_cat_re_0_nxt = {s0_cmul3_m2c_bd_0,{s0_cmul3_m2c_bc_0,{s0_cmul3_m2c_ac_0,s0_k8_slice_6}}};
  assign s0_cmul3_cat_re_0_req = (((s0_k8_slice_6_to_s0_cmul3_cat_re_req && s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_req);
  assign s0_k8_slice_6_to_s0_cmul3_cat_re_ack = (((s0_cmul3_cat_re_0_ack && s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_req);
  assign s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_ack = (((s0_cmul3_cat_re_0_ack && s0_k8_slice_6_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_req);
  assign s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_ack = (((s0_cmul3_cat_re_0_ack && s0_k8_slice_6_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_req);
  assign s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_ack = (((s0_cmul3_cat_re_0_ack && s0_k8_slice_6_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_req) && s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_req);
  assign s0_cmul3_cat_im_0_nxt = {s0_cmul3_m2c_da_0,{s0_k9_slice_7,{s0_cmul3_m2c_cd_0,s0_cmul3_m2c_cb_0}}};
  assign s0_cmul3_cat_im_0_req = (((s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_req && s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_req) && s0_k9_slice_7_to_s0_cmul3_cat_im_req) && s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_req);
  assign s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_ack = (((s0_cmul3_cat_im_0_ack && s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_req) && s0_k9_slice_7_to_s0_cmul3_cat_im_req) && s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_req);
  assign s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_ack = (((s0_cmul3_cat_im_0_ack && s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_req) && s0_k9_slice_7_to_s0_cmul3_cat_im_req) && s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_req);
  assign s0_k9_slice_7_to_s0_cmul3_cat_im_ack = (((s0_cmul3_cat_im_0_ack && s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_req) && s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_req) && s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_req);
  assign s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_ack = (((s0_cmul3_cat_im_0_ack && s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_req) && s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_req) && s0_k9_slice_7_to_s0_cmul3_cat_im_req);
  assign cfg_s0_cmul3_mas_re_to_s0_cmul3_mas_re_ack = 1'b1;
  assign s0_cmul3_mas_re_s1_en = ((s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_req && s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_ack) || s0_cmul3_mas_re_cfg_valid[3]);
  assign s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_ack = ((! s0_cmul3_mas_re_s1_valid) || s0_cmul3_mas_re_s1_ack);
  assign s0_cmul3_mas_re_s2_en = ((s0_cmul3_mas_re_s1_valid && s0_cmul3_mas_re_s1_ack) || s0_cmul3_mas_re_cfg_valid[3]);
  assign s0_cmul3_mas_re_s1_ack = ((! s0_cmul3_mas_re_s2_valid) || s0_cmul3_mas_re_s2_ack);
  assign s0_cmul3_mas_re_s3_en = ((s0_cmul3_mas_re_s2_valid && s0_cmul3_mas_re_s2_ack) || s0_cmul3_mas_re_cfg_valid[3]);
  assign s0_cmul3_mas_re_s2_ack = ((! s0_cmul3_mas_re_s3_valid) || s0_cmul3_mas_re_0_ack);
  assign s0_cmul3_mas_re_0_req = s0_cmul3_mas_re_s3_valid;
  assign s0_cmul3_mas_re_CLK0 = clk;
  assign s0_cmul3_mas_re_RST0 = (! reset_n);
  assign s0_cmul3_mas_re_CE0 = s0_cmul3_mas_re_s1_en;
  assign s0_cmul3_mas_re_CE1 = s0_cmul3_mas_re_s2_en;
  assign s0_cmul3_mas_re_CE2 = s0_cmul3_mas_re_s3_en;
  assign s0_cmul3_mas_re_ADDNSUB = cfg_s0_cmul3_mas_re[0];
  assign s0_cmul3_mas_re_A0 = s0_cmul3_cat_re_0[17 : 0];
  assign s0_cmul3_mas_re_B0 = s0_cmul3_cat_re_0[35 : 18];
  assign s0_cmul3_mas_re_A1 = s0_cmul3_cat_re_0[53 : 36];
  assign s0_cmul3_mas_re_B1 = s0_cmul3_cat_re_0[71 : 54];
  assign s0_cmul3_mas_re_0 = s0_cmul3_mas_re_SUM;
  assign cfg_s0_cmul3_mas_im_to_s0_cmul3_mas_im_ack = 1'b1;
  assign s0_cmul3_mas_im_s1_en = ((s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_req && s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_ack) || s0_cmul3_mas_im_cfg_valid[3]);
  assign s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_ack = ((! s0_cmul3_mas_im_s1_valid) || s0_cmul3_mas_im_s1_ack);
  assign s0_cmul3_mas_im_s2_en = ((s0_cmul3_mas_im_s1_valid && s0_cmul3_mas_im_s1_ack) || s0_cmul3_mas_im_cfg_valid[3]);
  assign s0_cmul3_mas_im_s1_ack = ((! s0_cmul3_mas_im_s2_valid) || s0_cmul3_mas_im_s2_ack);
  assign s0_cmul3_mas_im_s3_en = ((s0_cmul3_mas_im_s2_valid && s0_cmul3_mas_im_s2_ack) || s0_cmul3_mas_im_cfg_valid[3]);
  assign s0_cmul3_mas_im_s2_ack = ((! s0_cmul3_mas_im_s3_valid) || s0_cmul3_mas_im_0_ack);
  assign s0_cmul3_mas_im_0_req = s0_cmul3_mas_im_s3_valid;
  assign s0_cmul3_mas_im_CLK0 = clk;
  assign s0_cmul3_mas_im_RST0 = (! reset_n);
  assign s0_cmul3_mas_im_CE0 = s0_cmul3_mas_im_s1_en;
  assign s0_cmul3_mas_im_CE1 = s0_cmul3_mas_im_s2_en;
  assign s0_cmul3_mas_im_CE2 = s0_cmul3_mas_im_s3_en;
  assign s0_cmul3_mas_im_ADDNSUB = cfg_s0_cmul3_mas_im[0];
  assign s0_cmul3_mas_im_A0 = s0_cmul3_cat_im_0[17 : 0];
  assign s0_cmul3_mas_im_B0 = s0_cmul3_cat_im_0[35 : 18];
  assign s0_cmul3_mas_im_A1 = s0_cmul3_cat_im_0[53 : 36];
  assign s0_cmul3_mas_im_B1 = s0_cmul3_cat_im_0[71 : 54];
  assign s0_cmul3_mas_im_0 = s0_cmul3_mas_im_SUM;
  assign s1_k8_slice_0 = _zz_s1_k8_slice_0;
  assign s1_k8_slice_1 = _zz_s1_k8_slice_1;
  assign s1_k8_slice_2 = _zz_s1_k8_slice_2;
  assign s1_k8_slice_3 = _zz_s1_k8_slice_3;
  assign s1_k8_slice_4 = _zz_s1_k8_slice_4;
  assign s1_k8_slice_5 = _zz_s1_k8_slice_5;
  assign s1_k8_slice_6 = _zz_s1_k8_slice_6;
  assign s1_k8_slice_7 = _zz_s1_k8_slice_7;
  assign s1_k8_slice_0_req = (k8_funnel_1_to_s1_k8_slice_req && (! s1_k8_slice_i_0_req_reg));
  assign s1_k8_slice_i_0_ack_g = (s1_k8_slice_0_ack || (! s1_k8_slice_0_req));
  assign s1_k8_slice_1_req = (k8_funnel_1_to_s1_k8_slice_req && (! s1_k8_slice_i_1_req_reg));
  assign s1_k8_slice_i_1_ack_g = (s1_k8_slice_1_ack || (! s1_k8_slice_1_req));
  assign s1_k8_slice_2_req = (k8_funnel_1_to_s1_k8_slice_req && (! s1_k8_slice_i_2_req_reg));
  assign s1_k8_slice_i_2_ack_g = (s1_k8_slice_2_ack || (! s1_k8_slice_2_req));
  assign s1_k8_slice_3_req = (k8_funnel_1_to_s1_k8_slice_req && (! s1_k8_slice_i_3_req_reg));
  assign s1_k8_slice_i_3_ack_g = (s1_k8_slice_3_ack || (! s1_k8_slice_3_req));
  assign s1_k8_slice_4_req = (k8_funnel_1_to_s1_k8_slice_req && (! s1_k8_slice_i_4_req_reg));
  assign s1_k8_slice_i_4_ack_g = (s1_k8_slice_4_ack || (! s1_k8_slice_4_req));
  assign s1_k8_slice_5_req = (k8_funnel_1_to_s1_k8_slice_req && (! s1_k8_slice_i_5_req_reg));
  assign s1_k8_slice_i_5_ack_g = (s1_k8_slice_5_ack || (! s1_k8_slice_5_req));
  assign s1_k8_slice_6_req = (k8_funnel_1_to_s1_k8_slice_req && (! s1_k8_slice_i_6_req_reg));
  assign s1_k8_slice_i_6_ack_g = (s1_k8_slice_6_ack || (! s1_k8_slice_6_req));
  assign s1_k8_slice_7_req = (k8_funnel_1_to_s1_k8_slice_req && (! s1_k8_slice_i_7_req_reg));
  assign s1_k8_slice_i_7_ack_g = (s1_k8_slice_7_ack || (! s1_k8_slice_7_req));
  assign k8_funnel_1_to_s1_k8_slice_ack = (((((((s1_k8_slice_i_0_ack_g && s1_k8_slice_i_1_ack_g) && s1_k8_slice_i_2_ack_g) && s1_k8_slice_i_3_ack_g) && s1_k8_slice_i_4_ack_g) && s1_k8_slice_i_5_ack_g) && s1_k8_slice_i_6_ack_g) && s1_k8_slice_i_7_ack_g);
  assign s1_k9_slice_0 = _zz_s1_k9_slice_0;
  assign s1_k9_slice_1 = _zz_s1_k9_slice_1;
  assign s1_k9_slice_2 = _zz_s1_k9_slice_2;
  assign s1_k9_slice_3 = _zz_s1_k9_slice_3;
  assign s1_k9_slice_4 = _zz_s1_k9_slice_4;
  assign s1_k9_slice_5 = _zz_s1_k9_slice_5;
  assign s1_k9_slice_6 = _zz_s1_k9_slice_6;
  assign s1_k9_slice_7 = _zz_s1_k9_slice_7;
  assign s1_k9_slice_0_req = (k9_funnel_1_to_s1_k9_slice_req && (! s1_k9_slice_i_0_req_reg));
  assign s1_k9_slice_i_0_ack_g = (s1_k9_slice_0_ack || (! s1_k9_slice_0_req));
  assign s1_k9_slice_1_req = (k9_funnel_1_to_s1_k9_slice_req && (! s1_k9_slice_i_1_req_reg));
  assign s1_k9_slice_i_1_ack_g = (s1_k9_slice_1_ack || (! s1_k9_slice_1_req));
  assign s1_k9_slice_2_req = (k9_funnel_1_to_s1_k9_slice_req && (! s1_k9_slice_i_2_req_reg));
  assign s1_k9_slice_i_2_ack_g = (s1_k9_slice_2_ack || (! s1_k9_slice_2_req));
  assign s1_k9_slice_3_req = (k9_funnel_1_to_s1_k9_slice_req && (! s1_k9_slice_i_3_req_reg));
  assign s1_k9_slice_i_3_ack_g = (s1_k9_slice_3_ack || (! s1_k9_slice_3_req));
  assign s1_k9_slice_4_req = (k9_funnel_1_to_s1_k9_slice_req && (! s1_k9_slice_i_4_req_reg));
  assign s1_k9_slice_i_4_ack_g = (s1_k9_slice_4_ack || (! s1_k9_slice_4_req));
  assign s1_k9_slice_5_req = (k9_funnel_1_to_s1_k9_slice_req && (! s1_k9_slice_i_5_req_reg));
  assign s1_k9_slice_i_5_ack_g = (s1_k9_slice_5_ack || (! s1_k9_slice_5_req));
  assign s1_k9_slice_6_req = (k9_funnel_1_to_s1_k9_slice_req && (! s1_k9_slice_i_6_req_reg));
  assign s1_k9_slice_i_6_ack_g = (s1_k9_slice_6_ack || (! s1_k9_slice_6_req));
  assign s1_k9_slice_7_req = (k9_funnel_1_to_s1_k9_slice_req && (! s1_k9_slice_i_7_req_reg));
  assign s1_k9_slice_i_7_ack_g = (s1_k9_slice_7_ack || (! s1_k9_slice_7_req));
  assign k9_funnel_1_to_s1_k9_slice_ack = (((((((s1_k9_slice_i_0_ack_g && s1_k9_slice_i_1_ack_g) && s1_k9_slice_i_2_ack_g) && s1_k9_slice_i_3_ack_g) && s1_k9_slice_i_4_ack_g) && s1_k9_slice_i_5_ack_g) && s1_k9_slice_i_6_ack_g) && s1_k9_slice_i_7_ack_g);
  assign s1_cmul0_recip_norm_x = s1_k9_slice_0[15 : 0];
  assign s1_cmul0_recip_norm_mag = (_zz_s1_cmul0_recip_norm_mag + _zz_s1_cmul0_recip_norm_mag_2);
  always @(*) begin
    s1_cmul0_recip_norm_lz = 5'h10;
    if(s1_cmul0_recip_norm_mag[0]) begin
      s1_cmul0_recip_norm_lz = 5'h0f;
    end
    if(s1_cmul0_recip_norm_mag[1]) begin
      s1_cmul0_recip_norm_lz = 5'h0e;
    end
    if(s1_cmul0_recip_norm_mag[2]) begin
      s1_cmul0_recip_norm_lz = 5'h0d;
    end
    if(s1_cmul0_recip_norm_mag[3]) begin
      s1_cmul0_recip_norm_lz = 5'h0c;
    end
    if(s1_cmul0_recip_norm_mag[4]) begin
      s1_cmul0_recip_norm_lz = 5'h0b;
    end
    if(s1_cmul0_recip_norm_mag[5]) begin
      s1_cmul0_recip_norm_lz = 5'h0a;
    end
    if(s1_cmul0_recip_norm_mag[6]) begin
      s1_cmul0_recip_norm_lz = 5'h09;
    end
    if(s1_cmul0_recip_norm_mag[7]) begin
      s1_cmul0_recip_norm_lz = 5'h08;
    end
    if(s1_cmul0_recip_norm_mag[8]) begin
      s1_cmul0_recip_norm_lz = 5'h07;
    end
    if(s1_cmul0_recip_norm_mag[9]) begin
      s1_cmul0_recip_norm_lz = 5'h06;
    end
    if(s1_cmul0_recip_norm_mag[10]) begin
      s1_cmul0_recip_norm_lz = 5'h05;
    end
    if(s1_cmul0_recip_norm_mag[11]) begin
      s1_cmul0_recip_norm_lz = 5'h04;
    end
    if(s1_cmul0_recip_norm_mag[12]) begin
      s1_cmul0_recip_norm_lz = 5'h03;
    end
    if(s1_cmul0_recip_norm_mag[13]) begin
      s1_cmul0_recip_norm_lz = 5'h02;
    end
    if(s1_cmul0_recip_norm_mag[14]) begin
      s1_cmul0_recip_norm_lz = 5'h01;
    end
    if(s1_cmul0_recip_norm_mag[15]) begin
      s1_cmul0_recip_norm_lz = 5'h0;
    end
  end

  assign s1_cmul0_recip_norm_sat = (s1_cmul0_recip_norm_mag < 16'h0020);
  assign s1_cmul0_recip_norm_xn = (_zz_s1_cmul0_recip_norm_xn >>> 3'd6);
  assign s1_cmul0_recip_norm_0_nxt = {{{s1_cmul0_recip_norm_x[15],s1_cmul0_recip_norm_sat},s1_cmul0_recip_norm_lz},s1_cmul0_recip_norm_xn};
  assign s1_cmul0_recip_norm_0_req = s1_k9_slice_0_to_s1_cmul0_recip_norm_req;
  assign s1_k9_slice_0_to_s1_cmul0_recip_norm_ack = s1_cmul0_recip_norm_0_ack;
  assign _zz_s1_cmul0_recip_mul_y0 = s1_cmul0_recip_norm_0[9 : 0];
  assign s1_cmul0_recip_mul_y0 = (11'h5dd - _zz_s1_cmul0_recip_mul_y0_1);
  assign s1_cmul0_recip_mul_t = _zz_s1_cmul0_recip_mul_t[20 : 10];
  assign s1_cmul0_recip_mul_u = (11'h401 - s1_cmul0_recip_mul_t);
  assign s1_cmul0_recip_mul_0_nxt = {{s1_cmul0_recip_norm_0[16 : 10],s1_cmul0_recip_mul_u},s1_cmul0_recip_mul_y0};
  assign s1_cmul0_recip_mul_0_req = s1_cmul0_recip_norm_0_to_s1_cmul0_recip_mul_req;
  assign s1_cmul0_recip_norm_0_to_s1_cmul0_recip_mul_ack = s1_cmul0_recip_mul_0_ack;
  assign _zz_s1_cmul0_recip_out_rn = s1_cmul0_recip_mul_0[26 : 22];
  assign s1_cmul0_recip_out_r = {_zz_s1_cmul0_recip_out_r[21 : 10],2'b00};
  always @(*) begin
    if((_zz_s1_cmul0_recip_out_rn <= 5'h06)) begin
      s1_cmul0_recip_out_rn = {4'd0, _zz_s1_cmul0_recip_out_rn_1};
    end else begin
      s1_cmul0_recip_out_rn = (_zz_s1_cmul0_recip_out_rn_3 <<< _zz_s1_cmul0_recip_out_rn_4);
    end
  end

  assign s1_cmul0_recip_out_rmag = ((s1_cmul0_recip_mul_0[27] || (18'h08000 <= s1_cmul0_recip_out_rn)) ? 18'h07fff : s1_cmul0_recip_out_rn);
  assign s1_cmul0_recip_out_0_nxt = _zz_s1_cmul0_recip_out_0_nxt;
  assign s1_cmul0_recip_out_0_req = s1_cmul0_recip_mul_0_to_s1_cmul0_recip_out_req;
  assign s1_cmul0_recip_mul_0_to_s1_cmul0_recip_out_ack = s1_cmul0_recip_out_0_ack;
  assign s1_cmul0_m2c_ac_sel = cfg_s1_cmul0_m2c_ac;
  always @(*) begin
    case(s1_cmul0_m2c_ac_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_ac_0 = s1_k8_slice_0;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_ac_0 = s1_k9_slice_0;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_ac_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul0_m2c_ac_0 = s1_cmul0_recip_out_0;
      end
    endcase
  end

  assign s1_cmul0_m2c_ac_0 = _zz_s1_cmul0_m2c_ac_0;
  always @(*) begin
    case(s1_cmul0_m2c_ac_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_ac_0_req = s1_k8_slice_0_to_s1_cmul0_m2c_ac_req;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_ac_0_req = s1_k9_slice_0_to_s1_cmul0_m2c_ac_req;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_ac_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul0_m2c_ac_0_req = s1_cmul0_recip_out_0_to_s1_cmul0_m2c_ac_req;
      end
    endcase
  end

  assign s1_cmul0_m2c_ac_0_req = _zz_s1_cmul0_m2c_ac_0_req;
  assign s1_k8_slice_0_to_s1_cmul0_m2c_ac_ack = ((s1_cmul0_m2c_ac_sel != 2'b00) || s1_cmul0_m2c_ac_0_ack);
  assign s1_k9_slice_0_to_s1_cmul0_m2c_ac_ack = ((s1_cmul0_m2c_ac_sel != 2'b01) || s1_cmul0_m2c_ac_0_ack);
  assign s1_cmul0_recip_out_0_to_s1_cmul0_m2c_ac_ack = ((s1_cmul0_m2c_ac_sel != 2'b11) || s1_cmul0_m2c_ac_0_ack);
  assign cfg_s1_cmul0_m2c_ac_to_s1_cmul0_m2c_ac_ack = 1'b1;
  assign s1_cmul0_m2c_bc_sel = cfg_s1_cmul0_m2c_bc;
  always @(*) begin
    case(s1_cmul0_m2c_bc_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_bc_0 = s1_k8_slice_1;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_bc_0 = s1_k9_slice_0;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_bc_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul0_m2c_bc_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul0_m2c_bc_0 = _zz_s1_cmul0_m2c_bc_0;
  always @(*) begin
    case(s1_cmul0_m2c_bc_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_bc_0_req = s1_k8_slice_1_to_s1_cmul0_m2c_bc_req;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_bc_0_req = s1_k9_slice_0_to_s1_cmul0_m2c_bc_req;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_bc_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul0_m2c_bc_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul0_m2c_bc_0_req = _zz_s1_cmul0_m2c_bc_0_req;
  assign s1_k8_slice_1_to_s1_cmul0_m2c_bc_ack = ((s1_cmul0_m2c_bc_sel != 2'b00) || s1_cmul0_m2c_bc_0_ack);
  assign s1_k9_slice_0_to_s1_cmul0_m2c_bc_ack = ((s1_cmul0_m2c_bc_sel != 2'b01) || s1_cmul0_m2c_bc_0_ack);
  assign cfg_s1_cmul0_m2c_bc_to_s1_cmul0_m2c_bc_ack = 1'b1;
  assign s1_cmul0_m2c_bd_sel = cfg_s1_cmul0_m2c_bd;
  always @(*) begin
    case(s1_cmul0_m2c_bd_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_bd_0 = s1_k8_slice_1;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_bd_0 = s1_k9_slice_1;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_bd_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul0_m2c_bd_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul0_m2c_bd_0 = _zz_s1_cmul0_m2c_bd_0;
  always @(*) begin
    case(s1_cmul0_m2c_bd_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_bd_0_req = s1_k8_slice_1_to_s1_cmul0_m2c_bd_req;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_bd_0_req = s1_k9_slice_1_to_s1_cmul0_m2c_bd_req;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_bd_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul0_m2c_bd_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul0_m2c_bd_0_req = _zz_s1_cmul0_m2c_bd_0_req;
  assign s1_k8_slice_1_to_s1_cmul0_m2c_bd_ack = ((s1_cmul0_m2c_bd_sel != 2'b00) || s1_cmul0_m2c_bd_0_ack);
  assign s1_k9_slice_1_to_s1_cmul0_m2c_bd_ack = ((s1_cmul0_m2c_bd_sel != 2'b01) || s1_cmul0_m2c_bd_0_ack);
  assign cfg_s1_cmul0_m2c_bd_to_s1_cmul0_m2c_bd_ack = 1'b1;
  assign s1_cmul0_m2c_cb_sel = cfg_s1_cmul0_m2c_cb;
  always @(*) begin
    case(s1_cmul0_m2c_cb_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_cb_0 = s1_k9_slice_0;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_cb_0 = s1_k8_slice_1;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_cb_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul0_m2c_cb_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul0_m2c_cb_0 = _zz_s1_cmul0_m2c_cb_0;
  always @(*) begin
    case(s1_cmul0_m2c_cb_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_cb_0_req = s1_k9_slice_0_to_s1_cmul0_m2c_cb_req;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_cb_0_req = s1_k8_slice_1_to_s1_cmul0_m2c_cb_req;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_cb_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul0_m2c_cb_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul0_m2c_cb_0_req = _zz_s1_cmul0_m2c_cb_0_req;
  assign s1_k9_slice_0_to_s1_cmul0_m2c_cb_ack = ((s1_cmul0_m2c_cb_sel != 2'b00) || s1_cmul0_m2c_cb_0_ack);
  assign s1_k8_slice_1_to_s1_cmul0_m2c_cb_ack = ((s1_cmul0_m2c_cb_sel != 2'b01) || s1_cmul0_m2c_cb_0_ack);
  assign cfg_s1_cmul0_m2c_cb_to_s1_cmul0_m2c_cb_ack = 1'b1;
  assign s1_cmul0_m2c_cd_sel = cfg_s1_cmul0_m2c_cd;
  always @(*) begin
    case(s1_cmul0_m2c_cd_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_cd_0 = s1_k9_slice_0;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_cd_0 = s1_k9_slice_1;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_cd_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul0_m2c_cd_0 = s1_cmul0_recip_out_0;
      end
    endcase
  end

  assign s1_cmul0_m2c_cd_0 = _zz_s1_cmul0_m2c_cd_0;
  always @(*) begin
    case(s1_cmul0_m2c_cd_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_cd_0_req = s1_k9_slice_0_to_s1_cmul0_m2c_cd_req;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_cd_0_req = s1_k9_slice_1_to_s1_cmul0_m2c_cd_req;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_cd_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul0_m2c_cd_0_req = s1_cmul0_recip_out_0_to_s1_cmul0_m2c_cd_req;
      end
    endcase
  end

  assign s1_cmul0_m2c_cd_0_req = _zz_s1_cmul0_m2c_cd_0_req;
  assign s1_k9_slice_0_to_s1_cmul0_m2c_cd_ack = ((s1_cmul0_m2c_cd_sel != 2'b00) || s1_cmul0_m2c_cd_0_ack);
  assign s1_k9_slice_1_to_s1_cmul0_m2c_cd_ack = ((s1_cmul0_m2c_cd_sel != 2'b01) || s1_cmul0_m2c_cd_0_ack);
  assign s1_cmul0_recip_out_0_to_s1_cmul0_m2c_cd_ack = ((s1_cmul0_m2c_cd_sel != 2'b11) || s1_cmul0_m2c_cd_0_ack);
  assign cfg_s1_cmul0_m2c_cd_to_s1_cmul0_m2c_cd_ack = 1'b1;
  assign s1_cmul0_m2c_da_sel = cfg_s1_cmul0_m2c_da;
  always @(*) begin
    case(s1_cmul0_m2c_da_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_da_0 = s1_k9_slice_1;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_da_0 = s1_k8_slice_0;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_da_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul0_m2c_da_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul0_m2c_da_0 = _zz_s1_cmul0_m2c_da_0;
  always @(*) begin
    case(s1_cmul0_m2c_da_sel)
      2'b00 : begin
        _zz_s1_cmul0_m2c_da_0_req = s1_k9_slice_1_to_s1_cmul0_m2c_da_req;
      end
      2'b01 : begin
        _zz_s1_cmul0_m2c_da_0_req = s1_k8_slice_0_to_s1_cmul0_m2c_da_req;
      end
      2'b10 : begin
        _zz_s1_cmul0_m2c_da_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul0_m2c_da_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul0_m2c_da_0_req = _zz_s1_cmul0_m2c_da_0_req;
  assign s1_k9_slice_1_to_s1_cmul0_m2c_da_ack = ((s1_cmul0_m2c_da_sel != 2'b00) || s1_cmul0_m2c_da_0_ack);
  assign s1_k8_slice_0_to_s1_cmul0_m2c_da_ack = ((s1_cmul0_m2c_da_sel != 2'b01) || s1_cmul0_m2c_da_0_ack);
  assign cfg_s1_cmul0_m2c_da_to_s1_cmul0_m2c_da_ack = 1'b1;
  assign s1_cmul0_cat_re_0_nxt = {s1_cmul0_m2c_bd_0,{s1_cmul0_m2c_bc_0,{s1_cmul0_m2c_ac_0,s1_k8_slice_0}}};
  assign s1_cmul0_cat_re_0_req = (((s1_k8_slice_0_to_s1_cmul0_cat_re_req && s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_req);
  assign s1_k8_slice_0_to_s1_cmul0_cat_re_ack = (((s1_cmul0_cat_re_0_ack && s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_req);
  assign s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_ack = (((s1_cmul0_cat_re_0_ack && s1_k8_slice_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_req);
  assign s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_ack = (((s1_cmul0_cat_re_0_ack && s1_k8_slice_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_req);
  assign s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_ack = (((s1_cmul0_cat_re_0_ack && s1_k8_slice_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_req) && s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_req);
  assign s1_cmul0_cat_im_0_nxt = {s1_cmul0_m2c_da_0,{s1_k9_slice_1,{s1_cmul0_m2c_cd_0,s1_cmul0_m2c_cb_0}}};
  assign s1_cmul0_cat_im_0_req = (((s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_req && s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_req) && s1_k9_slice_1_to_s1_cmul0_cat_im_req) && s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_req);
  assign s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_ack = (((s1_cmul0_cat_im_0_ack && s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_req) && s1_k9_slice_1_to_s1_cmul0_cat_im_req) && s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_req);
  assign s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_ack = (((s1_cmul0_cat_im_0_ack && s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_req) && s1_k9_slice_1_to_s1_cmul0_cat_im_req) && s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_req);
  assign s1_k9_slice_1_to_s1_cmul0_cat_im_ack = (((s1_cmul0_cat_im_0_ack && s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_req) && s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_req) && s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_req);
  assign s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_ack = (((s1_cmul0_cat_im_0_ack && s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_req) && s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_req) && s1_k9_slice_1_to_s1_cmul0_cat_im_req);
  assign cfg_s1_cmul0_mas_re_to_s1_cmul0_mas_re_ack = 1'b1;
  assign s1_cmul0_mas_re_s1_en = ((s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_req && s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_ack) || s1_cmul0_mas_re_cfg_valid[3]);
  assign s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_ack = ((! s1_cmul0_mas_re_s1_valid) || s1_cmul0_mas_re_s1_ack);
  assign s1_cmul0_mas_re_s2_en = ((s1_cmul0_mas_re_s1_valid && s1_cmul0_mas_re_s1_ack) || s1_cmul0_mas_re_cfg_valid[3]);
  assign s1_cmul0_mas_re_s1_ack = ((! s1_cmul0_mas_re_s2_valid) || s1_cmul0_mas_re_s2_ack);
  assign s1_cmul0_mas_re_s3_en = ((s1_cmul0_mas_re_s2_valid && s1_cmul0_mas_re_s2_ack) || s1_cmul0_mas_re_cfg_valid[3]);
  assign s1_cmul0_mas_re_s2_ack = ((! s1_cmul0_mas_re_s3_valid) || s1_cmul0_mas_re_0_ack);
  assign s1_cmul0_mas_re_0_req = s1_cmul0_mas_re_s3_valid;
  assign s1_cmul0_mas_re_CLK0 = clk;
  assign s1_cmul0_mas_re_RST0 = (! reset_n);
  assign s1_cmul0_mas_re_CE0 = s1_cmul0_mas_re_s1_en;
  assign s1_cmul0_mas_re_CE1 = s1_cmul0_mas_re_s2_en;
  assign s1_cmul0_mas_re_CE2 = s1_cmul0_mas_re_s3_en;
  assign s1_cmul0_mas_re_ADDNSUB = cfg_s1_cmul0_mas_re[0];
  assign s1_cmul0_mas_re_A0 = s1_cmul0_cat_re_0[17 : 0];
  assign s1_cmul0_mas_re_B0 = s1_cmul0_cat_re_0[35 : 18];
  assign s1_cmul0_mas_re_A1 = s1_cmul0_cat_re_0[53 : 36];
  assign s1_cmul0_mas_re_B1 = s1_cmul0_cat_re_0[71 : 54];
  assign s1_cmul0_mas_re_0 = s1_cmul0_mas_re_SUM;
  assign cfg_s1_cmul0_mas_im_to_s1_cmul0_mas_im_ack = 1'b1;
  assign s1_cmul0_mas_im_s1_en = ((s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_req && s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_ack) || s1_cmul0_mas_im_cfg_valid[3]);
  assign s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_ack = ((! s1_cmul0_mas_im_s1_valid) || s1_cmul0_mas_im_s1_ack);
  assign s1_cmul0_mas_im_s2_en = ((s1_cmul0_mas_im_s1_valid && s1_cmul0_mas_im_s1_ack) || s1_cmul0_mas_im_cfg_valid[3]);
  assign s1_cmul0_mas_im_s1_ack = ((! s1_cmul0_mas_im_s2_valid) || s1_cmul0_mas_im_s2_ack);
  assign s1_cmul0_mas_im_s3_en = ((s1_cmul0_mas_im_s2_valid && s1_cmul0_mas_im_s2_ack) || s1_cmul0_mas_im_cfg_valid[3]);
  assign s1_cmul0_mas_im_s2_ack = ((! s1_cmul0_mas_im_s3_valid) || s1_cmul0_mas_im_0_ack);
  assign s1_cmul0_mas_im_0_req = s1_cmul0_mas_im_s3_valid;
  assign s1_cmul0_mas_im_CLK0 = clk;
  assign s1_cmul0_mas_im_RST0 = (! reset_n);
  assign s1_cmul0_mas_im_CE0 = s1_cmul0_mas_im_s1_en;
  assign s1_cmul0_mas_im_CE1 = s1_cmul0_mas_im_s2_en;
  assign s1_cmul0_mas_im_CE2 = s1_cmul0_mas_im_s3_en;
  assign s1_cmul0_mas_im_ADDNSUB = cfg_s1_cmul0_mas_im[0];
  assign s1_cmul0_mas_im_A0 = s1_cmul0_cat_im_0[17 : 0];
  assign s1_cmul0_mas_im_B0 = s1_cmul0_cat_im_0[35 : 18];
  assign s1_cmul0_mas_im_A1 = s1_cmul0_cat_im_0[53 : 36];
  assign s1_cmul0_mas_im_B1 = s1_cmul0_cat_im_0[71 : 54];
  assign s1_cmul0_mas_im_0 = s1_cmul0_mas_im_SUM;
  assign s1_cmul1_recip_norm_x = s1_k9_slice_2[15 : 0];
  assign s1_cmul1_recip_norm_mag = (_zz_s1_cmul1_recip_norm_mag + _zz_s1_cmul1_recip_norm_mag_2);
  always @(*) begin
    s1_cmul1_recip_norm_lz = 5'h10;
    if(s1_cmul1_recip_norm_mag[0]) begin
      s1_cmul1_recip_norm_lz = 5'h0f;
    end
    if(s1_cmul1_recip_norm_mag[1]) begin
      s1_cmul1_recip_norm_lz = 5'h0e;
    end
    if(s1_cmul1_recip_norm_mag[2]) begin
      s1_cmul1_recip_norm_lz = 5'h0d;
    end
    if(s1_cmul1_recip_norm_mag[3]) begin
      s1_cmul1_recip_norm_lz = 5'h0c;
    end
    if(s1_cmul1_recip_norm_mag[4]) begin
      s1_cmul1_recip_norm_lz = 5'h0b;
    end
    if(s1_cmul1_recip_norm_mag[5]) begin
      s1_cmul1_recip_norm_lz = 5'h0a;
    end
    if(s1_cmul1_recip_norm_mag[6]) begin
      s1_cmul1_recip_norm_lz = 5'h09;
    end
    if(s1_cmul1_recip_norm_mag[7]) begin
      s1_cmul1_recip_norm_lz = 5'h08;
    end
    if(s1_cmul1_recip_norm_mag[8]) begin
      s1_cmul1_recip_norm_lz = 5'h07;
    end
    if(s1_cmul1_recip_norm_mag[9]) begin
      s1_cmul1_recip_norm_lz = 5'h06;
    end
    if(s1_cmul1_recip_norm_mag[10]) begin
      s1_cmul1_recip_norm_lz = 5'h05;
    end
    if(s1_cmul1_recip_norm_mag[11]) begin
      s1_cmul1_recip_norm_lz = 5'h04;
    end
    if(s1_cmul1_recip_norm_mag[12]) begin
      s1_cmul1_recip_norm_lz = 5'h03;
    end
    if(s1_cmul1_recip_norm_mag[13]) begin
      s1_cmul1_recip_norm_lz = 5'h02;
    end
    if(s1_cmul1_recip_norm_mag[14]) begin
      s1_cmul1_recip_norm_lz = 5'h01;
    end
    if(s1_cmul1_recip_norm_mag[15]) begin
      s1_cmul1_recip_norm_lz = 5'h0;
    end
  end

  assign s1_cmul1_recip_norm_sat = (s1_cmul1_recip_norm_mag < 16'h0020);
  assign s1_cmul1_recip_norm_xn = (_zz_s1_cmul1_recip_norm_xn >>> 3'd6);
  assign s1_cmul1_recip_norm_0_nxt = {{{s1_cmul1_recip_norm_x[15],s1_cmul1_recip_norm_sat},s1_cmul1_recip_norm_lz},s1_cmul1_recip_norm_xn};
  assign s1_cmul1_recip_norm_0_req = s1_k9_slice_2_to_s1_cmul1_recip_norm_req;
  assign s1_k9_slice_2_to_s1_cmul1_recip_norm_ack = s1_cmul1_recip_norm_0_ack;
  assign _zz_s1_cmul1_recip_mul_y0 = s1_cmul1_recip_norm_0[9 : 0];
  assign s1_cmul1_recip_mul_y0 = (11'h5dd - _zz_s1_cmul1_recip_mul_y0_1);
  assign s1_cmul1_recip_mul_t = _zz_s1_cmul1_recip_mul_t[20 : 10];
  assign s1_cmul1_recip_mul_u = (11'h401 - s1_cmul1_recip_mul_t);
  assign s1_cmul1_recip_mul_0_nxt = {{s1_cmul1_recip_norm_0[16 : 10],s1_cmul1_recip_mul_u},s1_cmul1_recip_mul_y0};
  assign s1_cmul1_recip_mul_0_req = s1_cmul1_recip_norm_0_to_s1_cmul1_recip_mul_req;
  assign s1_cmul1_recip_norm_0_to_s1_cmul1_recip_mul_ack = s1_cmul1_recip_mul_0_ack;
  assign _zz_s1_cmul1_recip_out_rn = s1_cmul1_recip_mul_0[26 : 22];
  assign s1_cmul1_recip_out_r = {_zz_s1_cmul1_recip_out_r[21 : 10],2'b00};
  always @(*) begin
    if((_zz_s1_cmul1_recip_out_rn <= 5'h06)) begin
      s1_cmul1_recip_out_rn = {4'd0, _zz_s1_cmul1_recip_out_rn_1};
    end else begin
      s1_cmul1_recip_out_rn = (_zz_s1_cmul1_recip_out_rn_3 <<< _zz_s1_cmul1_recip_out_rn_4);
    end
  end

  assign s1_cmul1_recip_out_rmag = ((s1_cmul1_recip_mul_0[27] || (18'h08000 <= s1_cmul1_recip_out_rn)) ? 18'h07fff : s1_cmul1_recip_out_rn);
  assign s1_cmul1_recip_out_0_nxt = _zz_s1_cmul1_recip_out_0_nxt;
  assign s1_cmul1_recip_out_0_req = s1_cmul1_recip_mul_0_to_s1_cmul1_recip_out_req;
  assign s1_cmul1_recip_mul_0_to_s1_cmul1_recip_out_ack = s1_cmul1_recip_out_0_ack;
  assign s1_cmul1_m2c_ac_sel = cfg_s1_cmul1_m2c_ac;
  always @(*) begin
    case(s1_cmul1_m2c_ac_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_ac_0 = s1_k8_slice_2;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_ac_0 = s1_k9_slice_2;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_ac_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul1_m2c_ac_0 = s1_cmul1_recip_out_0;
      end
    endcase
  end

  assign s1_cmul1_m2c_ac_0 = _zz_s1_cmul1_m2c_ac_0;
  always @(*) begin
    case(s1_cmul1_m2c_ac_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_ac_0_req = s1_k8_slice_2_to_s1_cmul1_m2c_ac_req;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_ac_0_req = s1_k9_slice_2_to_s1_cmul1_m2c_ac_req;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_ac_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul1_m2c_ac_0_req = s1_cmul1_recip_out_0_to_s1_cmul1_m2c_ac_req;
      end
    endcase
  end

  assign s1_cmul1_m2c_ac_0_req = _zz_s1_cmul1_m2c_ac_0_req;
  assign s1_k8_slice_2_to_s1_cmul1_m2c_ac_ack = ((s1_cmul1_m2c_ac_sel != 2'b00) || s1_cmul1_m2c_ac_0_ack);
  assign s1_k9_slice_2_to_s1_cmul1_m2c_ac_ack = ((s1_cmul1_m2c_ac_sel != 2'b01) || s1_cmul1_m2c_ac_0_ack);
  assign s1_cmul1_recip_out_0_to_s1_cmul1_m2c_ac_ack = ((s1_cmul1_m2c_ac_sel != 2'b11) || s1_cmul1_m2c_ac_0_ack);
  assign cfg_s1_cmul1_m2c_ac_to_s1_cmul1_m2c_ac_ack = 1'b1;
  assign s1_cmul1_m2c_bc_sel = cfg_s1_cmul1_m2c_bc;
  always @(*) begin
    case(s1_cmul1_m2c_bc_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_bc_0 = s1_k8_slice_3;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_bc_0 = s1_k9_slice_2;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_bc_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul1_m2c_bc_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul1_m2c_bc_0 = _zz_s1_cmul1_m2c_bc_0;
  always @(*) begin
    case(s1_cmul1_m2c_bc_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_bc_0_req = s1_k8_slice_3_to_s1_cmul1_m2c_bc_req;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_bc_0_req = s1_k9_slice_2_to_s1_cmul1_m2c_bc_req;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_bc_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul1_m2c_bc_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul1_m2c_bc_0_req = _zz_s1_cmul1_m2c_bc_0_req;
  assign s1_k8_slice_3_to_s1_cmul1_m2c_bc_ack = ((s1_cmul1_m2c_bc_sel != 2'b00) || s1_cmul1_m2c_bc_0_ack);
  assign s1_k9_slice_2_to_s1_cmul1_m2c_bc_ack = ((s1_cmul1_m2c_bc_sel != 2'b01) || s1_cmul1_m2c_bc_0_ack);
  assign cfg_s1_cmul1_m2c_bc_to_s1_cmul1_m2c_bc_ack = 1'b1;
  assign s1_cmul1_m2c_bd_sel = cfg_s1_cmul1_m2c_bd;
  always @(*) begin
    case(s1_cmul1_m2c_bd_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_bd_0 = s1_k8_slice_3;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_bd_0 = s1_k9_slice_3;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_bd_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul1_m2c_bd_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul1_m2c_bd_0 = _zz_s1_cmul1_m2c_bd_0;
  always @(*) begin
    case(s1_cmul1_m2c_bd_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_bd_0_req = s1_k8_slice_3_to_s1_cmul1_m2c_bd_req;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_bd_0_req = s1_k9_slice_3_to_s1_cmul1_m2c_bd_req;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_bd_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul1_m2c_bd_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul1_m2c_bd_0_req = _zz_s1_cmul1_m2c_bd_0_req;
  assign s1_k8_slice_3_to_s1_cmul1_m2c_bd_ack = ((s1_cmul1_m2c_bd_sel != 2'b00) || s1_cmul1_m2c_bd_0_ack);
  assign s1_k9_slice_3_to_s1_cmul1_m2c_bd_ack = ((s1_cmul1_m2c_bd_sel != 2'b01) || s1_cmul1_m2c_bd_0_ack);
  assign cfg_s1_cmul1_m2c_bd_to_s1_cmul1_m2c_bd_ack = 1'b1;
  assign s1_cmul1_m2c_cb_sel = cfg_s1_cmul1_m2c_cb;
  always @(*) begin
    case(s1_cmul1_m2c_cb_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_cb_0 = s1_k9_slice_2;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_cb_0 = s1_k8_slice_3;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_cb_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul1_m2c_cb_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul1_m2c_cb_0 = _zz_s1_cmul1_m2c_cb_0;
  always @(*) begin
    case(s1_cmul1_m2c_cb_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_cb_0_req = s1_k9_slice_2_to_s1_cmul1_m2c_cb_req;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_cb_0_req = s1_k8_slice_3_to_s1_cmul1_m2c_cb_req;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_cb_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul1_m2c_cb_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul1_m2c_cb_0_req = _zz_s1_cmul1_m2c_cb_0_req;
  assign s1_k9_slice_2_to_s1_cmul1_m2c_cb_ack = ((s1_cmul1_m2c_cb_sel != 2'b00) || s1_cmul1_m2c_cb_0_ack);
  assign s1_k8_slice_3_to_s1_cmul1_m2c_cb_ack = ((s1_cmul1_m2c_cb_sel != 2'b01) || s1_cmul1_m2c_cb_0_ack);
  assign cfg_s1_cmul1_m2c_cb_to_s1_cmul1_m2c_cb_ack = 1'b1;
  assign s1_cmul1_m2c_cd_sel = cfg_s1_cmul1_m2c_cd;
  always @(*) begin
    case(s1_cmul1_m2c_cd_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_cd_0 = s1_k9_slice_2;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_cd_0 = s1_k9_slice_3;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_cd_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul1_m2c_cd_0 = s1_cmul1_recip_out_0;
      end
    endcase
  end

  assign s1_cmul1_m2c_cd_0 = _zz_s1_cmul1_m2c_cd_0;
  always @(*) begin
    case(s1_cmul1_m2c_cd_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_cd_0_req = s1_k9_slice_2_to_s1_cmul1_m2c_cd_req;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_cd_0_req = s1_k9_slice_3_to_s1_cmul1_m2c_cd_req;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_cd_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul1_m2c_cd_0_req = s1_cmul1_recip_out_0_to_s1_cmul1_m2c_cd_req;
      end
    endcase
  end

  assign s1_cmul1_m2c_cd_0_req = _zz_s1_cmul1_m2c_cd_0_req;
  assign s1_k9_slice_2_to_s1_cmul1_m2c_cd_ack = ((s1_cmul1_m2c_cd_sel != 2'b00) || s1_cmul1_m2c_cd_0_ack);
  assign s1_k9_slice_3_to_s1_cmul1_m2c_cd_ack = ((s1_cmul1_m2c_cd_sel != 2'b01) || s1_cmul1_m2c_cd_0_ack);
  assign s1_cmul1_recip_out_0_to_s1_cmul1_m2c_cd_ack = ((s1_cmul1_m2c_cd_sel != 2'b11) || s1_cmul1_m2c_cd_0_ack);
  assign cfg_s1_cmul1_m2c_cd_to_s1_cmul1_m2c_cd_ack = 1'b1;
  assign s1_cmul1_m2c_da_sel = cfg_s1_cmul1_m2c_da;
  always @(*) begin
    case(s1_cmul1_m2c_da_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_da_0 = s1_k9_slice_3;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_da_0 = s1_k8_slice_2;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_da_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul1_m2c_da_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul1_m2c_da_0 = _zz_s1_cmul1_m2c_da_0;
  always @(*) begin
    case(s1_cmul1_m2c_da_sel)
      2'b00 : begin
        _zz_s1_cmul1_m2c_da_0_req = s1_k9_slice_3_to_s1_cmul1_m2c_da_req;
      end
      2'b01 : begin
        _zz_s1_cmul1_m2c_da_0_req = s1_k8_slice_2_to_s1_cmul1_m2c_da_req;
      end
      2'b10 : begin
        _zz_s1_cmul1_m2c_da_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul1_m2c_da_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul1_m2c_da_0_req = _zz_s1_cmul1_m2c_da_0_req;
  assign s1_k9_slice_3_to_s1_cmul1_m2c_da_ack = ((s1_cmul1_m2c_da_sel != 2'b00) || s1_cmul1_m2c_da_0_ack);
  assign s1_k8_slice_2_to_s1_cmul1_m2c_da_ack = ((s1_cmul1_m2c_da_sel != 2'b01) || s1_cmul1_m2c_da_0_ack);
  assign cfg_s1_cmul1_m2c_da_to_s1_cmul1_m2c_da_ack = 1'b1;
  assign s1_cmul1_cat_re_0_nxt = {s1_cmul1_m2c_bd_0,{s1_cmul1_m2c_bc_0,{s1_cmul1_m2c_ac_0,s1_k8_slice_2}}};
  assign s1_cmul1_cat_re_0_req = (((s1_k8_slice_2_to_s1_cmul1_cat_re_req && s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_req);
  assign s1_k8_slice_2_to_s1_cmul1_cat_re_ack = (((s1_cmul1_cat_re_0_ack && s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_req);
  assign s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_ack = (((s1_cmul1_cat_re_0_ack && s1_k8_slice_2_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_req);
  assign s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_ack = (((s1_cmul1_cat_re_0_ack && s1_k8_slice_2_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_req);
  assign s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_ack = (((s1_cmul1_cat_re_0_ack && s1_k8_slice_2_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_req) && s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_req);
  assign s1_cmul1_cat_im_0_nxt = {s1_cmul1_m2c_da_0,{s1_k9_slice_3,{s1_cmul1_m2c_cd_0,s1_cmul1_m2c_cb_0}}};
  assign s1_cmul1_cat_im_0_req = (((s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_req && s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_req) && s1_k9_slice_3_to_s1_cmul1_cat_im_req) && s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_req);
  assign s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_ack = (((s1_cmul1_cat_im_0_ack && s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_req) && s1_k9_slice_3_to_s1_cmul1_cat_im_req) && s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_req);
  assign s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_ack = (((s1_cmul1_cat_im_0_ack && s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_req) && s1_k9_slice_3_to_s1_cmul1_cat_im_req) && s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_req);
  assign s1_k9_slice_3_to_s1_cmul1_cat_im_ack = (((s1_cmul1_cat_im_0_ack && s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_req) && s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_req) && s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_req);
  assign s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_ack = (((s1_cmul1_cat_im_0_ack && s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_req) && s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_req) && s1_k9_slice_3_to_s1_cmul1_cat_im_req);
  assign cfg_s1_cmul1_mas_re_to_s1_cmul1_mas_re_ack = 1'b1;
  assign s1_cmul1_mas_re_s1_en = ((s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_req && s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_ack) || s1_cmul1_mas_re_cfg_valid[3]);
  assign s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_ack = ((! s1_cmul1_mas_re_s1_valid) || s1_cmul1_mas_re_s1_ack);
  assign s1_cmul1_mas_re_s2_en = ((s1_cmul1_mas_re_s1_valid && s1_cmul1_mas_re_s1_ack) || s1_cmul1_mas_re_cfg_valid[3]);
  assign s1_cmul1_mas_re_s1_ack = ((! s1_cmul1_mas_re_s2_valid) || s1_cmul1_mas_re_s2_ack);
  assign s1_cmul1_mas_re_s3_en = ((s1_cmul1_mas_re_s2_valid && s1_cmul1_mas_re_s2_ack) || s1_cmul1_mas_re_cfg_valid[3]);
  assign s1_cmul1_mas_re_s2_ack = ((! s1_cmul1_mas_re_s3_valid) || s1_cmul1_mas_re_0_ack);
  assign s1_cmul1_mas_re_0_req = s1_cmul1_mas_re_s3_valid;
  assign s1_cmul1_mas_re_CLK0 = clk;
  assign s1_cmul1_mas_re_RST0 = (! reset_n);
  assign s1_cmul1_mas_re_CE0 = s1_cmul1_mas_re_s1_en;
  assign s1_cmul1_mas_re_CE1 = s1_cmul1_mas_re_s2_en;
  assign s1_cmul1_mas_re_CE2 = s1_cmul1_mas_re_s3_en;
  assign s1_cmul1_mas_re_ADDNSUB = cfg_s1_cmul1_mas_re[0];
  assign s1_cmul1_mas_re_A0 = s1_cmul1_cat_re_0[17 : 0];
  assign s1_cmul1_mas_re_B0 = s1_cmul1_cat_re_0[35 : 18];
  assign s1_cmul1_mas_re_A1 = s1_cmul1_cat_re_0[53 : 36];
  assign s1_cmul1_mas_re_B1 = s1_cmul1_cat_re_0[71 : 54];
  assign s1_cmul1_mas_re_0 = s1_cmul1_mas_re_SUM;
  assign cfg_s1_cmul1_mas_im_to_s1_cmul1_mas_im_ack = 1'b1;
  assign s1_cmul1_mas_im_s1_en = ((s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_req && s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_ack) || s1_cmul1_mas_im_cfg_valid[3]);
  assign s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_ack = ((! s1_cmul1_mas_im_s1_valid) || s1_cmul1_mas_im_s1_ack);
  assign s1_cmul1_mas_im_s2_en = ((s1_cmul1_mas_im_s1_valid && s1_cmul1_mas_im_s1_ack) || s1_cmul1_mas_im_cfg_valid[3]);
  assign s1_cmul1_mas_im_s1_ack = ((! s1_cmul1_mas_im_s2_valid) || s1_cmul1_mas_im_s2_ack);
  assign s1_cmul1_mas_im_s3_en = ((s1_cmul1_mas_im_s2_valid && s1_cmul1_mas_im_s2_ack) || s1_cmul1_mas_im_cfg_valid[3]);
  assign s1_cmul1_mas_im_s2_ack = ((! s1_cmul1_mas_im_s3_valid) || s1_cmul1_mas_im_0_ack);
  assign s1_cmul1_mas_im_0_req = s1_cmul1_mas_im_s3_valid;
  assign s1_cmul1_mas_im_CLK0 = clk;
  assign s1_cmul1_mas_im_RST0 = (! reset_n);
  assign s1_cmul1_mas_im_CE0 = s1_cmul1_mas_im_s1_en;
  assign s1_cmul1_mas_im_CE1 = s1_cmul1_mas_im_s2_en;
  assign s1_cmul1_mas_im_CE2 = s1_cmul1_mas_im_s3_en;
  assign s1_cmul1_mas_im_ADDNSUB = cfg_s1_cmul1_mas_im[0];
  assign s1_cmul1_mas_im_A0 = s1_cmul1_cat_im_0[17 : 0];
  assign s1_cmul1_mas_im_B0 = s1_cmul1_cat_im_0[35 : 18];
  assign s1_cmul1_mas_im_A1 = s1_cmul1_cat_im_0[53 : 36];
  assign s1_cmul1_mas_im_B1 = s1_cmul1_cat_im_0[71 : 54];
  assign s1_cmul1_mas_im_0 = s1_cmul1_mas_im_SUM;
  assign s1_cmul2_recip_norm_x = s1_k9_slice_4[15 : 0];
  assign s1_cmul2_recip_norm_mag = (_zz_s1_cmul2_recip_norm_mag + _zz_s1_cmul2_recip_norm_mag_2);
  always @(*) begin
    s1_cmul2_recip_norm_lz = 5'h10;
    if(s1_cmul2_recip_norm_mag[0]) begin
      s1_cmul2_recip_norm_lz = 5'h0f;
    end
    if(s1_cmul2_recip_norm_mag[1]) begin
      s1_cmul2_recip_norm_lz = 5'h0e;
    end
    if(s1_cmul2_recip_norm_mag[2]) begin
      s1_cmul2_recip_norm_lz = 5'h0d;
    end
    if(s1_cmul2_recip_norm_mag[3]) begin
      s1_cmul2_recip_norm_lz = 5'h0c;
    end
    if(s1_cmul2_recip_norm_mag[4]) begin
      s1_cmul2_recip_norm_lz = 5'h0b;
    end
    if(s1_cmul2_recip_norm_mag[5]) begin
      s1_cmul2_recip_norm_lz = 5'h0a;
    end
    if(s1_cmul2_recip_norm_mag[6]) begin
      s1_cmul2_recip_norm_lz = 5'h09;
    end
    if(s1_cmul2_recip_norm_mag[7]) begin
      s1_cmul2_recip_norm_lz = 5'h08;
    end
    if(s1_cmul2_recip_norm_mag[8]) begin
      s1_cmul2_recip_norm_lz = 5'h07;
    end
    if(s1_cmul2_recip_norm_mag[9]) begin
      s1_cmul2_recip_norm_lz = 5'h06;
    end
    if(s1_cmul2_recip_norm_mag[10]) begin
      s1_cmul2_recip_norm_lz = 5'h05;
    end
    if(s1_cmul2_recip_norm_mag[11]) begin
      s1_cmul2_recip_norm_lz = 5'h04;
    end
    if(s1_cmul2_recip_norm_mag[12]) begin
      s1_cmul2_recip_norm_lz = 5'h03;
    end
    if(s1_cmul2_recip_norm_mag[13]) begin
      s1_cmul2_recip_norm_lz = 5'h02;
    end
    if(s1_cmul2_recip_norm_mag[14]) begin
      s1_cmul2_recip_norm_lz = 5'h01;
    end
    if(s1_cmul2_recip_norm_mag[15]) begin
      s1_cmul2_recip_norm_lz = 5'h0;
    end
  end

  assign s1_cmul2_recip_norm_sat = (s1_cmul2_recip_norm_mag < 16'h0020);
  assign s1_cmul2_recip_norm_xn = (_zz_s1_cmul2_recip_norm_xn >>> 3'd6);
  assign s1_cmul2_recip_norm_0_nxt = {{{s1_cmul2_recip_norm_x[15],s1_cmul2_recip_norm_sat},s1_cmul2_recip_norm_lz},s1_cmul2_recip_norm_xn};
  assign s1_cmul2_recip_norm_0_req = s1_k9_slice_4_to_s1_cmul2_recip_norm_req;
  assign s1_k9_slice_4_to_s1_cmul2_recip_norm_ack = s1_cmul2_recip_norm_0_ack;
  assign _zz_s1_cmul2_recip_mul_y0 = s1_cmul2_recip_norm_0[9 : 0];
  assign s1_cmul2_recip_mul_y0 = (11'h5dd - _zz_s1_cmul2_recip_mul_y0_1);
  assign s1_cmul2_recip_mul_t = _zz_s1_cmul2_recip_mul_t[20 : 10];
  assign s1_cmul2_recip_mul_u = (11'h401 - s1_cmul2_recip_mul_t);
  assign s1_cmul2_recip_mul_0_nxt = {{s1_cmul2_recip_norm_0[16 : 10],s1_cmul2_recip_mul_u},s1_cmul2_recip_mul_y0};
  assign s1_cmul2_recip_mul_0_req = s1_cmul2_recip_norm_0_to_s1_cmul2_recip_mul_req;
  assign s1_cmul2_recip_norm_0_to_s1_cmul2_recip_mul_ack = s1_cmul2_recip_mul_0_ack;
  assign _zz_s1_cmul2_recip_out_rn = s1_cmul2_recip_mul_0[26 : 22];
  assign s1_cmul2_recip_out_r = {_zz_s1_cmul2_recip_out_r[21 : 10],2'b00};
  always @(*) begin
    if((_zz_s1_cmul2_recip_out_rn <= 5'h06)) begin
      s1_cmul2_recip_out_rn = {4'd0, _zz_s1_cmul2_recip_out_rn_1};
    end else begin
      s1_cmul2_recip_out_rn = (_zz_s1_cmul2_recip_out_rn_3 <<< _zz_s1_cmul2_recip_out_rn_4);
    end
  end

  assign s1_cmul2_recip_out_rmag = ((s1_cmul2_recip_mul_0[27] || (18'h08000 <= s1_cmul2_recip_out_rn)) ? 18'h07fff : s1_cmul2_recip_out_rn);
  assign s1_cmul2_recip_out_0_nxt = _zz_s1_cmul2_recip_out_0_nxt;
  assign s1_cmul2_recip_out_0_req = s1_cmul2_recip_mul_0_to_s1_cmul2_recip_out_req;
  assign s1_cmul2_recip_mul_0_to_s1_cmul2_recip_out_ack = s1_cmul2_recip_out_0_ack;
  assign s1_cmul2_m2c_ac_sel = cfg_s1_cmul2_m2c_ac;
  always @(*) begin
    case(s1_cmul2_m2c_ac_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_ac_0 = s1_k8_slice_4;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_ac_0 = s1_k9_slice_4;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_ac_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul2_m2c_ac_0 = s1_cmul2_recip_out_0;
      end
    endcase
  end

  assign s1_cmul2_m2c_ac_0 = _zz_s1_cmul2_m2c_ac_0;
  always @(*) begin
    case(s1_cmul2_m2c_ac_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_ac_0_req = s1_k8_slice_4_to_s1_cmul2_m2c_ac_req;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_ac_0_req = s1_k9_slice_4_to_s1_cmul2_m2c_ac_req;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_ac_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul2_m2c_ac_0_req = s1_cmul2_recip_out_0_to_s1_cmul2_m2c_ac_req;
      end
    endcase
  end

  assign s1_cmul2_m2c_ac_0_req = _zz_s1_cmul2_m2c_ac_0_req;
  assign s1_k8_slice_4_to_s1_cmul2_m2c_ac_ack = ((s1_cmul2_m2c_ac_sel != 2'b00) || s1_cmul2_m2c_ac_0_ack);
  assign s1_k9_slice_4_to_s1_cmul2_m2c_ac_ack = ((s1_cmul2_m2c_ac_sel != 2'b01) || s1_cmul2_m2c_ac_0_ack);
  assign s1_cmul2_recip_out_0_to_s1_cmul2_m2c_ac_ack = ((s1_cmul2_m2c_ac_sel != 2'b11) || s1_cmul2_m2c_ac_0_ack);
  assign cfg_s1_cmul2_m2c_ac_to_s1_cmul2_m2c_ac_ack = 1'b1;
  assign s1_cmul2_m2c_bc_sel = cfg_s1_cmul2_m2c_bc;
  always @(*) begin
    case(s1_cmul2_m2c_bc_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_bc_0 = s1_k8_slice_5;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_bc_0 = s1_k9_slice_4;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_bc_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul2_m2c_bc_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul2_m2c_bc_0 = _zz_s1_cmul2_m2c_bc_0;
  always @(*) begin
    case(s1_cmul2_m2c_bc_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_bc_0_req = s1_k8_slice_5_to_s1_cmul2_m2c_bc_req;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_bc_0_req = s1_k9_slice_4_to_s1_cmul2_m2c_bc_req;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_bc_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul2_m2c_bc_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul2_m2c_bc_0_req = _zz_s1_cmul2_m2c_bc_0_req;
  assign s1_k8_slice_5_to_s1_cmul2_m2c_bc_ack = ((s1_cmul2_m2c_bc_sel != 2'b00) || s1_cmul2_m2c_bc_0_ack);
  assign s1_k9_slice_4_to_s1_cmul2_m2c_bc_ack = ((s1_cmul2_m2c_bc_sel != 2'b01) || s1_cmul2_m2c_bc_0_ack);
  assign cfg_s1_cmul2_m2c_bc_to_s1_cmul2_m2c_bc_ack = 1'b1;
  assign s1_cmul2_m2c_bd_sel = cfg_s1_cmul2_m2c_bd;
  always @(*) begin
    case(s1_cmul2_m2c_bd_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_bd_0 = s1_k8_slice_5;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_bd_0 = s1_k9_slice_5;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_bd_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul2_m2c_bd_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul2_m2c_bd_0 = _zz_s1_cmul2_m2c_bd_0;
  always @(*) begin
    case(s1_cmul2_m2c_bd_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_bd_0_req = s1_k8_slice_5_to_s1_cmul2_m2c_bd_req;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_bd_0_req = s1_k9_slice_5_to_s1_cmul2_m2c_bd_req;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_bd_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul2_m2c_bd_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul2_m2c_bd_0_req = _zz_s1_cmul2_m2c_bd_0_req;
  assign s1_k8_slice_5_to_s1_cmul2_m2c_bd_ack = ((s1_cmul2_m2c_bd_sel != 2'b00) || s1_cmul2_m2c_bd_0_ack);
  assign s1_k9_slice_5_to_s1_cmul2_m2c_bd_ack = ((s1_cmul2_m2c_bd_sel != 2'b01) || s1_cmul2_m2c_bd_0_ack);
  assign cfg_s1_cmul2_m2c_bd_to_s1_cmul2_m2c_bd_ack = 1'b1;
  assign s1_cmul2_m2c_cb_sel = cfg_s1_cmul2_m2c_cb;
  always @(*) begin
    case(s1_cmul2_m2c_cb_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_cb_0 = s1_k9_slice_4;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_cb_0 = s1_k8_slice_5;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_cb_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul2_m2c_cb_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul2_m2c_cb_0 = _zz_s1_cmul2_m2c_cb_0;
  always @(*) begin
    case(s1_cmul2_m2c_cb_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_cb_0_req = s1_k9_slice_4_to_s1_cmul2_m2c_cb_req;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_cb_0_req = s1_k8_slice_5_to_s1_cmul2_m2c_cb_req;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_cb_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul2_m2c_cb_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul2_m2c_cb_0_req = _zz_s1_cmul2_m2c_cb_0_req;
  assign s1_k9_slice_4_to_s1_cmul2_m2c_cb_ack = ((s1_cmul2_m2c_cb_sel != 2'b00) || s1_cmul2_m2c_cb_0_ack);
  assign s1_k8_slice_5_to_s1_cmul2_m2c_cb_ack = ((s1_cmul2_m2c_cb_sel != 2'b01) || s1_cmul2_m2c_cb_0_ack);
  assign cfg_s1_cmul2_m2c_cb_to_s1_cmul2_m2c_cb_ack = 1'b1;
  assign s1_cmul2_m2c_cd_sel = cfg_s1_cmul2_m2c_cd;
  always @(*) begin
    case(s1_cmul2_m2c_cd_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_cd_0 = s1_k9_slice_4;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_cd_0 = s1_k9_slice_5;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_cd_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul2_m2c_cd_0 = s1_cmul2_recip_out_0;
      end
    endcase
  end

  assign s1_cmul2_m2c_cd_0 = _zz_s1_cmul2_m2c_cd_0;
  always @(*) begin
    case(s1_cmul2_m2c_cd_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_cd_0_req = s1_k9_slice_4_to_s1_cmul2_m2c_cd_req;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_cd_0_req = s1_k9_slice_5_to_s1_cmul2_m2c_cd_req;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_cd_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul2_m2c_cd_0_req = s1_cmul2_recip_out_0_to_s1_cmul2_m2c_cd_req;
      end
    endcase
  end

  assign s1_cmul2_m2c_cd_0_req = _zz_s1_cmul2_m2c_cd_0_req;
  assign s1_k9_slice_4_to_s1_cmul2_m2c_cd_ack = ((s1_cmul2_m2c_cd_sel != 2'b00) || s1_cmul2_m2c_cd_0_ack);
  assign s1_k9_slice_5_to_s1_cmul2_m2c_cd_ack = ((s1_cmul2_m2c_cd_sel != 2'b01) || s1_cmul2_m2c_cd_0_ack);
  assign s1_cmul2_recip_out_0_to_s1_cmul2_m2c_cd_ack = ((s1_cmul2_m2c_cd_sel != 2'b11) || s1_cmul2_m2c_cd_0_ack);
  assign cfg_s1_cmul2_m2c_cd_to_s1_cmul2_m2c_cd_ack = 1'b1;
  assign s1_cmul2_m2c_da_sel = cfg_s1_cmul2_m2c_da;
  always @(*) begin
    case(s1_cmul2_m2c_da_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_da_0 = s1_k9_slice_5;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_da_0 = s1_k8_slice_4;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_da_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul2_m2c_da_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul2_m2c_da_0 = _zz_s1_cmul2_m2c_da_0;
  always @(*) begin
    case(s1_cmul2_m2c_da_sel)
      2'b00 : begin
        _zz_s1_cmul2_m2c_da_0_req = s1_k9_slice_5_to_s1_cmul2_m2c_da_req;
      end
      2'b01 : begin
        _zz_s1_cmul2_m2c_da_0_req = s1_k8_slice_4_to_s1_cmul2_m2c_da_req;
      end
      2'b10 : begin
        _zz_s1_cmul2_m2c_da_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul2_m2c_da_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul2_m2c_da_0_req = _zz_s1_cmul2_m2c_da_0_req;
  assign s1_k9_slice_5_to_s1_cmul2_m2c_da_ack = ((s1_cmul2_m2c_da_sel != 2'b00) || s1_cmul2_m2c_da_0_ack);
  assign s1_k8_slice_4_to_s1_cmul2_m2c_da_ack = ((s1_cmul2_m2c_da_sel != 2'b01) || s1_cmul2_m2c_da_0_ack);
  assign cfg_s1_cmul2_m2c_da_to_s1_cmul2_m2c_da_ack = 1'b1;
  assign s1_cmul2_cat_re_0_nxt = {s1_cmul2_m2c_bd_0,{s1_cmul2_m2c_bc_0,{s1_cmul2_m2c_ac_0,s1_k8_slice_4}}};
  assign s1_cmul2_cat_re_0_req = (((s1_k8_slice_4_to_s1_cmul2_cat_re_req && s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_req);
  assign s1_k8_slice_4_to_s1_cmul2_cat_re_ack = (((s1_cmul2_cat_re_0_ack && s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_req);
  assign s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_ack = (((s1_cmul2_cat_re_0_ack && s1_k8_slice_4_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_req);
  assign s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_ack = (((s1_cmul2_cat_re_0_ack && s1_k8_slice_4_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_req);
  assign s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_ack = (((s1_cmul2_cat_re_0_ack && s1_k8_slice_4_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_req) && s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_req);
  assign s1_cmul2_cat_im_0_nxt = {s1_cmul2_m2c_da_0,{s1_k9_slice_5,{s1_cmul2_m2c_cd_0,s1_cmul2_m2c_cb_0}}};
  assign s1_cmul2_cat_im_0_req = (((s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_req && s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_req) && s1_k9_slice_5_to_s1_cmul2_cat_im_req) && s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_req);
  assign s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_ack = (((s1_cmul2_cat_im_0_ack && s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_req) && s1_k9_slice_5_to_s1_cmul2_cat_im_req) && s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_req);
  assign s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_ack = (((s1_cmul2_cat_im_0_ack && s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_req) && s1_k9_slice_5_to_s1_cmul2_cat_im_req) && s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_req);
  assign s1_k9_slice_5_to_s1_cmul2_cat_im_ack = (((s1_cmul2_cat_im_0_ack && s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_req) && s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_req) && s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_req);
  assign s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_ack = (((s1_cmul2_cat_im_0_ack && s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_req) && s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_req) && s1_k9_slice_5_to_s1_cmul2_cat_im_req);
  assign cfg_s1_cmul2_mas_re_to_s1_cmul2_mas_re_ack = 1'b1;
  assign s1_cmul2_mas_re_s1_en = ((s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_req && s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_ack) || s1_cmul2_mas_re_cfg_valid[3]);
  assign s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_ack = ((! s1_cmul2_mas_re_s1_valid) || s1_cmul2_mas_re_s1_ack);
  assign s1_cmul2_mas_re_s2_en = ((s1_cmul2_mas_re_s1_valid && s1_cmul2_mas_re_s1_ack) || s1_cmul2_mas_re_cfg_valid[3]);
  assign s1_cmul2_mas_re_s1_ack = ((! s1_cmul2_mas_re_s2_valid) || s1_cmul2_mas_re_s2_ack);
  assign s1_cmul2_mas_re_s3_en = ((s1_cmul2_mas_re_s2_valid && s1_cmul2_mas_re_s2_ack) || s1_cmul2_mas_re_cfg_valid[3]);
  assign s1_cmul2_mas_re_s2_ack = ((! s1_cmul2_mas_re_s3_valid) || s1_cmul2_mas_re_0_ack);
  assign s1_cmul2_mas_re_0_req = s1_cmul2_mas_re_s3_valid;
  assign s1_cmul2_mas_re_CLK0 = clk;
  assign s1_cmul2_mas_re_RST0 = (! reset_n);
  assign s1_cmul2_mas_re_CE0 = s1_cmul2_mas_re_s1_en;
  assign s1_cmul2_mas_re_CE1 = s1_cmul2_mas_re_s2_en;
  assign s1_cmul2_mas_re_CE2 = s1_cmul2_mas_re_s3_en;
  assign s1_cmul2_mas_re_ADDNSUB = cfg_s1_cmul2_mas_re[0];
  assign s1_cmul2_mas_re_A0 = s1_cmul2_cat_re_0[17 : 0];
  assign s1_cmul2_mas_re_B0 = s1_cmul2_cat_re_0[35 : 18];
  assign s1_cmul2_mas_re_A1 = s1_cmul2_cat_re_0[53 : 36];
  assign s1_cmul2_mas_re_B1 = s1_cmul2_cat_re_0[71 : 54];
  assign s1_cmul2_mas_re_0 = s1_cmul2_mas_re_SUM;
  assign cfg_s1_cmul2_mas_im_to_s1_cmul2_mas_im_ack = 1'b1;
  assign s1_cmul2_mas_im_s1_en = ((s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_req && s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_ack) || s1_cmul2_mas_im_cfg_valid[3]);
  assign s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_ack = ((! s1_cmul2_mas_im_s1_valid) || s1_cmul2_mas_im_s1_ack);
  assign s1_cmul2_mas_im_s2_en = ((s1_cmul2_mas_im_s1_valid && s1_cmul2_mas_im_s1_ack) || s1_cmul2_mas_im_cfg_valid[3]);
  assign s1_cmul2_mas_im_s1_ack = ((! s1_cmul2_mas_im_s2_valid) || s1_cmul2_mas_im_s2_ack);
  assign s1_cmul2_mas_im_s3_en = ((s1_cmul2_mas_im_s2_valid && s1_cmul2_mas_im_s2_ack) || s1_cmul2_mas_im_cfg_valid[3]);
  assign s1_cmul2_mas_im_s2_ack = ((! s1_cmul2_mas_im_s3_valid) || s1_cmul2_mas_im_0_ack);
  assign s1_cmul2_mas_im_0_req = s1_cmul2_mas_im_s3_valid;
  assign s1_cmul2_mas_im_CLK0 = clk;
  assign s1_cmul2_mas_im_RST0 = (! reset_n);
  assign s1_cmul2_mas_im_CE0 = s1_cmul2_mas_im_s1_en;
  assign s1_cmul2_mas_im_CE1 = s1_cmul2_mas_im_s2_en;
  assign s1_cmul2_mas_im_CE2 = s1_cmul2_mas_im_s3_en;
  assign s1_cmul2_mas_im_ADDNSUB = cfg_s1_cmul2_mas_im[0];
  assign s1_cmul2_mas_im_A0 = s1_cmul2_cat_im_0[17 : 0];
  assign s1_cmul2_mas_im_B0 = s1_cmul2_cat_im_0[35 : 18];
  assign s1_cmul2_mas_im_A1 = s1_cmul2_cat_im_0[53 : 36];
  assign s1_cmul2_mas_im_B1 = s1_cmul2_cat_im_0[71 : 54];
  assign s1_cmul2_mas_im_0 = s1_cmul2_mas_im_SUM;
  assign s1_cmul3_recip_norm_x = s1_k9_slice_6[15 : 0];
  assign s1_cmul3_recip_norm_mag = (_zz_s1_cmul3_recip_norm_mag + _zz_s1_cmul3_recip_norm_mag_2);
  always @(*) begin
    s1_cmul3_recip_norm_lz = 5'h10;
    if(s1_cmul3_recip_norm_mag[0]) begin
      s1_cmul3_recip_norm_lz = 5'h0f;
    end
    if(s1_cmul3_recip_norm_mag[1]) begin
      s1_cmul3_recip_norm_lz = 5'h0e;
    end
    if(s1_cmul3_recip_norm_mag[2]) begin
      s1_cmul3_recip_norm_lz = 5'h0d;
    end
    if(s1_cmul3_recip_norm_mag[3]) begin
      s1_cmul3_recip_norm_lz = 5'h0c;
    end
    if(s1_cmul3_recip_norm_mag[4]) begin
      s1_cmul3_recip_norm_lz = 5'h0b;
    end
    if(s1_cmul3_recip_norm_mag[5]) begin
      s1_cmul3_recip_norm_lz = 5'h0a;
    end
    if(s1_cmul3_recip_norm_mag[6]) begin
      s1_cmul3_recip_norm_lz = 5'h09;
    end
    if(s1_cmul3_recip_norm_mag[7]) begin
      s1_cmul3_recip_norm_lz = 5'h08;
    end
    if(s1_cmul3_recip_norm_mag[8]) begin
      s1_cmul3_recip_norm_lz = 5'h07;
    end
    if(s1_cmul3_recip_norm_mag[9]) begin
      s1_cmul3_recip_norm_lz = 5'h06;
    end
    if(s1_cmul3_recip_norm_mag[10]) begin
      s1_cmul3_recip_norm_lz = 5'h05;
    end
    if(s1_cmul3_recip_norm_mag[11]) begin
      s1_cmul3_recip_norm_lz = 5'h04;
    end
    if(s1_cmul3_recip_norm_mag[12]) begin
      s1_cmul3_recip_norm_lz = 5'h03;
    end
    if(s1_cmul3_recip_norm_mag[13]) begin
      s1_cmul3_recip_norm_lz = 5'h02;
    end
    if(s1_cmul3_recip_norm_mag[14]) begin
      s1_cmul3_recip_norm_lz = 5'h01;
    end
    if(s1_cmul3_recip_norm_mag[15]) begin
      s1_cmul3_recip_norm_lz = 5'h0;
    end
  end

  assign s1_cmul3_recip_norm_sat = (s1_cmul3_recip_norm_mag < 16'h0020);
  assign s1_cmul3_recip_norm_xn = (_zz_s1_cmul3_recip_norm_xn >>> 3'd6);
  assign s1_cmul3_recip_norm_0_nxt = {{{s1_cmul3_recip_norm_x[15],s1_cmul3_recip_norm_sat},s1_cmul3_recip_norm_lz},s1_cmul3_recip_norm_xn};
  assign s1_cmul3_recip_norm_0_req = s1_k9_slice_6_to_s1_cmul3_recip_norm_req;
  assign s1_k9_slice_6_to_s1_cmul3_recip_norm_ack = s1_cmul3_recip_norm_0_ack;
  assign _zz_s1_cmul3_recip_mul_y0 = s1_cmul3_recip_norm_0[9 : 0];
  assign s1_cmul3_recip_mul_y0 = (11'h5dd - _zz_s1_cmul3_recip_mul_y0_1);
  assign s1_cmul3_recip_mul_t = _zz_s1_cmul3_recip_mul_t[20 : 10];
  assign s1_cmul3_recip_mul_u = (11'h401 - s1_cmul3_recip_mul_t);
  assign s1_cmul3_recip_mul_0_nxt = {{s1_cmul3_recip_norm_0[16 : 10],s1_cmul3_recip_mul_u},s1_cmul3_recip_mul_y0};
  assign s1_cmul3_recip_mul_0_req = s1_cmul3_recip_norm_0_to_s1_cmul3_recip_mul_req;
  assign s1_cmul3_recip_norm_0_to_s1_cmul3_recip_mul_ack = s1_cmul3_recip_mul_0_ack;
  assign _zz_s1_cmul3_recip_out_rn = s1_cmul3_recip_mul_0[26 : 22];
  assign s1_cmul3_recip_out_r = {_zz_s1_cmul3_recip_out_r[21 : 10],2'b00};
  always @(*) begin
    if((_zz_s1_cmul3_recip_out_rn <= 5'h06)) begin
      s1_cmul3_recip_out_rn = {4'd0, _zz_s1_cmul3_recip_out_rn_1};
    end else begin
      s1_cmul3_recip_out_rn = (_zz_s1_cmul3_recip_out_rn_3 <<< _zz_s1_cmul3_recip_out_rn_4);
    end
  end

  assign s1_cmul3_recip_out_rmag = ((s1_cmul3_recip_mul_0[27] || (18'h08000 <= s1_cmul3_recip_out_rn)) ? 18'h07fff : s1_cmul3_recip_out_rn);
  assign s1_cmul3_recip_out_0_nxt = _zz_s1_cmul3_recip_out_0_nxt;
  assign s1_cmul3_recip_out_0_req = s1_cmul3_recip_mul_0_to_s1_cmul3_recip_out_req;
  assign s1_cmul3_recip_mul_0_to_s1_cmul3_recip_out_ack = s1_cmul3_recip_out_0_ack;
  assign s1_cmul3_m2c_ac_sel = cfg_s1_cmul3_m2c_ac;
  always @(*) begin
    case(s1_cmul3_m2c_ac_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_ac_0 = s1_k8_slice_6;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_ac_0 = s1_k9_slice_6;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_ac_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul3_m2c_ac_0 = s1_cmul3_recip_out_0;
      end
    endcase
  end

  assign s1_cmul3_m2c_ac_0 = _zz_s1_cmul3_m2c_ac_0;
  always @(*) begin
    case(s1_cmul3_m2c_ac_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_ac_0_req = s1_k8_slice_6_to_s1_cmul3_m2c_ac_req;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_ac_0_req = s1_k9_slice_6_to_s1_cmul3_m2c_ac_req;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_ac_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul3_m2c_ac_0_req = s1_cmul3_recip_out_0_to_s1_cmul3_m2c_ac_req;
      end
    endcase
  end

  assign s1_cmul3_m2c_ac_0_req = _zz_s1_cmul3_m2c_ac_0_req;
  assign s1_k8_slice_6_to_s1_cmul3_m2c_ac_ack = ((s1_cmul3_m2c_ac_sel != 2'b00) || s1_cmul3_m2c_ac_0_ack);
  assign s1_k9_slice_6_to_s1_cmul3_m2c_ac_ack = ((s1_cmul3_m2c_ac_sel != 2'b01) || s1_cmul3_m2c_ac_0_ack);
  assign s1_cmul3_recip_out_0_to_s1_cmul3_m2c_ac_ack = ((s1_cmul3_m2c_ac_sel != 2'b11) || s1_cmul3_m2c_ac_0_ack);
  assign cfg_s1_cmul3_m2c_ac_to_s1_cmul3_m2c_ac_ack = 1'b1;
  assign s1_cmul3_m2c_bc_sel = cfg_s1_cmul3_m2c_bc;
  always @(*) begin
    case(s1_cmul3_m2c_bc_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_bc_0 = s1_k8_slice_7;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_bc_0 = s1_k9_slice_6;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_bc_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul3_m2c_bc_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul3_m2c_bc_0 = _zz_s1_cmul3_m2c_bc_0;
  always @(*) begin
    case(s1_cmul3_m2c_bc_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_bc_0_req = s1_k8_slice_7_to_s1_cmul3_m2c_bc_req;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_bc_0_req = s1_k9_slice_6_to_s1_cmul3_m2c_bc_req;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_bc_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul3_m2c_bc_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul3_m2c_bc_0_req = _zz_s1_cmul3_m2c_bc_0_req;
  assign s1_k8_slice_7_to_s1_cmul3_m2c_bc_ack = ((s1_cmul3_m2c_bc_sel != 2'b00) || s1_cmul3_m2c_bc_0_ack);
  assign s1_k9_slice_6_to_s1_cmul3_m2c_bc_ack = ((s1_cmul3_m2c_bc_sel != 2'b01) || s1_cmul3_m2c_bc_0_ack);
  assign cfg_s1_cmul3_m2c_bc_to_s1_cmul3_m2c_bc_ack = 1'b1;
  assign s1_cmul3_m2c_bd_sel = cfg_s1_cmul3_m2c_bd;
  always @(*) begin
    case(s1_cmul3_m2c_bd_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_bd_0 = s1_k8_slice_7;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_bd_0 = s1_k9_slice_7;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_bd_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul3_m2c_bd_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul3_m2c_bd_0 = _zz_s1_cmul3_m2c_bd_0;
  always @(*) begin
    case(s1_cmul3_m2c_bd_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_bd_0_req = s1_k8_slice_7_to_s1_cmul3_m2c_bd_req;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_bd_0_req = s1_k9_slice_7_to_s1_cmul3_m2c_bd_req;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_bd_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul3_m2c_bd_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul3_m2c_bd_0_req = _zz_s1_cmul3_m2c_bd_0_req;
  assign s1_k8_slice_7_to_s1_cmul3_m2c_bd_ack = ((s1_cmul3_m2c_bd_sel != 2'b00) || s1_cmul3_m2c_bd_0_ack);
  assign s1_k9_slice_7_to_s1_cmul3_m2c_bd_ack = ((s1_cmul3_m2c_bd_sel != 2'b01) || s1_cmul3_m2c_bd_0_ack);
  assign cfg_s1_cmul3_m2c_bd_to_s1_cmul3_m2c_bd_ack = 1'b1;
  assign s1_cmul3_m2c_cb_sel = cfg_s1_cmul3_m2c_cb;
  always @(*) begin
    case(s1_cmul3_m2c_cb_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_cb_0 = s1_k9_slice_6;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_cb_0 = s1_k8_slice_7;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_cb_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul3_m2c_cb_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul3_m2c_cb_0 = _zz_s1_cmul3_m2c_cb_0;
  always @(*) begin
    case(s1_cmul3_m2c_cb_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_cb_0_req = s1_k9_slice_6_to_s1_cmul3_m2c_cb_req;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_cb_0_req = s1_k8_slice_7_to_s1_cmul3_m2c_cb_req;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_cb_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul3_m2c_cb_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul3_m2c_cb_0_req = _zz_s1_cmul3_m2c_cb_0_req;
  assign s1_k9_slice_6_to_s1_cmul3_m2c_cb_ack = ((s1_cmul3_m2c_cb_sel != 2'b00) || s1_cmul3_m2c_cb_0_ack);
  assign s1_k8_slice_7_to_s1_cmul3_m2c_cb_ack = ((s1_cmul3_m2c_cb_sel != 2'b01) || s1_cmul3_m2c_cb_0_ack);
  assign cfg_s1_cmul3_m2c_cb_to_s1_cmul3_m2c_cb_ack = 1'b1;
  assign s1_cmul3_m2c_cd_sel = cfg_s1_cmul3_m2c_cd;
  always @(*) begin
    case(s1_cmul3_m2c_cd_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_cd_0 = s1_k9_slice_6;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_cd_0 = s1_k9_slice_7;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_cd_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul3_m2c_cd_0 = s1_cmul3_recip_out_0;
      end
    endcase
  end

  assign s1_cmul3_m2c_cd_0 = _zz_s1_cmul3_m2c_cd_0;
  always @(*) begin
    case(s1_cmul3_m2c_cd_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_cd_0_req = s1_k9_slice_6_to_s1_cmul3_m2c_cd_req;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_cd_0_req = s1_k9_slice_7_to_s1_cmul3_m2c_cd_req;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_cd_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul3_m2c_cd_0_req = s1_cmul3_recip_out_0_to_s1_cmul3_m2c_cd_req;
      end
    endcase
  end

  assign s1_cmul3_m2c_cd_0_req = _zz_s1_cmul3_m2c_cd_0_req;
  assign s1_k9_slice_6_to_s1_cmul3_m2c_cd_ack = ((s1_cmul3_m2c_cd_sel != 2'b00) || s1_cmul3_m2c_cd_0_ack);
  assign s1_k9_slice_7_to_s1_cmul3_m2c_cd_ack = ((s1_cmul3_m2c_cd_sel != 2'b01) || s1_cmul3_m2c_cd_0_ack);
  assign s1_cmul3_recip_out_0_to_s1_cmul3_m2c_cd_ack = ((s1_cmul3_m2c_cd_sel != 2'b11) || s1_cmul3_m2c_cd_0_ack);
  assign cfg_s1_cmul3_m2c_cd_to_s1_cmul3_m2c_cd_ack = 1'b1;
  assign s1_cmul3_m2c_da_sel = cfg_s1_cmul3_m2c_da;
  always @(*) begin
    case(s1_cmul3_m2c_da_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_da_0 = s1_k9_slice_7;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_da_0 = s1_k8_slice_6;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_da_0 = 18'h00001;
      end
      default : begin
        _zz_s1_cmul3_m2c_da_0 = 18'h00001;
      end
    endcase
  end

  assign s1_cmul3_m2c_da_0 = _zz_s1_cmul3_m2c_da_0;
  always @(*) begin
    case(s1_cmul3_m2c_da_sel)
      2'b00 : begin
        _zz_s1_cmul3_m2c_da_0_req = s1_k9_slice_7_to_s1_cmul3_m2c_da_req;
      end
      2'b01 : begin
        _zz_s1_cmul3_m2c_da_0_req = s1_k8_slice_6_to_s1_cmul3_m2c_da_req;
      end
      2'b10 : begin
        _zz_s1_cmul3_m2c_da_0_req = 1'b1;
      end
      default : begin
        _zz_s1_cmul3_m2c_da_0_req = 1'b1;
      end
    endcase
  end

  assign s1_cmul3_m2c_da_0_req = _zz_s1_cmul3_m2c_da_0_req;
  assign s1_k9_slice_7_to_s1_cmul3_m2c_da_ack = ((s1_cmul3_m2c_da_sel != 2'b00) || s1_cmul3_m2c_da_0_ack);
  assign s1_k8_slice_6_to_s1_cmul3_m2c_da_ack = ((s1_cmul3_m2c_da_sel != 2'b01) || s1_cmul3_m2c_da_0_ack);
  assign cfg_s1_cmul3_m2c_da_to_s1_cmul3_m2c_da_ack = 1'b1;
  assign s1_cmul3_cat_re_0_nxt = {s1_cmul3_m2c_bd_0,{s1_cmul3_m2c_bc_0,{s1_cmul3_m2c_ac_0,s1_k8_slice_6}}};
  assign s1_cmul3_cat_re_0_req = (((s1_k8_slice_6_to_s1_cmul3_cat_re_req && s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_req);
  assign s1_k8_slice_6_to_s1_cmul3_cat_re_ack = (((s1_cmul3_cat_re_0_ack && s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_req);
  assign s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_ack = (((s1_cmul3_cat_re_0_ack && s1_k8_slice_6_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_req);
  assign s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_ack = (((s1_cmul3_cat_re_0_ack && s1_k8_slice_6_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_req);
  assign s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_ack = (((s1_cmul3_cat_re_0_ack && s1_k8_slice_6_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_req) && s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_req);
  assign s1_cmul3_cat_im_0_nxt = {s1_cmul3_m2c_da_0,{s1_k9_slice_7,{s1_cmul3_m2c_cd_0,s1_cmul3_m2c_cb_0}}};
  assign s1_cmul3_cat_im_0_req = (((s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_req && s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_req) && s1_k9_slice_7_to_s1_cmul3_cat_im_req) && s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_req);
  assign s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_ack = (((s1_cmul3_cat_im_0_ack && s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_req) && s1_k9_slice_7_to_s1_cmul3_cat_im_req) && s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_req);
  assign s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_ack = (((s1_cmul3_cat_im_0_ack && s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_req) && s1_k9_slice_7_to_s1_cmul3_cat_im_req) && s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_req);
  assign s1_k9_slice_7_to_s1_cmul3_cat_im_ack = (((s1_cmul3_cat_im_0_ack && s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_req) && s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_req) && s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_req);
  assign s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_ack = (((s1_cmul3_cat_im_0_ack && s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_req) && s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_req) && s1_k9_slice_7_to_s1_cmul3_cat_im_req);
  assign cfg_s1_cmul3_mas_re_to_s1_cmul3_mas_re_ack = 1'b1;
  assign s1_cmul3_mas_re_s1_en = ((s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_req && s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_ack) || s1_cmul3_mas_re_cfg_valid[3]);
  assign s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_ack = ((! s1_cmul3_mas_re_s1_valid) || s1_cmul3_mas_re_s1_ack);
  assign s1_cmul3_mas_re_s2_en = ((s1_cmul3_mas_re_s1_valid && s1_cmul3_mas_re_s1_ack) || s1_cmul3_mas_re_cfg_valid[3]);
  assign s1_cmul3_mas_re_s1_ack = ((! s1_cmul3_mas_re_s2_valid) || s1_cmul3_mas_re_s2_ack);
  assign s1_cmul3_mas_re_s3_en = ((s1_cmul3_mas_re_s2_valid && s1_cmul3_mas_re_s2_ack) || s1_cmul3_mas_re_cfg_valid[3]);
  assign s1_cmul3_mas_re_s2_ack = ((! s1_cmul3_mas_re_s3_valid) || s1_cmul3_mas_re_0_ack);
  assign s1_cmul3_mas_re_0_req = s1_cmul3_mas_re_s3_valid;
  assign s1_cmul3_mas_re_CLK0 = clk;
  assign s1_cmul3_mas_re_RST0 = (! reset_n);
  assign s1_cmul3_mas_re_CE0 = s1_cmul3_mas_re_s1_en;
  assign s1_cmul3_mas_re_CE1 = s1_cmul3_mas_re_s2_en;
  assign s1_cmul3_mas_re_CE2 = s1_cmul3_mas_re_s3_en;
  assign s1_cmul3_mas_re_ADDNSUB = cfg_s1_cmul3_mas_re[0];
  assign s1_cmul3_mas_re_A0 = s1_cmul3_cat_re_0[17 : 0];
  assign s1_cmul3_mas_re_B0 = s1_cmul3_cat_re_0[35 : 18];
  assign s1_cmul3_mas_re_A1 = s1_cmul3_cat_re_0[53 : 36];
  assign s1_cmul3_mas_re_B1 = s1_cmul3_cat_re_0[71 : 54];
  assign s1_cmul3_mas_re_0 = s1_cmul3_mas_re_SUM;
  assign cfg_s1_cmul3_mas_im_to_s1_cmul3_mas_im_ack = 1'b1;
  assign s1_cmul3_mas_im_s1_en = ((s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_req && s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_ack) || s1_cmul3_mas_im_cfg_valid[3]);
  assign s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_ack = ((! s1_cmul3_mas_im_s1_valid) || s1_cmul3_mas_im_s1_ack);
  assign s1_cmul3_mas_im_s2_en = ((s1_cmul3_mas_im_s1_valid && s1_cmul3_mas_im_s1_ack) || s1_cmul3_mas_im_cfg_valid[3]);
  assign s1_cmul3_mas_im_s1_ack = ((! s1_cmul3_mas_im_s2_valid) || s1_cmul3_mas_im_s2_ack);
  assign s1_cmul3_mas_im_s3_en = ((s1_cmul3_mas_im_s2_valid && s1_cmul3_mas_im_s2_ack) || s1_cmul3_mas_im_cfg_valid[3]);
  assign s1_cmul3_mas_im_s2_ack = ((! s1_cmul3_mas_im_s3_valid) || s1_cmul3_mas_im_0_ack);
  assign s1_cmul3_mas_im_0_req = s1_cmul3_mas_im_s3_valid;
  assign s1_cmul3_mas_im_CLK0 = clk;
  assign s1_cmul3_mas_im_RST0 = (! reset_n);
  assign s1_cmul3_mas_im_CE0 = s1_cmul3_mas_im_s1_en;
  assign s1_cmul3_mas_im_CE1 = s1_cmul3_mas_im_s2_en;
  assign s1_cmul3_mas_im_CE2 = s1_cmul3_mas_im_s3_en;
  assign s1_cmul3_mas_im_ADDNSUB = cfg_s1_cmul3_mas_im[0];
  assign s1_cmul3_mas_im_A0 = s1_cmul3_cat_im_0[17 : 0];
  assign s1_cmul3_mas_im_B0 = s1_cmul3_cat_im_0[35 : 18];
  assign s1_cmul3_mas_im_A1 = s1_cmul3_cat_im_0[53 : 36];
  assign s1_cmul3_mas_im_B1 = s1_cmul3_cat_im_0[71 : 54];
  assign s1_cmul3_mas_im_0 = s1_cmul3_mas_im_SUM;
  assign s0_r4_a0_re_0_nxt = _zz_s0_r4_a0_re_0_nxt;
  assign s0_r4_a0_re_0_req = (s0_cmul0_mas_re_0_to_s0_r4_a0_re_req && s0_cmul2_mas_re_0_to_s0_r4_a0_re_req);
  assign s0_cmul0_mas_re_0_to_s0_r4_a0_re_ack = (s0_r4_a0_re_0_ack && s0_cmul2_mas_re_0_to_s0_r4_a0_re_req);
  assign s0_cmul2_mas_re_0_to_s0_r4_a0_re_ack = (s0_r4_a0_re_0_ack && s0_cmul0_mas_re_0_to_s0_r4_a0_re_req);
  assign s0_r4_a0_im_0_nxt = _zz_s0_r4_a0_im_0_nxt;
  assign s0_r4_a0_im_0_req = (s0_cmul0_mas_im_0_to_s0_r4_a0_im_req && s0_cmul2_mas_im_0_to_s0_r4_a0_im_req);
  assign s0_cmul0_mas_im_0_to_s0_r4_a0_im_ack = (s0_r4_a0_im_0_ack && s0_cmul2_mas_im_0_to_s0_r4_a0_im_req);
  assign s0_cmul2_mas_im_0_to_s0_r4_a0_im_ack = (s0_r4_a0_im_0_ack && s0_cmul0_mas_im_0_to_s0_r4_a0_im_req);
  assign s0_r4_a1_re_0_nxt = _zz_s0_r4_a1_re_0_nxt;
  assign s0_r4_a1_re_0_req = (s0_cmul1_mas_re_0_to_s0_r4_a1_re_req && s0_cmul3_mas_re_0_to_s0_r4_a1_re_req);
  assign s0_cmul1_mas_re_0_to_s0_r4_a1_re_ack = (s0_r4_a1_re_0_ack && s0_cmul3_mas_re_0_to_s0_r4_a1_re_req);
  assign s0_cmul3_mas_re_0_to_s0_r4_a1_re_ack = (s0_r4_a1_re_0_ack && s0_cmul1_mas_re_0_to_s0_r4_a1_re_req);
  assign s0_r4_a1_im_0_nxt = _zz_s0_r4_a1_im_0_nxt;
  assign s0_r4_a1_im_0_req = (s0_cmul1_mas_im_0_to_s0_r4_a1_im_req && s0_cmul3_mas_im_0_to_s0_r4_a1_im_req);
  assign s0_cmul1_mas_im_0_to_s0_r4_a1_im_ack = (s0_r4_a1_im_0_ack && s0_cmul3_mas_im_0_to_s0_r4_a1_im_req);
  assign s0_cmul3_mas_im_0_to_s0_r4_a1_im_ack = (s0_r4_a1_im_0_ack && s0_cmul1_mas_im_0_to_s0_r4_a1_im_req);
  assign s0_r4_a2_re_0_nxt = _zz_s0_r4_a2_re_0_nxt;
  assign s0_r4_a2_re_0_req = (s0_cmul0_mas_re_0_to_s0_r4_a2_re_req && s0_cmul2_mas_re_0_to_s0_r4_a2_re_req);
  assign s0_cmul0_mas_re_0_to_s0_r4_a2_re_ack = (s0_r4_a2_re_0_ack && s0_cmul2_mas_re_0_to_s0_r4_a2_re_req);
  assign s0_cmul2_mas_re_0_to_s0_r4_a2_re_ack = (s0_r4_a2_re_0_ack && s0_cmul0_mas_re_0_to_s0_r4_a2_re_req);
  assign s0_r4_a2_im_0_nxt = _zz_s0_r4_a2_im_0_nxt;
  assign s0_r4_a2_im_0_req = (s0_cmul0_mas_im_0_to_s0_r4_a2_im_req && s0_cmul2_mas_im_0_to_s0_r4_a2_im_req);
  assign s0_cmul0_mas_im_0_to_s0_r4_a2_im_ack = (s0_r4_a2_im_0_ack && s0_cmul2_mas_im_0_to_s0_r4_a2_im_req);
  assign s0_cmul2_mas_im_0_to_s0_r4_a2_im_ack = (s0_r4_a2_im_0_ack && s0_cmul0_mas_im_0_to_s0_r4_a2_im_req);
  assign s0_r4_a3_re_0_nxt = _zz_s0_r4_a3_re_0_nxt;
  assign s0_r4_a3_re_0_req = (s0_cmul1_mas_re_0_to_s0_r4_a3_re_req && s0_cmul3_mas_re_0_to_s0_r4_a3_re_req);
  assign s0_cmul1_mas_re_0_to_s0_r4_a3_re_ack = (s0_r4_a3_re_0_ack && s0_cmul3_mas_re_0_to_s0_r4_a3_re_req);
  assign s0_cmul3_mas_re_0_to_s0_r4_a3_re_ack = (s0_r4_a3_re_0_ack && s0_cmul1_mas_re_0_to_s0_r4_a3_re_req);
  assign s0_r4_a3_im_0_nxt = _zz_s0_r4_a3_im_0_nxt;
  assign s0_r4_a3_im_0_req = (s0_cmul1_mas_im_0_to_s0_r4_a3_im_req && s0_cmul3_mas_im_0_to_s0_r4_a3_im_req);
  assign s0_cmul1_mas_im_0_to_s0_r4_a3_im_ack = (s0_r4_a3_im_0_ack && s0_cmul3_mas_im_0_to_s0_r4_a3_im_req);
  assign s0_cmul3_mas_im_0_to_s0_r4_a3_im_ack = (s0_r4_a3_im_0_ack && s0_cmul1_mas_im_0_to_s0_r4_a3_im_req);
  assign s0_r4_c0_re_0 = _zz_s0_r4_c0_re_0;
  assign s0_r4_c0_re_0_req = (s0_r4_a0_re_0_to_s0_r4_c0_re_req && s0_r4_a1_re_0_to_s0_r4_c0_re_req);
  assign s0_r4_a0_re_0_to_s0_r4_c0_re_ack = (s0_r4_c0_re_0_ack && s0_r4_a1_re_0_to_s0_r4_c0_re_req);
  assign s0_r4_a1_re_0_to_s0_r4_c0_re_ack = (s0_r4_c0_re_0_ack && s0_r4_a0_re_0_to_s0_r4_c0_re_req);
  assign s0_r4_c0_im_0 = _zz_s0_r4_c0_im_0;
  assign s0_r4_c0_im_0_req = (s0_r4_a0_im_0_to_s0_r4_c0_im_req && s0_r4_a1_im_0_to_s0_r4_c0_im_req);
  assign s0_r4_a0_im_0_to_s0_r4_c0_im_ack = (s0_r4_c0_im_0_ack && s0_r4_a1_im_0_to_s0_r4_c0_im_req);
  assign s0_r4_a1_im_0_to_s0_r4_c0_im_ack = (s0_r4_c0_im_0_ack && s0_r4_a0_im_0_to_s0_r4_c0_im_req);
  assign s0_r4_c1_re_0 = _zz_s0_r4_c1_re_0;
  assign s0_r4_c1_re_0_req = (s0_r4_a2_re_0_to_s0_r4_c1_re_req && s0_r4_a3_im_0_to_s0_r4_c1_re_req);
  assign s0_r4_a2_re_0_to_s0_r4_c1_re_ack = (s0_r4_c1_re_0_ack && s0_r4_a3_im_0_to_s0_r4_c1_re_req);
  assign s0_r4_a3_im_0_to_s0_r4_c1_re_ack = (s0_r4_c1_re_0_ack && s0_r4_a2_re_0_to_s0_r4_c1_re_req);
  assign s0_r4_c1_im_0 = _zz_s0_r4_c1_im_0;
  assign s0_r4_c1_im_0_req = (s0_r4_a2_im_0_to_s0_r4_c1_im_req && s0_r4_a3_re_0_to_s0_r4_c1_im_req);
  assign s0_r4_a2_im_0_to_s0_r4_c1_im_ack = (s0_r4_c1_im_0_ack && s0_r4_a3_re_0_to_s0_r4_c1_im_req);
  assign s0_r4_a3_re_0_to_s0_r4_c1_im_ack = (s0_r4_c1_im_0_ack && s0_r4_a2_im_0_to_s0_r4_c1_im_req);
  assign s0_r4_c2_re_0 = _zz_s0_r4_c2_re_0;
  assign s0_r4_c2_re_0_req = (s0_r4_a0_re_0_to_s0_r4_c2_re_req && s0_r4_a1_re_0_to_s0_r4_c2_re_req);
  assign s0_r4_a0_re_0_to_s0_r4_c2_re_ack = (s0_r4_c2_re_0_ack && s0_r4_a1_re_0_to_s0_r4_c2_re_req);
  assign s0_r4_a1_re_0_to_s0_r4_c2_re_ack = (s0_r4_c2_re_0_ack && s0_r4_a0_re_0_to_s0_r4_c2_re_req);
  assign s0_r4_c2_im_0 = _zz_s0_r4_c2_im_0;
  assign s0_r4_c2_im_0_req = (s0_r4_a0_im_0_to_s0_r4_c2_im_req && s0_r4_a1_im_0_to_s0_r4_c2_im_req);
  assign s0_r4_a0_im_0_to_s0_r4_c2_im_ack = (s0_r4_c2_im_0_ack && s0_r4_a1_im_0_to_s0_r4_c2_im_req);
  assign s0_r4_a1_im_0_to_s0_r4_c2_im_ack = (s0_r4_c2_im_0_ack && s0_r4_a0_im_0_to_s0_r4_c2_im_req);
  assign s0_r4_c3_re_0 = _zz_s0_r4_c3_re_0;
  assign s0_r4_c3_re_0_req = (s0_r4_a2_re_0_to_s0_r4_c3_re_req && s0_r4_a3_im_0_to_s0_r4_c3_re_req);
  assign s0_r4_a2_re_0_to_s0_r4_c3_re_ack = (s0_r4_c3_re_0_ack && s0_r4_a3_im_0_to_s0_r4_c3_re_req);
  assign s0_r4_a3_im_0_to_s0_r4_c3_re_ack = (s0_r4_c3_re_0_ack && s0_r4_a2_re_0_to_s0_r4_c3_re_req);
  assign s0_r4_c3_im_0 = _zz_s0_r4_c3_im_0;
  assign s0_r4_c3_im_0_req = (s0_r4_a2_im_0_to_s0_r4_c3_im_req && s0_r4_a3_re_0_to_s0_r4_c3_im_req);
  assign s0_r4_a2_im_0_to_s0_r4_c3_im_ack = (s0_r4_c3_im_0_ack && s0_r4_a3_re_0_to_s0_r4_c3_im_req);
  assign s0_r4_a3_re_0_to_s0_r4_c3_im_ack = (s0_r4_c3_im_0_ack && s0_r4_a2_im_0_to_s0_r4_c3_im_req);
  assign s0_r4_byp0_re_sel = cfg_s0_r4_byp0_re;
  always @(*) begin
    case(s0_r4_byp0_re_sel)
      2'b00 : begin
        _zz_s0_r4_byp0_re_0_nxt = s0_cmul0_mas_re_0;
      end
      2'b01 : begin
        _zz_s0_r4_byp0_re_0_nxt = s0_r4_c0_re_0;
      end
      2'b10 : begin
        _zz_s0_r4_byp0_re_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s0_r4_byp0_re_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s0_r4_byp0_re_0_nxt = _zz_s0_r4_byp0_re_0_nxt;
  always @(*) begin
    case(s0_r4_byp0_re_sel)
      2'b00 : begin
        _zz_s0_r4_byp0_re_0_req = s0_cmul0_mas_re_0_to_s0_r4_byp0_re_req;
      end
      2'b01 : begin
        _zz_s0_r4_byp0_re_0_req = s0_r4_c0_re_0_to_s0_r4_byp0_re_req;
      end
      2'b10 : begin
        _zz_s0_r4_byp0_re_0_req = 1'b1;
      end
      default : begin
        _zz_s0_r4_byp0_re_0_req = 1'b1;
      end
    endcase
  end

  assign s0_r4_byp0_re_0_req = _zz_s0_r4_byp0_re_0_req;
  assign s0_cmul0_mas_re_0_to_s0_r4_byp0_re_ack = ((s0_r4_byp0_re_sel != 2'b00) || s0_r4_byp0_re_0_ack);
  assign s0_r4_c0_re_0_to_s0_r4_byp0_re_ack = ((s0_r4_byp0_re_sel != 2'b01) || s0_r4_byp0_re_0_ack);
  assign cfg_s0_r4_byp0_re_to_s0_r4_byp0_re_ack = 1'b1;
  assign s0_r4_byp0_im_sel = cfg_s0_r4_byp0_im;
  always @(*) begin
    case(s0_r4_byp0_im_sel)
      2'b00 : begin
        _zz_s0_r4_byp0_im_0_nxt = s0_cmul0_mas_im_0;
      end
      2'b01 : begin
        _zz_s0_r4_byp0_im_0_nxt = s0_r4_c0_im_0;
      end
      2'b10 : begin
        _zz_s0_r4_byp0_im_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s0_r4_byp0_im_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s0_r4_byp0_im_0_nxt = _zz_s0_r4_byp0_im_0_nxt;
  always @(*) begin
    case(s0_r4_byp0_im_sel)
      2'b00 : begin
        _zz_s0_r4_byp0_im_0_req = s0_cmul0_mas_im_0_to_s0_r4_byp0_im_req;
      end
      2'b01 : begin
        _zz_s0_r4_byp0_im_0_req = s0_r4_c0_im_0_to_s0_r4_byp0_im_req;
      end
      2'b10 : begin
        _zz_s0_r4_byp0_im_0_req = 1'b1;
      end
      default : begin
        _zz_s0_r4_byp0_im_0_req = 1'b1;
      end
    endcase
  end

  assign s0_r4_byp0_im_0_req = _zz_s0_r4_byp0_im_0_req;
  assign s0_cmul0_mas_im_0_to_s0_r4_byp0_im_ack = ((s0_r4_byp0_im_sel != 2'b00) || s0_r4_byp0_im_0_ack);
  assign s0_r4_c0_im_0_to_s0_r4_byp0_im_ack = ((s0_r4_byp0_im_sel != 2'b01) || s0_r4_byp0_im_0_ack);
  assign cfg_s0_r4_byp0_im_to_s0_r4_byp0_im_ack = 1'b1;
  assign s0_r4_byp1_re_sel = cfg_s0_r4_byp1_re;
  always @(*) begin
    case(s0_r4_byp1_re_sel)
      2'b00 : begin
        _zz_s0_r4_byp1_re_0_nxt = s0_cmul1_mas_re_0;
      end
      2'b01 : begin
        _zz_s0_r4_byp1_re_0_nxt = s0_r4_c1_re_0;
      end
      2'b10 : begin
        _zz_s0_r4_byp1_re_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s0_r4_byp1_re_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s0_r4_byp1_re_0_nxt = _zz_s0_r4_byp1_re_0_nxt;
  always @(*) begin
    case(s0_r4_byp1_re_sel)
      2'b00 : begin
        _zz_s0_r4_byp1_re_0_req = s0_cmul1_mas_re_0_to_s0_r4_byp1_re_req;
      end
      2'b01 : begin
        _zz_s0_r4_byp1_re_0_req = s0_r4_c1_re_0_to_s0_r4_byp1_re_req;
      end
      2'b10 : begin
        _zz_s0_r4_byp1_re_0_req = 1'b1;
      end
      default : begin
        _zz_s0_r4_byp1_re_0_req = 1'b1;
      end
    endcase
  end

  assign s0_r4_byp1_re_0_req = _zz_s0_r4_byp1_re_0_req;
  assign s0_cmul1_mas_re_0_to_s0_r4_byp1_re_ack = ((s0_r4_byp1_re_sel != 2'b00) || s0_r4_byp1_re_0_ack);
  assign s0_r4_c1_re_0_to_s0_r4_byp1_re_ack = ((s0_r4_byp1_re_sel != 2'b01) || s0_r4_byp1_re_0_ack);
  assign cfg_s0_r4_byp1_re_to_s0_r4_byp1_re_ack = 1'b1;
  assign s0_r4_byp1_im_sel = cfg_s0_r4_byp1_im;
  always @(*) begin
    case(s0_r4_byp1_im_sel)
      2'b00 : begin
        _zz_s0_r4_byp1_im_0_nxt = s0_cmul1_mas_im_0;
      end
      2'b01 : begin
        _zz_s0_r4_byp1_im_0_nxt = s0_r4_c1_im_0;
      end
      2'b10 : begin
        _zz_s0_r4_byp1_im_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s0_r4_byp1_im_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s0_r4_byp1_im_0_nxt = _zz_s0_r4_byp1_im_0_nxt;
  always @(*) begin
    case(s0_r4_byp1_im_sel)
      2'b00 : begin
        _zz_s0_r4_byp1_im_0_req = s0_cmul1_mas_im_0_to_s0_r4_byp1_im_req;
      end
      2'b01 : begin
        _zz_s0_r4_byp1_im_0_req = s0_r4_c1_im_0_to_s0_r4_byp1_im_req;
      end
      2'b10 : begin
        _zz_s0_r4_byp1_im_0_req = 1'b1;
      end
      default : begin
        _zz_s0_r4_byp1_im_0_req = 1'b1;
      end
    endcase
  end

  assign s0_r4_byp1_im_0_req = _zz_s0_r4_byp1_im_0_req;
  assign s0_cmul1_mas_im_0_to_s0_r4_byp1_im_ack = ((s0_r4_byp1_im_sel != 2'b00) || s0_r4_byp1_im_0_ack);
  assign s0_r4_c1_im_0_to_s0_r4_byp1_im_ack = ((s0_r4_byp1_im_sel != 2'b01) || s0_r4_byp1_im_0_ack);
  assign cfg_s0_r4_byp1_im_to_s0_r4_byp1_im_ack = 1'b1;
  assign s0_r4_byp2_re_sel = cfg_s0_r4_byp2_re;
  always @(*) begin
    case(s0_r4_byp2_re_sel)
      2'b00 : begin
        _zz_s0_r4_byp2_re_0_nxt = s0_cmul2_mas_re_0;
      end
      2'b01 : begin
        _zz_s0_r4_byp2_re_0_nxt = s0_r4_c2_re_0;
      end
      2'b10 : begin
        _zz_s0_r4_byp2_re_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s0_r4_byp2_re_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s0_r4_byp2_re_0_nxt = _zz_s0_r4_byp2_re_0_nxt;
  always @(*) begin
    case(s0_r4_byp2_re_sel)
      2'b00 : begin
        _zz_s0_r4_byp2_re_0_req = s0_cmul2_mas_re_0_to_s0_r4_byp2_re_req;
      end
      2'b01 : begin
        _zz_s0_r4_byp2_re_0_req = s0_r4_c2_re_0_to_s0_r4_byp2_re_req;
      end
      2'b10 : begin
        _zz_s0_r4_byp2_re_0_req = 1'b1;
      end
      default : begin
        _zz_s0_r4_byp2_re_0_req = 1'b1;
      end
    endcase
  end

  assign s0_r4_byp2_re_0_req = _zz_s0_r4_byp2_re_0_req;
  assign s0_cmul2_mas_re_0_to_s0_r4_byp2_re_ack = ((s0_r4_byp2_re_sel != 2'b00) || s0_r4_byp2_re_0_ack);
  assign s0_r4_c2_re_0_to_s0_r4_byp2_re_ack = ((s0_r4_byp2_re_sel != 2'b01) || s0_r4_byp2_re_0_ack);
  assign cfg_s0_r4_byp2_re_to_s0_r4_byp2_re_ack = 1'b1;
  assign s0_r4_byp2_im_sel = cfg_s0_r4_byp2_im;
  always @(*) begin
    case(s0_r4_byp2_im_sel)
      2'b00 : begin
        _zz_s0_r4_byp2_im_0_nxt = s0_cmul2_mas_im_0;
      end
      2'b01 : begin
        _zz_s0_r4_byp2_im_0_nxt = s0_r4_c2_im_0;
      end
      2'b10 : begin
        _zz_s0_r4_byp2_im_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s0_r4_byp2_im_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s0_r4_byp2_im_0_nxt = _zz_s0_r4_byp2_im_0_nxt;
  always @(*) begin
    case(s0_r4_byp2_im_sel)
      2'b00 : begin
        _zz_s0_r4_byp2_im_0_req = s0_cmul2_mas_im_0_to_s0_r4_byp2_im_req;
      end
      2'b01 : begin
        _zz_s0_r4_byp2_im_0_req = s0_r4_c2_im_0_to_s0_r4_byp2_im_req;
      end
      2'b10 : begin
        _zz_s0_r4_byp2_im_0_req = 1'b1;
      end
      default : begin
        _zz_s0_r4_byp2_im_0_req = 1'b1;
      end
    endcase
  end

  assign s0_r4_byp2_im_0_req = _zz_s0_r4_byp2_im_0_req;
  assign s0_cmul2_mas_im_0_to_s0_r4_byp2_im_ack = ((s0_r4_byp2_im_sel != 2'b00) || s0_r4_byp2_im_0_ack);
  assign s0_r4_c2_im_0_to_s0_r4_byp2_im_ack = ((s0_r4_byp2_im_sel != 2'b01) || s0_r4_byp2_im_0_ack);
  assign cfg_s0_r4_byp2_im_to_s0_r4_byp2_im_ack = 1'b1;
  assign s0_r4_byp3_re_sel = cfg_s0_r4_byp3_re;
  always @(*) begin
    case(s0_r4_byp3_re_sel)
      2'b00 : begin
        _zz_s0_r4_byp3_re_0_nxt = s0_cmul3_mas_re_0;
      end
      2'b01 : begin
        _zz_s0_r4_byp3_re_0_nxt = s0_r4_c3_re_0;
      end
      2'b10 : begin
        _zz_s0_r4_byp3_re_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s0_r4_byp3_re_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s0_r4_byp3_re_0_nxt = _zz_s0_r4_byp3_re_0_nxt;
  always @(*) begin
    case(s0_r4_byp3_re_sel)
      2'b00 : begin
        _zz_s0_r4_byp3_re_0_req = s0_cmul3_mas_re_0_to_s0_r4_byp3_re_req;
      end
      2'b01 : begin
        _zz_s0_r4_byp3_re_0_req = s0_r4_c3_re_0_to_s0_r4_byp3_re_req;
      end
      2'b10 : begin
        _zz_s0_r4_byp3_re_0_req = 1'b1;
      end
      default : begin
        _zz_s0_r4_byp3_re_0_req = 1'b1;
      end
    endcase
  end

  assign s0_r4_byp3_re_0_req = _zz_s0_r4_byp3_re_0_req;
  assign s0_cmul3_mas_re_0_to_s0_r4_byp3_re_ack = ((s0_r4_byp3_re_sel != 2'b00) || s0_r4_byp3_re_0_ack);
  assign s0_r4_c3_re_0_to_s0_r4_byp3_re_ack = ((s0_r4_byp3_re_sel != 2'b01) || s0_r4_byp3_re_0_ack);
  assign cfg_s0_r4_byp3_re_to_s0_r4_byp3_re_ack = 1'b1;
  assign s0_r4_byp3_im_sel = cfg_s0_r4_byp3_im;
  always @(*) begin
    case(s0_r4_byp3_im_sel)
      2'b00 : begin
        _zz_s0_r4_byp3_im_0_nxt = s0_cmul3_mas_im_0;
      end
      2'b01 : begin
        _zz_s0_r4_byp3_im_0_nxt = s0_r4_c3_im_0;
      end
      2'b10 : begin
        _zz_s0_r4_byp3_im_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s0_r4_byp3_im_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s0_r4_byp3_im_0_nxt = _zz_s0_r4_byp3_im_0_nxt;
  always @(*) begin
    case(s0_r4_byp3_im_sel)
      2'b00 : begin
        _zz_s0_r4_byp3_im_0_req = s0_cmul3_mas_im_0_to_s0_r4_byp3_im_req;
      end
      2'b01 : begin
        _zz_s0_r4_byp3_im_0_req = s0_r4_c3_im_0_to_s0_r4_byp3_im_req;
      end
      2'b10 : begin
        _zz_s0_r4_byp3_im_0_req = 1'b1;
      end
      default : begin
        _zz_s0_r4_byp3_im_0_req = 1'b1;
      end
    endcase
  end

  assign s0_r4_byp3_im_0_req = _zz_s0_r4_byp3_im_0_req;
  assign s0_cmul3_mas_im_0_to_s0_r4_byp3_im_ack = ((s0_r4_byp3_im_sel != 2'b00) || s0_r4_byp3_im_0_ack);
  assign s0_r4_c3_im_0_to_s0_r4_byp3_im_ack = ((s0_r4_byp3_im_sel != 2'b01) || s0_r4_byp3_im_0_ack);
  assign cfg_s0_r4_byp3_im_to_s0_r4_byp3_im_ack = 1'b1;
  assign s1_r4_a0_re_0_nxt = _zz_s1_r4_a0_re_0_nxt;
  assign s1_r4_a0_re_0_req = (s1_cmul0_mas_re_0_to_s1_r4_a0_re_req && s1_cmul2_mas_re_0_to_s1_r4_a0_re_req);
  assign s1_cmul0_mas_re_0_to_s1_r4_a0_re_ack = (s1_r4_a0_re_0_ack && s1_cmul2_mas_re_0_to_s1_r4_a0_re_req);
  assign s1_cmul2_mas_re_0_to_s1_r4_a0_re_ack = (s1_r4_a0_re_0_ack && s1_cmul0_mas_re_0_to_s1_r4_a0_re_req);
  assign s1_r4_a0_im_0_nxt = _zz_s1_r4_a0_im_0_nxt;
  assign s1_r4_a0_im_0_req = (s1_cmul0_mas_im_0_to_s1_r4_a0_im_req && s1_cmul2_mas_im_0_to_s1_r4_a0_im_req);
  assign s1_cmul0_mas_im_0_to_s1_r4_a0_im_ack = (s1_r4_a0_im_0_ack && s1_cmul2_mas_im_0_to_s1_r4_a0_im_req);
  assign s1_cmul2_mas_im_0_to_s1_r4_a0_im_ack = (s1_r4_a0_im_0_ack && s1_cmul0_mas_im_0_to_s1_r4_a0_im_req);
  assign s1_r4_a1_re_0_nxt = _zz_s1_r4_a1_re_0_nxt;
  assign s1_r4_a1_re_0_req = (s1_cmul1_mas_re_0_to_s1_r4_a1_re_req && s1_cmul3_mas_re_0_to_s1_r4_a1_re_req);
  assign s1_cmul1_mas_re_0_to_s1_r4_a1_re_ack = (s1_r4_a1_re_0_ack && s1_cmul3_mas_re_0_to_s1_r4_a1_re_req);
  assign s1_cmul3_mas_re_0_to_s1_r4_a1_re_ack = (s1_r4_a1_re_0_ack && s1_cmul1_mas_re_0_to_s1_r4_a1_re_req);
  assign s1_r4_a1_im_0_nxt = _zz_s1_r4_a1_im_0_nxt;
  assign s1_r4_a1_im_0_req = (s1_cmul1_mas_im_0_to_s1_r4_a1_im_req && s1_cmul3_mas_im_0_to_s1_r4_a1_im_req);
  assign s1_cmul1_mas_im_0_to_s1_r4_a1_im_ack = (s1_r4_a1_im_0_ack && s1_cmul3_mas_im_0_to_s1_r4_a1_im_req);
  assign s1_cmul3_mas_im_0_to_s1_r4_a1_im_ack = (s1_r4_a1_im_0_ack && s1_cmul1_mas_im_0_to_s1_r4_a1_im_req);
  assign s1_r4_a2_re_0_nxt = _zz_s1_r4_a2_re_0_nxt;
  assign s1_r4_a2_re_0_req = (s1_cmul0_mas_re_0_to_s1_r4_a2_re_req && s1_cmul2_mas_re_0_to_s1_r4_a2_re_req);
  assign s1_cmul0_mas_re_0_to_s1_r4_a2_re_ack = (s1_r4_a2_re_0_ack && s1_cmul2_mas_re_0_to_s1_r4_a2_re_req);
  assign s1_cmul2_mas_re_0_to_s1_r4_a2_re_ack = (s1_r4_a2_re_0_ack && s1_cmul0_mas_re_0_to_s1_r4_a2_re_req);
  assign s1_r4_a2_im_0_nxt = _zz_s1_r4_a2_im_0_nxt;
  assign s1_r4_a2_im_0_req = (s1_cmul0_mas_im_0_to_s1_r4_a2_im_req && s1_cmul2_mas_im_0_to_s1_r4_a2_im_req);
  assign s1_cmul0_mas_im_0_to_s1_r4_a2_im_ack = (s1_r4_a2_im_0_ack && s1_cmul2_mas_im_0_to_s1_r4_a2_im_req);
  assign s1_cmul2_mas_im_0_to_s1_r4_a2_im_ack = (s1_r4_a2_im_0_ack && s1_cmul0_mas_im_0_to_s1_r4_a2_im_req);
  assign s1_r4_a3_re_0_nxt = _zz_s1_r4_a3_re_0_nxt;
  assign s1_r4_a3_re_0_req = (s1_cmul1_mas_re_0_to_s1_r4_a3_re_req && s1_cmul3_mas_re_0_to_s1_r4_a3_re_req);
  assign s1_cmul1_mas_re_0_to_s1_r4_a3_re_ack = (s1_r4_a3_re_0_ack && s1_cmul3_mas_re_0_to_s1_r4_a3_re_req);
  assign s1_cmul3_mas_re_0_to_s1_r4_a3_re_ack = (s1_r4_a3_re_0_ack && s1_cmul1_mas_re_0_to_s1_r4_a3_re_req);
  assign s1_r4_a3_im_0_nxt = _zz_s1_r4_a3_im_0_nxt;
  assign s1_r4_a3_im_0_req = (s1_cmul1_mas_im_0_to_s1_r4_a3_im_req && s1_cmul3_mas_im_0_to_s1_r4_a3_im_req);
  assign s1_cmul1_mas_im_0_to_s1_r4_a3_im_ack = (s1_r4_a3_im_0_ack && s1_cmul3_mas_im_0_to_s1_r4_a3_im_req);
  assign s1_cmul3_mas_im_0_to_s1_r4_a3_im_ack = (s1_r4_a3_im_0_ack && s1_cmul1_mas_im_0_to_s1_r4_a3_im_req);
  assign s1_r4_c0_re_0 = _zz_s1_r4_c0_re_0;
  assign s1_r4_c0_re_0_req = (s1_r4_a0_re_0_to_s1_r4_c0_re_req && s1_r4_a1_re_0_to_s1_r4_c0_re_req);
  assign s1_r4_a0_re_0_to_s1_r4_c0_re_ack = (s1_r4_c0_re_0_ack && s1_r4_a1_re_0_to_s1_r4_c0_re_req);
  assign s1_r4_a1_re_0_to_s1_r4_c0_re_ack = (s1_r4_c0_re_0_ack && s1_r4_a0_re_0_to_s1_r4_c0_re_req);
  assign s1_r4_c0_im_0 = _zz_s1_r4_c0_im_0;
  assign s1_r4_c0_im_0_req = (s1_r4_a0_im_0_to_s1_r4_c0_im_req && s1_r4_a1_im_0_to_s1_r4_c0_im_req);
  assign s1_r4_a0_im_0_to_s1_r4_c0_im_ack = (s1_r4_c0_im_0_ack && s1_r4_a1_im_0_to_s1_r4_c0_im_req);
  assign s1_r4_a1_im_0_to_s1_r4_c0_im_ack = (s1_r4_c0_im_0_ack && s1_r4_a0_im_0_to_s1_r4_c0_im_req);
  assign s1_r4_c1_re_0 = _zz_s1_r4_c1_re_0;
  assign s1_r4_c1_re_0_req = (s1_r4_a2_re_0_to_s1_r4_c1_re_req && s1_r4_a3_im_0_to_s1_r4_c1_re_req);
  assign s1_r4_a2_re_0_to_s1_r4_c1_re_ack = (s1_r4_c1_re_0_ack && s1_r4_a3_im_0_to_s1_r4_c1_re_req);
  assign s1_r4_a3_im_0_to_s1_r4_c1_re_ack = (s1_r4_c1_re_0_ack && s1_r4_a2_re_0_to_s1_r4_c1_re_req);
  assign s1_r4_c1_im_0 = _zz_s1_r4_c1_im_0;
  assign s1_r4_c1_im_0_req = (s1_r4_a2_im_0_to_s1_r4_c1_im_req && s1_r4_a3_re_0_to_s1_r4_c1_im_req);
  assign s1_r4_a2_im_0_to_s1_r4_c1_im_ack = (s1_r4_c1_im_0_ack && s1_r4_a3_re_0_to_s1_r4_c1_im_req);
  assign s1_r4_a3_re_0_to_s1_r4_c1_im_ack = (s1_r4_c1_im_0_ack && s1_r4_a2_im_0_to_s1_r4_c1_im_req);
  assign s1_r4_c2_re_0 = _zz_s1_r4_c2_re_0;
  assign s1_r4_c2_re_0_req = (s1_r4_a0_re_0_to_s1_r4_c2_re_req && s1_r4_a1_re_0_to_s1_r4_c2_re_req);
  assign s1_r4_a0_re_0_to_s1_r4_c2_re_ack = (s1_r4_c2_re_0_ack && s1_r4_a1_re_0_to_s1_r4_c2_re_req);
  assign s1_r4_a1_re_0_to_s1_r4_c2_re_ack = (s1_r4_c2_re_0_ack && s1_r4_a0_re_0_to_s1_r4_c2_re_req);
  assign s1_r4_c2_im_0 = _zz_s1_r4_c2_im_0;
  assign s1_r4_c2_im_0_req = (s1_r4_a0_im_0_to_s1_r4_c2_im_req && s1_r4_a1_im_0_to_s1_r4_c2_im_req);
  assign s1_r4_a0_im_0_to_s1_r4_c2_im_ack = (s1_r4_c2_im_0_ack && s1_r4_a1_im_0_to_s1_r4_c2_im_req);
  assign s1_r4_a1_im_0_to_s1_r4_c2_im_ack = (s1_r4_c2_im_0_ack && s1_r4_a0_im_0_to_s1_r4_c2_im_req);
  assign s1_r4_c3_re_0 = _zz_s1_r4_c3_re_0;
  assign s1_r4_c3_re_0_req = (s1_r4_a2_re_0_to_s1_r4_c3_re_req && s1_r4_a3_im_0_to_s1_r4_c3_re_req);
  assign s1_r4_a2_re_0_to_s1_r4_c3_re_ack = (s1_r4_c3_re_0_ack && s1_r4_a3_im_0_to_s1_r4_c3_re_req);
  assign s1_r4_a3_im_0_to_s1_r4_c3_re_ack = (s1_r4_c3_re_0_ack && s1_r4_a2_re_0_to_s1_r4_c3_re_req);
  assign s1_r4_c3_im_0 = _zz_s1_r4_c3_im_0;
  assign s1_r4_c3_im_0_req = (s1_r4_a2_im_0_to_s1_r4_c3_im_req && s1_r4_a3_re_0_to_s1_r4_c3_im_req);
  assign s1_r4_a2_im_0_to_s1_r4_c3_im_ack = (s1_r4_c3_im_0_ack && s1_r4_a3_re_0_to_s1_r4_c3_im_req);
  assign s1_r4_a3_re_0_to_s1_r4_c3_im_ack = (s1_r4_c3_im_0_ack && s1_r4_a2_im_0_to_s1_r4_c3_im_req);
  assign s1_r4_byp0_re_sel = cfg_s1_r4_byp0_re;
  always @(*) begin
    case(s1_r4_byp0_re_sel)
      2'b00 : begin
        _zz_s1_r4_byp0_re_0_nxt = s1_cmul0_mas_re_0;
      end
      2'b01 : begin
        _zz_s1_r4_byp0_re_0_nxt = s1_r4_c0_re_0;
      end
      2'b10 : begin
        _zz_s1_r4_byp0_re_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s1_r4_byp0_re_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s1_r4_byp0_re_0_nxt = _zz_s1_r4_byp0_re_0_nxt;
  always @(*) begin
    case(s1_r4_byp0_re_sel)
      2'b00 : begin
        _zz_s1_r4_byp0_re_0_req = s1_cmul0_mas_re_0_to_s1_r4_byp0_re_req;
      end
      2'b01 : begin
        _zz_s1_r4_byp0_re_0_req = s1_r4_c0_re_0_to_s1_r4_byp0_re_req;
      end
      2'b10 : begin
        _zz_s1_r4_byp0_re_0_req = 1'b1;
      end
      default : begin
        _zz_s1_r4_byp0_re_0_req = 1'b1;
      end
    endcase
  end

  assign s1_r4_byp0_re_0_req = _zz_s1_r4_byp0_re_0_req;
  assign s1_cmul0_mas_re_0_to_s1_r4_byp0_re_ack = ((s1_r4_byp0_re_sel != 2'b00) || s1_r4_byp0_re_0_ack);
  assign s1_r4_c0_re_0_to_s1_r4_byp0_re_ack = ((s1_r4_byp0_re_sel != 2'b01) || s1_r4_byp0_re_0_ack);
  assign cfg_s1_r4_byp0_re_to_s1_r4_byp0_re_ack = 1'b1;
  assign s1_r4_byp0_im_sel = cfg_s1_r4_byp0_im;
  always @(*) begin
    case(s1_r4_byp0_im_sel)
      2'b00 : begin
        _zz_s1_r4_byp0_im_0_nxt = s1_cmul0_mas_im_0;
      end
      2'b01 : begin
        _zz_s1_r4_byp0_im_0_nxt = s1_r4_c0_im_0;
      end
      2'b10 : begin
        _zz_s1_r4_byp0_im_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s1_r4_byp0_im_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s1_r4_byp0_im_0_nxt = _zz_s1_r4_byp0_im_0_nxt;
  always @(*) begin
    case(s1_r4_byp0_im_sel)
      2'b00 : begin
        _zz_s1_r4_byp0_im_0_req = s1_cmul0_mas_im_0_to_s1_r4_byp0_im_req;
      end
      2'b01 : begin
        _zz_s1_r4_byp0_im_0_req = s1_r4_c0_im_0_to_s1_r4_byp0_im_req;
      end
      2'b10 : begin
        _zz_s1_r4_byp0_im_0_req = 1'b1;
      end
      default : begin
        _zz_s1_r4_byp0_im_0_req = 1'b1;
      end
    endcase
  end

  assign s1_r4_byp0_im_0_req = _zz_s1_r4_byp0_im_0_req;
  assign s1_cmul0_mas_im_0_to_s1_r4_byp0_im_ack = ((s1_r4_byp0_im_sel != 2'b00) || s1_r4_byp0_im_0_ack);
  assign s1_r4_c0_im_0_to_s1_r4_byp0_im_ack = ((s1_r4_byp0_im_sel != 2'b01) || s1_r4_byp0_im_0_ack);
  assign cfg_s1_r4_byp0_im_to_s1_r4_byp0_im_ack = 1'b1;
  assign s1_r4_byp1_re_sel = cfg_s1_r4_byp1_re;
  always @(*) begin
    case(s1_r4_byp1_re_sel)
      2'b00 : begin
        _zz_s1_r4_byp1_re_0_nxt = s1_cmul1_mas_re_0;
      end
      2'b01 : begin
        _zz_s1_r4_byp1_re_0_nxt = s1_r4_c1_re_0;
      end
      2'b10 : begin
        _zz_s1_r4_byp1_re_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s1_r4_byp1_re_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s1_r4_byp1_re_0_nxt = _zz_s1_r4_byp1_re_0_nxt;
  always @(*) begin
    case(s1_r4_byp1_re_sel)
      2'b00 : begin
        _zz_s1_r4_byp1_re_0_req = s1_cmul1_mas_re_0_to_s1_r4_byp1_re_req;
      end
      2'b01 : begin
        _zz_s1_r4_byp1_re_0_req = s1_r4_c1_re_0_to_s1_r4_byp1_re_req;
      end
      2'b10 : begin
        _zz_s1_r4_byp1_re_0_req = 1'b1;
      end
      default : begin
        _zz_s1_r4_byp1_re_0_req = 1'b1;
      end
    endcase
  end

  assign s1_r4_byp1_re_0_req = _zz_s1_r4_byp1_re_0_req;
  assign s1_cmul1_mas_re_0_to_s1_r4_byp1_re_ack = ((s1_r4_byp1_re_sel != 2'b00) || s1_r4_byp1_re_0_ack);
  assign s1_r4_c1_re_0_to_s1_r4_byp1_re_ack = ((s1_r4_byp1_re_sel != 2'b01) || s1_r4_byp1_re_0_ack);
  assign cfg_s1_r4_byp1_re_to_s1_r4_byp1_re_ack = 1'b1;
  assign s1_r4_byp1_im_sel = cfg_s1_r4_byp1_im;
  always @(*) begin
    case(s1_r4_byp1_im_sel)
      2'b00 : begin
        _zz_s1_r4_byp1_im_0_nxt = s1_cmul1_mas_im_0;
      end
      2'b01 : begin
        _zz_s1_r4_byp1_im_0_nxt = s1_r4_c1_im_0;
      end
      2'b10 : begin
        _zz_s1_r4_byp1_im_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s1_r4_byp1_im_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s1_r4_byp1_im_0_nxt = _zz_s1_r4_byp1_im_0_nxt;
  always @(*) begin
    case(s1_r4_byp1_im_sel)
      2'b00 : begin
        _zz_s1_r4_byp1_im_0_req = s1_cmul1_mas_im_0_to_s1_r4_byp1_im_req;
      end
      2'b01 : begin
        _zz_s1_r4_byp1_im_0_req = s1_r4_c1_im_0_to_s1_r4_byp1_im_req;
      end
      2'b10 : begin
        _zz_s1_r4_byp1_im_0_req = 1'b1;
      end
      default : begin
        _zz_s1_r4_byp1_im_0_req = 1'b1;
      end
    endcase
  end

  assign s1_r4_byp1_im_0_req = _zz_s1_r4_byp1_im_0_req;
  assign s1_cmul1_mas_im_0_to_s1_r4_byp1_im_ack = ((s1_r4_byp1_im_sel != 2'b00) || s1_r4_byp1_im_0_ack);
  assign s1_r4_c1_im_0_to_s1_r4_byp1_im_ack = ((s1_r4_byp1_im_sel != 2'b01) || s1_r4_byp1_im_0_ack);
  assign cfg_s1_r4_byp1_im_to_s1_r4_byp1_im_ack = 1'b1;
  assign s1_r4_byp2_re_sel = cfg_s1_r4_byp2_re;
  always @(*) begin
    case(s1_r4_byp2_re_sel)
      2'b00 : begin
        _zz_s1_r4_byp2_re_0_nxt = s1_cmul2_mas_re_0;
      end
      2'b01 : begin
        _zz_s1_r4_byp2_re_0_nxt = s1_r4_c2_re_0;
      end
      2'b10 : begin
        _zz_s1_r4_byp2_re_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s1_r4_byp2_re_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s1_r4_byp2_re_0_nxt = _zz_s1_r4_byp2_re_0_nxt;
  always @(*) begin
    case(s1_r4_byp2_re_sel)
      2'b00 : begin
        _zz_s1_r4_byp2_re_0_req = s1_cmul2_mas_re_0_to_s1_r4_byp2_re_req;
      end
      2'b01 : begin
        _zz_s1_r4_byp2_re_0_req = s1_r4_c2_re_0_to_s1_r4_byp2_re_req;
      end
      2'b10 : begin
        _zz_s1_r4_byp2_re_0_req = 1'b1;
      end
      default : begin
        _zz_s1_r4_byp2_re_0_req = 1'b1;
      end
    endcase
  end

  assign s1_r4_byp2_re_0_req = _zz_s1_r4_byp2_re_0_req;
  assign s1_cmul2_mas_re_0_to_s1_r4_byp2_re_ack = ((s1_r4_byp2_re_sel != 2'b00) || s1_r4_byp2_re_0_ack);
  assign s1_r4_c2_re_0_to_s1_r4_byp2_re_ack = ((s1_r4_byp2_re_sel != 2'b01) || s1_r4_byp2_re_0_ack);
  assign cfg_s1_r4_byp2_re_to_s1_r4_byp2_re_ack = 1'b1;
  assign s1_r4_byp2_im_sel = cfg_s1_r4_byp2_im;
  always @(*) begin
    case(s1_r4_byp2_im_sel)
      2'b00 : begin
        _zz_s1_r4_byp2_im_0_nxt = s1_cmul2_mas_im_0;
      end
      2'b01 : begin
        _zz_s1_r4_byp2_im_0_nxt = s1_r4_c2_im_0;
      end
      2'b10 : begin
        _zz_s1_r4_byp2_im_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s1_r4_byp2_im_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s1_r4_byp2_im_0_nxt = _zz_s1_r4_byp2_im_0_nxt;
  always @(*) begin
    case(s1_r4_byp2_im_sel)
      2'b00 : begin
        _zz_s1_r4_byp2_im_0_req = s1_cmul2_mas_im_0_to_s1_r4_byp2_im_req;
      end
      2'b01 : begin
        _zz_s1_r4_byp2_im_0_req = s1_r4_c2_im_0_to_s1_r4_byp2_im_req;
      end
      2'b10 : begin
        _zz_s1_r4_byp2_im_0_req = 1'b1;
      end
      default : begin
        _zz_s1_r4_byp2_im_0_req = 1'b1;
      end
    endcase
  end

  assign s1_r4_byp2_im_0_req = _zz_s1_r4_byp2_im_0_req;
  assign s1_cmul2_mas_im_0_to_s1_r4_byp2_im_ack = ((s1_r4_byp2_im_sel != 2'b00) || s1_r4_byp2_im_0_ack);
  assign s1_r4_c2_im_0_to_s1_r4_byp2_im_ack = ((s1_r4_byp2_im_sel != 2'b01) || s1_r4_byp2_im_0_ack);
  assign cfg_s1_r4_byp2_im_to_s1_r4_byp2_im_ack = 1'b1;
  assign s1_r4_byp3_re_sel = cfg_s1_r4_byp3_re;
  always @(*) begin
    case(s1_r4_byp3_re_sel)
      2'b00 : begin
        _zz_s1_r4_byp3_re_0_nxt = s1_cmul3_mas_re_0;
      end
      2'b01 : begin
        _zz_s1_r4_byp3_re_0_nxt = s1_r4_c3_re_0;
      end
      2'b10 : begin
        _zz_s1_r4_byp3_re_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s1_r4_byp3_re_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s1_r4_byp3_re_0_nxt = _zz_s1_r4_byp3_re_0_nxt;
  always @(*) begin
    case(s1_r4_byp3_re_sel)
      2'b00 : begin
        _zz_s1_r4_byp3_re_0_req = s1_cmul3_mas_re_0_to_s1_r4_byp3_re_req;
      end
      2'b01 : begin
        _zz_s1_r4_byp3_re_0_req = s1_r4_c3_re_0_to_s1_r4_byp3_re_req;
      end
      2'b10 : begin
        _zz_s1_r4_byp3_re_0_req = 1'b1;
      end
      default : begin
        _zz_s1_r4_byp3_re_0_req = 1'b1;
      end
    endcase
  end

  assign s1_r4_byp3_re_0_req = _zz_s1_r4_byp3_re_0_req;
  assign s1_cmul3_mas_re_0_to_s1_r4_byp3_re_ack = ((s1_r4_byp3_re_sel != 2'b00) || s1_r4_byp3_re_0_ack);
  assign s1_r4_c3_re_0_to_s1_r4_byp3_re_ack = ((s1_r4_byp3_re_sel != 2'b01) || s1_r4_byp3_re_0_ack);
  assign cfg_s1_r4_byp3_re_to_s1_r4_byp3_re_ack = 1'b1;
  assign s1_r4_byp3_im_sel = cfg_s1_r4_byp3_im;
  always @(*) begin
    case(s1_r4_byp3_im_sel)
      2'b00 : begin
        _zz_s1_r4_byp3_im_0_nxt = s1_cmul3_mas_im_0;
      end
      2'b01 : begin
        _zz_s1_r4_byp3_im_0_nxt = s1_r4_c3_im_0;
      end
      2'b10 : begin
        _zz_s1_r4_byp3_im_0_nxt = 36'h000000001;
      end
      default : begin
        _zz_s1_r4_byp3_im_0_nxt = 36'h000000001;
      end
    endcase
  end

  assign s1_r4_byp3_im_0_nxt = _zz_s1_r4_byp3_im_0_nxt;
  always @(*) begin
    case(s1_r4_byp3_im_sel)
      2'b00 : begin
        _zz_s1_r4_byp3_im_0_req = s1_cmul3_mas_im_0_to_s1_r4_byp3_im_req;
      end
      2'b01 : begin
        _zz_s1_r4_byp3_im_0_req = s1_r4_c3_im_0_to_s1_r4_byp3_im_req;
      end
      2'b10 : begin
        _zz_s1_r4_byp3_im_0_req = 1'b1;
      end
      default : begin
        _zz_s1_r4_byp3_im_0_req = 1'b1;
      end
    endcase
  end

  assign s1_r4_byp3_im_0_req = _zz_s1_r4_byp3_im_0_req;
  assign s1_cmul3_mas_im_0_to_s1_r4_byp3_im_ack = ((s1_r4_byp3_im_sel != 2'b00) || s1_r4_byp3_im_0_ack);
  assign s1_r4_c3_im_0_to_s1_r4_byp3_im_ack = ((s1_r4_byp3_im_sel != 2'b01) || s1_r4_byp3_im_0_ack);
  assign cfg_s1_r4_byp3_im_to_s1_r4_byp3_im_ack = 1'b1;
  assign s0_k1_cat_0 = {s0_rsat3_im_0,{s0_rsat3_re_0,{s0_rsat2_im_0,{s0_rsat2_re_0,{s0_rsat1_im_0,{s0_rsat1_re_0,{s0_rsat0_im_0,s0_rsat0_re_0}}}}}}};
  assign s0_k1_cat_0_req = (((((((s0_rsat0_re_0_to_s0_k1_cat_req && s0_rsat0_im_0_to_s0_k1_cat_req) && s0_rsat1_re_0_to_s0_k1_cat_req) && s0_rsat1_im_0_to_s0_k1_cat_req) && s0_rsat2_re_0_to_s0_k1_cat_req) && s0_rsat2_im_0_to_s0_k1_cat_req) && s0_rsat3_re_0_to_s0_k1_cat_req) && s0_rsat3_im_0_to_s0_k1_cat_req);
  assign s0_rsat0_re_0_to_s0_k1_cat_ack = (((((((s0_k1_cat_0_ack && s0_rsat0_im_0_to_s0_k1_cat_req) && s0_rsat1_re_0_to_s0_k1_cat_req) && s0_rsat1_im_0_to_s0_k1_cat_req) && s0_rsat2_re_0_to_s0_k1_cat_req) && s0_rsat2_im_0_to_s0_k1_cat_req) && s0_rsat3_re_0_to_s0_k1_cat_req) && s0_rsat3_im_0_to_s0_k1_cat_req);
  assign s0_rsat0_im_0_to_s0_k1_cat_ack = (((((((s0_k1_cat_0_ack && s0_rsat0_re_0_to_s0_k1_cat_req) && s0_rsat1_re_0_to_s0_k1_cat_req) && s0_rsat1_im_0_to_s0_k1_cat_req) && s0_rsat2_re_0_to_s0_k1_cat_req) && s0_rsat2_im_0_to_s0_k1_cat_req) && s0_rsat3_re_0_to_s0_k1_cat_req) && s0_rsat3_im_0_to_s0_k1_cat_req);
  assign s0_rsat1_re_0_to_s0_k1_cat_ack = (((((((s0_k1_cat_0_ack && s0_rsat0_re_0_to_s0_k1_cat_req) && s0_rsat0_im_0_to_s0_k1_cat_req) && s0_rsat1_im_0_to_s0_k1_cat_req) && s0_rsat2_re_0_to_s0_k1_cat_req) && s0_rsat2_im_0_to_s0_k1_cat_req) && s0_rsat3_re_0_to_s0_k1_cat_req) && s0_rsat3_im_0_to_s0_k1_cat_req);
  assign s0_rsat1_im_0_to_s0_k1_cat_ack = (((((((s0_k1_cat_0_ack && s0_rsat0_re_0_to_s0_k1_cat_req) && s0_rsat0_im_0_to_s0_k1_cat_req) && s0_rsat1_re_0_to_s0_k1_cat_req) && s0_rsat2_re_0_to_s0_k1_cat_req) && s0_rsat2_im_0_to_s0_k1_cat_req) && s0_rsat3_re_0_to_s0_k1_cat_req) && s0_rsat3_im_0_to_s0_k1_cat_req);
  assign s0_rsat2_re_0_to_s0_k1_cat_ack = (((((((s0_k1_cat_0_ack && s0_rsat0_re_0_to_s0_k1_cat_req) && s0_rsat0_im_0_to_s0_k1_cat_req) && s0_rsat1_re_0_to_s0_k1_cat_req) && s0_rsat1_im_0_to_s0_k1_cat_req) && s0_rsat2_im_0_to_s0_k1_cat_req) && s0_rsat3_re_0_to_s0_k1_cat_req) && s0_rsat3_im_0_to_s0_k1_cat_req);
  assign s0_rsat2_im_0_to_s0_k1_cat_ack = (((((((s0_k1_cat_0_ack && s0_rsat0_re_0_to_s0_k1_cat_req) && s0_rsat0_im_0_to_s0_k1_cat_req) && s0_rsat1_re_0_to_s0_k1_cat_req) && s0_rsat1_im_0_to_s0_k1_cat_req) && s0_rsat2_re_0_to_s0_k1_cat_req) && s0_rsat3_re_0_to_s0_k1_cat_req) && s0_rsat3_im_0_to_s0_k1_cat_req);
  assign s0_rsat3_re_0_to_s0_k1_cat_ack = (((((((s0_k1_cat_0_ack && s0_rsat0_re_0_to_s0_k1_cat_req) && s0_rsat0_im_0_to_s0_k1_cat_req) && s0_rsat1_re_0_to_s0_k1_cat_req) && s0_rsat1_im_0_to_s0_k1_cat_req) && s0_rsat2_re_0_to_s0_k1_cat_req) && s0_rsat2_im_0_to_s0_k1_cat_req) && s0_rsat3_im_0_to_s0_k1_cat_req);
  assign s0_rsat3_im_0_to_s0_k1_cat_ack = (((((((s0_k1_cat_0_ack && s0_rsat0_re_0_to_s0_k1_cat_req) && s0_rsat0_im_0_to_s0_k1_cat_req) && s0_rsat1_re_0_to_s0_k1_cat_req) && s0_rsat1_im_0_to_s0_k1_cat_req) && s0_rsat2_re_0_to_s0_k1_cat_req) && s0_rsat2_im_0_to_s0_k1_cat_req) && s0_rsat3_re_0_to_s0_k1_cat_req);
  assign s0_bs0_re_0_nxt = s0_bs0_re_i_0_dat;
  assign s0_bs0_re_clk = clk;
  assign s0_bs0_re_reset_n = reset_n;
  assign s0_bs0_re_0_req = s0_r4_byp0_re_0_to_s0_bs0_re_req;
  assign s0_r4_byp0_re_0_to_s0_bs0_re_ack = s0_bs0_re_0_ack;
  assign cfg_s0_bs0_re_to_s0_bs0_re_ack = 1'b1;
  assign s0_bs0_im_0_nxt = s0_bs0_im_i_0_dat;
  assign s0_bs0_im_clk = clk;
  assign s0_bs0_im_reset_n = reset_n;
  assign s0_bs0_im_0_req = s0_r4_byp0_im_0_to_s0_bs0_im_req;
  assign s0_r4_byp0_im_0_to_s0_bs0_im_ack = s0_bs0_im_0_ack;
  assign cfg_s0_bs0_im_to_s0_bs0_im_ack = 1'b1;
  assign s0_rsat0_re_0_nxt = s0_rsat0_re_i_0_dat;
  assign s0_rsat0_re_clk = clk;
  assign s0_rsat0_re_reset_n = reset_n;
  assign s0_rsat0_re_0_req = s0_bs0_re_0_to_s0_rsat0_re_req;
  assign s0_bs0_re_0_to_s0_rsat0_re_ack = s0_rsat0_re_0_ack;
  assign s0_rsat0_im_0_nxt = s0_rsat0_im_i_0_dat;
  assign s0_rsat0_im_clk = clk;
  assign s0_rsat0_im_reset_n = reset_n;
  assign s0_rsat0_im_0_req = s0_bs0_im_0_to_s0_rsat0_im_req;
  assign s0_bs0_im_0_to_s0_rsat0_im_ack = s0_rsat0_im_0_ack;
  assign s0_bs1_re_0_nxt = s0_bs1_re_i_0_dat;
  assign s0_bs1_re_clk = clk;
  assign s0_bs1_re_reset_n = reset_n;
  assign s0_bs1_re_0_req = s0_r4_byp1_re_0_to_s0_bs1_re_req;
  assign s0_r4_byp1_re_0_to_s0_bs1_re_ack = s0_bs1_re_0_ack;
  assign cfg_s0_bs1_re_to_s0_bs1_re_ack = 1'b1;
  assign s0_bs1_im_0_nxt = s0_bs1_im_i_0_dat;
  assign s0_bs1_im_clk = clk;
  assign s0_bs1_im_reset_n = reset_n;
  assign s0_bs1_im_0_req = s0_r4_byp1_im_0_to_s0_bs1_im_req;
  assign s0_r4_byp1_im_0_to_s0_bs1_im_ack = s0_bs1_im_0_ack;
  assign cfg_s0_bs1_im_to_s0_bs1_im_ack = 1'b1;
  assign s0_rsat1_re_0_nxt = s0_rsat1_re_i_0_dat;
  assign s0_rsat1_re_clk = clk;
  assign s0_rsat1_re_reset_n = reset_n;
  assign s0_rsat1_re_0_req = s0_bs1_re_0_to_s0_rsat1_re_req;
  assign s0_bs1_re_0_to_s0_rsat1_re_ack = s0_rsat1_re_0_ack;
  assign s0_rsat1_im_0_nxt = s0_rsat1_im_i_0_dat;
  assign s0_rsat1_im_clk = clk;
  assign s0_rsat1_im_reset_n = reset_n;
  assign s0_rsat1_im_0_req = s0_bs1_im_0_to_s0_rsat1_im_req;
  assign s0_bs1_im_0_to_s0_rsat1_im_ack = s0_rsat1_im_0_ack;
  assign s0_bs2_re_0_nxt = s0_bs2_re_i_0_dat;
  assign s0_bs2_re_clk = clk;
  assign s0_bs2_re_reset_n = reset_n;
  assign s0_bs2_re_0_req = s0_r4_byp2_re_0_to_s0_bs2_re_req;
  assign s0_r4_byp2_re_0_to_s0_bs2_re_ack = s0_bs2_re_0_ack;
  assign cfg_s0_bs2_re_to_s0_bs2_re_ack = 1'b1;
  assign s0_bs2_im_0_nxt = s0_bs2_im_i_0_dat;
  assign s0_bs2_im_clk = clk;
  assign s0_bs2_im_reset_n = reset_n;
  assign s0_bs2_im_0_req = s0_r4_byp2_im_0_to_s0_bs2_im_req;
  assign s0_r4_byp2_im_0_to_s0_bs2_im_ack = s0_bs2_im_0_ack;
  assign cfg_s0_bs2_im_to_s0_bs2_im_ack = 1'b1;
  assign s0_rsat2_re_0_nxt = s0_rsat2_re_i_0_dat;
  assign s0_rsat2_re_clk = clk;
  assign s0_rsat2_re_reset_n = reset_n;
  assign s0_rsat2_re_0_req = s0_bs2_re_0_to_s0_rsat2_re_req;
  assign s0_bs2_re_0_to_s0_rsat2_re_ack = s0_rsat2_re_0_ack;
  assign s0_rsat2_im_0_nxt = s0_rsat2_im_i_0_dat;
  assign s0_rsat2_im_clk = clk;
  assign s0_rsat2_im_reset_n = reset_n;
  assign s0_rsat2_im_0_req = s0_bs2_im_0_to_s0_rsat2_im_req;
  assign s0_bs2_im_0_to_s0_rsat2_im_ack = s0_rsat2_im_0_ack;
  assign s0_bs3_re_0_nxt = s0_bs3_re_i_0_dat;
  assign s0_bs3_re_clk = clk;
  assign s0_bs3_re_reset_n = reset_n;
  assign s0_bs3_re_0_req = s0_r4_byp3_re_0_to_s0_bs3_re_req;
  assign s0_r4_byp3_re_0_to_s0_bs3_re_ack = s0_bs3_re_0_ack;
  assign cfg_s0_bs3_re_to_s0_bs3_re_ack = 1'b1;
  assign s0_bs3_im_0_nxt = s0_bs3_im_i_0_dat;
  assign s0_bs3_im_clk = clk;
  assign s0_bs3_im_reset_n = reset_n;
  assign s0_bs3_im_0_req = s0_r4_byp3_im_0_to_s0_bs3_im_req;
  assign s0_r4_byp3_im_0_to_s0_bs3_im_ack = s0_bs3_im_0_ack;
  assign cfg_s0_bs3_im_to_s0_bs3_im_ack = 1'b1;
  assign s0_rsat3_re_0_nxt = s0_rsat3_re_i_0_dat;
  assign s0_rsat3_re_clk = clk;
  assign s0_rsat3_re_reset_n = reset_n;
  assign s0_rsat3_re_0_req = s0_bs3_re_0_to_s0_rsat3_re_req;
  assign s0_bs3_re_0_to_s0_rsat3_re_ack = s0_rsat3_re_0_ack;
  assign s0_rsat3_im_0_nxt = s0_rsat3_im_i_0_dat;
  assign s0_rsat3_im_clk = clk;
  assign s0_rsat3_im_reset_n = reset_n;
  assign s0_rsat3_im_0_req = s0_bs3_im_0_to_s0_rsat3_im_req;
  assign s0_bs3_im_0_to_s0_rsat3_im_ack = s0_rsat3_im_0_ack;
  assign s1_k1_cat_0 = {s1_rsat3_im_0,{s1_rsat3_re_0,{s1_rsat2_im_0,{s1_rsat2_re_0,{s1_rsat1_im_0,{s1_rsat1_re_0,{s1_rsat0_im_0,s1_rsat0_re_0}}}}}}};
  assign s1_k1_cat_0_req = (((((((s1_rsat0_re_0_to_s1_k1_cat_req && s1_rsat0_im_0_to_s1_k1_cat_req) && s1_rsat1_re_0_to_s1_k1_cat_req) && s1_rsat1_im_0_to_s1_k1_cat_req) && s1_rsat2_re_0_to_s1_k1_cat_req) && s1_rsat2_im_0_to_s1_k1_cat_req) && s1_rsat3_re_0_to_s1_k1_cat_req) && s1_rsat3_im_0_to_s1_k1_cat_req);
  assign s1_rsat0_re_0_to_s1_k1_cat_ack = (((((((s1_k1_cat_0_ack && s1_rsat0_im_0_to_s1_k1_cat_req) && s1_rsat1_re_0_to_s1_k1_cat_req) && s1_rsat1_im_0_to_s1_k1_cat_req) && s1_rsat2_re_0_to_s1_k1_cat_req) && s1_rsat2_im_0_to_s1_k1_cat_req) && s1_rsat3_re_0_to_s1_k1_cat_req) && s1_rsat3_im_0_to_s1_k1_cat_req);
  assign s1_rsat0_im_0_to_s1_k1_cat_ack = (((((((s1_k1_cat_0_ack && s1_rsat0_re_0_to_s1_k1_cat_req) && s1_rsat1_re_0_to_s1_k1_cat_req) && s1_rsat1_im_0_to_s1_k1_cat_req) && s1_rsat2_re_0_to_s1_k1_cat_req) && s1_rsat2_im_0_to_s1_k1_cat_req) && s1_rsat3_re_0_to_s1_k1_cat_req) && s1_rsat3_im_0_to_s1_k1_cat_req);
  assign s1_rsat1_re_0_to_s1_k1_cat_ack = (((((((s1_k1_cat_0_ack && s1_rsat0_re_0_to_s1_k1_cat_req) && s1_rsat0_im_0_to_s1_k1_cat_req) && s1_rsat1_im_0_to_s1_k1_cat_req) && s1_rsat2_re_0_to_s1_k1_cat_req) && s1_rsat2_im_0_to_s1_k1_cat_req) && s1_rsat3_re_0_to_s1_k1_cat_req) && s1_rsat3_im_0_to_s1_k1_cat_req);
  assign s1_rsat1_im_0_to_s1_k1_cat_ack = (((((((s1_k1_cat_0_ack && s1_rsat0_re_0_to_s1_k1_cat_req) && s1_rsat0_im_0_to_s1_k1_cat_req) && s1_rsat1_re_0_to_s1_k1_cat_req) && s1_rsat2_re_0_to_s1_k1_cat_req) && s1_rsat2_im_0_to_s1_k1_cat_req) && s1_rsat3_re_0_to_s1_k1_cat_req) && s1_rsat3_im_0_to_s1_k1_cat_req);
  assign s1_rsat2_re_0_to_s1_k1_cat_ack = (((((((s1_k1_cat_0_ack && s1_rsat0_re_0_to_s1_k1_cat_req) && s1_rsat0_im_0_to_s1_k1_cat_req) && s1_rsat1_re_0_to_s1_k1_cat_req) && s1_rsat1_im_0_to_s1_k1_cat_req) && s1_rsat2_im_0_to_s1_k1_cat_req) && s1_rsat3_re_0_to_s1_k1_cat_req) && s1_rsat3_im_0_to_s1_k1_cat_req);
  assign s1_rsat2_im_0_to_s1_k1_cat_ack = (((((((s1_k1_cat_0_ack && s1_rsat0_re_0_to_s1_k1_cat_req) && s1_rsat0_im_0_to_s1_k1_cat_req) && s1_rsat1_re_0_to_s1_k1_cat_req) && s1_rsat1_im_0_to_s1_k1_cat_req) && s1_rsat2_re_0_to_s1_k1_cat_req) && s1_rsat3_re_0_to_s1_k1_cat_req) && s1_rsat3_im_0_to_s1_k1_cat_req);
  assign s1_rsat3_re_0_to_s1_k1_cat_ack = (((((((s1_k1_cat_0_ack && s1_rsat0_re_0_to_s1_k1_cat_req) && s1_rsat0_im_0_to_s1_k1_cat_req) && s1_rsat1_re_0_to_s1_k1_cat_req) && s1_rsat1_im_0_to_s1_k1_cat_req) && s1_rsat2_re_0_to_s1_k1_cat_req) && s1_rsat2_im_0_to_s1_k1_cat_req) && s1_rsat3_im_0_to_s1_k1_cat_req);
  assign s1_rsat3_im_0_to_s1_k1_cat_ack = (((((((s1_k1_cat_0_ack && s1_rsat0_re_0_to_s1_k1_cat_req) && s1_rsat0_im_0_to_s1_k1_cat_req) && s1_rsat1_re_0_to_s1_k1_cat_req) && s1_rsat1_im_0_to_s1_k1_cat_req) && s1_rsat2_re_0_to_s1_k1_cat_req) && s1_rsat2_im_0_to_s1_k1_cat_req) && s1_rsat3_re_0_to_s1_k1_cat_req);
  assign s1_bs0_re_0_nxt = s1_bs0_re_i_0_dat;
  assign s1_bs0_re_clk = clk;
  assign s1_bs0_re_reset_n = reset_n;
  assign s1_bs0_re_0_req = s1_r4_byp0_re_0_to_s1_bs0_re_req;
  assign s1_r4_byp0_re_0_to_s1_bs0_re_ack = s1_bs0_re_0_ack;
  assign cfg_s1_bs0_re_to_s1_bs0_re_ack = 1'b1;
  assign s1_bs0_im_0_nxt = s1_bs0_im_i_0_dat;
  assign s1_bs0_im_clk = clk;
  assign s1_bs0_im_reset_n = reset_n;
  assign s1_bs0_im_0_req = s1_r4_byp0_im_0_to_s1_bs0_im_req;
  assign s1_r4_byp0_im_0_to_s1_bs0_im_ack = s1_bs0_im_0_ack;
  assign cfg_s1_bs0_im_to_s1_bs0_im_ack = 1'b1;
  assign s1_rsat0_re_0_nxt = s1_rsat0_re_i_0_dat;
  assign s1_rsat0_re_clk = clk;
  assign s1_rsat0_re_reset_n = reset_n;
  assign s1_rsat0_re_0_req = s1_bs0_re_0_to_s1_rsat0_re_req;
  assign s1_bs0_re_0_to_s1_rsat0_re_ack = s1_rsat0_re_0_ack;
  assign s1_rsat0_im_0_nxt = s1_rsat0_im_i_0_dat;
  assign s1_rsat0_im_clk = clk;
  assign s1_rsat0_im_reset_n = reset_n;
  assign s1_rsat0_im_0_req = s1_bs0_im_0_to_s1_rsat0_im_req;
  assign s1_bs0_im_0_to_s1_rsat0_im_ack = s1_rsat0_im_0_ack;
  assign s1_bs1_re_0_nxt = s1_bs1_re_i_0_dat;
  assign s1_bs1_re_clk = clk;
  assign s1_bs1_re_reset_n = reset_n;
  assign s1_bs1_re_0_req = s1_r4_byp1_re_0_to_s1_bs1_re_req;
  assign s1_r4_byp1_re_0_to_s1_bs1_re_ack = s1_bs1_re_0_ack;
  assign cfg_s1_bs1_re_to_s1_bs1_re_ack = 1'b1;
  assign s1_bs1_im_0_nxt = s1_bs1_im_i_0_dat;
  assign s1_bs1_im_clk = clk;
  assign s1_bs1_im_reset_n = reset_n;
  assign s1_bs1_im_0_req = s1_r4_byp1_im_0_to_s1_bs1_im_req;
  assign s1_r4_byp1_im_0_to_s1_bs1_im_ack = s1_bs1_im_0_ack;
  assign cfg_s1_bs1_im_to_s1_bs1_im_ack = 1'b1;
  assign s1_rsat1_re_0_nxt = s1_rsat1_re_i_0_dat;
  assign s1_rsat1_re_clk = clk;
  assign s1_rsat1_re_reset_n = reset_n;
  assign s1_rsat1_re_0_req = s1_bs1_re_0_to_s1_rsat1_re_req;
  assign s1_bs1_re_0_to_s1_rsat1_re_ack = s1_rsat1_re_0_ack;
  assign s1_rsat1_im_0_nxt = s1_rsat1_im_i_0_dat;
  assign s1_rsat1_im_clk = clk;
  assign s1_rsat1_im_reset_n = reset_n;
  assign s1_rsat1_im_0_req = s1_bs1_im_0_to_s1_rsat1_im_req;
  assign s1_bs1_im_0_to_s1_rsat1_im_ack = s1_rsat1_im_0_ack;
  assign s1_bs2_re_0_nxt = s1_bs2_re_i_0_dat;
  assign s1_bs2_re_clk = clk;
  assign s1_bs2_re_reset_n = reset_n;
  assign s1_bs2_re_0_req = s1_r4_byp2_re_0_to_s1_bs2_re_req;
  assign s1_r4_byp2_re_0_to_s1_bs2_re_ack = s1_bs2_re_0_ack;
  assign cfg_s1_bs2_re_to_s1_bs2_re_ack = 1'b1;
  assign s1_bs2_im_0_nxt = s1_bs2_im_i_0_dat;
  assign s1_bs2_im_clk = clk;
  assign s1_bs2_im_reset_n = reset_n;
  assign s1_bs2_im_0_req = s1_r4_byp2_im_0_to_s1_bs2_im_req;
  assign s1_r4_byp2_im_0_to_s1_bs2_im_ack = s1_bs2_im_0_ack;
  assign cfg_s1_bs2_im_to_s1_bs2_im_ack = 1'b1;
  assign s1_rsat2_re_0_nxt = s1_rsat2_re_i_0_dat;
  assign s1_rsat2_re_clk = clk;
  assign s1_rsat2_re_reset_n = reset_n;
  assign s1_rsat2_re_0_req = s1_bs2_re_0_to_s1_rsat2_re_req;
  assign s1_bs2_re_0_to_s1_rsat2_re_ack = s1_rsat2_re_0_ack;
  assign s1_rsat2_im_0_nxt = s1_rsat2_im_i_0_dat;
  assign s1_rsat2_im_clk = clk;
  assign s1_rsat2_im_reset_n = reset_n;
  assign s1_rsat2_im_0_req = s1_bs2_im_0_to_s1_rsat2_im_req;
  assign s1_bs2_im_0_to_s1_rsat2_im_ack = s1_rsat2_im_0_ack;
  assign s1_bs3_re_0_nxt = s1_bs3_re_i_0_dat;
  assign s1_bs3_re_clk = clk;
  assign s1_bs3_re_reset_n = reset_n;
  assign s1_bs3_re_0_req = s1_r4_byp3_re_0_to_s1_bs3_re_req;
  assign s1_r4_byp3_re_0_to_s1_bs3_re_ack = s1_bs3_re_0_ack;
  assign cfg_s1_bs3_re_to_s1_bs3_re_ack = 1'b1;
  assign s1_bs3_im_0_nxt = s1_bs3_im_i_0_dat;
  assign s1_bs3_im_clk = clk;
  assign s1_bs3_im_reset_n = reset_n;
  assign s1_bs3_im_0_req = s1_r4_byp3_im_0_to_s1_bs3_im_req;
  assign s1_r4_byp3_im_0_to_s1_bs3_im_ack = s1_bs3_im_0_ack;
  assign cfg_s1_bs3_im_to_s1_bs3_im_ack = 1'b1;
  assign s1_rsat3_re_0_nxt = s1_rsat3_re_i_0_dat;
  assign s1_rsat3_re_clk = clk;
  assign s1_rsat3_re_reset_n = reset_n;
  assign s1_rsat3_re_0_req = s1_bs3_re_0_to_s1_rsat3_re_req;
  assign s1_bs3_re_0_to_s1_rsat3_re_ack = s1_rsat3_re_0_ack;
  assign s1_rsat3_im_0_nxt = s1_rsat3_im_i_0_dat;
  assign s1_rsat3_im_clk = clk;
  assign s1_rsat3_im_reset_n = reset_n;
  assign s1_rsat3_im_0_req = s1_bs3_im_0_to_s1_rsat3_im_req;
  assign s1_bs3_im_0_to_s1_rsat3_im_ack = s1_rsat3_im_0_ack;
  assign i_k1_dat = k1_defunnel_0;
  assign i_k1_req = k1_defunnel_0_to_i_k1_req;
  assign k1_defunnel_0_to_i_k1_ack = i_k1_ack;
  assign t_k8_0_m_req = t_k8_0_req;
  assign t_k8_0_ack = t_k8_0_m_ack;
  assign t_k8_0_to_k8_funnel_req = t_k8_0_m_req;
  assign t_k8_0_m_ack = t_k8_0_to_k8_funnel_ack;
  assign t_k9_0_m_req = t_k9_0_req;
  assign t_k9_0_ack = t_k9_0_m_ack;
  assign t_k9_0_to_k9_funnel_req = t_k9_0_m_req;
  assign t_k9_0_m_ack = t_k9_0_to_k9_funnel_ack;
  assign t_k14_0_m_req = t_k14_0_req;
  assign t_k14_0_ack = t_k14_0_m_ack;
  assign t_k14_0_to_cfg_req = t_k14_0_m_req;
  assign t_k14_0_m_ack = t_k14_0_to_cfg_ack;
  always @(*) begin
    k1_defunnel_0_eb_state_nxt = k1_defunnel_0_eb_state;
    case(k1_defunnel_0_eb_state)
      5'h14 : begin
        if(k1_defunnel_0_req) begin
          k1_defunnel_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! k1_defunnel_0_req) && k1_defunnel_0_m_ack)) begin
          k1_defunnel_0_eb_state_nxt = 5'h14;
        end
        if((k1_defunnel_0_req && (! k1_defunnel_0_m_ack))) begin
          k1_defunnel_0_eb_state_nxt = 5'h08;
        end
        if((k1_defunnel_0_req && k1_defunnel_0_m_ack)) begin
          k1_defunnel_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(k1_defunnel_0_m_ack) begin
          k1_defunnel_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! k1_defunnel_0_req) && k1_defunnel_0_m_ack)) begin
          k1_defunnel_0_eb_state_nxt = 5'h14;
        end
        if((k1_defunnel_0_req && (! k1_defunnel_0_m_ack))) begin
          k1_defunnel_0_eb_state_nxt = 5'h09;
        end
        if((k1_defunnel_0_req && k1_defunnel_0_m_ack)) begin
          k1_defunnel_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(k1_defunnel_0_m_ack) begin
          k1_defunnel_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign k1_defunnel_0_eb_en0 = (k1_defunnel_0_eb_state[2] && k1_defunnel_0_req);
  assign k1_defunnel_0_eb_en1 = (k1_defunnel_0_eb_state[1] && k1_defunnel_0_req);
  assign k1_defunnel_0_eb_sel = k1_defunnel_0_eb_state[0];
  assign k1_defunnel_0_ack = k1_defunnel_0_eb_state[4];
  assign k1_defunnel_0_m_req = k1_defunnel_0_eb_state[3];
  assign k1_defunnel_0 = (k1_defunnel_0_eb_sel ? k1_defunnel_0_eb_r1 : k1_defunnel_0_eb_r0);
  assign k1_defunnel_0_to_i_k1_req = k1_defunnel_0_m_req;
  assign k1_defunnel_0_m_ack = k1_defunnel_0_to_i_k1_ack;
  assign k8_funnel_0_ack = ((! k8_funnel_0_eb_valid) || k8_funnel_0_m_ack);
  assign k8_funnel_0_eb_en = (k8_funnel_0_req && k8_funnel_0_ack);
  assign k8_funnel_0_m_req = k8_funnel_0_eb_valid;
  assign k8_funnel_0 = k8_funnel_0_eb_r;
  assign k8_funnel_0_to_s0_k8_slice_req = k8_funnel_0_m_req;
  assign k8_funnel_0_m_ack = k8_funnel_0_to_s0_k8_slice_ack;
  assign k9_funnel_0_ack = ((! k9_funnel_0_eb_valid) || k9_funnel_0_m_ack);
  assign k9_funnel_0_eb_en = (k9_funnel_0_req && k9_funnel_0_ack);
  assign k9_funnel_0_m_req = k9_funnel_0_eb_valid;
  assign k9_funnel_0 = k9_funnel_0_eb_r;
  assign k9_funnel_0_to_s0_k9_slice_req = k9_funnel_0_m_req;
  assign k9_funnel_0_m_ack = k9_funnel_0_to_s0_k9_slice_ack;
  assign s0_k8_slice_0_m_req = s0_k8_slice_0_req;
  assign s0_k8_slice_0_ack = s0_k8_slice_0_m_ack;
  assign s0_k8_slice_0_to_s0_cmul0_m2c_ac_req = (s0_k8_slice_0_m_req && (! s0_k8_slice_0_fork_ack_r_0));
  assign s0_k8_slice_0_fork_ack_s_0 = (s0_k8_slice_0_to_s0_cmul0_m2c_ac_ack || (! s0_k8_slice_0_to_s0_cmul0_m2c_ac_req));
  assign s0_k8_slice_0_to_s0_cmul0_m2c_da_req = (s0_k8_slice_0_m_req && (! s0_k8_slice_0_fork_ack_r_1));
  assign s0_k8_slice_0_fork_ack_s_1 = (s0_k8_slice_0_to_s0_cmul0_m2c_da_ack || (! s0_k8_slice_0_to_s0_cmul0_m2c_da_req));
  assign s0_k8_slice_0_to_s0_cmul0_cat_re_req = (s0_k8_slice_0_m_req && (! s0_k8_slice_0_fork_ack_r_2));
  assign s0_k8_slice_0_fork_ack_s_2 = (s0_k8_slice_0_to_s0_cmul0_cat_re_ack || (! s0_k8_slice_0_to_s0_cmul0_cat_re_req));
  assign s0_k8_slice_0_m_ack = ((s0_k8_slice_0_fork_ack_s_0 && s0_k8_slice_0_fork_ack_s_1) && s0_k8_slice_0_fork_ack_s_2);
  assign s0_k8_slice_1_m_req = s0_k8_slice_1_req;
  assign s0_k8_slice_1_ack = s0_k8_slice_1_m_ack;
  assign s0_k8_slice_1_to_s0_cmul0_m2c_bc_req = (s0_k8_slice_1_m_req && (! s0_k8_slice_1_fork_ack_r_0));
  assign s0_k8_slice_1_fork_ack_s_0 = (s0_k8_slice_1_to_s0_cmul0_m2c_bc_ack || (! s0_k8_slice_1_to_s0_cmul0_m2c_bc_req));
  assign s0_k8_slice_1_to_s0_cmul0_m2c_bd_req = (s0_k8_slice_1_m_req && (! s0_k8_slice_1_fork_ack_r_1));
  assign s0_k8_slice_1_fork_ack_s_1 = (s0_k8_slice_1_to_s0_cmul0_m2c_bd_ack || (! s0_k8_slice_1_to_s0_cmul0_m2c_bd_req));
  assign s0_k8_slice_1_to_s0_cmul0_m2c_cb_req = (s0_k8_slice_1_m_req && (! s0_k8_slice_1_fork_ack_r_2));
  assign s0_k8_slice_1_fork_ack_s_2 = (s0_k8_slice_1_to_s0_cmul0_m2c_cb_ack || (! s0_k8_slice_1_to_s0_cmul0_m2c_cb_req));
  assign s0_k8_slice_1_m_ack = ((s0_k8_slice_1_fork_ack_s_0 && s0_k8_slice_1_fork_ack_s_1) && s0_k8_slice_1_fork_ack_s_2);
  assign s0_k9_slice_0_m_req = s0_k9_slice_0_req;
  assign s0_k9_slice_0_ack = s0_k9_slice_0_m_ack;
  assign s0_k9_slice_0_to_s0_cmul0_m2c_ac_req = (s0_k9_slice_0_m_req && (! s0_k9_slice_0_fork_ack_r_0));
  assign s0_k9_slice_0_fork_ack_s_0 = (s0_k9_slice_0_to_s0_cmul0_m2c_ac_ack || (! s0_k9_slice_0_to_s0_cmul0_m2c_ac_req));
  assign s0_k9_slice_0_to_s0_cmul0_m2c_bc_req = (s0_k9_slice_0_m_req && (! s0_k9_slice_0_fork_ack_r_1));
  assign s0_k9_slice_0_fork_ack_s_1 = (s0_k9_slice_0_to_s0_cmul0_m2c_bc_ack || (! s0_k9_slice_0_to_s0_cmul0_m2c_bc_req));
  assign s0_k9_slice_0_to_s0_cmul0_m2c_cb_req = (s0_k9_slice_0_m_req && (! s0_k9_slice_0_fork_ack_r_2));
  assign s0_k9_slice_0_fork_ack_s_2 = (s0_k9_slice_0_to_s0_cmul0_m2c_cb_ack || (! s0_k9_slice_0_to_s0_cmul0_m2c_cb_req));
  assign s0_k9_slice_0_to_s0_cmul0_m2c_cd_req = (s0_k9_slice_0_m_req && (! s0_k9_slice_0_fork_ack_r_3));
  assign s0_k9_slice_0_fork_ack_s_3 = (s0_k9_slice_0_to_s0_cmul0_m2c_cd_ack || (! s0_k9_slice_0_to_s0_cmul0_m2c_cd_req));
  assign s0_k9_slice_0_to_s0_cmul0_recip_norm_req = (s0_k9_slice_0_m_req && (! s0_k9_slice_0_fork_ack_r_4));
  assign s0_k9_slice_0_fork_ack_s_4 = (s0_k9_slice_0_to_s0_cmul0_recip_norm_ack || (! s0_k9_slice_0_to_s0_cmul0_recip_norm_req));
  assign s0_k9_slice_0_m_ack = ((((s0_k9_slice_0_fork_ack_s_0 && s0_k9_slice_0_fork_ack_s_1) && s0_k9_slice_0_fork_ack_s_2) && s0_k9_slice_0_fork_ack_s_3) && s0_k9_slice_0_fork_ack_s_4);
  assign s0_k9_slice_1_m_req = s0_k9_slice_1_req;
  assign s0_k9_slice_1_ack = s0_k9_slice_1_m_ack;
  assign s0_k9_slice_1_to_s0_cmul0_m2c_bd_req = (s0_k9_slice_1_m_req && (! s0_k9_slice_1_fork_ack_r_0));
  assign s0_k9_slice_1_fork_ack_s_0 = (s0_k9_slice_1_to_s0_cmul0_m2c_bd_ack || (! s0_k9_slice_1_to_s0_cmul0_m2c_bd_req));
  assign s0_k9_slice_1_to_s0_cmul0_m2c_cd_req = (s0_k9_slice_1_m_req && (! s0_k9_slice_1_fork_ack_r_1));
  assign s0_k9_slice_1_fork_ack_s_1 = (s0_k9_slice_1_to_s0_cmul0_m2c_cd_ack || (! s0_k9_slice_1_to_s0_cmul0_m2c_cd_req));
  assign s0_k9_slice_1_to_s0_cmul0_m2c_da_req = (s0_k9_slice_1_m_req && (! s0_k9_slice_1_fork_ack_r_2));
  assign s0_k9_slice_1_fork_ack_s_2 = (s0_k9_slice_1_to_s0_cmul0_m2c_da_ack || (! s0_k9_slice_1_to_s0_cmul0_m2c_da_req));
  assign s0_k9_slice_1_to_s0_cmul0_cat_im_req = (s0_k9_slice_1_m_req && (! s0_k9_slice_1_fork_ack_r_3));
  assign s0_k9_slice_1_fork_ack_s_3 = (s0_k9_slice_1_to_s0_cmul0_cat_im_ack || (! s0_k9_slice_1_to_s0_cmul0_cat_im_req));
  assign s0_k9_slice_1_m_ack = (((s0_k9_slice_1_fork_ack_s_0 && s0_k9_slice_1_fork_ack_s_1) && s0_k9_slice_1_fork_ack_s_2) && s0_k9_slice_1_fork_ack_s_3);
  assign s0_k8_slice_2_m_req = s0_k8_slice_2_req;
  assign s0_k8_slice_2_ack = s0_k8_slice_2_m_ack;
  assign s0_k8_slice_2_to_s0_cmul1_m2c_ac_req = (s0_k8_slice_2_m_req && (! s0_k8_slice_2_fork_ack_r_0));
  assign s0_k8_slice_2_fork_ack_s_0 = (s0_k8_slice_2_to_s0_cmul1_m2c_ac_ack || (! s0_k8_slice_2_to_s0_cmul1_m2c_ac_req));
  assign s0_k8_slice_2_to_s0_cmul1_m2c_da_req = (s0_k8_slice_2_m_req && (! s0_k8_slice_2_fork_ack_r_1));
  assign s0_k8_slice_2_fork_ack_s_1 = (s0_k8_slice_2_to_s0_cmul1_m2c_da_ack || (! s0_k8_slice_2_to_s0_cmul1_m2c_da_req));
  assign s0_k8_slice_2_to_s0_cmul1_cat_re_req = (s0_k8_slice_2_m_req && (! s0_k8_slice_2_fork_ack_r_2));
  assign s0_k8_slice_2_fork_ack_s_2 = (s0_k8_slice_2_to_s0_cmul1_cat_re_ack || (! s0_k8_slice_2_to_s0_cmul1_cat_re_req));
  assign s0_k8_slice_2_m_ack = ((s0_k8_slice_2_fork_ack_s_0 && s0_k8_slice_2_fork_ack_s_1) && s0_k8_slice_2_fork_ack_s_2);
  assign s0_k8_slice_3_m_req = s0_k8_slice_3_req;
  assign s0_k8_slice_3_ack = s0_k8_slice_3_m_ack;
  assign s0_k8_slice_3_to_s0_cmul1_m2c_bc_req = (s0_k8_slice_3_m_req && (! s0_k8_slice_3_fork_ack_r_0));
  assign s0_k8_slice_3_fork_ack_s_0 = (s0_k8_slice_3_to_s0_cmul1_m2c_bc_ack || (! s0_k8_slice_3_to_s0_cmul1_m2c_bc_req));
  assign s0_k8_slice_3_to_s0_cmul1_m2c_bd_req = (s0_k8_slice_3_m_req && (! s0_k8_slice_3_fork_ack_r_1));
  assign s0_k8_slice_3_fork_ack_s_1 = (s0_k8_slice_3_to_s0_cmul1_m2c_bd_ack || (! s0_k8_slice_3_to_s0_cmul1_m2c_bd_req));
  assign s0_k8_slice_3_to_s0_cmul1_m2c_cb_req = (s0_k8_slice_3_m_req && (! s0_k8_slice_3_fork_ack_r_2));
  assign s0_k8_slice_3_fork_ack_s_2 = (s0_k8_slice_3_to_s0_cmul1_m2c_cb_ack || (! s0_k8_slice_3_to_s0_cmul1_m2c_cb_req));
  assign s0_k8_slice_3_m_ack = ((s0_k8_slice_3_fork_ack_s_0 && s0_k8_slice_3_fork_ack_s_1) && s0_k8_slice_3_fork_ack_s_2);
  assign s0_k9_slice_2_m_req = s0_k9_slice_2_req;
  assign s0_k9_slice_2_ack = s0_k9_slice_2_m_ack;
  assign s0_k9_slice_2_to_s0_cmul1_m2c_ac_req = (s0_k9_slice_2_m_req && (! s0_k9_slice_2_fork_ack_r_0));
  assign s0_k9_slice_2_fork_ack_s_0 = (s0_k9_slice_2_to_s0_cmul1_m2c_ac_ack || (! s0_k9_slice_2_to_s0_cmul1_m2c_ac_req));
  assign s0_k9_slice_2_to_s0_cmul1_m2c_bc_req = (s0_k9_slice_2_m_req && (! s0_k9_slice_2_fork_ack_r_1));
  assign s0_k9_slice_2_fork_ack_s_1 = (s0_k9_slice_2_to_s0_cmul1_m2c_bc_ack || (! s0_k9_slice_2_to_s0_cmul1_m2c_bc_req));
  assign s0_k9_slice_2_to_s0_cmul1_m2c_cb_req = (s0_k9_slice_2_m_req && (! s0_k9_slice_2_fork_ack_r_2));
  assign s0_k9_slice_2_fork_ack_s_2 = (s0_k9_slice_2_to_s0_cmul1_m2c_cb_ack || (! s0_k9_slice_2_to_s0_cmul1_m2c_cb_req));
  assign s0_k9_slice_2_to_s0_cmul1_m2c_cd_req = (s0_k9_slice_2_m_req && (! s0_k9_slice_2_fork_ack_r_3));
  assign s0_k9_slice_2_fork_ack_s_3 = (s0_k9_slice_2_to_s0_cmul1_m2c_cd_ack || (! s0_k9_slice_2_to_s0_cmul1_m2c_cd_req));
  assign s0_k9_slice_2_to_s0_cmul1_recip_norm_req = (s0_k9_slice_2_m_req && (! s0_k9_slice_2_fork_ack_r_4));
  assign s0_k9_slice_2_fork_ack_s_4 = (s0_k9_slice_2_to_s0_cmul1_recip_norm_ack || (! s0_k9_slice_2_to_s0_cmul1_recip_norm_req));
  assign s0_k9_slice_2_m_ack = ((((s0_k9_slice_2_fork_ack_s_0 && s0_k9_slice_2_fork_ack_s_1) && s0_k9_slice_2_fork_ack_s_2) && s0_k9_slice_2_fork_ack_s_3) && s0_k9_slice_2_fork_ack_s_4);
  assign s0_k9_slice_3_m_req = s0_k9_slice_3_req;
  assign s0_k9_slice_3_ack = s0_k9_slice_3_m_ack;
  assign s0_k9_slice_3_to_s0_cmul1_m2c_bd_req = (s0_k9_slice_3_m_req && (! s0_k9_slice_3_fork_ack_r_0));
  assign s0_k9_slice_3_fork_ack_s_0 = (s0_k9_slice_3_to_s0_cmul1_m2c_bd_ack || (! s0_k9_slice_3_to_s0_cmul1_m2c_bd_req));
  assign s0_k9_slice_3_to_s0_cmul1_m2c_cd_req = (s0_k9_slice_3_m_req && (! s0_k9_slice_3_fork_ack_r_1));
  assign s0_k9_slice_3_fork_ack_s_1 = (s0_k9_slice_3_to_s0_cmul1_m2c_cd_ack || (! s0_k9_slice_3_to_s0_cmul1_m2c_cd_req));
  assign s0_k9_slice_3_to_s0_cmul1_m2c_da_req = (s0_k9_slice_3_m_req && (! s0_k9_slice_3_fork_ack_r_2));
  assign s0_k9_slice_3_fork_ack_s_2 = (s0_k9_slice_3_to_s0_cmul1_m2c_da_ack || (! s0_k9_slice_3_to_s0_cmul1_m2c_da_req));
  assign s0_k9_slice_3_to_s0_cmul1_cat_im_req = (s0_k9_slice_3_m_req && (! s0_k9_slice_3_fork_ack_r_3));
  assign s0_k9_slice_3_fork_ack_s_3 = (s0_k9_slice_3_to_s0_cmul1_cat_im_ack || (! s0_k9_slice_3_to_s0_cmul1_cat_im_req));
  assign s0_k9_slice_3_m_ack = (((s0_k9_slice_3_fork_ack_s_0 && s0_k9_slice_3_fork_ack_s_1) && s0_k9_slice_3_fork_ack_s_2) && s0_k9_slice_3_fork_ack_s_3);
  assign s0_k8_slice_4_m_req = s0_k8_slice_4_req;
  assign s0_k8_slice_4_ack = s0_k8_slice_4_m_ack;
  assign s0_k8_slice_4_to_s0_cmul2_m2c_ac_req = (s0_k8_slice_4_m_req && (! s0_k8_slice_4_fork_ack_r_0));
  assign s0_k8_slice_4_fork_ack_s_0 = (s0_k8_slice_4_to_s0_cmul2_m2c_ac_ack || (! s0_k8_slice_4_to_s0_cmul2_m2c_ac_req));
  assign s0_k8_slice_4_to_s0_cmul2_m2c_da_req = (s0_k8_slice_4_m_req && (! s0_k8_slice_4_fork_ack_r_1));
  assign s0_k8_slice_4_fork_ack_s_1 = (s0_k8_slice_4_to_s0_cmul2_m2c_da_ack || (! s0_k8_slice_4_to_s0_cmul2_m2c_da_req));
  assign s0_k8_slice_4_to_s0_cmul2_cat_re_req = (s0_k8_slice_4_m_req && (! s0_k8_slice_4_fork_ack_r_2));
  assign s0_k8_slice_4_fork_ack_s_2 = (s0_k8_slice_4_to_s0_cmul2_cat_re_ack || (! s0_k8_slice_4_to_s0_cmul2_cat_re_req));
  assign s0_k8_slice_4_m_ack = ((s0_k8_slice_4_fork_ack_s_0 && s0_k8_slice_4_fork_ack_s_1) && s0_k8_slice_4_fork_ack_s_2);
  assign s0_k8_slice_5_m_req = s0_k8_slice_5_req;
  assign s0_k8_slice_5_ack = s0_k8_slice_5_m_ack;
  assign s0_k8_slice_5_to_s0_cmul2_m2c_bc_req = (s0_k8_slice_5_m_req && (! s0_k8_slice_5_fork_ack_r_0));
  assign s0_k8_slice_5_fork_ack_s_0 = (s0_k8_slice_5_to_s0_cmul2_m2c_bc_ack || (! s0_k8_slice_5_to_s0_cmul2_m2c_bc_req));
  assign s0_k8_slice_5_to_s0_cmul2_m2c_bd_req = (s0_k8_slice_5_m_req && (! s0_k8_slice_5_fork_ack_r_1));
  assign s0_k8_slice_5_fork_ack_s_1 = (s0_k8_slice_5_to_s0_cmul2_m2c_bd_ack || (! s0_k8_slice_5_to_s0_cmul2_m2c_bd_req));
  assign s0_k8_slice_5_to_s0_cmul2_m2c_cb_req = (s0_k8_slice_5_m_req && (! s0_k8_slice_5_fork_ack_r_2));
  assign s0_k8_slice_5_fork_ack_s_2 = (s0_k8_slice_5_to_s0_cmul2_m2c_cb_ack || (! s0_k8_slice_5_to_s0_cmul2_m2c_cb_req));
  assign s0_k8_slice_5_m_ack = ((s0_k8_slice_5_fork_ack_s_0 && s0_k8_slice_5_fork_ack_s_1) && s0_k8_slice_5_fork_ack_s_2);
  assign s0_k9_slice_4_m_req = s0_k9_slice_4_req;
  assign s0_k9_slice_4_ack = s0_k9_slice_4_m_ack;
  assign s0_k9_slice_4_to_s0_cmul2_m2c_ac_req = (s0_k9_slice_4_m_req && (! s0_k9_slice_4_fork_ack_r_0));
  assign s0_k9_slice_4_fork_ack_s_0 = (s0_k9_slice_4_to_s0_cmul2_m2c_ac_ack || (! s0_k9_slice_4_to_s0_cmul2_m2c_ac_req));
  assign s0_k9_slice_4_to_s0_cmul2_m2c_bc_req = (s0_k9_slice_4_m_req && (! s0_k9_slice_4_fork_ack_r_1));
  assign s0_k9_slice_4_fork_ack_s_1 = (s0_k9_slice_4_to_s0_cmul2_m2c_bc_ack || (! s0_k9_slice_4_to_s0_cmul2_m2c_bc_req));
  assign s0_k9_slice_4_to_s0_cmul2_m2c_cb_req = (s0_k9_slice_4_m_req && (! s0_k9_slice_4_fork_ack_r_2));
  assign s0_k9_slice_4_fork_ack_s_2 = (s0_k9_slice_4_to_s0_cmul2_m2c_cb_ack || (! s0_k9_slice_4_to_s0_cmul2_m2c_cb_req));
  assign s0_k9_slice_4_to_s0_cmul2_m2c_cd_req = (s0_k9_slice_4_m_req && (! s0_k9_slice_4_fork_ack_r_3));
  assign s0_k9_slice_4_fork_ack_s_3 = (s0_k9_slice_4_to_s0_cmul2_m2c_cd_ack || (! s0_k9_slice_4_to_s0_cmul2_m2c_cd_req));
  assign s0_k9_slice_4_to_s0_cmul2_recip_norm_req = (s0_k9_slice_4_m_req && (! s0_k9_slice_4_fork_ack_r_4));
  assign s0_k9_slice_4_fork_ack_s_4 = (s0_k9_slice_4_to_s0_cmul2_recip_norm_ack || (! s0_k9_slice_4_to_s0_cmul2_recip_norm_req));
  assign s0_k9_slice_4_m_ack = ((((s0_k9_slice_4_fork_ack_s_0 && s0_k9_slice_4_fork_ack_s_1) && s0_k9_slice_4_fork_ack_s_2) && s0_k9_slice_4_fork_ack_s_3) && s0_k9_slice_4_fork_ack_s_4);
  assign s0_k9_slice_5_m_req = s0_k9_slice_5_req;
  assign s0_k9_slice_5_ack = s0_k9_slice_5_m_ack;
  assign s0_k9_slice_5_to_s0_cmul2_m2c_bd_req = (s0_k9_slice_5_m_req && (! s0_k9_slice_5_fork_ack_r_0));
  assign s0_k9_slice_5_fork_ack_s_0 = (s0_k9_slice_5_to_s0_cmul2_m2c_bd_ack || (! s0_k9_slice_5_to_s0_cmul2_m2c_bd_req));
  assign s0_k9_slice_5_to_s0_cmul2_m2c_cd_req = (s0_k9_slice_5_m_req && (! s0_k9_slice_5_fork_ack_r_1));
  assign s0_k9_slice_5_fork_ack_s_1 = (s0_k9_slice_5_to_s0_cmul2_m2c_cd_ack || (! s0_k9_slice_5_to_s0_cmul2_m2c_cd_req));
  assign s0_k9_slice_5_to_s0_cmul2_m2c_da_req = (s0_k9_slice_5_m_req && (! s0_k9_slice_5_fork_ack_r_2));
  assign s0_k9_slice_5_fork_ack_s_2 = (s0_k9_slice_5_to_s0_cmul2_m2c_da_ack || (! s0_k9_slice_5_to_s0_cmul2_m2c_da_req));
  assign s0_k9_slice_5_to_s0_cmul2_cat_im_req = (s0_k9_slice_5_m_req && (! s0_k9_slice_5_fork_ack_r_3));
  assign s0_k9_slice_5_fork_ack_s_3 = (s0_k9_slice_5_to_s0_cmul2_cat_im_ack || (! s0_k9_slice_5_to_s0_cmul2_cat_im_req));
  assign s0_k9_slice_5_m_ack = (((s0_k9_slice_5_fork_ack_s_0 && s0_k9_slice_5_fork_ack_s_1) && s0_k9_slice_5_fork_ack_s_2) && s0_k9_slice_5_fork_ack_s_3);
  assign s0_k8_slice_6_m_req = s0_k8_slice_6_req;
  assign s0_k8_slice_6_ack = s0_k8_slice_6_m_ack;
  assign s0_k8_slice_6_to_s0_cmul3_m2c_ac_req = (s0_k8_slice_6_m_req && (! s0_k8_slice_6_fork_ack_r_0));
  assign s0_k8_slice_6_fork_ack_s_0 = (s0_k8_slice_6_to_s0_cmul3_m2c_ac_ack || (! s0_k8_slice_6_to_s0_cmul3_m2c_ac_req));
  assign s0_k8_slice_6_to_s0_cmul3_m2c_da_req = (s0_k8_slice_6_m_req && (! s0_k8_slice_6_fork_ack_r_1));
  assign s0_k8_slice_6_fork_ack_s_1 = (s0_k8_slice_6_to_s0_cmul3_m2c_da_ack || (! s0_k8_slice_6_to_s0_cmul3_m2c_da_req));
  assign s0_k8_slice_6_to_s0_cmul3_cat_re_req = (s0_k8_slice_6_m_req && (! s0_k8_slice_6_fork_ack_r_2));
  assign s0_k8_slice_6_fork_ack_s_2 = (s0_k8_slice_6_to_s0_cmul3_cat_re_ack || (! s0_k8_slice_6_to_s0_cmul3_cat_re_req));
  assign s0_k8_slice_6_m_ack = ((s0_k8_slice_6_fork_ack_s_0 && s0_k8_slice_6_fork_ack_s_1) && s0_k8_slice_6_fork_ack_s_2);
  assign s0_k8_slice_7_m_req = s0_k8_slice_7_req;
  assign s0_k8_slice_7_ack = s0_k8_slice_7_m_ack;
  assign s0_k8_slice_7_to_s0_cmul3_m2c_bc_req = (s0_k8_slice_7_m_req && (! s0_k8_slice_7_fork_ack_r_0));
  assign s0_k8_slice_7_fork_ack_s_0 = (s0_k8_slice_7_to_s0_cmul3_m2c_bc_ack || (! s0_k8_slice_7_to_s0_cmul3_m2c_bc_req));
  assign s0_k8_slice_7_to_s0_cmul3_m2c_bd_req = (s0_k8_slice_7_m_req && (! s0_k8_slice_7_fork_ack_r_1));
  assign s0_k8_slice_7_fork_ack_s_1 = (s0_k8_slice_7_to_s0_cmul3_m2c_bd_ack || (! s0_k8_slice_7_to_s0_cmul3_m2c_bd_req));
  assign s0_k8_slice_7_to_s0_cmul3_m2c_cb_req = (s0_k8_slice_7_m_req && (! s0_k8_slice_7_fork_ack_r_2));
  assign s0_k8_slice_7_fork_ack_s_2 = (s0_k8_slice_7_to_s0_cmul3_m2c_cb_ack || (! s0_k8_slice_7_to_s0_cmul3_m2c_cb_req));
  assign s0_k8_slice_7_m_ack = ((s0_k8_slice_7_fork_ack_s_0 && s0_k8_slice_7_fork_ack_s_1) && s0_k8_slice_7_fork_ack_s_2);
  assign s0_k9_slice_6_m_req = s0_k9_slice_6_req;
  assign s0_k9_slice_6_ack = s0_k9_slice_6_m_ack;
  assign s0_k9_slice_6_to_s0_cmul3_m2c_ac_req = (s0_k9_slice_6_m_req && (! s0_k9_slice_6_fork_ack_r_0));
  assign s0_k9_slice_6_fork_ack_s_0 = (s0_k9_slice_6_to_s0_cmul3_m2c_ac_ack || (! s0_k9_slice_6_to_s0_cmul3_m2c_ac_req));
  assign s0_k9_slice_6_to_s0_cmul3_m2c_bc_req = (s0_k9_slice_6_m_req && (! s0_k9_slice_6_fork_ack_r_1));
  assign s0_k9_slice_6_fork_ack_s_1 = (s0_k9_slice_6_to_s0_cmul3_m2c_bc_ack || (! s0_k9_slice_6_to_s0_cmul3_m2c_bc_req));
  assign s0_k9_slice_6_to_s0_cmul3_m2c_cb_req = (s0_k9_slice_6_m_req && (! s0_k9_slice_6_fork_ack_r_2));
  assign s0_k9_slice_6_fork_ack_s_2 = (s0_k9_slice_6_to_s0_cmul3_m2c_cb_ack || (! s0_k9_slice_6_to_s0_cmul3_m2c_cb_req));
  assign s0_k9_slice_6_to_s0_cmul3_m2c_cd_req = (s0_k9_slice_6_m_req && (! s0_k9_slice_6_fork_ack_r_3));
  assign s0_k9_slice_6_fork_ack_s_3 = (s0_k9_slice_6_to_s0_cmul3_m2c_cd_ack || (! s0_k9_slice_6_to_s0_cmul3_m2c_cd_req));
  assign s0_k9_slice_6_to_s0_cmul3_recip_norm_req = (s0_k9_slice_6_m_req && (! s0_k9_slice_6_fork_ack_r_4));
  assign s0_k9_slice_6_fork_ack_s_4 = (s0_k9_slice_6_to_s0_cmul3_recip_norm_ack || (! s0_k9_slice_6_to_s0_cmul3_recip_norm_req));
  assign s0_k9_slice_6_m_ack = ((((s0_k9_slice_6_fork_ack_s_0 && s0_k9_slice_6_fork_ack_s_1) && s0_k9_slice_6_fork_ack_s_2) && s0_k9_slice_6_fork_ack_s_3) && s0_k9_slice_6_fork_ack_s_4);
  assign s0_k9_slice_7_m_req = s0_k9_slice_7_req;
  assign s0_k9_slice_7_ack = s0_k9_slice_7_m_ack;
  assign s0_k9_slice_7_to_s0_cmul3_m2c_bd_req = (s0_k9_slice_7_m_req && (! s0_k9_slice_7_fork_ack_r_0));
  assign s0_k9_slice_7_fork_ack_s_0 = (s0_k9_slice_7_to_s0_cmul3_m2c_bd_ack || (! s0_k9_slice_7_to_s0_cmul3_m2c_bd_req));
  assign s0_k9_slice_7_to_s0_cmul3_m2c_cd_req = (s0_k9_slice_7_m_req && (! s0_k9_slice_7_fork_ack_r_1));
  assign s0_k9_slice_7_fork_ack_s_1 = (s0_k9_slice_7_to_s0_cmul3_m2c_cd_ack || (! s0_k9_slice_7_to_s0_cmul3_m2c_cd_req));
  assign s0_k9_slice_7_to_s0_cmul3_m2c_da_req = (s0_k9_slice_7_m_req && (! s0_k9_slice_7_fork_ack_r_2));
  assign s0_k9_slice_7_fork_ack_s_2 = (s0_k9_slice_7_to_s0_cmul3_m2c_da_ack || (! s0_k9_slice_7_to_s0_cmul3_m2c_da_req));
  assign s0_k9_slice_7_to_s0_cmul3_cat_im_req = (s0_k9_slice_7_m_req && (! s0_k9_slice_7_fork_ack_r_3));
  assign s0_k9_slice_7_fork_ack_s_3 = (s0_k9_slice_7_to_s0_cmul3_cat_im_ack || (! s0_k9_slice_7_to_s0_cmul3_cat_im_req));
  assign s0_k9_slice_7_m_ack = (((s0_k9_slice_7_fork_ack_s_0 && s0_k9_slice_7_fork_ack_s_1) && s0_k9_slice_7_fork_ack_s_2) && s0_k9_slice_7_fork_ack_s_3);
  assign s0_cmul0_recip_norm_0_ack = ((! s0_cmul0_recip_norm_0_eb_valid) || s0_cmul0_recip_norm_0_m_ack);
  assign s0_cmul0_recip_norm_0_eb_en = (s0_cmul0_recip_norm_0_req && s0_cmul0_recip_norm_0_ack);
  assign s0_cmul0_recip_norm_0_m_req = s0_cmul0_recip_norm_0_eb_valid;
  assign s0_cmul0_recip_norm_0 = s0_cmul0_recip_norm_0_eb_r;
  assign s0_cmul0_recip_norm_0_to_s0_cmul0_recip_mul_req = s0_cmul0_recip_norm_0_m_req;
  assign s0_cmul0_recip_norm_0_m_ack = s0_cmul0_recip_norm_0_to_s0_cmul0_recip_mul_ack;
  assign s0_cmul0_recip_mul_0_ack = ((! s0_cmul0_recip_mul_0_eb_valid) || s0_cmul0_recip_mul_0_m_ack);
  assign s0_cmul0_recip_mul_0_eb_en = (s0_cmul0_recip_mul_0_req && s0_cmul0_recip_mul_0_ack);
  assign s0_cmul0_recip_mul_0_m_req = s0_cmul0_recip_mul_0_eb_valid;
  assign s0_cmul0_recip_mul_0 = s0_cmul0_recip_mul_0_eb_r;
  assign s0_cmul0_recip_mul_0_to_s0_cmul0_recip_out_req = s0_cmul0_recip_mul_0_m_req;
  assign s0_cmul0_recip_mul_0_m_ack = s0_cmul0_recip_mul_0_to_s0_cmul0_recip_out_ack;
  assign s0_cmul0_recip_out_0_ack = ((! s0_cmul0_recip_out_0_eb_valid) || s0_cmul0_recip_out_0_m_ack);
  assign s0_cmul0_recip_out_0_eb_en = (s0_cmul0_recip_out_0_req && s0_cmul0_recip_out_0_ack);
  assign s0_cmul0_recip_out_0_m_req = s0_cmul0_recip_out_0_eb_valid;
  assign s0_cmul0_recip_out_0 = s0_cmul0_recip_out_0_eb_r;
  assign s0_cmul0_recip_out_0_to_s0_cmul0_m2c_ac_req = (s0_cmul0_recip_out_0_m_req && (! s0_cmul0_recip_out_0_fork_ack_r_0));
  assign s0_cmul0_recip_out_0_fork_ack_s_0 = (s0_cmul0_recip_out_0_to_s0_cmul0_m2c_ac_ack || (! s0_cmul0_recip_out_0_to_s0_cmul0_m2c_ac_req));
  assign s0_cmul0_recip_out_0_to_s0_cmul0_m2c_cd_req = (s0_cmul0_recip_out_0_m_req && (! s0_cmul0_recip_out_0_fork_ack_r_1));
  assign s0_cmul0_recip_out_0_fork_ack_s_1 = (s0_cmul0_recip_out_0_to_s0_cmul0_m2c_cd_ack || (! s0_cmul0_recip_out_0_to_s0_cmul0_m2c_cd_req));
  assign s0_cmul0_recip_out_0_m_ack = (s0_cmul0_recip_out_0_fork_ack_s_0 && s0_cmul0_recip_out_0_fork_ack_s_1);
  assign cfg_s0_cmul0_m2c_ac_m_req = cfg_s0_cmul0_m2c_ac_req;
  assign cfg_s0_cmul0_m2c_ac_ack = cfg_s0_cmul0_m2c_ac_m_ack;
  assign cfg_s0_cmul0_m2c_ac_to_s0_cmul0_m2c_ac_req = cfg_s0_cmul0_m2c_ac_m_req;
  assign cfg_s0_cmul0_m2c_ac_m_ack = cfg_s0_cmul0_m2c_ac_to_s0_cmul0_m2c_ac_ack;
  assign s0_cmul0_m2c_ac_0_m_req = s0_cmul0_m2c_ac_0_req;
  assign s0_cmul0_m2c_ac_0_ack = s0_cmul0_m2c_ac_0_m_ack;
  assign s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_req = s0_cmul0_m2c_ac_0_m_req;
  assign s0_cmul0_m2c_ac_0_m_ack = s0_cmul0_m2c_ac_0_to_s0_cmul0_cat_re_ack;
  assign cfg_s0_cmul0_m2c_bc_m_req = cfg_s0_cmul0_m2c_bc_req;
  assign cfg_s0_cmul0_m2c_bc_ack = cfg_s0_cmul0_m2c_bc_m_ack;
  assign cfg_s0_cmul0_m2c_bc_to_s0_cmul0_m2c_bc_req = cfg_s0_cmul0_m2c_bc_m_req;
  assign cfg_s0_cmul0_m2c_bc_m_ack = cfg_s0_cmul0_m2c_bc_to_s0_cmul0_m2c_bc_ack;
  assign s0_cmul0_m2c_bc_0_m_req = s0_cmul0_m2c_bc_0_req;
  assign s0_cmul0_m2c_bc_0_ack = s0_cmul0_m2c_bc_0_m_ack;
  assign s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_req = s0_cmul0_m2c_bc_0_m_req;
  assign s0_cmul0_m2c_bc_0_m_ack = s0_cmul0_m2c_bc_0_to_s0_cmul0_cat_re_ack;
  assign cfg_s0_cmul0_m2c_bd_m_req = cfg_s0_cmul0_m2c_bd_req;
  assign cfg_s0_cmul0_m2c_bd_ack = cfg_s0_cmul0_m2c_bd_m_ack;
  assign cfg_s0_cmul0_m2c_bd_to_s0_cmul0_m2c_bd_req = cfg_s0_cmul0_m2c_bd_m_req;
  assign cfg_s0_cmul0_m2c_bd_m_ack = cfg_s0_cmul0_m2c_bd_to_s0_cmul0_m2c_bd_ack;
  assign s0_cmul0_m2c_bd_0_m_req = s0_cmul0_m2c_bd_0_req;
  assign s0_cmul0_m2c_bd_0_ack = s0_cmul0_m2c_bd_0_m_ack;
  assign s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_req = s0_cmul0_m2c_bd_0_m_req;
  assign s0_cmul0_m2c_bd_0_m_ack = s0_cmul0_m2c_bd_0_to_s0_cmul0_cat_re_ack;
  assign cfg_s0_cmul0_m2c_cb_m_req = cfg_s0_cmul0_m2c_cb_req;
  assign cfg_s0_cmul0_m2c_cb_ack = cfg_s0_cmul0_m2c_cb_m_ack;
  assign cfg_s0_cmul0_m2c_cb_to_s0_cmul0_m2c_cb_req = cfg_s0_cmul0_m2c_cb_m_req;
  assign cfg_s0_cmul0_m2c_cb_m_ack = cfg_s0_cmul0_m2c_cb_to_s0_cmul0_m2c_cb_ack;
  assign s0_cmul0_m2c_cb_0_m_req = s0_cmul0_m2c_cb_0_req;
  assign s0_cmul0_m2c_cb_0_ack = s0_cmul0_m2c_cb_0_m_ack;
  assign s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_req = s0_cmul0_m2c_cb_0_m_req;
  assign s0_cmul0_m2c_cb_0_m_ack = s0_cmul0_m2c_cb_0_to_s0_cmul0_cat_im_ack;
  assign cfg_s0_cmul0_m2c_cd_m_req = cfg_s0_cmul0_m2c_cd_req;
  assign cfg_s0_cmul0_m2c_cd_ack = cfg_s0_cmul0_m2c_cd_m_ack;
  assign cfg_s0_cmul0_m2c_cd_to_s0_cmul0_m2c_cd_req = cfg_s0_cmul0_m2c_cd_m_req;
  assign cfg_s0_cmul0_m2c_cd_m_ack = cfg_s0_cmul0_m2c_cd_to_s0_cmul0_m2c_cd_ack;
  assign s0_cmul0_m2c_cd_0_m_req = s0_cmul0_m2c_cd_0_req;
  assign s0_cmul0_m2c_cd_0_ack = s0_cmul0_m2c_cd_0_m_ack;
  assign s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_req = s0_cmul0_m2c_cd_0_m_req;
  assign s0_cmul0_m2c_cd_0_m_ack = s0_cmul0_m2c_cd_0_to_s0_cmul0_cat_im_ack;
  assign cfg_s0_cmul0_m2c_da_m_req = cfg_s0_cmul0_m2c_da_req;
  assign cfg_s0_cmul0_m2c_da_ack = cfg_s0_cmul0_m2c_da_m_ack;
  assign cfg_s0_cmul0_m2c_da_to_s0_cmul0_m2c_da_req = cfg_s0_cmul0_m2c_da_m_req;
  assign cfg_s0_cmul0_m2c_da_m_ack = cfg_s0_cmul0_m2c_da_to_s0_cmul0_m2c_da_ack;
  assign s0_cmul0_m2c_da_0_m_req = s0_cmul0_m2c_da_0_req;
  assign s0_cmul0_m2c_da_0_ack = s0_cmul0_m2c_da_0_m_ack;
  assign s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_req = s0_cmul0_m2c_da_0_m_req;
  assign s0_cmul0_m2c_da_0_m_ack = s0_cmul0_m2c_da_0_to_s0_cmul0_cat_im_ack;
  always @(*) begin
    s0_cmul0_cat_re_0_eb_state_nxt = s0_cmul0_cat_re_0_eb_state;
    case(s0_cmul0_cat_re_0_eb_state)
      5'h14 : begin
        if(s0_cmul0_cat_re_0_req) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_cmul0_cat_re_0_req) && s0_cmul0_cat_re_0_m_ack)) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul0_cat_re_0_req && (! s0_cmul0_cat_re_0_m_ack))) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_cmul0_cat_re_0_req && s0_cmul0_cat_re_0_m_ack)) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_cmul0_cat_re_0_m_ack) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_cmul0_cat_re_0_req) && s0_cmul0_cat_re_0_m_ack)) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul0_cat_re_0_req && (! s0_cmul0_cat_re_0_m_ack))) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_cmul0_cat_re_0_req && s0_cmul0_cat_re_0_m_ack)) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_cmul0_cat_re_0_m_ack) begin
          s0_cmul0_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_cmul0_cat_re_0_eb_en0 = (s0_cmul0_cat_re_0_eb_state[2] && s0_cmul0_cat_re_0_req);
  assign s0_cmul0_cat_re_0_eb_en1 = (s0_cmul0_cat_re_0_eb_state[1] && s0_cmul0_cat_re_0_req);
  assign s0_cmul0_cat_re_0_eb_sel = s0_cmul0_cat_re_0_eb_state[0];
  assign s0_cmul0_cat_re_0_ack = s0_cmul0_cat_re_0_eb_state[4];
  assign s0_cmul0_cat_re_0_m_req = s0_cmul0_cat_re_0_eb_state[3];
  assign s0_cmul0_cat_re_0 = (s0_cmul0_cat_re_0_eb_sel ? s0_cmul0_cat_re_0_eb_r1 : s0_cmul0_cat_re_0_eb_r0);
  assign s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_req = s0_cmul0_cat_re_0_m_req;
  assign s0_cmul0_cat_re_0_m_ack = s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_ack;
  always @(*) begin
    s0_cmul0_cat_im_0_eb_state_nxt = s0_cmul0_cat_im_0_eb_state;
    case(s0_cmul0_cat_im_0_eb_state)
      5'h14 : begin
        if(s0_cmul0_cat_im_0_req) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_cmul0_cat_im_0_req) && s0_cmul0_cat_im_0_m_ack)) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul0_cat_im_0_req && (! s0_cmul0_cat_im_0_m_ack))) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_cmul0_cat_im_0_req && s0_cmul0_cat_im_0_m_ack)) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_cmul0_cat_im_0_m_ack) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_cmul0_cat_im_0_req) && s0_cmul0_cat_im_0_m_ack)) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul0_cat_im_0_req && (! s0_cmul0_cat_im_0_m_ack))) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_cmul0_cat_im_0_req && s0_cmul0_cat_im_0_m_ack)) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_cmul0_cat_im_0_m_ack) begin
          s0_cmul0_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_cmul0_cat_im_0_eb_en0 = (s0_cmul0_cat_im_0_eb_state[2] && s0_cmul0_cat_im_0_req);
  assign s0_cmul0_cat_im_0_eb_en1 = (s0_cmul0_cat_im_0_eb_state[1] && s0_cmul0_cat_im_0_req);
  assign s0_cmul0_cat_im_0_eb_sel = s0_cmul0_cat_im_0_eb_state[0];
  assign s0_cmul0_cat_im_0_ack = s0_cmul0_cat_im_0_eb_state[4];
  assign s0_cmul0_cat_im_0_m_req = s0_cmul0_cat_im_0_eb_state[3];
  assign s0_cmul0_cat_im_0 = (s0_cmul0_cat_im_0_eb_sel ? s0_cmul0_cat_im_0_eb_r1 : s0_cmul0_cat_im_0_eb_r0);
  assign s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_req = s0_cmul0_cat_im_0_m_req;
  assign s0_cmul0_cat_im_0_m_ack = s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_ack;
  assign cfg_s0_cmul0_mas_re_m_req = cfg_s0_cmul0_mas_re_req;
  assign cfg_s0_cmul0_mas_re_ack = cfg_s0_cmul0_mas_re_m_ack;
  assign cfg_s0_cmul0_mas_re_to_s0_cmul0_mas_re_req = cfg_s0_cmul0_mas_re_m_req;
  assign cfg_s0_cmul0_mas_re_m_ack = cfg_s0_cmul0_mas_re_to_s0_cmul0_mas_re_ack;
  assign s0_cmul0_mas_re_0_m_req = s0_cmul0_mas_re_0_req;
  assign s0_cmul0_mas_re_0_ack = s0_cmul0_mas_re_0_m_ack;
  assign s0_cmul0_mas_re_0_to_s0_r4_a0_re_req = (s0_cmul0_mas_re_0_m_req && (! s0_cmul0_mas_re_0_fork_ack_r_0));
  assign s0_cmul0_mas_re_0_fork_ack_s_0 = (s0_cmul0_mas_re_0_to_s0_r4_a0_re_ack || (! s0_cmul0_mas_re_0_to_s0_r4_a0_re_req));
  assign s0_cmul0_mas_re_0_to_s0_r4_a2_re_req = (s0_cmul0_mas_re_0_m_req && (! s0_cmul0_mas_re_0_fork_ack_r_1));
  assign s0_cmul0_mas_re_0_fork_ack_s_1 = (s0_cmul0_mas_re_0_to_s0_r4_a2_re_ack || (! s0_cmul0_mas_re_0_to_s0_r4_a2_re_req));
  assign s0_cmul0_mas_re_0_to_s0_r4_byp0_re_req = (s0_cmul0_mas_re_0_m_req && (! s0_cmul0_mas_re_0_fork_ack_r_2));
  assign s0_cmul0_mas_re_0_fork_ack_s_2 = (s0_cmul0_mas_re_0_to_s0_r4_byp0_re_ack || (! s0_cmul0_mas_re_0_to_s0_r4_byp0_re_req));
  assign s0_cmul0_mas_re_0_m_ack = ((s0_cmul0_mas_re_0_fork_ack_s_0 && s0_cmul0_mas_re_0_fork_ack_s_1) && s0_cmul0_mas_re_0_fork_ack_s_2);
  assign cfg_s0_cmul0_mas_im_m_req = cfg_s0_cmul0_mas_im_req;
  assign cfg_s0_cmul0_mas_im_ack = cfg_s0_cmul0_mas_im_m_ack;
  assign cfg_s0_cmul0_mas_im_to_s0_cmul0_mas_im_req = cfg_s0_cmul0_mas_im_m_req;
  assign cfg_s0_cmul0_mas_im_m_ack = cfg_s0_cmul0_mas_im_to_s0_cmul0_mas_im_ack;
  assign s0_cmul0_mas_im_0_m_req = s0_cmul0_mas_im_0_req;
  assign s0_cmul0_mas_im_0_ack = s0_cmul0_mas_im_0_m_ack;
  assign s0_cmul0_mas_im_0_to_s0_r4_a0_im_req = (s0_cmul0_mas_im_0_m_req && (! s0_cmul0_mas_im_0_fork_ack_r_0));
  assign s0_cmul0_mas_im_0_fork_ack_s_0 = (s0_cmul0_mas_im_0_to_s0_r4_a0_im_ack || (! s0_cmul0_mas_im_0_to_s0_r4_a0_im_req));
  assign s0_cmul0_mas_im_0_to_s0_r4_a2_im_req = (s0_cmul0_mas_im_0_m_req && (! s0_cmul0_mas_im_0_fork_ack_r_1));
  assign s0_cmul0_mas_im_0_fork_ack_s_1 = (s0_cmul0_mas_im_0_to_s0_r4_a2_im_ack || (! s0_cmul0_mas_im_0_to_s0_r4_a2_im_req));
  assign s0_cmul0_mas_im_0_to_s0_r4_byp0_im_req = (s0_cmul0_mas_im_0_m_req && (! s0_cmul0_mas_im_0_fork_ack_r_2));
  assign s0_cmul0_mas_im_0_fork_ack_s_2 = (s0_cmul0_mas_im_0_to_s0_r4_byp0_im_ack || (! s0_cmul0_mas_im_0_to_s0_r4_byp0_im_req));
  assign s0_cmul0_mas_im_0_m_ack = ((s0_cmul0_mas_im_0_fork_ack_s_0 && s0_cmul0_mas_im_0_fork_ack_s_1) && s0_cmul0_mas_im_0_fork_ack_s_2);
  assign s0_cmul1_recip_norm_0_ack = ((! s0_cmul1_recip_norm_0_eb_valid) || s0_cmul1_recip_norm_0_m_ack);
  assign s0_cmul1_recip_norm_0_eb_en = (s0_cmul1_recip_norm_0_req && s0_cmul1_recip_norm_0_ack);
  assign s0_cmul1_recip_norm_0_m_req = s0_cmul1_recip_norm_0_eb_valid;
  assign s0_cmul1_recip_norm_0 = s0_cmul1_recip_norm_0_eb_r;
  assign s0_cmul1_recip_norm_0_to_s0_cmul1_recip_mul_req = s0_cmul1_recip_norm_0_m_req;
  assign s0_cmul1_recip_norm_0_m_ack = s0_cmul1_recip_norm_0_to_s0_cmul1_recip_mul_ack;
  assign s0_cmul1_recip_mul_0_ack = ((! s0_cmul1_recip_mul_0_eb_valid) || s0_cmul1_recip_mul_0_m_ack);
  assign s0_cmul1_recip_mul_0_eb_en = (s0_cmul1_recip_mul_0_req && s0_cmul1_recip_mul_0_ack);
  assign s0_cmul1_recip_mul_0_m_req = s0_cmul1_recip_mul_0_eb_valid;
  assign s0_cmul1_recip_mul_0 = s0_cmul1_recip_mul_0_eb_r;
  assign s0_cmul1_recip_mul_0_to_s0_cmul1_recip_out_req = s0_cmul1_recip_mul_0_m_req;
  assign s0_cmul1_recip_mul_0_m_ack = s0_cmul1_recip_mul_0_to_s0_cmul1_recip_out_ack;
  assign s0_cmul1_recip_out_0_ack = ((! s0_cmul1_recip_out_0_eb_valid) || s0_cmul1_recip_out_0_m_ack);
  assign s0_cmul1_recip_out_0_eb_en = (s0_cmul1_recip_out_0_req && s0_cmul1_recip_out_0_ack);
  assign s0_cmul1_recip_out_0_m_req = s0_cmul1_recip_out_0_eb_valid;
  assign s0_cmul1_recip_out_0 = s0_cmul1_recip_out_0_eb_r;
  assign s0_cmul1_recip_out_0_to_s0_cmul1_m2c_ac_req = (s0_cmul1_recip_out_0_m_req && (! s0_cmul1_recip_out_0_fork_ack_r_0));
  assign s0_cmul1_recip_out_0_fork_ack_s_0 = (s0_cmul1_recip_out_0_to_s0_cmul1_m2c_ac_ack || (! s0_cmul1_recip_out_0_to_s0_cmul1_m2c_ac_req));
  assign s0_cmul1_recip_out_0_to_s0_cmul1_m2c_cd_req = (s0_cmul1_recip_out_0_m_req && (! s0_cmul1_recip_out_0_fork_ack_r_1));
  assign s0_cmul1_recip_out_0_fork_ack_s_1 = (s0_cmul1_recip_out_0_to_s0_cmul1_m2c_cd_ack || (! s0_cmul1_recip_out_0_to_s0_cmul1_m2c_cd_req));
  assign s0_cmul1_recip_out_0_m_ack = (s0_cmul1_recip_out_0_fork_ack_s_0 && s0_cmul1_recip_out_0_fork_ack_s_1);
  assign cfg_s0_cmul1_m2c_ac_m_req = cfg_s0_cmul1_m2c_ac_req;
  assign cfg_s0_cmul1_m2c_ac_ack = cfg_s0_cmul1_m2c_ac_m_ack;
  assign cfg_s0_cmul1_m2c_ac_to_s0_cmul1_m2c_ac_req = cfg_s0_cmul1_m2c_ac_m_req;
  assign cfg_s0_cmul1_m2c_ac_m_ack = cfg_s0_cmul1_m2c_ac_to_s0_cmul1_m2c_ac_ack;
  assign s0_cmul1_m2c_ac_0_m_req = s0_cmul1_m2c_ac_0_req;
  assign s0_cmul1_m2c_ac_0_ack = s0_cmul1_m2c_ac_0_m_ack;
  assign s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_req = s0_cmul1_m2c_ac_0_m_req;
  assign s0_cmul1_m2c_ac_0_m_ack = s0_cmul1_m2c_ac_0_to_s0_cmul1_cat_re_ack;
  assign cfg_s0_cmul1_m2c_bc_m_req = cfg_s0_cmul1_m2c_bc_req;
  assign cfg_s0_cmul1_m2c_bc_ack = cfg_s0_cmul1_m2c_bc_m_ack;
  assign cfg_s0_cmul1_m2c_bc_to_s0_cmul1_m2c_bc_req = cfg_s0_cmul1_m2c_bc_m_req;
  assign cfg_s0_cmul1_m2c_bc_m_ack = cfg_s0_cmul1_m2c_bc_to_s0_cmul1_m2c_bc_ack;
  assign s0_cmul1_m2c_bc_0_m_req = s0_cmul1_m2c_bc_0_req;
  assign s0_cmul1_m2c_bc_0_ack = s0_cmul1_m2c_bc_0_m_ack;
  assign s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_req = s0_cmul1_m2c_bc_0_m_req;
  assign s0_cmul1_m2c_bc_0_m_ack = s0_cmul1_m2c_bc_0_to_s0_cmul1_cat_re_ack;
  assign cfg_s0_cmul1_m2c_bd_m_req = cfg_s0_cmul1_m2c_bd_req;
  assign cfg_s0_cmul1_m2c_bd_ack = cfg_s0_cmul1_m2c_bd_m_ack;
  assign cfg_s0_cmul1_m2c_bd_to_s0_cmul1_m2c_bd_req = cfg_s0_cmul1_m2c_bd_m_req;
  assign cfg_s0_cmul1_m2c_bd_m_ack = cfg_s0_cmul1_m2c_bd_to_s0_cmul1_m2c_bd_ack;
  assign s0_cmul1_m2c_bd_0_m_req = s0_cmul1_m2c_bd_0_req;
  assign s0_cmul1_m2c_bd_0_ack = s0_cmul1_m2c_bd_0_m_ack;
  assign s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_req = s0_cmul1_m2c_bd_0_m_req;
  assign s0_cmul1_m2c_bd_0_m_ack = s0_cmul1_m2c_bd_0_to_s0_cmul1_cat_re_ack;
  assign cfg_s0_cmul1_m2c_cb_m_req = cfg_s0_cmul1_m2c_cb_req;
  assign cfg_s0_cmul1_m2c_cb_ack = cfg_s0_cmul1_m2c_cb_m_ack;
  assign cfg_s0_cmul1_m2c_cb_to_s0_cmul1_m2c_cb_req = cfg_s0_cmul1_m2c_cb_m_req;
  assign cfg_s0_cmul1_m2c_cb_m_ack = cfg_s0_cmul1_m2c_cb_to_s0_cmul1_m2c_cb_ack;
  assign s0_cmul1_m2c_cb_0_m_req = s0_cmul1_m2c_cb_0_req;
  assign s0_cmul1_m2c_cb_0_ack = s0_cmul1_m2c_cb_0_m_ack;
  assign s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_req = s0_cmul1_m2c_cb_0_m_req;
  assign s0_cmul1_m2c_cb_0_m_ack = s0_cmul1_m2c_cb_0_to_s0_cmul1_cat_im_ack;
  assign cfg_s0_cmul1_m2c_cd_m_req = cfg_s0_cmul1_m2c_cd_req;
  assign cfg_s0_cmul1_m2c_cd_ack = cfg_s0_cmul1_m2c_cd_m_ack;
  assign cfg_s0_cmul1_m2c_cd_to_s0_cmul1_m2c_cd_req = cfg_s0_cmul1_m2c_cd_m_req;
  assign cfg_s0_cmul1_m2c_cd_m_ack = cfg_s0_cmul1_m2c_cd_to_s0_cmul1_m2c_cd_ack;
  assign s0_cmul1_m2c_cd_0_m_req = s0_cmul1_m2c_cd_0_req;
  assign s0_cmul1_m2c_cd_0_ack = s0_cmul1_m2c_cd_0_m_ack;
  assign s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_req = s0_cmul1_m2c_cd_0_m_req;
  assign s0_cmul1_m2c_cd_0_m_ack = s0_cmul1_m2c_cd_0_to_s0_cmul1_cat_im_ack;
  assign cfg_s0_cmul1_m2c_da_m_req = cfg_s0_cmul1_m2c_da_req;
  assign cfg_s0_cmul1_m2c_da_ack = cfg_s0_cmul1_m2c_da_m_ack;
  assign cfg_s0_cmul1_m2c_da_to_s0_cmul1_m2c_da_req = cfg_s0_cmul1_m2c_da_m_req;
  assign cfg_s0_cmul1_m2c_da_m_ack = cfg_s0_cmul1_m2c_da_to_s0_cmul1_m2c_da_ack;
  assign s0_cmul1_m2c_da_0_m_req = s0_cmul1_m2c_da_0_req;
  assign s0_cmul1_m2c_da_0_ack = s0_cmul1_m2c_da_0_m_ack;
  assign s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_req = s0_cmul1_m2c_da_0_m_req;
  assign s0_cmul1_m2c_da_0_m_ack = s0_cmul1_m2c_da_0_to_s0_cmul1_cat_im_ack;
  always @(*) begin
    s0_cmul1_cat_re_0_eb_state_nxt = s0_cmul1_cat_re_0_eb_state;
    case(s0_cmul1_cat_re_0_eb_state)
      5'h14 : begin
        if(s0_cmul1_cat_re_0_req) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_cmul1_cat_re_0_req) && s0_cmul1_cat_re_0_m_ack)) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul1_cat_re_0_req && (! s0_cmul1_cat_re_0_m_ack))) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_cmul1_cat_re_0_req && s0_cmul1_cat_re_0_m_ack)) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_cmul1_cat_re_0_m_ack) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_cmul1_cat_re_0_req) && s0_cmul1_cat_re_0_m_ack)) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul1_cat_re_0_req && (! s0_cmul1_cat_re_0_m_ack))) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_cmul1_cat_re_0_req && s0_cmul1_cat_re_0_m_ack)) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_cmul1_cat_re_0_m_ack) begin
          s0_cmul1_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_cmul1_cat_re_0_eb_en0 = (s0_cmul1_cat_re_0_eb_state[2] && s0_cmul1_cat_re_0_req);
  assign s0_cmul1_cat_re_0_eb_en1 = (s0_cmul1_cat_re_0_eb_state[1] && s0_cmul1_cat_re_0_req);
  assign s0_cmul1_cat_re_0_eb_sel = s0_cmul1_cat_re_0_eb_state[0];
  assign s0_cmul1_cat_re_0_ack = s0_cmul1_cat_re_0_eb_state[4];
  assign s0_cmul1_cat_re_0_m_req = s0_cmul1_cat_re_0_eb_state[3];
  assign s0_cmul1_cat_re_0 = (s0_cmul1_cat_re_0_eb_sel ? s0_cmul1_cat_re_0_eb_r1 : s0_cmul1_cat_re_0_eb_r0);
  assign s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_req = s0_cmul1_cat_re_0_m_req;
  assign s0_cmul1_cat_re_0_m_ack = s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_ack;
  always @(*) begin
    s0_cmul1_cat_im_0_eb_state_nxt = s0_cmul1_cat_im_0_eb_state;
    case(s0_cmul1_cat_im_0_eb_state)
      5'h14 : begin
        if(s0_cmul1_cat_im_0_req) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_cmul1_cat_im_0_req) && s0_cmul1_cat_im_0_m_ack)) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul1_cat_im_0_req && (! s0_cmul1_cat_im_0_m_ack))) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_cmul1_cat_im_0_req && s0_cmul1_cat_im_0_m_ack)) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_cmul1_cat_im_0_m_ack) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_cmul1_cat_im_0_req) && s0_cmul1_cat_im_0_m_ack)) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul1_cat_im_0_req && (! s0_cmul1_cat_im_0_m_ack))) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_cmul1_cat_im_0_req && s0_cmul1_cat_im_0_m_ack)) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_cmul1_cat_im_0_m_ack) begin
          s0_cmul1_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_cmul1_cat_im_0_eb_en0 = (s0_cmul1_cat_im_0_eb_state[2] && s0_cmul1_cat_im_0_req);
  assign s0_cmul1_cat_im_0_eb_en1 = (s0_cmul1_cat_im_0_eb_state[1] && s0_cmul1_cat_im_0_req);
  assign s0_cmul1_cat_im_0_eb_sel = s0_cmul1_cat_im_0_eb_state[0];
  assign s0_cmul1_cat_im_0_ack = s0_cmul1_cat_im_0_eb_state[4];
  assign s0_cmul1_cat_im_0_m_req = s0_cmul1_cat_im_0_eb_state[3];
  assign s0_cmul1_cat_im_0 = (s0_cmul1_cat_im_0_eb_sel ? s0_cmul1_cat_im_0_eb_r1 : s0_cmul1_cat_im_0_eb_r0);
  assign s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_req = s0_cmul1_cat_im_0_m_req;
  assign s0_cmul1_cat_im_0_m_ack = s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_ack;
  assign cfg_s0_cmul1_mas_re_m_req = cfg_s0_cmul1_mas_re_req;
  assign cfg_s0_cmul1_mas_re_ack = cfg_s0_cmul1_mas_re_m_ack;
  assign cfg_s0_cmul1_mas_re_to_s0_cmul1_mas_re_req = cfg_s0_cmul1_mas_re_m_req;
  assign cfg_s0_cmul1_mas_re_m_ack = cfg_s0_cmul1_mas_re_to_s0_cmul1_mas_re_ack;
  assign s0_cmul1_mas_re_0_m_req = s0_cmul1_mas_re_0_req;
  assign s0_cmul1_mas_re_0_ack = s0_cmul1_mas_re_0_m_ack;
  assign s0_cmul1_mas_re_0_to_s0_r4_a1_re_req = (s0_cmul1_mas_re_0_m_req && (! s0_cmul1_mas_re_0_fork_ack_r_0));
  assign s0_cmul1_mas_re_0_fork_ack_s_0 = (s0_cmul1_mas_re_0_to_s0_r4_a1_re_ack || (! s0_cmul1_mas_re_0_to_s0_r4_a1_re_req));
  assign s0_cmul1_mas_re_0_to_s0_r4_a3_re_req = (s0_cmul1_mas_re_0_m_req && (! s0_cmul1_mas_re_0_fork_ack_r_1));
  assign s0_cmul1_mas_re_0_fork_ack_s_1 = (s0_cmul1_mas_re_0_to_s0_r4_a3_re_ack || (! s0_cmul1_mas_re_0_to_s0_r4_a3_re_req));
  assign s0_cmul1_mas_re_0_to_s0_r4_byp1_re_req = (s0_cmul1_mas_re_0_m_req && (! s0_cmul1_mas_re_0_fork_ack_r_2));
  assign s0_cmul1_mas_re_0_fork_ack_s_2 = (s0_cmul1_mas_re_0_to_s0_r4_byp1_re_ack || (! s0_cmul1_mas_re_0_to_s0_r4_byp1_re_req));
  assign s0_cmul1_mas_re_0_m_ack = ((s0_cmul1_mas_re_0_fork_ack_s_0 && s0_cmul1_mas_re_0_fork_ack_s_1) && s0_cmul1_mas_re_0_fork_ack_s_2);
  assign cfg_s0_cmul1_mas_im_m_req = cfg_s0_cmul1_mas_im_req;
  assign cfg_s0_cmul1_mas_im_ack = cfg_s0_cmul1_mas_im_m_ack;
  assign cfg_s0_cmul1_mas_im_to_s0_cmul1_mas_im_req = cfg_s0_cmul1_mas_im_m_req;
  assign cfg_s0_cmul1_mas_im_m_ack = cfg_s0_cmul1_mas_im_to_s0_cmul1_mas_im_ack;
  assign s0_cmul1_mas_im_0_m_req = s0_cmul1_mas_im_0_req;
  assign s0_cmul1_mas_im_0_ack = s0_cmul1_mas_im_0_m_ack;
  assign s0_cmul1_mas_im_0_to_s0_r4_a1_im_req = (s0_cmul1_mas_im_0_m_req && (! s0_cmul1_mas_im_0_fork_ack_r_0));
  assign s0_cmul1_mas_im_0_fork_ack_s_0 = (s0_cmul1_mas_im_0_to_s0_r4_a1_im_ack || (! s0_cmul1_mas_im_0_to_s0_r4_a1_im_req));
  assign s0_cmul1_mas_im_0_to_s0_r4_a3_im_req = (s0_cmul1_mas_im_0_m_req && (! s0_cmul1_mas_im_0_fork_ack_r_1));
  assign s0_cmul1_mas_im_0_fork_ack_s_1 = (s0_cmul1_mas_im_0_to_s0_r4_a3_im_ack || (! s0_cmul1_mas_im_0_to_s0_r4_a3_im_req));
  assign s0_cmul1_mas_im_0_to_s0_r4_byp1_im_req = (s0_cmul1_mas_im_0_m_req && (! s0_cmul1_mas_im_0_fork_ack_r_2));
  assign s0_cmul1_mas_im_0_fork_ack_s_2 = (s0_cmul1_mas_im_0_to_s0_r4_byp1_im_ack || (! s0_cmul1_mas_im_0_to_s0_r4_byp1_im_req));
  assign s0_cmul1_mas_im_0_m_ack = ((s0_cmul1_mas_im_0_fork_ack_s_0 && s0_cmul1_mas_im_0_fork_ack_s_1) && s0_cmul1_mas_im_0_fork_ack_s_2);
  assign s0_cmul2_recip_norm_0_ack = ((! s0_cmul2_recip_norm_0_eb_valid) || s0_cmul2_recip_norm_0_m_ack);
  assign s0_cmul2_recip_norm_0_eb_en = (s0_cmul2_recip_norm_0_req && s0_cmul2_recip_norm_0_ack);
  assign s0_cmul2_recip_norm_0_m_req = s0_cmul2_recip_norm_0_eb_valid;
  assign s0_cmul2_recip_norm_0 = s0_cmul2_recip_norm_0_eb_r;
  assign s0_cmul2_recip_norm_0_to_s0_cmul2_recip_mul_req = s0_cmul2_recip_norm_0_m_req;
  assign s0_cmul2_recip_norm_0_m_ack = s0_cmul2_recip_norm_0_to_s0_cmul2_recip_mul_ack;
  assign s0_cmul2_recip_mul_0_ack = ((! s0_cmul2_recip_mul_0_eb_valid) || s0_cmul2_recip_mul_0_m_ack);
  assign s0_cmul2_recip_mul_0_eb_en = (s0_cmul2_recip_mul_0_req && s0_cmul2_recip_mul_0_ack);
  assign s0_cmul2_recip_mul_0_m_req = s0_cmul2_recip_mul_0_eb_valid;
  assign s0_cmul2_recip_mul_0 = s0_cmul2_recip_mul_0_eb_r;
  assign s0_cmul2_recip_mul_0_to_s0_cmul2_recip_out_req = s0_cmul2_recip_mul_0_m_req;
  assign s0_cmul2_recip_mul_0_m_ack = s0_cmul2_recip_mul_0_to_s0_cmul2_recip_out_ack;
  assign s0_cmul2_recip_out_0_ack = ((! s0_cmul2_recip_out_0_eb_valid) || s0_cmul2_recip_out_0_m_ack);
  assign s0_cmul2_recip_out_0_eb_en = (s0_cmul2_recip_out_0_req && s0_cmul2_recip_out_0_ack);
  assign s0_cmul2_recip_out_0_m_req = s0_cmul2_recip_out_0_eb_valid;
  assign s0_cmul2_recip_out_0 = s0_cmul2_recip_out_0_eb_r;
  assign s0_cmul2_recip_out_0_to_s0_cmul2_m2c_ac_req = (s0_cmul2_recip_out_0_m_req && (! s0_cmul2_recip_out_0_fork_ack_r_0));
  assign s0_cmul2_recip_out_0_fork_ack_s_0 = (s0_cmul2_recip_out_0_to_s0_cmul2_m2c_ac_ack || (! s0_cmul2_recip_out_0_to_s0_cmul2_m2c_ac_req));
  assign s0_cmul2_recip_out_0_to_s0_cmul2_m2c_cd_req = (s0_cmul2_recip_out_0_m_req && (! s0_cmul2_recip_out_0_fork_ack_r_1));
  assign s0_cmul2_recip_out_0_fork_ack_s_1 = (s0_cmul2_recip_out_0_to_s0_cmul2_m2c_cd_ack || (! s0_cmul2_recip_out_0_to_s0_cmul2_m2c_cd_req));
  assign s0_cmul2_recip_out_0_m_ack = (s0_cmul2_recip_out_0_fork_ack_s_0 && s0_cmul2_recip_out_0_fork_ack_s_1);
  assign cfg_s0_cmul2_m2c_ac_m_req = cfg_s0_cmul2_m2c_ac_req;
  assign cfg_s0_cmul2_m2c_ac_ack = cfg_s0_cmul2_m2c_ac_m_ack;
  assign cfg_s0_cmul2_m2c_ac_to_s0_cmul2_m2c_ac_req = cfg_s0_cmul2_m2c_ac_m_req;
  assign cfg_s0_cmul2_m2c_ac_m_ack = cfg_s0_cmul2_m2c_ac_to_s0_cmul2_m2c_ac_ack;
  assign s0_cmul2_m2c_ac_0_m_req = s0_cmul2_m2c_ac_0_req;
  assign s0_cmul2_m2c_ac_0_ack = s0_cmul2_m2c_ac_0_m_ack;
  assign s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_req = s0_cmul2_m2c_ac_0_m_req;
  assign s0_cmul2_m2c_ac_0_m_ack = s0_cmul2_m2c_ac_0_to_s0_cmul2_cat_re_ack;
  assign cfg_s0_cmul2_m2c_bc_m_req = cfg_s0_cmul2_m2c_bc_req;
  assign cfg_s0_cmul2_m2c_bc_ack = cfg_s0_cmul2_m2c_bc_m_ack;
  assign cfg_s0_cmul2_m2c_bc_to_s0_cmul2_m2c_bc_req = cfg_s0_cmul2_m2c_bc_m_req;
  assign cfg_s0_cmul2_m2c_bc_m_ack = cfg_s0_cmul2_m2c_bc_to_s0_cmul2_m2c_bc_ack;
  assign s0_cmul2_m2c_bc_0_m_req = s0_cmul2_m2c_bc_0_req;
  assign s0_cmul2_m2c_bc_0_ack = s0_cmul2_m2c_bc_0_m_ack;
  assign s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_req = s0_cmul2_m2c_bc_0_m_req;
  assign s0_cmul2_m2c_bc_0_m_ack = s0_cmul2_m2c_bc_0_to_s0_cmul2_cat_re_ack;
  assign cfg_s0_cmul2_m2c_bd_m_req = cfg_s0_cmul2_m2c_bd_req;
  assign cfg_s0_cmul2_m2c_bd_ack = cfg_s0_cmul2_m2c_bd_m_ack;
  assign cfg_s0_cmul2_m2c_bd_to_s0_cmul2_m2c_bd_req = cfg_s0_cmul2_m2c_bd_m_req;
  assign cfg_s0_cmul2_m2c_bd_m_ack = cfg_s0_cmul2_m2c_bd_to_s0_cmul2_m2c_bd_ack;
  assign s0_cmul2_m2c_bd_0_m_req = s0_cmul2_m2c_bd_0_req;
  assign s0_cmul2_m2c_bd_0_ack = s0_cmul2_m2c_bd_0_m_ack;
  assign s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_req = s0_cmul2_m2c_bd_0_m_req;
  assign s0_cmul2_m2c_bd_0_m_ack = s0_cmul2_m2c_bd_0_to_s0_cmul2_cat_re_ack;
  assign cfg_s0_cmul2_m2c_cb_m_req = cfg_s0_cmul2_m2c_cb_req;
  assign cfg_s0_cmul2_m2c_cb_ack = cfg_s0_cmul2_m2c_cb_m_ack;
  assign cfg_s0_cmul2_m2c_cb_to_s0_cmul2_m2c_cb_req = cfg_s0_cmul2_m2c_cb_m_req;
  assign cfg_s0_cmul2_m2c_cb_m_ack = cfg_s0_cmul2_m2c_cb_to_s0_cmul2_m2c_cb_ack;
  assign s0_cmul2_m2c_cb_0_m_req = s0_cmul2_m2c_cb_0_req;
  assign s0_cmul2_m2c_cb_0_ack = s0_cmul2_m2c_cb_0_m_ack;
  assign s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_req = s0_cmul2_m2c_cb_0_m_req;
  assign s0_cmul2_m2c_cb_0_m_ack = s0_cmul2_m2c_cb_0_to_s0_cmul2_cat_im_ack;
  assign cfg_s0_cmul2_m2c_cd_m_req = cfg_s0_cmul2_m2c_cd_req;
  assign cfg_s0_cmul2_m2c_cd_ack = cfg_s0_cmul2_m2c_cd_m_ack;
  assign cfg_s0_cmul2_m2c_cd_to_s0_cmul2_m2c_cd_req = cfg_s0_cmul2_m2c_cd_m_req;
  assign cfg_s0_cmul2_m2c_cd_m_ack = cfg_s0_cmul2_m2c_cd_to_s0_cmul2_m2c_cd_ack;
  assign s0_cmul2_m2c_cd_0_m_req = s0_cmul2_m2c_cd_0_req;
  assign s0_cmul2_m2c_cd_0_ack = s0_cmul2_m2c_cd_0_m_ack;
  assign s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_req = s0_cmul2_m2c_cd_0_m_req;
  assign s0_cmul2_m2c_cd_0_m_ack = s0_cmul2_m2c_cd_0_to_s0_cmul2_cat_im_ack;
  assign cfg_s0_cmul2_m2c_da_m_req = cfg_s0_cmul2_m2c_da_req;
  assign cfg_s0_cmul2_m2c_da_ack = cfg_s0_cmul2_m2c_da_m_ack;
  assign cfg_s0_cmul2_m2c_da_to_s0_cmul2_m2c_da_req = cfg_s0_cmul2_m2c_da_m_req;
  assign cfg_s0_cmul2_m2c_da_m_ack = cfg_s0_cmul2_m2c_da_to_s0_cmul2_m2c_da_ack;
  assign s0_cmul2_m2c_da_0_m_req = s0_cmul2_m2c_da_0_req;
  assign s0_cmul2_m2c_da_0_ack = s0_cmul2_m2c_da_0_m_ack;
  assign s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_req = s0_cmul2_m2c_da_0_m_req;
  assign s0_cmul2_m2c_da_0_m_ack = s0_cmul2_m2c_da_0_to_s0_cmul2_cat_im_ack;
  always @(*) begin
    s0_cmul2_cat_re_0_eb_state_nxt = s0_cmul2_cat_re_0_eb_state;
    case(s0_cmul2_cat_re_0_eb_state)
      5'h14 : begin
        if(s0_cmul2_cat_re_0_req) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_cmul2_cat_re_0_req) && s0_cmul2_cat_re_0_m_ack)) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul2_cat_re_0_req && (! s0_cmul2_cat_re_0_m_ack))) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_cmul2_cat_re_0_req && s0_cmul2_cat_re_0_m_ack)) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_cmul2_cat_re_0_m_ack) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_cmul2_cat_re_0_req) && s0_cmul2_cat_re_0_m_ack)) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul2_cat_re_0_req && (! s0_cmul2_cat_re_0_m_ack))) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_cmul2_cat_re_0_req && s0_cmul2_cat_re_0_m_ack)) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_cmul2_cat_re_0_m_ack) begin
          s0_cmul2_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_cmul2_cat_re_0_eb_en0 = (s0_cmul2_cat_re_0_eb_state[2] && s0_cmul2_cat_re_0_req);
  assign s0_cmul2_cat_re_0_eb_en1 = (s0_cmul2_cat_re_0_eb_state[1] && s0_cmul2_cat_re_0_req);
  assign s0_cmul2_cat_re_0_eb_sel = s0_cmul2_cat_re_0_eb_state[0];
  assign s0_cmul2_cat_re_0_ack = s0_cmul2_cat_re_0_eb_state[4];
  assign s0_cmul2_cat_re_0_m_req = s0_cmul2_cat_re_0_eb_state[3];
  assign s0_cmul2_cat_re_0 = (s0_cmul2_cat_re_0_eb_sel ? s0_cmul2_cat_re_0_eb_r1 : s0_cmul2_cat_re_0_eb_r0);
  assign s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_req = s0_cmul2_cat_re_0_m_req;
  assign s0_cmul2_cat_re_0_m_ack = s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_ack;
  always @(*) begin
    s0_cmul2_cat_im_0_eb_state_nxt = s0_cmul2_cat_im_0_eb_state;
    case(s0_cmul2_cat_im_0_eb_state)
      5'h14 : begin
        if(s0_cmul2_cat_im_0_req) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_cmul2_cat_im_0_req) && s0_cmul2_cat_im_0_m_ack)) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul2_cat_im_0_req && (! s0_cmul2_cat_im_0_m_ack))) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_cmul2_cat_im_0_req && s0_cmul2_cat_im_0_m_ack)) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_cmul2_cat_im_0_m_ack) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_cmul2_cat_im_0_req) && s0_cmul2_cat_im_0_m_ack)) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul2_cat_im_0_req && (! s0_cmul2_cat_im_0_m_ack))) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_cmul2_cat_im_0_req && s0_cmul2_cat_im_0_m_ack)) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_cmul2_cat_im_0_m_ack) begin
          s0_cmul2_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_cmul2_cat_im_0_eb_en0 = (s0_cmul2_cat_im_0_eb_state[2] && s0_cmul2_cat_im_0_req);
  assign s0_cmul2_cat_im_0_eb_en1 = (s0_cmul2_cat_im_0_eb_state[1] && s0_cmul2_cat_im_0_req);
  assign s0_cmul2_cat_im_0_eb_sel = s0_cmul2_cat_im_0_eb_state[0];
  assign s0_cmul2_cat_im_0_ack = s0_cmul2_cat_im_0_eb_state[4];
  assign s0_cmul2_cat_im_0_m_req = s0_cmul2_cat_im_0_eb_state[3];
  assign s0_cmul2_cat_im_0 = (s0_cmul2_cat_im_0_eb_sel ? s0_cmul2_cat_im_0_eb_r1 : s0_cmul2_cat_im_0_eb_r0);
  assign s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_req = s0_cmul2_cat_im_0_m_req;
  assign s0_cmul2_cat_im_0_m_ack = s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_ack;
  assign cfg_s0_cmul2_mas_re_m_req = cfg_s0_cmul2_mas_re_req;
  assign cfg_s0_cmul2_mas_re_ack = cfg_s0_cmul2_mas_re_m_ack;
  assign cfg_s0_cmul2_mas_re_to_s0_cmul2_mas_re_req = cfg_s0_cmul2_mas_re_m_req;
  assign cfg_s0_cmul2_mas_re_m_ack = cfg_s0_cmul2_mas_re_to_s0_cmul2_mas_re_ack;
  assign s0_cmul2_mas_re_0_m_req = s0_cmul2_mas_re_0_req;
  assign s0_cmul2_mas_re_0_ack = s0_cmul2_mas_re_0_m_ack;
  assign s0_cmul2_mas_re_0_to_s0_r4_a0_re_req = (s0_cmul2_mas_re_0_m_req && (! s0_cmul2_mas_re_0_fork_ack_r_0));
  assign s0_cmul2_mas_re_0_fork_ack_s_0 = (s0_cmul2_mas_re_0_to_s0_r4_a0_re_ack || (! s0_cmul2_mas_re_0_to_s0_r4_a0_re_req));
  assign s0_cmul2_mas_re_0_to_s0_r4_a2_re_req = (s0_cmul2_mas_re_0_m_req && (! s0_cmul2_mas_re_0_fork_ack_r_1));
  assign s0_cmul2_mas_re_0_fork_ack_s_1 = (s0_cmul2_mas_re_0_to_s0_r4_a2_re_ack || (! s0_cmul2_mas_re_0_to_s0_r4_a2_re_req));
  assign s0_cmul2_mas_re_0_to_s0_r4_byp2_re_req = (s0_cmul2_mas_re_0_m_req && (! s0_cmul2_mas_re_0_fork_ack_r_2));
  assign s0_cmul2_mas_re_0_fork_ack_s_2 = (s0_cmul2_mas_re_0_to_s0_r4_byp2_re_ack || (! s0_cmul2_mas_re_0_to_s0_r4_byp2_re_req));
  assign s0_cmul2_mas_re_0_m_ack = ((s0_cmul2_mas_re_0_fork_ack_s_0 && s0_cmul2_mas_re_0_fork_ack_s_1) && s0_cmul2_mas_re_0_fork_ack_s_2);
  assign cfg_s0_cmul2_mas_im_m_req = cfg_s0_cmul2_mas_im_req;
  assign cfg_s0_cmul2_mas_im_ack = cfg_s0_cmul2_mas_im_m_ack;
  assign cfg_s0_cmul2_mas_im_to_s0_cmul2_mas_im_req = cfg_s0_cmul2_mas_im_m_req;
  assign cfg_s0_cmul2_mas_im_m_ack = cfg_s0_cmul2_mas_im_to_s0_cmul2_mas_im_ack;
  assign s0_cmul2_mas_im_0_m_req = s0_cmul2_mas_im_0_req;
  assign s0_cmul2_mas_im_0_ack = s0_cmul2_mas_im_0_m_ack;
  assign s0_cmul2_mas_im_0_to_s0_r4_a0_im_req = (s0_cmul2_mas_im_0_m_req && (! s0_cmul2_mas_im_0_fork_ack_r_0));
  assign s0_cmul2_mas_im_0_fork_ack_s_0 = (s0_cmul2_mas_im_0_to_s0_r4_a0_im_ack || (! s0_cmul2_mas_im_0_to_s0_r4_a0_im_req));
  assign s0_cmul2_mas_im_0_to_s0_r4_a2_im_req = (s0_cmul2_mas_im_0_m_req && (! s0_cmul2_mas_im_0_fork_ack_r_1));
  assign s0_cmul2_mas_im_0_fork_ack_s_1 = (s0_cmul2_mas_im_0_to_s0_r4_a2_im_ack || (! s0_cmul2_mas_im_0_to_s0_r4_a2_im_req));
  assign s0_cmul2_mas_im_0_to_s0_r4_byp2_im_req = (s0_cmul2_mas_im_0_m_req && (! s0_cmul2_mas_im_0_fork_ack_r_2));
  assign s0_cmul2_mas_im_0_fork_ack_s_2 = (s0_cmul2_mas_im_0_to_s0_r4_byp2_im_ack || (! s0_cmul2_mas_im_0_to_s0_r4_byp2_im_req));
  assign s0_cmul2_mas_im_0_m_ack = ((s0_cmul2_mas_im_0_fork_ack_s_0 && s0_cmul2_mas_im_0_fork_ack_s_1) && s0_cmul2_mas_im_0_fork_ack_s_2);
  assign s0_cmul3_recip_norm_0_ack = ((! s0_cmul3_recip_norm_0_eb_valid) || s0_cmul3_recip_norm_0_m_ack);
  assign s0_cmul3_recip_norm_0_eb_en = (s0_cmul3_recip_norm_0_req && s0_cmul3_recip_norm_0_ack);
  assign s0_cmul3_recip_norm_0_m_req = s0_cmul3_recip_norm_0_eb_valid;
  assign s0_cmul3_recip_norm_0 = s0_cmul3_recip_norm_0_eb_r;
  assign s0_cmul3_recip_norm_0_to_s0_cmul3_recip_mul_req = s0_cmul3_recip_norm_0_m_req;
  assign s0_cmul3_recip_norm_0_m_ack = s0_cmul3_recip_norm_0_to_s0_cmul3_recip_mul_ack;
  assign s0_cmul3_recip_mul_0_ack = ((! s0_cmul3_recip_mul_0_eb_valid) || s0_cmul3_recip_mul_0_m_ack);
  assign s0_cmul3_recip_mul_0_eb_en = (s0_cmul3_recip_mul_0_req && s0_cmul3_recip_mul_0_ack);
  assign s0_cmul3_recip_mul_0_m_req = s0_cmul3_recip_mul_0_eb_valid;
  assign s0_cmul3_recip_mul_0 = s0_cmul3_recip_mul_0_eb_r;
  assign s0_cmul3_recip_mul_0_to_s0_cmul3_recip_out_req = s0_cmul3_recip_mul_0_m_req;
  assign s0_cmul3_recip_mul_0_m_ack = s0_cmul3_recip_mul_0_to_s0_cmul3_recip_out_ack;
  assign s0_cmul3_recip_out_0_ack = ((! s0_cmul3_recip_out_0_eb_valid) || s0_cmul3_recip_out_0_m_ack);
  assign s0_cmul3_recip_out_0_eb_en = (s0_cmul3_recip_out_0_req && s0_cmul3_recip_out_0_ack);
  assign s0_cmul3_recip_out_0_m_req = s0_cmul3_recip_out_0_eb_valid;
  assign s0_cmul3_recip_out_0 = s0_cmul3_recip_out_0_eb_r;
  assign s0_cmul3_recip_out_0_to_s0_cmul3_m2c_ac_req = (s0_cmul3_recip_out_0_m_req && (! s0_cmul3_recip_out_0_fork_ack_r_0));
  assign s0_cmul3_recip_out_0_fork_ack_s_0 = (s0_cmul3_recip_out_0_to_s0_cmul3_m2c_ac_ack || (! s0_cmul3_recip_out_0_to_s0_cmul3_m2c_ac_req));
  assign s0_cmul3_recip_out_0_to_s0_cmul3_m2c_cd_req = (s0_cmul3_recip_out_0_m_req && (! s0_cmul3_recip_out_0_fork_ack_r_1));
  assign s0_cmul3_recip_out_0_fork_ack_s_1 = (s0_cmul3_recip_out_0_to_s0_cmul3_m2c_cd_ack || (! s0_cmul3_recip_out_0_to_s0_cmul3_m2c_cd_req));
  assign s0_cmul3_recip_out_0_m_ack = (s0_cmul3_recip_out_0_fork_ack_s_0 && s0_cmul3_recip_out_0_fork_ack_s_1);
  assign cfg_s0_cmul3_m2c_ac_m_req = cfg_s0_cmul3_m2c_ac_req;
  assign cfg_s0_cmul3_m2c_ac_ack = cfg_s0_cmul3_m2c_ac_m_ack;
  assign cfg_s0_cmul3_m2c_ac_to_s0_cmul3_m2c_ac_req = cfg_s0_cmul3_m2c_ac_m_req;
  assign cfg_s0_cmul3_m2c_ac_m_ack = cfg_s0_cmul3_m2c_ac_to_s0_cmul3_m2c_ac_ack;
  assign s0_cmul3_m2c_ac_0_m_req = s0_cmul3_m2c_ac_0_req;
  assign s0_cmul3_m2c_ac_0_ack = s0_cmul3_m2c_ac_0_m_ack;
  assign s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_req = s0_cmul3_m2c_ac_0_m_req;
  assign s0_cmul3_m2c_ac_0_m_ack = s0_cmul3_m2c_ac_0_to_s0_cmul3_cat_re_ack;
  assign cfg_s0_cmul3_m2c_bc_m_req = cfg_s0_cmul3_m2c_bc_req;
  assign cfg_s0_cmul3_m2c_bc_ack = cfg_s0_cmul3_m2c_bc_m_ack;
  assign cfg_s0_cmul3_m2c_bc_to_s0_cmul3_m2c_bc_req = cfg_s0_cmul3_m2c_bc_m_req;
  assign cfg_s0_cmul3_m2c_bc_m_ack = cfg_s0_cmul3_m2c_bc_to_s0_cmul3_m2c_bc_ack;
  assign s0_cmul3_m2c_bc_0_m_req = s0_cmul3_m2c_bc_0_req;
  assign s0_cmul3_m2c_bc_0_ack = s0_cmul3_m2c_bc_0_m_ack;
  assign s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_req = s0_cmul3_m2c_bc_0_m_req;
  assign s0_cmul3_m2c_bc_0_m_ack = s0_cmul3_m2c_bc_0_to_s0_cmul3_cat_re_ack;
  assign cfg_s0_cmul3_m2c_bd_m_req = cfg_s0_cmul3_m2c_bd_req;
  assign cfg_s0_cmul3_m2c_bd_ack = cfg_s0_cmul3_m2c_bd_m_ack;
  assign cfg_s0_cmul3_m2c_bd_to_s0_cmul3_m2c_bd_req = cfg_s0_cmul3_m2c_bd_m_req;
  assign cfg_s0_cmul3_m2c_bd_m_ack = cfg_s0_cmul3_m2c_bd_to_s0_cmul3_m2c_bd_ack;
  assign s0_cmul3_m2c_bd_0_m_req = s0_cmul3_m2c_bd_0_req;
  assign s0_cmul3_m2c_bd_0_ack = s0_cmul3_m2c_bd_0_m_ack;
  assign s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_req = s0_cmul3_m2c_bd_0_m_req;
  assign s0_cmul3_m2c_bd_0_m_ack = s0_cmul3_m2c_bd_0_to_s0_cmul3_cat_re_ack;
  assign cfg_s0_cmul3_m2c_cb_m_req = cfg_s0_cmul3_m2c_cb_req;
  assign cfg_s0_cmul3_m2c_cb_ack = cfg_s0_cmul3_m2c_cb_m_ack;
  assign cfg_s0_cmul3_m2c_cb_to_s0_cmul3_m2c_cb_req = cfg_s0_cmul3_m2c_cb_m_req;
  assign cfg_s0_cmul3_m2c_cb_m_ack = cfg_s0_cmul3_m2c_cb_to_s0_cmul3_m2c_cb_ack;
  assign s0_cmul3_m2c_cb_0_m_req = s0_cmul3_m2c_cb_0_req;
  assign s0_cmul3_m2c_cb_0_ack = s0_cmul3_m2c_cb_0_m_ack;
  assign s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_req = s0_cmul3_m2c_cb_0_m_req;
  assign s0_cmul3_m2c_cb_0_m_ack = s0_cmul3_m2c_cb_0_to_s0_cmul3_cat_im_ack;
  assign cfg_s0_cmul3_m2c_cd_m_req = cfg_s0_cmul3_m2c_cd_req;
  assign cfg_s0_cmul3_m2c_cd_ack = cfg_s0_cmul3_m2c_cd_m_ack;
  assign cfg_s0_cmul3_m2c_cd_to_s0_cmul3_m2c_cd_req = cfg_s0_cmul3_m2c_cd_m_req;
  assign cfg_s0_cmul3_m2c_cd_m_ack = cfg_s0_cmul3_m2c_cd_to_s0_cmul3_m2c_cd_ack;
  assign s0_cmul3_m2c_cd_0_m_req = s0_cmul3_m2c_cd_0_req;
  assign s0_cmul3_m2c_cd_0_ack = s0_cmul3_m2c_cd_0_m_ack;
  assign s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_req = s0_cmul3_m2c_cd_0_m_req;
  assign s0_cmul3_m2c_cd_0_m_ack = s0_cmul3_m2c_cd_0_to_s0_cmul3_cat_im_ack;
  assign cfg_s0_cmul3_m2c_da_m_req = cfg_s0_cmul3_m2c_da_req;
  assign cfg_s0_cmul3_m2c_da_ack = cfg_s0_cmul3_m2c_da_m_ack;
  assign cfg_s0_cmul3_m2c_da_to_s0_cmul3_m2c_da_req = cfg_s0_cmul3_m2c_da_m_req;
  assign cfg_s0_cmul3_m2c_da_m_ack = cfg_s0_cmul3_m2c_da_to_s0_cmul3_m2c_da_ack;
  assign s0_cmul3_m2c_da_0_m_req = s0_cmul3_m2c_da_0_req;
  assign s0_cmul3_m2c_da_0_ack = s0_cmul3_m2c_da_0_m_ack;
  assign s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_req = s0_cmul3_m2c_da_0_m_req;
  assign s0_cmul3_m2c_da_0_m_ack = s0_cmul3_m2c_da_0_to_s0_cmul3_cat_im_ack;
  always @(*) begin
    s0_cmul3_cat_re_0_eb_state_nxt = s0_cmul3_cat_re_0_eb_state;
    case(s0_cmul3_cat_re_0_eb_state)
      5'h14 : begin
        if(s0_cmul3_cat_re_0_req) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_cmul3_cat_re_0_req) && s0_cmul3_cat_re_0_m_ack)) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul3_cat_re_0_req && (! s0_cmul3_cat_re_0_m_ack))) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_cmul3_cat_re_0_req && s0_cmul3_cat_re_0_m_ack)) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_cmul3_cat_re_0_m_ack) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_cmul3_cat_re_0_req) && s0_cmul3_cat_re_0_m_ack)) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul3_cat_re_0_req && (! s0_cmul3_cat_re_0_m_ack))) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_cmul3_cat_re_0_req && s0_cmul3_cat_re_0_m_ack)) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_cmul3_cat_re_0_m_ack) begin
          s0_cmul3_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_cmul3_cat_re_0_eb_en0 = (s0_cmul3_cat_re_0_eb_state[2] && s0_cmul3_cat_re_0_req);
  assign s0_cmul3_cat_re_0_eb_en1 = (s0_cmul3_cat_re_0_eb_state[1] && s0_cmul3_cat_re_0_req);
  assign s0_cmul3_cat_re_0_eb_sel = s0_cmul3_cat_re_0_eb_state[0];
  assign s0_cmul3_cat_re_0_ack = s0_cmul3_cat_re_0_eb_state[4];
  assign s0_cmul3_cat_re_0_m_req = s0_cmul3_cat_re_0_eb_state[3];
  assign s0_cmul3_cat_re_0 = (s0_cmul3_cat_re_0_eb_sel ? s0_cmul3_cat_re_0_eb_r1 : s0_cmul3_cat_re_0_eb_r0);
  assign s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_req = s0_cmul3_cat_re_0_m_req;
  assign s0_cmul3_cat_re_0_m_ack = s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_ack;
  always @(*) begin
    s0_cmul3_cat_im_0_eb_state_nxt = s0_cmul3_cat_im_0_eb_state;
    case(s0_cmul3_cat_im_0_eb_state)
      5'h14 : begin
        if(s0_cmul3_cat_im_0_req) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_cmul3_cat_im_0_req) && s0_cmul3_cat_im_0_m_ack)) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul3_cat_im_0_req && (! s0_cmul3_cat_im_0_m_ack))) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_cmul3_cat_im_0_req && s0_cmul3_cat_im_0_m_ack)) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_cmul3_cat_im_0_m_ack) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_cmul3_cat_im_0_req) && s0_cmul3_cat_im_0_m_ack)) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_cmul3_cat_im_0_req && (! s0_cmul3_cat_im_0_m_ack))) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_cmul3_cat_im_0_req && s0_cmul3_cat_im_0_m_ack)) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_cmul3_cat_im_0_m_ack) begin
          s0_cmul3_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_cmul3_cat_im_0_eb_en0 = (s0_cmul3_cat_im_0_eb_state[2] && s0_cmul3_cat_im_0_req);
  assign s0_cmul3_cat_im_0_eb_en1 = (s0_cmul3_cat_im_0_eb_state[1] && s0_cmul3_cat_im_0_req);
  assign s0_cmul3_cat_im_0_eb_sel = s0_cmul3_cat_im_0_eb_state[0];
  assign s0_cmul3_cat_im_0_ack = s0_cmul3_cat_im_0_eb_state[4];
  assign s0_cmul3_cat_im_0_m_req = s0_cmul3_cat_im_0_eb_state[3];
  assign s0_cmul3_cat_im_0 = (s0_cmul3_cat_im_0_eb_sel ? s0_cmul3_cat_im_0_eb_r1 : s0_cmul3_cat_im_0_eb_r0);
  assign s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_req = s0_cmul3_cat_im_0_m_req;
  assign s0_cmul3_cat_im_0_m_ack = s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_ack;
  assign cfg_s0_cmul3_mas_re_m_req = cfg_s0_cmul3_mas_re_req;
  assign cfg_s0_cmul3_mas_re_ack = cfg_s0_cmul3_mas_re_m_ack;
  assign cfg_s0_cmul3_mas_re_to_s0_cmul3_mas_re_req = cfg_s0_cmul3_mas_re_m_req;
  assign cfg_s0_cmul3_mas_re_m_ack = cfg_s0_cmul3_mas_re_to_s0_cmul3_mas_re_ack;
  assign s0_cmul3_mas_re_0_m_req = s0_cmul3_mas_re_0_req;
  assign s0_cmul3_mas_re_0_ack = s0_cmul3_mas_re_0_m_ack;
  assign s0_cmul3_mas_re_0_to_s0_r4_a1_re_req = (s0_cmul3_mas_re_0_m_req && (! s0_cmul3_mas_re_0_fork_ack_r_0));
  assign s0_cmul3_mas_re_0_fork_ack_s_0 = (s0_cmul3_mas_re_0_to_s0_r4_a1_re_ack || (! s0_cmul3_mas_re_0_to_s0_r4_a1_re_req));
  assign s0_cmul3_mas_re_0_to_s0_r4_a3_re_req = (s0_cmul3_mas_re_0_m_req && (! s0_cmul3_mas_re_0_fork_ack_r_1));
  assign s0_cmul3_mas_re_0_fork_ack_s_1 = (s0_cmul3_mas_re_0_to_s0_r4_a3_re_ack || (! s0_cmul3_mas_re_0_to_s0_r4_a3_re_req));
  assign s0_cmul3_mas_re_0_to_s0_r4_byp3_re_req = (s0_cmul3_mas_re_0_m_req && (! s0_cmul3_mas_re_0_fork_ack_r_2));
  assign s0_cmul3_mas_re_0_fork_ack_s_2 = (s0_cmul3_mas_re_0_to_s0_r4_byp3_re_ack || (! s0_cmul3_mas_re_0_to_s0_r4_byp3_re_req));
  assign s0_cmul3_mas_re_0_m_ack = ((s0_cmul3_mas_re_0_fork_ack_s_0 && s0_cmul3_mas_re_0_fork_ack_s_1) && s0_cmul3_mas_re_0_fork_ack_s_2);
  assign cfg_s0_cmul3_mas_im_m_req = cfg_s0_cmul3_mas_im_req;
  assign cfg_s0_cmul3_mas_im_ack = cfg_s0_cmul3_mas_im_m_ack;
  assign cfg_s0_cmul3_mas_im_to_s0_cmul3_mas_im_req = cfg_s0_cmul3_mas_im_m_req;
  assign cfg_s0_cmul3_mas_im_m_ack = cfg_s0_cmul3_mas_im_to_s0_cmul3_mas_im_ack;
  assign s0_cmul3_mas_im_0_m_req = s0_cmul3_mas_im_0_req;
  assign s0_cmul3_mas_im_0_ack = s0_cmul3_mas_im_0_m_ack;
  assign s0_cmul3_mas_im_0_to_s0_r4_a1_im_req = (s0_cmul3_mas_im_0_m_req && (! s0_cmul3_mas_im_0_fork_ack_r_0));
  assign s0_cmul3_mas_im_0_fork_ack_s_0 = (s0_cmul3_mas_im_0_to_s0_r4_a1_im_ack || (! s0_cmul3_mas_im_0_to_s0_r4_a1_im_req));
  assign s0_cmul3_mas_im_0_to_s0_r4_a3_im_req = (s0_cmul3_mas_im_0_m_req && (! s0_cmul3_mas_im_0_fork_ack_r_1));
  assign s0_cmul3_mas_im_0_fork_ack_s_1 = (s0_cmul3_mas_im_0_to_s0_r4_a3_im_ack || (! s0_cmul3_mas_im_0_to_s0_r4_a3_im_req));
  assign s0_cmul3_mas_im_0_to_s0_r4_byp3_im_req = (s0_cmul3_mas_im_0_m_req && (! s0_cmul3_mas_im_0_fork_ack_r_2));
  assign s0_cmul3_mas_im_0_fork_ack_s_2 = (s0_cmul3_mas_im_0_to_s0_r4_byp3_im_ack || (! s0_cmul3_mas_im_0_to_s0_r4_byp3_im_req));
  assign s0_cmul3_mas_im_0_m_ack = ((s0_cmul3_mas_im_0_fork_ack_s_0 && s0_cmul3_mas_im_0_fork_ack_s_1) && s0_cmul3_mas_im_0_fork_ack_s_2);
  assign k8_funnel_1_ack = ((! k8_funnel_1_eb_valid) || k8_funnel_1_m_ack);
  assign k8_funnel_1_eb_en = (k8_funnel_1_req && k8_funnel_1_ack);
  assign k8_funnel_1_m_req = k8_funnel_1_eb_valid;
  assign k8_funnel_1 = k8_funnel_1_eb_r;
  assign k8_funnel_1_to_s1_k8_slice_req = k8_funnel_1_m_req;
  assign k8_funnel_1_m_ack = k8_funnel_1_to_s1_k8_slice_ack;
  assign k9_funnel_1_ack = ((! k9_funnel_1_eb_valid) || k9_funnel_1_m_ack);
  assign k9_funnel_1_eb_en = (k9_funnel_1_req && k9_funnel_1_ack);
  assign k9_funnel_1_m_req = k9_funnel_1_eb_valid;
  assign k9_funnel_1 = k9_funnel_1_eb_r;
  assign k9_funnel_1_to_s1_k9_slice_req = k9_funnel_1_m_req;
  assign k9_funnel_1_m_ack = k9_funnel_1_to_s1_k9_slice_ack;
  assign s1_k8_slice_0_m_req = s1_k8_slice_0_req;
  assign s1_k8_slice_0_ack = s1_k8_slice_0_m_ack;
  assign s1_k8_slice_0_to_s1_cmul0_m2c_ac_req = (s1_k8_slice_0_m_req && (! s1_k8_slice_0_fork_ack_r_0));
  assign s1_k8_slice_0_fork_ack_s_0 = (s1_k8_slice_0_to_s1_cmul0_m2c_ac_ack || (! s1_k8_slice_0_to_s1_cmul0_m2c_ac_req));
  assign s1_k8_slice_0_to_s1_cmul0_m2c_da_req = (s1_k8_slice_0_m_req && (! s1_k8_slice_0_fork_ack_r_1));
  assign s1_k8_slice_0_fork_ack_s_1 = (s1_k8_slice_0_to_s1_cmul0_m2c_da_ack || (! s1_k8_slice_0_to_s1_cmul0_m2c_da_req));
  assign s1_k8_slice_0_to_s1_cmul0_cat_re_req = (s1_k8_slice_0_m_req && (! s1_k8_slice_0_fork_ack_r_2));
  assign s1_k8_slice_0_fork_ack_s_2 = (s1_k8_slice_0_to_s1_cmul0_cat_re_ack || (! s1_k8_slice_0_to_s1_cmul0_cat_re_req));
  assign s1_k8_slice_0_m_ack = ((s1_k8_slice_0_fork_ack_s_0 && s1_k8_slice_0_fork_ack_s_1) && s1_k8_slice_0_fork_ack_s_2);
  assign s1_k8_slice_1_m_req = s1_k8_slice_1_req;
  assign s1_k8_slice_1_ack = s1_k8_slice_1_m_ack;
  assign s1_k8_slice_1_to_s1_cmul0_m2c_bc_req = (s1_k8_slice_1_m_req && (! s1_k8_slice_1_fork_ack_r_0));
  assign s1_k8_slice_1_fork_ack_s_0 = (s1_k8_slice_1_to_s1_cmul0_m2c_bc_ack || (! s1_k8_slice_1_to_s1_cmul0_m2c_bc_req));
  assign s1_k8_slice_1_to_s1_cmul0_m2c_bd_req = (s1_k8_slice_1_m_req && (! s1_k8_slice_1_fork_ack_r_1));
  assign s1_k8_slice_1_fork_ack_s_1 = (s1_k8_slice_1_to_s1_cmul0_m2c_bd_ack || (! s1_k8_slice_1_to_s1_cmul0_m2c_bd_req));
  assign s1_k8_slice_1_to_s1_cmul0_m2c_cb_req = (s1_k8_slice_1_m_req && (! s1_k8_slice_1_fork_ack_r_2));
  assign s1_k8_slice_1_fork_ack_s_2 = (s1_k8_slice_1_to_s1_cmul0_m2c_cb_ack || (! s1_k8_slice_1_to_s1_cmul0_m2c_cb_req));
  assign s1_k8_slice_1_m_ack = ((s1_k8_slice_1_fork_ack_s_0 && s1_k8_slice_1_fork_ack_s_1) && s1_k8_slice_1_fork_ack_s_2);
  assign s1_k9_slice_0_m_req = s1_k9_slice_0_req;
  assign s1_k9_slice_0_ack = s1_k9_slice_0_m_ack;
  assign s1_k9_slice_0_to_s1_cmul0_m2c_ac_req = (s1_k9_slice_0_m_req && (! s1_k9_slice_0_fork_ack_r_0));
  assign s1_k9_slice_0_fork_ack_s_0 = (s1_k9_slice_0_to_s1_cmul0_m2c_ac_ack || (! s1_k9_slice_0_to_s1_cmul0_m2c_ac_req));
  assign s1_k9_slice_0_to_s1_cmul0_m2c_bc_req = (s1_k9_slice_0_m_req && (! s1_k9_slice_0_fork_ack_r_1));
  assign s1_k9_slice_0_fork_ack_s_1 = (s1_k9_slice_0_to_s1_cmul0_m2c_bc_ack || (! s1_k9_slice_0_to_s1_cmul0_m2c_bc_req));
  assign s1_k9_slice_0_to_s1_cmul0_m2c_cb_req = (s1_k9_slice_0_m_req && (! s1_k9_slice_0_fork_ack_r_2));
  assign s1_k9_slice_0_fork_ack_s_2 = (s1_k9_slice_0_to_s1_cmul0_m2c_cb_ack || (! s1_k9_slice_0_to_s1_cmul0_m2c_cb_req));
  assign s1_k9_slice_0_to_s1_cmul0_m2c_cd_req = (s1_k9_slice_0_m_req && (! s1_k9_slice_0_fork_ack_r_3));
  assign s1_k9_slice_0_fork_ack_s_3 = (s1_k9_slice_0_to_s1_cmul0_m2c_cd_ack || (! s1_k9_slice_0_to_s1_cmul0_m2c_cd_req));
  assign s1_k9_slice_0_to_s1_cmul0_recip_norm_req = (s1_k9_slice_0_m_req && (! s1_k9_slice_0_fork_ack_r_4));
  assign s1_k9_slice_0_fork_ack_s_4 = (s1_k9_slice_0_to_s1_cmul0_recip_norm_ack || (! s1_k9_slice_0_to_s1_cmul0_recip_norm_req));
  assign s1_k9_slice_0_m_ack = ((((s1_k9_slice_0_fork_ack_s_0 && s1_k9_slice_0_fork_ack_s_1) && s1_k9_slice_0_fork_ack_s_2) && s1_k9_slice_0_fork_ack_s_3) && s1_k9_slice_0_fork_ack_s_4);
  assign s1_k9_slice_1_m_req = s1_k9_slice_1_req;
  assign s1_k9_slice_1_ack = s1_k9_slice_1_m_ack;
  assign s1_k9_slice_1_to_s1_cmul0_m2c_bd_req = (s1_k9_slice_1_m_req && (! s1_k9_slice_1_fork_ack_r_0));
  assign s1_k9_slice_1_fork_ack_s_0 = (s1_k9_slice_1_to_s1_cmul0_m2c_bd_ack || (! s1_k9_slice_1_to_s1_cmul0_m2c_bd_req));
  assign s1_k9_slice_1_to_s1_cmul0_m2c_cd_req = (s1_k9_slice_1_m_req && (! s1_k9_slice_1_fork_ack_r_1));
  assign s1_k9_slice_1_fork_ack_s_1 = (s1_k9_slice_1_to_s1_cmul0_m2c_cd_ack || (! s1_k9_slice_1_to_s1_cmul0_m2c_cd_req));
  assign s1_k9_slice_1_to_s1_cmul0_m2c_da_req = (s1_k9_slice_1_m_req && (! s1_k9_slice_1_fork_ack_r_2));
  assign s1_k9_slice_1_fork_ack_s_2 = (s1_k9_slice_1_to_s1_cmul0_m2c_da_ack || (! s1_k9_slice_1_to_s1_cmul0_m2c_da_req));
  assign s1_k9_slice_1_to_s1_cmul0_cat_im_req = (s1_k9_slice_1_m_req && (! s1_k9_slice_1_fork_ack_r_3));
  assign s1_k9_slice_1_fork_ack_s_3 = (s1_k9_slice_1_to_s1_cmul0_cat_im_ack || (! s1_k9_slice_1_to_s1_cmul0_cat_im_req));
  assign s1_k9_slice_1_m_ack = (((s1_k9_slice_1_fork_ack_s_0 && s1_k9_slice_1_fork_ack_s_1) && s1_k9_slice_1_fork_ack_s_2) && s1_k9_slice_1_fork_ack_s_3);
  assign s1_k8_slice_2_m_req = s1_k8_slice_2_req;
  assign s1_k8_slice_2_ack = s1_k8_slice_2_m_ack;
  assign s1_k8_slice_2_to_s1_cmul1_m2c_ac_req = (s1_k8_slice_2_m_req && (! s1_k8_slice_2_fork_ack_r_0));
  assign s1_k8_slice_2_fork_ack_s_0 = (s1_k8_slice_2_to_s1_cmul1_m2c_ac_ack || (! s1_k8_slice_2_to_s1_cmul1_m2c_ac_req));
  assign s1_k8_slice_2_to_s1_cmul1_m2c_da_req = (s1_k8_slice_2_m_req && (! s1_k8_slice_2_fork_ack_r_1));
  assign s1_k8_slice_2_fork_ack_s_1 = (s1_k8_slice_2_to_s1_cmul1_m2c_da_ack || (! s1_k8_slice_2_to_s1_cmul1_m2c_da_req));
  assign s1_k8_slice_2_to_s1_cmul1_cat_re_req = (s1_k8_slice_2_m_req && (! s1_k8_slice_2_fork_ack_r_2));
  assign s1_k8_slice_2_fork_ack_s_2 = (s1_k8_slice_2_to_s1_cmul1_cat_re_ack || (! s1_k8_slice_2_to_s1_cmul1_cat_re_req));
  assign s1_k8_slice_2_m_ack = ((s1_k8_slice_2_fork_ack_s_0 && s1_k8_slice_2_fork_ack_s_1) && s1_k8_slice_2_fork_ack_s_2);
  assign s1_k8_slice_3_m_req = s1_k8_slice_3_req;
  assign s1_k8_slice_3_ack = s1_k8_slice_3_m_ack;
  assign s1_k8_slice_3_to_s1_cmul1_m2c_bc_req = (s1_k8_slice_3_m_req && (! s1_k8_slice_3_fork_ack_r_0));
  assign s1_k8_slice_3_fork_ack_s_0 = (s1_k8_slice_3_to_s1_cmul1_m2c_bc_ack || (! s1_k8_slice_3_to_s1_cmul1_m2c_bc_req));
  assign s1_k8_slice_3_to_s1_cmul1_m2c_bd_req = (s1_k8_slice_3_m_req && (! s1_k8_slice_3_fork_ack_r_1));
  assign s1_k8_slice_3_fork_ack_s_1 = (s1_k8_slice_3_to_s1_cmul1_m2c_bd_ack || (! s1_k8_slice_3_to_s1_cmul1_m2c_bd_req));
  assign s1_k8_slice_3_to_s1_cmul1_m2c_cb_req = (s1_k8_slice_3_m_req && (! s1_k8_slice_3_fork_ack_r_2));
  assign s1_k8_slice_3_fork_ack_s_2 = (s1_k8_slice_3_to_s1_cmul1_m2c_cb_ack || (! s1_k8_slice_3_to_s1_cmul1_m2c_cb_req));
  assign s1_k8_slice_3_m_ack = ((s1_k8_slice_3_fork_ack_s_0 && s1_k8_slice_3_fork_ack_s_1) && s1_k8_slice_3_fork_ack_s_2);
  assign s1_k9_slice_2_m_req = s1_k9_slice_2_req;
  assign s1_k9_slice_2_ack = s1_k9_slice_2_m_ack;
  assign s1_k9_slice_2_to_s1_cmul1_m2c_ac_req = (s1_k9_slice_2_m_req && (! s1_k9_slice_2_fork_ack_r_0));
  assign s1_k9_slice_2_fork_ack_s_0 = (s1_k9_slice_2_to_s1_cmul1_m2c_ac_ack || (! s1_k9_slice_2_to_s1_cmul1_m2c_ac_req));
  assign s1_k9_slice_2_to_s1_cmul1_m2c_bc_req = (s1_k9_slice_2_m_req && (! s1_k9_slice_2_fork_ack_r_1));
  assign s1_k9_slice_2_fork_ack_s_1 = (s1_k9_slice_2_to_s1_cmul1_m2c_bc_ack || (! s1_k9_slice_2_to_s1_cmul1_m2c_bc_req));
  assign s1_k9_slice_2_to_s1_cmul1_m2c_cb_req = (s1_k9_slice_2_m_req && (! s1_k9_slice_2_fork_ack_r_2));
  assign s1_k9_slice_2_fork_ack_s_2 = (s1_k9_slice_2_to_s1_cmul1_m2c_cb_ack || (! s1_k9_slice_2_to_s1_cmul1_m2c_cb_req));
  assign s1_k9_slice_2_to_s1_cmul1_m2c_cd_req = (s1_k9_slice_2_m_req && (! s1_k9_slice_2_fork_ack_r_3));
  assign s1_k9_slice_2_fork_ack_s_3 = (s1_k9_slice_2_to_s1_cmul1_m2c_cd_ack || (! s1_k9_slice_2_to_s1_cmul1_m2c_cd_req));
  assign s1_k9_slice_2_to_s1_cmul1_recip_norm_req = (s1_k9_slice_2_m_req && (! s1_k9_slice_2_fork_ack_r_4));
  assign s1_k9_slice_2_fork_ack_s_4 = (s1_k9_slice_2_to_s1_cmul1_recip_norm_ack || (! s1_k9_slice_2_to_s1_cmul1_recip_norm_req));
  assign s1_k9_slice_2_m_ack = ((((s1_k9_slice_2_fork_ack_s_0 && s1_k9_slice_2_fork_ack_s_1) && s1_k9_slice_2_fork_ack_s_2) && s1_k9_slice_2_fork_ack_s_3) && s1_k9_slice_2_fork_ack_s_4);
  assign s1_k9_slice_3_m_req = s1_k9_slice_3_req;
  assign s1_k9_slice_3_ack = s1_k9_slice_3_m_ack;
  assign s1_k9_slice_3_to_s1_cmul1_m2c_bd_req = (s1_k9_slice_3_m_req && (! s1_k9_slice_3_fork_ack_r_0));
  assign s1_k9_slice_3_fork_ack_s_0 = (s1_k9_slice_3_to_s1_cmul1_m2c_bd_ack || (! s1_k9_slice_3_to_s1_cmul1_m2c_bd_req));
  assign s1_k9_slice_3_to_s1_cmul1_m2c_cd_req = (s1_k9_slice_3_m_req && (! s1_k9_slice_3_fork_ack_r_1));
  assign s1_k9_slice_3_fork_ack_s_1 = (s1_k9_slice_3_to_s1_cmul1_m2c_cd_ack || (! s1_k9_slice_3_to_s1_cmul1_m2c_cd_req));
  assign s1_k9_slice_3_to_s1_cmul1_m2c_da_req = (s1_k9_slice_3_m_req && (! s1_k9_slice_3_fork_ack_r_2));
  assign s1_k9_slice_3_fork_ack_s_2 = (s1_k9_slice_3_to_s1_cmul1_m2c_da_ack || (! s1_k9_slice_3_to_s1_cmul1_m2c_da_req));
  assign s1_k9_slice_3_to_s1_cmul1_cat_im_req = (s1_k9_slice_3_m_req && (! s1_k9_slice_3_fork_ack_r_3));
  assign s1_k9_slice_3_fork_ack_s_3 = (s1_k9_slice_3_to_s1_cmul1_cat_im_ack || (! s1_k9_slice_3_to_s1_cmul1_cat_im_req));
  assign s1_k9_slice_3_m_ack = (((s1_k9_slice_3_fork_ack_s_0 && s1_k9_slice_3_fork_ack_s_1) && s1_k9_slice_3_fork_ack_s_2) && s1_k9_slice_3_fork_ack_s_3);
  assign s1_k8_slice_4_m_req = s1_k8_slice_4_req;
  assign s1_k8_slice_4_ack = s1_k8_slice_4_m_ack;
  assign s1_k8_slice_4_to_s1_cmul2_m2c_ac_req = (s1_k8_slice_4_m_req && (! s1_k8_slice_4_fork_ack_r_0));
  assign s1_k8_slice_4_fork_ack_s_0 = (s1_k8_slice_4_to_s1_cmul2_m2c_ac_ack || (! s1_k8_slice_4_to_s1_cmul2_m2c_ac_req));
  assign s1_k8_slice_4_to_s1_cmul2_m2c_da_req = (s1_k8_slice_4_m_req && (! s1_k8_slice_4_fork_ack_r_1));
  assign s1_k8_slice_4_fork_ack_s_1 = (s1_k8_slice_4_to_s1_cmul2_m2c_da_ack || (! s1_k8_slice_4_to_s1_cmul2_m2c_da_req));
  assign s1_k8_slice_4_to_s1_cmul2_cat_re_req = (s1_k8_slice_4_m_req && (! s1_k8_slice_4_fork_ack_r_2));
  assign s1_k8_slice_4_fork_ack_s_2 = (s1_k8_slice_4_to_s1_cmul2_cat_re_ack || (! s1_k8_slice_4_to_s1_cmul2_cat_re_req));
  assign s1_k8_slice_4_m_ack = ((s1_k8_slice_4_fork_ack_s_0 && s1_k8_slice_4_fork_ack_s_1) && s1_k8_slice_4_fork_ack_s_2);
  assign s1_k8_slice_5_m_req = s1_k8_slice_5_req;
  assign s1_k8_slice_5_ack = s1_k8_slice_5_m_ack;
  assign s1_k8_slice_5_to_s1_cmul2_m2c_bc_req = (s1_k8_slice_5_m_req && (! s1_k8_slice_5_fork_ack_r_0));
  assign s1_k8_slice_5_fork_ack_s_0 = (s1_k8_slice_5_to_s1_cmul2_m2c_bc_ack || (! s1_k8_slice_5_to_s1_cmul2_m2c_bc_req));
  assign s1_k8_slice_5_to_s1_cmul2_m2c_bd_req = (s1_k8_slice_5_m_req && (! s1_k8_slice_5_fork_ack_r_1));
  assign s1_k8_slice_5_fork_ack_s_1 = (s1_k8_slice_5_to_s1_cmul2_m2c_bd_ack || (! s1_k8_slice_5_to_s1_cmul2_m2c_bd_req));
  assign s1_k8_slice_5_to_s1_cmul2_m2c_cb_req = (s1_k8_slice_5_m_req && (! s1_k8_slice_5_fork_ack_r_2));
  assign s1_k8_slice_5_fork_ack_s_2 = (s1_k8_slice_5_to_s1_cmul2_m2c_cb_ack || (! s1_k8_slice_5_to_s1_cmul2_m2c_cb_req));
  assign s1_k8_slice_5_m_ack = ((s1_k8_slice_5_fork_ack_s_0 && s1_k8_slice_5_fork_ack_s_1) && s1_k8_slice_5_fork_ack_s_2);
  assign s1_k9_slice_4_m_req = s1_k9_slice_4_req;
  assign s1_k9_slice_4_ack = s1_k9_slice_4_m_ack;
  assign s1_k9_slice_4_to_s1_cmul2_m2c_ac_req = (s1_k9_slice_4_m_req && (! s1_k9_slice_4_fork_ack_r_0));
  assign s1_k9_slice_4_fork_ack_s_0 = (s1_k9_slice_4_to_s1_cmul2_m2c_ac_ack || (! s1_k9_slice_4_to_s1_cmul2_m2c_ac_req));
  assign s1_k9_slice_4_to_s1_cmul2_m2c_bc_req = (s1_k9_slice_4_m_req && (! s1_k9_slice_4_fork_ack_r_1));
  assign s1_k9_slice_4_fork_ack_s_1 = (s1_k9_slice_4_to_s1_cmul2_m2c_bc_ack || (! s1_k9_slice_4_to_s1_cmul2_m2c_bc_req));
  assign s1_k9_slice_4_to_s1_cmul2_m2c_cb_req = (s1_k9_slice_4_m_req && (! s1_k9_slice_4_fork_ack_r_2));
  assign s1_k9_slice_4_fork_ack_s_2 = (s1_k9_slice_4_to_s1_cmul2_m2c_cb_ack || (! s1_k9_slice_4_to_s1_cmul2_m2c_cb_req));
  assign s1_k9_slice_4_to_s1_cmul2_m2c_cd_req = (s1_k9_slice_4_m_req && (! s1_k9_slice_4_fork_ack_r_3));
  assign s1_k9_slice_4_fork_ack_s_3 = (s1_k9_slice_4_to_s1_cmul2_m2c_cd_ack || (! s1_k9_slice_4_to_s1_cmul2_m2c_cd_req));
  assign s1_k9_slice_4_to_s1_cmul2_recip_norm_req = (s1_k9_slice_4_m_req && (! s1_k9_slice_4_fork_ack_r_4));
  assign s1_k9_slice_4_fork_ack_s_4 = (s1_k9_slice_4_to_s1_cmul2_recip_norm_ack || (! s1_k9_slice_4_to_s1_cmul2_recip_norm_req));
  assign s1_k9_slice_4_m_ack = ((((s1_k9_slice_4_fork_ack_s_0 && s1_k9_slice_4_fork_ack_s_1) && s1_k9_slice_4_fork_ack_s_2) && s1_k9_slice_4_fork_ack_s_3) && s1_k9_slice_4_fork_ack_s_4);
  assign s1_k9_slice_5_m_req = s1_k9_slice_5_req;
  assign s1_k9_slice_5_ack = s1_k9_slice_5_m_ack;
  assign s1_k9_slice_5_to_s1_cmul2_m2c_bd_req = (s1_k9_slice_5_m_req && (! s1_k9_slice_5_fork_ack_r_0));
  assign s1_k9_slice_5_fork_ack_s_0 = (s1_k9_slice_5_to_s1_cmul2_m2c_bd_ack || (! s1_k9_slice_5_to_s1_cmul2_m2c_bd_req));
  assign s1_k9_slice_5_to_s1_cmul2_m2c_cd_req = (s1_k9_slice_5_m_req && (! s1_k9_slice_5_fork_ack_r_1));
  assign s1_k9_slice_5_fork_ack_s_1 = (s1_k9_slice_5_to_s1_cmul2_m2c_cd_ack || (! s1_k9_slice_5_to_s1_cmul2_m2c_cd_req));
  assign s1_k9_slice_5_to_s1_cmul2_m2c_da_req = (s1_k9_slice_5_m_req && (! s1_k9_slice_5_fork_ack_r_2));
  assign s1_k9_slice_5_fork_ack_s_2 = (s1_k9_slice_5_to_s1_cmul2_m2c_da_ack || (! s1_k9_slice_5_to_s1_cmul2_m2c_da_req));
  assign s1_k9_slice_5_to_s1_cmul2_cat_im_req = (s1_k9_slice_5_m_req && (! s1_k9_slice_5_fork_ack_r_3));
  assign s1_k9_slice_5_fork_ack_s_3 = (s1_k9_slice_5_to_s1_cmul2_cat_im_ack || (! s1_k9_slice_5_to_s1_cmul2_cat_im_req));
  assign s1_k9_slice_5_m_ack = (((s1_k9_slice_5_fork_ack_s_0 && s1_k9_slice_5_fork_ack_s_1) && s1_k9_slice_5_fork_ack_s_2) && s1_k9_slice_5_fork_ack_s_3);
  assign s1_k8_slice_6_m_req = s1_k8_slice_6_req;
  assign s1_k8_slice_6_ack = s1_k8_slice_6_m_ack;
  assign s1_k8_slice_6_to_s1_cmul3_m2c_ac_req = (s1_k8_slice_6_m_req && (! s1_k8_slice_6_fork_ack_r_0));
  assign s1_k8_slice_6_fork_ack_s_0 = (s1_k8_slice_6_to_s1_cmul3_m2c_ac_ack || (! s1_k8_slice_6_to_s1_cmul3_m2c_ac_req));
  assign s1_k8_slice_6_to_s1_cmul3_m2c_da_req = (s1_k8_slice_6_m_req && (! s1_k8_slice_6_fork_ack_r_1));
  assign s1_k8_slice_6_fork_ack_s_1 = (s1_k8_slice_6_to_s1_cmul3_m2c_da_ack || (! s1_k8_slice_6_to_s1_cmul3_m2c_da_req));
  assign s1_k8_slice_6_to_s1_cmul3_cat_re_req = (s1_k8_slice_6_m_req && (! s1_k8_slice_6_fork_ack_r_2));
  assign s1_k8_slice_6_fork_ack_s_2 = (s1_k8_slice_6_to_s1_cmul3_cat_re_ack || (! s1_k8_slice_6_to_s1_cmul3_cat_re_req));
  assign s1_k8_slice_6_m_ack = ((s1_k8_slice_6_fork_ack_s_0 && s1_k8_slice_6_fork_ack_s_1) && s1_k8_slice_6_fork_ack_s_2);
  assign s1_k8_slice_7_m_req = s1_k8_slice_7_req;
  assign s1_k8_slice_7_ack = s1_k8_slice_7_m_ack;
  assign s1_k8_slice_7_to_s1_cmul3_m2c_bc_req = (s1_k8_slice_7_m_req && (! s1_k8_slice_7_fork_ack_r_0));
  assign s1_k8_slice_7_fork_ack_s_0 = (s1_k8_slice_7_to_s1_cmul3_m2c_bc_ack || (! s1_k8_slice_7_to_s1_cmul3_m2c_bc_req));
  assign s1_k8_slice_7_to_s1_cmul3_m2c_bd_req = (s1_k8_slice_7_m_req && (! s1_k8_slice_7_fork_ack_r_1));
  assign s1_k8_slice_7_fork_ack_s_1 = (s1_k8_slice_7_to_s1_cmul3_m2c_bd_ack || (! s1_k8_slice_7_to_s1_cmul3_m2c_bd_req));
  assign s1_k8_slice_7_to_s1_cmul3_m2c_cb_req = (s1_k8_slice_7_m_req && (! s1_k8_slice_7_fork_ack_r_2));
  assign s1_k8_slice_7_fork_ack_s_2 = (s1_k8_slice_7_to_s1_cmul3_m2c_cb_ack || (! s1_k8_slice_7_to_s1_cmul3_m2c_cb_req));
  assign s1_k8_slice_7_m_ack = ((s1_k8_slice_7_fork_ack_s_0 && s1_k8_slice_7_fork_ack_s_1) && s1_k8_slice_7_fork_ack_s_2);
  assign s1_k9_slice_6_m_req = s1_k9_slice_6_req;
  assign s1_k9_slice_6_ack = s1_k9_slice_6_m_ack;
  assign s1_k9_slice_6_to_s1_cmul3_m2c_ac_req = (s1_k9_slice_6_m_req && (! s1_k9_slice_6_fork_ack_r_0));
  assign s1_k9_slice_6_fork_ack_s_0 = (s1_k9_slice_6_to_s1_cmul3_m2c_ac_ack || (! s1_k9_slice_6_to_s1_cmul3_m2c_ac_req));
  assign s1_k9_slice_6_to_s1_cmul3_m2c_bc_req = (s1_k9_slice_6_m_req && (! s1_k9_slice_6_fork_ack_r_1));
  assign s1_k9_slice_6_fork_ack_s_1 = (s1_k9_slice_6_to_s1_cmul3_m2c_bc_ack || (! s1_k9_slice_6_to_s1_cmul3_m2c_bc_req));
  assign s1_k9_slice_6_to_s1_cmul3_m2c_cb_req = (s1_k9_slice_6_m_req && (! s1_k9_slice_6_fork_ack_r_2));
  assign s1_k9_slice_6_fork_ack_s_2 = (s1_k9_slice_6_to_s1_cmul3_m2c_cb_ack || (! s1_k9_slice_6_to_s1_cmul3_m2c_cb_req));
  assign s1_k9_slice_6_to_s1_cmul3_m2c_cd_req = (s1_k9_slice_6_m_req && (! s1_k9_slice_6_fork_ack_r_3));
  assign s1_k9_slice_6_fork_ack_s_3 = (s1_k9_slice_6_to_s1_cmul3_m2c_cd_ack || (! s1_k9_slice_6_to_s1_cmul3_m2c_cd_req));
  assign s1_k9_slice_6_to_s1_cmul3_recip_norm_req = (s1_k9_slice_6_m_req && (! s1_k9_slice_6_fork_ack_r_4));
  assign s1_k9_slice_6_fork_ack_s_4 = (s1_k9_slice_6_to_s1_cmul3_recip_norm_ack || (! s1_k9_slice_6_to_s1_cmul3_recip_norm_req));
  assign s1_k9_slice_6_m_ack = ((((s1_k9_slice_6_fork_ack_s_0 && s1_k9_slice_6_fork_ack_s_1) && s1_k9_slice_6_fork_ack_s_2) && s1_k9_slice_6_fork_ack_s_3) && s1_k9_slice_6_fork_ack_s_4);
  assign s1_k9_slice_7_m_req = s1_k9_slice_7_req;
  assign s1_k9_slice_7_ack = s1_k9_slice_7_m_ack;
  assign s1_k9_slice_7_to_s1_cmul3_m2c_bd_req = (s1_k9_slice_7_m_req && (! s1_k9_slice_7_fork_ack_r_0));
  assign s1_k9_slice_7_fork_ack_s_0 = (s1_k9_slice_7_to_s1_cmul3_m2c_bd_ack || (! s1_k9_slice_7_to_s1_cmul3_m2c_bd_req));
  assign s1_k9_slice_7_to_s1_cmul3_m2c_cd_req = (s1_k9_slice_7_m_req && (! s1_k9_slice_7_fork_ack_r_1));
  assign s1_k9_slice_7_fork_ack_s_1 = (s1_k9_slice_7_to_s1_cmul3_m2c_cd_ack || (! s1_k9_slice_7_to_s1_cmul3_m2c_cd_req));
  assign s1_k9_slice_7_to_s1_cmul3_m2c_da_req = (s1_k9_slice_7_m_req && (! s1_k9_slice_7_fork_ack_r_2));
  assign s1_k9_slice_7_fork_ack_s_2 = (s1_k9_slice_7_to_s1_cmul3_m2c_da_ack || (! s1_k9_slice_7_to_s1_cmul3_m2c_da_req));
  assign s1_k9_slice_7_to_s1_cmul3_cat_im_req = (s1_k9_slice_7_m_req && (! s1_k9_slice_7_fork_ack_r_3));
  assign s1_k9_slice_7_fork_ack_s_3 = (s1_k9_slice_7_to_s1_cmul3_cat_im_ack || (! s1_k9_slice_7_to_s1_cmul3_cat_im_req));
  assign s1_k9_slice_7_m_ack = (((s1_k9_slice_7_fork_ack_s_0 && s1_k9_slice_7_fork_ack_s_1) && s1_k9_slice_7_fork_ack_s_2) && s1_k9_slice_7_fork_ack_s_3);
  assign s1_cmul0_recip_norm_0_ack = ((! s1_cmul0_recip_norm_0_eb_valid) || s1_cmul0_recip_norm_0_m_ack);
  assign s1_cmul0_recip_norm_0_eb_en = (s1_cmul0_recip_norm_0_req && s1_cmul0_recip_norm_0_ack);
  assign s1_cmul0_recip_norm_0_m_req = s1_cmul0_recip_norm_0_eb_valid;
  assign s1_cmul0_recip_norm_0 = s1_cmul0_recip_norm_0_eb_r;
  assign s1_cmul0_recip_norm_0_to_s1_cmul0_recip_mul_req = s1_cmul0_recip_norm_0_m_req;
  assign s1_cmul0_recip_norm_0_m_ack = s1_cmul0_recip_norm_0_to_s1_cmul0_recip_mul_ack;
  assign s1_cmul0_recip_mul_0_ack = ((! s1_cmul0_recip_mul_0_eb_valid) || s1_cmul0_recip_mul_0_m_ack);
  assign s1_cmul0_recip_mul_0_eb_en = (s1_cmul0_recip_mul_0_req && s1_cmul0_recip_mul_0_ack);
  assign s1_cmul0_recip_mul_0_m_req = s1_cmul0_recip_mul_0_eb_valid;
  assign s1_cmul0_recip_mul_0 = s1_cmul0_recip_mul_0_eb_r;
  assign s1_cmul0_recip_mul_0_to_s1_cmul0_recip_out_req = s1_cmul0_recip_mul_0_m_req;
  assign s1_cmul0_recip_mul_0_m_ack = s1_cmul0_recip_mul_0_to_s1_cmul0_recip_out_ack;
  assign s1_cmul0_recip_out_0_ack = ((! s1_cmul0_recip_out_0_eb_valid) || s1_cmul0_recip_out_0_m_ack);
  assign s1_cmul0_recip_out_0_eb_en = (s1_cmul0_recip_out_0_req && s1_cmul0_recip_out_0_ack);
  assign s1_cmul0_recip_out_0_m_req = s1_cmul0_recip_out_0_eb_valid;
  assign s1_cmul0_recip_out_0 = s1_cmul0_recip_out_0_eb_r;
  assign s1_cmul0_recip_out_0_to_s1_cmul0_m2c_ac_req = (s1_cmul0_recip_out_0_m_req && (! s1_cmul0_recip_out_0_fork_ack_r_0));
  assign s1_cmul0_recip_out_0_fork_ack_s_0 = (s1_cmul0_recip_out_0_to_s1_cmul0_m2c_ac_ack || (! s1_cmul0_recip_out_0_to_s1_cmul0_m2c_ac_req));
  assign s1_cmul0_recip_out_0_to_s1_cmul0_m2c_cd_req = (s1_cmul0_recip_out_0_m_req && (! s1_cmul0_recip_out_0_fork_ack_r_1));
  assign s1_cmul0_recip_out_0_fork_ack_s_1 = (s1_cmul0_recip_out_0_to_s1_cmul0_m2c_cd_ack || (! s1_cmul0_recip_out_0_to_s1_cmul0_m2c_cd_req));
  assign s1_cmul0_recip_out_0_m_ack = (s1_cmul0_recip_out_0_fork_ack_s_0 && s1_cmul0_recip_out_0_fork_ack_s_1);
  assign cfg_s1_cmul0_m2c_ac_m_req = cfg_s1_cmul0_m2c_ac_req;
  assign cfg_s1_cmul0_m2c_ac_ack = cfg_s1_cmul0_m2c_ac_m_ack;
  assign cfg_s1_cmul0_m2c_ac_to_s1_cmul0_m2c_ac_req = cfg_s1_cmul0_m2c_ac_m_req;
  assign cfg_s1_cmul0_m2c_ac_m_ack = cfg_s1_cmul0_m2c_ac_to_s1_cmul0_m2c_ac_ack;
  assign s1_cmul0_m2c_ac_0_m_req = s1_cmul0_m2c_ac_0_req;
  assign s1_cmul0_m2c_ac_0_ack = s1_cmul0_m2c_ac_0_m_ack;
  assign s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_req = s1_cmul0_m2c_ac_0_m_req;
  assign s1_cmul0_m2c_ac_0_m_ack = s1_cmul0_m2c_ac_0_to_s1_cmul0_cat_re_ack;
  assign cfg_s1_cmul0_m2c_bc_m_req = cfg_s1_cmul0_m2c_bc_req;
  assign cfg_s1_cmul0_m2c_bc_ack = cfg_s1_cmul0_m2c_bc_m_ack;
  assign cfg_s1_cmul0_m2c_bc_to_s1_cmul0_m2c_bc_req = cfg_s1_cmul0_m2c_bc_m_req;
  assign cfg_s1_cmul0_m2c_bc_m_ack = cfg_s1_cmul0_m2c_bc_to_s1_cmul0_m2c_bc_ack;
  assign s1_cmul0_m2c_bc_0_m_req = s1_cmul0_m2c_bc_0_req;
  assign s1_cmul0_m2c_bc_0_ack = s1_cmul0_m2c_bc_0_m_ack;
  assign s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_req = s1_cmul0_m2c_bc_0_m_req;
  assign s1_cmul0_m2c_bc_0_m_ack = s1_cmul0_m2c_bc_0_to_s1_cmul0_cat_re_ack;
  assign cfg_s1_cmul0_m2c_bd_m_req = cfg_s1_cmul0_m2c_bd_req;
  assign cfg_s1_cmul0_m2c_bd_ack = cfg_s1_cmul0_m2c_bd_m_ack;
  assign cfg_s1_cmul0_m2c_bd_to_s1_cmul0_m2c_bd_req = cfg_s1_cmul0_m2c_bd_m_req;
  assign cfg_s1_cmul0_m2c_bd_m_ack = cfg_s1_cmul0_m2c_bd_to_s1_cmul0_m2c_bd_ack;
  assign s1_cmul0_m2c_bd_0_m_req = s1_cmul0_m2c_bd_0_req;
  assign s1_cmul0_m2c_bd_0_ack = s1_cmul0_m2c_bd_0_m_ack;
  assign s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_req = s1_cmul0_m2c_bd_0_m_req;
  assign s1_cmul0_m2c_bd_0_m_ack = s1_cmul0_m2c_bd_0_to_s1_cmul0_cat_re_ack;
  assign cfg_s1_cmul0_m2c_cb_m_req = cfg_s1_cmul0_m2c_cb_req;
  assign cfg_s1_cmul0_m2c_cb_ack = cfg_s1_cmul0_m2c_cb_m_ack;
  assign cfg_s1_cmul0_m2c_cb_to_s1_cmul0_m2c_cb_req = cfg_s1_cmul0_m2c_cb_m_req;
  assign cfg_s1_cmul0_m2c_cb_m_ack = cfg_s1_cmul0_m2c_cb_to_s1_cmul0_m2c_cb_ack;
  assign s1_cmul0_m2c_cb_0_m_req = s1_cmul0_m2c_cb_0_req;
  assign s1_cmul0_m2c_cb_0_ack = s1_cmul0_m2c_cb_0_m_ack;
  assign s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_req = s1_cmul0_m2c_cb_0_m_req;
  assign s1_cmul0_m2c_cb_0_m_ack = s1_cmul0_m2c_cb_0_to_s1_cmul0_cat_im_ack;
  assign cfg_s1_cmul0_m2c_cd_m_req = cfg_s1_cmul0_m2c_cd_req;
  assign cfg_s1_cmul0_m2c_cd_ack = cfg_s1_cmul0_m2c_cd_m_ack;
  assign cfg_s1_cmul0_m2c_cd_to_s1_cmul0_m2c_cd_req = cfg_s1_cmul0_m2c_cd_m_req;
  assign cfg_s1_cmul0_m2c_cd_m_ack = cfg_s1_cmul0_m2c_cd_to_s1_cmul0_m2c_cd_ack;
  assign s1_cmul0_m2c_cd_0_m_req = s1_cmul0_m2c_cd_0_req;
  assign s1_cmul0_m2c_cd_0_ack = s1_cmul0_m2c_cd_0_m_ack;
  assign s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_req = s1_cmul0_m2c_cd_0_m_req;
  assign s1_cmul0_m2c_cd_0_m_ack = s1_cmul0_m2c_cd_0_to_s1_cmul0_cat_im_ack;
  assign cfg_s1_cmul0_m2c_da_m_req = cfg_s1_cmul0_m2c_da_req;
  assign cfg_s1_cmul0_m2c_da_ack = cfg_s1_cmul0_m2c_da_m_ack;
  assign cfg_s1_cmul0_m2c_da_to_s1_cmul0_m2c_da_req = cfg_s1_cmul0_m2c_da_m_req;
  assign cfg_s1_cmul0_m2c_da_m_ack = cfg_s1_cmul0_m2c_da_to_s1_cmul0_m2c_da_ack;
  assign s1_cmul0_m2c_da_0_m_req = s1_cmul0_m2c_da_0_req;
  assign s1_cmul0_m2c_da_0_ack = s1_cmul0_m2c_da_0_m_ack;
  assign s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_req = s1_cmul0_m2c_da_0_m_req;
  assign s1_cmul0_m2c_da_0_m_ack = s1_cmul0_m2c_da_0_to_s1_cmul0_cat_im_ack;
  always @(*) begin
    s1_cmul0_cat_re_0_eb_state_nxt = s1_cmul0_cat_re_0_eb_state;
    case(s1_cmul0_cat_re_0_eb_state)
      5'h14 : begin
        if(s1_cmul0_cat_re_0_req) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_cmul0_cat_re_0_req) && s1_cmul0_cat_re_0_m_ack)) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul0_cat_re_0_req && (! s1_cmul0_cat_re_0_m_ack))) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_cmul0_cat_re_0_req && s1_cmul0_cat_re_0_m_ack)) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_cmul0_cat_re_0_m_ack) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_cmul0_cat_re_0_req) && s1_cmul0_cat_re_0_m_ack)) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul0_cat_re_0_req && (! s1_cmul0_cat_re_0_m_ack))) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_cmul0_cat_re_0_req && s1_cmul0_cat_re_0_m_ack)) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_cmul0_cat_re_0_m_ack) begin
          s1_cmul0_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_cmul0_cat_re_0_eb_en0 = (s1_cmul0_cat_re_0_eb_state[2] && s1_cmul0_cat_re_0_req);
  assign s1_cmul0_cat_re_0_eb_en1 = (s1_cmul0_cat_re_0_eb_state[1] && s1_cmul0_cat_re_0_req);
  assign s1_cmul0_cat_re_0_eb_sel = s1_cmul0_cat_re_0_eb_state[0];
  assign s1_cmul0_cat_re_0_ack = s1_cmul0_cat_re_0_eb_state[4];
  assign s1_cmul0_cat_re_0_m_req = s1_cmul0_cat_re_0_eb_state[3];
  assign s1_cmul0_cat_re_0 = (s1_cmul0_cat_re_0_eb_sel ? s1_cmul0_cat_re_0_eb_r1 : s1_cmul0_cat_re_0_eb_r0);
  assign s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_req = s1_cmul0_cat_re_0_m_req;
  assign s1_cmul0_cat_re_0_m_ack = s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_ack;
  always @(*) begin
    s1_cmul0_cat_im_0_eb_state_nxt = s1_cmul0_cat_im_0_eb_state;
    case(s1_cmul0_cat_im_0_eb_state)
      5'h14 : begin
        if(s1_cmul0_cat_im_0_req) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_cmul0_cat_im_0_req) && s1_cmul0_cat_im_0_m_ack)) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul0_cat_im_0_req && (! s1_cmul0_cat_im_0_m_ack))) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_cmul0_cat_im_0_req && s1_cmul0_cat_im_0_m_ack)) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_cmul0_cat_im_0_m_ack) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_cmul0_cat_im_0_req) && s1_cmul0_cat_im_0_m_ack)) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul0_cat_im_0_req && (! s1_cmul0_cat_im_0_m_ack))) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_cmul0_cat_im_0_req && s1_cmul0_cat_im_0_m_ack)) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_cmul0_cat_im_0_m_ack) begin
          s1_cmul0_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_cmul0_cat_im_0_eb_en0 = (s1_cmul0_cat_im_0_eb_state[2] && s1_cmul0_cat_im_0_req);
  assign s1_cmul0_cat_im_0_eb_en1 = (s1_cmul0_cat_im_0_eb_state[1] && s1_cmul0_cat_im_0_req);
  assign s1_cmul0_cat_im_0_eb_sel = s1_cmul0_cat_im_0_eb_state[0];
  assign s1_cmul0_cat_im_0_ack = s1_cmul0_cat_im_0_eb_state[4];
  assign s1_cmul0_cat_im_0_m_req = s1_cmul0_cat_im_0_eb_state[3];
  assign s1_cmul0_cat_im_0 = (s1_cmul0_cat_im_0_eb_sel ? s1_cmul0_cat_im_0_eb_r1 : s1_cmul0_cat_im_0_eb_r0);
  assign s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_req = s1_cmul0_cat_im_0_m_req;
  assign s1_cmul0_cat_im_0_m_ack = s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_ack;
  assign cfg_s1_cmul0_mas_re_m_req = cfg_s1_cmul0_mas_re_req;
  assign cfg_s1_cmul0_mas_re_ack = cfg_s1_cmul0_mas_re_m_ack;
  assign cfg_s1_cmul0_mas_re_to_s1_cmul0_mas_re_req = cfg_s1_cmul0_mas_re_m_req;
  assign cfg_s1_cmul0_mas_re_m_ack = cfg_s1_cmul0_mas_re_to_s1_cmul0_mas_re_ack;
  assign s1_cmul0_mas_re_0_m_req = s1_cmul0_mas_re_0_req;
  assign s1_cmul0_mas_re_0_ack = s1_cmul0_mas_re_0_m_ack;
  assign s1_cmul0_mas_re_0_to_s1_r4_a0_re_req = (s1_cmul0_mas_re_0_m_req && (! s1_cmul0_mas_re_0_fork_ack_r_0));
  assign s1_cmul0_mas_re_0_fork_ack_s_0 = (s1_cmul0_mas_re_0_to_s1_r4_a0_re_ack || (! s1_cmul0_mas_re_0_to_s1_r4_a0_re_req));
  assign s1_cmul0_mas_re_0_to_s1_r4_a2_re_req = (s1_cmul0_mas_re_0_m_req && (! s1_cmul0_mas_re_0_fork_ack_r_1));
  assign s1_cmul0_mas_re_0_fork_ack_s_1 = (s1_cmul0_mas_re_0_to_s1_r4_a2_re_ack || (! s1_cmul0_mas_re_0_to_s1_r4_a2_re_req));
  assign s1_cmul0_mas_re_0_to_s1_r4_byp0_re_req = (s1_cmul0_mas_re_0_m_req && (! s1_cmul0_mas_re_0_fork_ack_r_2));
  assign s1_cmul0_mas_re_0_fork_ack_s_2 = (s1_cmul0_mas_re_0_to_s1_r4_byp0_re_ack || (! s1_cmul0_mas_re_0_to_s1_r4_byp0_re_req));
  assign s1_cmul0_mas_re_0_m_ack = ((s1_cmul0_mas_re_0_fork_ack_s_0 && s1_cmul0_mas_re_0_fork_ack_s_1) && s1_cmul0_mas_re_0_fork_ack_s_2);
  assign cfg_s1_cmul0_mas_im_m_req = cfg_s1_cmul0_mas_im_req;
  assign cfg_s1_cmul0_mas_im_ack = cfg_s1_cmul0_mas_im_m_ack;
  assign cfg_s1_cmul0_mas_im_to_s1_cmul0_mas_im_req = cfg_s1_cmul0_mas_im_m_req;
  assign cfg_s1_cmul0_mas_im_m_ack = cfg_s1_cmul0_mas_im_to_s1_cmul0_mas_im_ack;
  assign s1_cmul0_mas_im_0_m_req = s1_cmul0_mas_im_0_req;
  assign s1_cmul0_mas_im_0_ack = s1_cmul0_mas_im_0_m_ack;
  assign s1_cmul0_mas_im_0_to_s1_r4_a0_im_req = (s1_cmul0_mas_im_0_m_req && (! s1_cmul0_mas_im_0_fork_ack_r_0));
  assign s1_cmul0_mas_im_0_fork_ack_s_0 = (s1_cmul0_mas_im_0_to_s1_r4_a0_im_ack || (! s1_cmul0_mas_im_0_to_s1_r4_a0_im_req));
  assign s1_cmul0_mas_im_0_to_s1_r4_a2_im_req = (s1_cmul0_mas_im_0_m_req && (! s1_cmul0_mas_im_0_fork_ack_r_1));
  assign s1_cmul0_mas_im_0_fork_ack_s_1 = (s1_cmul0_mas_im_0_to_s1_r4_a2_im_ack || (! s1_cmul0_mas_im_0_to_s1_r4_a2_im_req));
  assign s1_cmul0_mas_im_0_to_s1_r4_byp0_im_req = (s1_cmul0_mas_im_0_m_req && (! s1_cmul0_mas_im_0_fork_ack_r_2));
  assign s1_cmul0_mas_im_0_fork_ack_s_2 = (s1_cmul0_mas_im_0_to_s1_r4_byp0_im_ack || (! s1_cmul0_mas_im_0_to_s1_r4_byp0_im_req));
  assign s1_cmul0_mas_im_0_m_ack = ((s1_cmul0_mas_im_0_fork_ack_s_0 && s1_cmul0_mas_im_0_fork_ack_s_1) && s1_cmul0_mas_im_0_fork_ack_s_2);
  assign s1_cmul1_recip_norm_0_ack = ((! s1_cmul1_recip_norm_0_eb_valid) || s1_cmul1_recip_norm_0_m_ack);
  assign s1_cmul1_recip_norm_0_eb_en = (s1_cmul1_recip_norm_0_req && s1_cmul1_recip_norm_0_ack);
  assign s1_cmul1_recip_norm_0_m_req = s1_cmul1_recip_norm_0_eb_valid;
  assign s1_cmul1_recip_norm_0 = s1_cmul1_recip_norm_0_eb_r;
  assign s1_cmul1_recip_norm_0_to_s1_cmul1_recip_mul_req = s1_cmul1_recip_norm_0_m_req;
  assign s1_cmul1_recip_norm_0_m_ack = s1_cmul1_recip_norm_0_to_s1_cmul1_recip_mul_ack;
  assign s1_cmul1_recip_mul_0_ack = ((! s1_cmul1_recip_mul_0_eb_valid) || s1_cmul1_recip_mul_0_m_ack);
  assign s1_cmul1_recip_mul_0_eb_en = (s1_cmul1_recip_mul_0_req && s1_cmul1_recip_mul_0_ack);
  assign s1_cmul1_recip_mul_0_m_req = s1_cmul1_recip_mul_0_eb_valid;
  assign s1_cmul1_recip_mul_0 = s1_cmul1_recip_mul_0_eb_r;
  assign s1_cmul1_recip_mul_0_to_s1_cmul1_recip_out_req = s1_cmul1_recip_mul_0_m_req;
  assign s1_cmul1_recip_mul_0_m_ack = s1_cmul1_recip_mul_0_to_s1_cmul1_recip_out_ack;
  assign s1_cmul1_recip_out_0_ack = ((! s1_cmul1_recip_out_0_eb_valid) || s1_cmul1_recip_out_0_m_ack);
  assign s1_cmul1_recip_out_0_eb_en = (s1_cmul1_recip_out_0_req && s1_cmul1_recip_out_0_ack);
  assign s1_cmul1_recip_out_0_m_req = s1_cmul1_recip_out_0_eb_valid;
  assign s1_cmul1_recip_out_0 = s1_cmul1_recip_out_0_eb_r;
  assign s1_cmul1_recip_out_0_to_s1_cmul1_m2c_ac_req = (s1_cmul1_recip_out_0_m_req && (! s1_cmul1_recip_out_0_fork_ack_r_0));
  assign s1_cmul1_recip_out_0_fork_ack_s_0 = (s1_cmul1_recip_out_0_to_s1_cmul1_m2c_ac_ack || (! s1_cmul1_recip_out_0_to_s1_cmul1_m2c_ac_req));
  assign s1_cmul1_recip_out_0_to_s1_cmul1_m2c_cd_req = (s1_cmul1_recip_out_0_m_req && (! s1_cmul1_recip_out_0_fork_ack_r_1));
  assign s1_cmul1_recip_out_0_fork_ack_s_1 = (s1_cmul1_recip_out_0_to_s1_cmul1_m2c_cd_ack || (! s1_cmul1_recip_out_0_to_s1_cmul1_m2c_cd_req));
  assign s1_cmul1_recip_out_0_m_ack = (s1_cmul1_recip_out_0_fork_ack_s_0 && s1_cmul1_recip_out_0_fork_ack_s_1);
  assign cfg_s1_cmul1_m2c_ac_m_req = cfg_s1_cmul1_m2c_ac_req;
  assign cfg_s1_cmul1_m2c_ac_ack = cfg_s1_cmul1_m2c_ac_m_ack;
  assign cfg_s1_cmul1_m2c_ac_to_s1_cmul1_m2c_ac_req = cfg_s1_cmul1_m2c_ac_m_req;
  assign cfg_s1_cmul1_m2c_ac_m_ack = cfg_s1_cmul1_m2c_ac_to_s1_cmul1_m2c_ac_ack;
  assign s1_cmul1_m2c_ac_0_m_req = s1_cmul1_m2c_ac_0_req;
  assign s1_cmul1_m2c_ac_0_ack = s1_cmul1_m2c_ac_0_m_ack;
  assign s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_req = s1_cmul1_m2c_ac_0_m_req;
  assign s1_cmul1_m2c_ac_0_m_ack = s1_cmul1_m2c_ac_0_to_s1_cmul1_cat_re_ack;
  assign cfg_s1_cmul1_m2c_bc_m_req = cfg_s1_cmul1_m2c_bc_req;
  assign cfg_s1_cmul1_m2c_bc_ack = cfg_s1_cmul1_m2c_bc_m_ack;
  assign cfg_s1_cmul1_m2c_bc_to_s1_cmul1_m2c_bc_req = cfg_s1_cmul1_m2c_bc_m_req;
  assign cfg_s1_cmul1_m2c_bc_m_ack = cfg_s1_cmul1_m2c_bc_to_s1_cmul1_m2c_bc_ack;
  assign s1_cmul1_m2c_bc_0_m_req = s1_cmul1_m2c_bc_0_req;
  assign s1_cmul1_m2c_bc_0_ack = s1_cmul1_m2c_bc_0_m_ack;
  assign s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_req = s1_cmul1_m2c_bc_0_m_req;
  assign s1_cmul1_m2c_bc_0_m_ack = s1_cmul1_m2c_bc_0_to_s1_cmul1_cat_re_ack;
  assign cfg_s1_cmul1_m2c_bd_m_req = cfg_s1_cmul1_m2c_bd_req;
  assign cfg_s1_cmul1_m2c_bd_ack = cfg_s1_cmul1_m2c_bd_m_ack;
  assign cfg_s1_cmul1_m2c_bd_to_s1_cmul1_m2c_bd_req = cfg_s1_cmul1_m2c_bd_m_req;
  assign cfg_s1_cmul1_m2c_bd_m_ack = cfg_s1_cmul1_m2c_bd_to_s1_cmul1_m2c_bd_ack;
  assign s1_cmul1_m2c_bd_0_m_req = s1_cmul1_m2c_bd_0_req;
  assign s1_cmul1_m2c_bd_0_ack = s1_cmul1_m2c_bd_0_m_ack;
  assign s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_req = s1_cmul1_m2c_bd_0_m_req;
  assign s1_cmul1_m2c_bd_0_m_ack = s1_cmul1_m2c_bd_0_to_s1_cmul1_cat_re_ack;
  assign cfg_s1_cmul1_m2c_cb_m_req = cfg_s1_cmul1_m2c_cb_req;
  assign cfg_s1_cmul1_m2c_cb_ack = cfg_s1_cmul1_m2c_cb_m_ack;
  assign cfg_s1_cmul1_m2c_cb_to_s1_cmul1_m2c_cb_req = cfg_s1_cmul1_m2c_cb_m_req;
  assign cfg_s1_cmul1_m2c_cb_m_ack = cfg_s1_cmul1_m2c_cb_to_s1_cmul1_m2c_cb_ack;
  assign s1_cmul1_m2c_cb_0_m_req = s1_cmul1_m2c_cb_0_req;
  assign s1_cmul1_m2c_cb_0_ack = s1_cmul1_m2c_cb_0_m_ack;
  assign s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_req = s1_cmul1_m2c_cb_0_m_req;
  assign s1_cmul1_m2c_cb_0_m_ack = s1_cmul1_m2c_cb_0_to_s1_cmul1_cat_im_ack;
  assign cfg_s1_cmul1_m2c_cd_m_req = cfg_s1_cmul1_m2c_cd_req;
  assign cfg_s1_cmul1_m2c_cd_ack = cfg_s1_cmul1_m2c_cd_m_ack;
  assign cfg_s1_cmul1_m2c_cd_to_s1_cmul1_m2c_cd_req = cfg_s1_cmul1_m2c_cd_m_req;
  assign cfg_s1_cmul1_m2c_cd_m_ack = cfg_s1_cmul1_m2c_cd_to_s1_cmul1_m2c_cd_ack;
  assign s1_cmul1_m2c_cd_0_m_req = s1_cmul1_m2c_cd_0_req;
  assign s1_cmul1_m2c_cd_0_ack = s1_cmul1_m2c_cd_0_m_ack;
  assign s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_req = s1_cmul1_m2c_cd_0_m_req;
  assign s1_cmul1_m2c_cd_0_m_ack = s1_cmul1_m2c_cd_0_to_s1_cmul1_cat_im_ack;
  assign cfg_s1_cmul1_m2c_da_m_req = cfg_s1_cmul1_m2c_da_req;
  assign cfg_s1_cmul1_m2c_da_ack = cfg_s1_cmul1_m2c_da_m_ack;
  assign cfg_s1_cmul1_m2c_da_to_s1_cmul1_m2c_da_req = cfg_s1_cmul1_m2c_da_m_req;
  assign cfg_s1_cmul1_m2c_da_m_ack = cfg_s1_cmul1_m2c_da_to_s1_cmul1_m2c_da_ack;
  assign s1_cmul1_m2c_da_0_m_req = s1_cmul1_m2c_da_0_req;
  assign s1_cmul1_m2c_da_0_ack = s1_cmul1_m2c_da_0_m_ack;
  assign s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_req = s1_cmul1_m2c_da_0_m_req;
  assign s1_cmul1_m2c_da_0_m_ack = s1_cmul1_m2c_da_0_to_s1_cmul1_cat_im_ack;
  always @(*) begin
    s1_cmul1_cat_re_0_eb_state_nxt = s1_cmul1_cat_re_0_eb_state;
    case(s1_cmul1_cat_re_0_eb_state)
      5'h14 : begin
        if(s1_cmul1_cat_re_0_req) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_cmul1_cat_re_0_req) && s1_cmul1_cat_re_0_m_ack)) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul1_cat_re_0_req && (! s1_cmul1_cat_re_0_m_ack))) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_cmul1_cat_re_0_req && s1_cmul1_cat_re_0_m_ack)) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_cmul1_cat_re_0_m_ack) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_cmul1_cat_re_0_req) && s1_cmul1_cat_re_0_m_ack)) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul1_cat_re_0_req && (! s1_cmul1_cat_re_0_m_ack))) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_cmul1_cat_re_0_req && s1_cmul1_cat_re_0_m_ack)) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_cmul1_cat_re_0_m_ack) begin
          s1_cmul1_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_cmul1_cat_re_0_eb_en0 = (s1_cmul1_cat_re_0_eb_state[2] && s1_cmul1_cat_re_0_req);
  assign s1_cmul1_cat_re_0_eb_en1 = (s1_cmul1_cat_re_0_eb_state[1] && s1_cmul1_cat_re_0_req);
  assign s1_cmul1_cat_re_0_eb_sel = s1_cmul1_cat_re_0_eb_state[0];
  assign s1_cmul1_cat_re_0_ack = s1_cmul1_cat_re_0_eb_state[4];
  assign s1_cmul1_cat_re_0_m_req = s1_cmul1_cat_re_0_eb_state[3];
  assign s1_cmul1_cat_re_0 = (s1_cmul1_cat_re_0_eb_sel ? s1_cmul1_cat_re_0_eb_r1 : s1_cmul1_cat_re_0_eb_r0);
  assign s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_req = s1_cmul1_cat_re_0_m_req;
  assign s1_cmul1_cat_re_0_m_ack = s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_ack;
  always @(*) begin
    s1_cmul1_cat_im_0_eb_state_nxt = s1_cmul1_cat_im_0_eb_state;
    case(s1_cmul1_cat_im_0_eb_state)
      5'h14 : begin
        if(s1_cmul1_cat_im_0_req) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_cmul1_cat_im_0_req) && s1_cmul1_cat_im_0_m_ack)) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul1_cat_im_0_req && (! s1_cmul1_cat_im_0_m_ack))) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_cmul1_cat_im_0_req && s1_cmul1_cat_im_0_m_ack)) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_cmul1_cat_im_0_m_ack) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_cmul1_cat_im_0_req) && s1_cmul1_cat_im_0_m_ack)) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul1_cat_im_0_req && (! s1_cmul1_cat_im_0_m_ack))) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_cmul1_cat_im_0_req && s1_cmul1_cat_im_0_m_ack)) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_cmul1_cat_im_0_m_ack) begin
          s1_cmul1_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_cmul1_cat_im_0_eb_en0 = (s1_cmul1_cat_im_0_eb_state[2] && s1_cmul1_cat_im_0_req);
  assign s1_cmul1_cat_im_0_eb_en1 = (s1_cmul1_cat_im_0_eb_state[1] && s1_cmul1_cat_im_0_req);
  assign s1_cmul1_cat_im_0_eb_sel = s1_cmul1_cat_im_0_eb_state[0];
  assign s1_cmul1_cat_im_0_ack = s1_cmul1_cat_im_0_eb_state[4];
  assign s1_cmul1_cat_im_0_m_req = s1_cmul1_cat_im_0_eb_state[3];
  assign s1_cmul1_cat_im_0 = (s1_cmul1_cat_im_0_eb_sel ? s1_cmul1_cat_im_0_eb_r1 : s1_cmul1_cat_im_0_eb_r0);
  assign s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_req = s1_cmul1_cat_im_0_m_req;
  assign s1_cmul1_cat_im_0_m_ack = s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_ack;
  assign cfg_s1_cmul1_mas_re_m_req = cfg_s1_cmul1_mas_re_req;
  assign cfg_s1_cmul1_mas_re_ack = cfg_s1_cmul1_mas_re_m_ack;
  assign cfg_s1_cmul1_mas_re_to_s1_cmul1_mas_re_req = cfg_s1_cmul1_mas_re_m_req;
  assign cfg_s1_cmul1_mas_re_m_ack = cfg_s1_cmul1_mas_re_to_s1_cmul1_mas_re_ack;
  assign s1_cmul1_mas_re_0_m_req = s1_cmul1_mas_re_0_req;
  assign s1_cmul1_mas_re_0_ack = s1_cmul1_mas_re_0_m_ack;
  assign s1_cmul1_mas_re_0_to_s1_r4_a1_re_req = (s1_cmul1_mas_re_0_m_req && (! s1_cmul1_mas_re_0_fork_ack_r_0));
  assign s1_cmul1_mas_re_0_fork_ack_s_0 = (s1_cmul1_mas_re_0_to_s1_r4_a1_re_ack || (! s1_cmul1_mas_re_0_to_s1_r4_a1_re_req));
  assign s1_cmul1_mas_re_0_to_s1_r4_a3_re_req = (s1_cmul1_mas_re_0_m_req && (! s1_cmul1_mas_re_0_fork_ack_r_1));
  assign s1_cmul1_mas_re_0_fork_ack_s_1 = (s1_cmul1_mas_re_0_to_s1_r4_a3_re_ack || (! s1_cmul1_mas_re_0_to_s1_r4_a3_re_req));
  assign s1_cmul1_mas_re_0_to_s1_r4_byp1_re_req = (s1_cmul1_mas_re_0_m_req && (! s1_cmul1_mas_re_0_fork_ack_r_2));
  assign s1_cmul1_mas_re_0_fork_ack_s_2 = (s1_cmul1_mas_re_0_to_s1_r4_byp1_re_ack || (! s1_cmul1_mas_re_0_to_s1_r4_byp1_re_req));
  assign s1_cmul1_mas_re_0_m_ack = ((s1_cmul1_mas_re_0_fork_ack_s_0 && s1_cmul1_mas_re_0_fork_ack_s_1) && s1_cmul1_mas_re_0_fork_ack_s_2);
  assign cfg_s1_cmul1_mas_im_m_req = cfg_s1_cmul1_mas_im_req;
  assign cfg_s1_cmul1_mas_im_ack = cfg_s1_cmul1_mas_im_m_ack;
  assign cfg_s1_cmul1_mas_im_to_s1_cmul1_mas_im_req = cfg_s1_cmul1_mas_im_m_req;
  assign cfg_s1_cmul1_mas_im_m_ack = cfg_s1_cmul1_mas_im_to_s1_cmul1_mas_im_ack;
  assign s1_cmul1_mas_im_0_m_req = s1_cmul1_mas_im_0_req;
  assign s1_cmul1_mas_im_0_ack = s1_cmul1_mas_im_0_m_ack;
  assign s1_cmul1_mas_im_0_to_s1_r4_a1_im_req = (s1_cmul1_mas_im_0_m_req && (! s1_cmul1_mas_im_0_fork_ack_r_0));
  assign s1_cmul1_mas_im_0_fork_ack_s_0 = (s1_cmul1_mas_im_0_to_s1_r4_a1_im_ack || (! s1_cmul1_mas_im_0_to_s1_r4_a1_im_req));
  assign s1_cmul1_mas_im_0_to_s1_r4_a3_im_req = (s1_cmul1_mas_im_0_m_req && (! s1_cmul1_mas_im_0_fork_ack_r_1));
  assign s1_cmul1_mas_im_0_fork_ack_s_1 = (s1_cmul1_mas_im_0_to_s1_r4_a3_im_ack || (! s1_cmul1_mas_im_0_to_s1_r4_a3_im_req));
  assign s1_cmul1_mas_im_0_to_s1_r4_byp1_im_req = (s1_cmul1_mas_im_0_m_req && (! s1_cmul1_mas_im_0_fork_ack_r_2));
  assign s1_cmul1_mas_im_0_fork_ack_s_2 = (s1_cmul1_mas_im_0_to_s1_r4_byp1_im_ack || (! s1_cmul1_mas_im_0_to_s1_r4_byp1_im_req));
  assign s1_cmul1_mas_im_0_m_ack = ((s1_cmul1_mas_im_0_fork_ack_s_0 && s1_cmul1_mas_im_0_fork_ack_s_1) && s1_cmul1_mas_im_0_fork_ack_s_2);
  assign s1_cmul2_recip_norm_0_ack = ((! s1_cmul2_recip_norm_0_eb_valid) || s1_cmul2_recip_norm_0_m_ack);
  assign s1_cmul2_recip_norm_0_eb_en = (s1_cmul2_recip_norm_0_req && s1_cmul2_recip_norm_0_ack);
  assign s1_cmul2_recip_norm_0_m_req = s1_cmul2_recip_norm_0_eb_valid;
  assign s1_cmul2_recip_norm_0 = s1_cmul2_recip_norm_0_eb_r;
  assign s1_cmul2_recip_norm_0_to_s1_cmul2_recip_mul_req = s1_cmul2_recip_norm_0_m_req;
  assign s1_cmul2_recip_norm_0_m_ack = s1_cmul2_recip_norm_0_to_s1_cmul2_recip_mul_ack;
  assign s1_cmul2_recip_mul_0_ack = ((! s1_cmul2_recip_mul_0_eb_valid) || s1_cmul2_recip_mul_0_m_ack);
  assign s1_cmul2_recip_mul_0_eb_en = (s1_cmul2_recip_mul_0_req && s1_cmul2_recip_mul_0_ack);
  assign s1_cmul2_recip_mul_0_m_req = s1_cmul2_recip_mul_0_eb_valid;
  assign s1_cmul2_recip_mul_0 = s1_cmul2_recip_mul_0_eb_r;
  assign s1_cmul2_recip_mul_0_to_s1_cmul2_recip_out_req = s1_cmul2_recip_mul_0_m_req;
  assign s1_cmul2_recip_mul_0_m_ack = s1_cmul2_recip_mul_0_to_s1_cmul2_recip_out_ack;
  assign s1_cmul2_recip_out_0_ack = ((! s1_cmul2_recip_out_0_eb_valid) || s1_cmul2_recip_out_0_m_ack);
  assign s1_cmul2_recip_out_0_eb_en = (s1_cmul2_recip_out_0_req && s1_cmul2_recip_out_0_ack);
  assign s1_cmul2_recip_out_0_m_req = s1_cmul2_recip_out_0_eb_valid;
  assign s1_cmul2_recip_out_0 = s1_cmul2_recip_out_0_eb_r;
  assign s1_cmul2_recip_out_0_to_s1_cmul2_m2c_ac_req = (s1_cmul2_recip_out_0_m_req && (! s1_cmul2_recip_out_0_fork_ack_r_0));
  assign s1_cmul2_recip_out_0_fork_ack_s_0 = (s1_cmul2_recip_out_0_to_s1_cmul2_m2c_ac_ack || (! s1_cmul2_recip_out_0_to_s1_cmul2_m2c_ac_req));
  assign s1_cmul2_recip_out_0_to_s1_cmul2_m2c_cd_req = (s1_cmul2_recip_out_0_m_req && (! s1_cmul2_recip_out_0_fork_ack_r_1));
  assign s1_cmul2_recip_out_0_fork_ack_s_1 = (s1_cmul2_recip_out_0_to_s1_cmul2_m2c_cd_ack || (! s1_cmul2_recip_out_0_to_s1_cmul2_m2c_cd_req));
  assign s1_cmul2_recip_out_0_m_ack = (s1_cmul2_recip_out_0_fork_ack_s_0 && s1_cmul2_recip_out_0_fork_ack_s_1);
  assign cfg_s1_cmul2_m2c_ac_m_req = cfg_s1_cmul2_m2c_ac_req;
  assign cfg_s1_cmul2_m2c_ac_ack = cfg_s1_cmul2_m2c_ac_m_ack;
  assign cfg_s1_cmul2_m2c_ac_to_s1_cmul2_m2c_ac_req = cfg_s1_cmul2_m2c_ac_m_req;
  assign cfg_s1_cmul2_m2c_ac_m_ack = cfg_s1_cmul2_m2c_ac_to_s1_cmul2_m2c_ac_ack;
  assign s1_cmul2_m2c_ac_0_m_req = s1_cmul2_m2c_ac_0_req;
  assign s1_cmul2_m2c_ac_0_ack = s1_cmul2_m2c_ac_0_m_ack;
  assign s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_req = s1_cmul2_m2c_ac_0_m_req;
  assign s1_cmul2_m2c_ac_0_m_ack = s1_cmul2_m2c_ac_0_to_s1_cmul2_cat_re_ack;
  assign cfg_s1_cmul2_m2c_bc_m_req = cfg_s1_cmul2_m2c_bc_req;
  assign cfg_s1_cmul2_m2c_bc_ack = cfg_s1_cmul2_m2c_bc_m_ack;
  assign cfg_s1_cmul2_m2c_bc_to_s1_cmul2_m2c_bc_req = cfg_s1_cmul2_m2c_bc_m_req;
  assign cfg_s1_cmul2_m2c_bc_m_ack = cfg_s1_cmul2_m2c_bc_to_s1_cmul2_m2c_bc_ack;
  assign s1_cmul2_m2c_bc_0_m_req = s1_cmul2_m2c_bc_0_req;
  assign s1_cmul2_m2c_bc_0_ack = s1_cmul2_m2c_bc_0_m_ack;
  assign s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_req = s1_cmul2_m2c_bc_0_m_req;
  assign s1_cmul2_m2c_bc_0_m_ack = s1_cmul2_m2c_bc_0_to_s1_cmul2_cat_re_ack;
  assign cfg_s1_cmul2_m2c_bd_m_req = cfg_s1_cmul2_m2c_bd_req;
  assign cfg_s1_cmul2_m2c_bd_ack = cfg_s1_cmul2_m2c_bd_m_ack;
  assign cfg_s1_cmul2_m2c_bd_to_s1_cmul2_m2c_bd_req = cfg_s1_cmul2_m2c_bd_m_req;
  assign cfg_s1_cmul2_m2c_bd_m_ack = cfg_s1_cmul2_m2c_bd_to_s1_cmul2_m2c_bd_ack;
  assign s1_cmul2_m2c_bd_0_m_req = s1_cmul2_m2c_bd_0_req;
  assign s1_cmul2_m2c_bd_0_ack = s1_cmul2_m2c_bd_0_m_ack;
  assign s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_req = s1_cmul2_m2c_bd_0_m_req;
  assign s1_cmul2_m2c_bd_0_m_ack = s1_cmul2_m2c_bd_0_to_s1_cmul2_cat_re_ack;
  assign cfg_s1_cmul2_m2c_cb_m_req = cfg_s1_cmul2_m2c_cb_req;
  assign cfg_s1_cmul2_m2c_cb_ack = cfg_s1_cmul2_m2c_cb_m_ack;
  assign cfg_s1_cmul2_m2c_cb_to_s1_cmul2_m2c_cb_req = cfg_s1_cmul2_m2c_cb_m_req;
  assign cfg_s1_cmul2_m2c_cb_m_ack = cfg_s1_cmul2_m2c_cb_to_s1_cmul2_m2c_cb_ack;
  assign s1_cmul2_m2c_cb_0_m_req = s1_cmul2_m2c_cb_0_req;
  assign s1_cmul2_m2c_cb_0_ack = s1_cmul2_m2c_cb_0_m_ack;
  assign s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_req = s1_cmul2_m2c_cb_0_m_req;
  assign s1_cmul2_m2c_cb_0_m_ack = s1_cmul2_m2c_cb_0_to_s1_cmul2_cat_im_ack;
  assign cfg_s1_cmul2_m2c_cd_m_req = cfg_s1_cmul2_m2c_cd_req;
  assign cfg_s1_cmul2_m2c_cd_ack = cfg_s1_cmul2_m2c_cd_m_ack;
  assign cfg_s1_cmul2_m2c_cd_to_s1_cmul2_m2c_cd_req = cfg_s1_cmul2_m2c_cd_m_req;
  assign cfg_s1_cmul2_m2c_cd_m_ack = cfg_s1_cmul2_m2c_cd_to_s1_cmul2_m2c_cd_ack;
  assign s1_cmul2_m2c_cd_0_m_req = s1_cmul2_m2c_cd_0_req;
  assign s1_cmul2_m2c_cd_0_ack = s1_cmul2_m2c_cd_0_m_ack;
  assign s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_req = s1_cmul2_m2c_cd_0_m_req;
  assign s1_cmul2_m2c_cd_0_m_ack = s1_cmul2_m2c_cd_0_to_s1_cmul2_cat_im_ack;
  assign cfg_s1_cmul2_m2c_da_m_req = cfg_s1_cmul2_m2c_da_req;
  assign cfg_s1_cmul2_m2c_da_ack = cfg_s1_cmul2_m2c_da_m_ack;
  assign cfg_s1_cmul2_m2c_da_to_s1_cmul2_m2c_da_req = cfg_s1_cmul2_m2c_da_m_req;
  assign cfg_s1_cmul2_m2c_da_m_ack = cfg_s1_cmul2_m2c_da_to_s1_cmul2_m2c_da_ack;
  assign s1_cmul2_m2c_da_0_m_req = s1_cmul2_m2c_da_0_req;
  assign s1_cmul2_m2c_da_0_ack = s1_cmul2_m2c_da_0_m_ack;
  assign s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_req = s1_cmul2_m2c_da_0_m_req;
  assign s1_cmul2_m2c_da_0_m_ack = s1_cmul2_m2c_da_0_to_s1_cmul2_cat_im_ack;
  always @(*) begin
    s1_cmul2_cat_re_0_eb_state_nxt = s1_cmul2_cat_re_0_eb_state;
    case(s1_cmul2_cat_re_0_eb_state)
      5'h14 : begin
        if(s1_cmul2_cat_re_0_req) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_cmul2_cat_re_0_req) && s1_cmul2_cat_re_0_m_ack)) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul2_cat_re_0_req && (! s1_cmul2_cat_re_0_m_ack))) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_cmul2_cat_re_0_req && s1_cmul2_cat_re_0_m_ack)) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_cmul2_cat_re_0_m_ack) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_cmul2_cat_re_0_req) && s1_cmul2_cat_re_0_m_ack)) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul2_cat_re_0_req && (! s1_cmul2_cat_re_0_m_ack))) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_cmul2_cat_re_0_req && s1_cmul2_cat_re_0_m_ack)) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_cmul2_cat_re_0_m_ack) begin
          s1_cmul2_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_cmul2_cat_re_0_eb_en0 = (s1_cmul2_cat_re_0_eb_state[2] && s1_cmul2_cat_re_0_req);
  assign s1_cmul2_cat_re_0_eb_en1 = (s1_cmul2_cat_re_0_eb_state[1] && s1_cmul2_cat_re_0_req);
  assign s1_cmul2_cat_re_0_eb_sel = s1_cmul2_cat_re_0_eb_state[0];
  assign s1_cmul2_cat_re_0_ack = s1_cmul2_cat_re_0_eb_state[4];
  assign s1_cmul2_cat_re_0_m_req = s1_cmul2_cat_re_0_eb_state[3];
  assign s1_cmul2_cat_re_0 = (s1_cmul2_cat_re_0_eb_sel ? s1_cmul2_cat_re_0_eb_r1 : s1_cmul2_cat_re_0_eb_r0);
  assign s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_req = s1_cmul2_cat_re_0_m_req;
  assign s1_cmul2_cat_re_0_m_ack = s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_ack;
  always @(*) begin
    s1_cmul2_cat_im_0_eb_state_nxt = s1_cmul2_cat_im_0_eb_state;
    case(s1_cmul2_cat_im_0_eb_state)
      5'h14 : begin
        if(s1_cmul2_cat_im_0_req) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_cmul2_cat_im_0_req) && s1_cmul2_cat_im_0_m_ack)) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul2_cat_im_0_req && (! s1_cmul2_cat_im_0_m_ack))) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_cmul2_cat_im_0_req && s1_cmul2_cat_im_0_m_ack)) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_cmul2_cat_im_0_m_ack) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_cmul2_cat_im_0_req) && s1_cmul2_cat_im_0_m_ack)) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul2_cat_im_0_req && (! s1_cmul2_cat_im_0_m_ack))) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_cmul2_cat_im_0_req && s1_cmul2_cat_im_0_m_ack)) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_cmul2_cat_im_0_m_ack) begin
          s1_cmul2_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_cmul2_cat_im_0_eb_en0 = (s1_cmul2_cat_im_0_eb_state[2] && s1_cmul2_cat_im_0_req);
  assign s1_cmul2_cat_im_0_eb_en1 = (s1_cmul2_cat_im_0_eb_state[1] && s1_cmul2_cat_im_0_req);
  assign s1_cmul2_cat_im_0_eb_sel = s1_cmul2_cat_im_0_eb_state[0];
  assign s1_cmul2_cat_im_0_ack = s1_cmul2_cat_im_0_eb_state[4];
  assign s1_cmul2_cat_im_0_m_req = s1_cmul2_cat_im_0_eb_state[3];
  assign s1_cmul2_cat_im_0 = (s1_cmul2_cat_im_0_eb_sel ? s1_cmul2_cat_im_0_eb_r1 : s1_cmul2_cat_im_0_eb_r0);
  assign s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_req = s1_cmul2_cat_im_0_m_req;
  assign s1_cmul2_cat_im_0_m_ack = s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_ack;
  assign cfg_s1_cmul2_mas_re_m_req = cfg_s1_cmul2_mas_re_req;
  assign cfg_s1_cmul2_mas_re_ack = cfg_s1_cmul2_mas_re_m_ack;
  assign cfg_s1_cmul2_mas_re_to_s1_cmul2_mas_re_req = cfg_s1_cmul2_mas_re_m_req;
  assign cfg_s1_cmul2_mas_re_m_ack = cfg_s1_cmul2_mas_re_to_s1_cmul2_mas_re_ack;
  assign s1_cmul2_mas_re_0_m_req = s1_cmul2_mas_re_0_req;
  assign s1_cmul2_mas_re_0_ack = s1_cmul2_mas_re_0_m_ack;
  assign s1_cmul2_mas_re_0_to_s1_r4_a0_re_req = (s1_cmul2_mas_re_0_m_req && (! s1_cmul2_mas_re_0_fork_ack_r_0));
  assign s1_cmul2_mas_re_0_fork_ack_s_0 = (s1_cmul2_mas_re_0_to_s1_r4_a0_re_ack || (! s1_cmul2_mas_re_0_to_s1_r4_a0_re_req));
  assign s1_cmul2_mas_re_0_to_s1_r4_a2_re_req = (s1_cmul2_mas_re_0_m_req && (! s1_cmul2_mas_re_0_fork_ack_r_1));
  assign s1_cmul2_mas_re_0_fork_ack_s_1 = (s1_cmul2_mas_re_0_to_s1_r4_a2_re_ack || (! s1_cmul2_mas_re_0_to_s1_r4_a2_re_req));
  assign s1_cmul2_mas_re_0_to_s1_r4_byp2_re_req = (s1_cmul2_mas_re_0_m_req && (! s1_cmul2_mas_re_0_fork_ack_r_2));
  assign s1_cmul2_mas_re_0_fork_ack_s_2 = (s1_cmul2_mas_re_0_to_s1_r4_byp2_re_ack || (! s1_cmul2_mas_re_0_to_s1_r4_byp2_re_req));
  assign s1_cmul2_mas_re_0_m_ack = ((s1_cmul2_mas_re_0_fork_ack_s_0 && s1_cmul2_mas_re_0_fork_ack_s_1) && s1_cmul2_mas_re_0_fork_ack_s_2);
  assign cfg_s1_cmul2_mas_im_m_req = cfg_s1_cmul2_mas_im_req;
  assign cfg_s1_cmul2_mas_im_ack = cfg_s1_cmul2_mas_im_m_ack;
  assign cfg_s1_cmul2_mas_im_to_s1_cmul2_mas_im_req = cfg_s1_cmul2_mas_im_m_req;
  assign cfg_s1_cmul2_mas_im_m_ack = cfg_s1_cmul2_mas_im_to_s1_cmul2_mas_im_ack;
  assign s1_cmul2_mas_im_0_m_req = s1_cmul2_mas_im_0_req;
  assign s1_cmul2_mas_im_0_ack = s1_cmul2_mas_im_0_m_ack;
  assign s1_cmul2_mas_im_0_to_s1_r4_a0_im_req = (s1_cmul2_mas_im_0_m_req && (! s1_cmul2_mas_im_0_fork_ack_r_0));
  assign s1_cmul2_mas_im_0_fork_ack_s_0 = (s1_cmul2_mas_im_0_to_s1_r4_a0_im_ack || (! s1_cmul2_mas_im_0_to_s1_r4_a0_im_req));
  assign s1_cmul2_mas_im_0_to_s1_r4_a2_im_req = (s1_cmul2_mas_im_0_m_req && (! s1_cmul2_mas_im_0_fork_ack_r_1));
  assign s1_cmul2_mas_im_0_fork_ack_s_1 = (s1_cmul2_mas_im_0_to_s1_r4_a2_im_ack || (! s1_cmul2_mas_im_0_to_s1_r4_a2_im_req));
  assign s1_cmul2_mas_im_0_to_s1_r4_byp2_im_req = (s1_cmul2_mas_im_0_m_req && (! s1_cmul2_mas_im_0_fork_ack_r_2));
  assign s1_cmul2_mas_im_0_fork_ack_s_2 = (s1_cmul2_mas_im_0_to_s1_r4_byp2_im_ack || (! s1_cmul2_mas_im_0_to_s1_r4_byp2_im_req));
  assign s1_cmul2_mas_im_0_m_ack = ((s1_cmul2_mas_im_0_fork_ack_s_0 && s1_cmul2_mas_im_0_fork_ack_s_1) && s1_cmul2_mas_im_0_fork_ack_s_2);
  assign s1_cmul3_recip_norm_0_ack = ((! s1_cmul3_recip_norm_0_eb_valid) || s1_cmul3_recip_norm_0_m_ack);
  assign s1_cmul3_recip_norm_0_eb_en = (s1_cmul3_recip_norm_0_req && s1_cmul3_recip_norm_0_ack);
  assign s1_cmul3_recip_norm_0_m_req = s1_cmul3_recip_norm_0_eb_valid;
  assign s1_cmul3_recip_norm_0 = s1_cmul3_recip_norm_0_eb_r;
  assign s1_cmul3_recip_norm_0_to_s1_cmul3_recip_mul_req = s1_cmul3_recip_norm_0_m_req;
  assign s1_cmul3_recip_norm_0_m_ack = s1_cmul3_recip_norm_0_to_s1_cmul3_recip_mul_ack;
  assign s1_cmul3_recip_mul_0_ack = ((! s1_cmul3_recip_mul_0_eb_valid) || s1_cmul3_recip_mul_0_m_ack);
  assign s1_cmul3_recip_mul_0_eb_en = (s1_cmul3_recip_mul_0_req && s1_cmul3_recip_mul_0_ack);
  assign s1_cmul3_recip_mul_0_m_req = s1_cmul3_recip_mul_0_eb_valid;
  assign s1_cmul3_recip_mul_0 = s1_cmul3_recip_mul_0_eb_r;
  assign s1_cmul3_recip_mul_0_to_s1_cmul3_recip_out_req = s1_cmul3_recip_mul_0_m_req;
  assign s1_cmul3_recip_mul_0_m_ack = s1_cmul3_recip_mul_0_to_s1_cmul3_recip_out_ack;
  assign s1_cmul3_recip_out_0_ack = ((! s1_cmul3_recip_out_0_eb_valid) || s1_cmul3_recip_out_0_m_ack);
  assign s1_cmul3_recip_out_0_eb_en = (s1_cmul3_recip_out_0_req && s1_cmul3_recip_out_0_ack);
  assign s1_cmul3_recip_out_0_m_req = s1_cmul3_recip_out_0_eb_valid;
  assign s1_cmul3_recip_out_0 = s1_cmul3_recip_out_0_eb_r;
  assign s1_cmul3_recip_out_0_to_s1_cmul3_m2c_ac_req = (s1_cmul3_recip_out_0_m_req && (! s1_cmul3_recip_out_0_fork_ack_r_0));
  assign s1_cmul3_recip_out_0_fork_ack_s_0 = (s1_cmul3_recip_out_0_to_s1_cmul3_m2c_ac_ack || (! s1_cmul3_recip_out_0_to_s1_cmul3_m2c_ac_req));
  assign s1_cmul3_recip_out_0_to_s1_cmul3_m2c_cd_req = (s1_cmul3_recip_out_0_m_req && (! s1_cmul3_recip_out_0_fork_ack_r_1));
  assign s1_cmul3_recip_out_0_fork_ack_s_1 = (s1_cmul3_recip_out_0_to_s1_cmul3_m2c_cd_ack || (! s1_cmul3_recip_out_0_to_s1_cmul3_m2c_cd_req));
  assign s1_cmul3_recip_out_0_m_ack = (s1_cmul3_recip_out_0_fork_ack_s_0 && s1_cmul3_recip_out_0_fork_ack_s_1);
  assign cfg_s1_cmul3_m2c_ac_m_req = cfg_s1_cmul3_m2c_ac_req;
  assign cfg_s1_cmul3_m2c_ac_ack = cfg_s1_cmul3_m2c_ac_m_ack;
  assign cfg_s1_cmul3_m2c_ac_to_s1_cmul3_m2c_ac_req = cfg_s1_cmul3_m2c_ac_m_req;
  assign cfg_s1_cmul3_m2c_ac_m_ack = cfg_s1_cmul3_m2c_ac_to_s1_cmul3_m2c_ac_ack;
  assign s1_cmul3_m2c_ac_0_m_req = s1_cmul3_m2c_ac_0_req;
  assign s1_cmul3_m2c_ac_0_ack = s1_cmul3_m2c_ac_0_m_ack;
  assign s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_req = s1_cmul3_m2c_ac_0_m_req;
  assign s1_cmul3_m2c_ac_0_m_ack = s1_cmul3_m2c_ac_0_to_s1_cmul3_cat_re_ack;
  assign cfg_s1_cmul3_m2c_bc_m_req = cfg_s1_cmul3_m2c_bc_req;
  assign cfg_s1_cmul3_m2c_bc_ack = cfg_s1_cmul3_m2c_bc_m_ack;
  assign cfg_s1_cmul3_m2c_bc_to_s1_cmul3_m2c_bc_req = cfg_s1_cmul3_m2c_bc_m_req;
  assign cfg_s1_cmul3_m2c_bc_m_ack = cfg_s1_cmul3_m2c_bc_to_s1_cmul3_m2c_bc_ack;
  assign s1_cmul3_m2c_bc_0_m_req = s1_cmul3_m2c_bc_0_req;
  assign s1_cmul3_m2c_bc_0_ack = s1_cmul3_m2c_bc_0_m_ack;
  assign s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_req = s1_cmul3_m2c_bc_0_m_req;
  assign s1_cmul3_m2c_bc_0_m_ack = s1_cmul3_m2c_bc_0_to_s1_cmul3_cat_re_ack;
  assign cfg_s1_cmul3_m2c_bd_m_req = cfg_s1_cmul3_m2c_bd_req;
  assign cfg_s1_cmul3_m2c_bd_ack = cfg_s1_cmul3_m2c_bd_m_ack;
  assign cfg_s1_cmul3_m2c_bd_to_s1_cmul3_m2c_bd_req = cfg_s1_cmul3_m2c_bd_m_req;
  assign cfg_s1_cmul3_m2c_bd_m_ack = cfg_s1_cmul3_m2c_bd_to_s1_cmul3_m2c_bd_ack;
  assign s1_cmul3_m2c_bd_0_m_req = s1_cmul3_m2c_bd_0_req;
  assign s1_cmul3_m2c_bd_0_ack = s1_cmul3_m2c_bd_0_m_ack;
  assign s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_req = s1_cmul3_m2c_bd_0_m_req;
  assign s1_cmul3_m2c_bd_0_m_ack = s1_cmul3_m2c_bd_0_to_s1_cmul3_cat_re_ack;
  assign cfg_s1_cmul3_m2c_cb_m_req = cfg_s1_cmul3_m2c_cb_req;
  assign cfg_s1_cmul3_m2c_cb_ack = cfg_s1_cmul3_m2c_cb_m_ack;
  assign cfg_s1_cmul3_m2c_cb_to_s1_cmul3_m2c_cb_req = cfg_s1_cmul3_m2c_cb_m_req;
  assign cfg_s1_cmul3_m2c_cb_m_ack = cfg_s1_cmul3_m2c_cb_to_s1_cmul3_m2c_cb_ack;
  assign s1_cmul3_m2c_cb_0_m_req = s1_cmul3_m2c_cb_0_req;
  assign s1_cmul3_m2c_cb_0_ack = s1_cmul3_m2c_cb_0_m_ack;
  assign s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_req = s1_cmul3_m2c_cb_0_m_req;
  assign s1_cmul3_m2c_cb_0_m_ack = s1_cmul3_m2c_cb_0_to_s1_cmul3_cat_im_ack;
  assign cfg_s1_cmul3_m2c_cd_m_req = cfg_s1_cmul3_m2c_cd_req;
  assign cfg_s1_cmul3_m2c_cd_ack = cfg_s1_cmul3_m2c_cd_m_ack;
  assign cfg_s1_cmul3_m2c_cd_to_s1_cmul3_m2c_cd_req = cfg_s1_cmul3_m2c_cd_m_req;
  assign cfg_s1_cmul3_m2c_cd_m_ack = cfg_s1_cmul3_m2c_cd_to_s1_cmul3_m2c_cd_ack;
  assign s1_cmul3_m2c_cd_0_m_req = s1_cmul3_m2c_cd_0_req;
  assign s1_cmul3_m2c_cd_0_ack = s1_cmul3_m2c_cd_0_m_ack;
  assign s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_req = s1_cmul3_m2c_cd_0_m_req;
  assign s1_cmul3_m2c_cd_0_m_ack = s1_cmul3_m2c_cd_0_to_s1_cmul3_cat_im_ack;
  assign cfg_s1_cmul3_m2c_da_m_req = cfg_s1_cmul3_m2c_da_req;
  assign cfg_s1_cmul3_m2c_da_ack = cfg_s1_cmul3_m2c_da_m_ack;
  assign cfg_s1_cmul3_m2c_da_to_s1_cmul3_m2c_da_req = cfg_s1_cmul3_m2c_da_m_req;
  assign cfg_s1_cmul3_m2c_da_m_ack = cfg_s1_cmul3_m2c_da_to_s1_cmul3_m2c_da_ack;
  assign s1_cmul3_m2c_da_0_m_req = s1_cmul3_m2c_da_0_req;
  assign s1_cmul3_m2c_da_0_ack = s1_cmul3_m2c_da_0_m_ack;
  assign s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_req = s1_cmul3_m2c_da_0_m_req;
  assign s1_cmul3_m2c_da_0_m_ack = s1_cmul3_m2c_da_0_to_s1_cmul3_cat_im_ack;
  always @(*) begin
    s1_cmul3_cat_re_0_eb_state_nxt = s1_cmul3_cat_re_0_eb_state;
    case(s1_cmul3_cat_re_0_eb_state)
      5'h14 : begin
        if(s1_cmul3_cat_re_0_req) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_cmul3_cat_re_0_req) && s1_cmul3_cat_re_0_m_ack)) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul3_cat_re_0_req && (! s1_cmul3_cat_re_0_m_ack))) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_cmul3_cat_re_0_req && s1_cmul3_cat_re_0_m_ack)) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_cmul3_cat_re_0_m_ack) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_cmul3_cat_re_0_req) && s1_cmul3_cat_re_0_m_ack)) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul3_cat_re_0_req && (! s1_cmul3_cat_re_0_m_ack))) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_cmul3_cat_re_0_req && s1_cmul3_cat_re_0_m_ack)) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_cmul3_cat_re_0_m_ack) begin
          s1_cmul3_cat_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_cmul3_cat_re_0_eb_en0 = (s1_cmul3_cat_re_0_eb_state[2] && s1_cmul3_cat_re_0_req);
  assign s1_cmul3_cat_re_0_eb_en1 = (s1_cmul3_cat_re_0_eb_state[1] && s1_cmul3_cat_re_0_req);
  assign s1_cmul3_cat_re_0_eb_sel = s1_cmul3_cat_re_0_eb_state[0];
  assign s1_cmul3_cat_re_0_ack = s1_cmul3_cat_re_0_eb_state[4];
  assign s1_cmul3_cat_re_0_m_req = s1_cmul3_cat_re_0_eb_state[3];
  assign s1_cmul3_cat_re_0 = (s1_cmul3_cat_re_0_eb_sel ? s1_cmul3_cat_re_0_eb_r1 : s1_cmul3_cat_re_0_eb_r0);
  assign s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_req = s1_cmul3_cat_re_0_m_req;
  assign s1_cmul3_cat_re_0_m_ack = s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_ack;
  always @(*) begin
    s1_cmul3_cat_im_0_eb_state_nxt = s1_cmul3_cat_im_0_eb_state;
    case(s1_cmul3_cat_im_0_eb_state)
      5'h14 : begin
        if(s1_cmul3_cat_im_0_req) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_cmul3_cat_im_0_req) && s1_cmul3_cat_im_0_m_ack)) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul3_cat_im_0_req && (! s1_cmul3_cat_im_0_m_ack))) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_cmul3_cat_im_0_req && s1_cmul3_cat_im_0_m_ack)) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_cmul3_cat_im_0_m_ack) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_cmul3_cat_im_0_req) && s1_cmul3_cat_im_0_m_ack)) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_cmul3_cat_im_0_req && (! s1_cmul3_cat_im_0_m_ack))) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_cmul3_cat_im_0_req && s1_cmul3_cat_im_0_m_ack)) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_cmul3_cat_im_0_m_ack) begin
          s1_cmul3_cat_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_cmul3_cat_im_0_eb_en0 = (s1_cmul3_cat_im_0_eb_state[2] && s1_cmul3_cat_im_0_req);
  assign s1_cmul3_cat_im_0_eb_en1 = (s1_cmul3_cat_im_0_eb_state[1] && s1_cmul3_cat_im_0_req);
  assign s1_cmul3_cat_im_0_eb_sel = s1_cmul3_cat_im_0_eb_state[0];
  assign s1_cmul3_cat_im_0_ack = s1_cmul3_cat_im_0_eb_state[4];
  assign s1_cmul3_cat_im_0_m_req = s1_cmul3_cat_im_0_eb_state[3];
  assign s1_cmul3_cat_im_0 = (s1_cmul3_cat_im_0_eb_sel ? s1_cmul3_cat_im_0_eb_r1 : s1_cmul3_cat_im_0_eb_r0);
  assign s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_req = s1_cmul3_cat_im_0_m_req;
  assign s1_cmul3_cat_im_0_m_ack = s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_ack;
  assign cfg_s1_cmul3_mas_re_m_req = cfg_s1_cmul3_mas_re_req;
  assign cfg_s1_cmul3_mas_re_ack = cfg_s1_cmul3_mas_re_m_ack;
  assign cfg_s1_cmul3_mas_re_to_s1_cmul3_mas_re_req = cfg_s1_cmul3_mas_re_m_req;
  assign cfg_s1_cmul3_mas_re_m_ack = cfg_s1_cmul3_mas_re_to_s1_cmul3_mas_re_ack;
  assign s1_cmul3_mas_re_0_m_req = s1_cmul3_mas_re_0_req;
  assign s1_cmul3_mas_re_0_ack = s1_cmul3_mas_re_0_m_ack;
  assign s1_cmul3_mas_re_0_to_s1_r4_a1_re_req = (s1_cmul3_mas_re_0_m_req && (! s1_cmul3_mas_re_0_fork_ack_r_0));
  assign s1_cmul3_mas_re_0_fork_ack_s_0 = (s1_cmul3_mas_re_0_to_s1_r4_a1_re_ack || (! s1_cmul3_mas_re_0_to_s1_r4_a1_re_req));
  assign s1_cmul3_mas_re_0_to_s1_r4_a3_re_req = (s1_cmul3_mas_re_0_m_req && (! s1_cmul3_mas_re_0_fork_ack_r_1));
  assign s1_cmul3_mas_re_0_fork_ack_s_1 = (s1_cmul3_mas_re_0_to_s1_r4_a3_re_ack || (! s1_cmul3_mas_re_0_to_s1_r4_a3_re_req));
  assign s1_cmul3_mas_re_0_to_s1_r4_byp3_re_req = (s1_cmul3_mas_re_0_m_req && (! s1_cmul3_mas_re_0_fork_ack_r_2));
  assign s1_cmul3_mas_re_0_fork_ack_s_2 = (s1_cmul3_mas_re_0_to_s1_r4_byp3_re_ack || (! s1_cmul3_mas_re_0_to_s1_r4_byp3_re_req));
  assign s1_cmul3_mas_re_0_m_ack = ((s1_cmul3_mas_re_0_fork_ack_s_0 && s1_cmul3_mas_re_0_fork_ack_s_1) && s1_cmul3_mas_re_0_fork_ack_s_2);
  assign cfg_s1_cmul3_mas_im_m_req = cfg_s1_cmul3_mas_im_req;
  assign cfg_s1_cmul3_mas_im_ack = cfg_s1_cmul3_mas_im_m_ack;
  assign cfg_s1_cmul3_mas_im_to_s1_cmul3_mas_im_req = cfg_s1_cmul3_mas_im_m_req;
  assign cfg_s1_cmul3_mas_im_m_ack = cfg_s1_cmul3_mas_im_to_s1_cmul3_mas_im_ack;
  assign s1_cmul3_mas_im_0_m_req = s1_cmul3_mas_im_0_req;
  assign s1_cmul3_mas_im_0_ack = s1_cmul3_mas_im_0_m_ack;
  assign s1_cmul3_mas_im_0_to_s1_r4_a1_im_req = (s1_cmul3_mas_im_0_m_req && (! s1_cmul3_mas_im_0_fork_ack_r_0));
  assign s1_cmul3_mas_im_0_fork_ack_s_0 = (s1_cmul3_mas_im_0_to_s1_r4_a1_im_ack || (! s1_cmul3_mas_im_0_to_s1_r4_a1_im_req));
  assign s1_cmul3_mas_im_0_to_s1_r4_a3_im_req = (s1_cmul3_mas_im_0_m_req && (! s1_cmul3_mas_im_0_fork_ack_r_1));
  assign s1_cmul3_mas_im_0_fork_ack_s_1 = (s1_cmul3_mas_im_0_to_s1_r4_a3_im_ack || (! s1_cmul3_mas_im_0_to_s1_r4_a3_im_req));
  assign s1_cmul3_mas_im_0_to_s1_r4_byp3_im_req = (s1_cmul3_mas_im_0_m_req && (! s1_cmul3_mas_im_0_fork_ack_r_2));
  assign s1_cmul3_mas_im_0_fork_ack_s_2 = (s1_cmul3_mas_im_0_to_s1_r4_byp3_im_ack || (! s1_cmul3_mas_im_0_to_s1_r4_byp3_im_req));
  assign s1_cmul3_mas_im_0_m_ack = ((s1_cmul3_mas_im_0_fork_ack_s_0 && s1_cmul3_mas_im_0_fork_ack_s_1) && s1_cmul3_mas_im_0_fork_ack_s_2);
  always @(*) begin
    s0_r4_a0_re_0_eb_state_nxt = s0_r4_a0_re_0_eb_state;
    case(s0_r4_a0_re_0_eb_state)
      5'h14 : begin
        if(s0_r4_a0_re_0_req) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_r4_a0_re_0_req) && s0_r4_a0_re_0_m_ack)) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a0_re_0_req && (! s0_r4_a0_re_0_m_ack))) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_r4_a0_re_0_req && s0_r4_a0_re_0_m_ack)) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_r4_a0_re_0_m_ack) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_r4_a0_re_0_req) && s0_r4_a0_re_0_m_ack)) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a0_re_0_req && (! s0_r4_a0_re_0_m_ack))) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_r4_a0_re_0_req && s0_r4_a0_re_0_m_ack)) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_r4_a0_re_0_m_ack) begin
          s0_r4_a0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_r4_a0_re_0_eb_en0 = (s0_r4_a0_re_0_eb_state[2] && s0_r4_a0_re_0_req);
  assign s0_r4_a0_re_0_eb_en1 = (s0_r4_a0_re_0_eb_state[1] && s0_r4_a0_re_0_req);
  assign s0_r4_a0_re_0_eb_sel = s0_r4_a0_re_0_eb_state[0];
  assign s0_r4_a0_re_0_ack = s0_r4_a0_re_0_eb_state[4];
  assign s0_r4_a0_re_0_m_req = s0_r4_a0_re_0_eb_state[3];
  assign s0_r4_a0_re_0 = (s0_r4_a0_re_0_eb_sel ? s0_r4_a0_re_0_eb_r1 : s0_r4_a0_re_0_eb_r0);
  assign s0_r4_a0_re_0_to_s0_r4_c0_re_req = (s0_r4_a0_re_0_m_req && (! s0_r4_a0_re_0_fork_ack_r_0));
  assign s0_r4_a0_re_0_fork_ack_s_0 = (s0_r4_a0_re_0_to_s0_r4_c0_re_ack || (! s0_r4_a0_re_0_to_s0_r4_c0_re_req));
  assign s0_r4_a0_re_0_to_s0_r4_c2_re_req = (s0_r4_a0_re_0_m_req && (! s0_r4_a0_re_0_fork_ack_r_1));
  assign s0_r4_a0_re_0_fork_ack_s_1 = (s0_r4_a0_re_0_to_s0_r4_c2_re_ack || (! s0_r4_a0_re_0_to_s0_r4_c2_re_req));
  assign s0_r4_a0_re_0_m_ack = (s0_r4_a0_re_0_fork_ack_s_0 && s0_r4_a0_re_0_fork_ack_s_1);
  always @(*) begin
    s0_r4_a0_im_0_eb_state_nxt = s0_r4_a0_im_0_eb_state;
    case(s0_r4_a0_im_0_eb_state)
      5'h14 : begin
        if(s0_r4_a0_im_0_req) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_r4_a0_im_0_req) && s0_r4_a0_im_0_m_ack)) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a0_im_0_req && (! s0_r4_a0_im_0_m_ack))) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_r4_a0_im_0_req && s0_r4_a0_im_0_m_ack)) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_r4_a0_im_0_m_ack) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_r4_a0_im_0_req) && s0_r4_a0_im_0_m_ack)) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a0_im_0_req && (! s0_r4_a0_im_0_m_ack))) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_r4_a0_im_0_req && s0_r4_a0_im_0_m_ack)) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_r4_a0_im_0_m_ack) begin
          s0_r4_a0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_r4_a0_im_0_eb_en0 = (s0_r4_a0_im_0_eb_state[2] && s0_r4_a0_im_0_req);
  assign s0_r4_a0_im_0_eb_en1 = (s0_r4_a0_im_0_eb_state[1] && s0_r4_a0_im_0_req);
  assign s0_r4_a0_im_0_eb_sel = s0_r4_a0_im_0_eb_state[0];
  assign s0_r4_a0_im_0_ack = s0_r4_a0_im_0_eb_state[4];
  assign s0_r4_a0_im_0_m_req = s0_r4_a0_im_0_eb_state[3];
  assign s0_r4_a0_im_0 = (s0_r4_a0_im_0_eb_sel ? s0_r4_a0_im_0_eb_r1 : s0_r4_a0_im_0_eb_r0);
  assign s0_r4_a0_im_0_to_s0_r4_c0_im_req = (s0_r4_a0_im_0_m_req && (! s0_r4_a0_im_0_fork_ack_r_0));
  assign s0_r4_a0_im_0_fork_ack_s_0 = (s0_r4_a0_im_0_to_s0_r4_c0_im_ack || (! s0_r4_a0_im_0_to_s0_r4_c0_im_req));
  assign s0_r4_a0_im_0_to_s0_r4_c2_im_req = (s0_r4_a0_im_0_m_req && (! s0_r4_a0_im_0_fork_ack_r_1));
  assign s0_r4_a0_im_0_fork_ack_s_1 = (s0_r4_a0_im_0_to_s0_r4_c2_im_ack || (! s0_r4_a0_im_0_to_s0_r4_c2_im_req));
  assign s0_r4_a0_im_0_m_ack = (s0_r4_a0_im_0_fork_ack_s_0 && s0_r4_a0_im_0_fork_ack_s_1);
  always @(*) begin
    s0_r4_a1_re_0_eb_state_nxt = s0_r4_a1_re_0_eb_state;
    case(s0_r4_a1_re_0_eb_state)
      5'h14 : begin
        if(s0_r4_a1_re_0_req) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_r4_a1_re_0_req) && s0_r4_a1_re_0_m_ack)) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a1_re_0_req && (! s0_r4_a1_re_0_m_ack))) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_r4_a1_re_0_req && s0_r4_a1_re_0_m_ack)) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_r4_a1_re_0_m_ack) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_r4_a1_re_0_req) && s0_r4_a1_re_0_m_ack)) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a1_re_0_req && (! s0_r4_a1_re_0_m_ack))) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_r4_a1_re_0_req && s0_r4_a1_re_0_m_ack)) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_r4_a1_re_0_m_ack) begin
          s0_r4_a1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_r4_a1_re_0_eb_en0 = (s0_r4_a1_re_0_eb_state[2] && s0_r4_a1_re_0_req);
  assign s0_r4_a1_re_0_eb_en1 = (s0_r4_a1_re_0_eb_state[1] && s0_r4_a1_re_0_req);
  assign s0_r4_a1_re_0_eb_sel = s0_r4_a1_re_0_eb_state[0];
  assign s0_r4_a1_re_0_ack = s0_r4_a1_re_0_eb_state[4];
  assign s0_r4_a1_re_0_m_req = s0_r4_a1_re_0_eb_state[3];
  assign s0_r4_a1_re_0 = (s0_r4_a1_re_0_eb_sel ? s0_r4_a1_re_0_eb_r1 : s0_r4_a1_re_0_eb_r0);
  assign s0_r4_a1_re_0_to_s0_r4_c0_re_req = (s0_r4_a1_re_0_m_req && (! s0_r4_a1_re_0_fork_ack_r_0));
  assign s0_r4_a1_re_0_fork_ack_s_0 = (s0_r4_a1_re_0_to_s0_r4_c0_re_ack || (! s0_r4_a1_re_0_to_s0_r4_c0_re_req));
  assign s0_r4_a1_re_0_to_s0_r4_c2_re_req = (s0_r4_a1_re_0_m_req && (! s0_r4_a1_re_0_fork_ack_r_1));
  assign s0_r4_a1_re_0_fork_ack_s_1 = (s0_r4_a1_re_0_to_s0_r4_c2_re_ack || (! s0_r4_a1_re_0_to_s0_r4_c2_re_req));
  assign s0_r4_a1_re_0_m_ack = (s0_r4_a1_re_0_fork_ack_s_0 && s0_r4_a1_re_0_fork_ack_s_1);
  always @(*) begin
    s0_r4_a1_im_0_eb_state_nxt = s0_r4_a1_im_0_eb_state;
    case(s0_r4_a1_im_0_eb_state)
      5'h14 : begin
        if(s0_r4_a1_im_0_req) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_r4_a1_im_0_req) && s0_r4_a1_im_0_m_ack)) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a1_im_0_req && (! s0_r4_a1_im_0_m_ack))) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_r4_a1_im_0_req && s0_r4_a1_im_0_m_ack)) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_r4_a1_im_0_m_ack) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_r4_a1_im_0_req) && s0_r4_a1_im_0_m_ack)) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a1_im_0_req && (! s0_r4_a1_im_0_m_ack))) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_r4_a1_im_0_req && s0_r4_a1_im_0_m_ack)) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_r4_a1_im_0_m_ack) begin
          s0_r4_a1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_r4_a1_im_0_eb_en0 = (s0_r4_a1_im_0_eb_state[2] && s0_r4_a1_im_0_req);
  assign s0_r4_a1_im_0_eb_en1 = (s0_r4_a1_im_0_eb_state[1] && s0_r4_a1_im_0_req);
  assign s0_r4_a1_im_0_eb_sel = s0_r4_a1_im_0_eb_state[0];
  assign s0_r4_a1_im_0_ack = s0_r4_a1_im_0_eb_state[4];
  assign s0_r4_a1_im_0_m_req = s0_r4_a1_im_0_eb_state[3];
  assign s0_r4_a1_im_0 = (s0_r4_a1_im_0_eb_sel ? s0_r4_a1_im_0_eb_r1 : s0_r4_a1_im_0_eb_r0);
  assign s0_r4_a1_im_0_to_s0_r4_c0_im_req = (s0_r4_a1_im_0_m_req && (! s0_r4_a1_im_0_fork_ack_r_0));
  assign s0_r4_a1_im_0_fork_ack_s_0 = (s0_r4_a1_im_0_to_s0_r4_c0_im_ack || (! s0_r4_a1_im_0_to_s0_r4_c0_im_req));
  assign s0_r4_a1_im_0_to_s0_r4_c2_im_req = (s0_r4_a1_im_0_m_req && (! s0_r4_a1_im_0_fork_ack_r_1));
  assign s0_r4_a1_im_0_fork_ack_s_1 = (s0_r4_a1_im_0_to_s0_r4_c2_im_ack || (! s0_r4_a1_im_0_to_s0_r4_c2_im_req));
  assign s0_r4_a1_im_0_m_ack = (s0_r4_a1_im_0_fork_ack_s_0 && s0_r4_a1_im_0_fork_ack_s_1);
  always @(*) begin
    s0_r4_a2_re_0_eb_state_nxt = s0_r4_a2_re_0_eb_state;
    case(s0_r4_a2_re_0_eb_state)
      5'h14 : begin
        if(s0_r4_a2_re_0_req) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_r4_a2_re_0_req) && s0_r4_a2_re_0_m_ack)) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a2_re_0_req && (! s0_r4_a2_re_0_m_ack))) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_r4_a2_re_0_req && s0_r4_a2_re_0_m_ack)) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_r4_a2_re_0_m_ack) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_r4_a2_re_0_req) && s0_r4_a2_re_0_m_ack)) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a2_re_0_req && (! s0_r4_a2_re_0_m_ack))) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_r4_a2_re_0_req && s0_r4_a2_re_0_m_ack)) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_r4_a2_re_0_m_ack) begin
          s0_r4_a2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_r4_a2_re_0_eb_en0 = (s0_r4_a2_re_0_eb_state[2] && s0_r4_a2_re_0_req);
  assign s0_r4_a2_re_0_eb_en1 = (s0_r4_a2_re_0_eb_state[1] && s0_r4_a2_re_0_req);
  assign s0_r4_a2_re_0_eb_sel = s0_r4_a2_re_0_eb_state[0];
  assign s0_r4_a2_re_0_ack = s0_r4_a2_re_0_eb_state[4];
  assign s0_r4_a2_re_0_m_req = s0_r4_a2_re_0_eb_state[3];
  assign s0_r4_a2_re_0 = (s0_r4_a2_re_0_eb_sel ? s0_r4_a2_re_0_eb_r1 : s0_r4_a2_re_0_eb_r0);
  assign s0_r4_a2_re_0_to_s0_r4_c1_re_req = (s0_r4_a2_re_0_m_req && (! s0_r4_a2_re_0_fork_ack_r_0));
  assign s0_r4_a2_re_0_fork_ack_s_0 = (s0_r4_a2_re_0_to_s0_r4_c1_re_ack || (! s0_r4_a2_re_0_to_s0_r4_c1_re_req));
  assign s0_r4_a2_re_0_to_s0_r4_c3_re_req = (s0_r4_a2_re_0_m_req && (! s0_r4_a2_re_0_fork_ack_r_1));
  assign s0_r4_a2_re_0_fork_ack_s_1 = (s0_r4_a2_re_0_to_s0_r4_c3_re_ack || (! s0_r4_a2_re_0_to_s0_r4_c3_re_req));
  assign s0_r4_a2_re_0_m_ack = (s0_r4_a2_re_0_fork_ack_s_0 && s0_r4_a2_re_0_fork_ack_s_1);
  always @(*) begin
    s0_r4_a2_im_0_eb_state_nxt = s0_r4_a2_im_0_eb_state;
    case(s0_r4_a2_im_0_eb_state)
      5'h14 : begin
        if(s0_r4_a2_im_0_req) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_r4_a2_im_0_req) && s0_r4_a2_im_0_m_ack)) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a2_im_0_req && (! s0_r4_a2_im_0_m_ack))) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_r4_a2_im_0_req && s0_r4_a2_im_0_m_ack)) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_r4_a2_im_0_m_ack) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_r4_a2_im_0_req) && s0_r4_a2_im_0_m_ack)) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a2_im_0_req && (! s0_r4_a2_im_0_m_ack))) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_r4_a2_im_0_req && s0_r4_a2_im_0_m_ack)) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_r4_a2_im_0_m_ack) begin
          s0_r4_a2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_r4_a2_im_0_eb_en0 = (s0_r4_a2_im_0_eb_state[2] && s0_r4_a2_im_0_req);
  assign s0_r4_a2_im_0_eb_en1 = (s0_r4_a2_im_0_eb_state[1] && s0_r4_a2_im_0_req);
  assign s0_r4_a2_im_0_eb_sel = s0_r4_a2_im_0_eb_state[0];
  assign s0_r4_a2_im_0_ack = s0_r4_a2_im_0_eb_state[4];
  assign s0_r4_a2_im_0_m_req = s0_r4_a2_im_0_eb_state[3];
  assign s0_r4_a2_im_0 = (s0_r4_a2_im_0_eb_sel ? s0_r4_a2_im_0_eb_r1 : s0_r4_a2_im_0_eb_r0);
  assign s0_r4_a2_im_0_to_s0_r4_c1_im_req = (s0_r4_a2_im_0_m_req && (! s0_r4_a2_im_0_fork_ack_r_0));
  assign s0_r4_a2_im_0_fork_ack_s_0 = (s0_r4_a2_im_0_to_s0_r4_c1_im_ack || (! s0_r4_a2_im_0_to_s0_r4_c1_im_req));
  assign s0_r4_a2_im_0_to_s0_r4_c3_im_req = (s0_r4_a2_im_0_m_req && (! s0_r4_a2_im_0_fork_ack_r_1));
  assign s0_r4_a2_im_0_fork_ack_s_1 = (s0_r4_a2_im_0_to_s0_r4_c3_im_ack || (! s0_r4_a2_im_0_to_s0_r4_c3_im_req));
  assign s0_r4_a2_im_0_m_ack = (s0_r4_a2_im_0_fork_ack_s_0 && s0_r4_a2_im_0_fork_ack_s_1);
  always @(*) begin
    s0_r4_a3_re_0_eb_state_nxt = s0_r4_a3_re_0_eb_state;
    case(s0_r4_a3_re_0_eb_state)
      5'h14 : begin
        if(s0_r4_a3_re_0_req) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_r4_a3_re_0_req) && s0_r4_a3_re_0_m_ack)) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a3_re_0_req && (! s0_r4_a3_re_0_m_ack))) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_r4_a3_re_0_req && s0_r4_a3_re_0_m_ack)) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_r4_a3_re_0_m_ack) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_r4_a3_re_0_req) && s0_r4_a3_re_0_m_ack)) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a3_re_0_req && (! s0_r4_a3_re_0_m_ack))) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_r4_a3_re_0_req && s0_r4_a3_re_0_m_ack)) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_r4_a3_re_0_m_ack) begin
          s0_r4_a3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_r4_a3_re_0_eb_en0 = (s0_r4_a3_re_0_eb_state[2] && s0_r4_a3_re_0_req);
  assign s0_r4_a3_re_0_eb_en1 = (s0_r4_a3_re_0_eb_state[1] && s0_r4_a3_re_0_req);
  assign s0_r4_a3_re_0_eb_sel = s0_r4_a3_re_0_eb_state[0];
  assign s0_r4_a3_re_0_ack = s0_r4_a3_re_0_eb_state[4];
  assign s0_r4_a3_re_0_m_req = s0_r4_a3_re_0_eb_state[3];
  assign s0_r4_a3_re_0 = (s0_r4_a3_re_0_eb_sel ? s0_r4_a3_re_0_eb_r1 : s0_r4_a3_re_0_eb_r0);
  assign s0_r4_a3_re_0_to_s0_r4_c1_im_req = (s0_r4_a3_re_0_m_req && (! s0_r4_a3_re_0_fork_ack_r_0));
  assign s0_r4_a3_re_0_fork_ack_s_0 = (s0_r4_a3_re_0_to_s0_r4_c1_im_ack || (! s0_r4_a3_re_0_to_s0_r4_c1_im_req));
  assign s0_r4_a3_re_0_to_s0_r4_c3_im_req = (s0_r4_a3_re_0_m_req && (! s0_r4_a3_re_0_fork_ack_r_1));
  assign s0_r4_a3_re_0_fork_ack_s_1 = (s0_r4_a3_re_0_to_s0_r4_c3_im_ack || (! s0_r4_a3_re_0_to_s0_r4_c3_im_req));
  assign s0_r4_a3_re_0_m_ack = (s0_r4_a3_re_0_fork_ack_s_0 && s0_r4_a3_re_0_fork_ack_s_1);
  always @(*) begin
    s0_r4_a3_im_0_eb_state_nxt = s0_r4_a3_im_0_eb_state;
    case(s0_r4_a3_im_0_eb_state)
      5'h14 : begin
        if(s0_r4_a3_im_0_req) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_r4_a3_im_0_req) && s0_r4_a3_im_0_m_ack)) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a3_im_0_req && (! s0_r4_a3_im_0_m_ack))) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_r4_a3_im_0_req && s0_r4_a3_im_0_m_ack)) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_r4_a3_im_0_m_ack) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_r4_a3_im_0_req) && s0_r4_a3_im_0_m_ack)) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_r4_a3_im_0_req && (! s0_r4_a3_im_0_m_ack))) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_r4_a3_im_0_req && s0_r4_a3_im_0_m_ack)) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_r4_a3_im_0_m_ack) begin
          s0_r4_a3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_r4_a3_im_0_eb_en0 = (s0_r4_a3_im_0_eb_state[2] && s0_r4_a3_im_0_req);
  assign s0_r4_a3_im_0_eb_en1 = (s0_r4_a3_im_0_eb_state[1] && s0_r4_a3_im_0_req);
  assign s0_r4_a3_im_0_eb_sel = s0_r4_a3_im_0_eb_state[0];
  assign s0_r4_a3_im_0_ack = s0_r4_a3_im_0_eb_state[4];
  assign s0_r4_a3_im_0_m_req = s0_r4_a3_im_0_eb_state[3];
  assign s0_r4_a3_im_0 = (s0_r4_a3_im_0_eb_sel ? s0_r4_a3_im_0_eb_r1 : s0_r4_a3_im_0_eb_r0);
  assign s0_r4_a3_im_0_to_s0_r4_c1_re_req = (s0_r4_a3_im_0_m_req && (! s0_r4_a3_im_0_fork_ack_r_0));
  assign s0_r4_a3_im_0_fork_ack_s_0 = (s0_r4_a3_im_0_to_s0_r4_c1_re_ack || (! s0_r4_a3_im_0_to_s0_r4_c1_re_req));
  assign s0_r4_a3_im_0_to_s0_r4_c3_re_req = (s0_r4_a3_im_0_m_req && (! s0_r4_a3_im_0_fork_ack_r_1));
  assign s0_r4_a3_im_0_fork_ack_s_1 = (s0_r4_a3_im_0_to_s0_r4_c3_re_ack || (! s0_r4_a3_im_0_to_s0_r4_c3_re_req));
  assign s0_r4_a3_im_0_m_ack = (s0_r4_a3_im_0_fork_ack_s_0 && s0_r4_a3_im_0_fork_ack_s_1);
  assign s0_r4_c0_re_0_m_req = s0_r4_c0_re_0_req;
  assign s0_r4_c0_re_0_ack = s0_r4_c0_re_0_m_ack;
  assign s0_r4_c0_re_0_to_s0_r4_byp0_re_req = s0_r4_c0_re_0_m_req;
  assign s0_r4_c0_re_0_m_ack = s0_r4_c0_re_0_to_s0_r4_byp0_re_ack;
  assign s0_r4_c0_im_0_m_req = s0_r4_c0_im_0_req;
  assign s0_r4_c0_im_0_ack = s0_r4_c0_im_0_m_ack;
  assign s0_r4_c0_im_0_to_s0_r4_byp0_im_req = s0_r4_c0_im_0_m_req;
  assign s0_r4_c0_im_0_m_ack = s0_r4_c0_im_0_to_s0_r4_byp0_im_ack;
  assign s0_r4_c1_re_0_m_req = s0_r4_c1_re_0_req;
  assign s0_r4_c1_re_0_ack = s0_r4_c1_re_0_m_ack;
  assign s0_r4_c1_re_0_to_s0_r4_byp1_re_req = s0_r4_c1_re_0_m_req;
  assign s0_r4_c1_re_0_m_ack = s0_r4_c1_re_0_to_s0_r4_byp1_re_ack;
  assign s0_r4_c1_im_0_m_req = s0_r4_c1_im_0_req;
  assign s0_r4_c1_im_0_ack = s0_r4_c1_im_0_m_ack;
  assign s0_r4_c1_im_0_to_s0_r4_byp1_im_req = s0_r4_c1_im_0_m_req;
  assign s0_r4_c1_im_0_m_ack = s0_r4_c1_im_0_to_s0_r4_byp1_im_ack;
  assign s0_r4_c2_re_0_m_req = s0_r4_c2_re_0_req;
  assign s0_r4_c2_re_0_ack = s0_r4_c2_re_0_m_ack;
  assign s0_r4_c2_re_0_to_s0_r4_byp2_re_req = s0_r4_c2_re_0_m_req;
  assign s0_r4_c2_re_0_m_ack = s0_r4_c2_re_0_to_s0_r4_byp2_re_ack;
  assign s0_r4_c2_im_0_m_req = s0_r4_c2_im_0_req;
  assign s0_r4_c2_im_0_ack = s0_r4_c2_im_0_m_ack;
  assign s0_r4_c2_im_0_to_s0_r4_byp2_im_req = s0_r4_c2_im_0_m_req;
  assign s0_r4_c2_im_0_m_ack = s0_r4_c2_im_0_to_s0_r4_byp2_im_ack;
  assign s0_r4_c3_re_0_m_req = s0_r4_c3_re_0_req;
  assign s0_r4_c3_re_0_ack = s0_r4_c3_re_0_m_ack;
  assign s0_r4_c3_re_0_to_s0_r4_byp3_re_req = s0_r4_c3_re_0_m_req;
  assign s0_r4_c3_re_0_m_ack = s0_r4_c3_re_0_to_s0_r4_byp3_re_ack;
  assign s0_r4_c3_im_0_m_req = s0_r4_c3_im_0_req;
  assign s0_r4_c3_im_0_ack = s0_r4_c3_im_0_m_ack;
  assign s0_r4_c3_im_0_to_s0_r4_byp3_im_req = s0_r4_c3_im_0_m_req;
  assign s0_r4_c3_im_0_m_ack = s0_r4_c3_im_0_to_s0_r4_byp3_im_ack;
  assign cfg_s0_r4_byp0_re_m_req = cfg_s0_r4_byp0_re_req;
  assign cfg_s0_r4_byp0_re_ack = cfg_s0_r4_byp0_re_m_ack;
  assign cfg_s0_r4_byp0_re_to_s0_r4_byp0_re_req = cfg_s0_r4_byp0_re_m_req;
  assign cfg_s0_r4_byp0_re_m_ack = cfg_s0_r4_byp0_re_to_s0_r4_byp0_re_ack;
  assign cfg_s0_r4_byp0_im_m_req = cfg_s0_r4_byp0_im_req;
  assign cfg_s0_r4_byp0_im_ack = cfg_s0_r4_byp0_im_m_ack;
  assign cfg_s0_r4_byp0_im_to_s0_r4_byp0_im_req = cfg_s0_r4_byp0_im_m_req;
  assign cfg_s0_r4_byp0_im_m_ack = cfg_s0_r4_byp0_im_to_s0_r4_byp0_im_ack;
  assign s0_r4_byp0_re_0_ack = ((! s0_r4_byp0_re_0_eb_valid) || s0_r4_byp0_re_0_m_ack);
  assign s0_r4_byp0_re_0_eb_en = (s0_r4_byp0_re_0_req && s0_r4_byp0_re_0_ack);
  assign s0_r4_byp0_re_0_m_req = s0_r4_byp0_re_0_eb_valid;
  assign s0_r4_byp0_re_0 = s0_r4_byp0_re_0_eb_r;
  assign s0_r4_byp0_re_0_to_s0_bs0_re_req = s0_r4_byp0_re_0_m_req;
  assign s0_r4_byp0_re_0_m_ack = s0_r4_byp0_re_0_to_s0_bs0_re_ack;
  assign s0_r4_byp0_im_0_ack = ((! s0_r4_byp0_im_0_eb_valid) || s0_r4_byp0_im_0_m_ack);
  assign s0_r4_byp0_im_0_eb_en = (s0_r4_byp0_im_0_req && s0_r4_byp0_im_0_ack);
  assign s0_r4_byp0_im_0_m_req = s0_r4_byp0_im_0_eb_valid;
  assign s0_r4_byp0_im_0 = s0_r4_byp0_im_0_eb_r;
  assign s0_r4_byp0_im_0_to_s0_bs0_im_req = s0_r4_byp0_im_0_m_req;
  assign s0_r4_byp0_im_0_m_ack = s0_r4_byp0_im_0_to_s0_bs0_im_ack;
  assign cfg_s0_r4_byp1_re_m_req = cfg_s0_r4_byp1_re_req;
  assign cfg_s0_r4_byp1_re_ack = cfg_s0_r4_byp1_re_m_ack;
  assign cfg_s0_r4_byp1_re_to_s0_r4_byp1_re_req = cfg_s0_r4_byp1_re_m_req;
  assign cfg_s0_r4_byp1_re_m_ack = cfg_s0_r4_byp1_re_to_s0_r4_byp1_re_ack;
  assign cfg_s0_r4_byp1_im_m_req = cfg_s0_r4_byp1_im_req;
  assign cfg_s0_r4_byp1_im_ack = cfg_s0_r4_byp1_im_m_ack;
  assign cfg_s0_r4_byp1_im_to_s0_r4_byp1_im_req = cfg_s0_r4_byp1_im_m_req;
  assign cfg_s0_r4_byp1_im_m_ack = cfg_s0_r4_byp1_im_to_s0_r4_byp1_im_ack;
  assign s0_r4_byp1_re_0_ack = ((! s0_r4_byp1_re_0_eb_valid) || s0_r4_byp1_re_0_m_ack);
  assign s0_r4_byp1_re_0_eb_en = (s0_r4_byp1_re_0_req && s0_r4_byp1_re_0_ack);
  assign s0_r4_byp1_re_0_m_req = s0_r4_byp1_re_0_eb_valid;
  assign s0_r4_byp1_re_0 = s0_r4_byp1_re_0_eb_r;
  assign s0_r4_byp1_re_0_to_s0_bs1_re_req = s0_r4_byp1_re_0_m_req;
  assign s0_r4_byp1_re_0_m_ack = s0_r4_byp1_re_0_to_s0_bs1_re_ack;
  assign s0_r4_byp1_im_0_ack = ((! s0_r4_byp1_im_0_eb_valid) || s0_r4_byp1_im_0_m_ack);
  assign s0_r4_byp1_im_0_eb_en = (s0_r4_byp1_im_0_req && s0_r4_byp1_im_0_ack);
  assign s0_r4_byp1_im_0_m_req = s0_r4_byp1_im_0_eb_valid;
  assign s0_r4_byp1_im_0 = s0_r4_byp1_im_0_eb_r;
  assign s0_r4_byp1_im_0_to_s0_bs1_im_req = s0_r4_byp1_im_0_m_req;
  assign s0_r4_byp1_im_0_m_ack = s0_r4_byp1_im_0_to_s0_bs1_im_ack;
  assign cfg_s0_r4_byp2_re_m_req = cfg_s0_r4_byp2_re_req;
  assign cfg_s0_r4_byp2_re_ack = cfg_s0_r4_byp2_re_m_ack;
  assign cfg_s0_r4_byp2_re_to_s0_r4_byp2_re_req = cfg_s0_r4_byp2_re_m_req;
  assign cfg_s0_r4_byp2_re_m_ack = cfg_s0_r4_byp2_re_to_s0_r4_byp2_re_ack;
  assign cfg_s0_r4_byp2_im_m_req = cfg_s0_r4_byp2_im_req;
  assign cfg_s0_r4_byp2_im_ack = cfg_s0_r4_byp2_im_m_ack;
  assign cfg_s0_r4_byp2_im_to_s0_r4_byp2_im_req = cfg_s0_r4_byp2_im_m_req;
  assign cfg_s0_r4_byp2_im_m_ack = cfg_s0_r4_byp2_im_to_s0_r4_byp2_im_ack;
  assign s0_r4_byp2_re_0_ack = ((! s0_r4_byp2_re_0_eb_valid) || s0_r4_byp2_re_0_m_ack);
  assign s0_r4_byp2_re_0_eb_en = (s0_r4_byp2_re_0_req && s0_r4_byp2_re_0_ack);
  assign s0_r4_byp2_re_0_m_req = s0_r4_byp2_re_0_eb_valid;
  assign s0_r4_byp2_re_0 = s0_r4_byp2_re_0_eb_r;
  assign s0_r4_byp2_re_0_to_s0_bs2_re_req = s0_r4_byp2_re_0_m_req;
  assign s0_r4_byp2_re_0_m_ack = s0_r4_byp2_re_0_to_s0_bs2_re_ack;
  assign s0_r4_byp2_im_0_ack = ((! s0_r4_byp2_im_0_eb_valid) || s0_r4_byp2_im_0_m_ack);
  assign s0_r4_byp2_im_0_eb_en = (s0_r4_byp2_im_0_req && s0_r4_byp2_im_0_ack);
  assign s0_r4_byp2_im_0_m_req = s0_r4_byp2_im_0_eb_valid;
  assign s0_r4_byp2_im_0 = s0_r4_byp2_im_0_eb_r;
  assign s0_r4_byp2_im_0_to_s0_bs2_im_req = s0_r4_byp2_im_0_m_req;
  assign s0_r4_byp2_im_0_m_ack = s0_r4_byp2_im_0_to_s0_bs2_im_ack;
  assign cfg_s0_r4_byp3_re_m_req = cfg_s0_r4_byp3_re_req;
  assign cfg_s0_r4_byp3_re_ack = cfg_s0_r4_byp3_re_m_ack;
  assign cfg_s0_r4_byp3_re_to_s0_r4_byp3_re_req = cfg_s0_r4_byp3_re_m_req;
  assign cfg_s0_r4_byp3_re_m_ack = cfg_s0_r4_byp3_re_to_s0_r4_byp3_re_ack;
  assign cfg_s0_r4_byp3_im_m_req = cfg_s0_r4_byp3_im_req;
  assign cfg_s0_r4_byp3_im_ack = cfg_s0_r4_byp3_im_m_ack;
  assign cfg_s0_r4_byp3_im_to_s0_r4_byp3_im_req = cfg_s0_r4_byp3_im_m_req;
  assign cfg_s0_r4_byp3_im_m_ack = cfg_s0_r4_byp3_im_to_s0_r4_byp3_im_ack;
  assign s0_r4_byp3_re_0_ack = ((! s0_r4_byp3_re_0_eb_valid) || s0_r4_byp3_re_0_m_ack);
  assign s0_r4_byp3_re_0_eb_en = (s0_r4_byp3_re_0_req && s0_r4_byp3_re_0_ack);
  assign s0_r4_byp3_re_0_m_req = s0_r4_byp3_re_0_eb_valid;
  assign s0_r4_byp3_re_0 = s0_r4_byp3_re_0_eb_r;
  assign s0_r4_byp3_re_0_to_s0_bs3_re_req = s0_r4_byp3_re_0_m_req;
  assign s0_r4_byp3_re_0_m_ack = s0_r4_byp3_re_0_to_s0_bs3_re_ack;
  assign s0_r4_byp3_im_0_ack = ((! s0_r4_byp3_im_0_eb_valid) || s0_r4_byp3_im_0_m_ack);
  assign s0_r4_byp3_im_0_eb_en = (s0_r4_byp3_im_0_req && s0_r4_byp3_im_0_ack);
  assign s0_r4_byp3_im_0_m_req = s0_r4_byp3_im_0_eb_valid;
  assign s0_r4_byp3_im_0 = s0_r4_byp3_im_0_eb_r;
  assign s0_r4_byp3_im_0_to_s0_bs3_im_req = s0_r4_byp3_im_0_m_req;
  assign s0_r4_byp3_im_0_m_ack = s0_r4_byp3_im_0_to_s0_bs3_im_ack;
  always @(*) begin
    s1_r4_a0_re_0_eb_state_nxt = s1_r4_a0_re_0_eb_state;
    case(s1_r4_a0_re_0_eb_state)
      5'h14 : begin
        if(s1_r4_a0_re_0_req) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_r4_a0_re_0_req) && s1_r4_a0_re_0_m_ack)) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a0_re_0_req && (! s1_r4_a0_re_0_m_ack))) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_r4_a0_re_0_req && s1_r4_a0_re_0_m_ack)) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_r4_a0_re_0_m_ack) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_r4_a0_re_0_req) && s1_r4_a0_re_0_m_ack)) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a0_re_0_req && (! s1_r4_a0_re_0_m_ack))) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_r4_a0_re_0_req && s1_r4_a0_re_0_m_ack)) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_r4_a0_re_0_m_ack) begin
          s1_r4_a0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_r4_a0_re_0_eb_en0 = (s1_r4_a0_re_0_eb_state[2] && s1_r4_a0_re_0_req);
  assign s1_r4_a0_re_0_eb_en1 = (s1_r4_a0_re_0_eb_state[1] && s1_r4_a0_re_0_req);
  assign s1_r4_a0_re_0_eb_sel = s1_r4_a0_re_0_eb_state[0];
  assign s1_r4_a0_re_0_ack = s1_r4_a0_re_0_eb_state[4];
  assign s1_r4_a0_re_0_m_req = s1_r4_a0_re_0_eb_state[3];
  assign s1_r4_a0_re_0 = (s1_r4_a0_re_0_eb_sel ? s1_r4_a0_re_0_eb_r1 : s1_r4_a0_re_0_eb_r0);
  assign s1_r4_a0_re_0_to_s1_r4_c0_re_req = (s1_r4_a0_re_0_m_req && (! s1_r4_a0_re_0_fork_ack_r_0));
  assign s1_r4_a0_re_0_fork_ack_s_0 = (s1_r4_a0_re_0_to_s1_r4_c0_re_ack || (! s1_r4_a0_re_0_to_s1_r4_c0_re_req));
  assign s1_r4_a0_re_0_to_s1_r4_c2_re_req = (s1_r4_a0_re_0_m_req && (! s1_r4_a0_re_0_fork_ack_r_1));
  assign s1_r4_a0_re_0_fork_ack_s_1 = (s1_r4_a0_re_0_to_s1_r4_c2_re_ack || (! s1_r4_a0_re_0_to_s1_r4_c2_re_req));
  assign s1_r4_a0_re_0_m_ack = (s1_r4_a0_re_0_fork_ack_s_0 && s1_r4_a0_re_0_fork_ack_s_1);
  always @(*) begin
    s1_r4_a0_im_0_eb_state_nxt = s1_r4_a0_im_0_eb_state;
    case(s1_r4_a0_im_0_eb_state)
      5'h14 : begin
        if(s1_r4_a0_im_0_req) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_r4_a0_im_0_req) && s1_r4_a0_im_0_m_ack)) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a0_im_0_req && (! s1_r4_a0_im_0_m_ack))) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_r4_a0_im_0_req && s1_r4_a0_im_0_m_ack)) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_r4_a0_im_0_m_ack) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_r4_a0_im_0_req) && s1_r4_a0_im_0_m_ack)) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a0_im_0_req && (! s1_r4_a0_im_0_m_ack))) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_r4_a0_im_0_req && s1_r4_a0_im_0_m_ack)) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_r4_a0_im_0_m_ack) begin
          s1_r4_a0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_r4_a0_im_0_eb_en0 = (s1_r4_a0_im_0_eb_state[2] && s1_r4_a0_im_0_req);
  assign s1_r4_a0_im_0_eb_en1 = (s1_r4_a0_im_0_eb_state[1] && s1_r4_a0_im_0_req);
  assign s1_r4_a0_im_0_eb_sel = s1_r4_a0_im_0_eb_state[0];
  assign s1_r4_a0_im_0_ack = s1_r4_a0_im_0_eb_state[4];
  assign s1_r4_a0_im_0_m_req = s1_r4_a0_im_0_eb_state[3];
  assign s1_r4_a0_im_0 = (s1_r4_a0_im_0_eb_sel ? s1_r4_a0_im_0_eb_r1 : s1_r4_a0_im_0_eb_r0);
  assign s1_r4_a0_im_0_to_s1_r4_c0_im_req = (s1_r4_a0_im_0_m_req && (! s1_r4_a0_im_0_fork_ack_r_0));
  assign s1_r4_a0_im_0_fork_ack_s_0 = (s1_r4_a0_im_0_to_s1_r4_c0_im_ack || (! s1_r4_a0_im_0_to_s1_r4_c0_im_req));
  assign s1_r4_a0_im_0_to_s1_r4_c2_im_req = (s1_r4_a0_im_0_m_req && (! s1_r4_a0_im_0_fork_ack_r_1));
  assign s1_r4_a0_im_0_fork_ack_s_1 = (s1_r4_a0_im_0_to_s1_r4_c2_im_ack || (! s1_r4_a0_im_0_to_s1_r4_c2_im_req));
  assign s1_r4_a0_im_0_m_ack = (s1_r4_a0_im_0_fork_ack_s_0 && s1_r4_a0_im_0_fork_ack_s_1);
  always @(*) begin
    s1_r4_a1_re_0_eb_state_nxt = s1_r4_a1_re_0_eb_state;
    case(s1_r4_a1_re_0_eb_state)
      5'h14 : begin
        if(s1_r4_a1_re_0_req) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_r4_a1_re_0_req) && s1_r4_a1_re_0_m_ack)) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a1_re_0_req && (! s1_r4_a1_re_0_m_ack))) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_r4_a1_re_0_req && s1_r4_a1_re_0_m_ack)) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_r4_a1_re_0_m_ack) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_r4_a1_re_0_req) && s1_r4_a1_re_0_m_ack)) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a1_re_0_req && (! s1_r4_a1_re_0_m_ack))) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_r4_a1_re_0_req && s1_r4_a1_re_0_m_ack)) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_r4_a1_re_0_m_ack) begin
          s1_r4_a1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_r4_a1_re_0_eb_en0 = (s1_r4_a1_re_0_eb_state[2] && s1_r4_a1_re_0_req);
  assign s1_r4_a1_re_0_eb_en1 = (s1_r4_a1_re_0_eb_state[1] && s1_r4_a1_re_0_req);
  assign s1_r4_a1_re_0_eb_sel = s1_r4_a1_re_0_eb_state[0];
  assign s1_r4_a1_re_0_ack = s1_r4_a1_re_0_eb_state[4];
  assign s1_r4_a1_re_0_m_req = s1_r4_a1_re_0_eb_state[3];
  assign s1_r4_a1_re_0 = (s1_r4_a1_re_0_eb_sel ? s1_r4_a1_re_0_eb_r1 : s1_r4_a1_re_0_eb_r0);
  assign s1_r4_a1_re_0_to_s1_r4_c0_re_req = (s1_r4_a1_re_0_m_req && (! s1_r4_a1_re_0_fork_ack_r_0));
  assign s1_r4_a1_re_0_fork_ack_s_0 = (s1_r4_a1_re_0_to_s1_r4_c0_re_ack || (! s1_r4_a1_re_0_to_s1_r4_c0_re_req));
  assign s1_r4_a1_re_0_to_s1_r4_c2_re_req = (s1_r4_a1_re_0_m_req && (! s1_r4_a1_re_0_fork_ack_r_1));
  assign s1_r4_a1_re_0_fork_ack_s_1 = (s1_r4_a1_re_0_to_s1_r4_c2_re_ack || (! s1_r4_a1_re_0_to_s1_r4_c2_re_req));
  assign s1_r4_a1_re_0_m_ack = (s1_r4_a1_re_0_fork_ack_s_0 && s1_r4_a1_re_0_fork_ack_s_1);
  always @(*) begin
    s1_r4_a1_im_0_eb_state_nxt = s1_r4_a1_im_0_eb_state;
    case(s1_r4_a1_im_0_eb_state)
      5'h14 : begin
        if(s1_r4_a1_im_0_req) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_r4_a1_im_0_req) && s1_r4_a1_im_0_m_ack)) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a1_im_0_req && (! s1_r4_a1_im_0_m_ack))) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_r4_a1_im_0_req && s1_r4_a1_im_0_m_ack)) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_r4_a1_im_0_m_ack) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_r4_a1_im_0_req) && s1_r4_a1_im_0_m_ack)) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a1_im_0_req && (! s1_r4_a1_im_0_m_ack))) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_r4_a1_im_0_req && s1_r4_a1_im_0_m_ack)) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_r4_a1_im_0_m_ack) begin
          s1_r4_a1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_r4_a1_im_0_eb_en0 = (s1_r4_a1_im_0_eb_state[2] && s1_r4_a1_im_0_req);
  assign s1_r4_a1_im_0_eb_en1 = (s1_r4_a1_im_0_eb_state[1] && s1_r4_a1_im_0_req);
  assign s1_r4_a1_im_0_eb_sel = s1_r4_a1_im_0_eb_state[0];
  assign s1_r4_a1_im_0_ack = s1_r4_a1_im_0_eb_state[4];
  assign s1_r4_a1_im_0_m_req = s1_r4_a1_im_0_eb_state[3];
  assign s1_r4_a1_im_0 = (s1_r4_a1_im_0_eb_sel ? s1_r4_a1_im_0_eb_r1 : s1_r4_a1_im_0_eb_r0);
  assign s1_r4_a1_im_0_to_s1_r4_c0_im_req = (s1_r4_a1_im_0_m_req && (! s1_r4_a1_im_0_fork_ack_r_0));
  assign s1_r4_a1_im_0_fork_ack_s_0 = (s1_r4_a1_im_0_to_s1_r4_c0_im_ack || (! s1_r4_a1_im_0_to_s1_r4_c0_im_req));
  assign s1_r4_a1_im_0_to_s1_r4_c2_im_req = (s1_r4_a1_im_0_m_req && (! s1_r4_a1_im_0_fork_ack_r_1));
  assign s1_r4_a1_im_0_fork_ack_s_1 = (s1_r4_a1_im_0_to_s1_r4_c2_im_ack || (! s1_r4_a1_im_0_to_s1_r4_c2_im_req));
  assign s1_r4_a1_im_0_m_ack = (s1_r4_a1_im_0_fork_ack_s_0 && s1_r4_a1_im_0_fork_ack_s_1);
  always @(*) begin
    s1_r4_a2_re_0_eb_state_nxt = s1_r4_a2_re_0_eb_state;
    case(s1_r4_a2_re_0_eb_state)
      5'h14 : begin
        if(s1_r4_a2_re_0_req) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_r4_a2_re_0_req) && s1_r4_a2_re_0_m_ack)) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a2_re_0_req && (! s1_r4_a2_re_0_m_ack))) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_r4_a2_re_0_req && s1_r4_a2_re_0_m_ack)) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_r4_a2_re_0_m_ack) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_r4_a2_re_0_req) && s1_r4_a2_re_0_m_ack)) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a2_re_0_req && (! s1_r4_a2_re_0_m_ack))) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_r4_a2_re_0_req && s1_r4_a2_re_0_m_ack)) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_r4_a2_re_0_m_ack) begin
          s1_r4_a2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_r4_a2_re_0_eb_en0 = (s1_r4_a2_re_0_eb_state[2] && s1_r4_a2_re_0_req);
  assign s1_r4_a2_re_0_eb_en1 = (s1_r4_a2_re_0_eb_state[1] && s1_r4_a2_re_0_req);
  assign s1_r4_a2_re_0_eb_sel = s1_r4_a2_re_0_eb_state[0];
  assign s1_r4_a2_re_0_ack = s1_r4_a2_re_0_eb_state[4];
  assign s1_r4_a2_re_0_m_req = s1_r4_a2_re_0_eb_state[3];
  assign s1_r4_a2_re_0 = (s1_r4_a2_re_0_eb_sel ? s1_r4_a2_re_0_eb_r1 : s1_r4_a2_re_0_eb_r0);
  assign s1_r4_a2_re_0_to_s1_r4_c1_re_req = (s1_r4_a2_re_0_m_req && (! s1_r4_a2_re_0_fork_ack_r_0));
  assign s1_r4_a2_re_0_fork_ack_s_0 = (s1_r4_a2_re_0_to_s1_r4_c1_re_ack || (! s1_r4_a2_re_0_to_s1_r4_c1_re_req));
  assign s1_r4_a2_re_0_to_s1_r4_c3_re_req = (s1_r4_a2_re_0_m_req && (! s1_r4_a2_re_0_fork_ack_r_1));
  assign s1_r4_a2_re_0_fork_ack_s_1 = (s1_r4_a2_re_0_to_s1_r4_c3_re_ack || (! s1_r4_a2_re_0_to_s1_r4_c3_re_req));
  assign s1_r4_a2_re_0_m_ack = (s1_r4_a2_re_0_fork_ack_s_0 && s1_r4_a2_re_0_fork_ack_s_1);
  always @(*) begin
    s1_r4_a2_im_0_eb_state_nxt = s1_r4_a2_im_0_eb_state;
    case(s1_r4_a2_im_0_eb_state)
      5'h14 : begin
        if(s1_r4_a2_im_0_req) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_r4_a2_im_0_req) && s1_r4_a2_im_0_m_ack)) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a2_im_0_req && (! s1_r4_a2_im_0_m_ack))) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_r4_a2_im_0_req && s1_r4_a2_im_0_m_ack)) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_r4_a2_im_0_m_ack) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_r4_a2_im_0_req) && s1_r4_a2_im_0_m_ack)) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a2_im_0_req && (! s1_r4_a2_im_0_m_ack))) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_r4_a2_im_0_req && s1_r4_a2_im_0_m_ack)) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_r4_a2_im_0_m_ack) begin
          s1_r4_a2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_r4_a2_im_0_eb_en0 = (s1_r4_a2_im_0_eb_state[2] && s1_r4_a2_im_0_req);
  assign s1_r4_a2_im_0_eb_en1 = (s1_r4_a2_im_0_eb_state[1] && s1_r4_a2_im_0_req);
  assign s1_r4_a2_im_0_eb_sel = s1_r4_a2_im_0_eb_state[0];
  assign s1_r4_a2_im_0_ack = s1_r4_a2_im_0_eb_state[4];
  assign s1_r4_a2_im_0_m_req = s1_r4_a2_im_0_eb_state[3];
  assign s1_r4_a2_im_0 = (s1_r4_a2_im_0_eb_sel ? s1_r4_a2_im_0_eb_r1 : s1_r4_a2_im_0_eb_r0);
  assign s1_r4_a2_im_0_to_s1_r4_c1_im_req = (s1_r4_a2_im_0_m_req && (! s1_r4_a2_im_0_fork_ack_r_0));
  assign s1_r4_a2_im_0_fork_ack_s_0 = (s1_r4_a2_im_0_to_s1_r4_c1_im_ack || (! s1_r4_a2_im_0_to_s1_r4_c1_im_req));
  assign s1_r4_a2_im_0_to_s1_r4_c3_im_req = (s1_r4_a2_im_0_m_req && (! s1_r4_a2_im_0_fork_ack_r_1));
  assign s1_r4_a2_im_0_fork_ack_s_1 = (s1_r4_a2_im_0_to_s1_r4_c3_im_ack || (! s1_r4_a2_im_0_to_s1_r4_c3_im_req));
  assign s1_r4_a2_im_0_m_ack = (s1_r4_a2_im_0_fork_ack_s_0 && s1_r4_a2_im_0_fork_ack_s_1);
  always @(*) begin
    s1_r4_a3_re_0_eb_state_nxt = s1_r4_a3_re_0_eb_state;
    case(s1_r4_a3_re_0_eb_state)
      5'h14 : begin
        if(s1_r4_a3_re_0_req) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_r4_a3_re_0_req) && s1_r4_a3_re_0_m_ack)) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a3_re_0_req && (! s1_r4_a3_re_0_m_ack))) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_r4_a3_re_0_req && s1_r4_a3_re_0_m_ack)) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_r4_a3_re_0_m_ack) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_r4_a3_re_0_req) && s1_r4_a3_re_0_m_ack)) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a3_re_0_req && (! s1_r4_a3_re_0_m_ack))) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_r4_a3_re_0_req && s1_r4_a3_re_0_m_ack)) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_r4_a3_re_0_m_ack) begin
          s1_r4_a3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_r4_a3_re_0_eb_en0 = (s1_r4_a3_re_0_eb_state[2] && s1_r4_a3_re_0_req);
  assign s1_r4_a3_re_0_eb_en1 = (s1_r4_a3_re_0_eb_state[1] && s1_r4_a3_re_0_req);
  assign s1_r4_a3_re_0_eb_sel = s1_r4_a3_re_0_eb_state[0];
  assign s1_r4_a3_re_0_ack = s1_r4_a3_re_0_eb_state[4];
  assign s1_r4_a3_re_0_m_req = s1_r4_a3_re_0_eb_state[3];
  assign s1_r4_a3_re_0 = (s1_r4_a3_re_0_eb_sel ? s1_r4_a3_re_0_eb_r1 : s1_r4_a3_re_0_eb_r0);
  assign s1_r4_a3_re_0_to_s1_r4_c1_im_req = (s1_r4_a3_re_0_m_req && (! s1_r4_a3_re_0_fork_ack_r_0));
  assign s1_r4_a3_re_0_fork_ack_s_0 = (s1_r4_a3_re_0_to_s1_r4_c1_im_ack || (! s1_r4_a3_re_0_to_s1_r4_c1_im_req));
  assign s1_r4_a3_re_0_to_s1_r4_c3_im_req = (s1_r4_a3_re_0_m_req && (! s1_r4_a3_re_0_fork_ack_r_1));
  assign s1_r4_a3_re_0_fork_ack_s_1 = (s1_r4_a3_re_0_to_s1_r4_c3_im_ack || (! s1_r4_a3_re_0_to_s1_r4_c3_im_req));
  assign s1_r4_a3_re_0_m_ack = (s1_r4_a3_re_0_fork_ack_s_0 && s1_r4_a3_re_0_fork_ack_s_1);
  always @(*) begin
    s1_r4_a3_im_0_eb_state_nxt = s1_r4_a3_im_0_eb_state;
    case(s1_r4_a3_im_0_eb_state)
      5'h14 : begin
        if(s1_r4_a3_im_0_req) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_r4_a3_im_0_req) && s1_r4_a3_im_0_m_ack)) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a3_im_0_req && (! s1_r4_a3_im_0_m_ack))) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_r4_a3_im_0_req && s1_r4_a3_im_0_m_ack)) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_r4_a3_im_0_m_ack) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_r4_a3_im_0_req) && s1_r4_a3_im_0_m_ack)) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_r4_a3_im_0_req && (! s1_r4_a3_im_0_m_ack))) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_r4_a3_im_0_req && s1_r4_a3_im_0_m_ack)) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_r4_a3_im_0_m_ack) begin
          s1_r4_a3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_r4_a3_im_0_eb_en0 = (s1_r4_a3_im_0_eb_state[2] && s1_r4_a3_im_0_req);
  assign s1_r4_a3_im_0_eb_en1 = (s1_r4_a3_im_0_eb_state[1] && s1_r4_a3_im_0_req);
  assign s1_r4_a3_im_0_eb_sel = s1_r4_a3_im_0_eb_state[0];
  assign s1_r4_a3_im_0_ack = s1_r4_a3_im_0_eb_state[4];
  assign s1_r4_a3_im_0_m_req = s1_r4_a3_im_0_eb_state[3];
  assign s1_r4_a3_im_0 = (s1_r4_a3_im_0_eb_sel ? s1_r4_a3_im_0_eb_r1 : s1_r4_a3_im_0_eb_r0);
  assign s1_r4_a3_im_0_to_s1_r4_c1_re_req = (s1_r4_a3_im_0_m_req && (! s1_r4_a3_im_0_fork_ack_r_0));
  assign s1_r4_a3_im_0_fork_ack_s_0 = (s1_r4_a3_im_0_to_s1_r4_c1_re_ack || (! s1_r4_a3_im_0_to_s1_r4_c1_re_req));
  assign s1_r4_a3_im_0_to_s1_r4_c3_re_req = (s1_r4_a3_im_0_m_req && (! s1_r4_a3_im_0_fork_ack_r_1));
  assign s1_r4_a3_im_0_fork_ack_s_1 = (s1_r4_a3_im_0_to_s1_r4_c3_re_ack || (! s1_r4_a3_im_0_to_s1_r4_c3_re_req));
  assign s1_r4_a3_im_0_m_ack = (s1_r4_a3_im_0_fork_ack_s_0 && s1_r4_a3_im_0_fork_ack_s_1);
  assign s1_r4_c0_re_0_m_req = s1_r4_c0_re_0_req;
  assign s1_r4_c0_re_0_ack = s1_r4_c0_re_0_m_ack;
  assign s1_r4_c0_re_0_to_s1_r4_byp0_re_req = s1_r4_c0_re_0_m_req;
  assign s1_r4_c0_re_0_m_ack = s1_r4_c0_re_0_to_s1_r4_byp0_re_ack;
  assign s1_r4_c0_im_0_m_req = s1_r4_c0_im_0_req;
  assign s1_r4_c0_im_0_ack = s1_r4_c0_im_0_m_ack;
  assign s1_r4_c0_im_0_to_s1_r4_byp0_im_req = s1_r4_c0_im_0_m_req;
  assign s1_r4_c0_im_0_m_ack = s1_r4_c0_im_0_to_s1_r4_byp0_im_ack;
  assign s1_r4_c1_re_0_m_req = s1_r4_c1_re_0_req;
  assign s1_r4_c1_re_0_ack = s1_r4_c1_re_0_m_ack;
  assign s1_r4_c1_re_0_to_s1_r4_byp1_re_req = s1_r4_c1_re_0_m_req;
  assign s1_r4_c1_re_0_m_ack = s1_r4_c1_re_0_to_s1_r4_byp1_re_ack;
  assign s1_r4_c1_im_0_m_req = s1_r4_c1_im_0_req;
  assign s1_r4_c1_im_0_ack = s1_r4_c1_im_0_m_ack;
  assign s1_r4_c1_im_0_to_s1_r4_byp1_im_req = s1_r4_c1_im_0_m_req;
  assign s1_r4_c1_im_0_m_ack = s1_r4_c1_im_0_to_s1_r4_byp1_im_ack;
  assign s1_r4_c2_re_0_m_req = s1_r4_c2_re_0_req;
  assign s1_r4_c2_re_0_ack = s1_r4_c2_re_0_m_ack;
  assign s1_r4_c2_re_0_to_s1_r4_byp2_re_req = s1_r4_c2_re_0_m_req;
  assign s1_r4_c2_re_0_m_ack = s1_r4_c2_re_0_to_s1_r4_byp2_re_ack;
  assign s1_r4_c2_im_0_m_req = s1_r4_c2_im_0_req;
  assign s1_r4_c2_im_0_ack = s1_r4_c2_im_0_m_ack;
  assign s1_r4_c2_im_0_to_s1_r4_byp2_im_req = s1_r4_c2_im_0_m_req;
  assign s1_r4_c2_im_0_m_ack = s1_r4_c2_im_0_to_s1_r4_byp2_im_ack;
  assign s1_r4_c3_re_0_m_req = s1_r4_c3_re_0_req;
  assign s1_r4_c3_re_0_ack = s1_r4_c3_re_0_m_ack;
  assign s1_r4_c3_re_0_to_s1_r4_byp3_re_req = s1_r4_c3_re_0_m_req;
  assign s1_r4_c3_re_0_m_ack = s1_r4_c3_re_0_to_s1_r4_byp3_re_ack;
  assign s1_r4_c3_im_0_m_req = s1_r4_c3_im_0_req;
  assign s1_r4_c3_im_0_ack = s1_r4_c3_im_0_m_ack;
  assign s1_r4_c3_im_0_to_s1_r4_byp3_im_req = s1_r4_c3_im_0_m_req;
  assign s1_r4_c3_im_0_m_ack = s1_r4_c3_im_0_to_s1_r4_byp3_im_ack;
  assign cfg_s1_r4_byp0_re_m_req = cfg_s1_r4_byp0_re_req;
  assign cfg_s1_r4_byp0_re_ack = cfg_s1_r4_byp0_re_m_ack;
  assign cfg_s1_r4_byp0_re_to_s1_r4_byp0_re_req = cfg_s1_r4_byp0_re_m_req;
  assign cfg_s1_r4_byp0_re_m_ack = cfg_s1_r4_byp0_re_to_s1_r4_byp0_re_ack;
  assign cfg_s1_r4_byp0_im_m_req = cfg_s1_r4_byp0_im_req;
  assign cfg_s1_r4_byp0_im_ack = cfg_s1_r4_byp0_im_m_ack;
  assign cfg_s1_r4_byp0_im_to_s1_r4_byp0_im_req = cfg_s1_r4_byp0_im_m_req;
  assign cfg_s1_r4_byp0_im_m_ack = cfg_s1_r4_byp0_im_to_s1_r4_byp0_im_ack;
  assign s1_r4_byp0_re_0_ack = ((! s1_r4_byp0_re_0_eb_valid) || s1_r4_byp0_re_0_m_ack);
  assign s1_r4_byp0_re_0_eb_en = (s1_r4_byp0_re_0_req && s1_r4_byp0_re_0_ack);
  assign s1_r4_byp0_re_0_m_req = s1_r4_byp0_re_0_eb_valid;
  assign s1_r4_byp0_re_0 = s1_r4_byp0_re_0_eb_r;
  assign s1_r4_byp0_re_0_to_s1_bs0_re_req = s1_r4_byp0_re_0_m_req;
  assign s1_r4_byp0_re_0_m_ack = s1_r4_byp0_re_0_to_s1_bs0_re_ack;
  assign s1_r4_byp0_im_0_ack = ((! s1_r4_byp0_im_0_eb_valid) || s1_r4_byp0_im_0_m_ack);
  assign s1_r4_byp0_im_0_eb_en = (s1_r4_byp0_im_0_req && s1_r4_byp0_im_0_ack);
  assign s1_r4_byp0_im_0_m_req = s1_r4_byp0_im_0_eb_valid;
  assign s1_r4_byp0_im_0 = s1_r4_byp0_im_0_eb_r;
  assign s1_r4_byp0_im_0_to_s1_bs0_im_req = s1_r4_byp0_im_0_m_req;
  assign s1_r4_byp0_im_0_m_ack = s1_r4_byp0_im_0_to_s1_bs0_im_ack;
  assign cfg_s1_r4_byp1_re_m_req = cfg_s1_r4_byp1_re_req;
  assign cfg_s1_r4_byp1_re_ack = cfg_s1_r4_byp1_re_m_ack;
  assign cfg_s1_r4_byp1_re_to_s1_r4_byp1_re_req = cfg_s1_r4_byp1_re_m_req;
  assign cfg_s1_r4_byp1_re_m_ack = cfg_s1_r4_byp1_re_to_s1_r4_byp1_re_ack;
  assign cfg_s1_r4_byp1_im_m_req = cfg_s1_r4_byp1_im_req;
  assign cfg_s1_r4_byp1_im_ack = cfg_s1_r4_byp1_im_m_ack;
  assign cfg_s1_r4_byp1_im_to_s1_r4_byp1_im_req = cfg_s1_r4_byp1_im_m_req;
  assign cfg_s1_r4_byp1_im_m_ack = cfg_s1_r4_byp1_im_to_s1_r4_byp1_im_ack;
  assign s1_r4_byp1_re_0_ack = ((! s1_r4_byp1_re_0_eb_valid) || s1_r4_byp1_re_0_m_ack);
  assign s1_r4_byp1_re_0_eb_en = (s1_r4_byp1_re_0_req && s1_r4_byp1_re_0_ack);
  assign s1_r4_byp1_re_0_m_req = s1_r4_byp1_re_0_eb_valid;
  assign s1_r4_byp1_re_0 = s1_r4_byp1_re_0_eb_r;
  assign s1_r4_byp1_re_0_to_s1_bs1_re_req = s1_r4_byp1_re_0_m_req;
  assign s1_r4_byp1_re_0_m_ack = s1_r4_byp1_re_0_to_s1_bs1_re_ack;
  assign s1_r4_byp1_im_0_ack = ((! s1_r4_byp1_im_0_eb_valid) || s1_r4_byp1_im_0_m_ack);
  assign s1_r4_byp1_im_0_eb_en = (s1_r4_byp1_im_0_req && s1_r4_byp1_im_0_ack);
  assign s1_r4_byp1_im_0_m_req = s1_r4_byp1_im_0_eb_valid;
  assign s1_r4_byp1_im_0 = s1_r4_byp1_im_0_eb_r;
  assign s1_r4_byp1_im_0_to_s1_bs1_im_req = s1_r4_byp1_im_0_m_req;
  assign s1_r4_byp1_im_0_m_ack = s1_r4_byp1_im_0_to_s1_bs1_im_ack;
  assign cfg_s1_r4_byp2_re_m_req = cfg_s1_r4_byp2_re_req;
  assign cfg_s1_r4_byp2_re_ack = cfg_s1_r4_byp2_re_m_ack;
  assign cfg_s1_r4_byp2_re_to_s1_r4_byp2_re_req = cfg_s1_r4_byp2_re_m_req;
  assign cfg_s1_r4_byp2_re_m_ack = cfg_s1_r4_byp2_re_to_s1_r4_byp2_re_ack;
  assign cfg_s1_r4_byp2_im_m_req = cfg_s1_r4_byp2_im_req;
  assign cfg_s1_r4_byp2_im_ack = cfg_s1_r4_byp2_im_m_ack;
  assign cfg_s1_r4_byp2_im_to_s1_r4_byp2_im_req = cfg_s1_r4_byp2_im_m_req;
  assign cfg_s1_r4_byp2_im_m_ack = cfg_s1_r4_byp2_im_to_s1_r4_byp2_im_ack;
  assign s1_r4_byp2_re_0_ack = ((! s1_r4_byp2_re_0_eb_valid) || s1_r4_byp2_re_0_m_ack);
  assign s1_r4_byp2_re_0_eb_en = (s1_r4_byp2_re_0_req && s1_r4_byp2_re_0_ack);
  assign s1_r4_byp2_re_0_m_req = s1_r4_byp2_re_0_eb_valid;
  assign s1_r4_byp2_re_0 = s1_r4_byp2_re_0_eb_r;
  assign s1_r4_byp2_re_0_to_s1_bs2_re_req = s1_r4_byp2_re_0_m_req;
  assign s1_r4_byp2_re_0_m_ack = s1_r4_byp2_re_0_to_s1_bs2_re_ack;
  assign s1_r4_byp2_im_0_ack = ((! s1_r4_byp2_im_0_eb_valid) || s1_r4_byp2_im_0_m_ack);
  assign s1_r4_byp2_im_0_eb_en = (s1_r4_byp2_im_0_req && s1_r4_byp2_im_0_ack);
  assign s1_r4_byp2_im_0_m_req = s1_r4_byp2_im_0_eb_valid;
  assign s1_r4_byp2_im_0 = s1_r4_byp2_im_0_eb_r;
  assign s1_r4_byp2_im_0_to_s1_bs2_im_req = s1_r4_byp2_im_0_m_req;
  assign s1_r4_byp2_im_0_m_ack = s1_r4_byp2_im_0_to_s1_bs2_im_ack;
  assign cfg_s1_r4_byp3_re_m_req = cfg_s1_r4_byp3_re_req;
  assign cfg_s1_r4_byp3_re_ack = cfg_s1_r4_byp3_re_m_ack;
  assign cfg_s1_r4_byp3_re_to_s1_r4_byp3_re_req = cfg_s1_r4_byp3_re_m_req;
  assign cfg_s1_r4_byp3_re_m_ack = cfg_s1_r4_byp3_re_to_s1_r4_byp3_re_ack;
  assign cfg_s1_r4_byp3_im_m_req = cfg_s1_r4_byp3_im_req;
  assign cfg_s1_r4_byp3_im_ack = cfg_s1_r4_byp3_im_m_ack;
  assign cfg_s1_r4_byp3_im_to_s1_r4_byp3_im_req = cfg_s1_r4_byp3_im_m_req;
  assign cfg_s1_r4_byp3_im_m_ack = cfg_s1_r4_byp3_im_to_s1_r4_byp3_im_ack;
  assign s1_r4_byp3_re_0_ack = ((! s1_r4_byp3_re_0_eb_valid) || s1_r4_byp3_re_0_m_ack);
  assign s1_r4_byp3_re_0_eb_en = (s1_r4_byp3_re_0_req && s1_r4_byp3_re_0_ack);
  assign s1_r4_byp3_re_0_m_req = s1_r4_byp3_re_0_eb_valid;
  assign s1_r4_byp3_re_0 = s1_r4_byp3_re_0_eb_r;
  assign s1_r4_byp3_re_0_to_s1_bs3_re_req = s1_r4_byp3_re_0_m_req;
  assign s1_r4_byp3_re_0_m_ack = s1_r4_byp3_re_0_to_s1_bs3_re_ack;
  assign s1_r4_byp3_im_0_ack = ((! s1_r4_byp3_im_0_eb_valid) || s1_r4_byp3_im_0_m_ack);
  assign s1_r4_byp3_im_0_eb_en = (s1_r4_byp3_im_0_req && s1_r4_byp3_im_0_ack);
  assign s1_r4_byp3_im_0_m_req = s1_r4_byp3_im_0_eb_valid;
  assign s1_r4_byp3_im_0 = s1_r4_byp3_im_0_eb_r;
  assign s1_r4_byp3_im_0_to_s1_bs3_im_req = s1_r4_byp3_im_0_m_req;
  assign s1_r4_byp3_im_0_m_ack = s1_r4_byp3_im_0_to_s1_bs3_im_ack;
  assign s0_k1_cat_0_m_req = s0_k1_cat_0_req;
  assign s0_k1_cat_0_ack = s0_k1_cat_0_m_ack;
  assign s0_k1_cat_0_to_k1_defunnel_req = s0_k1_cat_0_m_req;
  assign s0_k1_cat_0_m_ack = s0_k1_cat_0_to_k1_defunnel_ack;
  assign cfg_s0_bs0_re_m_req = cfg_s0_bs0_re_req;
  assign cfg_s0_bs0_re_ack = cfg_s0_bs0_re_m_ack;
  assign cfg_s0_bs0_re_to_s0_bs0_re_req = cfg_s0_bs0_re_m_req;
  assign cfg_s0_bs0_re_m_ack = cfg_s0_bs0_re_to_s0_bs0_re_ack;
  assign cfg_s0_bs0_im_m_req = cfg_s0_bs0_im_req;
  assign cfg_s0_bs0_im_ack = cfg_s0_bs0_im_m_ack;
  assign cfg_s0_bs0_im_to_s0_bs0_im_req = cfg_s0_bs0_im_m_req;
  assign cfg_s0_bs0_im_m_ack = cfg_s0_bs0_im_to_s0_bs0_im_ack;
  always @(*) begin
    s0_bs0_re_0_eb_state_nxt = s0_bs0_re_0_eb_state;
    case(s0_bs0_re_0_eb_state)
      5'h14 : begin
        if(s0_bs0_re_0_req) begin
          s0_bs0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_bs0_re_0_req) && s0_bs0_re_0_m_ack)) begin
          s0_bs0_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs0_re_0_req && (! s0_bs0_re_0_m_ack))) begin
          s0_bs0_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_bs0_re_0_req && s0_bs0_re_0_m_ack)) begin
          s0_bs0_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_bs0_re_0_m_ack) begin
          s0_bs0_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_bs0_re_0_req) && s0_bs0_re_0_m_ack)) begin
          s0_bs0_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs0_re_0_req && (! s0_bs0_re_0_m_ack))) begin
          s0_bs0_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_bs0_re_0_req && s0_bs0_re_0_m_ack)) begin
          s0_bs0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_bs0_re_0_m_ack) begin
          s0_bs0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_bs0_re_0_eb_en0 = (s0_bs0_re_0_eb_state[2] && s0_bs0_re_0_req);
  assign s0_bs0_re_0_eb_en1 = (s0_bs0_re_0_eb_state[1] && s0_bs0_re_0_req);
  assign s0_bs0_re_0_eb_sel = s0_bs0_re_0_eb_state[0];
  assign s0_bs0_re_0_ack = s0_bs0_re_0_eb_state[4];
  assign s0_bs0_re_0_m_req = s0_bs0_re_0_eb_state[3];
  assign s0_bs0_re_0 = (s0_bs0_re_0_eb_sel ? s0_bs0_re_0_eb_r1 : s0_bs0_re_0_eb_r0);
  assign s0_bs0_re_0_to_s0_rsat0_re_req = s0_bs0_re_0_m_req;
  assign s0_bs0_re_0_m_ack = s0_bs0_re_0_to_s0_rsat0_re_ack;
  always @(*) begin
    s0_bs0_im_0_eb_state_nxt = s0_bs0_im_0_eb_state;
    case(s0_bs0_im_0_eb_state)
      5'h14 : begin
        if(s0_bs0_im_0_req) begin
          s0_bs0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_bs0_im_0_req) && s0_bs0_im_0_m_ack)) begin
          s0_bs0_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs0_im_0_req && (! s0_bs0_im_0_m_ack))) begin
          s0_bs0_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_bs0_im_0_req && s0_bs0_im_0_m_ack)) begin
          s0_bs0_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_bs0_im_0_m_ack) begin
          s0_bs0_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_bs0_im_0_req) && s0_bs0_im_0_m_ack)) begin
          s0_bs0_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs0_im_0_req && (! s0_bs0_im_0_m_ack))) begin
          s0_bs0_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_bs0_im_0_req && s0_bs0_im_0_m_ack)) begin
          s0_bs0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_bs0_im_0_m_ack) begin
          s0_bs0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_bs0_im_0_eb_en0 = (s0_bs0_im_0_eb_state[2] && s0_bs0_im_0_req);
  assign s0_bs0_im_0_eb_en1 = (s0_bs0_im_0_eb_state[1] && s0_bs0_im_0_req);
  assign s0_bs0_im_0_eb_sel = s0_bs0_im_0_eb_state[0];
  assign s0_bs0_im_0_ack = s0_bs0_im_0_eb_state[4];
  assign s0_bs0_im_0_m_req = s0_bs0_im_0_eb_state[3];
  assign s0_bs0_im_0 = (s0_bs0_im_0_eb_sel ? s0_bs0_im_0_eb_r1 : s0_bs0_im_0_eb_r0);
  assign s0_bs0_im_0_to_s0_rsat0_im_req = s0_bs0_im_0_m_req;
  assign s0_bs0_im_0_m_ack = s0_bs0_im_0_to_s0_rsat0_im_ack;
  assign s0_rsat0_re_0_ack = ((! s0_rsat0_re_0_eb_valid) || s0_rsat0_re_0_m_ack);
  assign s0_rsat0_re_0_eb_en = (s0_rsat0_re_0_req && s0_rsat0_re_0_ack);
  assign s0_rsat0_re_0_m_req = s0_rsat0_re_0_eb_valid;
  assign s0_rsat0_re_0 = s0_rsat0_re_0_eb_r;
  assign s0_rsat0_re_0_to_s0_k1_cat_req = s0_rsat0_re_0_m_req;
  assign s0_rsat0_re_0_m_ack = s0_rsat0_re_0_to_s0_k1_cat_ack;
  assign s0_rsat0_im_0_ack = ((! s0_rsat0_im_0_eb_valid) || s0_rsat0_im_0_m_ack);
  assign s0_rsat0_im_0_eb_en = (s0_rsat0_im_0_req && s0_rsat0_im_0_ack);
  assign s0_rsat0_im_0_m_req = s0_rsat0_im_0_eb_valid;
  assign s0_rsat0_im_0 = s0_rsat0_im_0_eb_r;
  assign s0_rsat0_im_0_to_s0_k1_cat_req = s0_rsat0_im_0_m_req;
  assign s0_rsat0_im_0_m_ack = s0_rsat0_im_0_to_s0_k1_cat_ack;
  assign cfg_s0_bs1_re_m_req = cfg_s0_bs1_re_req;
  assign cfg_s0_bs1_re_ack = cfg_s0_bs1_re_m_ack;
  assign cfg_s0_bs1_re_to_s0_bs1_re_req = cfg_s0_bs1_re_m_req;
  assign cfg_s0_bs1_re_m_ack = cfg_s0_bs1_re_to_s0_bs1_re_ack;
  assign cfg_s0_bs1_im_m_req = cfg_s0_bs1_im_req;
  assign cfg_s0_bs1_im_ack = cfg_s0_bs1_im_m_ack;
  assign cfg_s0_bs1_im_to_s0_bs1_im_req = cfg_s0_bs1_im_m_req;
  assign cfg_s0_bs1_im_m_ack = cfg_s0_bs1_im_to_s0_bs1_im_ack;
  always @(*) begin
    s0_bs1_re_0_eb_state_nxt = s0_bs1_re_0_eb_state;
    case(s0_bs1_re_0_eb_state)
      5'h14 : begin
        if(s0_bs1_re_0_req) begin
          s0_bs1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_bs1_re_0_req) && s0_bs1_re_0_m_ack)) begin
          s0_bs1_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs1_re_0_req && (! s0_bs1_re_0_m_ack))) begin
          s0_bs1_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_bs1_re_0_req && s0_bs1_re_0_m_ack)) begin
          s0_bs1_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_bs1_re_0_m_ack) begin
          s0_bs1_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_bs1_re_0_req) && s0_bs1_re_0_m_ack)) begin
          s0_bs1_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs1_re_0_req && (! s0_bs1_re_0_m_ack))) begin
          s0_bs1_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_bs1_re_0_req && s0_bs1_re_0_m_ack)) begin
          s0_bs1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_bs1_re_0_m_ack) begin
          s0_bs1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_bs1_re_0_eb_en0 = (s0_bs1_re_0_eb_state[2] && s0_bs1_re_0_req);
  assign s0_bs1_re_0_eb_en1 = (s0_bs1_re_0_eb_state[1] && s0_bs1_re_0_req);
  assign s0_bs1_re_0_eb_sel = s0_bs1_re_0_eb_state[0];
  assign s0_bs1_re_0_ack = s0_bs1_re_0_eb_state[4];
  assign s0_bs1_re_0_m_req = s0_bs1_re_0_eb_state[3];
  assign s0_bs1_re_0 = (s0_bs1_re_0_eb_sel ? s0_bs1_re_0_eb_r1 : s0_bs1_re_0_eb_r0);
  assign s0_bs1_re_0_to_s0_rsat1_re_req = s0_bs1_re_0_m_req;
  assign s0_bs1_re_0_m_ack = s0_bs1_re_0_to_s0_rsat1_re_ack;
  always @(*) begin
    s0_bs1_im_0_eb_state_nxt = s0_bs1_im_0_eb_state;
    case(s0_bs1_im_0_eb_state)
      5'h14 : begin
        if(s0_bs1_im_0_req) begin
          s0_bs1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_bs1_im_0_req) && s0_bs1_im_0_m_ack)) begin
          s0_bs1_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs1_im_0_req && (! s0_bs1_im_0_m_ack))) begin
          s0_bs1_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_bs1_im_0_req && s0_bs1_im_0_m_ack)) begin
          s0_bs1_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_bs1_im_0_m_ack) begin
          s0_bs1_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_bs1_im_0_req) && s0_bs1_im_0_m_ack)) begin
          s0_bs1_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs1_im_0_req && (! s0_bs1_im_0_m_ack))) begin
          s0_bs1_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_bs1_im_0_req && s0_bs1_im_0_m_ack)) begin
          s0_bs1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_bs1_im_0_m_ack) begin
          s0_bs1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_bs1_im_0_eb_en0 = (s0_bs1_im_0_eb_state[2] && s0_bs1_im_0_req);
  assign s0_bs1_im_0_eb_en1 = (s0_bs1_im_0_eb_state[1] && s0_bs1_im_0_req);
  assign s0_bs1_im_0_eb_sel = s0_bs1_im_0_eb_state[0];
  assign s0_bs1_im_0_ack = s0_bs1_im_0_eb_state[4];
  assign s0_bs1_im_0_m_req = s0_bs1_im_0_eb_state[3];
  assign s0_bs1_im_0 = (s0_bs1_im_0_eb_sel ? s0_bs1_im_0_eb_r1 : s0_bs1_im_0_eb_r0);
  assign s0_bs1_im_0_to_s0_rsat1_im_req = s0_bs1_im_0_m_req;
  assign s0_bs1_im_0_m_ack = s0_bs1_im_0_to_s0_rsat1_im_ack;
  assign s0_rsat1_re_0_ack = ((! s0_rsat1_re_0_eb_valid) || s0_rsat1_re_0_m_ack);
  assign s0_rsat1_re_0_eb_en = (s0_rsat1_re_0_req && s0_rsat1_re_0_ack);
  assign s0_rsat1_re_0_m_req = s0_rsat1_re_0_eb_valid;
  assign s0_rsat1_re_0 = s0_rsat1_re_0_eb_r;
  assign s0_rsat1_re_0_to_s0_k1_cat_req = s0_rsat1_re_0_m_req;
  assign s0_rsat1_re_0_m_ack = s0_rsat1_re_0_to_s0_k1_cat_ack;
  assign s0_rsat1_im_0_ack = ((! s0_rsat1_im_0_eb_valid) || s0_rsat1_im_0_m_ack);
  assign s0_rsat1_im_0_eb_en = (s0_rsat1_im_0_req && s0_rsat1_im_0_ack);
  assign s0_rsat1_im_0_m_req = s0_rsat1_im_0_eb_valid;
  assign s0_rsat1_im_0 = s0_rsat1_im_0_eb_r;
  assign s0_rsat1_im_0_to_s0_k1_cat_req = s0_rsat1_im_0_m_req;
  assign s0_rsat1_im_0_m_ack = s0_rsat1_im_0_to_s0_k1_cat_ack;
  assign cfg_s0_bs2_re_m_req = cfg_s0_bs2_re_req;
  assign cfg_s0_bs2_re_ack = cfg_s0_bs2_re_m_ack;
  assign cfg_s0_bs2_re_to_s0_bs2_re_req = cfg_s0_bs2_re_m_req;
  assign cfg_s0_bs2_re_m_ack = cfg_s0_bs2_re_to_s0_bs2_re_ack;
  assign cfg_s0_bs2_im_m_req = cfg_s0_bs2_im_req;
  assign cfg_s0_bs2_im_ack = cfg_s0_bs2_im_m_ack;
  assign cfg_s0_bs2_im_to_s0_bs2_im_req = cfg_s0_bs2_im_m_req;
  assign cfg_s0_bs2_im_m_ack = cfg_s0_bs2_im_to_s0_bs2_im_ack;
  always @(*) begin
    s0_bs2_re_0_eb_state_nxt = s0_bs2_re_0_eb_state;
    case(s0_bs2_re_0_eb_state)
      5'h14 : begin
        if(s0_bs2_re_0_req) begin
          s0_bs2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_bs2_re_0_req) && s0_bs2_re_0_m_ack)) begin
          s0_bs2_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs2_re_0_req && (! s0_bs2_re_0_m_ack))) begin
          s0_bs2_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_bs2_re_0_req && s0_bs2_re_0_m_ack)) begin
          s0_bs2_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_bs2_re_0_m_ack) begin
          s0_bs2_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_bs2_re_0_req) && s0_bs2_re_0_m_ack)) begin
          s0_bs2_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs2_re_0_req && (! s0_bs2_re_0_m_ack))) begin
          s0_bs2_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_bs2_re_0_req && s0_bs2_re_0_m_ack)) begin
          s0_bs2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_bs2_re_0_m_ack) begin
          s0_bs2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_bs2_re_0_eb_en0 = (s0_bs2_re_0_eb_state[2] && s0_bs2_re_0_req);
  assign s0_bs2_re_0_eb_en1 = (s0_bs2_re_0_eb_state[1] && s0_bs2_re_0_req);
  assign s0_bs2_re_0_eb_sel = s0_bs2_re_0_eb_state[0];
  assign s0_bs2_re_0_ack = s0_bs2_re_0_eb_state[4];
  assign s0_bs2_re_0_m_req = s0_bs2_re_0_eb_state[3];
  assign s0_bs2_re_0 = (s0_bs2_re_0_eb_sel ? s0_bs2_re_0_eb_r1 : s0_bs2_re_0_eb_r0);
  assign s0_bs2_re_0_to_s0_rsat2_re_req = s0_bs2_re_0_m_req;
  assign s0_bs2_re_0_m_ack = s0_bs2_re_0_to_s0_rsat2_re_ack;
  always @(*) begin
    s0_bs2_im_0_eb_state_nxt = s0_bs2_im_0_eb_state;
    case(s0_bs2_im_0_eb_state)
      5'h14 : begin
        if(s0_bs2_im_0_req) begin
          s0_bs2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_bs2_im_0_req) && s0_bs2_im_0_m_ack)) begin
          s0_bs2_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs2_im_0_req && (! s0_bs2_im_0_m_ack))) begin
          s0_bs2_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_bs2_im_0_req && s0_bs2_im_0_m_ack)) begin
          s0_bs2_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_bs2_im_0_m_ack) begin
          s0_bs2_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_bs2_im_0_req) && s0_bs2_im_0_m_ack)) begin
          s0_bs2_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs2_im_0_req && (! s0_bs2_im_0_m_ack))) begin
          s0_bs2_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_bs2_im_0_req && s0_bs2_im_0_m_ack)) begin
          s0_bs2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_bs2_im_0_m_ack) begin
          s0_bs2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_bs2_im_0_eb_en0 = (s0_bs2_im_0_eb_state[2] && s0_bs2_im_0_req);
  assign s0_bs2_im_0_eb_en1 = (s0_bs2_im_0_eb_state[1] && s0_bs2_im_0_req);
  assign s0_bs2_im_0_eb_sel = s0_bs2_im_0_eb_state[0];
  assign s0_bs2_im_0_ack = s0_bs2_im_0_eb_state[4];
  assign s0_bs2_im_0_m_req = s0_bs2_im_0_eb_state[3];
  assign s0_bs2_im_0 = (s0_bs2_im_0_eb_sel ? s0_bs2_im_0_eb_r1 : s0_bs2_im_0_eb_r0);
  assign s0_bs2_im_0_to_s0_rsat2_im_req = s0_bs2_im_0_m_req;
  assign s0_bs2_im_0_m_ack = s0_bs2_im_0_to_s0_rsat2_im_ack;
  assign s0_rsat2_re_0_ack = ((! s0_rsat2_re_0_eb_valid) || s0_rsat2_re_0_m_ack);
  assign s0_rsat2_re_0_eb_en = (s0_rsat2_re_0_req && s0_rsat2_re_0_ack);
  assign s0_rsat2_re_0_m_req = s0_rsat2_re_0_eb_valid;
  assign s0_rsat2_re_0 = s0_rsat2_re_0_eb_r;
  assign s0_rsat2_re_0_to_s0_k1_cat_req = s0_rsat2_re_0_m_req;
  assign s0_rsat2_re_0_m_ack = s0_rsat2_re_0_to_s0_k1_cat_ack;
  assign s0_rsat2_im_0_ack = ((! s0_rsat2_im_0_eb_valid) || s0_rsat2_im_0_m_ack);
  assign s0_rsat2_im_0_eb_en = (s0_rsat2_im_0_req && s0_rsat2_im_0_ack);
  assign s0_rsat2_im_0_m_req = s0_rsat2_im_0_eb_valid;
  assign s0_rsat2_im_0 = s0_rsat2_im_0_eb_r;
  assign s0_rsat2_im_0_to_s0_k1_cat_req = s0_rsat2_im_0_m_req;
  assign s0_rsat2_im_0_m_ack = s0_rsat2_im_0_to_s0_k1_cat_ack;
  assign cfg_s0_bs3_re_m_req = cfg_s0_bs3_re_req;
  assign cfg_s0_bs3_re_ack = cfg_s0_bs3_re_m_ack;
  assign cfg_s0_bs3_re_to_s0_bs3_re_req = cfg_s0_bs3_re_m_req;
  assign cfg_s0_bs3_re_m_ack = cfg_s0_bs3_re_to_s0_bs3_re_ack;
  assign cfg_s0_bs3_im_m_req = cfg_s0_bs3_im_req;
  assign cfg_s0_bs3_im_ack = cfg_s0_bs3_im_m_ack;
  assign cfg_s0_bs3_im_to_s0_bs3_im_req = cfg_s0_bs3_im_m_req;
  assign cfg_s0_bs3_im_m_ack = cfg_s0_bs3_im_to_s0_bs3_im_ack;
  always @(*) begin
    s0_bs3_re_0_eb_state_nxt = s0_bs3_re_0_eb_state;
    case(s0_bs3_re_0_eb_state)
      5'h14 : begin
        if(s0_bs3_re_0_req) begin
          s0_bs3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_bs3_re_0_req) && s0_bs3_re_0_m_ack)) begin
          s0_bs3_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs3_re_0_req && (! s0_bs3_re_0_m_ack))) begin
          s0_bs3_re_0_eb_state_nxt = 5'h08;
        end
        if((s0_bs3_re_0_req && s0_bs3_re_0_m_ack)) begin
          s0_bs3_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_bs3_re_0_m_ack) begin
          s0_bs3_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_bs3_re_0_req) && s0_bs3_re_0_m_ack)) begin
          s0_bs3_re_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs3_re_0_req && (! s0_bs3_re_0_m_ack))) begin
          s0_bs3_re_0_eb_state_nxt = 5'h09;
        end
        if((s0_bs3_re_0_req && s0_bs3_re_0_m_ack)) begin
          s0_bs3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_bs3_re_0_m_ack) begin
          s0_bs3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_bs3_re_0_eb_en0 = (s0_bs3_re_0_eb_state[2] && s0_bs3_re_0_req);
  assign s0_bs3_re_0_eb_en1 = (s0_bs3_re_0_eb_state[1] && s0_bs3_re_0_req);
  assign s0_bs3_re_0_eb_sel = s0_bs3_re_0_eb_state[0];
  assign s0_bs3_re_0_ack = s0_bs3_re_0_eb_state[4];
  assign s0_bs3_re_0_m_req = s0_bs3_re_0_eb_state[3];
  assign s0_bs3_re_0 = (s0_bs3_re_0_eb_sel ? s0_bs3_re_0_eb_r1 : s0_bs3_re_0_eb_r0);
  assign s0_bs3_re_0_to_s0_rsat3_re_req = s0_bs3_re_0_m_req;
  assign s0_bs3_re_0_m_ack = s0_bs3_re_0_to_s0_rsat3_re_ack;
  always @(*) begin
    s0_bs3_im_0_eb_state_nxt = s0_bs3_im_0_eb_state;
    case(s0_bs3_im_0_eb_state)
      5'h14 : begin
        if(s0_bs3_im_0_req) begin
          s0_bs3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s0_bs3_im_0_req) && s0_bs3_im_0_m_ack)) begin
          s0_bs3_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs3_im_0_req && (! s0_bs3_im_0_m_ack))) begin
          s0_bs3_im_0_eb_state_nxt = 5'h08;
        end
        if((s0_bs3_im_0_req && s0_bs3_im_0_m_ack)) begin
          s0_bs3_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s0_bs3_im_0_m_ack) begin
          s0_bs3_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s0_bs3_im_0_req) && s0_bs3_im_0_m_ack)) begin
          s0_bs3_im_0_eb_state_nxt = 5'h14;
        end
        if((s0_bs3_im_0_req && (! s0_bs3_im_0_m_ack))) begin
          s0_bs3_im_0_eb_state_nxt = 5'h09;
        end
        if((s0_bs3_im_0_req && s0_bs3_im_0_m_ack)) begin
          s0_bs3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s0_bs3_im_0_m_ack) begin
          s0_bs3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s0_bs3_im_0_eb_en0 = (s0_bs3_im_0_eb_state[2] && s0_bs3_im_0_req);
  assign s0_bs3_im_0_eb_en1 = (s0_bs3_im_0_eb_state[1] && s0_bs3_im_0_req);
  assign s0_bs3_im_0_eb_sel = s0_bs3_im_0_eb_state[0];
  assign s0_bs3_im_0_ack = s0_bs3_im_0_eb_state[4];
  assign s0_bs3_im_0_m_req = s0_bs3_im_0_eb_state[3];
  assign s0_bs3_im_0 = (s0_bs3_im_0_eb_sel ? s0_bs3_im_0_eb_r1 : s0_bs3_im_0_eb_r0);
  assign s0_bs3_im_0_to_s0_rsat3_im_req = s0_bs3_im_0_m_req;
  assign s0_bs3_im_0_m_ack = s0_bs3_im_0_to_s0_rsat3_im_ack;
  assign s0_rsat3_re_0_ack = ((! s0_rsat3_re_0_eb_valid) || s0_rsat3_re_0_m_ack);
  assign s0_rsat3_re_0_eb_en = (s0_rsat3_re_0_req && s0_rsat3_re_0_ack);
  assign s0_rsat3_re_0_m_req = s0_rsat3_re_0_eb_valid;
  assign s0_rsat3_re_0 = s0_rsat3_re_0_eb_r;
  assign s0_rsat3_re_0_to_s0_k1_cat_req = s0_rsat3_re_0_m_req;
  assign s0_rsat3_re_0_m_ack = s0_rsat3_re_0_to_s0_k1_cat_ack;
  assign s0_rsat3_im_0_ack = ((! s0_rsat3_im_0_eb_valid) || s0_rsat3_im_0_m_ack);
  assign s0_rsat3_im_0_eb_en = (s0_rsat3_im_0_req && s0_rsat3_im_0_ack);
  assign s0_rsat3_im_0_m_req = s0_rsat3_im_0_eb_valid;
  assign s0_rsat3_im_0 = s0_rsat3_im_0_eb_r;
  assign s0_rsat3_im_0_to_s0_k1_cat_req = s0_rsat3_im_0_m_req;
  assign s0_rsat3_im_0_m_ack = s0_rsat3_im_0_to_s0_k1_cat_ack;
  assign s1_k1_cat_0_m_req = s1_k1_cat_0_req;
  assign s1_k1_cat_0_ack = s1_k1_cat_0_m_ack;
  assign s1_k1_cat_0_to_k1_defunnel_req = s1_k1_cat_0_m_req;
  assign s1_k1_cat_0_m_ack = s1_k1_cat_0_to_k1_defunnel_ack;
  assign cfg_s1_bs0_re_m_req = cfg_s1_bs0_re_req;
  assign cfg_s1_bs0_re_ack = cfg_s1_bs0_re_m_ack;
  assign cfg_s1_bs0_re_to_s1_bs0_re_req = cfg_s1_bs0_re_m_req;
  assign cfg_s1_bs0_re_m_ack = cfg_s1_bs0_re_to_s1_bs0_re_ack;
  assign cfg_s1_bs0_im_m_req = cfg_s1_bs0_im_req;
  assign cfg_s1_bs0_im_ack = cfg_s1_bs0_im_m_ack;
  assign cfg_s1_bs0_im_to_s1_bs0_im_req = cfg_s1_bs0_im_m_req;
  assign cfg_s1_bs0_im_m_ack = cfg_s1_bs0_im_to_s1_bs0_im_ack;
  always @(*) begin
    s1_bs0_re_0_eb_state_nxt = s1_bs0_re_0_eb_state;
    case(s1_bs0_re_0_eb_state)
      5'h14 : begin
        if(s1_bs0_re_0_req) begin
          s1_bs0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_bs0_re_0_req) && s1_bs0_re_0_m_ack)) begin
          s1_bs0_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs0_re_0_req && (! s1_bs0_re_0_m_ack))) begin
          s1_bs0_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_bs0_re_0_req && s1_bs0_re_0_m_ack)) begin
          s1_bs0_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_bs0_re_0_m_ack) begin
          s1_bs0_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_bs0_re_0_req) && s1_bs0_re_0_m_ack)) begin
          s1_bs0_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs0_re_0_req && (! s1_bs0_re_0_m_ack))) begin
          s1_bs0_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_bs0_re_0_req && s1_bs0_re_0_m_ack)) begin
          s1_bs0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_bs0_re_0_m_ack) begin
          s1_bs0_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_bs0_re_0_eb_en0 = (s1_bs0_re_0_eb_state[2] && s1_bs0_re_0_req);
  assign s1_bs0_re_0_eb_en1 = (s1_bs0_re_0_eb_state[1] && s1_bs0_re_0_req);
  assign s1_bs0_re_0_eb_sel = s1_bs0_re_0_eb_state[0];
  assign s1_bs0_re_0_ack = s1_bs0_re_0_eb_state[4];
  assign s1_bs0_re_0_m_req = s1_bs0_re_0_eb_state[3];
  assign s1_bs0_re_0 = (s1_bs0_re_0_eb_sel ? s1_bs0_re_0_eb_r1 : s1_bs0_re_0_eb_r0);
  assign s1_bs0_re_0_to_s1_rsat0_re_req = s1_bs0_re_0_m_req;
  assign s1_bs0_re_0_m_ack = s1_bs0_re_0_to_s1_rsat0_re_ack;
  always @(*) begin
    s1_bs0_im_0_eb_state_nxt = s1_bs0_im_0_eb_state;
    case(s1_bs0_im_0_eb_state)
      5'h14 : begin
        if(s1_bs0_im_0_req) begin
          s1_bs0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_bs0_im_0_req) && s1_bs0_im_0_m_ack)) begin
          s1_bs0_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs0_im_0_req && (! s1_bs0_im_0_m_ack))) begin
          s1_bs0_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_bs0_im_0_req && s1_bs0_im_0_m_ack)) begin
          s1_bs0_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_bs0_im_0_m_ack) begin
          s1_bs0_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_bs0_im_0_req) && s1_bs0_im_0_m_ack)) begin
          s1_bs0_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs0_im_0_req && (! s1_bs0_im_0_m_ack))) begin
          s1_bs0_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_bs0_im_0_req && s1_bs0_im_0_m_ack)) begin
          s1_bs0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_bs0_im_0_m_ack) begin
          s1_bs0_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_bs0_im_0_eb_en0 = (s1_bs0_im_0_eb_state[2] && s1_bs0_im_0_req);
  assign s1_bs0_im_0_eb_en1 = (s1_bs0_im_0_eb_state[1] && s1_bs0_im_0_req);
  assign s1_bs0_im_0_eb_sel = s1_bs0_im_0_eb_state[0];
  assign s1_bs0_im_0_ack = s1_bs0_im_0_eb_state[4];
  assign s1_bs0_im_0_m_req = s1_bs0_im_0_eb_state[3];
  assign s1_bs0_im_0 = (s1_bs0_im_0_eb_sel ? s1_bs0_im_0_eb_r1 : s1_bs0_im_0_eb_r0);
  assign s1_bs0_im_0_to_s1_rsat0_im_req = s1_bs0_im_0_m_req;
  assign s1_bs0_im_0_m_ack = s1_bs0_im_0_to_s1_rsat0_im_ack;
  assign s1_rsat0_re_0_ack = ((! s1_rsat0_re_0_eb_valid) || s1_rsat0_re_0_m_ack);
  assign s1_rsat0_re_0_eb_en = (s1_rsat0_re_0_req && s1_rsat0_re_0_ack);
  assign s1_rsat0_re_0_m_req = s1_rsat0_re_0_eb_valid;
  assign s1_rsat0_re_0 = s1_rsat0_re_0_eb_r;
  assign s1_rsat0_re_0_to_s1_k1_cat_req = s1_rsat0_re_0_m_req;
  assign s1_rsat0_re_0_m_ack = s1_rsat0_re_0_to_s1_k1_cat_ack;
  assign s1_rsat0_im_0_ack = ((! s1_rsat0_im_0_eb_valid) || s1_rsat0_im_0_m_ack);
  assign s1_rsat0_im_0_eb_en = (s1_rsat0_im_0_req && s1_rsat0_im_0_ack);
  assign s1_rsat0_im_0_m_req = s1_rsat0_im_0_eb_valid;
  assign s1_rsat0_im_0 = s1_rsat0_im_0_eb_r;
  assign s1_rsat0_im_0_to_s1_k1_cat_req = s1_rsat0_im_0_m_req;
  assign s1_rsat0_im_0_m_ack = s1_rsat0_im_0_to_s1_k1_cat_ack;
  assign cfg_s1_bs1_re_m_req = cfg_s1_bs1_re_req;
  assign cfg_s1_bs1_re_ack = cfg_s1_bs1_re_m_ack;
  assign cfg_s1_bs1_re_to_s1_bs1_re_req = cfg_s1_bs1_re_m_req;
  assign cfg_s1_bs1_re_m_ack = cfg_s1_bs1_re_to_s1_bs1_re_ack;
  assign cfg_s1_bs1_im_m_req = cfg_s1_bs1_im_req;
  assign cfg_s1_bs1_im_ack = cfg_s1_bs1_im_m_ack;
  assign cfg_s1_bs1_im_to_s1_bs1_im_req = cfg_s1_bs1_im_m_req;
  assign cfg_s1_bs1_im_m_ack = cfg_s1_bs1_im_to_s1_bs1_im_ack;
  always @(*) begin
    s1_bs1_re_0_eb_state_nxt = s1_bs1_re_0_eb_state;
    case(s1_bs1_re_0_eb_state)
      5'h14 : begin
        if(s1_bs1_re_0_req) begin
          s1_bs1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_bs1_re_0_req) && s1_bs1_re_0_m_ack)) begin
          s1_bs1_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs1_re_0_req && (! s1_bs1_re_0_m_ack))) begin
          s1_bs1_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_bs1_re_0_req && s1_bs1_re_0_m_ack)) begin
          s1_bs1_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_bs1_re_0_m_ack) begin
          s1_bs1_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_bs1_re_0_req) && s1_bs1_re_0_m_ack)) begin
          s1_bs1_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs1_re_0_req && (! s1_bs1_re_0_m_ack))) begin
          s1_bs1_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_bs1_re_0_req && s1_bs1_re_0_m_ack)) begin
          s1_bs1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_bs1_re_0_m_ack) begin
          s1_bs1_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_bs1_re_0_eb_en0 = (s1_bs1_re_0_eb_state[2] && s1_bs1_re_0_req);
  assign s1_bs1_re_0_eb_en1 = (s1_bs1_re_0_eb_state[1] && s1_bs1_re_0_req);
  assign s1_bs1_re_0_eb_sel = s1_bs1_re_0_eb_state[0];
  assign s1_bs1_re_0_ack = s1_bs1_re_0_eb_state[4];
  assign s1_bs1_re_0_m_req = s1_bs1_re_0_eb_state[3];
  assign s1_bs1_re_0 = (s1_bs1_re_0_eb_sel ? s1_bs1_re_0_eb_r1 : s1_bs1_re_0_eb_r0);
  assign s1_bs1_re_0_to_s1_rsat1_re_req = s1_bs1_re_0_m_req;
  assign s1_bs1_re_0_m_ack = s1_bs1_re_0_to_s1_rsat1_re_ack;
  always @(*) begin
    s1_bs1_im_0_eb_state_nxt = s1_bs1_im_0_eb_state;
    case(s1_bs1_im_0_eb_state)
      5'h14 : begin
        if(s1_bs1_im_0_req) begin
          s1_bs1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_bs1_im_0_req) && s1_bs1_im_0_m_ack)) begin
          s1_bs1_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs1_im_0_req && (! s1_bs1_im_0_m_ack))) begin
          s1_bs1_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_bs1_im_0_req && s1_bs1_im_0_m_ack)) begin
          s1_bs1_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_bs1_im_0_m_ack) begin
          s1_bs1_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_bs1_im_0_req) && s1_bs1_im_0_m_ack)) begin
          s1_bs1_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs1_im_0_req && (! s1_bs1_im_0_m_ack))) begin
          s1_bs1_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_bs1_im_0_req && s1_bs1_im_0_m_ack)) begin
          s1_bs1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_bs1_im_0_m_ack) begin
          s1_bs1_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_bs1_im_0_eb_en0 = (s1_bs1_im_0_eb_state[2] && s1_bs1_im_0_req);
  assign s1_bs1_im_0_eb_en1 = (s1_bs1_im_0_eb_state[1] && s1_bs1_im_0_req);
  assign s1_bs1_im_0_eb_sel = s1_bs1_im_0_eb_state[0];
  assign s1_bs1_im_0_ack = s1_bs1_im_0_eb_state[4];
  assign s1_bs1_im_0_m_req = s1_bs1_im_0_eb_state[3];
  assign s1_bs1_im_0 = (s1_bs1_im_0_eb_sel ? s1_bs1_im_0_eb_r1 : s1_bs1_im_0_eb_r0);
  assign s1_bs1_im_0_to_s1_rsat1_im_req = s1_bs1_im_0_m_req;
  assign s1_bs1_im_0_m_ack = s1_bs1_im_0_to_s1_rsat1_im_ack;
  assign s1_rsat1_re_0_ack = ((! s1_rsat1_re_0_eb_valid) || s1_rsat1_re_0_m_ack);
  assign s1_rsat1_re_0_eb_en = (s1_rsat1_re_0_req && s1_rsat1_re_0_ack);
  assign s1_rsat1_re_0_m_req = s1_rsat1_re_0_eb_valid;
  assign s1_rsat1_re_0 = s1_rsat1_re_0_eb_r;
  assign s1_rsat1_re_0_to_s1_k1_cat_req = s1_rsat1_re_0_m_req;
  assign s1_rsat1_re_0_m_ack = s1_rsat1_re_0_to_s1_k1_cat_ack;
  assign s1_rsat1_im_0_ack = ((! s1_rsat1_im_0_eb_valid) || s1_rsat1_im_0_m_ack);
  assign s1_rsat1_im_0_eb_en = (s1_rsat1_im_0_req && s1_rsat1_im_0_ack);
  assign s1_rsat1_im_0_m_req = s1_rsat1_im_0_eb_valid;
  assign s1_rsat1_im_0 = s1_rsat1_im_0_eb_r;
  assign s1_rsat1_im_0_to_s1_k1_cat_req = s1_rsat1_im_0_m_req;
  assign s1_rsat1_im_0_m_ack = s1_rsat1_im_0_to_s1_k1_cat_ack;
  assign cfg_s1_bs2_re_m_req = cfg_s1_bs2_re_req;
  assign cfg_s1_bs2_re_ack = cfg_s1_bs2_re_m_ack;
  assign cfg_s1_bs2_re_to_s1_bs2_re_req = cfg_s1_bs2_re_m_req;
  assign cfg_s1_bs2_re_m_ack = cfg_s1_bs2_re_to_s1_bs2_re_ack;
  assign cfg_s1_bs2_im_m_req = cfg_s1_bs2_im_req;
  assign cfg_s1_bs2_im_ack = cfg_s1_bs2_im_m_ack;
  assign cfg_s1_bs2_im_to_s1_bs2_im_req = cfg_s1_bs2_im_m_req;
  assign cfg_s1_bs2_im_m_ack = cfg_s1_bs2_im_to_s1_bs2_im_ack;
  always @(*) begin
    s1_bs2_re_0_eb_state_nxt = s1_bs2_re_0_eb_state;
    case(s1_bs2_re_0_eb_state)
      5'h14 : begin
        if(s1_bs2_re_0_req) begin
          s1_bs2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_bs2_re_0_req) && s1_bs2_re_0_m_ack)) begin
          s1_bs2_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs2_re_0_req && (! s1_bs2_re_0_m_ack))) begin
          s1_bs2_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_bs2_re_0_req && s1_bs2_re_0_m_ack)) begin
          s1_bs2_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_bs2_re_0_m_ack) begin
          s1_bs2_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_bs2_re_0_req) && s1_bs2_re_0_m_ack)) begin
          s1_bs2_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs2_re_0_req && (! s1_bs2_re_0_m_ack))) begin
          s1_bs2_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_bs2_re_0_req && s1_bs2_re_0_m_ack)) begin
          s1_bs2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_bs2_re_0_m_ack) begin
          s1_bs2_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_bs2_re_0_eb_en0 = (s1_bs2_re_0_eb_state[2] && s1_bs2_re_0_req);
  assign s1_bs2_re_0_eb_en1 = (s1_bs2_re_0_eb_state[1] && s1_bs2_re_0_req);
  assign s1_bs2_re_0_eb_sel = s1_bs2_re_0_eb_state[0];
  assign s1_bs2_re_0_ack = s1_bs2_re_0_eb_state[4];
  assign s1_bs2_re_0_m_req = s1_bs2_re_0_eb_state[3];
  assign s1_bs2_re_0 = (s1_bs2_re_0_eb_sel ? s1_bs2_re_0_eb_r1 : s1_bs2_re_0_eb_r0);
  assign s1_bs2_re_0_to_s1_rsat2_re_req = s1_bs2_re_0_m_req;
  assign s1_bs2_re_0_m_ack = s1_bs2_re_0_to_s1_rsat2_re_ack;
  always @(*) begin
    s1_bs2_im_0_eb_state_nxt = s1_bs2_im_0_eb_state;
    case(s1_bs2_im_0_eb_state)
      5'h14 : begin
        if(s1_bs2_im_0_req) begin
          s1_bs2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_bs2_im_0_req) && s1_bs2_im_0_m_ack)) begin
          s1_bs2_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs2_im_0_req && (! s1_bs2_im_0_m_ack))) begin
          s1_bs2_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_bs2_im_0_req && s1_bs2_im_0_m_ack)) begin
          s1_bs2_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_bs2_im_0_m_ack) begin
          s1_bs2_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_bs2_im_0_req) && s1_bs2_im_0_m_ack)) begin
          s1_bs2_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs2_im_0_req && (! s1_bs2_im_0_m_ack))) begin
          s1_bs2_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_bs2_im_0_req && s1_bs2_im_0_m_ack)) begin
          s1_bs2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_bs2_im_0_m_ack) begin
          s1_bs2_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_bs2_im_0_eb_en0 = (s1_bs2_im_0_eb_state[2] && s1_bs2_im_0_req);
  assign s1_bs2_im_0_eb_en1 = (s1_bs2_im_0_eb_state[1] && s1_bs2_im_0_req);
  assign s1_bs2_im_0_eb_sel = s1_bs2_im_0_eb_state[0];
  assign s1_bs2_im_0_ack = s1_bs2_im_0_eb_state[4];
  assign s1_bs2_im_0_m_req = s1_bs2_im_0_eb_state[3];
  assign s1_bs2_im_0 = (s1_bs2_im_0_eb_sel ? s1_bs2_im_0_eb_r1 : s1_bs2_im_0_eb_r0);
  assign s1_bs2_im_0_to_s1_rsat2_im_req = s1_bs2_im_0_m_req;
  assign s1_bs2_im_0_m_ack = s1_bs2_im_0_to_s1_rsat2_im_ack;
  assign s1_rsat2_re_0_ack = ((! s1_rsat2_re_0_eb_valid) || s1_rsat2_re_0_m_ack);
  assign s1_rsat2_re_0_eb_en = (s1_rsat2_re_0_req && s1_rsat2_re_0_ack);
  assign s1_rsat2_re_0_m_req = s1_rsat2_re_0_eb_valid;
  assign s1_rsat2_re_0 = s1_rsat2_re_0_eb_r;
  assign s1_rsat2_re_0_to_s1_k1_cat_req = s1_rsat2_re_0_m_req;
  assign s1_rsat2_re_0_m_ack = s1_rsat2_re_0_to_s1_k1_cat_ack;
  assign s1_rsat2_im_0_ack = ((! s1_rsat2_im_0_eb_valid) || s1_rsat2_im_0_m_ack);
  assign s1_rsat2_im_0_eb_en = (s1_rsat2_im_0_req && s1_rsat2_im_0_ack);
  assign s1_rsat2_im_0_m_req = s1_rsat2_im_0_eb_valid;
  assign s1_rsat2_im_0 = s1_rsat2_im_0_eb_r;
  assign s1_rsat2_im_0_to_s1_k1_cat_req = s1_rsat2_im_0_m_req;
  assign s1_rsat2_im_0_m_ack = s1_rsat2_im_0_to_s1_k1_cat_ack;
  assign cfg_s1_bs3_re_m_req = cfg_s1_bs3_re_req;
  assign cfg_s1_bs3_re_ack = cfg_s1_bs3_re_m_ack;
  assign cfg_s1_bs3_re_to_s1_bs3_re_req = cfg_s1_bs3_re_m_req;
  assign cfg_s1_bs3_re_m_ack = cfg_s1_bs3_re_to_s1_bs3_re_ack;
  assign cfg_s1_bs3_im_m_req = cfg_s1_bs3_im_req;
  assign cfg_s1_bs3_im_ack = cfg_s1_bs3_im_m_ack;
  assign cfg_s1_bs3_im_to_s1_bs3_im_req = cfg_s1_bs3_im_m_req;
  assign cfg_s1_bs3_im_m_ack = cfg_s1_bs3_im_to_s1_bs3_im_ack;
  always @(*) begin
    s1_bs3_re_0_eb_state_nxt = s1_bs3_re_0_eb_state;
    case(s1_bs3_re_0_eb_state)
      5'h14 : begin
        if(s1_bs3_re_0_req) begin
          s1_bs3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_bs3_re_0_req) && s1_bs3_re_0_m_ack)) begin
          s1_bs3_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs3_re_0_req && (! s1_bs3_re_0_m_ack))) begin
          s1_bs3_re_0_eb_state_nxt = 5'h08;
        end
        if((s1_bs3_re_0_req && s1_bs3_re_0_m_ack)) begin
          s1_bs3_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_bs3_re_0_m_ack) begin
          s1_bs3_re_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_bs3_re_0_req) && s1_bs3_re_0_m_ack)) begin
          s1_bs3_re_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs3_re_0_req && (! s1_bs3_re_0_m_ack))) begin
          s1_bs3_re_0_eb_state_nxt = 5'h09;
        end
        if((s1_bs3_re_0_req && s1_bs3_re_0_m_ack)) begin
          s1_bs3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_bs3_re_0_m_ack) begin
          s1_bs3_re_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_bs3_re_0_eb_en0 = (s1_bs3_re_0_eb_state[2] && s1_bs3_re_0_req);
  assign s1_bs3_re_0_eb_en1 = (s1_bs3_re_0_eb_state[1] && s1_bs3_re_0_req);
  assign s1_bs3_re_0_eb_sel = s1_bs3_re_0_eb_state[0];
  assign s1_bs3_re_0_ack = s1_bs3_re_0_eb_state[4];
  assign s1_bs3_re_0_m_req = s1_bs3_re_0_eb_state[3];
  assign s1_bs3_re_0 = (s1_bs3_re_0_eb_sel ? s1_bs3_re_0_eb_r1 : s1_bs3_re_0_eb_r0);
  assign s1_bs3_re_0_to_s1_rsat3_re_req = s1_bs3_re_0_m_req;
  assign s1_bs3_re_0_m_ack = s1_bs3_re_0_to_s1_rsat3_re_ack;
  always @(*) begin
    s1_bs3_im_0_eb_state_nxt = s1_bs3_im_0_eb_state;
    case(s1_bs3_im_0_eb_state)
      5'h14 : begin
        if(s1_bs3_im_0_req) begin
          s1_bs3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h1a : begin
        if(((! s1_bs3_im_0_req) && s1_bs3_im_0_m_ack)) begin
          s1_bs3_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs3_im_0_req && (! s1_bs3_im_0_m_ack))) begin
          s1_bs3_im_0_eb_state_nxt = 5'h08;
        end
        if((s1_bs3_im_0_req && s1_bs3_im_0_m_ack)) begin
          s1_bs3_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h08 : begin
        if(s1_bs3_im_0_m_ack) begin
          s1_bs3_im_0_eb_state_nxt = 5'h1d;
        end
      end
      5'h1d : begin
        if(((! s1_bs3_im_0_req) && s1_bs3_im_0_m_ack)) begin
          s1_bs3_im_0_eb_state_nxt = 5'h14;
        end
        if((s1_bs3_im_0_req && (! s1_bs3_im_0_m_ack))) begin
          s1_bs3_im_0_eb_state_nxt = 5'h09;
        end
        if((s1_bs3_im_0_req && s1_bs3_im_0_m_ack)) begin
          s1_bs3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      5'h09 : begin
        if(s1_bs3_im_0_m_ack) begin
          s1_bs3_im_0_eb_state_nxt = 5'h1a;
        end
      end
      default : begin
      end
    endcase
  end

  assign s1_bs3_im_0_eb_en0 = (s1_bs3_im_0_eb_state[2] && s1_bs3_im_0_req);
  assign s1_bs3_im_0_eb_en1 = (s1_bs3_im_0_eb_state[1] && s1_bs3_im_0_req);
  assign s1_bs3_im_0_eb_sel = s1_bs3_im_0_eb_state[0];
  assign s1_bs3_im_0_ack = s1_bs3_im_0_eb_state[4];
  assign s1_bs3_im_0_m_req = s1_bs3_im_0_eb_state[3];
  assign s1_bs3_im_0 = (s1_bs3_im_0_eb_sel ? s1_bs3_im_0_eb_r1 : s1_bs3_im_0_eb_r0);
  assign s1_bs3_im_0_to_s1_rsat3_im_req = s1_bs3_im_0_m_req;
  assign s1_bs3_im_0_m_ack = s1_bs3_im_0_to_s1_rsat3_im_ack;
  assign s1_rsat3_re_0_ack = ((! s1_rsat3_re_0_eb_valid) || s1_rsat3_re_0_m_ack);
  assign s1_rsat3_re_0_eb_en = (s1_rsat3_re_0_req && s1_rsat3_re_0_ack);
  assign s1_rsat3_re_0_m_req = s1_rsat3_re_0_eb_valid;
  assign s1_rsat3_re_0 = s1_rsat3_re_0_eb_r;
  assign s1_rsat3_re_0_to_s1_k1_cat_req = s1_rsat3_re_0_m_req;
  assign s1_rsat3_re_0_m_ack = s1_rsat3_re_0_to_s1_k1_cat_ack;
  assign s1_rsat3_im_0_ack = ((! s1_rsat3_im_0_eb_valid) || s1_rsat3_im_0_m_ack);
  assign s1_rsat3_im_0_eb_en = (s1_rsat3_im_0_req && s1_rsat3_im_0_ack);
  assign s1_rsat3_im_0_m_req = s1_rsat3_im_0_eb_valid;
  assign s1_rsat3_im_0 = s1_rsat3_im_0_eb_r;
  assign s1_rsat3_im_0_to_s1_k1_cat_req = s1_rsat3_im_0_m_req;
  assign s1_rsat3_im_0_m_ack = s1_rsat3_im_0_to_s1_k1_cat_ack;
  assign cfg_k8_funnel_m_req = cfg_k8_funnel_req;
  assign cfg_k8_funnel_ack = cfg_k8_funnel_m_ack;
  assign cfg_k8_funnel_to_k8_funnel_req = cfg_k8_funnel_m_req;
  assign cfg_k8_funnel_m_ack = cfg_k8_funnel_to_k8_funnel_ack;
  assign cfg_k9_funnel_m_req = cfg_k9_funnel_req;
  assign cfg_k9_funnel_ack = cfg_k9_funnel_m_ack;
  assign cfg_k9_funnel_to_k9_funnel_req = cfg_k9_funnel_m_req;
  assign cfg_k9_funnel_m_ack = cfg_k9_funnel_to_k9_funnel_ack;
  assign cfg_k1_defunnel_m_req = cfg_k1_defunnel_req;
  assign cfg_k1_defunnel_ack = cfg_k1_defunnel_m_ack;
  assign cfg_k1_defunnel_to_k1_defunnel_req = cfg_k1_defunnel_m_req;
  assign cfg_k1_defunnel_m_ack = cfg_k1_defunnel_to_k1_defunnel_ack;
  always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
      cfg_i_0_req_reg <= 1'b0;
      cfg_i_1_req_reg <= 1'b0;
      cfg_i_2_req_reg <= 1'b0;
      cfg_i_3_req_reg <= 1'b0;
      cfg_i_4_req_reg <= 1'b0;
      cfg_i_5_req_reg <= 1'b0;
      cfg_i_6_req_reg <= 1'b0;
      cfg_i_7_req_reg <= 1'b0;
      cfg_i_8_req_reg <= 1'b0;
      cfg_i_9_req_reg <= 1'b0;
      cfg_i_10_req_reg <= 1'b0;
      cfg_i_11_req_reg <= 1'b0;
      cfg_i_12_req_reg <= 1'b0;
      cfg_i_13_req_reg <= 1'b0;
      cfg_i_14_req_reg <= 1'b0;
      cfg_i_15_req_reg <= 1'b0;
      cfg_i_16_req_reg <= 1'b0;
      cfg_i_17_req_reg <= 1'b0;
      cfg_i_18_req_reg <= 1'b0;
      cfg_i_19_req_reg <= 1'b0;
      cfg_i_20_req_reg <= 1'b0;
      cfg_i_21_req_reg <= 1'b0;
      cfg_i_22_req_reg <= 1'b0;
      cfg_i_23_req_reg <= 1'b0;
      cfg_i_24_req_reg <= 1'b0;
      cfg_i_25_req_reg <= 1'b0;
      cfg_i_26_req_reg <= 1'b0;
      cfg_i_27_req_reg <= 1'b0;
      cfg_i_28_req_reg <= 1'b0;
      cfg_i_29_req_reg <= 1'b0;
      cfg_i_30_req_reg <= 1'b0;
      cfg_i_31_req_reg <= 1'b0;
      cfg_i_32_req_reg <= 1'b0;
      cfg_i_33_req_reg <= 1'b0;
      cfg_i_34_req_reg <= 1'b0;
      cfg_i_35_req_reg <= 1'b0;
      cfg_i_36_req_reg <= 1'b0;
      cfg_i_37_req_reg <= 1'b0;
      cfg_i_38_req_reg <= 1'b0;
      cfg_i_39_req_reg <= 1'b0;
      cfg_i_40_req_reg <= 1'b0;
      cfg_i_41_req_reg <= 1'b0;
      cfg_i_42_req_reg <= 1'b0;
      cfg_i_43_req_reg <= 1'b0;
      cfg_i_44_req_reg <= 1'b0;
      cfg_i_45_req_reg <= 1'b0;
      cfg_i_46_req_reg <= 1'b0;
      cfg_i_47_req_reg <= 1'b0;
      cfg_i_48_req_reg <= 1'b0;
      cfg_i_49_req_reg <= 1'b0;
      cfg_i_50_req_reg <= 1'b0;
      cfg_i_51_req_reg <= 1'b0;
      cfg_i_52_req_reg <= 1'b0;
      cfg_i_53_req_reg <= 1'b0;
      cfg_i_54_req_reg <= 1'b0;
      cfg_i_55_req_reg <= 1'b0;
      cfg_i_56_req_reg <= 1'b0;
      cfg_i_57_req_reg <= 1'b0;
      cfg_i_58_req_reg <= 1'b0;
      cfg_i_59_req_reg <= 1'b0;
      cfg_i_60_req_reg <= 1'b0;
      cfg_i_61_req_reg <= 1'b0;
      cfg_i_62_req_reg <= 1'b0;
      cfg_i_63_req_reg <= 1'b0;
      cfg_i_64_req_reg <= 1'b0;
      cfg_i_65_req_reg <= 1'b0;
      cfg_i_66_req_reg <= 1'b0;
      cfg_i_67_req_reg <= 1'b0;
      cfg_i_68_req_reg <= 1'b0;
      cfg_i_69_req_reg <= 1'b0;
      cfg_i_70_req_reg <= 1'b0;
      cfg_i_71_req_reg <= 1'b0;
      cfg_i_72_req_reg <= 1'b0;
      cfg_i_73_req_reg <= 1'b0;
      cfg_i_74_req_reg <= 1'b0;
      cfg_i_75_req_reg <= 1'b0;
      cfg_i_76_req_reg <= 1'b0;
      cfg_i_77_req_reg <= 1'b0;
      cfg_i_78_req_reg <= 1'b0;
      cfg_i_79_req_reg <= 1'b0;
      cfg_i_80_req_reg <= 1'b0;
      cfg_i_81_req_reg <= 1'b0;
      cfg_i_82_req_reg <= 1'b0;
      cfg_i_83_req_reg <= 1'b0;
      cfg_i_84_req_reg <= 1'b0;
      cfg_i_85_req_reg <= 1'b0;
      cfg_i_86_req_reg <= 1'b0;
      cfg_i_87_req_reg <= 1'b0;
      cfg_i_88_req_reg <= 1'b0;
      cfg_i_89_req_reg <= 1'b0;
      cfg_i_90_req_reg <= 1'b0;
      cfg_i_91_req_reg <= 1'b0;
      cfg_i_92_req_reg <= 1'b0;
      cfg_i_93_req_reg <= 1'b0;
      cfg_i_94_req_reg <= 1'b0;
      cfg_i_95_req_reg <= 1'b0;
      cfg_i_96_req_reg <= 1'b0;
      cfg_i_97_req_reg <= 1'b0;
      cfg_i_98_req_reg <= 1'b0;
      s0_k8_slice_i_0_req_reg <= 1'b0;
      s0_k8_slice_i_1_req_reg <= 1'b0;
      s0_k8_slice_i_2_req_reg <= 1'b0;
      s0_k8_slice_i_3_req_reg <= 1'b0;
      s0_k8_slice_i_4_req_reg <= 1'b0;
      s0_k8_slice_i_5_req_reg <= 1'b0;
      s0_k8_slice_i_6_req_reg <= 1'b0;
      s0_k8_slice_i_7_req_reg <= 1'b0;
      s0_k9_slice_i_0_req_reg <= 1'b0;
      s0_k9_slice_i_1_req_reg <= 1'b0;
      s0_k9_slice_i_2_req_reg <= 1'b0;
      s0_k9_slice_i_3_req_reg <= 1'b0;
      s0_k9_slice_i_4_req_reg <= 1'b0;
      s0_k9_slice_i_5_req_reg <= 1'b0;
      s0_k9_slice_i_6_req_reg <= 1'b0;
      s0_k9_slice_i_7_req_reg <= 1'b0;
      s0_cmul0_mas_re_s1_valid <= 1'b0;
      s0_cmul0_mas_re_s2_valid <= 1'b0;
      s0_cmul0_mas_re_s3_valid <= 1'b0;
      s0_cmul0_mas_im_s1_valid <= 1'b0;
      s0_cmul0_mas_im_s2_valid <= 1'b0;
      s0_cmul0_mas_im_s3_valid <= 1'b0;
      s0_cmul1_mas_re_s1_valid <= 1'b0;
      s0_cmul1_mas_re_s2_valid <= 1'b0;
      s0_cmul1_mas_re_s3_valid <= 1'b0;
      s0_cmul1_mas_im_s1_valid <= 1'b0;
      s0_cmul1_mas_im_s2_valid <= 1'b0;
      s0_cmul1_mas_im_s3_valid <= 1'b0;
      s0_cmul2_mas_re_s1_valid <= 1'b0;
      s0_cmul2_mas_re_s2_valid <= 1'b0;
      s0_cmul2_mas_re_s3_valid <= 1'b0;
      s0_cmul2_mas_im_s1_valid <= 1'b0;
      s0_cmul2_mas_im_s2_valid <= 1'b0;
      s0_cmul2_mas_im_s3_valid <= 1'b0;
      s0_cmul3_mas_re_s1_valid <= 1'b0;
      s0_cmul3_mas_re_s2_valid <= 1'b0;
      s0_cmul3_mas_re_s3_valid <= 1'b0;
      s0_cmul3_mas_im_s1_valid <= 1'b0;
      s0_cmul3_mas_im_s2_valid <= 1'b0;
      s0_cmul3_mas_im_s3_valid <= 1'b0;
      s1_k8_slice_i_0_req_reg <= 1'b0;
      s1_k8_slice_i_1_req_reg <= 1'b0;
      s1_k8_slice_i_2_req_reg <= 1'b0;
      s1_k8_slice_i_3_req_reg <= 1'b0;
      s1_k8_slice_i_4_req_reg <= 1'b0;
      s1_k8_slice_i_5_req_reg <= 1'b0;
      s1_k8_slice_i_6_req_reg <= 1'b0;
      s1_k8_slice_i_7_req_reg <= 1'b0;
      s1_k9_slice_i_0_req_reg <= 1'b0;
      s1_k9_slice_i_1_req_reg <= 1'b0;
      s1_k9_slice_i_2_req_reg <= 1'b0;
      s1_k9_slice_i_3_req_reg <= 1'b0;
      s1_k9_slice_i_4_req_reg <= 1'b0;
      s1_k9_slice_i_5_req_reg <= 1'b0;
      s1_k9_slice_i_6_req_reg <= 1'b0;
      s1_k9_slice_i_7_req_reg <= 1'b0;
      s1_cmul0_mas_re_s1_valid <= 1'b0;
      s1_cmul0_mas_re_s2_valid <= 1'b0;
      s1_cmul0_mas_re_s3_valid <= 1'b0;
      s1_cmul0_mas_im_s1_valid <= 1'b0;
      s1_cmul0_mas_im_s2_valid <= 1'b0;
      s1_cmul0_mas_im_s3_valid <= 1'b0;
      s1_cmul1_mas_re_s1_valid <= 1'b0;
      s1_cmul1_mas_re_s2_valid <= 1'b0;
      s1_cmul1_mas_re_s3_valid <= 1'b0;
      s1_cmul1_mas_im_s1_valid <= 1'b0;
      s1_cmul1_mas_im_s2_valid <= 1'b0;
      s1_cmul1_mas_im_s3_valid <= 1'b0;
      s1_cmul2_mas_re_s1_valid <= 1'b0;
      s1_cmul2_mas_re_s2_valid <= 1'b0;
      s1_cmul2_mas_re_s3_valid <= 1'b0;
      s1_cmul2_mas_im_s1_valid <= 1'b0;
      s1_cmul2_mas_im_s2_valid <= 1'b0;
      s1_cmul2_mas_im_s3_valid <= 1'b0;
      s1_cmul3_mas_re_s1_valid <= 1'b0;
      s1_cmul3_mas_re_s2_valid <= 1'b0;
      s1_cmul3_mas_re_s3_valid <= 1'b0;
      s1_cmul3_mas_im_s1_valid <= 1'b0;
      s1_cmul3_mas_im_s2_valid <= 1'b0;
      s1_cmul3_mas_im_s3_valid <= 1'b0;
      k1_defunnel_0_eb_state <= 5'h14;
      k8_funnel_0_eb_valid <= 1'b0;
      k9_funnel_0_eb_valid <= 1'b0;
      s0_k8_slice_0_fork_ack_r_0 <= 1'b0;
      s0_k8_slice_0_fork_ack_r_1 <= 1'b0;
      s0_k8_slice_0_fork_ack_r_2 <= 1'b0;
      s0_k8_slice_1_fork_ack_r_0 <= 1'b0;
      s0_k8_slice_1_fork_ack_r_1 <= 1'b0;
      s0_k8_slice_1_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_0_fork_ack_r_0 <= 1'b0;
      s0_k9_slice_0_fork_ack_r_1 <= 1'b0;
      s0_k9_slice_0_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_0_fork_ack_r_3 <= 1'b0;
      s0_k9_slice_0_fork_ack_r_4 <= 1'b0;
      s0_k9_slice_1_fork_ack_r_0 <= 1'b0;
      s0_k9_slice_1_fork_ack_r_1 <= 1'b0;
      s0_k9_slice_1_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_1_fork_ack_r_3 <= 1'b0;
      s0_k8_slice_2_fork_ack_r_0 <= 1'b0;
      s0_k8_slice_2_fork_ack_r_1 <= 1'b0;
      s0_k8_slice_2_fork_ack_r_2 <= 1'b0;
      s0_k8_slice_3_fork_ack_r_0 <= 1'b0;
      s0_k8_slice_3_fork_ack_r_1 <= 1'b0;
      s0_k8_slice_3_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_2_fork_ack_r_0 <= 1'b0;
      s0_k9_slice_2_fork_ack_r_1 <= 1'b0;
      s0_k9_slice_2_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_2_fork_ack_r_3 <= 1'b0;
      s0_k9_slice_2_fork_ack_r_4 <= 1'b0;
      s0_k9_slice_3_fork_ack_r_0 <= 1'b0;
      s0_k9_slice_3_fork_ack_r_1 <= 1'b0;
      s0_k9_slice_3_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_3_fork_ack_r_3 <= 1'b0;
      s0_k8_slice_4_fork_ack_r_0 <= 1'b0;
      s0_k8_slice_4_fork_ack_r_1 <= 1'b0;
      s0_k8_slice_4_fork_ack_r_2 <= 1'b0;
      s0_k8_slice_5_fork_ack_r_0 <= 1'b0;
      s0_k8_slice_5_fork_ack_r_1 <= 1'b0;
      s0_k8_slice_5_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_4_fork_ack_r_0 <= 1'b0;
      s0_k9_slice_4_fork_ack_r_1 <= 1'b0;
      s0_k9_slice_4_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_4_fork_ack_r_3 <= 1'b0;
      s0_k9_slice_4_fork_ack_r_4 <= 1'b0;
      s0_k9_slice_5_fork_ack_r_0 <= 1'b0;
      s0_k9_slice_5_fork_ack_r_1 <= 1'b0;
      s0_k9_slice_5_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_5_fork_ack_r_3 <= 1'b0;
      s0_k8_slice_6_fork_ack_r_0 <= 1'b0;
      s0_k8_slice_6_fork_ack_r_1 <= 1'b0;
      s0_k8_slice_6_fork_ack_r_2 <= 1'b0;
      s0_k8_slice_7_fork_ack_r_0 <= 1'b0;
      s0_k8_slice_7_fork_ack_r_1 <= 1'b0;
      s0_k8_slice_7_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_6_fork_ack_r_0 <= 1'b0;
      s0_k9_slice_6_fork_ack_r_1 <= 1'b0;
      s0_k9_slice_6_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_6_fork_ack_r_3 <= 1'b0;
      s0_k9_slice_6_fork_ack_r_4 <= 1'b0;
      s0_k9_slice_7_fork_ack_r_0 <= 1'b0;
      s0_k9_slice_7_fork_ack_r_1 <= 1'b0;
      s0_k9_slice_7_fork_ack_r_2 <= 1'b0;
      s0_k9_slice_7_fork_ack_r_3 <= 1'b0;
      s0_cmul0_recip_norm_0_eb_valid <= 1'b0;
      s0_cmul0_recip_mul_0_eb_valid <= 1'b0;
      s0_cmul0_recip_out_0_eb_valid <= 1'b0;
      s0_cmul0_recip_out_0_fork_ack_r_0 <= 1'b0;
      s0_cmul0_recip_out_0_fork_ack_r_1 <= 1'b0;
      s0_cmul0_cat_re_0_eb_state <= 5'h14;
      s0_cmul0_cat_im_0_eb_state <= 5'h14;
      s0_cmul0_mas_re_0_fork_ack_r_0 <= 1'b0;
      s0_cmul0_mas_re_0_fork_ack_r_1 <= 1'b0;
      s0_cmul0_mas_re_0_fork_ack_r_2 <= 1'b0;
      s0_cmul0_mas_im_0_fork_ack_r_0 <= 1'b0;
      s0_cmul0_mas_im_0_fork_ack_r_1 <= 1'b0;
      s0_cmul0_mas_im_0_fork_ack_r_2 <= 1'b0;
      s0_cmul1_recip_norm_0_eb_valid <= 1'b0;
      s0_cmul1_recip_mul_0_eb_valid <= 1'b0;
      s0_cmul1_recip_out_0_eb_valid <= 1'b0;
      s0_cmul1_recip_out_0_fork_ack_r_0 <= 1'b0;
      s0_cmul1_recip_out_0_fork_ack_r_1 <= 1'b0;
      s0_cmul1_cat_re_0_eb_state <= 5'h14;
      s0_cmul1_cat_im_0_eb_state <= 5'h14;
      s0_cmul1_mas_re_0_fork_ack_r_0 <= 1'b0;
      s0_cmul1_mas_re_0_fork_ack_r_1 <= 1'b0;
      s0_cmul1_mas_re_0_fork_ack_r_2 <= 1'b0;
      s0_cmul1_mas_im_0_fork_ack_r_0 <= 1'b0;
      s0_cmul1_mas_im_0_fork_ack_r_1 <= 1'b0;
      s0_cmul1_mas_im_0_fork_ack_r_2 <= 1'b0;
      s0_cmul2_recip_norm_0_eb_valid <= 1'b0;
      s0_cmul2_recip_mul_0_eb_valid <= 1'b0;
      s0_cmul2_recip_out_0_eb_valid <= 1'b0;
      s0_cmul2_recip_out_0_fork_ack_r_0 <= 1'b0;
      s0_cmul2_recip_out_0_fork_ack_r_1 <= 1'b0;
      s0_cmul2_cat_re_0_eb_state <= 5'h14;
      s0_cmul2_cat_im_0_eb_state <= 5'h14;
      s0_cmul2_mas_re_0_fork_ack_r_0 <= 1'b0;
      s0_cmul2_mas_re_0_fork_ack_r_1 <= 1'b0;
      s0_cmul2_mas_re_0_fork_ack_r_2 <= 1'b0;
      s0_cmul2_mas_im_0_fork_ack_r_0 <= 1'b0;
      s0_cmul2_mas_im_0_fork_ack_r_1 <= 1'b0;
      s0_cmul2_mas_im_0_fork_ack_r_2 <= 1'b0;
      s0_cmul3_recip_norm_0_eb_valid <= 1'b0;
      s0_cmul3_recip_mul_0_eb_valid <= 1'b0;
      s0_cmul3_recip_out_0_eb_valid <= 1'b0;
      s0_cmul3_recip_out_0_fork_ack_r_0 <= 1'b0;
      s0_cmul3_recip_out_0_fork_ack_r_1 <= 1'b0;
      s0_cmul3_cat_re_0_eb_state <= 5'h14;
      s0_cmul3_cat_im_0_eb_state <= 5'h14;
      s0_cmul3_mas_re_0_fork_ack_r_0 <= 1'b0;
      s0_cmul3_mas_re_0_fork_ack_r_1 <= 1'b0;
      s0_cmul3_mas_re_0_fork_ack_r_2 <= 1'b0;
      s0_cmul3_mas_im_0_fork_ack_r_0 <= 1'b0;
      s0_cmul3_mas_im_0_fork_ack_r_1 <= 1'b0;
      s0_cmul3_mas_im_0_fork_ack_r_2 <= 1'b0;
      k8_funnel_1_eb_valid <= 1'b0;
      k9_funnel_1_eb_valid <= 1'b0;
      s1_k8_slice_0_fork_ack_r_0 <= 1'b0;
      s1_k8_slice_0_fork_ack_r_1 <= 1'b0;
      s1_k8_slice_0_fork_ack_r_2 <= 1'b0;
      s1_k8_slice_1_fork_ack_r_0 <= 1'b0;
      s1_k8_slice_1_fork_ack_r_1 <= 1'b0;
      s1_k8_slice_1_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_0_fork_ack_r_0 <= 1'b0;
      s1_k9_slice_0_fork_ack_r_1 <= 1'b0;
      s1_k9_slice_0_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_0_fork_ack_r_3 <= 1'b0;
      s1_k9_slice_0_fork_ack_r_4 <= 1'b0;
      s1_k9_slice_1_fork_ack_r_0 <= 1'b0;
      s1_k9_slice_1_fork_ack_r_1 <= 1'b0;
      s1_k9_slice_1_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_1_fork_ack_r_3 <= 1'b0;
      s1_k8_slice_2_fork_ack_r_0 <= 1'b0;
      s1_k8_slice_2_fork_ack_r_1 <= 1'b0;
      s1_k8_slice_2_fork_ack_r_2 <= 1'b0;
      s1_k8_slice_3_fork_ack_r_0 <= 1'b0;
      s1_k8_slice_3_fork_ack_r_1 <= 1'b0;
      s1_k8_slice_3_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_2_fork_ack_r_0 <= 1'b0;
      s1_k9_slice_2_fork_ack_r_1 <= 1'b0;
      s1_k9_slice_2_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_2_fork_ack_r_3 <= 1'b0;
      s1_k9_slice_2_fork_ack_r_4 <= 1'b0;
      s1_k9_slice_3_fork_ack_r_0 <= 1'b0;
      s1_k9_slice_3_fork_ack_r_1 <= 1'b0;
      s1_k9_slice_3_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_3_fork_ack_r_3 <= 1'b0;
      s1_k8_slice_4_fork_ack_r_0 <= 1'b0;
      s1_k8_slice_4_fork_ack_r_1 <= 1'b0;
      s1_k8_slice_4_fork_ack_r_2 <= 1'b0;
      s1_k8_slice_5_fork_ack_r_0 <= 1'b0;
      s1_k8_slice_5_fork_ack_r_1 <= 1'b0;
      s1_k8_slice_5_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_4_fork_ack_r_0 <= 1'b0;
      s1_k9_slice_4_fork_ack_r_1 <= 1'b0;
      s1_k9_slice_4_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_4_fork_ack_r_3 <= 1'b0;
      s1_k9_slice_4_fork_ack_r_4 <= 1'b0;
      s1_k9_slice_5_fork_ack_r_0 <= 1'b0;
      s1_k9_slice_5_fork_ack_r_1 <= 1'b0;
      s1_k9_slice_5_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_5_fork_ack_r_3 <= 1'b0;
      s1_k8_slice_6_fork_ack_r_0 <= 1'b0;
      s1_k8_slice_6_fork_ack_r_1 <= 1'b0;
      s1_k8_slice_6_fork_ack_r_2 <= 1'b0;
      s1_k8_slice_7_fork_ack_r_0 <= 1'b0;
      s1_k8_slice_7_fork_ack_r_1 <= 1'b0;
      s1_k8_slice_7_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_6_fork_ack_r_0 <= 1'b0;
      s1_k9_slice_6_fork_ack_r_1 <= 1'b0;
      s1_k9_slice_6_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_6_fork_ack_r_3 <= 1'b0;
      s1_k9_slice_6_fork_ack_r_4 <= 1'b0;
      s1_k9_slice_7_fork_ack_r_0 <= 1'b0;
      s1_k9_slice_7_fork_ack_r_1 <= 1'b0;
      s1_k9_slice_7_fork_ack_r_2 <= 1'b0;
      s1_k9_slice_7_fork_ack_r_3 <= 1'b0;
      s1_cmul0_recip_norm_0_eb_valid <= 1'b0;
      s1_cmul0_recip_mul_0_eb_valid <= 1'b0;
      s1_cmul0_recip_out_0_eb_valid <= 1'b0;
      s1_cmul0_recip_out_0_fork_ack_r_0 <= 1'b0;
      s1_cmul0_recip_out_0_fork_ack_r_1 <= 1'b0;
      s1_cmul0_cat_re_0_eb_state <= 5'h14;
      s1_cmul0_cat_im_0_eb_state <= 5'h14;
      s1_cmul0_mas_re_0_fork_ack_r_0 <= 1'b0;
      s1_cmul0_mas_re_0_fork_ack_r_1 <= 1'b0;
      s1_cmul0_mas_re_0_fork_ack_r_2 <= 1'b0;
      s1_cmul0_mas_im_0_fork_ack_r_0 <= 1'b0;
      s1_cmul0_mas_im_0_fork_ack_r_1 <= 1'b0;
      s1_cmul0_mas_im_0_fork_ack_r_2 <= 1'b0;
      s1_cmul1_recip_norm_0_eb_valid <= 1'b0;
      s1_cmul1_recip_mul_0_eb_valid <= 1'b0;
      s1_cmul1_recip_out_0_eb_valid <= 1'b0;
      s1_cmul1_recip_out_0_fork_ack_r_0 <= 1'b0;
      s1_cmul1_recip_out_0_fork_ack_r_1 <= 1'b0;
      s1_cmul1_cat_re_0_eb_state <= 5'h14;
      s1_cmul1_cat_im_0_eb_state <= 5'h14;
      s1_cmul1_mas_re_0_fork_ack_r_0 <= 1'b0;
      s1_cmul1_mas_re_0_fork_ack_r_1 <= 1'b0;
      s1_cmul1_mas_re_0_fork_ack_r_2 <= 1'b0;
      s1_cmul1_mas_im_0_fork_ack_r_0 <= 1'b0;
      s1_cmul1_mas_im_0_fork_ack_r_1 <= 1'b0;
      s1_cmul1_mas_im_0_fork_ack_r_2 <= 1'b0;
      s1_cmul2_recip_norm_0_eb_valid <= 1'b0;
      s1_cmul2_recip_mul_0_eb_valid <= 1'b0;
      s1_cmul2_recip_out_0_eb_valid <= 1'b0;
      s1_cmul2_recip_out_0_fork_ack_r_0 <= 1'b0;
      s1_cmul2_recip_out_0_fork_ack_r_1 <= 1'b0;
      s1_cmul2_cat_re_0_eb_state <= 5'h14;
      s1_cmul2_cat_im_0_eb_state <= 5'h14;
      s1_cmul2_mas_re_0_fork_ack_r_0 <= 1'b0;
      s1_cmul2_mas_re_0_fork_ack_r_1 <= 1'b0;
      s1_cmul2_mas_re_0_fork_ack_r_2 <= 1'b0;
      s1_cmul2_mas_im_0_fork_ack_r_0 <= 1'b0;
      s1_cmul2_mas_im_0_fork_ack_r_1 <= 1'b0;
      s1_cmul2_mas_im_0_fork_ack_r_2 <= 1'b0;
      s1_cmul3_recip_norm_0_eb_valid <= 1'b0;
      s1_cmul3_recip_mul_0_eb_valid <= 1'b0;
      s1_cmul3_recip_out_0_eb_valid <= 1'b0;
      s1_cmul3_recip_out_0_fork_ack_r_0 <= 1'b0;
      s1_cmul3_recip_out_0_fork_ack_r_1 <= 1'b0;
      s1_cmul3_cat_re_0_eb_state <= 5'h14;
      s1_cmul3_cat_im_0_eb_state <= 5'h14;
      s1_cmul3_mas_re_0_fork_ack_r_0 <= 1'b0;
      s1_cmul3_mas_re_0_fork_ack_r_1 <= 1'b0;
      s1_cmul3_mas_re_0_fork_ack_r_2 <= 1'b0;
      s1_cmul3_mas_im_0_fork_ack_r_0 <= 1'b0;
      s1_cmul3_mas_im_0_fork_ack_r_1 <= 1'b0;
      s1_cmul3_mas_im_0_fork_ack_r_2 <= 1'b0;
      s0_r4_a0_re_0_eb_state <= 5'h14;
      s0_r4_a0_re_0_fork_ack_r_0 <= 1'b0;
      s0_r4_a0_re_0_fork_ack_r_1 <= 1'b0;
      s0_r4_a0_im_0_eb_state <= 5'h14;
      s0_r4_a0_im_0_fork_ack_r_0 <= 1'b0;
      s0_r4_a0_im_0_fork_ack_r_1 <= 1'b0;
      s0_r4_a1_re_0_eb_state <= 5'h14;
      s0_r4_a1_re_0_fork_ack_r_0 <= 1'b0;
      s0_r4_a1_re_0_fork_ack_r_1 <= 1'b0;
      s0_r4_a1_im_0_eb_state <= 5'h14;
      s0_r4_a1_im_0_fork_ack_r_0 <= 1'b0;
      s0_r4_a1_im_0_fork_ack_r_1 <= 1'b0;
      s0_r4_a2_re_0_eb_state <= 5'h14;
      s0_r4_a2_re_0_fork_ack_r_0 <= 1'b0;
      s0_r4_a2_re_0_fork_ack_r_1 <= 1'b0;
      s0_r4_a2_im_0_eb_state <= 5'h14;
      s0_r4_a2_im_0_fork_ack_r_0 <= 1'b0;
      s0_r4_a2_im_0_fork_ack_r_1 <= 1'b0;
      s0_r4_a3_re_0_eb_state <= 5'h14;
      s0_r4_a3_re_0_fork_ack_r_0 <= 1'b0;
      s0_r4_a3_re_0_fork_ack_r_1 <= 1'b0;
      s0_r4_a3_im_0_eb_state <= 5'h14;
      s0_r4_a3_im_0_fork_ack_r_0 <= 1'b0;
      s0_r4_a3_im_0_fork_ack_r_1 <= 1'b0;
      s0_r4_byp0_re_0_eb_valid <= 1'b0;
      s0_r4_byp0_im_0_eb_valid <= 1'b0;
      s0_r4_byp1_re_0_eb_valid <= 1'b0;
      s0_r4_byp1_im_0_eb_valid <= 1'b0;
      s0_r4_byp2_re_0_eb_valid <= 1'b0;
      s0_r4_byp2_im_0_eb_valid <= 1'b0;
      s0_r4_byp3_re_0_eb_valid <= 1'b0;
      s0_r4_byp3_im_0_eb_valid <= 1'b0;
      s1_r4_a0_re_0_eb_state <= 5'h14;
      s1_r4_a0_re_0_fork_ack_r_0 <= 1'b0;
      s1_r4_a0_re_0_fork_ack_r_1 <= 1'b0;
      s1_r4_a0_im_0_eb_state <= 5'h14;
      s1_r4_a0_im_0_fork_ack_r_0 <= 1'b0;
      s1_r4_a0_im_0_fork_ack_r_1 <= 1'b0;
      s1_r4_a1_re_0_eb_state <= 5'h14;
      s1_r4_a1_re_0_fork_ack_r_0 <= 1'b0;
      s1_r4_a1_re_0_fork_ack_r_1 <= 1'b0;
      s1_r4_a1_im_0_eb_state <= 5'h14;
      s1_r4_a1_im_0_fork_ack_r_0 <= 1'b0;
      s1_r4_a1_im_0_fork_ack_r_1 <= 1'b0;
      s1_r4_a2_re_0_eb_state <= 5'h14;
      s1_r4_a2_re_0_fork_ack_r_0 <= 1'b0;
      s1_r4_a2_re_0_fork_ack_r_1 <= 1'b0;
      s1_r4_a2_im_0_eb_state <= 5'h14;
      s1_r4_a2_im_0_fork_ack_r_0 <= 1'b0;
      s1_r4_a2_im_0_fork_ack_r_1 <= 1'b0;
      s1_r4_a3_re_0_eb_state <= 5'h14;
      s1_r4_a3_re_0_fork_ack_r_0 <= 1'b0;
      s1_r4_a3_re_0_fork_ack_r_1 <= 1'b0;
      s1_r4_a3_im_0_eb_state <= 5'h14;
      s1_r4_a3_im_0_fork_ack_r_0 <= 1'b0;
      s1_r4_a3_im_0_fork_ack_r_1 <= 1'b0;
      s1_r4_byp0_re_0_eb_valid <= 1'b0;
      s1_r4_byp0_im_0_eb_valid <= 1'b0;
      s1_r4_byp1_re_0_eb_valid <= 1'b0;
      s1_r4_byp1_im_0_eb_valid <= 1'b0;
      s1_r4_byp2_re_0_eb_valid <= 1'b0;
      s1_r4_byp2_im_0_eb_valid <= 1'b0;
      s1_r4_byp3_re_0_eb_valid <= 1'b0;
      s1_r4_byp3_im_0_eb_valid <= 1'b0;
      s0_bs0_re_0_eb_state <= 5'h14;
      s0_bs0_im_0_eb_state <= 5'h14;
      s0_rsat0_re_0_eb_valid <= 1'b0;
      s0_rsat0_im_0_eb_valid <= 1'b0;
      s0_bs1_re_0_eb_state <= 5'h14;
      s0_bs1_im_0_eb_state <= 5'h14;
      s0_rsat1_re_0_eb_valid <= 1'b0;
      s0_rsat1_im_0_eb_valid <= 1'b0;
      s0_bs2_re_0_eb_state <= 5'h14;
      s0_bs2_im_0_eb_state <= 5'h14;
      s0_rsat2_re_0_eb_valid <= 1'b0;
      s0_rsat2_im_0_eb_valid <= 1'b0;
      s0_bs3_re_0_eb_state <= 5'h14;
      s0_bs3_im_0_eb_state <= 5'h14;
      s0_rsat3_re_0_eb_valid <= 1'b0;
      s0_rsat3_im_0_eb_valid <= 1'b0;
      s1_bs0_re_0_eb_state <= 5'h14;
      s1_bs0_im_0_eb_state <= 5'h14;
      s1_rsat0_re_0_eb_valid <= 1'b0;
      s1_rsat0_im_0_eb_valid <= 1'b0;
      s1_bs1_re_0_eb_state <= 5'h14;
      s1_bs1_im_0_eb_state <= 5'h14;
      s1_rsat1_re_0_eb_valid <= 1'b0;
      s1_rsat1_im_0_eb_valid <= 1'b0;
      s1_bs2_re_0_eb_state <= 5'h14;
      s1_bs2_im_0_eb_state <= 5'h14;
      s1_rsat2_re_0_eb_valid <= 1'b0;
      s1_rsat2_im_0_eb_valid <= 1'b0;
      s1_bs3_re_0_eb_state <= 5'h14;
      s1_bs3_im_0_eb_state <= 5'h14;
      s1_rsat3_re_0_eb_valid <= 1'b0;
      s1_rsat3_im_0_eb_valid <= 1'b0;
    end else begin
      cfg_i_0_req_reg <= (cfg_i_0_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_1_req_reg <= (cfg_i_1_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_2_req_reg <= (cfg_i_2_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_3_req_reg <= (cfg_i_3_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_4_req_reg <= (cfg_i_4_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_5_req_reg <= (cfg_i_5_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_6_req_reg <= (cfg_i_6_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_7_req_reg <= (cfg_i_7_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_8_req_reg <= (cfg_i_8_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_9_req_reg <= (cfg_i_9_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_10_req_reg <= (cfg_i_10_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_11_req_reg <= (cfg_i_11_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_12_req_reg <= (cfg_i_12_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_13_req_reg <= (cfg_i_13_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_14_req_reg <= (cfg_i_14_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_15_req_reg <= (cfg_i_15_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_16_req_reg <= (cfg_i_16_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_17_req_reg <= (cfg_i_17_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_18_req_reg <= (cfg_i_18_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_19_req_reg <= (cfg_i_19_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_20_req_reg <= (cfg_i_20_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_21_req_reg <= (cfg_i_21_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_22_req_reg <= (cfg_i_22_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_23_req_reg <= (cfg_i_23_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_24_req_reg <= (cfg_i_24_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_25_req_reg <= (cfg_i_25_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_26_req_reg <= (cfg_i_26_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_27_req_reg <= (cfg_i_27_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_28_req_reg <= (cfg_i_28_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_29_req_reg <= (cfg_i_29_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_30_req_reg <= (cfg_i_30_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_31_req_reg <= (cfg_i_31_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_32_req_reg <= (cfg_i_32_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_33_req_reg <= (cfg_i_33_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_34_req_reg <= (cfg_i_34_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_35_req_reg <= (cfg_i_35_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_36_req_reg <= (cfg_i_36_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_37_req_reg <= (cfg_i_37_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_38_req_reg <= (cfg_i_38_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_39_req_reg <= (cfg_i_39_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_40_req_reg <= (cfg_i_40_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_41_req_reg <= (cfg_i_41_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_42_req_reg <= (cfg_i_42_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_43_req_reg <= (cfg_i_43_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_44_req_reg <= (cfg_i_44_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_45_req_reg <= (cfg_i_45_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_46_req_reg <= (cfg_i_46_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_47_req_reg <= (cfg_i_47_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_48_req_reg <= (cfg_i_48_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_49_req_reg <= (cfg_i_49_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_50_req_reg <= (cfg_i_50_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_51_req_reg <= (cfg_i_51_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_52_req_reg <= (cfg_i_52_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_53_req_reg <= (cfg_i_53_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_54_req_reg <= (cfg_i_54_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_55_req_reg <= (cfg_i_55_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_56_req_reg <= (cfg_i_56_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_57_req_reg <= (cfg_i_57_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_58_req_reg <= (cfg_i_58_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_59_req_reg <= (cfg_i_59_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_60_req_reg <= (cfg_i_60_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_61_req_reg <= (cfg_i_61_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_62_req_reg <= (cfg_i_62_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_63_req_reg <= (cfg_i_63_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_64_req_reg <= (cfg_i_64_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_65_req_reg <= (cfg_i_65_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_66_req_reg <= (cfg_i_66_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_67_req_reg <= (cfg_i_67_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_68_req_reg <= (cfg_i_68_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_69_req_reg <= (cfg_i_69_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_70_req_reg <= (cfg_i_70_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_71_req_reg <= (cfg_i_71_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_72_req_reg <= (cfg_i_72_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_73_req_reg <= (cfg_i_73_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_74_req_reg <= (cfg_i_74_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_75_req_reg <= (cfg_i_75_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_76_req_reg <= (cfg_i_76_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_77_req_reg <= (cfg_i_77_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_78_req_reg <= (cfg_i_78_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_79_req_reg <= (cfg_i_79_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_80_req_reg <= (cfg_i_80_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_81_req_reg <= (cfg_i_81_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_82_req_reg <= (cfg_i_82_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_83_req_reg <= (cfg_i_83_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_84_req_reg <= (cfg_i_84_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_85_req_reg <= (cfg_i_85_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_86_req_reg <= (cfg_i_86_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_87_req_reg <= (cfg_i_87_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_88_req_reg <= (cfg_i_88_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_89_req_reg <= (cfg_i_89_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_90_req_reg <= (cfg_i_90_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_91_req_reg <= (cfg_i_91_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_92_req_reg <= (cfg_i_92_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_93_req_reg <= (cfg_i_93_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_94_req_reg <= (cfg_i_94_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_95_req_reg <= (cfg_i_95_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_96_req_reg <= (cfg_i_96_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_97_req_reg <= (cfg_i_97_ack_g && (! t_k14_0_to_cfg_ack));
      cfg_i_98_req_reg <= (cfg_i_98_ack_g && (! t_k14_0_to_cfg_ack));
      s0_k8_slice_i_0_req_reg <= (s0_k8_slice_i_0_ack_g && (! k8_funnel_0_to_s0_k8_slice_ack));
      s0_k8_slice_i_1_req_reg <= (s0_k8_slice_i_1_ack_g && (! k8_funnel_0_to_s0_k8_slice_ack));
      s0_k8_slice_i_2_req_reg <= (s0_k8_slice_i_2_ack_g && (! k8_funnel_0_to_s0_k8_slice_ack));
      s0_k8_slice_i_3_req_reg <= (s0_k8_slice_i_3_ack_g && (! k8_funnel_0_to_s0_k8_slice_ack));
      s0_k8_slice_i_4_req_reg <= (s0_k8_slice_i_4_ack_g && (! k8_funnel_0_to_s0_k8_slice_ack));
      s0_k8_slice_i_5_req_reg <= (s0_k8_slice_i_5_ack_g && (! k8_funnel_0_to_s0_k8_slice_ack));
      s0_k8_slice_i_6_req_reg <= (s0_k8_slice_i_6_ack_g && (! k8_funnel_0_to_s0_k8_slice_ack));
      s0_k8_slice_i_7_req_reg <= (s0_k8_slice_i_7_ack_g && (! k8_funnel_0_to_s0_k8_slice_ack));
      s0_k9_slice_i_0_req_reg <= (s0_k9_slice_i_0_ack_g && (! k9_funnel_0_to_s0_k9_slice_ack));
      s0_k9_slice_i_1_req_reg <= (s0_k9_slice_i_1_ack_g && (! k9_funnel_0_to_s0_k9_slice_ack));
      s0_k9_slice_i_2_req_reg <= (s0_k9_slice_i_2_ack_g && (! k9_funnel_0_to_s0_k9_slice_ack));
      s0_k9_slice_i_3_req_reg <= (s0_k9_slice_i_3_ack_g && (! k9_funnel_0_to_s0_k9_slice_ack));
      s0_k9_slice_i_4_req_reg <= (s0_k9_slice_i_4_ack_g && (! k9_funnel_0_to_s0_k9_slice_ack));
      s0_k9_slice_i_5_req_reg <= (s0_k9_slice_i_5_ack_g && (! k9_funnel_0_to_s0_k9_slice_ack));
      s0_k9_slice_i_6_req_reg <= (s0_k9_slice_i_6_ack_g && (! k9_funnel_0_to_s0_k9_slice_ack));
      s0_k9_slice_i_7_req_reg <= (s0_k9_slice_i_7_ack_g && (! k9_funnel_0_to_s0_k9_slice_ack));
      s0_cmul0_mas_re_s1_valid <= ((! s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_ack) || s0_cmul0_cat_re_0_to_s0_cmul0_mas_re_req);
      s0_cmul0_mas_re_s2_valid <= ((! s0_cmul0_mas_re_s1_ack) || s0_cmul0_mas_re_s1_valid);
      s0_cmul0_mas_re_s3_valid <= ((! s0_cmul0_mas_re_s2_ack) || s0_cmul0_mas_re_s2_valid);
      s0_cmul0_mas_im_s1_valid <= ((! s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_ack) || s0_cmul0_cat_im_0_to_s0_cmul0_mas_im_req);
      s0_cmul0_mas_im_s2_valid <= ((! s0_cmul0_mas_im_s1_ack) || s0_cmul0_mas_im_s1_valid);
      s0_cmul0_mas_im_s3_valid <= ((! s0_cmul0_mas_im_s2_ack) || s0_cmul0_mas_im_s2_valid);
      s0_cmul1_mas_re_s1_valid <= ((! s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_ack) || s0_cmul1_cat_re_0_to_s0_cmul1_mas_re_req);
      s0_cmul1_mas_re_s2_valid <= ((! s0_cmul1_mas_re_s1_ack) || s0_cmul1_mas_re_s1_valid);
      s0_cmul1_mas_re_s3_valid <= ((! s0_cmul1_mas_re_s2_ack) || s0_cmul1_mas_re_s2_valid);
      s0_cmul1_mas_im_s1_valid <= ((! s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_ack) || s0_cmul1_cat_im_0_to_s0_cmul1_mas_im_req);
      s0_cmul1_mas_im_s2_valid <= ((! s0_cmul1_mas_im_s1_ack) || s0_cmul1_mas_im_s1_valid);
      s0_cmul1_mas_im_s3_valid <= ((! s0_cmul1_mas_im_s2_ack) || s0_cmul1_mas_im_s2_valid);
      s0_cmul2_mas_re_s1_valid <= ((! s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_ack) || s0_cmul2_cat_re_0_to_s0_cmul2_mas_re_req);
      s0_cmul2_mas_re_s2_valid <= ((! s0_cmul2_mas_re_s1_ack) || s0_cmul2_mas_re_s1_valid);
      s0_cmul2_mas_re_s3_valid <= ((! s0_cmul2_mas_re_s2_ack) || s0_cmul2_mas_re_s2_valid);
      s0_cmul2_mas_im_s1_valid <= ((! s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_ack) || s0_cmul2_cat_im_0_to_s0_cmul2_mas_im_req);
      s0_cmul2_mas_im_s2_valid <= ((! s0_cmul2_mas_im_s1_ack) || s0_cmul2_mas_im_s1_valid);
      s0_cmul2_mas_im_s3_valid <= ((! s0_cmul2_mas_im_s2_ack) || s0_cmul2_mas_im_s2_valid);
      s0_cmul3_mas_re_s1_valid <= ((! s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_ack) || s0_cmul3_cat_re_0_to_s0_cmul3_mas_re_req);
      s0_cmul3_mas_re_s2_valid <= ((! s0_cmul3_mas_re_s1_ack) || s0_cmul3_mas_re_s1_valid);
      s0_cmul3_mas_re_s3_valid <= ((! s0_cmul3_mas_re_s2_ack) || s0_cmul3_mas_re_s2_valid);
      s0_cmul3_mas_im_s1_valid <= ((! s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_ack) || s0_cmul3_cat_im_0_to_s0_cmul3_mas_im_req);
      s0_cmul3_mas_im_s2_valid <= ((! s0_cmul3_mas_im_s1_ack) || s0_cmul3_mas_im_s1_valid);
      s0_cmul3_mas_im_s3_valid <= ((! s0_cmul3_mas_im_s2_ack) || s0_cmul3_mas_im_s2_valid);
      s1_k8_slice_i_0_req_reg <= (s1_k8_slice_i_0_ack_g && (! k8_funnel_1_to_s1_k8_slice_ack));
      s1_k8_slice_i_1_req_reg <= (s1_k8_slice_i_1_ack_g && (! k8_funnel_1_to_s1_k8_slice_ack));
      s1_k8_slice_i_2_req_reg <= (s1_k8_slice_i_2_ack_g && (! k8_funnel_1_to_s1_k8_slice_ack));
      s1_k8_slice_i_3_req_reg <= (s1_k8_slice_i_3_ack_g && (! k8_funnel_1_to_s1_k8_slice_ack));
      s1_k8_slice_i_4_req_reg <= (s1_k8_slice_i_4_ack_g && (! k8_funnel_1_to_s1_k8_slice_ack));
      s1_k8_slice_i_5_req_reg <= (s1_k8_slice_i_5_ack_g && (! k8_funnel_1_to_s1_k8_slice_ack));
      s1_k8_slice_i_6_req_reg <= (s1_k8_slice_i_6_ack_g && (! k8_funnel_1_to_s1_k8_slice_ack));
      s1_k8_slice_i_7_req_reg <= (s1_k8_slice_i_7_ack_g && (! k8_funnel_1_to_s1_k8_slice_ack));
      s1_k9_slice_i_0_req_reg <= (s1_k9_slice_i_0_ack_g && (! k9_funnel_1_to_s1_k9_slice_ack));
      s1_k9_slice_i_1_req_reg <= (s1_k9_slice_i_1_ack_g && (! k9_funnel_1_to_s1_k9_slice_ack));
      s1_k9_slice_i_2_req_reg <= (s1_k9_slice_i_2_ack_g && (! k9_funnel_1_to_s1_k9_slice_ack));
      s1_k9_slice_i_3_req_reg <= (s1_k9_slice_i_3_ack_g && (! k9_funnel_1_to_s1_k9_slice_ack));
      s1_k9_slice_i_4_req_reg <= (s1_k9_slice_i_4_ack_g && (! k9_funnel_1_to_s1_k9_slice_ack));
      s1_k9_slice_i_5_req_reg <= (s1_k9_slice_i_5_ack_g && (! k9_funnel_1_to_s1_k9_slice_ack));
      s1_k9_slice_i_6_req_reg <= (s1_k9_slice_i_6_ack_g && (! k9_funnel_1_to_s1_k9_slice_ack));
      s1_k9_slice_i_7_req_reg <= (s1_k9_slice_i_7_ack_g && (! k9_funnel_1_to_s1_k9_slice_ack));
      s1_cmul0_mas_re_s1_valid <= ((! s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_ack) || s1_cmul0_cat_re_0_to_s1_cmul0_mas_re_req);
      s1_cmul0_mas_re_s2_valid <= ((! s1_cmul0_mas_re_s1_ack) || s1_cmul0_mas_re_s1_valid);
      s1_cmul0_mas_re_s3_valid <= ((! s1_cmul0_mas_re_s2_ack) || s1_cmul0_mas_re_s2_valid);
      s1_cmul0_mas_im_s1_valid <= ((! s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_ack) || s1_cmul0_cat_im_0_to_s1_cmul0_mas_im_req);
      s1_cmul0_mas_im_s2_valid <= ((! s1_cmul0_mas_im_s1_ack) || s1_cmul0_mas_im_s1_valid);
      s1_cmul0_mas_im_s3_valid <= ((! s1_cmul0_mas_im_s2_ack) || s1_cmul0_mas_im_s2_valid);
      s1_cmul1_mas_re_s1_valid <= ((! s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_ack) || s1_cmul1_cat_re_0_to_s1_cmul1_mas_re_req);
      s1_cmul1_mas_re_s2_valid <= ((! s1_cmul1_mas_re_s1_ack) || s1_cmul1_mas_re_s1_valid);
      s1_cmul1_mas_re_s3_valid <= ((! s1_cmul1_mas_re_s2_ack) || s1_cmul1_mas_re_s2_valid);
      s1_cmul1_mas_im_s1_valid <= ((! s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_ack) || s1_cmul1_cat_im_0_to_s1_cmul1_mas_im_req);
      s1_cmul1_mas_im_s2_valid <= ((! s1_cmul1_mas_im_s1_ack) || s1_cmul1_mas_im_s1_valid);
      s1_cmul1_mas_im_s3_valid <= ((! s1_cmul1_mas_im_s2_ack) || s1_cmul1_mas_im_s2_valid);
      s1_cmul2_mas_re_s1_valid <= ((! s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_ack) || s1_cmul2_cat_re_0_to_s1_cmul2_mas_re_req);
      s1_cmul2_mas_re_s2_valid <= ((! s1_cmul2_mas_re_s1_ack) || s1_cmul2_mas_re_s1_valid);
      s1_cmul2_mas_re_s3_valid <= ((! s1_cmul2_mas_re_s2_ack) || s1_cmul2_mas_re_s2_valid);
      s1_cmul2_mas_im_s1_valid <= ((! s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_ack) || s1_cmul2_cat_im_0_to_s1_cmul2_mas_im_req);
      s1_cmul2_mas_im_s2_valid <= ((! s1_cmul2_mas_im_s1_ack) || s1_cmul2_mas_im_s1_valid);
      s1_cmul2_mas_im_s3_valid <= ((! s1_cmul2_mas_im_s2_ack) || s1_cmul2_mas_im_s2_valid);
      s1_cmul3_mas_re_s1_valid <= ((! s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_ack) || s1_cmul3_cat_re_0_to_s1_cmul3_mas_re_req);
      s1_cmul3_mas_re_s2_valid <= ((! s1_cmul3_mas_re_s1_ack) || s1_cmul3_mas_re_s1_valid);
      s1_cmul3_mas_re_s3_valid <= ((! s1_cmul3_mas_re_s2_ack) || s1_cmul3_mas_re_s2_valid);
      s1_cmul3_mas_im_s1_valid <= ((! s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_ack) || s1_cmul3_cat_im_0_to_s1_cmul3_mas_im_req);
      s1_cmul3_mas_im_s2_valid <= ((! s1_cmul3_mas_im_s1_ack) || s1_cmul3_mas_im_s1_valid);
      s1_cmul3_mas_im_s3_valid <= ((! s1_cmul3_mas_im_s2_ack) || s1_cmul3_mas_im_s2_valid);
      k1_defunnel_0_eb_state <= k1_defunnel_0_eb_state_nxt;
      k8_funnel_0_eb_valid <= ((! k8_funnel_0_ack) || k8_funnel_0_req);
      k9_funnel_0_eb_valid <= ((! k9_funnel_0_ack) || k9_funnel_0_req);
      s0_k8_slice_0_fork_ack_r_0 <= (s0_k8_slice_0_fork_ack_s_0 && (! s0_k8_slice_0_m_ack));
      s0_k8_slice_0_fork_ack_r_1 <= (s0_k8_slice_0_fork_ack_s_1 && (! s0_k8_slice_0_m_ack));
      s0_k8_slice_0_fork_ack_r_2 <= (s0_k8_slice_0_fork_ack_s_2 && (! s0_k8_slice_0_m_ack));
      s0_k8_slice_1_fork_ack_r_0 <= (s0_k8_slice_1_fork_ack_s_0 && (! s0_k8_slice_1_m_ack));
      s0_k8_slice_1_fork_ack_r_1 <= (s0_k8_slice_1_fork_ack_s_1 && (! s0_k8_slice_1_m_ack));
      s0_k8_slice_1_fork_ack_r_2 <= (s0_k8_slice_1_fork_ack_s_2 && (! s0_k8_slice_1_m_ack));
      s0_k9_slice_0_fork_ack_r_0 <= (s0_k9_slice_0_fork_ack_s_0 && (! s0_k9_slice_0_m_ack));
      s0_k9_slice_0_fork_ack_r_1 <= (s0_k9_slice_0_fork_ack_s_1 && (! s0_k9_slice_0_m_ack));
      s0_k9_slice_0_fork_ack_r_2 <= (s0_k9_slice_0_fork_ack_s_2 && (! s0_k9_slice_0_m_ack));
      s0_k9_slice_0_fork_ack_r_3 <= (s0_k9_slice_0_fork_ack_s_3 && (! s0_k9_slice_0_m_ack));
      s0_k9_slice_0_fork_ack_r_4 <= (s0_k9_slice_0_fork_ack_s_4 && (! s0_k9_slice_0_m_ack));
      s0_k9_slice_1_fork_ack_r_0 <= (s0_k9_slice_1_fork_ack_s_0 && (! s0_k9_slice_1_m_ack));
      s0_k9_slice_1_fork_ack_r_1 <= (s0_k9_slice_1_fork_ack_s_1 && (! s0_k9_slice_1_m_ack));
      s0_k9_slice_1_fork_ack_r_2 <= (s0_k9_slice_1_fork_ack_s_2 && (! s0_k9_slice_1_m_ack));
      s0_k9_slice_1_fork_ack_r_3 <= (s0_k9_slice_1_fork_ack_s_3 && (! s0_k9_slice_1_m_ack));
      s0_k8_slice_2_fork_ack_r_0 <= (s0_k8_slice_2_fork_ack_s_0 && (! s0_k8_slice_2_m_ack));
      s0_k8_slice_2_fork_ack_r_1 <= (s0_k8_slice_2_fork_ack_s_1 && (! s0_k8_slice_2_m_ack));
      s0_k8_slice_2_fork_ack_r_2 <= (s0_k8_slice_2_fork_ack_s_2 && (! s0_k8_slice_2_m_ack));
      s0_k8_slice_3_fork_ack_r_0 <= (s0_k8_slice_3_fork_ack_s_0 && (! s0_k8_slice_3_m_ack));
      s0_k8_slice_3_fork_ack_r_1 <= (s0_k8_slice_3_fork_ack_s_1 && (! s0_k8_slice_3_m_ack));
      s0_k8_slice_3_fork_ack_r_2 <= (s0_k8_slice_3_fork_ack_s_2 && (! s0_k8_slice_3_m_ack));
      s0_k9_slice_2_fork_ack_r_0 <= (s0_k9_slice_2_fork_ack_s_0 && (! s0_k9_slice_2_m_ack));
      s0_k9_slice_2_fork_ack_r_1 <= (s0_k9_slice_2_fork_ack_s_1 && (! s0_k9_slice_2_m_ack));
      s0_k9_slice_2_fork_ack_r_2 <= (s0_k9_slice_2_fork_ack_s_2 && (! s0_k9_slice_2_m_ack));
      s0_k9_slice_2_fork_ack_r_3 <= (s0_k9_slice_2_fork_ack_s_3 && (! s0_k9_slice_2_m_ack));
      s0_k9_slice_2_fork_ack_r_4 <= (s0_k9_slice_2_fork_ack_s_4 && (! s0_k9_slice_2_m_ack));
      s0_k9_slice_3_fork_ack_r_0 <= (s0_k9_slice_3_fork_ack_s_0 && (! s0_k9_slice_3_m_ack));
      s0_k9_slice_3_fork_ack_r_1 <= (s0_k9_slice_3_fork_ack_s_1 && (! s0_k9_slice_3_m_ack));
      s0_k9_slice_3_fork_ack_r_2 <= (s0_k9_slice_3_fork_ack_s_2 && (! s0_k9_slice_3_m_ack));
      s0_k9_slice_3_fork_ack_r_3 <= (s0_k9_slice_3_fork_ack_s_3 && (! s0_k9_slice_3_m_ack));
      s0_k8_slice_4_fork_ack_r_0 <= (s0_k8_slice_4_fork_ack_s_0 && (! s0_k8_slice_4_m_ack));
      s0_k8_slice_4_fork_ack_r_1 <= (s0_k8_slice_4_fork_ack_s_1 && (! s0_k8_slice_4_m_ack));
      s0_k8_slice_4_fork_ack_r_2 <= (s0_k8_slice_4_fork_ack_s_2 && (! s0_k8_slice_4_m_ack));
      s0_k8_slice_5_fork_ack_r_0 <= (s0_k8_slice_5_fork_ack_s_0 && (! s0_k8_slice_5_m_ack));
      s0_k8_slice_5_fork_ack_r_1 <= (s0_k8_slice_5_fork_ack_s_1 && (! s0_k8_slice_5_m_ack));
      s0_k8_slice_5_fork_ack_r_2 <= (s0_k8_slice_5_fork_ack_s_2 && (! s0_k8_slice_5_m_ack));
      s0_k9_slice_4_fork_ack_r_0 <= (s0_k9_slice_4_fork_ack_s_0 && (! s0_k9_slice_4_m_ack));
      s0_k9_slice_4_fork_ack_r_1 <= (s0_k9_slice_4_fork_ack_s_1 && (! s0_k9_slice_4_m_ack));
      s0_k9_slice_4_fork_ack_r_2 <= (s0_k9_slice_4_fork_ack_s_2 && (! s0_k9_slice_4_m_ack));
      s0_k9_slice_4_fork_ack_r_3 <= (s0_k9_slice_4_fork_ack_s_3 && (! s0_k9_slice_4_m_ack));
      s0_k9_slice_4_fork_ack_r_4 <= (s0_k9_slice_4_fork_ack_s_4 && (! s0_k9_slice_4_m_ack));
      s0_k9_slice_5_fork_ack_r_0 <= (s0_k9_slice_5_fork_ack_s_0 && (! s0_k9_slice_5_m_ack));
      s0_k9_slice_5_fork_ack_r_1 <= (s0_k9_slice_5_fork_ack_s_1 && (! s0_k9_slice_5_m_ack));
      s0_k9_slice_5_fork_ack_r_2 <= (s0_k9_slice_5_fork_ack_s_2 && (! s0_k9_slice_5_m_ack));
      s0_k9_slice_5_fork_ack_r_3 <= (s0_k9_slice_5_fork_ack_s_3 && (! s0_k9_slice_5_m_ack));
      s0_k8_slice_6_fork_ack_r_0 <= (s0_k8_slice_6_fork_ack_s_0 && (! s0_k8_slice_6_m_ack));
      s0_k8_slice_6_fork_ack_r_1 <= (s0_k8_slice_6_fork_ack_s_1 && (! s0_k8_slice_6_m_ack));
      s0_k8_slice_6_fork_ack_r_2 <= (s0_k8_slice_6_fork_ack_s_2 && (! s0_k8_slice_6_m_ack));
      s0_k8_slice_7_fork_ack_r_0 <= (s0_k8_slice_7_fork_ack_s_0 && (! s0_k8_slice_7_m_ack));
      s0_k8_slice_7_fork_ack_r_1 <= (s0_k8_slice_7_fork_ack_s_1 && (! s0_k8_slice_7_m_ack));
      s0_k8_slice_7_fork_ack_r_2 <= (s0_k8_slice_7_fork_ack_s_2 && (! s0_k8_slice_7_m_ack));
      s0_k9_slice_6_fork_ack_r_0 <= (s0_k9_slice_6_fork_ack_s_0 && (! s0_k9_slice_6_m_ack));
      s0_k9_slice_6_fork_ack_r_1 <= (s0_k9_slice_6_fork_ack_s_1 && (! s0_k9_slice_6_m_ack));
      s0_k9_slice_6_fork_ack_r_2 <= (s0_k9_slice_6_fork_ack_s_2 && (! s0_k9_slice_6_m_ack));
      s0_k9_slice_6_fork_ack_r_3 <= (s0_k9_slice_6_fork_ack_s_3 && (! s0_k9_slice_6_m_ack));
      s0_k9_slice_6_fork_ack_r_4 <= (s0_k9_slice_6_fork_ack_s_4 && (! s0_k9_slice_6_m_ack));
      s0_k9_slice_7_fork_ack_r_0 <= (s0_k9_slice_7_fork_ack_s_0 && (! s0_k9_slice_7_m_ack));
      s0_k9_slice_7_fork_ack_r_1 <= (s0_k9_slice_7_fork_ack_s_1 && (! s0_k9_slice_7_m_ack));
      s0_k9_slice_7_fork_ack_r_2 <= (s0_k9_slice_7_fork_ack_s_2 && (! s0_k9_slice_7_m_ack));
      s0_k9_slice_7_fork_ack_r_3 <= (s0_k9_slice_7_fork_ack_s_3 && (! s0_k9_slice_7_m_ack));
      s0_cmul0_recip_norm_0_eb_valid <= ((! s0_cmul0_recip_norm_0_ack) || s0_cmul0_recip_norm_0_req);
      s0_cmul0_recip_mul_0_eb_valid <= ((! s0_cmul0_recip_mul_0_ack) || s0_cmul0_recip_mul_0_req);
      s0_cmul0_recip_out_0_eb_valid <= ((! s0_cmul0_recip_out_0_ack) || s0_cmul0_recip_out_0_req);
      s0_cmul0_recip_out_0_fork_ack_r_0 <= (s0_cmul0_recip_out_0_fork_ack_s_0 && (! s0_cmul0_recip_out_0_m_ack));
      s0_cmul0_recip_out_0_fork_ack_r_1 <= (s0_cmul0_recip_out_0_fork_ack_s_1 && (! s0_cmul0_recip_out_0_m_ack));
      s0_cmul0_cat_re_0_eb_state <= s0_cmul0_cat_re_0_eb_state_nxt;
      s0_cmul0_cat_im_0_eb_state <= s0_cmul0_cat_im_0_eb_state_nxt;
      s0_cmul0_mas_re_0_fork_ack_r_0 <= (s0_cmul0_mas_re_0_fork_ack_s_0 && (! s0_cmul0_mas_re_0_m_ack));
      s0_cmul0_mas_re_0_fork_ack_r_1 <= (s0_cmul0_mas_re_0_fork_ack_s_1 && (! s0_cmul0_mas_re_0_m_ack));
      s0_cmul0_mas_re_0_fork_ack_r_2 <= (s0_cmul0_mas_re_0_fork_ack_s_2 && (! s0_cmul0_mas_re_0_m_ack));
      s0_cmul0_mas_im_0_fork_ack_r_0 <= (s0_cmul0_mas_im_0_fork_ack_s_0 && (! s0_cmul0_mas_im_0_m_ack));
      s0_cmul0_mas_im_0_fork_ack_r_1 <= (s0_cmul0_mas_im_0_fork_ack_s_1 && (! s0_cmul0_mas_im_0_m_ack));
      s0_cmul0_mas_im_0_fork_ack_r_2 <= (s0_cmul0_mas_im_0_fork_ack_s_2 && (! s0_cmul0_mas_im_0_m_ack));
      s0_cmul1_recip_norm_0_eb_valid <= ((! s0_cmul1_recip_norm_0_ack) || s0_cmul1_recip_norm_0_req);
      s0_cmul1_recip_mul_0_eb_valid <= ((! s0_cmul1_recip_mul_0_ack) || s0_cmul1_recip_mul_0_req);
      s0_cmul1_recip_out_0_eb_valid <= ((! s0_cmul1_recip_out_0_ack) || s0_cmul1_recip_out_0_req);
      s0_cmul1_recip_out_0_fork_ack_r_0 <= (s0_cmul1_recip_out_0_fork_ack_s_0 && (! s0_cmul1_recip_out_0_m_ack));
      s0_cmul1_recip_out_0_fork_ack_r_1 <= (s0_cmul1_recip_out_0_fork_ack_s_1 && (! s0_cmul1_recip_out_0_m_ack));
      s0_cmul1_cat_re_0_eb_state <= s0_cmul1_cat_re_0_eb_state_nxt;
      s0_cmul1_cat_im_0_eb_state <= s0_cmul1_cat_im_0_eb_state_nxt;
      s0_cmul1_mas_re_0_fork_ack_r_0 <= (s0_cmul1_mas_re_0_fork_ack_s_0 && (! s0_cmul1_mas_re_0_m_ack));
      s0_cmul1_mas_re_0_fork_ack_r_1 <= (s0_cmul1_mas_re_0_fork_ack_s_1 && (! s0_cmul1_mas_re_0_m_ack));
      s0_cmul1_mas_re_0_fork_ack_r_2 <= (s0_cmul1_mas_re_0_fork_ack_s_2 && (! s0_cmul1_mas_re_0_m_ack));
      s0_cmul1_mas_im_0_fork_ack_r_0 <= (s0_cmul1_mas_im_0_fork_ack_s_0 && (! s0_cmul1_mas_im_0_m_ack));
      s0_cmul1_mas_im_0_fork_ack_r_1 <= (s0_cmul1_mas_im_0_fork_ack_s_1 && (! s0_cmul1_mas_im_0_m_ack));
      s0_cmul1_mas_im_0_fork_ack_r_2 <= (s0_cmul1_mas_im_0_fork_ack_s_2 && (! s0_cmul1_mas_im_0_m_ack));
      s0_cmul2_recip_norm_0_eb_valid <= ((! s0_cmul2_recip_norm_0_ack) || s0_cmul2_recip_norm_0_req);
      s0_cmul2_recip_mul_0_eb_valid <= ((! s0_cmul2_recip_mul_0_ack) || s0_cmul2_recip_mul_0_req);
      s0_cmul2_recip_out_0_eb_valid <= ((! s0_cmul2_recip_out_0_ack) || s0_cmul2_recip_out_0_req);
      s0_cmul2_recip_out_0_fork_ack_r_0 <= (s0_cmul2_recip_out_0_fork_ack_s_0 && (! s0_cmul2_recip_out_0_m_ack));
      s0_cmul2_recip_out_0_fork_ack_r_1 <= (s0_cmul2_recip_out_0_fork_ack_s_1 && (! s0_cmul2_recip_out_0_m_ack));
      s0_cmul2_cat_re_0_eb_state <= s0_cmul2_cat_re_0_eb_state_nxt;
      s0_cmul2_cat_im_0_eb_state <= s0_cmul2_cat_im_0_eb_state_nxt;
      s0_cmul2_mas_re_0_fork_ack_r_0 <= (s0_cmul2_mas_re_0_fork_ack_s_0 && (! s0_cmul2_mas_re_0_m_ack));
      s0_cmul2_mas_re_0_fork_ack_r_1 <= (s0_cmul2_mas_re_0_fork_ack_s_1 && (! s0_cmul2_mas_re_0_m_ack));
      s0_cmul2_mas_re_0_fork_ack_r_2 <= (s0_cmul2_mas_re_0_fork_ack_s_2 && (! s0_cmul2_mas_re_0_m_ack));
      s0_cmul2_mas_im_0_fork_ack_r_0 <= (s0_cmul2_mas_im_0_fork_ack_s_0 && (! s0_cmul2_mas_im_0_m_ack));
      s0_cmul2_mas_im_0_fork_ack_r_1 <= (s0_cmul2_mas_im_0_fork_ack_s_1 && (! s0_cmul2_mas_im_0_m_ack));
      s0_cmul2_mas_im_0_fork_ack_r_2 <= (s0_cmul2_mas_im_0_fork_ack_s_2 && (! s0_cmul2_mas_im_0_m_ack));
      s0_cmul3_recip_norm_0_eb_valid <= ((! s0_cmul3_recip_norm_0_ack) || s0_cmul3_recip_norm_0_req);
      s0_cmul3_recip_mul_0_eb_valid <= ((! s0_cmul3_recip_mul_0_ack) || s0_cmul3_recip_mul_0_req);
      s0_cmul3_recip_out_0_eb_valid <= ((! s0_cmul3_recip_out_0_ack) || s0_cmul3_recip_out_0_req);
      s0_cmul3_recip_out_0_fork_ack_r_0 <= (s0_cmul3_recip_out_0_fork_ack_s_0 && (! s0_cmul3_recip_out_0_m_ack));
      s0_cmul3_recip_out_0_fork_ack_r_1 <= (s0_cmul3_recip_out_0_fork_ack_s_1 && (! s0_cmul3_recip_out_0_m_ack));
      s0_cmul3_cat_re_0_eb_state <= s0_cmul3_cat_re_0_eb_state_nxt;
      s0_cmul3_cat_im_0_eb_state <= s0_cmul3_cat_im_0_eb_state_nxt;
      s0_cmul3_mas_re_0_fork_ack_r_0 <= (s0_cmul3_mas_re_0_fork_ack_s_0 && (! s0_cmul3_mas_re_0_m_ack));
      s0_cmul3_mas_re_0_fork_ack_r_1 <= (s0_cmul3_mas_re_0_fork_ack_s_1 && (! s0_cmul3_mas_re_0_m_ack));
      s0_cmul3_mas_re_0_fork_ack_r_2 <= (s0_cmul3_mas_re_0_fork_ack_s_2 && (! s0_cmul3_mas_re_0_m_ack));
      s0_cmul3_mas_im_0_fork_ack_r_0 <= (s0_cmul3_mas_im_0_fork_ack_s_0 && (! s0_cmul3_mas_im_0_m_ack));
      s0_cmul3_mas_im_0_fork_ack_r_1 <= (s0_cmul3_mas_im_0_fork_ack_s_1 && (! s0_cmul3_mas_im_0_m_ack));
      s0_cmul3_mas_im_0_fork_ack_r_2 <= (s0_cmul3_mas_im_0_fork_ack_s_2 && (! s0_cmul3_mas_im_0_m_ack));
      k8_funnel_1_eb_valid <= ((! k8_funnel_1_ack) || k8_funnel_1_req);
      k9_funnel_1_eb_valid <= ((! k9_funnel_1_ack) || k9_funnel_1_req);
      s1_k8_slice_0_fork_ack_r_0 <= (s1_k8_slice_0_fork_ack_s_0 && (! s1_k8_slice_0_m_ack));
      s1_k8_slice_0_fork_ack_r_1 <= (s1_k8_slice_0_fork_ack_s_1 && (! s1_k8_slice_0_m_ack));
      s1_k8_slice_0_fork_ack_r_2 <= (s1_k8_slice_0_fork_ack_s_2 && (! s1_k8_slice_0_m_ack));
      s1_k8_slice_1_fork_ack_r_0 <= (s1_k8_slice_1_fork_ack_s_0 && (! s1_k8_slice_1_m_ack));
      s1_k8_slice_1_fork_ack_r_1 <= (s1_k8_slice_1_fork_ack_s_1 && (! s1_k8_slice_1_m_ack));
      s1_k8_slice_1_fork_ack_r_2 <= (s1_k8_slice_1_fork_ack_s_2 && (! s1_k8_slice_1_m_ack));
      s1_k9_slice_0_fork_ack_r_0 <= (s1_k9_slice_0_fork_ack_s_0 && (! s1_k9_slice_0_m_ack));
      s1_k9_slice_0_fork_ack_r_1 <= (s1_k9_slice_0_fork_ack_s_1 && (! s1_k9_slice_0_m_ack));
      s1_k9_slice_0_fork_ack_r_2 <= (s1_k9_slice_0_fork_ack_s_2 && (! s1_k9_slice_0_m_ack));
      s1_k9_slice_0_fork_ack_r_3 <= (s1_k9_slice_0_fork_ack_s_3 && (! s1_k9_slice_0_m_ack));
      s1_k9_slice_0_fork_ack_r_4 <= (s1_k9_slice_0_fork_ack_s_4 && (! s1_k9_slice_0_m_ack));
      s1_k9_slice_1_fork_ack_r_0 <= (s1_k9_slice_1_fork_ack_s_0 && (! s1_k9_slice_1_m_ack));
      s1_k9_slice_1_fork_ack_r_1 <= (s1_k9_slice_1_fork_ack_s_1 && (! s1_k9_slice_1_m_ack));
      s1_k9_slice_1_fork_ack_r_2 <= (s1_k9_slice_1_fork_ack_s_2 && (! s1_k9_slice_1_m_ack));
      s1_k9_slice_1_fork_ack_r_3 <= (s1_k9_slice_1_fork_ack_s_3 && (! s1_k9_slice_1_m_ack));
      s1_k8_slice_2_fork_ack_r_0 <= (s1_k8_slice_2_fork_ack_s_0 && (! s1_k8_slice_2_m_ack));
      s1_k8_slice_2_fork_ack_r_1 <= (s1_k8_slice_2_fork_ack_s_1 && (! s1_k8_slice_2_m_ack));
      s1_k8_slice_2_fork_ack_r_2 <= (s1_k8_slice_2_fork_ack_s_2 && (! s1_k8_slice_2_m_ack));
      s1_k8_slice_3_fork_ack_r_0 <= (s1_k8_slice_3_fork_ack_s_0 && (! s1_k8_slice_3_m_ack));
      s1_k8_slice_3_fork_ack_r_1 <= (s1_k8_slice_3_fork_ack_s_1 && (! s1_k8_slice_3_m_ack));
      s1_k8_slice_3_fork_ack_r_2 <= (s1_k8_slice_3_fork_ack_s_2 && (! s1_k8_slice_3_m_ack));
      s1_k9_slice_2_fork_ack_r_0 <= (s1_k9_slice_2_fork_ack_s_0 && (! s1_k9_slice_2_m_ack));
      s1_k9_slice_2_fork_ack_r_1 <= (s1_k9_slice_2_fork_ack_s_1 && (! s1_k9_slice_2_m_ack));
      s1_k9_slice_2_fork_ack_r_2 <= (s1_k9_slice_2_fork_ack_s_2 && (! s1_k9_slice_2_m_ack));
      s1_k9_slice_2_fork_ack_r_3 <= (s1_k9_slice_2_fork_ack_s_3 && (! s1_k9_slice_2_m_ack));
      s1_k9_slice_2_fork_ack_r_4 <= (s1_k9_slice_2_fork_ack_s_4 && (! s1_k9_slice_2_m_ack));
      s1_k9_slice_3_fork_ack_r_0 <= (s1_k9_slice_3_fork_ack_s_0 && (! s1_k9_slice_3_m_ack));
      s1_k9_slice_3_fork_ack_r_1 <= (s1_k9_slice_3_fork_ack_s_1 && (! s1_k9_slice_3_m_ack));
      s1_k9_slice_3_fork_ack_r_2 <= (s1_k9_slice_3_fork_ack_s_2 && (! s1_k9_slice_3_m_ack));
      s1_k9_slice_3_fork_ack_r_3 <= (s1_k9_slice_3_fork_ack_s_3 && (! s1_k9_slice_3_m_ack));
      s1_k8_slice_4_fork_ack_r_0 <= (s1_k8_slice_4_fork_ack_s_0 && (! s1_k8_slice_4_m_ack));
      s1_k8_slice_4_fork_ack_r_1 <= (s1_k8_slice_4_fork_ack_s_1 && (! s1_k8_slice_4_m_ack));
      s1_k8_slice_4_fork_ack_r_2 <= (s1_k8_slice_4_fork_ack_s_2 && (! s1_k8_slice_4_m_ack));
      s1_k8_slice_5_fork_ack_r_0 <= (s1_k8_slice_5_fork_ack_s_0 && (! s1_k8_slice_5_m_ack));
      s1_k8_slice_5_fork_ack_r_1 <= (s1_k8_slice_5_fork_ack_s_1 && (! s1_k8_slice_5_m_ack));
      s1_k8_slice_5_fork_ack_r_2 <= (s1_k8_slice_5_fork_ack_s_2 && (! s1_k8_slice_5_m_ack));
      s1_k9_slice_4_fork_ack_r_0 <= (s1_k9_slice_4_fork_ack_s_0 && (! s1_k9_slice_4_m_ack));
      s1_k9_slice_4_fork_ack_r_1 <= (s1_k9_slice_4_fork_ack_s_1 && (! s1_k9_slice_4_m_ack));
      s1_k9_slice_4_fork_ack_r_2 <= (s1_k9_slice_4_fork_ack_s_2 && (! s1_k9_slice_4_m_ack));
      s1_k9_slice_4_fork_ack_r_3 <= (s1_k9_slice_4_fork_ack_s_3 && (! s1_k9_slice_4_m_ack));
      s1_k9_slice_4_fork_ack_r_4 <= (s1_k9_slice_4_fork_ack_s_4 && (! s1_k9_slice_4_m_ack));
      s1_k9_slice_5_fork_ack_r_0 <= (s1_k9_slice_5_fork_ack_s_0 && (! s1_k9_slice_5_m_ack));
      s1_k9_slice_5_fork_ack_r_1 <= (s1_k9_slice_5_fork_ack_s_1 && (! s1_k9_slice_5_m_ack));
      s1_k9_slice_5_fork_ack_r_2 <= (s1_k9_slice_5_fork_ack_s_2 && (! s1_k9_slice_5_m_ack));
      s1_k9_slice_5_fork_ack_r_3 <= (s1_k9_slice_5_fork_ack_s_3 && (! s1_k9_slice_5_m_ack));
      s1_k8_slice_6_fork_ack_r_0 <= (s1_k8_slice_6_fork_ack_s_0 && (! s1_k8_slice_6_m_ack));
      s1_k8_slice_6_fork_ack_r_1 <= (s1_k8_slice_6_fork_ack_s_1 && (! s1_k8_slice_6_m_ack));
      s1_k8_slice_6_fork_ack_r_2 <= (s1_k8_slice_6_fork_ack_s_2 && (! s1_k8_slice_6_m_ack));
      s1_k8_slice_7_fork_ack_r_0 <= (s1_k8_slice_7_fork_ack_s_0 && (! s1_k8_slice_7_m_ack));
      s1_k8_slice_7_fork_ack_r_1 <= (s1_k8_slice_7_fork_ack_s_1 && (! s1_k8_slice_7_m_ack));
      s1_k8_slice_7_fork_ack_r_2 <= (s1_k8_slice_7_fork_ack_s_2 && (! s1_k8_slice_7_m_ack));
      s1_k9_slice_6_fork_ack_r_0 <= (s1_k9_slice_6_fork_ack_s_0 && (! s1_k9_slice_6_m_ack));
      s1_k9_slice_6_fork_ack_r_1 <= (s1_k9_slice_6_fork_ack_s_1 && (! s1_k9_slice_6_m_ack));
      s1_k9_slice_6_fork_ack_r_2 <= (s1_k9_slice_6_fork_ack_s_2 && (! s1_k9_slice_6_m_ack));
      s1_k9_slice_6_fork_ack_r_3 <= (s1_k9_slice_6_fork_ack_s_3 && (! s1_k9_slice_6_m_ack));
      s1_k9_slice_6_fork_ack_r_4 <= (s1_k9_slice_6_fork_ack_s_4 && (! s1_k9_slice_6_m_ack));
      s1_k9_slice_7_fork_ack_r_0 <= (s1_k9_slice_7_fork_ack_s_0 && (! s1_k9_slice_7_m_ack));
      s1_k9_slice_7_fork_ack_r_1 <= (s1_k9_slice_7_fork_ack_s_1 && (! s1_k9_slice_7_m_ack));
      s1_k9_slice_7_fork_ack_r_2 <= (s1_k9_slice_7_fork_ack_s_2 && (! s1_k9_slice_7_m_ack));
      s1_k9_slice_7_fork_ack_r_3 <= (s1_k9_slice_7_fork_ack_s_3 && (! s1_k9_slice_7_m_ack));
      s1_cmul0_recip_norm_0_eb_valid <= ((! s1_cmul0_recip_norm_0_ack) || s1_cmul0_recip_norm_0_req);
      s1_cmul0_recip_mul_0_eb_valid <= ((! s1_cmul0_recip_mul_0_ack) || s1_cmul0_recip_mul_0_req);
      s1_cmul0_recip_out_0_eb_valid <= ((! s1_cmul0_recip_out_0_ack) || s1_cmul0_recip_out_0_req);
      s1_cmul0_recip_out_0_fork_ack_r_0 <= (s1_cmul0_recip_out_0_fork_ack_s_0 && (! s1_cmul0_recip_out_0_m_ack));
      s1_cmul0_recip_out_0_fork_ack_r_1 <= (s1_cmul0_recip_out_0_fork_ack_s_1 && (! s1_cmul0_recip_out_0_m_ack));
      s1_cmul0_cat_re_0_eb_state <= s1_cmul0_cat_re_0_eb_state_nxt;
      s1_cmul0_cat_im_0_eb_state <= s1_cmul0_cat_im_0_eb_state_nxt;
      s1_cmul0_mas_re_0_fork_ack_r_0 <= (s1_cmul0_mas_re_0_fork_ack_s_0 && (! s1_cmul0_mas_re_0_m_ack));
      s1_cmul0_mas_re_0_fork_ack_r_1 <= (s1_cmul0_mas_re_0_fork_ack_s_1 && (! s1_cmul0_mas_re_0_m_ack));
      s1_cmul0_mas_re_0_fork_ack_r_2 <= (s1_cmul0_mas_re_0_fork_ack_s_2 && (! s1_cmul0_mas_re_0_m_ack));
      s1_cmul0_mas_im_0_fork_ack_r_0 <= (s1_cmul0_mas_im_0_fork_ack_s_0 && (! s1_cmul0_mas_im_0_m_ack));
      s1_cmul0_mas_im_0_fork_ack_r_1 <= (s1_cmul0_mas_im_0_fork_ack_s_1 && (! s1_cmul0_mas_im_0_m_ack));
      s1_cmul0_mas_im_0_fork_ack_r_2 <= (s1_cmul0_mas_im_0_fork_ack_s_2 && (! s1_cmul0_mas_im_0_m_ack));
      s1_cmul1_recip_norm_0_eb_valid <= ((! s1_cmul1_recip_norm_0_ack) || s1_cmul1_recip_norm_0_req);
      s1_cmul1_recip_mul_0_eb_valid <= ((! s1_cmul1_recip_mul_0_ack) || s1_cmul1_recip_mul_0_req);
      s1_cmul1_recip_out_0_eb_valid <= ((! s1_cmul1_recip_out_0_ack) || s1_cmul1_recip_out_0_req);
      s1_cmul1_recip_out_0_fork_ack_r_0 <= (s1_cmul1_recip_out_0_fork_ack_s_0 && (! s1_cmul1_recip_out_0_m_ack));
      s1_cmul1_recip_out_0_fork_ack_r_1 <= (s1_cmul1_recip_out_0_fork_ack_s_1 && (! s1_cmul1_recip_out_0_m_ack));
      s1_cmul1_cat_re_0_eb_state <= s1_cmul1_cat_re_0_eb_state_nxt;
      s1_cmul1_cat_im_0_eb_state <= s1_cmul1_cat_im_0_eb_state_nxt;
      s1_cmul1_mas_re_0_fork_ack_r_0 <= (s1_cmul1_mas_re_0_fork_ack_s_0 && (! s1_cmul1_mas_re_0_m_ack));
      s1_cmul1_mas_re_0_fork_ack_r_1 <= (s1_cmul1_mas_re_0_fork_ack_s_1 && (! s1_cmul1_mas_re_0_m_ack));
      s1_cmul1_mas_re_0_fork_ack_r_2 <= (s1_cmul1_mas_re_0_fork_ack_s_2 && (! s1_cmul1_mas_re_0_m_ack));
      s1_cmul1_mas_im_0_fork_ack_r_0 <= (s1_cmul1_mas_im_0_fork_ack_s_0 && (! s1_cmul1_mas_im_0_m_ack));
      s1_cmul1_mas_im_0_fork_ack_r_1 <= (s1_cmul1_mas_im_0_fork_ack_s_1 && (! s1_cmul1_mas_im_0_m_ack));
      s1_cmul1_mas_im_0_fork_ack_r_2 <= (s1_cmul1_mas_im_0_fork_ack_s_2 && (! s1_cmul1_mas_im_0_m_ack));
      s1_cmul2_recip_norm_0_eb_valid <= ((! s1_cmul2_recip_norm_0_ack) || s1_cmul2_recip_norm_0_req);
      s1_cmul2_recip_mul_0_eb_valid <= ((! s1_cmul2_recip_mul_0_ack) || s1_cmul2_recip_mul_0_req);
      s1_cmul2_recip_out_0_eb_valid <= ((! s1_cmul2_recip_out_0_ack) || s1_cmul2_recip_out_0_req);
      s1_cmul2_recip_out_0_fork_ack_r_0 <= (s1_cmul2_recip_out_0_fork_ack_s_0 && (! s1_cmul2_recip_out_0_m_ack));
      s1_cmul2_recip_out_0_fork_ack_r_1 <= (s1_cmul2_recip_out_0_fork_ack_s_1 && (! s1_cmul2_recip_out_0_m_ack));
      s1_cmul2_cat_re_0_eb_state <= s1_cmul2_cat_re_0_eb_state_nxt;
      s1_cmul2_cat_im_0_eb_state <= s1_cmul2_cat_im_0_eb_state_nxt;
      s1_cmul2_mas_re_0_fork_ack_r_0 <= (s1_cmul2_mas_re_0_fork_ack_s_0 && (! s1_cmul2_mas_re_0_m_ack));
      s1_cmul2_mas_re_0_fork_ack_r_1 <= (s1_cmul2_mas_re_0_fork_ack_s_1 && (! s1_cmul2_mas_re_0_m_ack));
      s1_cmul2_mas_re_0_fork_ack_r_2 <= (s1_cmul2_mas_re_0_fork_ack_s_2 && (! s1_cmul2_mas_re_0_m_ack));
      s1_cmul2_mas_im_0_fork_ack_r_0 <= (s1_cmul2_mas_im_0_fork_ack_s_0 && (! s1_cmul2_mas_im_0_m_ack));
      s1_cmul2_mas_im_0_fork_ack_r_1 <= (s1_cmul2_mas_im_0_fork_ack_s_1 && (! s1_cmul2_mas_im_0_m_ack));
      s1_cmul2_mas_im_0_fork_ack_r_2 <= (s1_cmul2_mas_im_0_fork_ack_s_2 && (! s1_cmul2_mas_im_0_m_ack));
      s1_cmul3_recip_norm_0_eb_valid <= ((! s1_cmul3_recip_norm_0_ack) || s1_cmul3_recip_norm_0_req);
      s1_cmul3_recip_mul_0_eb_valid <= ((! s1_cmul3_recip_mul_0_ack) || s1_cmul3_recip_mul_0_req);
      s1_cmul3_recip_out_0_eb_valid <= ((! s1_cmul3_recip_out_0_ack) || s1_cmul3_recip_out_0_req);
      s1_cmul3_recip_out_0_fork_ack_r_0 <= (s1_cmul3_recip_out_0_fork_ack_s_0 && (! s1_cmul3_recip_out_0_m_ack));
      s1_cmul3_recip_out_0_fork_ack_r_1 <= (s1_cmul3_recip_out_0_fork_ack_s_1 && (! s1_cmul3_recip_out_0_m_ack));
      s1_cmul3_cat_re_0_eb_state <= s1_cmul3_cat_re_0_eb_state_nxt;
      s1_cmul3_cat_im_0_eb_state <= s1_cmul3_cat_im_0_eb_state_nxt;
      s1_cmul3_mas_re_0_fork_ack_r_0 <= (s1_cmul3_mas_re_0_fork_ack_s_0 && (! s1_cmul3_mas_re_0_m_ack));
      s1_cmul3_mas_re_0_fork_ack_r_1 <= (s1_cmul3_mas_re_0_fork_ack_s_1 && (! s1_cmul3_mas_re_0_m_ack));
      s1_cmul3_mas_re_0_fork_ack_r_2 <= (s1_cmul3_mas_re_0_fork_ack_s_2 && (! s1_cmul3_mas_re_0_m_ack));
      s1_cmul3_mas_im_0_fork_ack_r_0 <= (s1_cmul3_mas_im_0_fork_ack_s_0 && (! s1_cmul3_mas_im_0_m_ack));
      s1_cmul3_mas_im_0_fork_ack_r_1 <= (s1_cmul3_mas_im_0_fork_ack_s_1 && (! s1_cmul3_mas_im_0_m_ack));
      s1_cmul3_mas_im_0_fork_ack_r_2 <= (s1_cmul3_mas_im_0_fork_ack_s_2 && (! s1_cmul3_mas_im_0_m_ack));
      s0_r4_a0_re_0_eb_state <= s0_r4_a0_re_0_eb_state_nxt;
      s0_r4_a0_re_0_fork_ack_r_0 <= (s0_r4_a0_re_0_fork_ack_s_0 && (! s0_r4_a0_re_0_m_ack));
      s0_r4_a0_re_0_fork_ack_r_1 <= (s0_r4_a0_re_0_fork_ack_s_1 && (! s0_r4_a0_re_0_m_ack));
      s0_r4_a0_im_0_eb_state <= s0_r4_a0_im_0_eb_state_nxt;
      s0_r4_a0_im_0_fork_ack_r_0 <= (s0_r4_a0_im_0_fork_ack_s_0 && (! s0_r4_a0_im_0_m_ack));
      s0_r4_a0_im_0_fork_ack_r_1 <= (s0_r4_a0_im_0_fork_ack_s_1 && (! s0_r4_a0_im_0_m_ack));
      s0_r4_a1_re_0_eb_state <= s0_r4_a1_re_0_eb_state_nxt;
      s0_r4_a1_re_0_fork_ack_r_0 <= (s0_r4_a1_re_0_fork_ack_s_0 && (! s0_r4_a1_re_0_m_ack));
      s0_r4_a1_re_0_fork_ack_r_1 <= (s0_r4_a1_re_0_fork_ack_s_1 && (! s0_r4_a1_re_0_m_ack));
      s0_r4_a1_im_0_eb_state <= s0_r4_a1_im_0_eb_state_nxt;
      s0_r4_a1_im_0_fork_ack_r_0 <= (s0_r4_a1_im_0_fork_ack_s_0 && (! s0_r4_a1_im_0_m_ack));
      s0_r4_a1_im_0_fork_ack_r_1 <= (s0_r4_a1_im_0_fork_ack_s_1 && (! s0_r4_a1_im_0_m_ack));
      s0_r4_a2_re_0_eb_state <= s0_r4_a2_re_0_eb_state_nxt;
      s0_r4_a2_re_0_fork_ack_r_0 <= (s0_r4_a2_re_0_fork_ack_s_0 && (! s0_r4_a2_re_0_m_ack));
      s0_r4_a2_re_0_fork_ack_r_1 <= (s0_r4_a2_re_0_fork_ack_s_1 && (! s0_r4_a2_re_0_m_ack));
      s0_r4_a2_im_0_eb_state <= s0_r4_a2_im_0_eb_state_nxt;
      s0_r4_a2_im_0_fork_ack_r_0 <= (s0_r4_a2_im_0_fork_ack_s_0 && (! s0_r4_a2_im_0_m_ack));
      s0_r4_a2_im_0_fork_ack_r_1 <= (s0_r4_a2_im_0_fork_ack_s_1 && (! s0_r4_a2_im_0_m_ack));
      s0_r4_a3_re_0_eb_state <= s0_r4_a3_re_0_eb_state_nxt;
      s0_r4_a3_re_0_fork_ack_r_0 <= (s0_r4_a3_re_0_fork_ack_s_0 && (! s0_r4_a3_re_0_m_ack));
      s0_r4_a3_re_0_fork_ack_r_1 <= (s0_r4_a3_re_0_fork_ack_s_1 && (! s0_r4_a3_re_0_m_ack));
      s0_r4_a3_im_0_eb_state <= s0_r4_a3_im_0_eb_state_nxt;
      s0_r4_a3_im_0_fork_ack_r_0 <= (s0_r4_a3_im_0_fork_ack_s_0 && (! s0_r4_a3_im_0_m_ack));
      s0_r4_a3_im_0_fork_ack_r_1 <= (s0_r4_a3_im_0_fork_ack_s_1 && (! s0_r4_a3_im_0_m_ack));
      s0_r4_byp0_re_0_eb_valid <= ((! s0_r4_byp0_re_0_ack) || s0_r4_byp0_re_0_req);
      s0_r4_byp0_im_0_eb_valid <= ((! s0_r4_byp0_im_0_ack) || s0_r4_byp0_im_0_req);
      s0_r4_byp1_re_0_eb_valid <= ((! s0_r4_byp1_re_0_ack) || s0_r4_byp1_re_0_req);
      s0_r4_byp1_im_0_eb_valid <= ((! s0_r4_byp1_im_0_ack) || s0_r4_byp1_im_0_req);
      s0_r4_byp2_re_0_eb_valid <= ((! s0_r4_byp2_re_0_ack) || s0_r4_byp2_re_0_req);
      s0_r4_byp2_im_0_eb_valid <= ((! s0_r4_byp2_im_0_ack) || s0_r4_byp2_im_0_req);
      s0_r4_byp3_re_0_eb_valid <= ((! s0_r4_byp3_re_0_ack) || s0_r4_byp3_re_0_req);
      s0_r4_byp3_im_0_eb_valid <= ((! s0_r4_byp3_im_0_ack) || s0_r4_byp3_im_0_req);
      s1_r4_a0_re_0_eb_state <= s1_r4_a0_re_0_eb_state_nxt;
      s1_r4_a0_re_0_fork_ack_r_0 <= (s1_r4_a0_re_0_fork_ack_s_0 && (! s1_r4_a0_re_0_m_ack));
      s1_r4_a0_re_0_fork_ack_r_1 <= (s1_r4_a0_re_0_fork_ack_s_1 && (! s1_r4_a0_re_0_m_ack));
      s1_r4_a0_im_0_eb_state <= s1_r4_a0_im_0_eb_state_nxt;
      s1_r4_a0_im_0_fork_ack_r_0 <= (s1_r4_a0_im_0_fork_ack_s_0 && (! s1_r4_a0_im_0_m_ack));
      s1_r4_a0_im_0_fork_ack_r_1 <= (s1_r4_a0_im_0_fork_ack_s_1 && (! s1_r4_a0_im_0_m_ack));
      s1_r4_a1_re_0_eb_state <= s1_r4_a1_re_0_eb_state_nxt;
      s1_r4_a1_re_0_fork_ack_r_0 <= (s1_r4_a1_re_0_fork_ack_s_0 && (! s1_r4_a1_re_0_m_ack));
      s1_r4_a1_re_0_fork_ack_r_1 <= (s1_r4_a1_re_0_fork_ack_s_1 && (! s1_r4_a1_re_0_m_ack));
      s1_r4_a1_im_0_eb_state <= s1_r4_a1_im_0_eb_state_nxt;
      s1_r4_a1_im_0_fork_ack_r_0 <= (s1_r4_a1_im_0_fork_ack_s_0 && (! s1_r4_a1_im_0_m_ack));
      s1_r4_a1_im_0_fork_ack_r_1 <= (s1_r4_a1_im_0_fork_ack_s_1 && (! s1_r4_a1_im_0_m_ack));
      s1_r4_a2_re_0_eb_state <= s1_r4_a2_re_0_eb_state_nxt;
      s1_r4_a2_re_0_fork_ack_r_0 <= (s1_r4_a2_re_0_fork_ack_s_0 && (! s1_r4_a2_re_0_m_ack));
      s1_r4_a2_re_0_fork_ack_r_1 <= (s1_r4_a2_re_0_fork_ack_s_1 && (! s1_r4_a2_re_0_m_ack));
      s1_r4_a2_im_0_eb_state <= s1_r4_a2_im_0_eb_state_nxt;
      s1_r4_a2_im_0_fork_ack_r_0 <= (s1_r4_a2_im_0_fork_ack_s_0 && (! s1_r4_a2_im_0_m_ack));
      s1_r4_a2_im_0_fork_ack_r_1 <= (s1_r4_a2_im_0_fork_ack_s_1 && (! s1_r4_a2_im_0_m_ack));
      s1_r4_a3_re_0_eb_state <= s1_r4_a3_re_0_eb_state_nxt;
      s1_r4_a3_re_0_fork_ack_r_0 <= (s1_r4_a3_re_0_fork_ack_s_0 && (! s1_r4_a3_re_0_m_ack));
      s1_r4_a3_re_0_fork_ack_r_1 <= (s1_r4_a3_re_0_fork_ack_s_1 && (! s1_r4_a3_re_0_m_ack));
      s1_r4_a3_im_0_eb_state <= s1_r4_a3_im_0_eb_state_nxt;
      s1_r4_a3_im_0_fork_ack_r_0 <= (s1_r4_a3_im_0_fork_ack_s_0 && (! s1_r4_a3_im_0_m_ack));
      s1_r4_a3_im_0_fork_ack_r_1 <= (s1_r4_a3_im_0_fork_ack_s_1 && (! s1_r4_a3_im_0_m_ack));
      s1_r4_byp0_re_0_eb_valid <= ((! s1_r4_byp0_re_0_ack) || s1_r4_byp0_re_0_req);
      s1_r4_byp0_im_0_eb_valid <= ((! s1_r4_byp0_im_0_ack) || s1_r4_byp0_im_0_req);
      s1_r4_byp1_re_0_eb_valid <= ((! s1_r4_byp1_re_0_ack) || s1_r4_byp1_re_0_req);
      s1_r4_byp1_im_0_eb_valid <= ((! s1_r4_byp1_im_0_ack) || s1_r4_byp1_im_0_req);
      s1_r4_byp2_re_0_eb_valid <= ((! s1_r4_byp2_re_0_ack) || s1_r4_byp2_re_0_req);
      s1_r4_byp2_im_0_eb_valid <= ((! s1_r4_byp2_im_0_ack) || s1_r4_byp2_im_0_req);
      s1_r4_byp3_re_0_eb_valid <= ((! s1_r4_byp3_re_0_ack) || s1_r4_byp3_re_0_req);
      s1_r4_byp3_im_0_eb_valid <= ((! s1_r4_byp3_im_0_ack) || s1_r4_byp3_im_0_req);
      s0_bs0_re_0_eb_state <= s0_bs0_re_0_eb_state_nxt;
      s0_bs0_im_0_eb_state <= s0_bs0_im_0_eb_state_nxt;
      s0_rsat0_re_0_eb_valid <= ((! s0_rsat0_re_0_ack) || s0_rsat0_re_0_req);
      s0_rsat0_im_0_eb_valid <= ((! s0_rsat0_im_0_ack) || s0_rsat0_im_0_req);
      s0_bs1_re_0_eb_state <= s0_bs1_re_0_eb_state_nxt;
      s0_bs1_im_0_eb_state <= s0_bs1_im_0_eb_state_nxt;
      s0_rsat1_re_0_eb_valid <= ((! s0_rsat1_re_0_ack) || s0_rsat1_re_0_req);
      s0_rsat1_im_0_eb_valid <= ((! s0_rsat1_im_0_ack) || s0_rsat1_im_0_req);
      s0_bs2_re_0_eb_state <= s0_bs2_re_0_eb_state_nxt;
      s0_bs2_im_0_eb_state <= s0_bs2_im_0_eb_state_nxt;
      s0_rsat2_re_0_eb_valid <= ((! s0_rsat2_re_0_ack) || s0_rsat2_re_0_req);
      s0_rsat2_im_0_eb_valid <= ((! s0_rsat2_im_0_ack) || s0_rsat2_im_0_req);
      s0_bs3_re_0_eb_state <= s0_bs3_re_0_eb_state_nxt;
      s0_bs3_im_0_eb_state <= s0_bs3_im_0_eb_state_nxt;
      s0_rsat3_re_0_eb_valid <= ((! s0_rsat3_re_0_ack) || s0_rsat3_re_0_req);
      s0_rsat3_im_0_eb_valid <= ((! s0_rsat3_im_0_ack) || s0_rsat3_im_0_req);
      s1_bs0_re_0_eb_state <= s1_bs0_re_0_eb_state_nxt;
      s1_bs0_im_0_eb_state <= s1_bs0_im_0_eb_state_nxt;
      s1_rsat0_re_0_eb_valid <= ((! s1_rsat0_re_0_ack) || s1_rsat0_re_0_req);
      s1_rsat0_im_0_eb_valid <= ((! s1_rsat0_im_0_ack) || s1_rsat0_im_0_req);
      s1_bs1_re_0_eb_state <= s1_bs1_re_0_eb_state_nxt;
      s1_bs1_im_0_eb_state <= s1_bs1_im_0_eb_state_nxt;
      s1_rsat1_re_0_eb_valid <= ((! s1_rsat1_re_0_ack) || s1_rsat1_re_0_req);
      s1_rsat1_im_0_eb_valid <= ((! s1_rsat1_im_0_ack) || s1_rsat1_im_0_req);
      s1_bs2_re_0_eb_state <= s1_bs2_re_0_eb_state_nxt;
      s1_bs2_im_0_eb_state <= s1_bs2_im_0_eb_state_nxt;
      s1_rsat2_re_0_eb_valid <= ((! s1_rsat2_re_0_ack) || s1_rsat2_re_0_req);
      s1_rsat2_im_0_eb_valid <= ((! s1_rsat2_im_0_ack) || s1_rsat2_im_0_req);
      s1_bs3_re_0_eb_state <= s1_bs3_re_0_eb_state_nxt;
      s1_bs3_im_0_eb_state <= s1_bs3_im_0_eb_state_nxt;
      s1_rsat3_re_0_eb_valid <= ((! s1_rsat3_re_0_ack) || s1_rsat3_re_0_req);
      s1_rsat3_im_0_eb_valid <= ((! s1_rsat3_im_0_ack) || s1_rsat3_im_0_req);
    end
  end

  always @(posedge clk) begin
    s0_cmul0_mas_re_cfg_valid <= {s0_cmul0_mas_re_cfg_valid[2 : 0],cfg_s0_cmul0_mas_re_to_s0_cmul0_mas_re_req};
    s0_cmul0_mas_im_cfg_valid <= {s0_cmul0_mas_im_cfg_valid[2 : 0],cfg_s0_cmul0_mas_im_to_s0_cmul0_mas_im_req};
    s0_cmul1_mas_re_cfg_valid <= {s0_cmul1_mas_re_cfg_valid[2 : 0],cfg_s0_cmul1_mas_re_to_s0_cmul1_mas_re_req};
    s0_cmul1_mas_im_cfg_valid <= {s0_cmul1_mas_im_cfg_valid[2 : 0],cfg_s0_cmul1_mas_im_to_s0_cmul1_mas_im_req};
    s0_cmul2_mas_re_cfg_valid <= {s0_cmul2_mas_re_cfg_valid[2 : 0],cfg_s0_cmul2_mas_re_to_s0_cmul2_mas_re_req};
    s0_cmul2_mas_im_cfg_valid <= {s0_cmul2_mas_im_cfg_valid[2 : 0],cfg_s0_cmul2_mas_im_to_s0_cmul2_mas_im_req};
    s0_cmul3_mas_re_cfg_valid <= {s0_cmul3_mas_re_cfg_valid[2 : 0],cfg_s0_cmul3_mas_re_to_s0_cmul3_mas_re_req};
    s0_cmul3_mas_im_cfg_valid <= {s0_cmul3_mas_im_cfg_valid[2 : 0],cfg_s0_cmul3_mas_im_to_s0_cmul3_mas_im_req};
    s1_cmul0_mas_re_cfg_valid <= {s1_cmul0_mas_re_cfg_valid[2 : 0],cfg_s1_cmul0_mas_re_to_s1_cmul0_mas_re_req};
    s1_cmul0_mas_im_cfg_valid <= {s1_cmul0_mas_im_cfg_valid[2 : 0],cfg_s1_cmul0_mas_im_to_s1_cmul0_mas_im_req};
    s1_cmul1_mas_re_cfg_valid <= {s1_cmul1_mas_re_cfg_valid[2 : 0],cfg_s1_cmul1_mas_re_to_s1_cmul1_mas_re_req};
    s1_cmul1_mas_im_cfg_valid <= {s1_cmul1_mas_im_cfg_valid[2 : 0],cfg_s1_cmul1_mas_im_to_s1_cmul1_mas_im_req};
    s1_cmul2_mas_re_cfg_valid <= {s1_cmul2_mas_re_cfg_valid[2 : 0],cfg_s1_cmul2_mas_re_to_s1_cmul2_mas_re_req};
    s1_cmul2_mas_im_cfg_valid <= {s1_cmul2_mas_im_cfg_valid[2 : 0],cfg_s1_cmul2_mas_im_to_s1_cmul2_mas_im_req};
    s1_cmul3_mas_re_cfg_valid <= {s1_cmul3_mas_re_cfg_valid[2 : 0],cfg_s1_cmul3_mas_re_to_s1_cmul3_mas_re_req};
    s1_cmul3_mas_im_cfg_valid <= {s1_cmul3_mas_im_cfg_valid[2 : 0],cfg_s1_cmul3_mas_im_to_s1_cmul3_mas_im_req};
    if(k1_defunnel_0_eb_en0) begin
      k1_defunnel_0_eb_r0 <= k1_defunnel_0_nxt;
    end
    if(k1_defunnel_0_eb_en1) begin
      k1_defunnel_0_eb_r1 <= k1_defunnel_0_nxt;
    end
    if(k8_funnel_0_eb_en) begin
      k8_funnel_0_eb_r <= k8_funnel_0_nxt;
    end
    if(k9_funnel_0_eb_en) begin
      k9_funnel_0_eb_r <= k9_funnel_0_nxt;
    end
    if(s0_cmul0_recip_norm_0_eb_en) begin
      s0_cmul0_recip_norm_0_eb_r <= s0_cmul0_recip_norm_0_nxt;
    end
    if(s0_cmul0_recip_mul_0_eb_en) begin
      s0_cmul0_recip_mul_0_eb_r <= s0_cmul0_recip_mul_0_nxt;
    end
    if(s0_cmul0_recip_out_0_eb_en) begin
      s0_cmul0_recip_out_0_eb_r <= s0_cmul0_recip_out_0_nxt;
    end
    if(s0_cmul0_cat_re_0_eb_en0) begin
      s0_cmul0_cat_re_0_eb_r0 <= s0_cmul0_cat_re_0_nxt;
    end
    if(s0_cmul0_cat_re_0_eb_en1) begin
      s0_cmul0_cat_re_0_eb_r1 <= s0_cmul0_cat_re_0_nxt;
    end
    if(s0_cmul0_cat_im_0_eb_en0) begin
      s0_cmul0_cat_im_0_eb_r0 <= s0_cmul0_cat_im_0_nxt;
    end
    if(s0_cmul0_cat_im_0_eb_en1) begin
      s0_cmul0_cat_im_0_eb_r1 <= s0_cmul0_cat_im_0_nxt;
    end
    if(s0_cmul1_recip_norm_0_eb_en) begin
      s0_cmul1_recip_norm_0_eb_r <= s0_cmul1_recip_norm_0_nxt;
    end
    if(s0_cmul1_recip_mul_0_eb_en) begin
      s0_cmul1_recip_mul_0_eb_r <= s0_cmul1_recip_mul_0_nxt;
    end
    if(s0_cmul1_recip_out_0_eb_en) begin
      s0_cmul1_recip_out_0_eb_r <= s0_cmul1_recip_out_0_nxt;
    end
    if(s0_cmul1_cat_re_0_eb_en0) begin
      s0_cmul1_cat_re_0_eb_r0 <= s0_cmul1_cat_re_0_nxt;
    end
    if(s0_cmul1_cat_re_0_eb_en1) begin
      s0_cmul1_cat_re_0_eb_r1 <= s0_cmul1_cat_re_0_nxt;
    end
    if(s0_cmul1_cat_im_0_eb_en0) begin
      s0_cmul1_cat_im_0_eb_r0 <= s0_cmul1_cat_im_0_nxt;
    end
    if(s0_cmul1_cat_im_0_eb_en1) begin
      s0_cmul1_cat_im_0_eb_r1 <= s0_cmul1_cat_im_0_nxt;
    end
    if(s0_cmul2_recip_norm_0_eb_en) begin
      s0_cmul2_recip_norm_0_eb_r <= s0_cmul2_recip_norm_0_nxt;
    end
    if(s0_cmul2_recip_mul_0_eb_en) begin
      s0_cmul2_recip_mul_0_eb_r <= s0_cmul2_recip_mul_0_nxt;
    end
    if(s0_cmul2_recip_out_0_eb_en) begin
      s0_cmul2_recip_out_0_eb_r <= s0_cmul2_recip_out_0_nxt;
    end
    if(s0_cmul2_cat_re_0_eb_en0) begin
      s0_cmul2_cat_re_0_eb_r0 <= s0_cmul2_cat_re_0_nxt;
    end
    if(s0_cmul2_cat_re_0_eb_en1) begin
      s0_cmul2_cat_re_0_eb_r1 <= s0_cmul2_cat_re_0_nxt;
    end
    if(s0_cmul2_cat_im_0_eb_en0) begin
      s0_cmul2_cat_im_0_eb_r0 <= s0_cmul2_cat_im_0_nxt;
    end
    if(s0_cmul2_cat_im_0_eb_en1) begin
      s0_cmul2_cat_im_0_eb_r1 <= s0_cmul2_cat_im_0_nxt;
    end
    if(s0_cmul3_recip_norm_0_eb_en) begin
      s0_cmul3_recip_norm_0_eb_r <= s0_cmul3_recip_norm_0_nxt;
    end
    if(s0_cmul3_recip_mul_0_eb_en) begin
      s0_cmul3_recip_mul_0_eb_r <= s0_cmul3_recip_mul_0_nxt;
    end
    if(s0_cmul3_recip_out_0_eb_en) begin
      s0_cmul3_recip_out_0_eb_r <= s0_cmul3_recip_out_0_nxt;
    end
    if(s0_cmul3_cat_re_0_eb_en0) begin
      s0_cmul3_cat_re_0_eb_r0 <= s0_cmul3_cat_re_0_nxt;
    end
    if(s0_cmul3_cat_re_0_eb_en1) begin
      s0_cmul3_cat_re_0_eb_r1 <= s0_cmul3_cat_re_0_nxt;
    end
    if(s0_cmul3_cat_im_0_eb_en0) begin
      s0_cmul3_cat_im_0_eb_r0 <= s0_cmul3_cat_im_0_nxt;
    end
    if(s0_cmul3_cat_im_0_eb_en1) begin
      s0_cmul3_cat_im_0_eb_r1 <= s0_cmul3_cat_im_0_nxt;
    end
    if(k8_funnel_1_eb_en) begin
      k8_funnel_1_eb_r <= k8_funnel_1_nxt;
    end
    if(k9_funnel_1_eb_en) begin
      k9_funnel_1_eb_r <= k9_funnel_1_nxt;
    end
    if(s1_cmul0_recip_norm_0_eb_en) begin
      s1_cmul0_recip_norm_0_eb_r <= s1_cmul0_recip_norm_0_nxt;
    end
    if(s1_cmul0_recip_mul_0_eb_en) begin
      s1_cmul0_recip_mul_0_eb_r <= s1_cmul0_recip_mul_0_nxt;
    end
    if(s1_cmul0_recip_out_0_eb_en) begin
      s1_cmul0_recip_out_0_eb_r <= s1_cmul0_recip_out_0_nxt;
    end
    if(s1_cmul0_cat_re_0_eb_en0) begin
      s1_cmul0_cat_re_0_eb_r0 <= s1_cmul0_cat_re_0_nxt;
    end
    if(s1_cmul0_cat_re_0_eb_en1) begin
      s1_cmul0_cat_re_0_eb_r1 <= s1_cmul0_cat_re_0_nxt;
    end
    if(s1_cmul0_cat_im_0_eb_en0) begin
      s1_cmul0_cat_im_0_eb_r0 <= s1_cmul0_cat_im_0_nxt;
    end
    if(s1_cmul0_cat_im_0_eb_en1) begin
      s1_cmul0_cat_im_0_eb_r1 <= s1_cmul0_cat_im_0_nxt;
    end
    if(s1_cmul1_recip_norm_0_eb_en) begin
      s1_cmul1_recip_norm_0_eb_r <= s1_cmul1_recip_norm_0_nxt;
    end
    if(s1_cmul1_recip_mul_0_eb_en) begin
      s1_cmul1_recip_mul_0_eb_r <= s1_cmul1_recip_mul_0_nxt;
    end
    if(s1_cmul1_recip_out_0_eb_en) begin
      s1_cmul1_recip_out_0_eb_r <= s1_cmul1_recip_out_0_nxt;
    end
    if(s1_cmul1_cat_re_0_eb_en0) begin
      s1_cmul1_cat_re_0_eb_r0 <= s1_cmul1_cat_re_0_nxt;
    end
    if(s1_cmul1_cat_re_0_eb_en1) begin
      s1_cmul1_cat_re_0_eb_r1 <= s1_cmul1_cat_re_0_nxt;
    end
    if(s1_cmul1_cat_im_0_eb_en0) begin
      s1_cmul1_cat_im_0_eb_r0 <= s1_cmul1_cat_im_0_nxt;
    end
    if(s1_cmul1_cat_im_0_eb_en1) begin
      s1_cmul1_cat_im_0_eb_r1 <= s1_cmul1_cat_im_0_nxt;
    end
    if(s1_cmul2_recip_norm_0_eb_en) begin
      s1_cmul2_recip_norm_0_eb_r <= s1_cmul2_recip_norm_0_nxt;
    end
    if(s1_cmul2_recip_mul_0_eb_en) begin
      s1_cmul2_recip_mul_0_eb_r <= s1_cmul2_recip_mul_0_nxt;
    end
    if(s1_cmul2_recip_out_0_eb_en) begin
      s1_cmul2_recip_out_0_eb_r <= s1_cmul2_recip_out_0_nxt;
    end
    if(s1_cmul2_cat_re_0_eb_en0) begin
      s1_cmul2_cat_re_0_eb_r0 <= s1_cmul2_cat_re_0_nxt;
    end
    if(s1_cmul2_cat_re_0_eb_en1) begin
      s1_cmul2_cat_re_0_eb_r1 <= s1_cmul2_cat_re_0_nxt;
    end
    if(s1_cmul2_cat_im_0_eb_en0) begin
      s1_cmul2_cat_im_0_eb_r0 <= s1_cmul2_cat_im_0_nxt;
    end
    if(s1_cmul2_cat_im_0_eb_en1) begin
      s1_cmul2_cat_im_0_eb_r1 <= s1_cmul2_cat_im_0_nxt;
    end
    if(s1_cmul3_recip_norm_0_eb_en) begin
      s1_cmul3_recip_norm_0_eb_r <= s1_cmul3_recip_norm_0_nxt;
    end
    if(s1_cmul3_recip_mul_0_eb_en) begin
      s1_cmul3_recip_mul_0_eb_r <= s1_cmul3_recip_mul_0_nxt;
    end
    if(s1_cmul3_recip_out_0_eb_en) begin
      s1_cmul3_recip_out_0_eb_r <= s1_cmul3_recip_out_0_nxt;
    end
    if(s1_cmul3_cat_re_0_eb_en0) begin
      s1_cmul3_cat_re_0_eb_r0 <= s1_cmul3_cat_re_0_nxt;
    end
    if(s1_cmul3_cat_re_0_eb_en1) begin
      s1_cmul3_cat_re_0_eb_r1 <= s1_cmul3_cat_re_0_nxt;
    end
    if(s1_cmul3_cat_im_0_eb_en0) begin
      s1_cmul3_cat_im_0_eb_r0 <= s1_cmul3_cat_im_0_nxt;
    end
    if(s1_cmul3_cat_im_0_eb_en1) begin
      s1_cmul3_cat_im_0_eb_r1 <= s1_cmul3_cat_im_0_nxt;
    end
    if(s0_r4_a0_re_0_eb_en0) begin
      s0_r4_a0_re_0_eb_r0 <= s0_r4_a0_re_0_nxt;
    end
    if(s0_r4_a0_re_0_eb_en1) begin
      s0_r4_a0_re_0_eb_r1 <= s0_r4_a0_re_0_nxt;
    end
    if(s0_r4_a0_im_0_eb_en0) begin
      s0_r4_a0_im_0_eb_r0 <= s0_r4_a0_im_0_nxt;
    end
    if(s0_r4_a0_im_0_eb_en1) begin
      s0_r4_a0_im_0_eb_r1 <= s0_r4_a0_im_0_nxt;
    end
    if(s0_r4_a1_re_0_eb_en0) begin
      s0_r4_a1_re_0_eb_r0 <= s0_r4_a1_re_0_nxt;
    end
    if(s0_r4_a1_re_0_eb_en1) begin
      s0_r4_a1_re_0_eb_r1 <= s0_r4_a1_re_0_nxt;
    end
    if(s0_r4_a1_im_0_eb_en0) begin
      s0_r4_a1_im_0_eb_r0 <= s0_r4_a1_im_0_nxt;
    end
    if(s0_r4_a1_im_0_eb_en1) begin
      s0_r4_a1_im_0_eb_r1 <= s0_r4_a1_im_0_nxt;
    end
    if(s0_r4_a2_re_0_eb_en0) begin
      s0_r4_a2_re_0_eb_r0 <= s0_r4_a2_re_0_nxt;
    end
    if(s0_r4_a2_re_0_eb_en1) begin
      s0_r4_a2_re_0_eb_r1 <= s0_r4_a2_re_0_nxt;
    end
    if(s0_r4_a2_im_0_eb_en0) begin
      s0_r4_a2_im_0_eb_r0 <= s0_r4_a2_im_0_nxt;
    end
    if(s0_r4_a2_im_0_eb_en1) begin
      s0_r4_a2_im_0_eb_r1 <= s0_r4_a2_im_0_nxt;
    end
    if(s0_r4_a3_re_0_eb_en0) begin
      s0_r4_a3_re_0_eb_r0 <= s0_r4_a3_re_0_nxt;
    end
    if(s0_r4_a3_re_0_eb_en1) begin
      s0_r4_a3_re_0_eb_r1 <= s0_r4_a3_re_0_nxt;
    end
    if(s0_r4_a3_im_0_eb_en0) begin
      s0_r4_a3_im_0_eb_r0 <= s0_r4_a3_im_0_nxt;
    end
    if(s0_r4_a3_im_0_eb_en1) begin
      s0_r4_a3_im_0_eb_r1 <= s0_r4_a3_im_0_nxt;
    end
    if(s0_r4_byp0_re_0_eb_en) begin
      s0_r4_byp0_re_0_eb_r <= s0_r4_byp0_re_0_nxt;
    end
    if(s0_r4_byp0_im_0_eb_en) begin
      s0_r4_byp0_im_0_eb_r <= s0_r4_byp0_im_0_nxt;
    end
    if(s0_r4_byp1_re_0_eb_en) begin
      s0_r4_byp1_re_0_eb_r <= s0_r4_byp1_re_0_nxt;
    end
    if(s0_r4_byp1_im_0_eb_en) begin
      s0_r4_byp1_im_0_eb_r <= s0_r4_byp1_im_0_nxt;
    end
    if(s0_r4_byp2_re_0_eb_en) begin
      s0_r4_byp2_re_0_eb_r <= s0_r4_byp2_re_0_nxt;
    end
    if(s0_r4_byp2_im_0_eb_en) begin
      s0_r4_byp2_im_0_eb_r <= s0_r4_byp2_im_0_nxt;
    end
    if(s0_r4_byp3_re_0_eb_en) begin
      s0_r4_byp3_re_0_eb_r <= s0_r4_byp3_re_0_nxt;
    end
    if(s0_r4_byp3_im_0_eb_en) begin
      s0_r4_byp3_im_0_eb_r <= s0_r4_byp3_im_0_nxt;
    end
    if(s1_r4_a0_re_0_eb_en0) begin
      s1_r4_a0_re_0_eb_r0 <= s1_r4_a0_re_0_nxt;
    end
    if(s1_r4_a0_re_0_eb_en1) begin
      s1_r4_a0_re_0_eb_r1 <= s1_r4_a0_re_0_nxt;
    end
    if(s1_r4_a0_im_0_eb_en0) begin
      s1_r4_a0_im_0_eb_r0 <= s1_r4_a0_im_0_nxt;
    end
    if(s1_r4_a0_im_0_eb_en1) begin
      s1_r4_a0_im_0_eb_r1 <= s1_r4_a0_im_0_nxt;
    end
    if(s1_r4_a1_re_0_eb_en0) begin
      s1_r4_a1_re_0_eb_r0 <= s1_r4_a1_re_0_nxt;
    end
    if(s1_r4_a1_re_0_eb_en1) begin
      s1_r4_a1_re_0_eb_r1 <= s1_r4_a1_re_0_nxt;
    end
    if(s1_r4_a1_im_0_eb_en0) begin
      s1_r4_a1_im_0_eb_r0 <= s1_r4_a1_im_0_nxt;
    end
    if(s1_r4_a1_im_0_eb_en1) begin
      s1_r4_a1_im_0_eb_r1 <= s1_r4_a1_im_0_nxt;
    end
    if(s1_r4_a2_re_0_eb_en0) begin
      s1_r4_a2_re_0_eb_r0 <= s1_r4_a2_re_0_nxt;
    end
    if(s1_r4_a2_re_0_eb_en1) begin
      s1_r4_a2_re_0_eb_r1 <= s1_r4_a2_re_0_nxt;
    end
    if(s1_r4_a2_im_0_eb_en0) begin
      s1_r4_a2_im_0_eb_r0 <= s1_r4_a2_im_0_nxt;
    end
    if(s1_r4_a2_im_0_eb_en1) begin
      s1_r4_a2_im_0_eb_r1 <= s1_r4_a2_im_0_nxt;
    end
    if(s1_r4_a3_re_0_eb_en0) begin
      s1_r4_a3_re_0_eb_r0 <= s1_r4_a3_re_0_nxt;
    end
    if(s1_r4_a3_re_0_eb_en1) begin
      s1_r4_a3_re_0_eb_r1 <= s1_r4_a3_re_0_nxt;
    end
    if(s1_r4_a3_im_0_eb_en0) begin
      s1_r4_a3_im_0_eb_r0 <= s1_r4_a3_im_0_nxt;
    end
    if(s1_r4_a3_im_0_eb_en1) begin
      s1_r4_a3_im_0_eb_r1 <= s1_r4_a3_im_0_nxt;
    end
    if(s1_r4_byp0_re_0_eb_en) begin
      s1_r4_byp0_re_0_eb_r <= s1_r4_byp0_re_0_nxt;
    end
    if(s1_r4_byp0_im_0_eb_en) begin
      s1_r4_byp0_im_0_eb_r <= s1_r4_byp0_im_0_nxt;
    end
    if(s1_r4_byp1_re_0_eb_en) begin
      s1_r4_byp1_re_0_eb_r <= s1_r4_byp1_re_0_nxt;
    end
    if(s1_r4_byp1_im_0_eb_en) begin
      s1_r4_byp1_im_0_eb_r <= s1_r4_byp1_im_0_nxt;
    end
    if(s1_r4_byp2_re_0_eb_en) begin
      s1_r4_byp2_re_0_eb_r <= s1_r4_byp2_re_0_nxt;
    end
    if(s1_r4_byp2_im_0_eb_en) begin
      s1_r4_byp2_im_0_eb_r <= s1_r4_byp2_im_0_nxt;
    end
    if(s1_r4_byp3_re_0_eb_en) begin
      s1_r4_byp3_re_0_eb_r <= s1_r4_byp3_re_0_nxt;
    end
    if(s1_r4_byp3_im_0_eb_en) begin
      s1_r4_byp3_im_0_eb_r <= s1_r4_byp3_im_0_nxt;
    end
    if(s0_bs0_re_0_eb_en0) begin
      s0_bs0_re_0_eb_r0 <= s0_bs0_re_0_nxt;
    end
    if(s0_bs0_re_0_eb_en1) begin
      s0_bs0_re_0_eb_r1 <= s0_bs0_re_0_nxt;
    end
    if(s0_bs0_im_0_eb_en0) begin
      s0_bs0_im_0_eb_r0 <= s0_bs0_im_0_nxt;
    end
    if(s0_bs0_im_0_eb_en1) begin
      s0_bs0_im_0_eb_r1 <= s0_bs0_im_0_nxt;
    end
    if(s0_rsat0_re_0_eb_en) begin
      s0_rsat0_re_0_eb_r <= s0_rsat0_re_0_nxt;
    end
    if(s0_rsat0_im_0_eb_en) begin
      s0_rsat0_im_0_eb_r <= s0_rsat0_im_0_nxt;
    end
    if(s0_bs1_re_0_eb_en0) begin
      s0_bs1_re_0_eb_r0 <= s0_bs1_re_0_nxt;
    end
    if(s0_bs1_re_0_eb_en1) begin
      s0_bs1_re_0_eb_r1 <= s0_bs1_re_0_nxt;
    end
    if(s0_bs1_im_0_eb_en0) begin
      s0_bs1_im_0_eb_r0 <= s0_bs1_im_0_nxt;
    end
    if(s0_bs1_im_0_eb_en1) begin
      s0_bs1_im_0_eb_r1 <= s0_bs1_im_0_nxt;
    end
    if(s0_rsat1_re_0_eb_en) begin
      s0_rsat1_re_0_eb_r <= s0_rsat1_re_0_nxt;
    end
    if(s0_rsat1_im_0_eb_en) begin
      s0_rsat1_im_0_eb_r <= s0_rsat1_im_0_nxt;
    end
    if(s0_bs2_re_0_eb_en0) begin
      s0_bs2_re_0_eb_r0 <= s0_bs2_re_0_nxt;
    end
    if(s0_bs2_re_0_eb_en1) begin
      s0_bs2_re_0_eb_r1 <= s0_bs2_re_0_nxt;
    end
    if(s0_bs2_im_0_eb_en0) begin
      s0_bs2_im_0_eb_r0 <= s0_bs2_im_0_nxt;
    end
    if(s0_bs2_im_0_eb_en1) begin
      s0_bs2_im_0_eb_r1 <= s0_bs2_im_0_nxt;
    end
    if(s0_rsat2_re_0_eb_en) begin
      s0_rsat2_re_0_eb_r <= s0_rsat2_re_0_nxt;
    end
    if(s0_rsat2_im_0_eb_en) begin
      s0_rsat2_im_0_eb_r <= s0_rsat2_im_0_nxt;
    end
    if(s0_bs3_re_0_eb_en0) begin
      s0_bs3_re_0_eb_r0 <= s0_bs3_re_0_nxt;
    end
    if(s0_bs3_re_0_eb_en1) begin
      s0_bs3_re_0_eb_r1 <= s0_bs3_re_0_nxt;
    end
    if(s0_bs3_im_0_eb_en0) begin
      s0_bs3_im_0_eb_r0 <= s0_bs3_im_0_nxt;
    end
    if(s0_bs3_im_0_eb_en1) begin
      s0_bs3_im_0_eb_r1 <= s0_bs3_im_0_nxt;
    end
    if(s0_rsat3_re_0_eb_en) begin
      s0_rsat3_re_0_eb_r <= s0_rsat3_re_0_nxt;
    end
    if(s0_rsat3_im_0_eb_en) begin
      s0_rsat3_im_0_eb_r <= s0_rsat3_im_0_nxt;
    end
    if(s1_bs0_re_0_eb_en0) begin
      s1_bs0_re_0_eb_r0 <= s1_bs0_re_0_nxt;
    end
    if(s1_bs0_re_0_eb_en1) begin
      s1_bs0_re_0_eb_r1 <= s1_bs0_re_0_nxt;
    end
    if(s1_bs0_im_0_eb_en0) begin
      s1_bs0_im_0_eb_r0 <= s1_bs0_im_0_nxt;
    end
    if(s1_bs0_im_0_eb_en1) begin
      s1_bs0_im_0_eb_r1 <= s1_bs0_im_0_nxt;
    end
    if(s1_rsat0_re_0_eb_en) begin
      s1_rsat0_re_0_eb_r <= s1_rsat0_re_0_nxt;
    end
    if(s1_rsat0_im_0_eb_en) begin
      s1_rsat0_im_0_eb_r <= s1_rsat0_im_0_nxt;
    end
    if(s1_bs1_re_0_eb_en0) begin
      s1_bs1_re_0_eb_r0 <= s1_bs1_re_0_nxt;
    end
    if(s1_bs1_re_0_eb_en1) begin
      s1_bs1_re_0_eb_r1 <= s1_bs1_re_0_nxt;
    end
    if(s1_bs1_im_0_eb_en0) begin
      s1_bs1_im_0_eb_r0 <= s1_bs1_im_0_nxt;
    end
    if(s1_bs1_im_0_eb_en1) begin
      s1_bs1_im_0_eb_r1 <= s1_bs1_im_0_nxt;
    end
    if(s1_rsat1_re_0_eb_en) begin
      s1_rsat1_re_0_eb_r <= s1_rsat1_re_0_nxt;
    end
    if(s1_rsat1_im_0_eb_en) begin
      s1_rsat1_im_0_eb_r <= s1_rsat1_im_0_nxt;
    end
    if(s1_bs2_re_0_eb_en0) begin
      s1_bs2_re_0_eb_r0 <= s1_bs2_re_0_nxt;
    end
    if(s1_bs2_re_0_eb_en1) begin
      s1_bs2_re_0_eb_r1 <= s1_bs2_re_0_nxt;
    end
    if(s1_bs2_im_0_eb_en0) begin
      s1_bs2_im_0_eb_r0 <= s1_bs2_im_0_nxt;
    end
    if(s1_bs2_im_0_eb_en1) begin
      s1_bs2_im_0_eb_r1 <= s1_bs2_im_0_nxt;
    end
    if(s1_rsat2_re_0_eb_en) begin
      s1_rsat2_re_0_eb_r <= s1_rsat2_re_0_nxt;
    end
    if(s1_rsat2_im_0_eb_en) begin
      s1_rsat2_im_0_eb_r <= s1_rsat2_im_0_nxt;
    end
    if(s1_bs3_re_0_eb_en0) begin
      s1_bs3_re_0_eb_r0 <= s1_bs3_re_0_nxt;
    end
    if(s1_bs3_re_0_eb_en1) begin
      s1_bs3_re_0_eb_r1 <= s1_bs3_re_0_nxt;
    end
    if(s1_bs3_im_0_eb_en0) begin
      s1_bs3_im_0_eb_r0 <= s1_bs3_im_0_nxt;
    end
    if(s1_bs3_im_0_eb_en1) begin
      s1_bs3_im_0_eb_r1 <= s1_bs3_im_0_nxt;
    end
    if(s1_rsat3_re_0_eb_en) begin
      s1_rsat3_re_0_eb_r <= s1_rsat3_re_0_nxt;
    end
    if(s1_rsat3_im_0_eb_en) begin
      s1_rsat3_im_0_eb_r <= s1_rsat3_im_0_nxt;
    end
  end


endmodule

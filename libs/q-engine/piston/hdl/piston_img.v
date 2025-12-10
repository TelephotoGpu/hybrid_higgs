module piston #(
    parameter NODE28_VMEM_SIZE = 4096,
    parameter NODE28_VMEM0 = "vmem0.mif",
    parameter NODE28_VMEM1 = "vmem1.mif",
    parameter NODE28_VMEM2 = "vmem2.mif",
    parameter NODE28_VMEM3 = "vmem3.mif",
    parameter NODE28_VMEM4 = "vmem4.mif",
    parameter NODE28_VMEM5 = "vmem5.mif",
    parameter NODE28_VMEM6 = "vmem6.mif",
    parameter NODE28_VMEM7 = "vmem7.mif",
    parameter NODE28_VMEM8 = "vmem8.mif",
    parameter NODE28_VMEM9 = "vmem9.mif",
    parameter NODE28_VMEM10 = "vmem10.mif",
    parameter NODE28_VMEM11 = "vmem11.mif",
    parameter NODE28_VMEM12 = "vmem12.mif",
    parameter NODE28_VMEM13 = "vmem13.mif",
    parameter NODE28_VMEM14 = "vmem14.mif",
    parameter NODE28_VMEM15 = "vmem15.mif",
    parameter NODE28_VMEM16 = "vmem16.mif",
    parameter NODE28_VMEM17 = "vmem17.mif",
    parameter NODE28_VMEM18 = "vmem18.mif",
    parameter NODE28_VMEM19 = "vmem19.mif",
    parameter NODE28_VMEM20 = "vmem20.mif",
    parameter NODE28_VMEM21 = "vmem21.mif",
    parameter NODE28_VMEM22 = "vmem22.mif",
    parameter NODE28_VMEM23 = "vmem23.mif",
    parameter NODE28_VMEM24 = "vmem24.mif",
    parameter NODE28_VMEM25 = "vmem25.mif",
    parameter NODE28_VMEM26 = "vmem26.mif",
    parameter NODE28_VMEM27 = "vmem27.mif",
    parameter NODE28_VMEM28 = "vmem28.mif",
    parameter NODE28_VMEM29 = "vmem29.mif",
    parameter NODE28_VMEM30 = "vmem30.mif",
    parameter NODE28_VMEM31 = "vmem31.mif"
) (
    // per node (target / initiator)
    input              clk,
    input              reset_n,
    input       [63:0] t_instr_dat,
    input              t_instr_req,
    output             t_instr_ack,
    input       [48:0] t_idma_0_dat,
    input              t_idma_0_req,
    output             t_idma_0_ack,
    input       [48:0] t_idma_1_dat,
    input              t_idma_1_req,
    output             t_idma_1_ack,
    input       [48:0] t_idma_2_dat,
    input              t_idma_2_req,
    output             t_idma_2_ack,
    input       [48:0] t_idma_3_dat,
    input              t_idma_3_req,
    output             t_idma_3_ack,
    output      [31:0] i_odma_0_dat,
    output             i_odma_0_req,
    input              i_odma_0_ack,
    output      [31:0] i_odma_1_dat,
    output             i_odma_1_req,
    input              i_odma_1_ack,
    output      [31:0] i_odma_2_dat,
    output             i_odma_2_req,
    input              i_odma_2_ack,
    output      [31:0] i_odma_3_dat,
    output             i_odma_3_req,
    input              i_odma_3_ack
);
// per edge
wire      [63:0] dat0, dat0_nxt;
wire      [63:0] dat1, dat1_nxt;
wire      [63:0] dat2, dat2_nxt;
wire      [63:0] dat3, dat3_nxt;
wire      [63:0] dat4, dat4_nxt;
wire      [63:0] dat5, dat5_nxt;
wire      [63:0] dat6, dat6_nxt;
wire      [63:0] dat7, dat7_nxt;
wire      [63:0] dat8, dat8_nxt;
wire      [63:0] dat9, dat9_nxt;
wire      [63:0] dat10, dat10_nxt;
wire      [63:0] dat11, dat11_nxt;
wire      [63:0] dat12, dat12_nxt;
wire      [63:0] dat13, dat13_nxt;
wire      [63:0] dat14, dat14_nxt;
wire      [63:0] dat15, dat15_nxt;
wire      [63:0] dat16, dat16_nxt;
wire      [63:0] dat17, dat17_nxt;
wire      [63:0] dat18, dat18_nxt;
wire      [63:0] dat19, dat19_nxt;
wire      [63:0] dat20, dat20_nxt;
wire      [63:0] dat21, dat21_nxt;
wire      [63:0] dat22, dat22_nxt;
wire      [63:0] dat23, dat23_nxt;
wire      [63:0] dat24, dat24_nxt;
wire      [63:0] dat25, dat25_nxt;
wire      [63:0] dat26, dat26_nxt;
wire      [63:0] dat27, dat27_nxt;
wire      [63:0] dat28, dat28_nxt;
wire      [63:0] dat29, dat29_nxt;
wire      [63:0] dat30, dat30_nxt;
wire     [511:0] dat31, dat31_nxt;
wire     [511:0] dat32, dat32_nxt;
wire     [511:0] dat33, dat33_nxt;
wire     [511:0] dat34;
wire     [511:0] dat35, dat35_nxt;
wire     [511:0] dat36, dat36_nxt;
wire     [511:0] dat37, dat37_nxt;
wire     [511:0] dat38, dat38_nxt;
wire     [511:0] dat39, dat39_nxt;
wire     [511:0] dat40, dat40_nxt;
wire     [511:0] dat41, dat41_nxt;
wire     [511:0] dat42, dat42_nxt;
wire     [263:0] dat43, dat43_nxt;
wire      [67:0] dat44, dat44_nxt;
wire     [195:0] dat45, dat45_nxt;
wire     [195:0] dat46, dat46_nxt;
wire       [3:0] dat47, dat47_nxt;
wire      [67:0] dat48, dat48_nxt;
wire       [3:0] dat49, dat49_nxt;
wire      [67:0] dat50, dat50_nxt;
wire      [67:0] dat51, dat51_nxt;
wire      [48:0] dat52, dat52_nxt;
wire      [48:0] dat53, dat53_nxt;
wire      [48:0] dat54, dat54_nxt;
wire      [48:0] dat55, dat55_nxt;
wire      [48:0] dat56, dat56_nxt;
wire      [31:0] dat57, dat57_nxt;
wire      [31:0] dat58, dat58_nxt;
wire      [31:0] dat59, dat59_nxt;
wire      [31:0] dat60, dat60_nxt;
wire      [31:0] dat61, dat61_nxt;
wire      [31:0] dat62, dat62_nxt;
// per node
// node:0 is target port
assign dat0_nxt = t_instr_dat;

// node:1 equality
assign dat1_nxt = dat0;

// node:2 equality
assign dat2_nxt = dat0;

// node:3 equality
assign dat3_nxt = dat1;

// node:4 equality
assign dat4_nxt = dat1;

// node:5 equality
assign dat5_nxt = dat2;

// node:6 equality
assign dat6_nxt = dat2;

// node:7 equality
assign dat7_nxt = dat3;

// node:8 equality
assign dat10_nxt = dat3;

// node:9 equality
assign dat13_nxt = dat4;

// node:10 equality
assign dat16_nxt = dat4;

// node:11 equality
assign dat19_nxt = dat5;

// node:12 equality
assign dat22_nxt = dat5;

// node:13 equality
assign dat25_nxt = dat6;

// node:14 equality
assign dat28_nxt = dat6;

// node:15 is target port
assign dat52_nxt = t_idma_0_dat;

// node:16 is target port
assign dat53_nxt = t_idma_1_dat;

// node:17 equality
assign dat54_nxt = dat53;

// node:18 is target port
assign dat55_nxt = t_idma_2_dat;

// node:19 is target port
assign dat56_nxt = t_idma_3_dat;

// node:20 is initiator port
assign i_odma_0_dat = dat57;

// node:21 is initiator port
assign i_odma_1_dat = dat59;

// node:22 equality
assign dat59_nxt = dat58;

// node:23 is initiator port
assign i_odma_2_dat = dat61;

// node:24 equality
assign dat61_nxt = dat60;

// node:25 is initiator port
assign i_odma_3_dat = dat62;

// node:26 macro vector
wire             instr_0_valid26;
wire             instr_0_ready26;
wire             instr_1_valid26;
wire             instr_1_ready26;
wire             instr_2_valid26;
wire             instr_2_ready26;
wire             instr_3_valid26;
wire             instr_3_ready26;
wire             instr_4_valid26;
wire             instr_4_ready26;
wire             instr_5_valid26;
wire             instr_5_ready26;
wire             instr_6_valid26;
wire             instr_6_ready26;
wire             instr_7_valid26;
wire             instr_7_ready26;
wire             instr_8_valid26;
wire             instr_8_ready26;
wire             instr_9_valid26;
wire             instr_9_ready26;
wire             instr_10_valid26;
wire             instr_10_ready26;
wire             instr_11_valid26;
wire             instr_11_ready26;
wire             instr_12_valid26;
wire             instr_12_ready26;
wire             instr_13_valid26;
wire             instr_13_ready26;
wire             instr_14_valid26;
wire             instr_14_ready26;
wire             instr_15_valid26;
wire             instr_15_ready26;
wire             tk15_valid26;
wire             tk15_ready26;
wire             ik15_valid26;
wire             ik15_ready26;
wire             kap_valid26;
wire             kap_ready26;
vector_dat_17_2 unode26 (
    .t_instr_0_dat(dat8),
    .t_instr_1_dat(dat9),
    .t_instr_2_dat(dat11),
    .t_instr_3_dat(dat12),
    .t_instr_4_dat(dat14),
    .t_instr_5_dat(dat15),
    .t_instr_6_dat(dat17),
    .t_instr_7_dat(dat18),
    .t_instr_8_dat(dat20),
    .t_instr_9_dat(dat21),
    .t_instr_10_dat(dat23),
    .t_instr_11_dat(dat24),
    .t_instr_12_dat(dat26),
    .t_instr_13_dat(dat27),
    .t_instr_14_dat(dat29),
    .t_instr_15_dat(dat30),
    .t_k15_dat(dat37),
    .i_k15_dat(dat31_nxt),
    .i_kap_dat(dat43_nxt),
    .instr_0_valid(instr_0_valid26),
    .instr_0_ready(instr_0_ready26),
    .instr_1_valid(instr_1_valid26),
    .instr_1_ready(instr_1_ready26),
    .instr_2_valid(instr_2_valid26),
    .instr_2_ready(instr_2_ready26),
    .instr_3_valid(instr_3_valid26),
    .instr_3_ready(instr_3_ready26),
    .instr_4_valid(instr_4_valid26),
    .instr_4_ready(instr_4_ready26),
    .instr_5_valid(instr_5_valid26),
    .instr_5_ready(instr_5_ready26),
    .instr_6_valid(instr_6_valid26),
    .instr_6_ready(instr_6_ready26),
    .instr_7_valid(instr_7_valid26),
    .instr_7_ready(instr_7_ready26),
    .instr_8_valid(instr_8_valid26),
    .instr_8_ready(instr_8_ready26),
    .instr_9_valid(instr_9_valid26),
    .instr_9_ready(instr_9_ready26),
    .instr_10_valid(instr_10_valid26),
    .instr_10_ready(instr_10_ready26),
    .instr_11_valid(instr_11_valid26),
    .instr_11_ready(instr_11_ready26),
    .instr_12_valid(instr_12_valid26),
    .instr_12_ready(instr_12_ready26),
    .instr_13_valid(instr_13_valid26),
    .instr_13_ready(instr_13_ready26),
    .instr_14_valid(instr_14_valid26),
    .instr_14_ready(instr_14_ready26),
    .instr_15_valid(instr_15_valid26),
    .instr_15_ready(instr_15_ready26),
    .tk15_valid(tk15_valid26),
    .tk15_ready(tk15_ready26),
    .ik15_valid(ik15_valid26),
    .ik15_ready(ik15_ready26),
    .kap_valid(kap_valid26),
    .kap_ready(kap_ready26),
    .clk(clk),
    .reset_n(reset_n)
);
// node:27 macro inmux
wire       [3:0] sel2750;
inmux_dat_4_1 unode27 (
    .t_k15_dat(dat31),
    .t_k13_dat(dat41),
    .t_k1_dat(dat42),
    .t_c_dat(dat47),
    .i_inmux_dat(dat32_nxt),
    .sel(sel2750),
    .clk(clk),
    .reset_n(reset_n)
);
// node:28 macro vmem
wire       [3:0] idma_valid28;
wire       [3:0] idma_ready28;
wire       [3:0] odma_valid28;
wire       [3:0] odma_ready28;
wire             tvs_valid28;
wire             tvs_ready28;
wire             ivs_valid28;
wire             ivs_ready28;
wire       [3:0] k_ctrl28;
`ifdef HIGGS_FPGA_XILINX
vmem_dat_6_5_1_1 #(
`else
vmem_dat_6_5 #(
`endif
    .VMEM_SIZE(NODE28_VMEM_SIZE),
    .VMEM0(NODE28_VMEM0),
    .VMEM1(NODE28_VMEM1),
    .VMEM2(NODE28_VMEM2),
    .VMEM3(NODE28_VMEM3),
    .VMEM4(NODE28_VMEM4),
    .VMEM5(NODE28_VMEM5),
    .VMEM6(NODE28_VMEM6),
    .VMEM7(NODE28_VMEM7),
    .VMEM8(NODE28_VMEM8),
    .VMEM9(NODE28_VMEM9),
    .VMEM10(NODE28_VMEM10),
    .VMEM11(NODE28_VMEM11),
    .VMEM12(NODE28_VMEM12),
    .VMEM13(NODE28_VMEM13),
    .VMEM14(NODE28_VMEM14),
    .VMEM15(NODE28_VMEM15),
    .VMEM16(NODE28_VMEM16),
    .VMEM17(NODE28_VMEM17),
    .VMEM18(NODE28_VMEM18),
    .VMEM19(NODE28_VMEM19),
    .VMEM20(NODE28_VMEM20),
    .VMEM21(NODE28_VMEM21),
    .VMEM22(NODE28_VMEM22),
    .VMEM23(NODE28_VMEM23),
    .VMEM24(NODE28_VMEM24),
    .VMEM25(NODE28_VMEM25),
    .VMEM26(NODE28_VMEM26),
    .VMEM27(NODE28_VMEM27),
    .VMEM28(NODE28_VMEM28),
    .VMEM29(NODE28_VMEM29),
    .VMEM30(NODE28_VMEM30),
    .VMEM31(NODE28_VMEM31)
) unode28 (
    .t_ivs_dat(dat33),
    .t_ka_dat(dat46),
    .t_idma_0_dat(dat52),
    .t_idma_1_dat(dat54),
    .t_idma_2_dat(dat55),
    .t_idma_3_dat(dat56),
    .i_ovs_dat(dat34),
    .i_odma_0_dat(dat57_nxt),
    .i_odma_1_dat(dat58_nxt),
    .i_odma_2_dat(dat60_nxt),
    .i_odma_3_dat(dat62_nxt),
    .idma_valid(idma_valid28),
    .idma_ready(idma_ready28),
    .odma_valid(odma_valid28),
    .odma_ready(odma_ready28),
    .tvs_valid(tvs_valid28),
    .tvs_ready(tvs_ready28),
    .ivs_valid(ivs_valid28),
    .ivs_ready(ivs_ready28),
    .k_ctrl(k_ctrl28),
    .clk(clk),
    .reset_n(reset_n)
);
// node:29 macro oumux
wire       [3:0] sel2950;
oumux_dat_2_5 unode29 (
    .t_oumux_dat(dat36),
    .t_c_dat(dat49),
    .i_k15_dat(dat37_nxt),
    .i_k8_dat(dat38_nxt),
    .i_k9_dat(dat39_nxt),
    .i_k14_dat(dat40_nxt),
    .i_k13_dat(dat41_nxt),
    .sel(sel2950),
    .clk(clk),
    .reset_n(reset_n)
);
// node:30 macro deconcat
assign {dat45_nxt, dat44_nxt} = dat43[263:0];
// node:31 macro perm_full_addr

perm_full_addr_dat_1_1 unode31 (
    .t_0_dat(dat44),
    .i_0_dat(dat48_nxt),
    .clk(clk),
    .reset_n(reset_n)
);
// node:32 macro perm_full_data

perm_full_data_dat_2_1 unode32 (
    .t_data_dat(dat32),
    .t_addr_dat(dat50),
    .i_data_dat(dat33_nxt),
    .clk(clk),
    .reset_n(reset_n)
);
// node:33 macro perm_full_data

perm_full_data_dat_2_1 unode33 (
    .t_data_dat(dat35),
    .t_addr_dat(dat51),
    .i_data_dat(dat36_nxt),
    .clk(clk),
    .reset_n(reset_n)
);
// node:34 macro ka_decode
wire       [3:0] k_ctrl34;
ka_decode_dat_1_3 unode34 (
    .t_ka_dat(dat45),
    .i_ka_dat(dat46_nxt),
    .i_k_sk_dat(dat47_nxt),
    .i_k_lk_dat(dat49_nxt),
    .k_ctrl(k_ctrl34),
    .clk(clk),
    .reset_n(reset_n)
);
// node:35 macro p_decode
wire       [3:0] k_ctrl35;
p_decode_dat_1_2 unode35 (
    .t_kp_dat(dat48),
    .i_p_sk_dat(dat50_nxt),
    .i_p_lk_dat(dat51_nxt),
    .k_ctrl(k_ctrl35),
    .clk(clk),
    .reset_n(reset_n)
);
// node:36 equality
assign dat35_nxt = dat34;

// node:37 equality
assign dat8_nxt = dat7;

// node:38 equality
assign dat9_nxt = dat7;

// node:39 equality
assign dat11_nxt = dat10;

// node:40 equality
assign dat12_nxt = dat10;

// node:41 equality
assign dat14_nxt = dat13;

// node:42 equality
assign dat15_nxt = dat13;

// node:43 equality
assign dat17_nxt = dat16;

// node:44 equality
assign dat18_nxt = dat16;

// node:45 equality
assign dat20_nxt = dat19;

// node:46 equality
assign dat21_nxt = dat19;

// node:47 equality
assign dat23_nxt = dat22;

// node:48 equality
assign dat24_nxt = dat22;

// node:49 equality
assign dat26_nxt = dat25;

// node:50 equality
assign dat27_nxt = dat25;

// node:51 equality
assign dat29_nxt = dat28;

// node:52 equality
assign dat30_nxt = dat28;

// node:53 macro img_datapath

wire n53_k8_req;
wire n53_k8_ack;
wire n53_k9_req;
wire n53_k9_ack;
wire n53_k14_req;
wire n53_k14_ack;
wire n53_k1_req;
wire n53_k1_ack;
img_datapath unode53 (
    .clk(clk),
    .reset_n(reset_n),
    .t_k8_dat(dat38),
    .t_k8_req(n53_k8_req),
    .t_k8_ack(n53_k8_ack),
    .t_k9_dat(dat39),
    .t_k9_req(n53_k9_req),
    .t_k9_ack(n53_k9_ack),
    .t_k14_dat(dat40),
    .t_k14_req(n53_k14_req),
    .t_k14_ack(n53_k14_ack),
    .i_k1_dat(dat42_nxt),
    .i_k1_req(n53_k1_req),
    .i_k1_ack(n53_k1_ack)
);

// per edge

// edge:0 EB1.5
wire en0_0, en0_1, sel0;
reg [63:0] dat0_r0, dat0_r1;
always @(posedge clk) if (en0_0) dat0_r0 <= dat0_nxt;
always @(posedge clk) if (en0_1) dat0_r1 <= dat0_nxt;

assign dat0 = sel0 ? dat0_r1 : dat0_r0;


// edge:1 EB1.5
wire en1_0, en1_1, sel1;
reg [63:0] dat1_r0, dat1_r1;
always @(posedge clk) if (en1_0) dat1_r0 <= dat1_nxt;
always @(posedge clk) if (en1_1) dat1_r1 <= dat1_nxt;

assign dat1 = sel1 ? dat1_r1 : dat1_r0;


// edge:2 EB1.5
wire en2_0, en2_1, sel2;
reg [63:0] dat2_r0, dat2_r1;
always @(posedge clk) if (en2_0) dat2_r0 <= dat2_nxt;
always @(posedge clk) if (en2_1) dat2_r1 <= dat2_nxt;

assign dat2 = sel2 ? dat2_r1 : dat2_r0;


// edge:3 EB1.5
wire en3_0, en3_1, sel3;
reg [63:0] dat3_r0, dat3_r1;
always @(posedge clk) if (en3_0) dat3_r0 <= dat3_nxt;
always @(posedge clk) if (en3_1) dat3_r1 <= dat3_nxt;

assign dat3 = sel3 ? dat3_r1 : dat3_r0;


// edge:4 EB1.5
wire en4_0, en4_1, sel4;
reg [63:0] dat4_r0, dat4_r1;
always @(posedge clk) if (en4_0) dat4_r0 <= dat4_nxt;
always @(posedge clk) if (en4_1) dat4_r1 <= dat4_nxt;

assign dat4 = sel4 ? dat4_r1 : dat4_r0;


// edge:5 EB1.5
wire en5_0, en5_1, sel5;
reg [63:0] dat5_r0, dat5_r1;
always @(posedge clk) if (en5_0) dat5_r0 <= dat5_nxt;
always @(posedge clk) if (en5_1) dat5_r1 <= dat5_nxt;

assign dat5 = sel5 ? dat5_r1 : dat5_r0;


// edge:6 EB1.5
wire en6_0, en6_1, sel6;
reg [63:0] dat6_r0, dat6_r1;
always @(posedge clk) if (en6_0) dat6_r0 <= dat6_nxt;
always @(posedge clk) if (en6_1) dat6_r1 <= dat6_nxt;

assign dat6 = sel6 ? dat6_r1 : dat6_r0;


// edge:7 EB1.5
wire en7_0, en7_1, sel7;
reg [63:0] dat7_r0, dat7_r1;
always @(posedge clk) if (en7_0) dat7_r0 <= dat7_nxt;
always @(posedge clk) if (en7_1) dat7_r1 <= dat7_nxt;

assign dat7 = sel7 ? dat7_r1 : dat7_r0;


// edge:8 EB1.5
wire en8_0, en8_1, sel8;
reg [63:0] dat8_r0, dat8_r1;
always @(posedge clk) if (en8_0) dat8_r0 <= dat8_nxt;
always @(posedge clk) if (en8_1) dat8_r1 <= dat8_nxt;

assign dat8 = sel8 ? dat8_r1 : dat8_r0;


// edge:9 EB1.5
wire en9_0, en9_1, sel9;
reg [63:0] dat9_r0, dat9_r1;
always @(posedge clk) if (en9_0) dat9_r0 <= dat9_nxt;
always @(posedge clk) if (en9_1) dat9_r1 <= dat9_nxt;

assign dat9 = sel9 ? dat9_r1 : dat9_r0;


// edge:10 EB1.5
wire en10_0, en10_1, sel10;
reg [63:0] dat10_r0, dat10_r1;
always @(posedge clk) if (en10_0) dat10_r0 <= dat10_nxt;
always @(posedge clk) if (en10_1) dat10_r1 <= dat10_nxt;

assign dat10 = sel10 ? dat10_r1 : dat10_r0;


// edge:11 EB1.5
wire en11_0, en11_1, sel11;
reg [63:0] dat11_r0, dat11_r1;
always @(posedge clk) if (en11_0) dat11_r0 <= dat11_nxt;
always @(posedge clk) if (en11_1) dat11_r1 <= dat11_nxt;

assign dat11 = sel11 ? dat11_r1 : dat11_r0;


// edge:12 EB1.5
wire en12_0, en12_1, sel12;
reg [63:0] dat12_r0, dat12_r1;
always @(posedge clk) if (en12_0) dat12_r0 <= dat12_nxt;
always @(posedge clk) if (en12_1) dat12_r1 <= dat12_nxt;

assign dat12 = sel12 ? dat12_r1 : dat12_r0;


// edge:13 EB1.5
wire en13_0, en13_1, sel13;
reg [63:0] dat13_r0, dat13_r1;
always @(posedge clk) if (en13_0) dat13_r0 <= dat13_nxt;
always @(posedge clk) if (en13_1) dat13_r1 <= dat13_nxt;

assign dat13 = sel13 ? dat13_r1 : dat13_r0;


// edge:14 EB1.5
wire en14_0, en14_1, sel14;
reg [63:0] dat14_r0, dat14_r1;
always @(posedge clk) if (en14_0) dat14_r0 <= dat14_nxt;
always @(posedge clk) if (en14_1) dat14_r1 <= dat14_nxt;

assign dat14 = sel14 ? dat14_r1 : dat14_r0;


// edge:15 EB1.5
wire en15_0, en15_1, sel15;
reg [63:0] dat15_r0, dat15_r1;
always @(posedge clk) if (en15_0) dat15_r0 <= dat15_nxt;
always @(posedge clk) if (en15_1) dat15_r1 <= dat15_nxt;

assign dat15 = sel15 ? dat15_r1 : dat15_r0;


// edge:16 EB1.5
wire en16_0, en16_1, sel16;
reg [63:0] dat16_r0, dat16_r1;
always @(posedge clk) if (en16_0) dat16_r0 <= dat16_nxt;
always @(posedge clk) if (en16_1) dat16_r1 <= dat16_nxt;

assign dat16 = sel16 ? dat16_r1 : dat16_r0;


// edge:17 EB1.5
wire en17_0, en17_1, sel17;
reg [63:0] dat17_r0, dat17_r1;
always @(posedge clk) if (en17_0) dat17_r0 <= dat17_nxt;
always @(posedge clk) if (en17_1) dat17_r1 <= dat17_nxt;

assign dat17 = sel17 ? dat17_r1 : dat17_r0;


// edge:18 EB1.5
wire en18_0, en18_1, sel18;
reg [63:0] dat18_r0, dat18_r1;
always @(posedge clk) if (en18_0) dat18_r0 <= dat18_nxt;
always @(posedge clk) if (en18_1) dat18_r1 <= dat18_nxt;

assign dat18 = sel18 ? dat18_r1 : dat18_r0;


// edge:19 EB1.5
wire en19_0, en19_1, sel19;
reg [63:0] dat19_r0, dat19_r1;
always @(posedge clk) if (en19_0) dat19_r0 <= dat19_nxt;
always @(posedge clk) if (en19_1) dat19_r1 <= dat19_nxt;

assign dat19 = sel19 ? dat19_r1 : dat19_r0;


// edge:20 EB1.5
wire en20_0, en20_1, sel20;
reg [63:0] dat20_r0, dat20_r1;
always @(posedge clk) if (en20_0) dat20_r0 <= dat20_nxt;
always @(posedge clk) if (en20_1) dat20_r1 <= dat20_nxt;

assign dat20 = sel20 ? dat20_r1 : dat20_r0;


// edge:21 EB1.5
wire en21_0, en21_1, sel21;
reg [63:0] dat21_r0, dat21_r1;
always @(posedge clk) if (en21_0) dat21_r0 <= dat21_nxt;
always @(posedge clk) if (en21_1) dat21_r1 <= dat21_nxt;

assign dat21 = sel21 ? dat21_r1 : dat21_r0;


// edge:22 EB1.5
wire en22_0, en22_1, sel22;
reg [63:0] dat22_r0, dat22_r1;
always @(posedge clk) if (en22_0) dat22_r0 <= dat22_nxt;
always @(posedge clk) if (en22_1) dat22_r1 <= dat22_nxt;

assign dat22 = sel22 ? dat22_r1 : dat22_r0;


// edge:23 EB1.5
wire en23_0, en23_1, sel23;
reg [63:0] dat23_r0, dat23_r1;
always @(posedge clk) if (en23_0) dat23_r0 <= dat23_nxt;
always @(posedge clk) if (en23_1) dat23_r1 <= dat23_nxt;

assign dat23 = sel23 ? dat23_r1 : dat23_r0;


// edge:24 EB1.5
wire en24_0, en24_1, sel24;
reg [63:0] dat24_r0, dat24_r1;
always @(posedge clk) if (en24_0) dat24_r0 <= dat24_nxt;
always @(posedge clk) if (en24_1) dat24_r1 <= dat24_nxt;

assign dat24 = sel24 ? dat24_r1 : dat24_r0;


// edge:25 EB1.5
wire en25_0, en25_1, sel25;
reg [63:0] dat25_r0, dat25_r1;
always @(posedge clk) if (en25_0) dat25_r0 <= dat25_nxt;
always @(posedge clk) if (en25_1) dat25_r1 <= dat25_nxt;

assign dat25 = sel25 ? dat25_r1 : dat25_r0;


// edge:26 EB1.5
wire en26_0, en26_1, sel26;
reg [63:0] dat26_r0, dat26_r1;
always @(posedge clk) if (en26_0) dat26_r0 <= dat26_nxt;
always @(posedge clk) if (en26_1) dat26_r1 <= dat26_nxt;

assign dat26 = sel26 ? dat26_r1 : dat26_r0;


// edge:27 EB1.5
wire en27_0, en27_1, sel27;
reg [63:0] dat27_r0, dat27_r1;
always @(posedge clk) if (en27_0) dat27_r0 <= dat27_nxt;
always @(posedge clk) if (en27_1) dat27_r1 <= dat27_nxt;

assign dat27 = sel27 ? dat27_r1 : dat27_r0;


// edge:28 EB1.5
wire en28_0, en28_1, sel28;
reg [63:0] dat28_r0, dat28_r1;
always @(posedge clk) if (en28_0) dat28_r0 <= dat28_nxt;
always @(posedge clk) if (en28_1) dat28_r1 <= dat28_nxt;

assign dat28 = sel28 ? dat28_r1 : dat28_r0;


// edge:29 EB1.5
wire en29_0, en29_1, sel29;
reg [63:0] dat29_r0, dat29_r1;
always @(posedge clk) if (en29_0) dat29_r0 <= dat29_nxt;
always @(posedge clk) if (en29_1) dat29_r1 <= dat29_nxt;

assign dat29 = sel29 ? dat29_r1 : dat29_r0;


// edge:30 EB1.5
wire en30_0, en30_1, sel30;
reg [63:0] dat30_r0, dat30_r1;
always @(posedge clk) if (en30_0) dat30_r0 <= dat30_nxt;
always @(posedge clk) if (en30_1) dat30_r1 <= dat30_nxt;

assign dat30 = sel30 ? dat30_r1 : dat30_r0;


// edge:31 EB1.5
wire en31_0, en31_1, sel31;
reg [511:0] dat31_r0, dat31_r1;
always @(posedge clk) if (en31_0) dat31_r0 <= dat31_nxt;
always @(posedge clk) if (en31_1) dat31_r1 <= dat31_nxt;

assign dat31 = sel31 ? dat31_r1 : dat31_r0;


// edge:32 EB1
wire en32;
reg [511:0] dat32_r;
always @(posedge clk) if (en32) dat32_r <= dat32_nxt;
assign dat32 = dat32_r;


// edge:33 EB1
wire en33;
reg [511:0] dat33_r;
always @(posedge clk) if (en33) dat33_r <= dat33_nxt;
assign dat33 = dat33_r;


// edge:34 EB0


// edge:35 EB1
wire en35;
reg [511:0] dat35_r;
always @(posedge clk) if (en35) dat35_r <= dat35_nxt;
assign dat35 = dat35_r;


// edge:36 EB1.5
wire en36_0, en36_1, sel36;
reg [511:0] dat36_r0, dat36_r1;
always @(posedge clk) if (en36_0) dat36_r0 <= dat36_nxt;
always @(posedge clk) if (en36_1) dat36_r1 <= dat36_nxt;

assign dat36 = sel36 ? dat36_r1 : dat36_r0;


// edge:37 EB1.5
wire en37_0, en37_1, sel37;
reg [511:0] dat37_r0, dat37_r1;
always @(posedge clk) if (en37_0) dat37_r0 <= dat37_nxt;
always @(posedge clk) if (en37_1) dat37_r1 <= dat37_nxt;

assign dat37 = sel37 ? dat37_r1 : dat37_r0;


// edge:38 EB1.5
wire en38_0, en38_1, sel38;
reg [511:0] dat38_r0, dat38_r1;
always @(posedge clk) if (en38_0) dat38_r0 <= dat38_nxt;
always @(posedge clk) if (en38_1) dat38_r1 <= dat38_nxt;

assign dat38 = sel38 ? dat38_r1 : dat38_r0;


// edge:39 EB1.5
wire en39_0, en39_1, sel39;
reg [511:0] dat39_r0, dat39_r1;
always @(posedge clk) if (en39_0) dat39_r0 <= dat39_nxt;
always @(posedge clk) if (en39_1) dat39_r1 <= dat39_nxt;

assign dat39 = sel39 ? dat39_r1 : dat39_r0;


// edge:40 EB1
wire en40;
reg [511:0] dat40_r;
always @(posedge clk) if (en40) dat40_r <= dat40_nxt;
assign dat40 = dat40_r;


// edge:41 EB_FIFO Depth=4
reg [511:0] mem41 [3:0];
reg [511:0] dat41_r0;
wire ren41, wen41;
wire [1:0] wr_ptr41, rd_ptr41;

always @(posedge clk) if (ren41) dat41_r0 <= mem41[rd_ptr41];
always @(posedge clk) if (wen41) mem41[wr_ptr41] <= dat41_nxt;

assign dat41 = dat41_r0;


// edge:42 EB1.5
wire en42_0, en42_1, sel42;
reg [511:0] dat42_r0, dat42_r1;
always @(posedge clk) if (en42_0) dat42_r0 <= dat42_nxt;
always @(posedge clk) if (en42_1) dat42_r1 <= dat42_nxt;

assign dat42 = sel42 ? dat42_r1 : dat42_r0;


// edge:43 EB1.5
wire en43_0, en43_1, sel43;
reg [263:0] dat43_r0, dat43_r1;
always @(posedge clk) if (en43_0) dat43_r0 <= dat43_nxt;
always @(posedge clk) if (en43_1) dat43_r1 <= dat43_nxt;

assign dat43 = sel43 ? dat43_r1 : dat43_r0;


// edge:44 EB1
wire en44;
reg [67:0] dat44_r;
always @(posedge clk) if (en44) dat44_r <= dat44_nxt;
assign dat44 = dat44_r;


// edge:45 EB1
wire en45;
reg [195:0] dat45_r;
always @(posedge clk) if (en45) dat45_r <= dat45_nxt;
assign dat45 = dat45_r;


// edge:46 EB_FIFO Depth=4
reg [195:0] mem46 [3:0];
reg [195:0] dat46_r0;
wire ren46, wen46;
wire [1:0] wr_ptr46, rd_ptr46;

always @(posedge clk) if (ren46) dat46_r0 <= mem46[rd_ptr46];
always @(posedge clk) if (wen46) mem46[wr_ptr46] <= dat46_nxt;

assign dat46 = dat46_r0;


// edge:47 EB_FIFO Depth=2
reg [3:0] mem47 [1:0];
reg [3:0] dat47_r0;
wire ren47, wen47;
wire [0:0] wr_ptr47, rd_ptr47;

always @(posedge clk) if (ren47) dat47_r0 <= mem47[rd_ptr47];
always @(posedge clk) if (wen47) mem47[wr_ptr47] <= dat47_nxt;

assign dat47 = dat47_r0;


// edge:48 EB1
wire en48;
reg [67:0] dat48_r;
always @(posedge clk) if (en48) dat48_r <= dat48_nxt;
assign dat48 = dat48_r;


// edge:49 EB_FIFO Depth=4
reg [3:0] mem49 [3:0];
reg [3:0] dat49_r0;
wire ren49, wen49;
wire [1:0] wr_ptr49, rd_ptr49;

always @(posedge clk) if (ren49) dat49_r0 <= mem49[rd_ptr49];
always @(posedge clk) if (wen49) mem49[wr_ptr49] <= dat49_nxt;

assign dat49 = dat49_r0;


// edge:50 EB_FIFO Depth=3
reg [67:0] mem50 [2:0];
reg [67:0] dat50_r0;
wire ren50, wen50;
wire [1:0] wr_ptr50, rd_ptr50;

always @(posedge clk) if (ren50) dat50_r0 <= mem50[rd_ptr50];
always @(posedge clk) if (wen50) mem50[wr_ptr50] <= dat50_nxt;

assign dat50 = dat50_r0;


// edge:51 EB_FIFO Depth=3
reg [67:0] mem51 [2:0];
reg [67:0] dat51_r0;
wire ren51, wen51;
wire [1:0] wr_ptr51, rd_ptr51;

always @(posedge clk) if (ren51) dat51_r0 <= mem51[rd_ptr51];
always @(posedge clk) if (wen51) mem51[wr_ptr51] <= dat51_nxt;

assign dat51 = dat51_r0;


// edge:52 EB1.5
wire en52_0, en52_1, sel52;
reg [48:0] dat52_r0, dat52_r1;
always @(posedge clk) if (en52_0) dat52_r0 <= dat52_nxt;
always @(posedge clk) if (en52_1) dat52_r1 <= dat52_nxt;

assign dat52 = sel52 ? dat52_r1 : dat52_r0;


// edge:53 EB1.5
wire en53_0, en53_1, sel53;
reg [48:0] dat53_r0, dat53_r1;
always @(posedge clk) if (en53_0) dat53_r0 <= dat53_nxt;
always @(posedge clk) if (en53_1) dat53_r1 <= dat53_nxt;

assign dat53 = sel53 ? dat53_r1 : dat53_r0;


// edge:54 EB1.5
wire en54_0, en54_1, sel54;
reg [48:0] dat54_r0, dat54_r1;
always @(posedge clk) if (en54_0) dat54_r0 <= dat54_nxt;
always @(posedge clk) if (en54_1) dat54_r1 <= dat54_nxt;

assign dat54 = sel54 ? dat54_r1 : dat54_r0;


// edge:55 EB1.5
wire en55_0, en55_1, sel55;
reg [48:0] dat55_r0, dat55_r1;
always @(posedge clk) if (en55_0) dat55_r0 <= dat55_nxt;
always @(posedge clk) if (en55_1) dat55_r1 <= dat55_nxt;

assign dat55 = sel55 ? dat55_r1 : dat55_r0;


// edge:56 EB1.5
wire en56_0, en56_1, sel56;
reg [48:0] dat56_r0, dat56_r1;
always @(posedge clk) if (en56_0) dat56_r0 <= dat56_nxt;
always @(posedge clk) if (en56_1) dat56_r1 <= dat56_nxt;

assign dat56 = sel56 ? dat56_r1 : dat56_r0;


// edge:57 EB1.7
wire en57_0, en57_1, sel57;
reg [31:0] dat57_r0, dat57_r1;
wire [31:0] dat57_r0_nxt;
assign dat57_r0_nxt = sel57 ? dat57_r1 : dat57_nxt;

always @(posedge clk) if (en57_0) dat57_r0 <= dat57_r0_nxt;
always @(posedge clk) if (en57_1) dat57_r1 <= dat57_nxt;

assign dat57 = dat57_r0;


// edge:58 EB1.7
wire en58_0, en58_1, sel58;
reg [31:0] dat58_r0, dat58_r1;
wire [31:0] dat58_r0_nxt;
assign dat58_r0_nxt = sel58 ? dat58_r1 : dat58_nxt;

always @(posedge clk) if (en58_0) dat58_r0 <= dat58_r0_nxt;
always @(posedge clk) if (en58_1) dat58_r1 <= dat58_nxt;

assign dat58 = dat58_r0;


// edge:59 EB1
wire en59;
reg [31:0] dat59_r;
always @(posedge clk) if (en59) dat59_r <= dat59_nxt;
assign dat59 = dat59_r;


// edge:60 EB1.7
wire en60_0, en60_1, sel60;
reg [31:0] dat60_r0, dat60_r1;
wire [31:0] dat60_r0_nxt;
assign dat60_r0_nxt = sel60 ? dat60_r1 : dat60_nxt;

always @(posedge clk) if (en60_0) dat60_r0 <= dat60_r0_nxt;
always @(posedge clk) if (en60_1) dat60_r1 <= dat60_nxt;

assign dat60 = dat60_r0;


// edge:61 EB1
wire en61;
reg [31:0] dat61_r;
always @(posedge clk) if (en61) dat61_r <= dat61_nxt;
assign dat61 = dat61_r;


// edge:62 EB1.7
wire en62_0, en62_1, sel62;
reg [31:0] dat62_r0, dat62_r1;
wire [31:0] dat62_r0_nxt;
assign dat62_r0_nxt = sel62 ? dat62_r1 : dat62_nxt;

always @(posedge clk) if (en62_0) dat62_r0 <= dat62_r0_nxt;
always @(posedge clk) if (en62_1) dat62_r1 <= dat62_nxt;

assign dat62 = dat62_r0;

piston_ctrl uctrl (
    .clk(clk),
    .reset_n(reset_n),
    .t_instr_req(t_instr_req),
    .t_instr_ack(t_instr_ack),
    .t_idma_0_req(t_idma_0_req),
    .t_idma_0_ack(t_idma_0_ack),
    .t_idma_1_req(t_idma_1_req),
    .t_idma_1_ack(t_idma_1_ack),
    .t_idma_2_req(t_idma_2_req),
    .t_idma_2_ack(t_idma_2_ack),
    .t_idma_3_req(t_idma_3_req),
    .t_idma_3_ack(t_idma_3_ack),
    .i_odma_0_req(i_odma_0_req),
    .i_odma_0_ack(i_odma_0_ack),
    .i_odma_1_req(i_odma_1_req),
    .i_odma_1_ack(i_odma_1_ack),
    .i_odma_2_req(i_odma_2_req),
    .i_odma_2_ack(i_odma_2_ack),
    .i_odma_3_req(i_odma_3_req),
    .i_odma_3_ack(i_odma_3_ack),
    .en0_0(en0_0),
    .en0_1(en0_1),
    .sel0(sel0),
    .en1_0(en1_0),
    .en1_1(en1_1),
    .sel1(sel1),
    .en2_0(en2_0),
    .en2_1(en2_1),
    .sel2(sel2),
    .en3_0(en3_0),
    .en3_1(en3_1),
    .sel3(sel3),
    .en4_0(en4_0),
    .en4_1(en4_1),
    .sel4(sel4),
    .en5_0(en5_0),
    .en5_1(en5_1),
    .sel5(sel5),
    .en6_0(en6_0),
    .en6_1(en6_1),
    .sel6(sel6),
    .en7_0(en7_0),
    .en7_1(en7_1),
    .sel7(sel7),
    .en8_0(en8_0),
    .en8_1(en8_1),
    .sel8(sel8),
    .en9_0(en9_0),
    .en9_1(en9_1),
    .sel9(sel9),
    .en10_0(en10_0),
    .en10_1(en10_1),
    .sel10(sel10),
    .en11_0(en11_0),
    .en11_1(en11_1),
    .sel11(sel11),
    .en12_0(en12_0),
    .en12_1(en12_1),
    .sel12(sel12),
    .en13_0(en13_0),
    .en13_1(en13_1),
    .sel13(sel13),
    .en14_0(en14_0),
    .en14_1(en14_1),
    .sel14(sel14),
    .en15_0(en15_0),
    .en15_1(en15_1),
    .sel15(sel15),
    .en16_0(en16_0),
    .en16_1(en16_1),
    .sel16(sel16),
    .en17_0(en17_0),
    .en17_1(en17_1),
    .sel17(sel17),
    .en18_0(en18_0),
    .en18_1(en18_1),
    .sel18(sel18),
    .en19_0(en19_0),
    .en19_1(en19_1),
    .sel19(sel19),
    .en20_0(en20_0),
    .en20_1(en20_1),
    .sel20(sel20),
    .en21_0(en21_0),
    .en21_1(en21_1),
    .sel21(sel21),
    .en22_0(en22_0),
    .en22_1(en22_1),
    .sel22(sel22),
    .en23_0(en23_0),
    .en23_1(en23_1),
    .sel23(sel23),
    .en24_0(en24_0),
    .en24_1(en24_1),
    .sel24(sel24),
    .en25_0(en25_0),
    .en25_1(en25_1),
    .sel25(sel25),
    .en26_0(en26_0),
    .en26_1(en26_1),
    .sel26(sel26),
    .en27_0(en27_0),
    .en27_1(en27_1),
    .sel27(sel27),
    .en28_0(en28_0),
    .en28_1(en28_1),
    .sel28(sel28),
    .en29_0(en29_0),
    .en29_1(en29_1),
    .sel29(sel29),
    .en30_0(en30_0),
    .en30_1(en30_1),
    .sel30(sel30),
    .en31_0(en31_0),
    .en31_1(en31_1),
    .sel31(sel31),
    .en32(en32),
    .en33(en33),
    .en35(en35),
    .en36_0(en36_0),
    .en36_1(en36_1),
    .sel36(sel36),
    .en37_0(en37_0),
    .en37_1(en37_1),
    .sel37(sel37),
    .en38_0(en38_0),
    .en38_1(en38_1),
    .sel38(sel38),
    .en39_0(en39_0),
    .en39_1(en39_1),
    .sel39(sel39),
    .en40(en40),
    .wr_ptr41(wr_ptr41),
    .rd_ptr41(rd_ptr41),
    .wen41(wen41),
    .ren41(ren41),
    .en42_0(en42_0),
    .en42_1(en42_1),
    .sel42(sel42),
    .en43_0(en43_0),
    .en43_1(en43_1),
    .sel43(sel43),
    .en44(en44),
    .en45(en45),
    .wr_ptr46(wr_ptr46),
    .rd_ptr46(rd_ptr46),
    .wen46(wen46),
    .ren46(ren46),
    .wr_ptr47(wr_ptr47),
    .rd_ptr47(rd_ptr47),
    .wen47(wen47),
    .ren47(ren47),
    .en48(en48),
    .wr_ptr49(wr_ptr49),
    .rd_ptr49(rd_ptr49),
    .wen49(wen49),
    .ren49(ren49),
    .wr_ptr50(wr_ptr50),
    .rd_ptr50(rd_ptr50),
    .wen50(wen50),
    .ren50(ren50),
    .wr_ptr51(wr_ptr51),
    .rd_ptr51(rd_ptr51),
    .wen51(wen51),
    .ren51(ren51),
    .en52_0(en52_0),
    .en52_1(en52_1),
    .sel52(sel52),
    .en53_0(en53_0),
    .en53_1(en53_1),
    .sel53(sel53),
    .en54_0(en54_0),
    .en54_1(en54_1),
    .sel54(sel54),
    .en55_0(en55_0),
    .en55_1(en55_1),
    .sel55(sel55),
    .en56_0(en56_0),
    .en56_1(en56_1),
    .sel56(sel56),
    .en57_0(en57_0),
    .en57_1(en57_1),
    .sel57(sel57),
    .en58_0(en58_0),
    .en58_1(en58_1),
    .sel58(sel58),
    .en59(en59),
    .en60_0(en60_0),
    .en60_1(en60_1),
    .sel60(sel60),
    .en61(en61),
    .en62_0(en62_0),
    .en62_1(en62_1),
    .sel62(sel62),
    .instr_0_valid26(instr_0_valid26),
    .instr_0_ready26(instr_0_ready26),
    .instr_1_valid26(instr_1_valid26),
    .instr_1_ready26(instr_1_ready26),
    .instr_2_valid26(instr_2_valid26),
    .instr_2_ready26(instr_2_ready26),
    .instr_3_valid26(instr_3_valid26),
    .instr_3_ready26(instr_3_ready26),
    .instr_4_valid26(instr_4_valid26),
    .instr_4_ready26(instr_4_ready26),
    .instr_5_valid26(instr_5_valid26),
    .instr_5_ready26(instr_5_ready26),
    .instr_6_valid26(instr_6_valid26),
    .instr_6_ready26(instr_6_ready26),
    .instr_7_valid26(instr_7_valid26),
    .instr_7_ready26(instr_7_ready26),
    .instr_8_valid26(instr_8_valid26),
    .instr_8_ready26(instr_8_ready26),
    .instr_9_valid26(instr_9_valid26),
    .instr_9_ready26(instr_9_ready26),
    .instr_10_valid26(instr_10_valid26),
    .instr_10_ready26(instr_10_ready26),
    .instr_11_valid26(instr_11_valid26),
    .instr_11_ready26(instr_11_ready26),
    .instr_12_valid26(instr_12_valid26),
    .instr_12_ready26(instr_12_ready26),
    .instr_13_valid26(instr_13_valid26),
    .instr_13_ready26(instr_13_ready26),
    .instr_14_valid26(instr_14_valid26),
    .instr_14_ready26(instr_14_ready26),
    .instr_15_valid26(instr_15_valid26),
    .instr_15_ready26(instr_15_ready26),
    .tk15_valid26(tk15_valid26),
    .tk15_ready26(tk15_ready26),
    .ik15_valid26(ik15_valid26),
    .ik15_ready26(ik15_ready26),
    .kap_valid26(kap_valid26),
    .kap_ready26(kap_ready26),
    .sel2750(sel2750),
    .idma_valid28(idma_valid28),
    .idma_ready28(idma_ready28),
    .odma_valid28(odma_valid28),
    .odma_ready28(odma_ready28),
    .tvs_valid28(tvs_valid28),
    .tvs_ready28(tvs_ready28),
    .ivs_valid28(ivs_valid28),
    .ivs_ready28(ivs_ready28),
    .k_ctrl28(k_ctrl28),
    .sel2950(sel2950),
    .k_ctrl34(k_ctrl34),
    .k_ctrl35(k_ctrl35),
    .n53_k8_req(n53_k8_req),
    .n53_k8_ack(n53_k8_ack),
    .n53_k9_req(n53_k9_req),
    .n53_k9_ack(n53_k9_ack),
    .n53_k14_req(n53_k14_req),
    .n53_k14_ack(n53_k14_ack),
    .n53_k1_req(n53_k1_req),
    .n53_k1_ack(n53_k1_ack)
);
endmodule // piston

module piston_ctrl (
    // per node (target / initiator)
    input              clk,
    input              reset_n,
    input              t_instr_req,
    output             t_instr_ack,
    input              t_idma_0_req,
    output             t_idma_0_ack,
    input              t_idma_1_req,
    output             t_idma_1_ack,
    input              t_idma_2_req,
    output             t_idma_2_ack,
    input              t_idma_3_req,
    output             t_idma_3_ack,
    output             i_odma_0_req,
    input              i_odma_0_ack,
    output             i_odma_1_req,
    input              i_odma_1_ack,
    output             i_odma_2_req,
    input              i_odma_2_ack,
    output             i_odma_3_req,
    input              i_odma_3_ack,
    output             en0_0,
    output             en0_1,
    output             sel0,
    output             en1_0,
    output             en1_1,
    output             sel1,
    output             en2_0,
    output             en2_1,
    output             sel2,
    output             en3_0,
    output             en3_1,
    output             sel3,
    output             en4_0,
    output             en4_1,
    output             sel4,
    output             en5_0,
    output             en5_1,
    output             sel5,
    output             en6_0,
    output             en6_1,
    output             sel6,
    output             en7_0,
    output             en7_1,
    output             sel7,
    output             en8_0,
    output             en8_1,
    output             sel8,
    output             en9_0,
    output             en9_1,
    output             sel9,
    output             en10_0,
    output             en10_1,
    output             sel10,
    output             en11_0,
    output             en11_1,
    output             sel11,
    output             en12_0,
    output             en12_1,
    output             sel12,
    output             en13_0,
    output             en13_1,
    output             sel13,
    output             en14_0,
    output             en14_1,
    output             sel14,
    output             en15_0,
    output             en15_1,
    output             sel15,
    output             en16_0,
    output             en16_1,
    output             sel16,
    output             en17_0,
    output             en17_1,
    output             sel17,
    output             en18_0,
    output             en18_1,
    output             sel18,
    output             en19_0,
    output             en19_1,
    output             sel19,
    output             en20_0,
    output             en20_1,
    output             sel20,
    output             en21_0,
    output             en21_1,
    output             sel21,
    output             en22_0,
    output             en22_1,
    output             sel22,
    output             en23_0,
    output             en23_1,
    output             sel23,
    output             en24_0,
    output             en24_1,
    output             sel24,
    output             en25_0,
    output             en25_1,
    output             sel25,
    output             en26_0,
    output             en26_1,
    output             sel26,
    output             en27_0,
    output             en27_1,
    output             sel27,
    output             en28_0,
    output             en28_1,
    output             sel28,
    output             en29_0,
    output             en29_1,
    output             sel29,
    output             en30_0,
    output             en30_1,
    output             sel30,
    output             en31_0,
    output             en31_1,
    output             sel31,
    output             en32,
    output             en33,
    output             en35,
    output             en36_0,
    output             en36_1,
    output             sel36,
    output             en37_0,
    output             en37_1,
    output             sel37,
    output             en38_0,
    output             en38_1,
    output             sel38,
    output             en39_0,
    output             en39_1,
    output             sel39,
    output             en40,
    output       [1:0] wr_ptr41,
    output       [1:0] rd_ptr41,
    output             wen41,
    output             ren41,
    output             en42_0,
    output             en42_1,
    output             sel42,
    output             en43_0,
    output             en43_1,
    output             sel43,
    output             en44,
    output             en45,
    output       [1:0] wr_ptr46,
    output       [1:0] rd_ptr46,
    output             wen46,
    output             ren46,
    output             wr_ptr47,
    output             rd_ptr47,
    output             wen47,
    output             ren47,
    output             en48,
    output       [1:0] wr_ptr49,
    output       [1:0] rd_ptr49,
    output             wen49,
    output             ren49,
    output       [1:0] wr_ptr50,
    output       [1:0] rd_ptr50,
    output             wen50,
    output             ren50,
    output       [1:0] wr_ptr51,
    output       [1:0] rd_ptr51,
    output             wen51,
    output             ren51,
    output             en52_0,
    output             en52_1,
    output             sel52,
    output             en53_0,
    output             en53_1,
    output             sel53,
    output             en54_0,
    output             en54_1,
    output             sel54,
    output             en55_0,
    output             en55_1,
    output             sel55,
    output             en56_0,
    output             en56_1,
    output             sel56,
    output             en57_0,
    output             en57_1,
    output             sel57,
    output             en58_0,
    output             en58_1,
    output             sel58,
    output             en59,
    output             en60_0,
    output             en60_1,
    output             sel60,
    output             en61,
    output             en62_0,
    output             en62_1,
    output             sel62,
    output             instr_0_valid26,
    input              instr_0_ready26,
    output             instr_1_valid26,
    input              instr_1_ready26,
    output             instr_2_valid26,
    input              instr_2_ready26,
    output             instr_3_valid26,
    input              instr_3_ready26,
    output             instr_4_valid26,
    input              instr_4_ready26,
    output             instr_5_valid26,
    input              instr_5_ready26,
    output             instr_6_valid26,
    input              instr_6_ready26,
    output             instr_7_valid26,
    input              instr_7_ready26,
    output             instr_8_valid26,
    input              instr_8_ready26,
    output             instr_9_valid26,
    input              instr_9_ready26,
    output             instr_10_valid26,
    input              instr_10_ready26,
    output             instr_11_valid26,
    input              instr_11_ready26,
    output             instr_12_valid26,
    input              instr_12_ready26,
    output             instr_13_valid26,
    input              instr_13_ready26,
    output             instr_14_valid26,
    input              instr_14_ready26,
    output             instr_15_valid26,
    input              instr_15_ready26,
    output             tk15_valid26,
    input              tk15_ready26,
    input              ik15_valid26,
    output             ik15_ready26,
    input              kap_valid26,
    output             kap_ready26,
    input        [3:0] sel2750,
    output       [3:0] idma_valid28,
    input        [3:0] idma_ready28,
    input        [3:0] odma_valid28,
    output       [3:0] odma_ready28,
    output             tvs_valid28,
    input              tvs_ready28,
    input              ivs_valid28,
    output             ivs_ready28,
    input        [3:0] k_ctrl28,
    input        [3:0] sel2950,
    input        [3:0] k_ctrl34,
    input        [3:0] k_ctrl35,
    output             n53_k8_req,
    input              n53_k8_ack,
    output             n53_k9_req,
    input              n53_k9_ack,
    output             n53_k14_req,
    input              n53_k14_ack,
    input              n53_k1_req,
    output             n53_k1_ack
);
// per edge
wire             req0, ack0, ack0_0, req0_0, ack0_1, req0_1;
wire             req1, ack1, ack1_0, req1_0, ack1_1, req1_1;
wire             req2, ack2, ack2_0, req2_0, ack2_1, req2_1;
wire             req3, ack3, ack3_0, req3_0, ack3_1, req3_1;
wire             req4, ack4, ack4_0, req4_0, ack4_1, req4_1;
wire             req5, ack5, ack5_0, req5_0, ack5_1, req5_1;
wire             req6, ack6, ack6_0, req6_0, ack6_1, req6_1;
wire             req7, ack7, ack7_0, req7_0, ack7_1, req7_1;
wire             req8, ack8, ack8_0, req8_0;
wire             req9, ack9, ack9_0, req9_0;
wire             req10, ack10, ack10_0, req10_0, ack10_1, req10_1;
wire             req11, ack11, ack11_0, req11_0;
wire             req12, ack12, ack12_0, req12_0;
wire             req13, ack13, ack13_0, req13_0, ack13_1, req13_1;
wire             req14, ack14, ack14_0, req14_0;
wire             req15, ack15, ack15_0, req15_0;
wire             req16, ack16, ack16_0, req16_0, ack16_1, req16_1;
wire             req17, ack17, ack17_0, req17_0;
wire             req18, ack18, ack18_0, req18_0;
wire             req19, ack19, ack19_0, req19_0, ack19_1, req19_1;
wire             req20, ack20, ack20_0, req20_0;
wire             req21, ack21, ack21_0, req21_0;
wire             req22, ack22, ack22_0, req22_0, ack22_1, req22_1;
wire             req23, ack23, ack23_0, req23_0;
wire             req24, ack24, ack24_0, req24_0;
wire             req25, ack25, ack25_0, req25_0, ack25_1, req25_1;
wire             req26, ack26, ack26_0, req26_0;
wire             req27, ack27, ack27_0, req27_0;
wire             req28, ack28, ack28_0, req28_0, ack28_1, req28_1;
wire             req29, ack29, ack29_0, req29_0;
wire             req30, ack30, ack30_0, req30_0;
wire             req31, ack31, ack31_0, req31_0;
wire             req32, ack32, ack32_0, req32_0;
wire             req33, ack33, ack33_0, req33_0;
wire             req34, ack34, ack34_0, req34_0;
wire             req35, ack35, ack35_0, req35_0;
wire             req36, ack36, ack36_0, req36_0;
wire             req37, ack37, ack37_0, req37_0;
wire             req38, ack38, ack38_0, req38_0;
wire             req39, ack39, ack39_0, req39_0;
wire             req40, ack40, ack40_0, req40_0;
wire             req41, ack41, ack41_0, req41_0;
wire             req42, ack42, ack42_0, req42_0;
wire             req43, ack43, ack43_0, req43_0;
wire             req44, ack44, ack44_0, req44_0;
wire             req45, ack45, ack45_0, req45_0;
wire             req46, ack46, ack46_0, req46_0;
wire             req47, ack47, ack47_0, req47_0;
wire             req48, ack48, ack48_0, req48_0;
wire             req49, ack49, ack49_0, req49_0;
wire             req50, ack50, ack50_0, req50_0;
wire             req51, ack51, ack51_0, req51_0;
wire             req52, ack52, ack52_0, req52_0;
wire             req53, ack53, ack53_0, req53_0;
wire             req54, ack54, ack54_0, req54_0;
wire             req55, ack55, ack55_0, req55_0;
wire             req56, ack56, ack56_0, req56_0;
wire             req57, ack57, ack57_0, req57_0;
wire             req58, ack58, ack58_0, req58_0;
wire             req59, ack59, ack59_0, req59_0;
wire             req60, ack60, ack60_0, req60_0;
wire             req61, ack61, ack61_0, req61_0;
wire             req62, ack62, ack62_0, req62_0;
// node:t_instr target
assign req0 = t_instr_req;
assign t_instr_ack = ack0;
// node:t_idma_0 target
assign req52 = t_idma_0_req;
assign t_idma_0_ack = ack52;
// node:t_idma_1 target
assign req53 = t_idma_1_req;
assign t_idma_1_ack = ack53;
// node:t_idma_2 target
assign req55 = t_idma_2_req;
assign t_idma_2_ack = ack55;
// node:t_idma_3 target
assign req56 = t_idma_3_req;
assign t_idma_3_ack = ack56;

// edge:0 EB1.5
wire ack0m, req0m;
eb15_ctrl uctrl_0 (
    .t_0_req(req0), .t_0_ack(ack0),
    .i_0_req(req0m), .i_0_ack(ack0m),
    .en0(en0_0), .en1(en0_1), .sel(sel0),
    .clk(clk), .reset_n(reset_n)
);


// edge:0 fork
reg  ack0_0_r, ack0_1_r;
wire ack0_0_s, ack0_1_s;
assign req0_0 = req0m & ~ack0_0_r;
assign req0_1 = req0m & ~ack0_1_r;
assign ack0_0_s = ack0_0 | ~req0_0;
assign ack0_1_s = ack0_1 | ~req0_1;
assign ack0m = ack0_0_s & ack0_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack0_0_r <= 1'b0; else ack0_0_r <= ack0_0_s & ~ack0m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack0_1_r <= 1'b0; else ack0_1_r <= ack0_1_s & ~ack0m;


// edge:1 EB1.5
wire ack1m, req1m;
eb15_ctrl uctrl_1 (
    .t_0_req(req1), .t_0_ack(ack1),
    .i_0_req(req1m), .i_0_ack(ack1m),
    .en0(en1_0), .en1(en1_1), .sel(sel1),
    .clk(clk), .reset_n(reset_n)
);


// edge:1 fork
reg  ack1_0_r, ack1_1_r;
wire ack1_0_s, ack1_1_s;
assign req1_0 = req1m & ~ack1_0_r;
assign req1_1 = req1m & ~ack1_1_r;
assign ack1_0_s = ack1_0 | ~req1_0;
assign ack1_1_s = ack1_1 | ~req1_1;
assign ack1m = ack1_0_s & ack1_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack1_0_r <= 1'b0; else ack1_0_r <= ack1_0_s & ~ack1m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack1_1_r <= 1'b0; else ack1_1_r <= ack1_1_s & ~ack1m;


// edge:2 EB1.5
wire ack2m, req2m;
eb15_ctrl uctrl_2 (
    .t_0_req(req2), .t_0_ack(ack2),
    .i_0_req(req2m), .i_0_ack(ack2m),
    .en0(en2_0), .en1(en2_1), .sel(sel2),
    .clk(clk), .reset_n(reset_n)
);


// edge:2 fork
reg  ack2_0_r, ack2_1_r;
wire ack2_0_s, ack2_1_s;
assign req2_0 = req2m & ~ack2_0_r;
assign req2_1 = req2m & ~ack2_1_r;
assign ack2_0_s = ack2_0 | ~req2_0;
assign ack2_1_s = ack2_1 | ~req2_1;
assign ack2m = ack2_0_s & ack2_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack2_0_r <= 1'b0; else ack2_0_r <= ack2_0_s & ~ack2m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack2_1_r <= 1'b0; else ack2_1_r <= ack2_1_s & ~ack2m;


// edge:3 EB1.5
wire ack3m, req3m;
eb15_ctrl uctrl_3 (
    .t_0_req(req3), .t_0_ack(ack3),
    .i_0_req(req3m), .i_0_ack(ack3m),
    .en0(en3_0), .en1(en3_1), .sel(sel3),
    .clk(clk), .reset_n(reset_n)
);


// edge:3 fork
reg  ack3_0_r, ack3_1_r;
wire ack3_0_s, ack3_1_s;
assign req3_0 = req3m & ~ack3_0_r;
assign req3_1 = req3m & ~ack3_1_r;
assign ack3_0_s = ack3_0 | ~req3_0;
assign ack3_1_s = ack3_1 | ~req3_1;
assign ack3m = ack3_0_s & ack3_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack3_0_r <= 1'b0; else ack3_0_r <= ack3_0_s & ~ack3m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack3_1_r <= 1'b0; else ack3_1_r <= ack3_1_s & ~ack3m;


// edge:4 EB1.5
wire ack4m, req4m;
eb15_ctrl uctrl_4 (
    .t_0_req(req4), .t_0_ack(ack4),
    .i_0_req(req4m), .i_0_ack(ack4m),
    .en0(en4_0), .en1(en4_1), .sel(sel4),
    .clk(clk), .reset_n(reset_n)
);


// edge:4 fork
reg  ack4_0_r, ack4_1_r;
wire ack4_0_s, ack4_1_s;
assign req4_0 = req4m & ~ack4_0_r;
assign req4_1 = req4m & ~ack4_1_r;
assign ack4_0_s = ack4_0 | ~req4_0;
assign ack4_1_s = ack4_1 | ~req4_1;
assign ack4m = ack4_0_s & ack4_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack4_0_r <= 1'b0; else ack4_0_r <= ack4_0_s & ~ack4m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack4_1_r <= 1'b0; else ack4_1_r <= ack4_1_s & ~ack4m;


// edge:5 EB1.5
wire ack5m, req5m;
eb15_ctrl uctrl_5 (
    .t_0_req(req5), .t_0_ack(ack5),
    .i_0_req(req5m), .i_0_ack(ack5m),
    .en0(en5_0), .en1(en5_1), .sel(sel5),
    .clk(clk), .reset_n(reset_n)
);


// edge:5 fork
reg  ack5_0_r, ack5_1_r;
wire ack5_0_s, ack5_1_s;
assign req5_0 = req5m & ~ack5_0_r;
assign req5_1 = req5m & ~ack5_1_r;
assign ack5_0_s = ack5_0 | ~req5_0;
assign ack5_1_s = ack5_1 | ~req5_1;
assign ack5m = ack5_0_s & ack5_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack5_0_r <= 1'b0; else ack5_0_r <= ack5_0_s & ~ack5m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack5_1_r <= 1'b0; else ack5_1_r <= ack5_1_s & ~ack5m;


// edge:6 EB1.5
wire ack6m, req6m;
eb15_ctrl uctrl_6 (
    .t_0_req(req6), .t_0_ack(ack6),
    .i_0_req(req6m), .i_0_ack(ack6m),
    .en0(en6_0), .en1(en6_1), .sel(sel6),
    .clk(clk), .reset_n(reset_n)
);


// edge:6 fork
reg  ack6_0_r, ack6_1_r;
wire ack6_0_s, ack6_1_s;
assign req6_0 = req6m & ~ack6_0_r;
assign req6_1 = req6m & ~ack6_1_r;
assign ack6_0_s = ack6_0 | ~req6_0;
assign ack6_1_s = ack6_1 | ~req6_1;
assign ack6m = ack6_0_s & ack6_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack6_0_r <= 1'b0; else ack6_0_r <= ack6_0_s & ~ack6m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack6_1_r <= 1'b0; else ack6_1_r <= ack6_1_s & ~ack6m;


// edge:7 EB1.5
wire ack7m, req7m;
eb15_ctrl uctrl_7 (
    .t_0_req(req7), .t_0_ack(ack7),
    .i_0_req(req7m), .i_0_ack(ack7m),
    .en0(en7_0), .en1(en7_1), .sel(sel7),
    .clk(clk), .reset_n(reset_n)
);


// edge:7 fork
reg  ack7_0_r, ack7_1_r;
wire ack7_0_s, ack7_1_s;
assign req7_0 = req7m & ~ack7_0_r;
assign req7_1 = req7m & ~ack7_1_r;
assign ack7_0_s = ack7_0 | ~req7_0;
assign ack7_1_s = ack7_1 | ~req7_1;
assign ack7m = ack7_0_s & ack7_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack7_0_r <= 1'b0; else ack7_0_r <= ack7_0_s & ~ack7m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack7_1_r <= 1'b0; else ack7_1_r <= ack7_1_s & ~ack7m;


// edge:8 EB1.5
wire ack8m, req8m;
eb15_ctrl uctrl_8 (
    .t_0_req(req8), .t_0_ack(ack8),
    .i_0_req(req8m), .i_0_ack(ack8m),
    .en0(en8_0), .en1(en8_1), .sel(sel8),
    .clk(clk), .reset_n(reset_n)
);


// edge:8 fork


assign req8_0 = req8m;

assign ack8m = ack8_0;



// edge:9 EB1.5
wire ack9m, req9m;
eb15_ctrl uctrl_9 (
    .t_0_req(req9), .t_0_ack(ack9),
    .i_0_req(req9m), .i_0_ack(ack9m),
    .en0(en9_0), .en1(en9_1), .sel(sel9),
    .clk(clk), .reset_n(reset_n)
);


// edge:9 fork


assign req9_0 = req9m;

assign ack9m = ack9_0;



// edge:10 EB1.5
wire ack10m, req10m;
eb15_ctrl uctrl_10 (
    .t_0_req(req10), .t_0_ack(ack10),
    .i_0_req(req10m), .i_0_ack(ack10m),
    .en0(en10_0), .en1(en10_1), .sel(sel10),
    .clk(clk), .reset_n(reset_n)
);


// edge:10 fork
reg  ack10_0_r, ack10_1_r;
wire ack10_0_s, ack10_1_s;
assign req10_0 = req10m & ~ack10_0_r;
assign req10_1 = req10m & ~ack10_1_r;
assign ack10_0_s = ack10_0 | ~req10_0;
assign ack10_1_s = ack10_1 | ~req10_1;
assign ack10m = ack10_0_s & ack10_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack10_0_r <= 1'b0; else ack10_0_r <= ack10_0_s & ~ack10m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack10_1_r <= 1'b0; else ack10_1_r <= ack10_1_s & ~ack10m;


// edge:11 EB1.5
wire ack11m, req11m;
eb15_ctrl uctrl_11 (
    .t_0_req(req11), .t_0_ack(ack11),
    .i_0_req(req11m), .i_0_ack(ack11m),
    .en0(en11_0), .en1(en11_1), .sel(sel11),
    .clk(clk), .reset_n(reset_n)
);


// edge:11 fork


assign req11_0 = req11m;

assign ack11m = ack11_0;



// edge:12 EB1.5
wire ack12m, req12m;
eb15_ctrl uctrl_12 (
    .t_0_req(req12), .t_0_ack(ack12),
    .i_0_req(req12m), .i_0_ack(ack12m),
    .en0(en12_0), .en1(en12_1), .sel(sel12),
    .clk(clk), .reset_n(reset_n)
);


// edge:12 fork


assign req12_0 = req12m;

assign ack12m = ack12_0;



// edge:13 EB1.5
wire ack13m, req13m;
eb15_ctrl uctrl_13 (
    .t_0_req(req13), .t_0_ack(ack13),
    .i_0_req(req13m), .i_0_ack(ack13m),
    .en0(en13_0), .en1(en13_1), .sel(sel13),
    .clk(clk), .reset_n(reset_n)
);


// edge:13 fork
reg  ack13_0_r, ack13_1_r;
wire ack13_0_s, ack13_1_s;
assign req13_0 = req13m & ~ack13_0_r;
assign req13_1 = req13m & ~ack13_1_r;
assign ack13_0_s = ack13_0 | ~req13_0;
assign ack13_1_s = ack13_1 | ~req13_1;
assign ack13m = ack13_0_s & ack13_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack13_0_r <= 1'b0; else ack13_0_r <= ack13_0_s & ~ack13m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack13_1_r <= 1'b0; else ack13_1_r <= ack13_1_s & ~ack13m;


// edge:14 EB1.5
wire ack14m, req14m;
eb15_ctrl uctrl_14 (
    .t_0_req(req14), .t_0_ack(ack14),
    .i_0_req(req14m), .i_0_ack(ack14m),
    .en0(en14_0), .en1(en14_1), .sel(sel14),
    .clk(clk), .reset_n(reset_n)
);


// edge:14 fork


assign req14_0 = req14m;

assign ack14m = ack14_0;



// edge:15 EB1.5
wire ack15m, req15m;
eb15_ctrl uctrl_15 (
    .t_0_req(req15), .t_0_ack(ack15),
    .i_0_req(req15m), .i_0_ack(ack15m),
    .en0(en15_0), .en1(en15_1), .sel(sel15),
    .clk(clk), .reset_n(reset_n)
);


// edge:15 fork


assign req15_0 = req15m;

assign ack15m = ack15_0;



// edge:16 EB1.5
wire ack16m, req16m;
eb15_ctrl uctrl_16 (
    .t_0_req(req16), .t_0_ack(ack16),
    .i_0_req(req16m), .i_0_ack(ack16m),
    .en0(en16_0), .en1(en16_1), .sel(sel16),
    .clk(clk), .reset_n(reset_n)
);


// edge:16 fork
reg  ack16_0_r, ack16_1_r;
wire ack16_0_s, ack16_1_s;
assign req16_0 = req16m & ~ack16_0_r;
assign req16_1 = req16m & ~ack16_1_r;
assign ack16_0_s = ack16_0 | ~req16_0;
assign ack16_1_s = ack16_1 | ~req16_1;
assign ack16m = ack16_0_s & ack16_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack16_0_r <= 1'b0; else ack16_0_r <= ack16_0_s & ~ack16m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack16_1_r <= 1'b0; else ack16_1_r <= ack16_1_s & ~ack16m;


// edge:17 EB1.5
wire ack17m, req17m;
eb15_ctrl uctrl_17 (
    .t_0_req(req17), .t_0_ack(ack17),
    .i_0_req(req17m), .i_0_ack(ack17m),
    .en0(en17_0), .en1(en17_1), .sel(sel17),
    .clk(clk), .reset_n(reset_n)
);


// edge:17 fork


assign req17_0 = req17m;

assign ack17m = ack17_0;



// edge:18 EB1.5
wire ack18m, req18m;
eb15_ctrl uctrl_18 (
    .t_0_req(req18), .t_0_ack(ack18),
    .i_0_req(req18m), .i_0_ack(ack18m),
    .en0(en18_0), .en1(en18_1), .sel(sel18),
    .clk(clk), .reset_n(reset_n)
);


// edge:18 fork


assign req18_0 = req18m;

assign ack18m = ack18_0;



// edge:19 EB1.5
wire ack19m, req19m;
eb15_ctrl uctrl_19 (
    .t_0_req(req19), .t_0_ack(ack19),
    .i_0_req(req19m), .i_0_ack(ack19m),
    .en0(en19_0), .en1(en19_1), .sel(sel19),
    .clk(clk), .reset_n(reset_n)
);


// edge:19 fork
reg  ack19_0_r, ack19_1_r;
wire ack19_0_s, ack19_1_s;
assign req19_0 = req19m & ~ack19_0_r;
assign req19_1 = req19m & ~ack19_1_r;
assign ack19_0_s = ack19_0 | ~req19_0;
assign ack19_1_s = ack19_1 | ~req19_1;
assign ack19m = ack19_0_s & ack19_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack19_0_r <= 1'b0; else ack19_0_r <= ack19_0_s & ~ack19m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack19_1_r <= 1'b0; else ack19_1_r <= ack19_1_s & ~ack19m;


// edge:20 EB1.5
wire ack20m, req20m;
eb15_ctrl uctrl_20 (
    .t_0_req(req20), .t_0_ack(ack20),
    .i_0_req(req20m), .i_0_ack(ack20m),
    .en0(en20_0), .en1(en20_1), .sel(sel20),
    .clk(clk), .reset_n(reset_n)
);


// edge:20 fork


assign req20_0 = req20m;

assign ack20m = ack20_0;



// edge:21 EB1.5
wire ack21m, req21m;
eb15_ctrl uctrl_21 (
    .t_0_req(req21), .t_0_ack(ack21),
    .i_0_req(req21m), .i_0_ack(ack21m),
    .en0(en21_0), .en1(en21_1), .sel(sel21),
    .clk(clk), .reset_n(reset_n)
);


// edge:21 fork


assign req21_0 = req21m;

assign ack21m = ack21_0;



// edge:22 EB1.5
wire ack22m, req22m;
eb15_ctrl uctrl_22 (
    .t_0_req(req22), .t_0_ack(ack22),
    .i_0_req(req22m), .i_0_ack(ack22m),
    .en0(en22_0), .en1(en22_1), .sel(sel22),
    .clk(clk), .reset_n(reset_n)
);


// edge:22 fork
reg  ack22_0_r, ack22_1_r;
wire ack22_0_s, ack22_1_s;
assign req22_0 = req22m & ~ack22_0_r;
assign req22_1 = req22m & ~ack22_1_r;
assign ack22_0_s = ack22_0 | ~req22_0;
assign ack22_1_s = ack22_1 | ~req22_1;
assign ack22m = ack22_0_s & ack22_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack22_0_r <= 1'b0; else ack22_0_r <= ack22_0_s & ~ack22m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack22_1_r <= 1'b0; else ack22_1_r <= ack22_1_s & ~ack22m;


// edge:23 EB1.5
wire ack23m, req23m;
eb15_ctrl uctrl_23 (
    .t_0_req(req23), .t_0_ack(ack23),
    .i_0_req(req23m), .i_0_ack(ack23m),
    .en0(en23_0), .en1(en23_1), .sel(sel23),
    .clk(clk), .reset_n(reset_n)
);


// edge:23 fork


assign req23_0 = req23m;

assign ack23m = ack23_0;



// edge:24 EB1.5
wire ack24m, req24m;
eb15_ctrl uctrl_24 (
    .t_0_req(req24), .t_0_ack(ack24),
    .i_0_req(req24m), .i_0_ack(ack24m),
    .en0(en24_0), .en1(en24_1), .sel(sel24),
    .clk(clk), .reset_n(reset_n)
);


// edge:24 fork


assign req24_0 = req24m;

assign ack24m = ack24_0;



// edge:25 EB1.5
wire ack25m, req25m;
eb15_ctrl uctrl_25 (
    .t_0_req(req25), .t_0_ack(ack25),
    .i_0_req(req25m), .i_0_ack(ack25m),
    .en0(en25_0), .en1(en25_1), .sel(sel25),
    .clk(clk), .reset_n(reset_n)
);


// edge:25 fork
reg  ack25_0_r, ack25_1_r;
wire ack25_0_s, ack25_1_s;
assign req25_0 = req25m & ~ack25_0_r;
assign req25_1 = req25m & ~ack25_1_r;
assign ack25_0_s = ack25_0 | ~req25_0;
assign ack25_1_s = ack25_1 | ~req25_1;
assign ack25m = ack25_0_s & ack25_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack25_0_r <= 1'b0; else ack25_0_r <= ack25_0_s & ~ack25m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack25_1_r <= 1'b0; else ack25_1_r <= ack25_1_s & ~ack25m;


// edge:26 EB1.5
wire ack26m, req26m;
eb15_ctrl uctrl_26 (
    .t_0_req(req26), .t_0_ack(ack26),
    .i_0_req(req26m), .i_0_ack(ack26m),
    .en0(en26_0), .en1(en26_1), .sel(sel26),
    .clk(clk), .reset_n(reset_n)
);


// edge:26 fork


assign req26_0 = req26m;

assign ack26m = ack26_0;



// edge:27 EB1.5
wire ack27m, req27m;
eb15_ctrl uctrl_27 (
    .t_0_req(req27), .t_0_ack(ack27),
    .i_0_req(req27m), .i_0_ack(ack27m),
    .en0(en27_0), .en1(en27_1), .sel(sel27),
    .clk(clk), .reset_n(reset_n)
);


// edge:27 fork


assign req27_0 = req27m;

assign ack27m = ack27_0;



// edge:28 EB1.5
wire ack28m, req28m;
eb15_ctrl uctrl_28 (
    .t_0_req(req28), .t_0_ack(ack28),
    .i_0_req(req28m), .i_0_ack(ack28m),
    .en0(en28_0), .en1(en28_1), .sel(sel28),
    .clk(clk), .reset_n(reset_n)
);


// edge:28 fork
reg  ack28_0_r, ack28_1_r;
wire ack28_0_s, ack28_1_s;
assign req28_0 = req28m & ~ack28_0_r;
assign req28_1 = req28m & ~ack28_1_r;
assign ack28_0_s = ack28_0 | ~req28_0;
assign ack28_1_s = ack28_1 | ~req28_1;
assign ack28m = ack28_0_s & ack28_1_s;
always @(posedge clk or negedge reset_n) if (~reset_n) ack28_0_r <= 1'b0; else ack28_0_r <= ack28_0_s & ~ack28m;
always @(posedge clk or negedge reset_n) if (~reset_n) ack28_1_r <= 1'b0; else ack28_1_r <= ack28_1_s & ~ack28m;


// edge:29 EB1.5
wire ack29m, req29m;
eb15_ctrl uctrl_29 (
    .t_0_req(req29), .t_0_ack(ack29),
    .i_0_req(req29m), .i_0_ack(ack29m),
    .en0(en29_0), .en1(en29_1), .sel(sel29),
    .clk(clk), .reset_n(reset_n)
);


// edge:29 fork


assign req29_0 = req29m;

assign ack29m = ack29_0;



// edge:30 EB1.5
wire ack30m, req30m;
eb15_ctrl uctrl_30 (
    .t_0_req(req30), .t_0_ack(ack30),
    .i_0_req(req30m), .i_0_ack(ack30m),
    .en0(en30_0), .en1(en30_1), .sel(sel30),
    .clk(clk), .reset_n(reset_n)
);


// edge:30 fork


assign req30_0 = req30m;

assign ack30m = ack30_0;



// edge:31 EB1.5
wire ack31m, req31m;
eb15_ctrl uctrl_31 (
    .t_0_req(req31), .t_0_ack(ack31),
    .i_0_req(req31m), .i_0_ack(ack31m),
    .en0(en31_0), .en1(en31_1), .sel(sel31),
    .clk(clk), .reset_n(reset_n)
);


// edge:31 fork


assign req31_0 = req31m;

assign ack31m = ack31_0;



// edge:32 EB1
wire ack32m;
reg req32m;
assign en32 = req32 & ack32;
assign ack32 = ~req32m | ack32m;
always @(posedge clk or negedge reset_n) if (~reset_n) req32m <= 1'b0; else req32m <= ~ack32 | req32;


// edge:32 fork


assign req32_0 = req32m;

assign ack32m = ack32_0;



// edge:33 EB1
wire ack33m;
reg req33m;
assign en33 = req33 & ack33;
assign ack33 = ~req33m | ack33m;
always @(posedge clk or negedge reset_n) if (~reset_n) req33m <= 1'b0; else req33m <= ~ack33 | req33;


// edge:33 fork


assign req33_0 = req33m;

assign ack33m = ack33_0;



// edge:34 EB0
wire ack34m, req34m;
assign req34m = req34;
assign ack34 = ack34m;


// edge:34 fork


assign req34_0 = req34m;

assign ack34m = ack34_0;



// edge:35 EB1
wire ack35m;
reg req35m;
assign en35 = req35 & ack35;
assign ack35 = ~req35m | ack35m;
always @(posedge clk or negedge reset_n) if (~reset_n) req35m <= 1'b0; else req35m <= ~ack35 | req35;


// edge:35 fork


assign req35_0 = req35m;

assign ack35m = ack35_0;



// edge:36 EB1.5
wire ack36m, req36m;
eb15_ctrl uctrl_36 (
    .t_0_req(req36), .t_0_ack(ack36),
    .i_0_req(req36m), .i_0_ack(ack36m),
    .en0(en36_0), .en1(en36_1), .sel(sel36),
    .clk(clk), .reset_n(reset_n)
);


// edge:36 fork


assign req36_0 = req36m;

assign ack36m = ack36_0;



// edge:37 EB1.5
wire ack37m, req37m;
eb15_ctrl uctrl_37 (
    .t_0_req(req37), .t_0_ack(ack37),
    .i_0_req(req37m), .i_0_ack(ack37m),
    .en0(en37_0), .en1(en37_1), .sel(sel37),
    .clk(clk), .reset_n(reset_n)
);


// edge:37 fork


assign req37_0 = req37m;

assign ack37m = ack37_0;



// edge:38 EB1.5
wire ack38m, req38m;
eb15_ctrl uctrl_38 (
    .t_0_req(req38), .t_0_ack(ack38),
    .i_0_req(req38m), .i_0_ack(ack38m),
    .en0(en38_0), .en1(en38_1), .sel(sel38),
    .clk(clk), .reset_n(reset_n)
);


// edge:38 fork


assign req38_0 = req38m;

assign ack38m = ack38_0;



// edge:39 EB1.5
wire ack39m, req39m;
eb15_ctrl uctrl_39 (
    .t_0_req(req39), .t_0_ack(ack39),
    .i_0_req(req39m), .i_0_ack(ack39m),
    .en0(en39_0), .en1(en39_1), .sel(sel39),
    .clk(clk), .reset_n(reset_n)
);


// edge:39 fork


assign req39_0 = req39m;

assign ack39m = ack39_0;



// edge:40 EB1
wire ack40m;
reg req40m;
assign en40 = req40 & ack40;
assign ack40 = ~req40m | ack40m;
always @(posedge clk or negedge reset_n) if (~reset_n) req40m <= 1'b0; else req40m <= ~ack40 | req40;


// edge:40 fork


assign req40_0 = req40m;

assign ack40m = ack40_0;



// edge:41 EB_FIFO
wire ack41m, req41m;
eb_fifo_ctrl #(
    .DEPTHMO(2'd3),
    .DEPTHLOG2MO(1)
) uctrl_41 (
    .t_0_req(req41), .t_0_ack(ack41),
    .i_0_req(req41m), .i_0_ack(ack41m),
    .wr_ptr(wr_ptr41),
    .rd_ptr(rd_ptr41),
    .wen(wen41),
    .ren(ren41),
    .clk(clk), .reset_n(reset_n)
);


// edge:41 fork


assign req41_0 = req41m;

assign ack41m = ack41_0;



// edge:42 EB1.5
wire ack42m, req42m;
eb15_ctrl uctrl_42 (
    .t_0_req(req42), .t_0_ack(ack42),
    .i_0_req(req42m), .i_0_ack(ack42m),
    .en0(en42_0), .en1(en42_1), .sel(sel42),
    .clk(clk), .reset_n(reset_n)
);


// edge:42 fork


assign req42_0 = req42m;

assign ack42m = ack42_0;



// edge:43 EB1.5
wire ack43m, req43m;
eb15_ctrl uctrl_43 (
    .t_0_req(req43), .t_0_ack(ack43),
    .i_0_req(req43m), .i_0_ack(ack43m),
    .en0(en43_0), .en1(en43_1), .sel(sel43),
    .clk(clk), .reset_n(reset_n)
);


// edge:43 fork


assign req43_0 = req43m;

assign ack43m = ack43_0;



// edge:44 EB1
wire ack44m;
reg req44m;
assign en44 = req44 & ack44;
assign ack44 = ~req44m | ack44m;
always @(posedge clk or negedge reset_n) if (~reset_n) req44m <= 1'b0; else req44m <= ~ack44 | req44;


// edge:44 fork


assign req44_0 = req44m;

assign ack44m = ack44_0;



// edge:45 EB1
wire ack45m;
reg req45m;
assign en45 = req45 & ack45;
assign ack45 = ~req45m | ack45m;
always @(posedge clk or negedge reset_n) if (~reset_n) req45m <= 1'b0; else req45m <= ~ack45 | req45;


// edge:45 fork


assign req45_0 = req45m;

assign ack45m = ack45_0;



// edge:46 EB_FIFO
wire ack46m, req46m;
eb_fifo_ctrl #(
    .DEPTHMO(2'd3),
    .DEPTHLOG2MO(1)
) uctrl_46 (
    .t_0_req(req46), .t_0_ack(ack46),
    .i_0_req(req46m), .i_0_ack(ack46m),
    .wr_ptr(wr_ptr46),
    .rd_ptr(rd_ptr46),
    .wen(wen46),
    .ren(ren46),
    .clk(clk), .reset_n(reset_n)
);


// edge:46 fork


assign req46_0 = req46m;

assign ack46m = ack46_0;



// edge:47 EB_FIFO
wire ack47m, req47m;
eb_fifo_ctrl #(
    .DEPTHMO(1'd1),
    .DEPTHLOG2MO(0)
) uctrl_47 (
    .t_0_req(req47), .t_0_ack(ack47),
    .i_0_req(req47m), .i_0_ack(ack47m),
    .wr_ptr(wr_ptr47),
    .rd_ptr(rd_ptr47),
    .wen(wen47),
    .ren(ren47),
    .clk(clk), .reset_n(reset_n)
);


// edge:47 fork


assign req47_0 = req47m;

assign ack47m = ack47_0;



// edge:48 EB1
wire ack48m;
reg req48m;
assign en48 = req48 & ack48;
assign ack48 = ~req48m | ack48m;
always @(posedge clk or negedge reset_n) if (~reset_n) req48m <= 1'b0; else req48m <= ~ack48 | req48;


// edge:48 fork


assign req48_0 = req48m;

assign ack48m = ack48_0;



// edge:49 EB_FIFO
wire ack49m, req49m;
eb_fifo_ctrl #(
    .DEPTHMO(2'd3),
    .DEPTHLOG2MO(1)
) uctrl_49 (
    .t_0_req(req49), .t_0_ack(ack49),
    .i_0_req(req49m), .i_0_ack(ack49m),
    .wr_ptr(wr_ptr49),
    .rd_ptr(rd_ptr49),
    .wen(wen49),
    .ren(ren49),
    .clk(clk), .reset_n(reset_n)
);


// edge:49 fork


assign req49_0 = req49m;

assign ack49m = ack49_0;



// edge:50 EB_FIFO
wire ack50m, req50m;
eb_fifo_ctrl #(
    .DEPTHMO(2'd2),
    .DEPTHLOG2MO(1)
) uctrl_50 (
    .t_0_req(req50), .t_0_ack(ack50),
    .i_0_req(req50m), .i_0_ack(ack50m),
    .wr_ptr(wr_ptr50),
    .rd_ptr(rd_ptr50),
    .wen(wen50),
    .ren(ren50),
    .clk(clk), .reset_n(reset_n)
);


// edge:50 fork


assign req50_0 = req50m;

assign ack50m = ack50_0;



// edge:51 EB_FIFO
wire ack51m, req51m;
eb_fifo_ctrl #(
    .DEPTHMO(2'd2),
    .DEPTHLOG2MO(1)
) uctrl_51 (
    .t_0_req(req51), .t_0_ack(ack51),
    .i_0_req(req51m), .i_0_ack(ack51m),
    .wr_ptr(wr_ptr51),
    .rd_ptr(rd_ptr51),
    .wen(wen51),
    .ren(ren51),
    .clk(clk), .reset_n(reset_n)
);


// edge:51 fork


assign req51_0 = req51m;

assign ack51m = ack51_0;



// edge:52 EB1.5
wire ack52m, req52m;
eb15_ctrl uctrl_52 (
    .t_0_req(req52), .t_0_ack(ack52),
    .i_0_req(req52m), .i_0_ack(ack52m),
    .en0(en52_0), .en1(en52_1), .sel(sel52),
    .clk(clk), .reset_n(reset_n)
);


// edge:52 fork


assign req52_0 = req52m;

assign ack52m = ack52_0;



// edge:53 EB1.5
wire ack53m, req53m;
eb15_ctrl uctrl_53 (
    .t_0_req(req53), .t_0_ack(ack53),
    .i_0_req(req53m), .i_0_ack(ack53m),
    .en0(en53_0), .en1(en53_1), .sel(sel53),
    .clk(clk), .reset_n(reset_n)
);


// edge:53 fork


assign req53_0 = req53m;

assign ack53m = ack53_0;



// edge:54 EB1.5
wire ack54m, req54m;
eb15_ctrl uctrl_54 (
    .t_0_req(req54), .t_0_ack(ack54),
    .i_0_req(req54m), .i_0_ack(ack54m),
    .en0(en54_0), .en1(en54_1), .sel(sel54),
    .clk(clk), .reset_n(reset_n)
);


// edge:54 fork


assign req54_0 = req54m;

assign ack54m = ack54_0;



// edge:55 EB1.5
wire ack55m, req55m;
eb15_ctrl uctrl_55 (
    .t_0_req(req55), .t_0_ack(ack55),
    .i_0_req(req55m), .i_0_ack(ack55m),
    .en0(en55_0), .en1(en55_1), .sel(sel55),
    .clk(clk), .reset_n(reset_n)
);


// edge:55 fork


assign req55_0 = req55m;

assign ack55m = ack55_0;



// edge:56 EB1.5
wire ack56m, req56m;
eb15_ctrl uctrl_56 (
    .t_0_req(req56), .t_0_ack(ack56),
    .i_0_req(req56m), .i_0_ack(ack56m),
    .en0(en56_0), .en1(en56_1), .sel(sel56),
    .clk(clk), .reset_n(reset_n)
);


// edge:56 fork


assign req56_0 = req56m;

assign ack56m = ack56_0;



// edge:57 EB1.7
wire ack57m, req57m;
eb17_ctrl uctrl_57 (
    .t_0_req(req57), .t_0_ack(ack57),
    .i_0_req(req57m), .i_0_ack(ack57m),
    .en0(en57_0), .en1(en57_1), .sel(sel57),
    .clk(clk), .reset_n(reset_n)
);


// edge:57 fork


assign req57_0 = req57m;

assign ack57m = ack57_0;



// edge:58 EB1.7
wire ack58m, req58m;
eb17_ctrl uctrl_58 (
    .t_0_req(req58), .t_0_ack(ack58),
    .i_0_req(req58m), .i_0_ack(ack58m),
    .en0(en58_0), .en1(en58_1), .sel(sel58),
    .clk(clk), .reset_n(reset_n)
);


// edge:58 fork


assign req58_0 = req58m;

assign ack58m = ack58_0;



// edge:59 EB1
wire ack59m;
reg req59m;
assign en59 = req59 & ack59;
assign ack59 = ~req59m | ack59m;
always @(posedge clk or negedge reset_n) if (~reset_n) req59m <= 1'b0; else req59m <= ~ack59 | req59;


// edge:59 fork


assign req59_0 = req59m;

assign ack59m = ack59_0;



// edge:60 EB1.7
wire ack60m, req60m;
eb17_ctrl uctrl_60 (
    .t_0_req(req60), .t_0_ack(ack60),
    .i_0_req(req60m), .i_0_ack(ack60m),
    .en0(en60_0), .en1(en60_1), .sel(sel60),
    .clk(clk), .reset_n(reset_n)
);


// edge:60 fork


assign req60_0 = req60m;

assign ack60m = ack60_0;



// edge:61 EB1
wire ack61m;
reg req61m;
assign en61 = req61 & ack61;
assign ack61 = ~req61m | ack61m;
always @(posedge clk or negedge reset_n) if (~reset_n) req61m <= 1'b0; else req61m <= ~ack61 | req61;


// edge:61 fork


assign req61_0 = req61m;

assign ack61m = ack61_0;



// edge:62 EB1.7
wire ack62m, req62m;
eb17_ctrl uctrl_62 (
    .t_0_req(req62), .t_0_ack(ack62),
    .i_0_req(req62m), .i_0_ack(ack62m),
    .en0(en62_0), .en1(en62_1), .sel(sel62),
    .clk(clk), .reset_n(reset_n)
);


// edge:62 fork


assign req62_0 = req62m;

assign ack62m = ack62_0;


// node:1 join undefined
assign req1 = req0_0;
assign ack0_0 = ack1;
// node:2 join undefined
assign req2 = req0_1;
assign ack0_1 = ack2;
// node:3 join undefined
assign req3 = req1_0;
assign ack1_0 = ack3;
// node:4 join undefined
assign req4 = req1_1;
assign ack1_1 = ack4;
// node:5 join undefined
assign req5 = req2_0;
assign ack2_0 = ack5;
// node:6 join undefined
assign req6 = req2_1;
assign ack2_1 = ack6;
// node:7 join undefined
assign req7 = req3_0;
assign ack3_0 = ack7;
// node:8 join undefined
assign req10 = req3_1;
assign ack3_1 = ack10;
// node:9 join undefined
assign req13 = req4_0;
assign ack4_0 = ack13;
// node:10 join undefined
assign req16 = req4_1;
assign ack4_1 = ack16;
// node:11 join undefined
assign req19 = req5_0;
assign ack5_0 = ack19;
// node:12 join undefined
assign req22 = req5_1;
assign ack5_1 = ack22;
// node:13 join undefined
assign req25 = req6_0;
assign ack6_0 = ack25;
// node:14 join undefined
assign req28 = req6_1;
assign ack6_1 = ack28;
// node:17 join undefined
assign req54 = req53_0;
assign ack53_0 = ack54;
// node:22 join undefined
assign req59 = req58_0;
assign ack58_0 = ack59;
// node:24 join undefined
assign req61 = req60_0;
assign ack60_0 = ack61;
// node:26 custom controller vector
vector_ctrl_17_2 unode26 (
    .t_instr_0_req(req8_0),
    .t_instr_0_ack(ack8_0),
    .t_instr_1_req(req9_0),
    .t_instr_1_ack(ack9_0),
    .t_instr_2_req(req11_0),
    .t_instr_2_ack(ack11_0),
    .t_instr_3_req(req12_0),
    .t_instr_3_ack(ack12_0),
    .t_instr_4_req(req14_0),
    .t_instr_4_ack(ack14_0),
    .t_instr_5_req(req15_0),
    .t_instr_5_ack(ack15_0),
    .t_instr_6_req(req17_0),
    .t_instr_6_ack(ack17_0),
    .t_instr_7_req(req18_0),
    .t_instr_7_ack(ack18_0),
    .t_instr_8_req(req20_0),
    .t_instr_8_ack(ack20_0),
    .t_instr_9_req(req21_0),
    .t_instr_9_ack(ack21_0),
    .t_instr_10_req(req23_0),
    .t_instr_10_ack(ack23_0),
    .t_instr_11_req(req24_0),
    .t_instr_11_ack(ack24_0),
    .t_instr_12_req(req26_0),
    .t_instr_12_ack(ack26_0),
    .t_instr_13_req(req27_0),
    .t_instr_13_ack(ack27_0),
    .t_instr_14_req(req29_0),
    .t_instr_14_ack(ack29_0),
    .t_instr_15_req(req30_0),
    .t_instr_15_ack(ack30_0),
    .t_k15_req(req37_0),
    .t_k15_ack(ack37_0),
    .i_k15_req(req31),
    .i_k15_ack(ack31),
    .i_kap_req(req43),
    .i_kap_ack(ack43),
    .instr_0_valid(instr_0_valid26),
    .instr_0_ready(instr_0_ready26),
    .instr_1_valid(instr_1_valid26),
    .instr_1_ready(instr_1_ready26),
    .instr_2_valid(instr_2_valid26),
    .instr_2_ready(instr_2_ready26),
    .instr_3_valid(instr_3_valid26),
    .instr_3_ready(instr_3_ready26),
    .instr_4_valid(instr_4_valid26),
    .instr_4_ready(instr_4_ready26),
    .instr_5_valid(instr_5_valid26),
    .instr_5_ready(instr_5_ready26),
    .instr_6_valid(instr_6_valid26),
    .instr_6_ready(instr_6_ready26),
    .instr_7_valid(instr_7_valid26),
    .instr_7_ready(instr_7_ready26),
    .instr_8_valid(instr_8_valid26),
    .instr_8_ready(instr_8_ready26),
    .instr_9_valid(instr_9_valid26),
    .instr_9_ready(instr_9_ready26),
    .instr_10_valid(instr_10_valid26),
    .instr_10_ready(instr_10_ready26),
    .instr_11_valid(instr_11_valid26),
    .instr_11_ready(instr_11_ready26),
    .instr_12_valid(instr_12_valid26),
    .instr_12_ready(instr_12_ready26),
    .instr_13_valid(instr_13_valid26),
    .instr_13_ready(instr_13_ready26),
    .instr_14_valid(instr_14_valid26),
    .instr_14_ready(instr_14_ready26),
    .instr_15_valid(instr_15_valid26),
    .instr_15_ready(instr_15_ready26),
    .tk15_valid(tk15_valid26),
    .tk15_ready(tk15_ready26),
    .ik15_valid(ik15_valid26),
    .ik15_ready(ik15_ready26),
    .kap_valid(kap_valid26),
    .kap_ready(kap_ready26),
    .clk(clk),
    .reset_n(reset_n));

// node:27 custom controller inmux
inmux_ctrl_4_1 unode27 (
    .t_k15_req(req31_0),
    .t_k15_ack(ack31_0),
    .t_k13_req(req41_0),
    .t_k13_ack(ack41_0),
    .t_k1_req(req42_0),
    .t_k1_ack(ack42_0),
    .t_c_req(req47_0),
    .t_c_ack(ack47_0),
    .i_inmux_req(req32),
    .i_inmux_ack(ack32),
    .sel(sel2750),
    .clk(clk),
    .reset_n(reset_n));

// node:28 custom controller vmem
vmem_ctrl_6_5 unode28 (
    .t_ivs_req(req33_0),
    .t_ivs_ack(ack33_0),
    .t_ka_req(req46_0),
    .t_ka_ack(ack46_0),
    .t_idma_0_req(req52_0),
    .t_idma_0_ack(ack52_0),
    .t_idma_1_req(req54_0),
    .t_idma_1_ack(ack54_0),
    .t_idma_2_req(req55_0),
    .t_idma_2_ack(ack55_0),
    .t_idma_3_req(req56_0),
    .t_idma_3_ack(ack56_0),
    .i_ovs_req(req34),
    .i_ovs_ack(ack34),
    .i_odma_0_req(req57),
    .i_odma_0_ack(ack57),
    .i_odma_1_req(req58),
    .i_odma_1_ack(ack58),
    .i_odma_2_req(req60),
    .i_odma_2_ack(ack60),
    .i_odma_3_req(req62),
    .i_odma_3_ack(ack62),
    .idma_valid(idma_valid28),
    .idma_ready(idma_ready28),
    .odma_valid(odma_valid28),
    .odma_ready(odma_ready28),
    .tvs_valid(tvs_valid28),
    .tvs_ready(tvs_ready28),
    .ivs_valid(ivs_valid28),
    .ivs_ready(ivs_ready28),
    .k_ctrl(k_ctrl28),
    .clk(clk),
    .reset_n(reset_n));

// node:29 custom controller oumux
oumux_ctrl_2_5 unode29 (
    .t_oumux_req(req36_0),
    .t_oumux_ack(ack36_0),
    .t_c_req(req49_0),
    .t_c_ack(ack49_0),
    .i_k15_req(req37),
    .i_k15_ack(ack37),
    .i_k8_req(req38),
    .i_k8_ack(ack38),
    .i_k9_req(req39),
    .i_k9_ack(ack39),
    .i_k14_req(req40),
    .i_k14_ack(ack40),
    .i_k13_req(req41),
    .i_k13_ack(ack41),
    .sel(sel2950),
    .clk(clk),
    .reset_n(reset_n));

// node:30 fork controller;
reg    req44_reg, req45_reg;
assign req44 = req43_0 & ~req44_reg;
assign req45 = req43_0 & ~req45_reg;
wire   ack44_g, ack45_g;
assign ack44_g = ack44 | ~req44;
assign ack45_g = ack45 | ~req45;
assign ack43_0 = ack44_g & ack45_g;
always @(posedge clk or negedge reset_n) if (~reset_n) req44_reg <= 1'b0; else req44_reg <= ack44_g & ~ack43_0;
always @(posedge clk or negedge reset_n) if (~reset_n) req45_reg <= 1'b0; else req45_reg <= ack45_g & ~ack43_0;

// node:31 join perm_full_addr
assign req48 = req44_0;
assign ack44_0 = ack48;
// node:32 join perm_full_data
assign req33 = req32_0 & req50_0;
assign ack32_0 = ack33 & req50_0;
assign ack50_0 = ack33 & req32_0;
// node:33 join perm_full_data
assign req36 = req35_0 & req51_0;
assign ack35_0 = ack36 & req51_0;
assign ack51_0 = ack36 & req35_0;
// node:34 custom controller ka_decode
ka_decode_ctrl_1_3 unode34 (
    .t_ka_req(req45_0),
    .t_ka_ack(ack45_0),
    .i_ka_req(req46),
    .i_ka_ack(ack46),
    .i_k_sk_req(req47),
    .i_k_sk_ack(ack47),
    .i_k_lk_req(req49),
    .i_k_lk_ack(ack49),
    .k_ctrl(k_ctrl34),
    .clk(clk),
    .reset_n(reset_n));

// node:35 custom controller p_decode
p_decode_ctrl_1_2 unode35 (
    .t_kp_req(req48_0),
    .t_kp_ack(ack48_0),
    .i_p_sk_req(req50),
    .i_p_sk_ack(ack50),
    .i_p_lk_req(req51),
    .i_p_lk_ack(ack51),
    .k_ctrl(k_ctrl35),
    .clk(clk),
    .reset_n(reset_n));

// node:36 join undefined
assign req35 = req34_0;
assign ack34_0 = ack35;
// node:37 join undefined
assign req8 = req7_0;
assign ack7_0 = ack8;
// node:38 join undefined
assign req9 = req7_1;
assign ack7_1 = ack9;
// node:39 join undefined
assign req11 = req10_0;
assign ack10_0 = ack11;
// node:40 join undefined
assign req12 = req10_1;
assign ack10_1 = ack12;
// node:41 join undefined
assign req14 = req13_0;
assign ack13_0 = ack14;
// node:42 join undefined
assign req15 = req13_1;
assign ack13_1 = ack15;
// node:43 join undefined
assign req17 = req16_0;
assign ack16_0 = ack17;
// node:44 join undefined
assign req18 = req16_1;
assign ack16_1 = ack18;
// node:45 join undefined
assign req20 = req19_0;
assign ack19_0 = ack20;
// node:46 join undefined
assign req21 = req19_1;
assign ack19_1 = ack21;
// node:47 join undefined
assign req23 = req22_0;
assign ack22_0 = ack23;
// node:48 join undefined
assign req24 = req22_1;
assign ack22_1 = ack24;
// node:49 join undefined
assign req26 = req25_0;
assign ack25_0 = ack26;
// node:50 join undefined
assign req27 = req25_1;
assign ack25_1 = ack27;
// node:51 join undefined
assign req29 = req28_0;
assign ack28_0 = ack29;
// node:52 join undefined
assign req30 = req28_1;
assign ack28_1 = ack30;
// node:53 img_datapath
assign n53_k8_req = req38_0;
assign ack38_0 = n53_k8_ack;
assign n53_k9_req = req39_0;
assign ack39_0 = n53_k9_ack;
assign n53_k14_req = req40_0;
assign ack40_0 = n53_k14_ack;
assign req42 = n53_k1_req;
assign n53_k1_ack = ack42;
// node:20 initiator
assign i_odma_0_req = req57_0;
assign ack57_0 = i_odma_0_ack;
// node:21 initiator
assign i_odma_1_req = req59_0;
assign ack59_0 = i_odma_1_ack;
// node:23 initiator
assign i_odma_2_req = req61_0;
assign ack61_0 = i_odma_2_ack;
// node:25 initiator
assign i_odma_3_req = req62_0;
assign ack62_0 = i_odma_3_ack;
endmodule // piston_ctrl

// Wrapper around the generated SpinalHDL VmemDatArbOut1_1 (DMA=6, SLICE=16).
// Regenerate with `make -C libs/spinal clean vao`.  Each slice return carries a
// 3-bit DMA tag (in_out_num) naming the output DMA it is destined for.
module vmem_dat_arb_out_spinal_wrapper (
    input  wire          clk,
    input  wire          rst_n,

    // 16 Input interfaces
    input  wire  [15:0]  in_valid,
    output wire  [15:0]  in_ready,
    input  wire [511:0]  in_data,
    input  wire  [47:0]  in_out_num,

    // Order tracking for each DMA output (0-5)
    input  wire  [5:0]   order_wr_en,
    output wire  [5:0]   order_ready,
    input  wire  [23:0]  order_slice_index,

    // 6 Output interfaces
    output wire  [5:0]   out_valid,
    input  wire  [5:0]   out_ready,
    output wire [191:0]  out_data
);

    VmemDatArbOut1_1 vmem_arb_out_inst (
        .clk                    (clk),
        .resetn                 (rst_n),

        .io_in_data_0_valid    (in_valid[0]),
        .io_in_data_0_ready    (in_ready[0]),
        .io_in_data_0_payload  ({in_out_num[2:0], in_data[31:0]}),

        .io_in_data_1_valid    (in_valid[1]),
        .io_in_data_1_ready    (in_ready[1]),
        .io_in_data_1_payload  ({in_out_num[5:3], in_data[63:32]}),

        .io_in_data_2_valid    (in_valid[2]),
        .io_in_data_2_ready    (in_ready[2]),
        .io_in_data_2_payload  ({in_out_num[8:6], in_data[95:64]}),

        .io_in_data_3_valid    (in_valid[3]),
        .io_in_data_3_ready    (in_ready[3]),
        .io_in_data_3_payload  ({in_out_num[11:9], in_data[127:96]}),

        .io_in_data_4_valid    (in_valid[4]),
        .io_in_data_4_ready    (in_ready[4]),
        .io_in_data_4_payload  ({in_out_num[14:12], in_data[159:128]}),

        .io_in_data_5_valid    (in_valid[5]),
        .io_in_data_5_ready    (in_ready[5]),
        .io_in_data_5_payload  ({in_out_num[17:15], in_data[191:160]}),

        .io_in_data_6_valid    (in_valid[6]),
        .io_in_data_6_ready    (in_ready[6]),
        .io_in_data_6_payload  ({in_out_num[20:18], in_data[223:192]}),

        .io_in_data_7_valid    (in_valid[7]),
        .io_in_data_7_ready    (in_ready[7]),
        .io_in_data_7_payload  ({in_out_num[23:21], in_data[255:224]}),

        .io_in_data_8_valid    (in_valid[8]),
        .io_in_data_8_ready    (in_ready[8]),
        .io_in_data_8_payload  ({in_out_num[26:24], in_data[287:256]}),

        .io_in_data_9_valid    (in_valid[9]),
        .io_in_data_9_ready    (in_ready[9]),
        .io_in_data_9_payload  ({in_out_num[29:27], in_data[319:288]}),

        .io_in_data_10_valid    (in_valid[10]),
        .io_in_data_10_ready    (in_ready[10]),
        .io_in_data_10_payload  ({in_out_num[32:30], in_data[351:320]}),

        .io_in_data_11_valid    (in_valid[11]),
        .io_in_data_11_ready    (in_ready[11]),
        .io_in_data_11_payload  ({in_out_num[35:33], in_data[383:352]}),

        .io_in_data_12_valid    (in_valid[12]),
        .io_in_data_12_ready    (in_ready[12]),
        .io_in_data_12_payload  ({in_out_num[38:36], in_data[415:384]}),

        .io_in_data_13_valid    (in_valid[13]),
        .io_in_data_13_ready    (in_ready[13]),
        .io_in_data_13_payload  ({in_out_num[41:39], in_data[447:416]}),

        .io_in_data_14_valid    (in_valid[14]),
        .io_in_data_14_ready    (in_ready[14]),
        .io_in_data_14_payload  ({in_out_num[44:42], in_data[479:448]}),

        .io_in_data_15_valid    (in_valid[15]),
        .io_in_data_15_ready    (in_ready[15]),
        .io_in_data_15_payload  ({in_out_num[47:45], in_data[511:480]}),

        .io_dma_order_0_valid  (order_wr_en[0]),
        .io_dma_order_0_ready  (order_ready[0]),
        .io_dma_order_0_payload(order_slice_index[3:0]),

        .io_dma_order_1_valid  (order_wr_en[1]),
        .io_dma_order_1_ready  (order_ready[1]),
        .io_dma_order_1_payload(order_slice_index[7:4]),

        .io_dma_order_2_valid  (order_wr_en[2]),
        .io_dma_order_2_ready  (order_ready[2]),
        .io_dma_order_2_payload(order_slice_index[11:8]),

        .io_dma_order_3_valid  (order_wr_en[3]),
        .io_dma_order_3_ready  (order_ready[3]),
        .io_dma_order_3_payload(order_slice_index[15:12]),

        .io_dma_order_4_valid  (order_wr_en[4]),
        .io_dma_order_4_ready  (order_ready[4]),
        .io_dma_order_4_payload(order_slice_index[19:16]),

        .io_dma_order_5_valid  (order_wr_en[5]),
        .io_dma_order_5_ready  (order_ready[5]),
        .io_dma_order_5_payload(order_slice_index[23:20]),

        .io_out_data_0_valid   (out_valid[0]),
        .io_out_data_0_ready   (out_ready[0]),
        .io_out_data_0_payload (out_data[31:0]),

        .io_out_data_1_valid   (out_valid[1]),
        .io_out_data_1_ready   (out_ready[1]),
        .io_out_data_1_payload (out_data[63:32]),

        .io_out_data_2_valid   (out_valid[2]),
        .io_out_data_2_ready   (out_ready[2]),
        .io_out_data_2_payload (out_data[95:64]),

        .io_out_data_3_valid   (out_valid[3]),
        .io_out_data_3_ready   (out_ready[3]),
        .io_out_data_3_payload (out_data[127:96]),

        .io_out_data_4_valid   (out_valid[4]),
        .io_out_data_4_ready   (out_ready[4]),
        .io_out_data_4_payload (out_data[159:128]),

        .io_out_data_5_valid   (out_valid[5]),
        .io_out_data_5_ready   (out_ready[5]),
        .io_out_data_5_payload (out_data[191:160])
    );

endmodule

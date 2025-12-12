`timescale 10ps / 10ps

`default_nettype none

module duc_hb_cascade #(
    parameter integer WIDTH = 16,
    parameter integer RATIO = 4
) (
    input  wire logic [WIDTH-1:0] i_inph_data,
    input  wire logic [WIDTH-1:0] i_quad_data,
    output wire logic             o_ready,
    output wire logic [WIDTH-1:0] o_inph_data,
    output wire logic [WIDTH-1:0] o_quad_data,
    input  wire logic             i_ready,
    input  wire logic             i_clock,
    input  wire logic             i_reset
);

localparam integer MAX_STAGES = 4;
localparam integer NUM_STAGES = $clog2(RATIO);
localparam bit     RATIO_SUPPORTED = (RATIO == 2) || (RATIO == 4) || (RATIO == 8) || (RATIO == 16);

logic [WIDTH-1:0]   stage_inph_data [0:MAX_STAGES-1];
logic [WIDTH-1:0]   stage_quad_data [0:MAX_STAGES-1];
logic               stage_ready     [0:MAX_STAGES-1];
logic [2*WIDTH-1:0] skid_iq_data    [0:MAX_STAGES-2];
logic               skid_ready      [0:MAX_STAGES-2];

generate
    if (RATIO_SUPPORTED) begin : gen_supported
        genvar stage;
        for (stage = 0; stage < MAX_STAGES; stage = stage + 1) begin : gen_interp_stage
            if (stage < NUM_STAGES) begin : gen_active_stage
                if (stage == 0) begin : gen_first_stage
                    duc_hb_interp_fir_h0 #(.WIDTH(WIDTH))
                    interp_stage_inst (
                        .i_inph_data(i_inph_data                               ),
                        .i_quad_data(i_quad_data                               ),
                        .o_ready    (stage_ready[stage]                        ),
                        .o_inph_data(stage_inph_data[stage]                    ),
                        .o_quad_data(stage_quad_data[stage]                    ),
                        .i_ready    ((stage == NUM_STAGES - 1) ? i_ready : skid_ready[stage]),
                        .i_clock    (i_clock                                   ),
                        .i_reset    (i_reset                                   ));
                end else if (stage == 1) begin : gen_h0_stage
                    duc_hb_interp_fir_h0 #(.WIDTH(WIDTH))
                    interp_stage_inst (
                        .i_inph_data(skid_iq_data[stage-1][WIDTH-1:0]         ),
                        .i_quad_data(skid_iq_data[stage-1][2*WIDTH-1:WIDTH]   ),
                        .o_ready    (stage_ready[stage]                        ),
                        .o_inph_data(stage_inph_data[stage]                    ),
                        .o_quad_data(stage_quad_data[stage]                    ),
                        .i_ready    ((stage == NUM_STAGES - 1) ? i_ready : skid_ready[stage]),
                        .i_clock    (i_clock                                   ),
                        .i_reset    (i_reset                                   ));
                end else if (stage == 2) begin : gen_h1_stage
                    duc_hb_interp_fir_h1 #(.WIDTH(WIDTH))
                    interp_stage_inst (
                        .i_inph_data(skid_iq_data[stage-1][WIDTH-1:0]         ),
                        .i_quad_data(skid_iq_data[stage-1][2*WIDTH-1:WIDTH]   ),
                        .o_ready    (stage_ready[stage]                        ),
                        .o_inph_data(stage_inph_data[stage]                    ),
                        .o_quad_data(stage_quad_data[stage]                    ),
                        .i_ready    ((stage == NUM_STAGES - 1) ? i_ready : skid_ready[stage]),
                        .i_clock    (i_clock                                   ),
                        .i_reset    (i_reset                                   ));
                end else begin : gen_h2_stage
                    duc_hb_interp_fir_h2 #(.WIDTH(WIDTH))
                    interp_stage_inst (
                        .i_inph_data(skid_iq_data[stage-1][WIDTH-1:0]         ),
                        .i_quad_data(skid_iq_data[stage-1][2*WIDTH-1:WIDTH]   ),
                        .o_ready    (stage_ready[stage]                        ),
                        .o_inph_data(stage_inph_data[stage]                    ),
                        .o_quad_data(stage_quad_data[stage]                    ),
                        .i_ready    (i_ready                                   ),
                        .i_clock    (i_clock                                   ),
                        .i_reset    (i_reset                                   ));
                end
            end
        end

        for (stage = 0; stage < MAX_STAGES - 1; stage = stage + 1) begin : gen_skid
            if (stage < NUM_STAGES - 1) begin : gen_active_skid
                duc_skid #(
                    .WIDTH(2*WIDTH))
                skid_inst (
                    .i_clock    (i_clock                                        ),
                    .i_reset    (i_reset                                        ),
                    .i_in_data  ({ stage_quad_data[stage], stage_inph_data[stage] }),
                    .o_in_ready (skid_ready[stage]                               ),
                    .o_out_data (skid_iq_data[stage]                             ),
                    .i_out_ready(stage_ready[stage+1]                            ));
            end
        end

        assign o_ready = stage_ready[0];
        assign o_inph_data = stage_inph_data[NUM_STAGES-1];
        assign o_quad_data = stage_quad_data[NUM_STAGES-1];
    end else begin : gen_unsupported
        initial begin
            $fatal(1, "duc_hb_cascade RATIO=%0d unsupported; legal values are 2, 4, 8, and 16", RATIO);
        end

        assign o_ready = 1'b0;
        assign o_inph_data = '0;
        assign o_quad_data = '0;
    end
endgenerate

endmodule: duc_hb_cascade

`default_nettype wire

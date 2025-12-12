`timescale 10ps / 10ps

`default_nettype none

module ddc_hb_cascade #(
    parameter integer WIDTH = 16,
    parameter integer RATIO = 8
) (
    input  wire logic [WIDTH-1:0] i_inph_data,
    input  wire logic [WIDTH-1:0] i_quad_data,
    input  wire logic [WIDTH-1:0] i_inph_delay_data,
    input  wire logic [WIDTH-1:0] i_quad_delay_data,
    input  wire logic             i_valid,
    output      logic [WIDTH-1:0] o_inph_data,
    output      logic [WIDTH-1:0] o_quad_data,
    output      logic             o_valid,
    input  wire logic             i_clock,
    input  wire logic             i_reset
);

localparam integer MAX_STAGES = 4;
localparam integer NUM_STAGES = $clog2(RATIO);
localparam bit     RATIO_SUPPORTED = (RATIO == 2) || (RATIO == 4) || (RATIO == 8) || (RATIO == 16);

logic [WIDTH-1:0] stage_inph_data [0:MAX_STAGES-1];
logic [WIDTH-1:0] stage_quad_data [0:MAX_STAGES-1];
logic             stage_valid     [0:MAX_STAGES-1];

integer f0;
initial begin
    f0 = $fopen("h0_data.csv","w");
end

always_ff @(posedge i_clock) begin
    if (stage_valid[0]) begin
        $fwrite(f0,"%d, %d\n",$signed(stage_quad_data[0]), $signed(stage_inph_data[0]));
    end
end

generate
    if (RATIO_SUPPORTED) begin : gen_supported
        genvar stage;
        for (stage = 0; stage < MAX_STAGES; stage = stage + 1) begin : gen_decim_stage
            if (stage < NUM_STAGES) begin : gen_active_stage
                if (stage == 0) begin : gen_first_stage
                    ddc_hb_decim_firx2_h0 #(.WIDTH(WIDTH))
                    decim_stage_inst (
                        .i_inph_data      (i_inph_data             ),
                        .i_quad_data      (i_quad_data             ),
                        .i_inph_delay_data(i_inph_delay_data       ),
                        .i_quad_delay_data(i_quad_delay_data       ),
                        .i_valid          (i_valid                 ),
                        .o_inph_data      (stage_inph_data[stage]  ),
                        .o_quad_data      (stage_quad_data[stage]  ),
                        .o_valid          (stage_valid[stage]      ),
                        .i_clock          (i_clock                 ),
                        .i_reset          (i_reset                 ));
                end else if (stage == 1) begin : gen_h1_stage
                    ddc_hb_decim_fir_h1 #(.WIDTH(WIDTH))
                    decim_stage_inst (
                        .i_inph_data(stage_inph_data[stage-1]),
                        .i_quad_data(stage_quad_data[stage-1]),
                        .i_valid    (stage_valid[stage-1]    ),
                        .o_inph_data(stage_inph_data[stage]  ),
                        .o_quad_data(stage_quad_data[stage]  ),
                        .o_valid    (stage_valid[stage]      ),
                        .i_clock    (i_clock                 ),
                        .i_reset    (i_reset                 ));
                end else if (stage == 2) begin : gen_h2_stage
                    ddc_hb_decim_fir_h2 #(.WIDTH(WIDTH))
                    decim_stage_inst (
                        .i_inph_data(stage_inph_data[stage-1]),
                        .i_quad_data(stage_quad_data[stage-1]),
                        .i_valid    (stage_valid[stage-1]    ),
                        .o_inph_data(stage_inph_data[stage]  ),
                        .o_quad_data(stage_quad_data[stage]  ),
                        .o_valid    (stage_valid[stage]      ),
                        .i_clock    (i_clock                 ),
                        .i_reset    (i_reset                 ));
                end else begin : gen_h3_stage
                    ddc_hb_decim_fir_h3 #(.WIDTH(WIDTH))
                    decim_stage_inst (
                        .i_inph_data(stage_inph_data[stage-1]),
                        .i_quad_data(stage_quad_data[stage-1]),
                        .i_valid    (stage_valid[stage-1]    ),
                        .o_inph_data(stage_inph_data[stage]  ),
                        .o_quad_data(stage_quad_data[stage]  ),
                        .o_valid    (stage_valid[stage]      ),
                        .i_clock    (i_clock                 ),
                        .i_reset    (i_reset                 ));
                end
            end
        end

        assign o_inph_data = stage_inph_data[NUM_STAGES-1];
        assign o_quad_data = stage_quad_data[NUM_STAGES-1];
        assign o_valid = stage_valid[NUM_STAGES-1];
    end else begin : gen_unsupported
        initial begin
            $fatal(1, "ddc_hb_cascade RATIO=%0d unsupported; legal values are 2, 4, 8, and 16", RATIO);
        end

        assign o_inph_data = '0;
        assign o_quad_data = '0;
        assign o_valid = 1'b0;
    end
endgenerate

endmodule: ddc_hb_cascade

`default_nettype wire

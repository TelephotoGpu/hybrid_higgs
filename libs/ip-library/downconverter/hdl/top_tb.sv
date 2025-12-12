module top_tb #(
    parameter integer RATIO = 8
) (
    input  wire        i_clk,
    input  wire        i_rst_p,
    input  wire [31:0] i_seed,
    input  wire        rand_valid,
    input  wire        rand_ready
);

localparam integer DEPTH = 1536;

logic signed [15:0] mem_inph  [0:DEPTH-1];
logic signed [15:0] mem_delay [0:DEPTH-1];
logic [$clog2(DEPTH):0] read_addr;
logic signed [15:0] i_inph_data;
logic signed [15:0] i_inph_delay_data;
logic               i_valid;
logic signed [15:0] o_inph_data;
logic signed [15:0] o_quad_data;
logic               o_valid;
integer             f_out;

initial begin
    $readmemh("i_inph_data.mif", mem_inph);
    $readmemh("i_inph_delay_data.mif", mem_delay);
    f_out = $fopen("tb_output.csv", "w");
    i_inph_data = '0;
    i_inph_delay_data = '0;
    i_valid = 1'b0;
    read_addr = '0;
end

always_ff @(negedge i_clk) begin
    if (i_rst_p) begin
        i_inph_data <= '0;
        i_inph_delay_data <= '0;
        i_valid <= 1'b0;
        read_addr <= '0;
    end else begin
        if (o_valid) begin
            $fwrite(f_out, "%0d,%0d\n", $signed(o_inph_data), $signed(o_quad_data));
        end
        if (read_addr < DEPTH) begin
            i_inph_data <= mem_inph[read_addr];
            i_inph_delay_data <= mem_delay[read_addr];
            i_valid <= 1'b1;
            read_addr <= read_addr + 1'b1;
        end else begin
            i_inph_data <= '0;
            i_inph_delay_data <= '0;
            i_valid <= 1'b0;
        end
    end
end

downconverter #(
    .RATIO(RATIO))
DUT (
    .i_inph_data(i_inph_data),
    .i_inph_delay_data(i_inph_delay_data),
    .i_valid(i_valid),
    .o_inph_data(o_inph_data),
    .o_quad_data(o_quad_data),
    .o_valid(o_valid),
    .i_clock(i_clk),
    .i_reset(i_rst_p)
);

endmodule

module top_tb #(
    parameter integer RATIO = 4
) (
    input  wire        i_clk,
    input  wire        i_rst_p,
    input  wire [31:0] i_seed,
    input  wire        rand_valid,
    input  wire        rand_ready
);

localparam integer DEPTH = 640;
localparam integer LOG_CYCLES = (DEPTH * RATIO) + 512;

logic signed [15:0] mem_inph [0:DEPTH-1];
logic signed [15:0] mem_quad [0:DEPTH-1];
logic [$clog2(DEPTH):0] read_addr;
logic [$clog2(LOG_CYCLES + 1):0] log_count;
logic signed [15:0] i_inph_data;
logic signed [15:0] i_quad_data;
logic               o_ready;
logic signed [15:0] o_inph_data;
logic signed [15:0] o_quad_data;
logic               i_ready;
integer             f_out;

assign i_ready = 1'b1;

initial begin
    $readmemh("i_inph_data.mif", mem_inph);
    $readmemh("i_quad_data.mif", mem_quad);
    f_out = $fopen("tb_output.csv", "w");
    i_inph_data = '0;
    i_quad_data = '0;
    read_addr = '0;
    log_count = '0;
end

always_ff @(negedge i_clk) begin
    if (i_rst_p) begin
        i_inph_data <= '0;
        i_quad_data <= '0;
        read_addr <= '0;
        log_count <= '0;
    end else begin
        if (log_count < LOG_CYCLES) begin
            $fwrite(f_out, "%0d,%0d\n", $signed(o_inph_data), $signed(o_quad_data));
            log_count <= log_count + 1'b1;
        end
        if (o_ready && read_addr < DEPTH) begin
            i_inph_data <= mem_inph[read_addr];
            i_quad_data <= mem_quad[read_addr];
            read_addr <= read_addr + 1'b1;
        end else if (o_ready) begin
            i_inph_data <= '0;
            i_quad_data <= '0;
        end
    end
end

upconverter #(
    .RATIO(RATIO))
DUT (
    .i_inph_data(i_inph_data),
    .i_quad_data(i_quad_data),
    .o_ready(o_ready),
    .o_inph_data(o_inph_data),
    .o_quad_data(o_quad_data),
    .i_ready(i_ready),
    .i_clock(i_clk),
    .i_reset(i_rst_p)
);

endmodule

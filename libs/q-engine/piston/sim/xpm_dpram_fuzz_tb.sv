module dpram_reference #(
    parameter int DEPTH = 4096
) (
    input  wire        clk,
    input  wire [11:0] addr_0,
    input  wire [31:0] din_0,
    input  wire        we_0,
    input  wire        re_0,
    output reg  [31:0] dout_0,
    input  wire [11:0] addr_1,
    input  wire [31:0] din_1,
    input  wire        we_1,
    output reg  [31:0] dout_1
);
    reg [31:0] mem [DEPTH-1:0];

    always @(posedge clk) begin
        if (re_0)
            dout_0 <= mem[addr_0];
        if (we_0) begin
            mem[addr_0] <= din_0;
            dout_0 <= din_0;
        end
    end

    always @(posedge clk) begin
        dout_1 <= mem[addr_1];
        if (we_1) begin
            mem[addr_1] <= din_1;
            dout_1 <= din_1;
        end
    end
endmodule

module xpm_dpram_fuzz_tb;
    localparam int DEPTH = 4096;
    localparam int FUZZ_CYCLES = 20_000;

    logic clk = 1'b0;
    logic [11:0] addr_0 = '0;
    logic [31:0] din_0 = '0;
    logic we_0 = 1'b0;
    logic re_0 = 1'b0;
    logic [31:0] xpm_dout_0;
    logic [31:0] reference_dout_0;
    logic [11:0] addr_1 = '0;
    logic [31:0] din_1 = '0;
    logic we_1 = 1'b0;
    logic [31:0] xpm_dout_1;
    logic [31:0] reference_dout_1;
    int unsigned checks = 0;

    dpram #(
        .DEPTH(DEPTH)
    ) xilinx_dpram (
        .clk(clk),
        .addr_0(addr_0),
        .din_0(din_0),
        .we_0(we_0),
        .re_0(re_0),
        .dout_0(xpm_dout_0),
        .addr_1(addr_1),
        .din_1(din_1),
        .we_1(we_1),
        .dout_1(xpm_dout_1)
    );

    dpram_reference #(
        .DEPTH(DEPTH)
    ) reference_dpram (
        .clk(clk),
        .addr_0(addr_0),
        .din_0(din_0),
        .we_0(we_0),
        .re_0(re_0),
        .dout_0(reference_dout_0),
        .addr_1(addr_1),
        .din_1(din_1),
        .we_1(we_1),
        .dout_1(reference_dout_1)
    );

    always #4 clk = ~clk;

    task automatic check_outputs(input int cycle);
        if (xpm_dout_0 !== reference_dout_0 ||
            xpm_dout_1 !== reference_dout_1) begin
            $fatal(
                1,
                "Mismatch at cycle %0d: xpm=(%h,%h) reference=(%h,%h)",
                cycle,
                xpm_dout_0,
                xpm_dout_1,
                reference_dout_0,
                reference_dout_1
            );
        end
        checks += 2;
    endtask

    initial begin
        for (int index = 0; index < DEPTH; index += 2) begin
            @(negedge clk);
            addr_0 = index;
            din_0 = 32'hA500_0000 | index;
            we_0 = 1'b1;
            re_0 = 1'b1;
            addr_1 = index + 1;
            din_1 = 32'h5A00_0000 | (index + 1);
            we_1 = 1'b1;
            @(posedge clk);
            #1 check_outputs(index / 2);
        end

        for (int cycle = 0; cycle < FUZZ_CYCLES; cycle++) begin
            @(negedge clk);
            addr_0 = $urandom;
            addr_1 = $urandom;
            we_0 = $urandom_range(0, 1);
            we_1 = $urandom_range(0, 1);
            if ((we_0 || we_1) && addr_0 == addr_1)
                addr_1 = addr_1 + 1'b1;
            re_0 = $urandom_range(0, 1);
            din_0 = $urandom;
            din_1 = $urandom;

            @(posedge clk);
            #1 check_outputs(cycle + (DEPTH / 2));
        end

        $display("PASS: %0d XPM true-dual-port RAM comparisons", checks);
        $finish;
    end
endmodule

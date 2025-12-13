// XSIM clock wrapper for tb_stream_core.
module tb_stream;
   parameter MODE = 2;
   reg clk = 0;
   always #5 clk = ~clk;
   tb_stream_core #(.MODE(MODE)) core (.clk(clk));
endmodule

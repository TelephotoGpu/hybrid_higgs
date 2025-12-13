// XSIM clock wrapper for tb_dma_out_last_core.
module tb_dma_out_last;
   reg clk = 0;
   always #5 clk = ~clk;
   tb_dma_out_last_core core (.clk(clk));
endmodule

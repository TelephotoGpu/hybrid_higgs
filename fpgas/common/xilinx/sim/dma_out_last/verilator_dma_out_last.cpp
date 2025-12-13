// Verilator clock driver for tb_dma_out_last_core.
#include <verilated.h>
#include "Vtb_dma_out_last_core.h"

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);
  Vtb_dma_out_last_core *top = new Vtb_dma_out_last_core;
  top->clk = 0;
  top->eval();
  while (!Verilated::gotFinish()) {
    top->clk = 1;
    top->eval();
    top->clk = 0;
    top->eval();
  }
  top->final();
  delete top;
  return 0;
}

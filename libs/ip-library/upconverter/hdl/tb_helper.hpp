#ifndef __TB_HELPER__
#define __TB_HELPER__

#include <verilated_vcd_c.h>

template <class T>
class TBHELPER {
public:
  T *top;
  uint64_t* main_time;
  VerilatedVcdC* tfp = nullptr;
  unsigned char *clk;

  TBHELPER(T *top, uint64_t *main_time, VerilatedVcdC *tfp) {
    this->top = top;
    this->main_time = main_time;
    this->tfp = tfp;
    clk = &(top->i_clk);
  }

  void reset(unsigned count) {
    count += count % 2;
    if (count < 4) {
      count += 4 - count;
    }
    *clk = 0;
    top->i_rst_p = 1;
    for (unsigned i = 0; i < count; i++) {
      if (i + 2 >= count) {
        top->i_rst_p = 0;
      }
      (*main_time)++;
      *clk = !*clk;
      top->eval();
      if (tfp) {
        tfp->dump(*main_time);
      }
    }
    top->i_rst_p = 0;
  }

  void tick(unsigned count = 1) {
    for (unsigned i = 0; i < count; i++) {
      (*main_time)++;
      *clk = !*clk;
      top->eval();
      if (tfp) {
        tfp->dump(*main_time);
      }
      *clk = !*clk;
      (*main_time)++;
      top->eval();
      if (tfp) {
        tfp->dump(*main_time);
      }
    }
  }
};

#endif

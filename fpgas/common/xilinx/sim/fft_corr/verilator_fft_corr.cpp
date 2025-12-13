// Verilator driver for fft_corr; cycle-for-cycle mirror of tb_fft_corr.sv.
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <vector>

#include <verilated.h>
#include "Vfft_corr.h"

static Vfft_corr *top;
static int errors;
static long cyc;

static void fail(const char *msg) {
  ++errors;
  if (errors < 20) std::printf("MISMATCH cycle=%ld: %s\n", cyc, msg);
}

static void tick_half(int clk) {
  top->clk = clk;
  top->eval();
}

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);
  top = new Vfft_corr;
  const char *dir_arg = Verilated::commandArgsPlusMatch("DIR=");
  std::string dir = (dir_arg && *dir_arg) ? std::string(dir_arg + 5) : ".";

  unsigned n_in = 0, n_out = 0, npat = 0;
  FILE *fd = std::fopen((dir + "/meta.txt").c_str(), "r");
  if (!fd || std::fscanf(fd, "%u %u %u", &n_in, &n_out, &npat) != 3) return 2;
  std::fclose(fd);
  std::vector<uint32_t> in_d(n_in), ex_d(n_out);
  std::vector<int> in_l(n_in), in_c(n_in), in_e(n_in), in_w(n_in), ex_l(n_out), vpat(npat), rpat(npat);
  fd = std::fopen((dir + "/in.txt").c_str(), "r");
  for (unsigned a = 0; a < n_in; ++a)
    if (std::fscanf(fd, "%x %d %d %d %d", &in_d[a], &in_l[a], &in_c[a], &in_e[a], &in_w[a]) != 5) return 2;
  std::fclose(fd);
  fd = std::fopen((dir + "/exp.txt").c_str(), "r");
  for (unsigned a = 0; a < n_out; ++a)
    if (std::fscanf(fd, "%x %d", &ex_d[a], &ex_l[a]) != 2) return 2;
  std::fclose(fd);
  fd = std::fopen((dir + "/vpat.txt").c_str(), "r");
  for (unsigned a = 0; a < npat; ++a)
    if (std::fscanf(fd, "%d", &vpat[a]) != 1) return 2;
  std::fclose(fd);
  fd = std::fopen((dir + "/rpat.txt").c_str(), "r");
  for (unsigned a = 0; a < npat; ++a)
    if (std::fscanf(fd, "%d", &rpat[a]) != 1) return 2;
  std::fclose(fd);
  FILE *fo = std::fopen((dir + "/verilator_trace.csv").c_str(), "w");
  std::fprintf(fo, "cycle,event,data,last,err\n");

  top->srst = 1;
  top->t_valid = 0;
  top->i_ready = 0;
  top->err_clear = 0;
  top->t_data = 0;
  top->t_last = 0;
  tick_half(0);
  for (int k = 0; k < 4; ++k) {
    tick_half(1);
    tick_half(0);
  }
  top->srst = 0;

  unsigned idx = 0, oidx = 0;
  int presenting = 0, cleared = 0, prev_stall = 0, tail = 0;
  uint32_t prev_d = 0;
  int prev_l = 0;
  for (cyc = 0; (idx < n_in || oidx < n_out || tail < 64) && cyc < (long)npat + 200000; ++cyc) {
    int err_clear = 0;
    if (!presenting && idx < n_in) {
      if (in_c[idx] && !cleared) {
        err_clear = 1;
        cleared = 1;
      } else if (cyc >= (long)npat || vpat[cyc]) {
        presenting = 1;
      }
    }
    top->err_clear = err_clear;
    top->t_valid = presenting;
    top->t_data = idx < n_in ? in_d[idx] : 0;
    top->t_last = idx < n_in ? in_l[idx] : 0;
    top->i_ready = (idx >= n_in && oidx >= n_out) ? 1 : (cyc >= (long)npat ? 1 : rpat[cyc]);
    tick_half(0);

    const int in_fire = top->t_valid && top->t_ready;
    const int out_fire = top->i_valid && top->i_ready;
    if (prev_stall) {
      if (!top->i_valid)
        fail("i_valid dropped while stalled");
      else if (top->i_data != prev_d || top->i_last != prev_l)
        fail("output changed while stalled");
    }
    if (out_fire) {
      if (oidx >= n_out) {
        fail("unexpected extra output");
      } else if (top->i_data != ex_d[oidx] || top->i_last != ex_l[oidx]) {
        std::printf("  out %u: got %08x/%d exp %08x/%d\n", oidx, top->i_data, top->i_last,
                    ex_d[oidx], ex_l[oidx]);
        fail("output data/last mismatch");
      }
      std::fprintf(fo, "%ld,OUT,%08x,%d,%d\n", cyc, top->i_data, top->i_last, top->err);
      ++oidx;
    }
    if (in_fire)
      std::fprintf(fo, "%ld,IN,%08x,%d,%d\n", cyc, top->t_data, top->t_last, top->err);
    prev_stall = top->i_valid && !top->i_ready;
    prev_d = top->i_data;
    prev_l = top->i_last;

    tick_half(1);
    if (in_fire) {
      if ((int)top->err != in_e[idx]) {
        std::printf("  in %u: err %d exp %d\n", idx, top->err, in_e[idx]);
        fail("sticky error mismatch");
      }
      ++idx;
      presenting = 0;
      cleared = 0;
    }
    if (err_clear && top->err != 0) fail("err_clear did not clear");
    if (idx >= n_in && oidx >= n_out) ++tail;
  }
  if (idx != n_in || oidx != n_out) fail("timeout");
  std::fprintf(fo, "%ld,END,%08x,%d,%d\n", cyc, 0, 0, top->err);
  std::fclose(fo);
  if (errors == 0)
    std::printf("PASS: %u input beats, %u outputs, %ld cycles\n", n_in, n_out, cyc);
  else
    std::printf("FAIL: %d errors\n", errors);
  top->final();
  delete top;
  return errors ? 1 : 0;
}

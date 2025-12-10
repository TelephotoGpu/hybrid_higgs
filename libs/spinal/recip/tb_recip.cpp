// Unit test of the reciprocal netlist (build/recip/recip_unit.v): pushes all
// 65536 16-bit inputs (sign-extended to 18 bits) with random req gaps and
// random output backpressure, writes one result per line to argv[1]. Checked
// by libs/datapath/recip/recip_model.py check.
#include <cstdio>
#include <cstdint>
#include "Vrecip_unit.h"
#include "verilated.h"

static uint32_t lcg = 12345;
static uint32_t rnd() { lcg = lcg * 1103515245u + 12345u; return lcg >> 16; }

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Vrecip_unit *top = new Vrecip_unit;
    FILE *f = fopen(argc > 1 ? argv[1] : "got.txt", "w");
    const int n = 65536;
    int sent = 0, got = 0;
    top->clk = 0;
    top->reset_n = 0;
    top->t_x_req = 0;
    top->i_y_ack = 0;
    for (int i = 0; i < 4; i++) { top->clk ^= 1; top->eval(); }
    top->reset_n = 1;
    for (long cyc = 0; got < n; cyc++) {
        if (cyc > 20L * n) { fprintf(stderr, "timeout: sent %d got %d\n", sent, got); return 1; }
        if (!top->t_x_req && sent < n && rnd() % 4) {
            top->t_x_req = 1;
            top->t_x_dat = (uint32_t)(int32_t)(int16_t)sent & 0x3ffff;
        }
        top->i_y_ack = rnd() % 3 != 0;
        top->eval();
        bool in_fire = top->t_x_req && top->t_x_ack;
        if (top->i_y_req && top->i_y_ack) {
            fprintf(f, "%05x\n", top->i_y_dat & 0x3ffff);
            got++;
        }
        top->clk = 1; top->eval();
        top->clk = 0; top->eval();
        if (in_fire) { top->t_x_req = 0; sent++; }
    }
    fclose(f);
    printf("recip_unit: %d results\n", got);
    delete top;
    return 0;
}

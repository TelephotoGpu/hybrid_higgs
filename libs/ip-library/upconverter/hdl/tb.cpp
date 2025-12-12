#include <cstdlib>
#include <iostream>

#include <boost/program_options.hpp>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vtop_tb.h"
#include "tb_helper.hpp"

using namespace boost::program_options;

typedef Vtop_tb top_t;

VerilatedVcdC* tfp = nullptr;
top_t* top = new top_t;
vluint64_t main_time = 0;

double sc_time_stamp() { return main_time; }

static void preReset() {
    top->i_rst_p = 1;
    top->i_clk = 0;
    top->i_seed = 0;
    top->rand_valid = 0;
    top->rand_ready = 0;
}

int main(int argc, char** argv, char** env) {
    if (0 && argc && argv && env) {}

    Verilated::debug(0);
    Verilated::randReset(0);
    Verilated::traceEverOn(true);

    tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("wave_dump.vcd");

    int cycles = 4096;
    int seed_number = 1;
    try {
        options_description desc{"Options"};
        desc.add_options()
            ("help,h", "Help screen")
            ("cycles", value<int>()->default_value(cycles), "Simulation cycles")
            ("seed_value", value<int>()->default_value(seed_number), "Seed value");
        variables_map vm;
        store(parse_command_line(argc, argv, desc), vm);
        notify(vm);
        cycles = vm["cycles"].as<int>();
        seed_number = vm["seed_value"].as<int>();
        if (vm.count("help")) {
            std::cout << desc << '\n';
        }
    } catch (const error& ex) {
        std::cerr << ex.what() << '\n';
        return 2;
    }

    TBHELPER<top_t> helper(top, &main_time, tfp);
    preReset();
    top->i_seed = seed_number;
    helper.reset(40);
    helper.tick(cycles);

    top->final();
    if (tfp) {
        tfp->close();
    }
    delete top;
    return 0;
}

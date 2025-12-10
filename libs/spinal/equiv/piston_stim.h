// equiv.py --prelude for piston: q-engine instruction and DMA stimulus.
//
// Uniform random instruction words almost never move data through the
// datapath: unbalanced K ops deadlock the vector unit (an SK1 waits for a k1
// that needs LK8+LK9+LK14 queued behind it, SK2/LK10/LK11 have no source).
// This emits small balanced K-op groups instead, with random vector ops and
// fields, mostly MVXV with small rs1 so LK/SK addresses fall in vmem words
// 0..31, which the DMA stimulus fills with random data.
//
// Instruction (libs/riscv-baseband/c/inc/xbaseband.h): {rs1, S1[31:28],
// K[27:24], S2[23:20], RS1[19:15], OP[14:11], DS[10:7], 0x0b}. LK/SK take
// their per-lane vmem addresses from vector register S1.
#include <algorithm>
#include <vector>
#include "norecip.h"

static uint64_t piston_instr_word(int k) {
    // vector ops without the k15 scratch (MV_K15_V/MV_V_K15 need LK15/SK15
    // pairing with the vector ops, not modelled here)
    // half MVXV so that most vector registers hold small vmem addresses
    static const uint64_t ops[] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x8, 0x9,
                                   0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA, 0xA};
    uint64_t w = 0x0bULL | ((rng() & 0xF) << 7) | (ops[rng() % 18] << 11) | ((rng() & 0x1F) << 15) |
                 ((rng() & 0xF) << 20) | ((uint64_t)k << 24) | ((rng() & 0xF) << 28);
    // rs1: lane address [11:0] in words 0..31, permutation [15:12]
    return w | (((rng() & 0x1F) | (rng() & 0xF000)) << 32);
}

// held until accepted (fire_t_instr)
static uint64_t piston_instr() {
    static std::vector<int> prog;
    static uint64_t cur;
    static bool have = false;
    if (fire_t_instr || !have) {
        if (prog.empty()) {
            switch (rng() % 4) {
            case 0: prog = {0}; break;                       // KNOP
            case 1: case 2: {
                // datapath: LK14 (cfg), 1..4 LK8+LK9 beats, SK1. With random
                // cfg the datapath may want more beats, so an SK1 can still
                // block until the next random reset (--reset-rate).
                prog = {14};
                for (int b = 1 + rng() % 4; b; b--) {
                    std::vector<int> lk = {8, 9};
                    std::shuffle(lk.begin(), lk.end(), rng);
                    prog.insert(prog.end(), lk.begin(), lk.end());
                }
                prog.push_back(1);
                break;
            }
            default: prog = {13, 5}; break;                  // LK13 SK13
            }
        }
        cur = piston_instr_word(prog.front());
        prog.erase(prog.begin());
        have = true;
    }
    return cur;
}

// {we, addr[15:4] word, addr[3:0] bank, data}; words 0..31. The data has no
// m2c code 3 (norecip.h) in any 16-bit half, since any vmem word may be
// loaded by LK14.
static uint64_t piston_dma() {
    return ((rng() & 1ULL) << 48) | ((rng() & 0x1FFULL) << 32) | norecip_word((uint32_t)rng());
}

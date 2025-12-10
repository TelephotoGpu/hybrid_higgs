// Stimulus constraint for equivalence against the reqack reference, which
// has no reciprocal: in the FFT datapath k14 word, m2c_ac and m2c_cd of each
// cmul (16-bit half k, bits [1:0] and [9:8]) take 1/c on code 3, where the
// reference reads constant 1 (doc/kernel/NOTES.md §12). Code 3 is remapped
// to a random 0..2, so both netlists must agree.
#pragma once
#include <cstdint>

static uint32_t norecip_half(uint32_t h) {
    for (int b : {0, 8})
        if (((h >> b) & 3) == 3) h = (h & ~(3u << b)) | ((uint32_t)(rng() % 3) << b);
    return h;
}

static uint32_t norecip_word(uint32_t w) {
    return norecip_half(w & 0xFFFF) | (norecip_half(w >> 16) << 16);
}

// piston_dp: the 512-bit t_k14_dat (cmul fields are halves 0..7)
static void norecip_k14(uint32_t *k14) {
    for (int i = 0; i < 16; i++) k14[i] = norecip_word(k14[i]);
}

static bool norecip_code3(const uint32_t *k14) {
    for (int k = 0; k < 8; k++) {
        uint32_t h = (k14[k / 2] >> (16 * (k % 2))) & 0xFFFF;
        if ((h & 3) == 3 || ((h >> 8) & 3) == 3) return true;
    }
    return false;
}

// Full piston (--stop, needs --vflags=--public): vmem words written by SK
// ops can reach LK14 with code 3, which the stimulus cannot prevent. True
// when such a k14 enters the DUT datapath at the next rising edge; the
// netlists may differ from then on.
template <class M> static bool norecip_piston_code3(M *m) {
    auto &p = dut(m);
    return p.dp_t_k14_req && p.dp_t_k14_ack && norecip_code3(p.oumux_k14);
}

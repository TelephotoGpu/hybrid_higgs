#ifndef __CONFIG_WORD_CDIV_EQ_05_H__
#define __CONFIG_WORD_CDIV_EQ_05_H__

// Divide x / Re(y) on the FFT datapath reciprocal (doc/kernel/NOTES.md §12):
// config_word_cmul_eq_0f with m2c_ac = m2c_cd = 3 (1/c instead of a and c)
// and bs = 5, so each lane computes (a + jb) * (1/c + jd) as Q1.15; with
// d = 0 that is (a + jb) / c. Model: libs/datapath/recip/recip_model.py.
VMEM_SECTION unsigned short config_word_cdiv_eq_05 [32] = {
    0x4753, // cmul, ac = cd = 1/c
    0x4753,
    0x4753,
    0x4753,
    0x4753,
    0x4753,
    0x4753,
    0x4753,

    0x0000, 0x0000, // non-rx4

    0x0505,  // bs = 05
    0x0505,
    0x0505,
    0x0505,
    0x0505,
    0x0505,
    0x0505,
    0x0505,

    0x0202, // funnel   k8, k9
    0x0002,

    0, 0, 0, 0,
    0, 0, 0, 0,
    0, 0, 0, 0
};

#endif

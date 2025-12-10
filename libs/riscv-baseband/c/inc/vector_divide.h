#ifndef __VECTOR_DIVIDE__
#define __VECTOR_DIVIDE__

#include "vmem.h"

#ifndef VECTOR_DIVIDE_DONT_INCLUDE_CFG_WORDS
#include "config_word_cdiv_eq_05.h"
#endif

// out[i] = x[i] / Re(y[i]) (FFT datapath only, needs the reciprocal).
// Words are {im[31:16], re[15:0]} Q1.15; for y[i] = c + jd the result is
// x * (1/c + jd), so d must be 0 for a plain divide. |c| < 32 saturates
// 1/c to +-32767 (Q6.10), about 3 significant digits of precision
// (doc/kernel/NOTES.md §12). All arguments are vmem row addresses.
void vector_divide_1024(const unsigned int input_x, const unsigned int input_y, const unsigned int output_data_location);

#endif

#define VECTOR_DIVIDE_DONT_INCLUDE_CFG_WORDS
#include "vector_divide.h"
#undef VECTOR_DIVIDE_DONT_INCLUDE_CFG_WORDS

#define VECTOR_MULTIPLY_DONT_INCLUDE_CFG_WORDS
#include "vector_multiply.h"
#undef VECTOR_MULTIPLY_DONT_INCLUDE_CFG_WORDS

extern unsigned short config_word_cdiv_eq_05 [32];

void vector_divide_1024(const unsigned int input_x, const unsigned int input_y, const unsigned int output_data_location) {
    cfg_vector_multiply_1024(VMEM_ROW_ADDRESS(config_word_cdiv_eq_05), input_x, input_y, output_data_location);
}

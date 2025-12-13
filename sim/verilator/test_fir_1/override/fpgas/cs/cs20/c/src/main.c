#include "xbaseband.h"
#include "csr_control.h"
#include "vmem.h"
#include "fir_driver.h"
#include "fir_vectors.h"

VMEM_SECTION unsigned int fir_scratch_v[FIR_SCRATCH_WORDS];
VMEM_SECTION unsigned int fir_in_v[FIRV_WORDS];
VMEM_SECTION unsigned int fir_out_v[FIRV_OUTPUTS];

// Every operation is queued back to back (the driver only blocks for DMA
// schedule space) so header/payload chaining and stream ordering are
// exercised; the output is collected once at the end.
int main(void)
{
    for(unsigned int i = 0; i < FIRV_WORDS; i++) {
        fir_in_v[i] = firv_words[i];
    }
    for(unsigned int i = 0; i < FIRV_OUTPUTS; i++) {
        fir_out_v[i] = 0xa5a5a5a5;
    }

    fir_init(fir_scratch_v);

    for(unsigned int i = 0; i < FIRV_OPS; i++) {
        const firv_op_t *op = &firv_ops[i];
        switch(op->op) {
            case FIRV_OP_COEF:
                fir_load_coeffs(fir_in_v + op->offset, op->shift);
                break;
            case FIRV_OP_DATA:
                fir_filter(fir_in_v + op->offset, fir_out_v + op->out, op->n);
                break;
            case FIRV_OP_RESET:
                fir_reset();
                break;
            default:
                fir_send_raw(fir_in_v + op->offset, op->n, 0, 0);
                break;
        }
    }

    fir_wait();

    CSR_WRITE(DMA_1_START_ADDR, VMEM_DMA_ADDRESS(fir_out_v));
    CSR_WRITE(DMA_1_LENGTH, FIRV_OUTPUTS);
    CSR_WRITE(DMA_1_TIMER_VAL, 0xffffffff);
    CSR_WRITE_ZERO(SLICER);
    CSR_WRITE_ZERO(DMA_1_PUSH_SCHEDULE);

    while(1) {}
}

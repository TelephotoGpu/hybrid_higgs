#include "fir_driver.h"

void fir_init(void) {
}

int fir_load_coeffs(const unsigned int *vmem_coeffs, unsigned int shift) {
    if(shift > 31) {
        return FIR_EINVAL;
    }
    return qstream_send(FIR_PORT, FIR_HDR_LOAD_COEFFS(shift), vmem_coeffs, FIR_NTAPS);
}

int fir_reset(void) {
    return qstream_send(FIR_PORT, FIR_HDR_RESET, 0, 0);
}

int fir_filter(const unsigned int *in, unsigned int *out, unsigned int n) {
    return fir_filter_cb(in, out, n, 0, 0);
}

int fir_filter_cb(const unsigned int *in, unsigned int *out, unsigned int n,
                  qstream_cb_t cb, void *ctx) {
    if(n == 0) {
        return FIR_EINVAL;
    }
    const int r = qstream_expect(FIR_PORT, out, n, cb, ctx);
    if(r != QSTREAM_OK) {
        return r;
    }
    return qstream_send(FIR_PORT, FIR_HDR_DATA, in, n);
}

int fir_send_raw(const unsigned int *vmem_words, unsigned int n,
                 unsigned int *out, unsigned int out_n) {
    if(n == 0) {
        return FIR_EINVAL;
    }
    if(out_n != 0) {
        const int r = qstream_expect(FIR_PORT, out, out_n, 0, 0);
        if(r != QSTREAM_OK) {
            return r;
        }
    }
    return qstream_send_words(FIR_PORT, vmem_words, n);
}

unsigned int fir_last_tag(void) {
    return qstream_last_tag(FIR_PORT);
}

int fir_busy(void) {
    return qstream_busy();
}

int fir_wait(void) {
    return qstream_wait();
}

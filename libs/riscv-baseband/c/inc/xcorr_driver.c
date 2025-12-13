#include "xcorr_driver.h"

void xcorr_init(void) {
}

int xcorr_load_ref(const unsigned int *vmem_taps, unsigned int n) {
    if(n == 0 || n > XCORR_N) {
        return XCORR_EINVAL;
    }
    return qstream_send(XCORR_PORT, XCORR_HDR_LOAD_REF, vmem_taps, n);
}

int xcorr_reset(void) {
    return qstream_send(XCORR_PORT, XCORR_HDR_RESET, 0, 0);
}

int xcorr_correlate(const unsigned int *in, unsigned int *out, unsigned int n,
                    unsigned int mode, unsigned int shift) {
    return xcorr_correlate_cb(in, out, n, mode, shift, 0, 0);
}

int xcorr_correlate_cb(const unsigned int *in, unsigned int *out, unsigned int n,
                       unsigned int mode, unsigned int shift,
                       qstream_cb_t cb, void *ctx) {
    if(n == 0 || mode > XCORR_MODE_POW || shift > XCORR_MAX_SHIFT) {
        return XCORR_EINVAL;
    }
    const int r = qstream_expect(XCORR_PORT, out, n, cb, ctx);
    if(r != QSTREAM_OK) {
        return r;
    }
    return qstream_send(XCORR_PORT, XCORR_HDR(XCORR_OP_DATA, shift, mode), in, n);
}

int xcorr_send_raw(const unsigned int *vmem_words, unsigned int n,
                   unsigned int *out, unsigned int out_n) {
    if(n == 0) {
        return XCORR_EINVAL;
    }
    if(out_n != 0) {
        const int r = qstream_expect(XCORR_PORT, out, out_n, 0, 0);
        if(r != QSTREAM_OK) {
            return r;
        }
    }
    return qstream_send_words(XCORR_PORT, vmem_words, n);
}

unsigned int xcorr_last_tag(void) {
    return qstream_last_tag(XCORR_PORT);
}

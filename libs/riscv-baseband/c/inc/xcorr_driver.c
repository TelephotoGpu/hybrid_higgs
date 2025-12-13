#include "xcorr_driver.h"

void xcorr_init(void) {
}

int xcorr_load_cfg(const unsigned int *vmem_cfg, unsigned int shift, unsigned int mode) {
    if(shift > 31 || mode > XCORR_MODE_RB) {
        return XCORR_EINVAL;
    }
    return qstream_send(XCORR_PORT, XCORR_HDR(XCORR_OP_LOAD_CFG, shift, mode), vmem_cfg, XCORR_M);
}

int xcorr_reset(void) {
    return qstream_send(XCORR_PORT, XCORR_HDR_RESET, 0, 0);
}

int xcorr_correlate(const unsigned int *in, unsigned int *out, unsigned int n) {
    return xcorr_correlate_cb(in, out, n, 0, 0);
}

int xcorr_correlate_cb(const unsigned int *in, unsigned int *out, unsigned int n,
                       qstream_cb_t cb, void *ctx) {
    if(n == 0) {
        return XCORR_EINVAL;
    }
    const int r = qstream_expect(XCORR_PORT, out, n, cb, ctx);
    if(r != QSTREAM_OK) {
        return r;
    }
    return qstream_send(XCORR_PORT, XCORR_HDR_DATA, in, n);
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

// w * (i + jq) for w in {+1, -1, +j, -j}
static void rot(int *i, int *q, unsigned int w) {
    const int ri = *i, rq = *q;
    switch(w & 3) {
        case XCORR_W_P1: break;
        case XCORR_W_M1: *i = -ri; *q = -rq; break;
        case XCORR_W_PJ: *i = -rq; *q = ri; break;
        default:         *i = rq;  *q = -ri; break;
    }
}

static int s16(unsigned int v) {
    return (int)(short)(v & 0xffffu);
}

// a_k[n] = w_k a_{k-1}[n] + b_{k-1}[n - D_k], b_k[n] = w_k a_{k-1}[n] - b_{k-1}[n - D_k].
// Updated in place from high n to low so b[n - D] is still the old value.
// For a permutation the two terms never overlap, so every value stays exactly
// one of {0, +-amp, +-j amp}.
int xcorr_golay_pair_words(const unsigned char *p, const unsigned char *w,
                           unsigned int amp, unsigned int *a, unsigned int *b) {
    unsigned int seen = 0;
    if(amp == 0 || amp > 0x7fff) {
        return XCORR_EINVAL;
    }
    for(unsigned int k = 0; k < XCORR_M; k++) {
        if(p[k] >= XCORR_M || (seen & (1u << p[k])) || w[k] > 3) {
            return XCORR_EINVAL;
        }
        seen |= 1u << p[k];
    }
    for(unsigned int n = 0; n < XCORR_L; n++) {
        a[n] = 0;
        b[n] = 0;
    }
    a[0] = XCORR_SAMPLE(amp, 0);
    b[0] = XCORR_SAMPLE(amp, 0);
    for(unsigned int k = 0; k < XCORR_M; k++) {
        const unsigned int d = 1u << p[k];
        for(int n = XCORR_L - 1; n >= 0; n--) {
            int ai = s16(a[n]), aq = s16(a[n] >> 16);
            rot(&ai, &aq, w[k]);
            int bi = 0, bq = 0;
            if((unsigned int)n >= d) {
                bi = s16(b[n - d]);
                bq = s16(b[n - d] >> 16);
            }
            a[n] = XCORR_SAMPLE(ai + bi, aq + bq);
            b[n] = XCORR_SAMPLE(ai - bi, aq - bq);
        }
    }
    return XCORR_OK;
}

unsigned int xcorr_last_tag(void) {
    return qstream_last_tag(XCORR_PORT);
}

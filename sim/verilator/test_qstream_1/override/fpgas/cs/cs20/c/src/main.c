// qstream op interpreter (shared by test_qstream_1 and test_xcorr_fir_1).
//
// qs_vectors.h (from gen_vectors.py) holds a table of ops. The firmware
// builds its input in VMEM (xorshift32 noise, literal words, Golay pairs
// and correlator config words), then drives the FIR (port 0) and the Golay
// correlator (port 1) through the fir_driver / xcorr_driver / qstream
// libraries. Packets for both ports are queued back to back; qstream decodes
// each merge tag and routes the payload into that packet's out_v slot. A
// callback checks every arrival against the op that expected it. At the end
// out_v plus a status trailer is streamed out through DMA_1 and compared to
// the Python models (FIR + Golay) by the testbench.
#include "xbaseband.h"
#include "csr_control.h"
#include "vmem.h"
#include "qstream.h"
#include "fir_driver.h"
#include "xcorr_driver.h"
#include "qs_vectors.h"

#define TRAILER_WORDS (6)

VMEM_SECTION unsigned int qs_scratch_v[QSTREAM_SCRATCH_WORDS];
VMEM_SECTION unsigned int in_v[QV_WORDS];
VMEM_SECTION unsigned int out_v[QV_OUTPUTS + TRAILER_WORDS];

// Callback bookkeeping. Each expected packet's ctx encodes where it must
// land: (out_v offset << 12) | (n << 1) | port.
#define CTX(off, n, port) ((void *)(((off) << 12) | ((n) << 1) | (port)))
#define CB_ERR_PORT   (0x1)   // arrival for the wrong port
#define CB_ERR_DST    (0x2)   // dst/n differ from the expected packet
#define CB_ERR_ORDER  (0x4)   // per-port arrivals out of issue order
static unsigned int cb_err;
static unsigned int *cb_last_dst[QSTREAM_NPORTS];
static unsigned int cb_last_port;
static unsigned int cb_switches;
static unsigned int cb_arrivals;

static void on_output(unsigned port, unsigned seq, unsigned int *dst,
                      unsigned n, void *ctx) {
    const unsigned int c = (unsigned int)ctx;
    (void)seq;
    if((c & 1) != port) {
        cb_err |= CB_ERR_PORT;
    }
    if(dst != out_v + (c >> 12) || n != ((c >> 1) & 0x7ff)) {
        cb_err |= CB_ERR_DST;
    }
    if(port < QSTREAM_NPORTS) {
        if(cb_last_dst[port] != 0 && dst <= cb_last_dst[port]) {
            cb_err |= CB_ERR_ORDER;
        }
        cb_last_dst[port] = dst;
    }
    if(cb_arrivals != 0 && port != cb_last_port) {
        cb_switches++;
    }
    cb_last_port = port;
    cb_arrivals++;
}

static unsigned int rng;

static unsigned int xorshift32(void) {
    rng ^= rng << 13;
    rng ^= rng >> 17;
    rng ^= rng << 5;
    return rng;
}

// uniform in [-amp, amp] (modulo bias is fine; gen_vectors.py mirrors it)
static unsigned int rand_lane(unsigned int amp) {
    return (unsigned int)((int)(xorshift32() % (2 * amp + 1)) - (int)amp) & 0xffffu;
}

static void fill(unsigned int off, unsigned int n, unsigned int amp, unsigned int seed) {
    rng = seed;
    for(unsigned int i = 0; i < n; i++) {
        const unsigned int re = rand_lane(amp);
        const unsigned int im = rand_lane(amp);
        in_v[off + i] = (im << 16) | re;
    }
}

static void unpack_cfg(unsigned int pnib, unsigned int wbits,
                       unsigned char *p, unsigned char *w) {
    for(unsigned int k = 0; k < XCORR_M; k++) {
        p[k] = (pnib >> (4 * k)) & 0xf;
        w[k] = (wbits >> (2 * k)) & 0x3;
    }
}

static unsigned int fail_word;

static void check(int r) {
    if(r != 0 && fail_word == 0) {
        fail_word = 0xbad00000u | ((unsigned int)r & 0xffu);
    }
}

int main(void)
{
    unsigned char p[XCORR_M], w[XCORR_M];

    for(unsigned int i = 0; i < QV_OUTPUTS + TRAILER_WORDS; i++) {
        out_v[i] = 0xa5a5a5a5;
    }
    // ld_standard places .sbss outside the region crt zeroes, so small
    // statics start undefined (X in XSIM): initialize them explicitly.
    cb_err = 0;
    cb_last_dst[0] = cb_last_dst[1] = 0;
    cb_last_port = 0;
    cb_switches = 0;
    cb_arrivals = 0;
    fail_word = 0;
    rng = 1;

    qstream_init(qs_scratch_v);
    fir_init();
    xcorr_init();

    for(unsigned int i = 0; i < QV_OPS; i++) {
        const unsigned int *op = qv_ops[i];
        const unsigned int port = op[1], a = op[2], b = op[3], c = op[4], d = op[5];
        switch(op[0]) {
            case QV_OP_FILL:
                fill(a, b, c, d);
                break;
            case QV_OP_WORD:
                in_v[a] = c;
                break;
            case QV_OP_CFGW:
                unpack_cfg(c, d, p, w);
                for(unsigned int k = 0; k < XCORR_M; k++) {
                    in_v[a + k] = XCORR_CFG_WORD(p[k], w[k]);
                }
                break;
            case QV_OP_PAIR:
                unpack_cfg(c, d & 0xffffu, p, w);
                check(xcorr_golay_pair_words(p, w, d >> 16, in_v + a, in_v + a + XCORR_L));
                break;
            case QV_OP_FIR_COEF:
                check(fir_load_coeffs(in_v + a, c));
                break;
            case QV_OP_XC_CFG:
                check(xcorr_load_cfg(in_v + a, c, d));
                break;
            case QV_OP_DATA:
                if(port == FIR_PORT) {
                    check(fir_filter_cb(in_v + a, out_v + d, b, on_output, CTX(d, b, port)));
                } else {
                    check(xcorr_correlate_cb(in_v + a, out_v + d, b, on_output, CTX(d, b, port)));
                }
                break;
            case QV_OP_RESET:
                check(port == FIR_PORT ? fir_reset() : xcorr_reset());
                break;
            case QV_OP_RAW:
                check(qstream_send_raw(in_v + a, b));
                break;
            case QV_OP_WORDS:
                if(c != 0) {
                    check(qstream_expect(port, out_v + d, c, on_output, CTX(d, c, port)));
                }
                check(qstream_send_words(port, in_v + a, b));
                break;
            case QV_OP_BURST:
                // b one-sample FIR packets from in_v[a..]; after every c-th
                // (c != 0) also a one-sample correlator packet. Outputs
                // land consecutively from out_v[d] in issue order.
                for(unsigned int k = 0, x = a, o = d; k < b; k++) {
                    check(fir_filter_cb(in_v + x, out_v + o, 1, on_output, CTX(o, 1, FIR_PORT)));
                    x++;
                    o++;
                    if(c != 0 && k % c == 0) {
                        check(xcorr_correlate_cb(in_v + x, out_v + o, 1, on_output, CTX(o, 1, XCORR_PORT)));
                        x++;
                        o++;
                    }
                }
                break;
            case QV_OP_WAIT:
                check(qstream_wait());
                break;
            default:
                check(-99);
                break;
        }
    }

    check(qstream_wait());

    // volatile: otherwise dead-store eliminated (only DMA_1 reads them)
    volatile unsigned int *t = out_v + QV_OUTPUTS;
    t[0] = qstream_rx_count(FIR_PORT);
    t[1] = qstream_rx_count(XCORR_PORT);
    t[2] = fir_last_tag();
    t[3] = xcorr_last_tag();
    t[4] = (cb_err << 16) | qstream_errors() | fail_word;
    t[5] = 0x600d0000u | (cb_switches != 0 ? 0x100u : 0) | (cb_arrivals & 0xffu);

    CSR_WRITE(DMA_1_START_ADDR, VMEM_DMA_ADDRESS(out_v));
    CSR_WRITE(DMA_1_LENGTH, QV_OUTPUTS + TRAILER_WORDS);
    CSR_WRITE(DMA_1_TIMER_VAL, 0xffffffff);
    CSR_WRITE_ZERO(SLICER);
    CSR_WRITE_ZERO(DMA_1_PUSH_SCHEDULE);

    while(1) {}
}

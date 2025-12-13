#ifndef __XCORR_DRIVER_H__
#define __XCORR_DRIVER_H__

// Driver for the Q-engine FFT overlap-save cross-correlator (fft_corr,
// Xilinx builds only), on top of the qstream transport (qstream.h):
//
//   VMEM -> DMA_3 -> stream_router -> fft_corr (port 1) -> stream_merge
//        -> DMA_4 -> VMEM
//
// fft_corr correlates the input stream against an arbitrary complex
// reference ref[0..R-1] (1 <= R <= XCORR_N taps):
//
//   y[n] = sum_{i<R} conj(ref[i]) * x[n-R+1+i]
//
// so y peaks (at sum |ref|^2) on the last sample of a copy of ref. Each input
// sample produces one output, formatted per DATA packet:
//   XCORR_MODE_CPLX:  sat16(y >> shift) per lane (complex Q1.15 sample)
//   XCORR_MODE_POW:   satu32(|y|^2 >> shift) (unsigned 32-bit power)
// with rounding. The FFT uses 27-bit rails with fixed scaling: its error is
// about 1-2 LSB rms of an internal output whose LSB is 2^g in y units, where
// g = 2*log2(2*XCORR_N) - 1 - e and e (-10..16) is chosen at each reference
// load so the reference spectrum fills 18 bits. For a full-scale input and
// shift >= g the error is about 1 output LSB; small inputs (or shift < g)
// see the 2^g step.
// The input history persists across packets and reference loads;
// xcorr_reset() clears it. Power-up reference: {0x7fff}, so
// XCORR_MODE_CPLX with shift 15 passes the input through.
// Latency: a block of up to XCORR_N + 1 samples is transformed when full or
// at the end of a packet, so short packets each cost a full 2N-point FFT.
// See doc/add-fir/PLAN.md, "Phase 3".
// Samples are complex Q1.15: I in [15:0], Q in [31:16].

#include "qstream.h"

#define XCORR_PORT                (1)
#define XCORR_N                   (256)

#define XCORR_HDR_MAGIC           (0xFC0A0000u)
#define XCORR_OP_DATA             (0x1)
#define XCORR_OP_LOAD_REF         (0x2)
#define XCORR_OP_RESET            (0x3)
#define XCORR_HDR(op, shift, mode) (XCORR_HDR_MAGIC | ((((unsigned)(mode)) & 0x3u) << 14) \
                                   | ((((unsigned)(shift)) & 0x3fu) << 8) | ((unsigned)(op) & 0xfu))
#define XCORR_HDR_LOAD_REF        XCORR_HDR(XCORR_OP_LOAD_REF, 0, 0)
#define XCORR_HDR_RESET           XCORR_HDR(XCORR_OP_RESET, 0, 0)

#define XCORR_MODE_CPLX           (0)
#define XCORR_MODE_POW            (1)
#define XCORR_MAX_SHIFT           (63)

#define XCORR_SAMPLE(i, q)        ((((unsigned)(q) & 0xffffu) << 16) | ((unsigned)(i) & 0xffffu))

#define XCORR_OK                  (0)
#define XCORR_EINVAL              (-1)

// Call once after qstream_init() and before any other xcorr_* call.
void xcorr_init(void);

// Load n (1..XCORR_N) reference taps from VMEM. Produces no output. Blocks
// already sent use the old reference; the correlator stalls its input for
// about 3 * XCORR_N cycles while the new reference is transformed.
int xcorr_load_ref(const unsigned int *vmem_taps, unsigned int n);

// Clear the correlator history (the reference is kept). Produces no output.
int xcorr_reset(void);

// Correlate n samples from `in` into `out` (both VMEM, n >= 1) with output
// format mode (XCORR_MODE_*) and shift (0..XCORR_MAX_SHIFT). History carries
// over between calls.
int xcorr_correlate(const unsigned int *in, unsigned int *out, unsigned int n,
                    unsigned int mode, unsigned int shift);

// xcorr_correlate() that calls cb(XCORR_PORT, seq, out, n, ctx) from
// qstream_poll() once the output has landed.
int xcorr_correlate_cb(const unsigned int *in, unsigned int *out, unsigned int n,
                       unsigned int mode, unsigned int shift,
                       qstream_cb_t cb, void *ctx);

// Send `n` raw words as one port-1 packet (the driver prepends the route
// word; the caller supplies the header). If the packet produces output,
// `out_n` words are received into `out`; use out_n = 0 otherwise.
int xcorr_send_raw(const unsigned int *vmem_words, unsigned int n,
                   unsigned int *out, unsigned int out_n);

// The most recent merge tag received from the correlator port.
unsigned int xcorr_last_tag(void);

#endif /* __XCORR_DRIVER_H__ */

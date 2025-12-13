#ifndef __FIR_DRIVER_H__
#define __FIR_DRIVER_H__

// Driver for the Q-engine streaming complex FIR (Xilinx builds only), on
// top of the qstream transport (qstream.h):
//
//   VMEM -> DMA_3 -> stream_router -> fir_filter (port 0) -> stream_merge
//        -> DMA_4 -> VMEM
//
// Each call sends one packet [ROUTE(FIR_PORT)][FIR header][payload]. Output
// packets are received by qstream, which strips the merge tag word. See
// doc/add-fir/PLAN.md.
// Samples and coefficients are complex Q1.15: I in [15:0], Q in [31:16].
//
// All pointers are CPU pointers into VMEM (VMEM_SECTION buffers). Functions
// block only while waiting for DMA schedule space; call fir_wait() (or
// qstream_wait()) before reading output or reusing an input buffer.

#include "qstream.h"

#define FIR_NTAPS                 (16)
#define FIR_PORT                  (0)

#define FIR_DEFAULT_SHIFT         (15)

#define FIR_HDR_MAGIC             (0xF1F00000u)
#define FIR_OP_DATA               (0x1)
#define FIR_OP_LOAD_COEFFS        (0x2)
#define FIR_OP_RESET              (0x3)
#define FIR_HDR(op, shift)        (FIR_HDR_MAGIC | ((((unsigned)(shift)) & 0x1fu) << 8) | ((unsigned)(op) & 0xfu))
#define FIR_HDR_DATA              FIR_HDR(FIR_OP_DATA, 0)
#define FIR_HDR_RESET             FIR_HDR(FIR_OP_RESET, 0)
#define FIR_HDR_LOAD_COEFFS(shift) FIR_HDR(FIR_OP_LOAD_COEFFS, (shift))

#define FIR_SAMPLE(i, q)          ((((unsigned)(q) & 0xffffu) << 16) | ((unsigned)(i) & 0xffffu))

#define FIR_OK                    (0)
#define FIR_EINVAL                (-1)

// Call once after qstream_init() and before any other fir_* call.
void fir_init(void);

// Load FIR_NTAPS coefficients (h[0] multiplies the newest sample) and the
// output shift (0..31). History is kept. Produces no output.
int fir_load_coeffs(const unsigned int *vmem_coeffs, unsigned int shift);

// Clear the history (coefficients and shift are kept). Produces no output.
int fir_reset(void);

// Filter n samples from `in` into `out` (both VMEM, n >= 1). History carries
// over between calls, so a long stream may be split across calls.
int fir_filter(const unsigned int *in, unsigned int *out, unsigned int n);

// fir_filter() that calls cb(FIR_PORT, seq, out, n, ctx) from qstream_poll()
// once the output has landed.
int fir_filter_cb(const unsigned int *in, unsigned int *out, unsigned int n,
                  qstream_cb_t cb, void *ctx);

// Send `n` raw words from VMEM as one FIR packet (the driver prepends the
// route word; the caller supplies the FIR header word). If the packet produces
// output, `out_n` words are received into `out`; use out_n = 0 for packets
// with no output. Intended for tests and error injection.
int fir_send_raw(const unsigned int *vmem_words, unsigned int n,
                 unsigned int *out, unsigned int out_n);

// The most recent merge tag received from the FIR port (valid after
// fir_wait()). Its seq field counts FIR output packets modulo 256.
unsigned int fir_last_tag(void);

// Non-zero while any qstream work (either port) is queued or in flight.
int fir_busy(void);

// Block until fir_busy() is zero. Returns QSTREAM_OK, or QSTREAM_EPROTO
// after a fatal tag error (output buffers may then be unfilled).
int fir_wait(void);

#endif /* __FIR_DRIVER_H__ */

#ifndef __FIR_DRIVER_H__
#define __FIR_DRIVER_H__

// Driver for the Q-engine streaming complex FIR (Xilinx builds only).
//
//   VMEM -> DMA_3 (dma_out_last) -> fir_filter -> DMA_4 (dma_in) -> VMEM
//
// Every DMA_3 packet (words up to and including `last`) starts with one
// header word selecting DATA, LOAD_COEFFS or RESET. See doc/add-fir/PLAN.md.
// Samples and coefficients are complex Q1.15: I in [15:0], Q in [31:16].
//
// All pointers are CPU pointers into VMEM (VMEM_SECTION buffers). Functions
// block only while waiting for DMA schedule space; call fir_wait() before
// reading output or reusing an input buffer.

#define FIR_NTAPS                 (16)
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

// Words of VMEM scratch owned by the driver (holds the header words).
#define FIR_SCRATCH_WORDS         (3)

#define FIR_OK                    (0)
#define FIR_EINVAL                (-1)

// Must be called once before any other call. `vmem_scratch` must point to
// FIR_SCRATCH_WORDS words of VMEM reserved for the driver.
void fir_init(unsigned int *vmem_scratch);

// Load FIR_NTAPS coefficients (h[0] multiplies the newest sample) and the
// output shift (0..31). History is kept. Produces no output.
int fir_load_coeffs(const unsigned int *vmem_coeffs, unsigned int shift);

// Clear the history (coefficients and shift are kept). Produces no output.
int fir_reset(void);

// Filter n samples from `in` into `out` (both VMEM, n >= 1). History carries
// over between calls, so a long stream may be split across calls.
int fir_filter(const unsigned int *in, unsigned int *out, unsigned int n);

// Send `n` raw words from VMEM as one packet; the caller supplies the header
// word. If the packet produces output, `out_n` words are captured into `out`
// (DMA_4 is scheduled first); use out_n = 0 for packets with no output.
// Intended for tests and error injection.
int fir_send_raw(const unsigned int *vmem_words, unsigned int n,
                 unsigned int *out, unsigned int out_n);

// Non-zero while any FIR DMA work is scheduled or in flight.
int fir_busy(void);

// Block until fir_busy() is zero.
void fir_wait(void);

#endif /* __FIR_DRIVER_H__ */

#include "fir_driver.h"
#include "csr_control.h"
#include "vmem.h"

#define FIR_SLOT_DATA   (0)
#define FIR_SLOT_RESET  (1)
#define FIR_SLOT_COEFFS (2)
#define FIR_DMA_NOW     (0xffffffff)

static volatile unsigned int *fir_scratch;

static unsigned int dma3_occupancy(void) {
    unsigned int v;
    CSR_READ(DMA_3_SCHEDULE_OCCUPANCY, v);
    return v;
}

static unsigned int dma4_occupancy(void) {
    unsigned int v;
    CSR_READ(DMA_4_SCHEDULE_OCCUPANCY, v);
    return v;
}

static int dma3_busy(void) {
    // occupancy first: a schedule leaves the FIFO only once it is busy
    if(dma3_occupancy() != 0) {
        return 1;
    }
    unsigned int status;
    CSR_READ(DMA_3_STATUS, status);
    return (status & DMA_3_STATUS_BUSY) != 0;
}

// A full config FIFO silently drops pushes, so always wait for room.
static void dma3_wait_room(unsigned int slots) {
    while(dma3_occupancy() > DMA_3_SCHEDULE_DEPTH - slots) {}
}

static void dma4_wait_room(void) {
    while(dma4_occupancy() >= DMA_4_SCHEDULE_DEPTH) {}
}

static void dma3_push(const volatile unsigned int *vmem, unsigned int n, unsigned int last) {
    CSR_WRITE(DMA_3_START_ADDR, VMEM_DMA_ADDRESS(vmem));
    CSR_WRITE(DMA_3_LENGTH, n);
    CSR_WRITE(DMA_3_TIMER_VAL, FIR_DMA_NOW);
    CSR_WRITE(DMA_3_LAST_RTL, last);
    CSR_WRITE_ZERO(DMA_3_PUSH_SCHEDULE);
}

static void dma4_push(unsigned int *vmem, unsigned int n) {
    CSR_WRITE(DMA_4_START_ADDR, VMEM_DMA_ADDRESS(vmem));
    CSR_WRITE(DMA_4_LENGTH, n);
    CSR_WRITE(DMA_4_TIMER_VAL, FIR_DMA_NOW);
    CSR_WRITE_ZERO(DMA_4_LAST_RTL);
    CSR_WRITE_ZERO(DMA_4_PUSH_SCHEDULE);
}

void fir_init(unsigned int *vmem_scratch) {
    fir_scratch = vmem_scratch;
    fir_scratch[FIR_SLOT_DATA] = FIR_HDR_DATA;
    fir_scratch[FIR_SLOT_RESET] = FIR_HDR_RESET;
    fir_scratch[FIR_SLOT_COEFFS] = FIR_HDR_LOAD_COEFFS(FIR_DEFAULT_SHIFT);
    CSR_WRITE_ZERO(DMA_3_REVERSE);
    CSR_WRITE_ZERO(DMA_4_REVERSE);
}

int fir_load_coeffs(const unsigned int *vmem_coeffs, unsigned int shift) {
    if(shift > 31) {
        return FIR_EINVAL;
    }
    const unsigned int hdr = FIR_HDR_LOAD_COEFFS(shift);
    if(fir_scratch[FIR_SLOT_COEFFS] != hdr) {
        // an earlier queued load may still read the old header word
        while(dma3_busy()) {}
        fir_scratch[FIR_SLOT_COEFFS] = hdr;
    }
    dma3_wait_room(2);
    dma3_push(fir_scratch + FIR_SLOT_COEFFS, 1, 0);
    dma3_push(vmem_coeffs, FIR_NTAPS, 1);
    return FIR_OK;
}

int fir_reset(void) {
    dma3_wait_room(1);
    dma3_push(fir_scratch + FIR_SLOT_RESET, 1, 1);
    return FIR_OK;
}

int fir_filter(const unsigned int *in, unsigned int *out, unsigned int n) {
    if(n == 0) {
        return FIR_EINVAL;
    }
    // schedule the output side first so the FIR never waits on DMA_4
    dma4_wait_room();
    dma4_push(out, n);
    dma3_wait_room(2);
    dma3_push(fir_scratch + FIR_SLOT_DATA, 1, 0);
    dma3_push(in, n, 1);
    return FIR_OK;
}

int fir_send_raw(const unsigned int *vmem_words, unsigned int n,
                 unsigned int *out, unsigned int out_n) {
    if(n == 0) {
        return FIR_EINVAL;
    }
    if(out_n != 0) {
        dma4_wait_room();
        dma4_push(out, out_n);
    }
    dma3_wait_room(1);
    dma3_push(vmem_words, n, 1);
    return FIR_OK;
}

int fir_busy(void) {
    return dma4_occupancy() != 0 || dma3_busy();
}

void fir_wait(void) {
    while(fir_busy()) {}
}

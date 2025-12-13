#ifndef __QSTREAM_H__
#define __QSTREAM_H__

// qstream: packet transport over the Q-engine DMA_3 / DMA_4 stream path
// (Xilinx builds only). See doc/add-fir/PLAN.md, "Phase 2".
//
//   VMEM -> DMA_3 -> stream_router -> port 0 fir_filter  -> stream_merge -> DMA_4 -> VMEM
//                                  -> port 1 fft_corr    ->
//
// Transmit: every packet is [ROUTE word][module header][payload] with
// `last` on the final word. The route and header words come from a ring of
// driver-owned VMEM scratch slots, so caller buffers need no reserved words.
//
// Receive: the merge prefixes each output packet with a tag word
// (QSTREAM_TAG(port, seq)). The driver keeps a 1-word DMA_4 schedule armed
// for the next tag. When the tag lands, it decodes the port and pops that
// port's next expected {dst, n} (registered with qstream_expect()). It then
// schedules DMA_4 for n words straight into dst and re-arms the next tag.
// A job completes only after its schedule retires and dst[n-1] has visibly
// changed from a sentinel the driver stores there. DMA_4 is the lowest
// priority VMEM writer, so its last words can trail the schedule.
// Output packets from different ports may therefore arrive in any
// interleaving; within a port they arrive in order.
//
// Every blocking loop services the receive side, so a full DMA_3 schedule
// FIFO cannot deadlock against a stalled merge. All pointers are CPU
// pointers into VMEM (VMEM_SECTION buffers).

#define QSTREAM_MAGIC             (0x5271u)
#define QSTREAM_ROUTE(port)       ((QSTREAM_MAGIC << 16) | ((unsigned)(port) & 0xfu))
#define QSTREAM_TAG(port, seq)    ((QSTREAM_MAGIC << 16) | ((((unsigned)(seq)) & 0xffu) << 4) | ((unsigned)(port) & 0xfu))
#define QSTREAM_TAG_PORT(tag)     ((tag) & 0xfu)
#define QSTREAM_TAG_SEQ(tag)      (((tag) >> 4) & 0xffu)
#define QSTREAM_TAG_VALID(tag)    (((tag) >> 16) == QSTREAM_MAGIC && ((tag) & 0xf000u) == 0)

#define QSTREAM_NPORTS            (2)
#define QSTREAM_TX_SLOTS          (8)     // [route, hdr] pairs in flight
#define QSTREAM_TAG_SLOTS         (4)
#define QSTREAM_SCRATCH_WORDS     (2 * QSTREAM_TX_SLOTS + QSTREAM_TAG_SLOTS)
#define QSTREAM_RXQ_DEPTH         (16)    // expected output packets per port

#define QSTREAM_OK                (0)
#define QSTREAM_EINVAL            (-1)
#define QSTREAM_EPROTO            (-2)    // unrecoverable receive error

// qstream_errors() bits (sticky until qstream_init)
#define QSTREAM_ERR_TAG_MAGIC     (0x1)   // tag word without the magic
#define QSTREAM_ERR_TAG_PORT      (0x2)   // tag for a port with nothing expected
#define QSTREAM_ERR_TAG_SEQ       (0x4)   // tag seq differs from the expected seq

// Called from qstream_poll() when an expected packet has fully landed.
typedef void (*qstream_cb_t)(unsigned port, unsigned seq, unsigned int *dst,
                             unsigned n, void *ctx);

// `vmem_scratch` must point to QSTREAM_SCRATCH_WORDS words of VMEM owned by
// the driver. Resets the driver's view of the tag sequence numbers, so call
// it only while the hardware is idle (for example once at boot).
void qstream_init(unsigned int *vmem_scratch);

// Queue one packet [ROUTE(port)][hdr][payload[0..n-1]]. n may be 0
// (header-only packet). Blocks only for DMA_3 schedule space.
int qstream_send(unsigned port, unsigned hdr, const unsigned int *payload, unsigned n);

// Queue [ROUTE(port)][words[0..n-1]]: the caller supplies the header word.
int qstream_send_words(unsigned port, const unsigned int *words, unsigned n);

// Queue words[0..n-1] as one packet with no route word (tests, bad routes).
int qstream_send_raw(const unsigned int *words, unsigned n);

// Register the next output packet from `port`: n >= 1 words into dst.
// Must be called before the packet that produces it is sent. `cb` may be 0.
int qstream_expect(unsigned port, unsigned int *dst, unsigned n,
                   qstream_cb_t cb, void *ctx);

// Service the receive side. Returns the number of expected packets that
// completed during this call, or QSTREAM_EPROTO after a fatal tag error.
int qstream_poll(void);

// Number of expected packets not yet completed (all ports).
unsigned qstream_pending(void);

// Non-zero while any transmit or receive work is queued or in flight.
int qstream_busy(void);

// Block until qstream_busy() is zero. Returns QSTREAM_OK or QSTREAM_EPROTO.
int qstream_wait(void);

// Sticky QSTREAM_ERR_* bits.
unsigned qstream_errors(void);

// The most recent tag word received for `port` (0 before any).
unsigned qstream_last_tag(unsigned port);

// Number of output packets received for `port` since qstream_init().
unsigned qstream_rx_count(unsigned port);

#endif /* __QSTREAM_H__ */

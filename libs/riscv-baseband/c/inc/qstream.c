#include "qstream.h"
#include "csr_control.h"
#include "vmem.h"

#define QS_DMA_NOW      (0xffffffffu)
#define QS_TAG_BASE     (2 * QSTREAM_TX_SLOTS)
#define QS_JOBQ_DEPTH   (4)
// dma_in retires a schedule when its last write enters the VMEM arbiter, which
// is fixed-priority with DMA_4 lowest, so the final few words may land after
// the CPU sees the schedule complete. A job therefore also waits until
// dst[n-1] no longer holds this sentinel (DMA_4 writes land in order). Data
// equal to the sentinel falls back to QS_DRAIN_POLLS extra polls.
#define QS_SENTINEL     (0x7ffe8001u)
#define QS_DRAIN_POLLS  (8)

#define QS_BARRIER()    __asm__ volatile("" ::: "memory")

typedef struct {
    unsigned int *dst;
    unsigned n;
    qstream_cb_t cb;
    void *ctx;
} qs_expect_t;

typedef struct {
    qs_expect_t e;
    unsigned port;
    unsigned seq;
    unsigned sched;     // DMA_4 schedule index of the payload
    unsigned drain;     // polls spent waiting for dst[n-1] to land
} qs_job_t;

static volatile unsigned int *qs_scratch;

// DMA schedule counters: completed = pushed - occupancy (a schedule leaves
// the CSR FIFO only when its last read/write has been issued).
static unsigned qs_d3_pushed;
static unsigned qs_d4_pushed;

static unsigned qs_tx_next;
static unsigned qs_tx_sched[QSTREAM_TX_SLOTS];
static unsigned char qs_tx_used[QSTREAM_TX_SLOTS];

static qs_expect_t qs_rxq[QSTREAM_NPORTS][QSTREAM_RXQ_DEPTH];
static unsigned qs_rxq_head[QSTREAM_NPORTS];
static unsigned qs_rxq_count[QSTREAM_NPORTS];
static unsigned qs_unassigned;
static unsigned qs_pending;

static qs_job_t qs_jobq[QS_JOBQ_DEPTH];
static unsigned qs_jobq_head;
static unsigned qs_jobq_count;

static int qs_tag_armed;
static unsigned qs_tag_slot;
static unsigned qs_tag_sched;

static unsigned qs_rx_seq[QSTREAM_NPORTS];
static unsigned qs_rx_count[QSTREAM_NPORTS];
static unsigned qs_last_tag[QSTREAM_NPORTS];
static unsigned qs_err;
static int qs_dead;

static unsigned d3_occupancy(void) {
    unsigned v;
    CSR_READ(DMA_3_SCHEDULE_OCCUPANCY, v);
    return v;
}

static unsigned d4_occupancy(void) {
    unsigned v;
    CSR_READ(DMA_4_SCHEDULE_OCCUPANCY, v);
    return v;
}

static int d3_idle(void) {
    // occupancy first: a schedule leaves the FIFO only once it is busy
    if(d3_occupancy() != 0) {
        return 0;
    }
    unsigned status;
    CSR_READ(DMA_3_STATUS, status);
    return (status & DMA_3_STATUS_BUSY) == 0;
}

static unsigned d3_completed(void) {
    return qs_d3_pushed - d3_occupancy();
}

static unsigned d4_completed(void) {
    return qs_d4_pushed - d4_occupancy();
}

// true when schedule index `sched` has completed given `completed` schedules
static int sched_done(unsigned completed, unsigned sched) {
    return (int)(completed - sched) > 0;
}

static void d3_push(const volatile unsigned int *vmem, unsigned n, unsigned last) {
    QS_BARRIER();
    CSR_WRITE(DMA_3_START_ADDR, VMEM_DMA_ADDRESS(vmem));
    CSR_WRITE(DMA_3_LENGTH, n);
    CSR_WRITE(DMA_3_TIMER_VAL, QS_DMA_NOW);
    CSR_WRITE(DMA_3_LAST_RTL, last);
    CSR_WRITE_ZERO(DMA_3_PUSH_SCHEDULE);
    qs_d3_pushed++;
}

static unsigned d4_push(volatile unsigned int *vmem, unsigned n) {
    QS_BARRIER();
    CSR_WRITE(DMA_4_START_ADDR, VMEM_DMA_ADDRESS(vmem));
    CSR_WRITE(DMA_4_LENGTH, n);
    CSR_WRITE(DMA_4_TIMER_VAL, QS_DMA_NOW);
    CSR_WRITE_ZERO(DMA_4_LAST_RTL);
    CSR_WRITE_ZERO(DMA_4_PUSH_SCHEDULE);
    return qs_d4_pushed++;
}

void qstream_init(unsigned int *vmem_scratch) {
    qs_scratch = vmem_scratch;
    for(unsigned i = 0; i < QSTREAM_SCRATCH_WORDS; i++) {
        qs_scratch[i] = 0;
    }
    qs_d3_pushed = d3_occupancy();
    qs_d4_pushed = d4_occupancy();
    qs_tx_next = 0;
    for(unsigned i = 0; i < QSTREAM_TX_SLOTS; i++) {
        qs_tx_used[i] = 0;
    }
    for(unsigned p = 0; p < QSTREAM_NPORTS; p++) {
        qs_rxq_head[p] = 0;
        qs_rxq_count[p] = 0;
        qs_rx_seq[p] = 0;
        qs_rx_count[p] = 0;
        qs_last_tag[p] = 0;
    }
    qs_unassigned = 0;
    qs_pending = 0;
    qs_jobq_head = 0;
    qs_jobq_count = 0;
    qs_tag_armed = 0;
    qs_tag_slot = 0;
    qs_err = 0;
    qs_dead = 0;
    CSR_WRITE_ZERO(DMA_3_REVERSE);
    CSR_WRITE_ZERO(DMA_4_REVERSE);
}

// ------------------------------------------------------------------ receive
static int rx_take_tag(void) {
    volatile unsigned int *slot = qs_scratch + QS_TAG_BASE + qs_tag_slot;
    const unsigned tag = *slot;
    if(tag == 0) {
        return 0;   // DMA_4 write issued but not yet visible; retry
    }
    *slot = 0;
    qs_tag_armed = 0;
    qs_tag_slot = (qs_tag_slot + 1) % QSTREAM_TAG_SLOTS;

    if(!QSTREAM_TAG_VALID(tag)) {
        qs_err |= QSTREAM_ERR_TAG_MAGIC;
        qs_dead = 1;
        return QSTREAM_EPROTO;
    }
    const unsigned port = QSTREAM_TAG_PORT(tag);
    if(port >= QSTREAM_NPORTS || qs_rxq_count[port] == 0) {
        qs_err |= QSTREAM_ERR_TAG_PORT;
        qs_dead = 1;
        return QSTREAM_EPROTO;
    }
    const unsigned seq = QSTREAM_TAG_SEQ(tag);
    if(seq != (qs_rx_seq[port] & 0xffu)) {
        qs_err |= QSTREAM_ERR_TAG_SEQ;
    }
    qs_rx_seq[port] = seq + 1;
    qs_rx_count[port]++;
    qs_last_tag[port] = tag;

    const qs_expect_t e = qs_rxq[port][qs_rxq_head[port]];
    qs_rxq_head[port] = (qs_rxq_head[port] + 1) % QSTREAM_RXQ_DEPTH;
    qs_rxq_count[port]--;
    qs_unassigned--;

    qs_job_t *j = &qs_jobq[(qs_jobq_head + qs_jobq_count) % QS_JOBQ_DEPTH];
    j->e = e;
    j->port = port;
    j->seq = seq;
    j->drain = 0;
    ((volatile unsigned int *)e.dst)[e.n - 1] = QS_SENTINEL;
    j->sched = d4_push(e.dst, e.n);
    qs_jobq_count++;
    return 1;
}

int qstream_poll(void) {
    int done = 0;
    if(qs_dead) {
        return QSTREAM_EPROTO;
    }
    while(1) {
        const unsigned completed = d4_completed();
        while(qs_jobq_count != 0 && sched_done(completed, qs_jobq[qs_jobq_head].sched)) {
            qs_job_t *j = &qs_jobq[qs_jobq_head];
            if(((volatile unsigned int *)j->e.dst)[j->e.n - 1] == QS_SENTINEL
               && j->drain++ < QS_DRAIN_POLLS) {
                break;
            }
            qs_jobq_head = (qs_jobq_head + 1) % QS_JOBQ_DEPTH;
            qs_jobq_count--;
            qs_pending--;
            done++;
            if(j->e.cb) {
                j->e.cb(j->port, j->seq, j->e.dst, j->e.n, j->e.ctx);
            }
        }
        if(qs_tag_armed && sched_done(completed, qs_tag_sched)) {
            const int r = rx_take_tag();
            if(r < 0) {
                return r;
            }
            if(r > 0) {
                continue;
            }
            break;
        }
        if(!qs_tag_armed && qs_unassigned != 0 && qs_jobq_count < QS_JOBQ_DEPTH
           && d4_occupancy() < DMA_4_SCHEDULE_DEPTH) {
            qs_tag_sched = d4_push(qs_scratch + QS_TAG_BASE + qs_tag_slot, 1);
            qs_tag_armed = 1;
            continue;
        }
        break;
    }
    return done;
}

int qstream_expect(unsigned port, unsigned int *dst, unsigned n,
                   qstream_cb_t cb, void *ctx) {
    if(port >= QSTREAM_NPORTS || n == 0) {
        return QSTREAM_EINVAL;
    }
    while(qs_rxq_count[port] == QSTREAM_RXQ_DEPTH) {
        if(qstream_poll() < 0) {
            return QSTREAM_EPROTO;
        }
    }
    qs_expect_t *e = &qs_rxq[port][(qs_rxq_head[port] + qs_rxq_count[port]) % QSTREAM_RXQ_DEPTH];
    e->dst = dst;
    e->n = n;
    e->cb = cb;
    e->ctx = ctx;
    qs_rxq_count[port]++;
    qs_unassigned++;
    qs_pending++;
    qstream_poll();
    return QSTREAM_OK;
}

// ------------------------------------------------------------------ transmit
static int d3_wait_room(unsigned slots) {
    while(d3_occupancy() > DMA_3_SCHEDULE_DEPTH - slots) {
        if(qstream_poll() < 0) {
            return QSTREAM_EPROTO;
        }
    }
    return QSTREAM_OK;
}

// A slot may be rewritten once a later DMA_3 schedule has also completed
// (its reads are then long past) or DMA_3 is idle.
static int tx_slot_acquire(unsigned *out) {
    const unsigned s = qs_tx_next;
    while(qs_tx_used[s] && !sched_done(d3_completed(), qs_tx_sched[s] + 1) && !d3_idle()) {
        if(qstream_poll() < 0) {
            return QSTREAM_EPROTO;
        }
    }
    qs_tx_next = (s + 1) % QSTREAM_TX_SLOTS;
    *out = s;
    return QSTREAM_OK;
}

static int tx_packet(unsigned port, int with_hdr, unsigned hdr,
                     const unsigned int *payload, unsigned n) {
    unsigned s;
    if(port >= QSTREAM_NPORTS) {
        return QSTREAM_EINVAL;
    }
    if(tx_slot_acquire(&s) < 0 || d3_wait_room(n ? 2 : 1) < 0) {
        return QSTREAM_EPROTO;
    }
    volatile unsigned int *pair = qs_scratch + 2 * s;
    pair[0] = QSTREAM_ROUTE(port);
    pair[1] = hdr;
    qs_tx_used[s] = 1;
    qs_tx_sched[s] = qs_d3_pushed;
    d3_push(pair, with_hdr ? 2 : 1, n == 0);
    if(n != 0) {
        d3_push(payload, n, 1);
    }
    qstream_poll();
    return QSTREAM_OK;
}

int qstream_send(unsigned port, unsigned hdr, const unsigned int *payload, unsigned n) {
    return tx_packet(port, 1, hdr, payload, n);
}

int qstream_send_words(unsigned port, const unsigned int *words, unsigned n) {
    return tx_packet(port, 0, 0, words, n);
}

int qstream_send_raw(const unsigned int *words, unsigned n) {
    if(n == 0) {
        return QSTREAM_EINVAL;
    }
    if(d3_wait_room(1) < 0) {
        return QSTREAM_EPROTO;
    }
    d3_push(words, n, 1);
    qstream_poll();
    return QSTREAM_OK;
}

// ------------------------------------------------------------------ status
unsigned qstream_pending(void) {
    return qs_pending;
}

int qstream_busy(void) {
    return qs_pending != 0 || !d3_idle();
}

int qstream_wait(void) {
    while(qstream_busy()) {
        if(qstream_poll() < 0) {
            return QSTREAM_EPROTO;
        }
    }
    return QSTREAM_OK;
}

unsigned qstream_errors(void) {
    return qs_err;
}

unsigned qstream_last_tag(unsigned port) {
    return port < QSTREAM_NPORTS ? qs_last_tag[port] : 0;
}

unsigned qstream_rx_count(unsigned port) {
    return port < QSTREAM_NPORTS ? qs_rx_count[port] : 0;
}

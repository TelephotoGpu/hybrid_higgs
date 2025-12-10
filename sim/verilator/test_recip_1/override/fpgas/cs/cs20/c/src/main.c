// test_recip_1: vector_divide_1024() on the FFT datapath reciprocal against
// the bit-exact model (libs/datapath/recip/recip_model.py, see Makefile).
#include "xbaseband.h"
#include "vmem.h"
#include "csr_control.h"
#include "ringbus.h"

#include "ringbus2_pre.h"
#define OUR_RING_ENUM RING_ENUM_CS20
#include "ringbus2_post.h"

#include "vector_divide.h"
#include "vector_multiply.h"
#include "recip_vectors.h"

#include "vmalloc.h"
VMalloc mgr;

// fence row, token rows 1 and 2 (as image_kernel.c img_fence)
VMEM_SECTION unsigned int fence_mem[3 * 16];
static unsigned int fence_token;

void report_test_results(unsigned int data)
{
  unsigned int occupancy;

  while(1)
  {
   CSR_READ(RINGBUS_SCHEDULE_OCCUPANCY, occupancy);
   if(occupancy < RINGBUS_SCHEDULE_DEPTH)
   {
    break;
   }
  }

  CSR_WRITE(RINGBUS_WRITE_ADDR, RING_ADDR_PC);
  CSR_WRITE(RINGBUS_WRITE_DATA, data);
  CSR_WRITE(RINGBUS_WRITE_EN, 0);
}

// Wait until every earlier SK1 has landed: LK13 of a token row, SK13 to
// the fence row (the store mux is in order), poll the token.
static void fence(void) {
  volatile unsigned int *f = fence_mem;
  const unsigned int tok = fence_token == 1 ? 2 : 1;
  fence_token = tok;
  const unsigned int row = VMEM_ROW_ADDRESS(fence_mem);
  MVXV_KNOP(V12, row + tok);
  VNOP_LK13(V12);
  MVXV_KNOP(V13, row);
  VNOP_SK13(V13);
  asm volatile("" ::: "memory");
  while (f[0] != tok) {
  }
  asm volatile("" ::: "memory");
}

// timer ticks of op(x, y, out) + fence, as a throughput reference
static unsigned int timed(void (*op)(unsigned int, unsigned int, unsigned int), unsigned int out_row) {
  unsigned int t0, t1;
  CSR_READ(TIMER_VALUE, t0);
  op(VMEM_ROW_ADDRESS(recip_x), VMEM_ROW_ADDRESS(recip_y), out_row);
  fence();
  CSR_READ(TIMER_VALUE, t1);
  return t1 - t0;
}

static void cmul_1024(unsigned int x, unsigned int y, unsigned int out) {
  cfg_vector_multiply_1024(VMEM_ROW_ADDRESS(config_word_cmul_eq_0f), x, y, out);
}

static unsigned int divide_ticks;

// divide into a fresh row and compare; returns the mismatch count
static unsigned int run(void) {
  unsigned int *out = vmalloc_single(&mgr);
  volatile unsigned int *o = out;
  for (unsigned int i = 0; i < RECIP_N; i++) {
    o[i] = ~recip_exp[i];
  }
  divide_ticks = timed(vector_divide_1024, VMEM_ROW_ADDRESS(out));

  unsigned int bad = 0, first = 0;
  for (unsigned int i = 0; i < RECIP_N; i++) {
    if (o[i] != recip_exp[i]) {
      if (!bad) {
        first = i;
      }
      bad++;
    }
  }
  report_test_results(bad);
  if (bad) {
    report_test_results(first);
    report_test_results(o[first]);
    report_test_results(recip_exp[first]);
  }
  return bad;
}

int main(void)
{
  unsigned int all_results = 0;

  // .sbss is not zeroed by crt (ld_standard), set statics explicitly
  fence_token = 0;
  divide_ticks = 0;
  volatile unsigned int *f = fence_mem;
  for (unsigned int i = 0; i < 16; i++) {
    f[i] = 0;
    f[16 + i] = 1;
    f[32 + i] = 2;
  }
  (void)f[47];

  init_VMalloc(&mgr);

  report_test_results(0xdeadbeef);

  // twice: back to back with other datapath users idle in between
  all_results |= (run() == 0) << 0;
  all_results |= (run() == 0) << 1;

  // same schedule with the plain cmul config (no reciprocal)
  report_test_results(divide_ticks);
  report_test_results(timed(cmul_1024, VMEM_ROW_ADDRESS(vmalloc_single(&mgr))));

  report_test_results(all_results);

  return 0;
}

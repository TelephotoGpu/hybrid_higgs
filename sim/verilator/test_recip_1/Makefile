HIGGS_ROOT=../../..
###############
#
#  test_recip_1: FFT datapath reciprocal (doc/kernel/NOTES.md §12).
#
#  cs20 (FFT datapath) runs vector_divide_1024() (libs/riscv-baseband/c/inc/
#  vector_divide.c) on vectors from libs/datapath/recip/recip_model.py and
#  compares every word with the bit-exact model: special divisors (0, +-1,
#  +-31, +-32, -32768, ...), random divisors of every magnitude, and a last
#  quarter with Im(y) != 0 (x * (1/c + jd)). The results are reported over
#  the ringbus: 0xdeadbeef, then per run the mismatch count and the first
#  mismatch (index, got, expected) if any, the timer ticks of the divide
#  and of a plain cmul of the same size, then the pass mask (0x3).
#
#  make vectors    generate the vmem vector header for the firmware
#  make test       build + run

OVERRIDE_CS20_C=1
TB_USE_CS20=1

RECIP_MODEL=$(HIGGS_ROOT)/libs/datapath/recip/recip_model.py
RECIP_VECTORS=override/fpgas/cs/cs20/c/src/recip_vectors.h

HIGGS_TEST_DIR=.
include $(HIGGS_ROOT)/scripts/make_include/tb_common.mk

.PHONY: vectors
vectors: $(RECIP_VECTORS)
$(RECIP_VECTORS): $(RECIP_MODEL)
	python3 $(RECIP_MODEL) gen-header $@ 1024
compilehex: $(RECIP_VECTORS)

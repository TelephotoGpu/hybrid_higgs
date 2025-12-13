HIGGS_ROOT=../../..
include $(HIGGS_ROOT)/scripts/make_include/connection_configs.defs
###############
#
#    test_xcorr_fir_1: randomized full-system test that muxes FIR (port 0)
#    and FFT correlator (port 1) packets back and forth through
#
#      VMEM -> DMA_3 -> stream_router -> fir_filter / fft_corr -> stream_merge -> DMA_4 -> VMEM
#
#    using fir_driver + xcorr_driver on qstream. qstream reads each merge tag
#    word to decide which port (and so which expected packet) the following
#    payload belongs to. gen_vectors.py builds a random job list from
#    TEST_SEED (see its docstring); STALL_SEED independently randomizes
#    valid/ready at every stream boundary. The firmware, tb.cpp and the
#    XSIM testbench are shared with test_qstream_1 (symlinks).
#
#    make verilator_run_log                 build + run TEST_SEED/STALL_SEED
#    make seeds [SEEDS="t:s t:s ..."]       after a build: rebuild only the
#                                           firmware and rerun per seed pair
#    make xsim_compare                      Verilator vs XSIM, bit-exact

OVERRIDE_CS20_C=1
TB_USE_CS20=1

HIGGS_TEST_DIR=.
include $(HIGGS_ROOT)/scripts/make_include/tb_common.mk

XILINX_DIR=$(HIGGS_ROOT)/fpgas/common/xilinx
QS_XILINX_SOURCES=\
	$(Q_ENGINE_REPO)/piston/hdl/vmem_dat_6_5_1_1.v \
	$(Q_ENGINE_REPO)/piston/hdl/vmem_dat_arb_out_spinal_wrapper.v \
	$(HIGGS_ROOT)/libs/spinal/hw/gen/VmemDatArbOut1_1.v \
	$(XILINX_DIR)/memory_slice_1_1_xilinx.sv \
	$(Q_ENGINE_REPO)/hdl/dma/dma_out_last.v \
	$(Q_ENGINE_REPO)/hdl/fir/fir_filter.v \
	$(Q_ENGINE_REPO)/hdl/stream/stream_router.v \
	$(Q_ENGINE_REPO)/hdl/stream/stream_merge.v \
	$(Q_ENGINE_REPO)/hdl/stream/stream_stall.v \
	$(Q_ENGINE_REPO)/hdl/xcorr/fft_corr.v

VER_SOURCES+=$(QS_XILINX_SOURCES)
# QSTREAM_STALL_INJECT turns the stream_stall shims around the router/merge
# and both modules into seeded random valid/ready gaps (STALL_SEED).
STALL_SEED?=1
RUN_PLUSARGS+=+STALL_SEED=$(STALL_SEED)
EXTRA_VERILATOR_ARGS=+define+HIGGS_FPGA_XILINX +define+MEMORY_SLICE_1_1 \
	+define+VMEM_DAT_ARB_OUT_1_1 +define+QSTREAM_STALL_INJECT \
	$(XILINX_DIR)/sim/memory_slice/xpm_memory_tdpram_verilator_model.sv

# piston is flattened without the Lattice memory_slice, so no VMEM peeking
ADDCFLAGS += -CFLAGS -DHIGGS_TB_NO_VMEM_READ

EXPECTED_HEX=expected.hex
QS_VECTORS_H=override/fpgas/cs/cs20/c/src/qs_vectors.h

TEST_SEED?=1

.PHONY: vectors
vectors:
	python3 gen_vectors.py $(TEST_SEED)

# regenerate stimulus before any firmware build
compilehex: vectors

include $(HIGGS_ROOT)/scripts/make_include/xsim_common.mk

XSIM_DEFINES+=-d HIGGS_FPGA_XILINX -d MEMORY_SLICE_1_1 -d VMEM_DAT_ARB_OUT_1_1 -d QSTREAM_STALL_INJECT
XSIM_ELAB_FLAGS=-L xpm
XSIM_COMPARE_COMMAND=python3 ../test_qstream_1/compare_qs.py $(EXPECTED_HEX) verilator_run.log cs20_out.hex xsim_run.log xsim_out.hex

.PHONY: qs_clean
qs_clean: clean xsim_clean
	rm -f $(EXPECTED_HEX) $(QS_VECTORS_H) cs20_out.hex xsim_out.hex verilator_run.log seed_*.log

# Rerun an existing Verilator build with another TEST_SEED / STALL_SEED:
# only the firmware changes (it is loaded at run time).
SEEDS?=1:1 2:7 3:3 4:11 5:5 6:13 7:2 8:17 9:9 10:23 11:4 12:31
.PHONY: fw seed_run seeds
fw: vectors
	$(call invoke_c_override_submake)

seed_run: fw
	@./obj_dir/$(VER_BINARY) +STALL_SEED=$(STALL_SEED) > seed_$(TEST_SEED)_$(STALL_SEED).log 2>&1; \
	  r=$$(grep -aE "^Ran |^Captured" seed_$(TEST_SEED)_$(STALL_SEED).log | tr '\n' ' '); \
	  if grep -aq "All Tests Passed" seed_$(TEST_SEED)_$(STALL_SEED).log; then \
	    echo "PASS TEST_SEED=$(TEST_SEED) STALL_SEED=$(STALL_SEED): $$r"; \
	  else echo "FAIL TEST_SEED=$(TEST_SEED) STALL_SEED=$(STALL_SEED): $$r (seed_$(TEST_SEED)_$(STALL_SEED).log)"; exit 1; fi

seeds:
	@for p in $(SEEDS); do \
	  out=$$($(MAKE) --no-print-directory seed_run TEST_SEED=$${p%%:*} STALL_SEED=$${p##*:} 2>&1); \
	  echo "$$out" | grep -E "^(PASS|FAIL) "; \
	  echo "$$out" | grep -q "^PASS " || exit 1; \
	done

HIGGS_ROOT=../../..
include $(HIGGS_ROOT)/scripts/make_include/connection_configs.defs
###############
#
#    test_qstream_1: directed full-system test of the Q-engine stream path
#
#      VMEM -> DMA_3 -> stream_router -> port 0 fir_filter -> stream_merge -> DMA_4 -> VMEM
#                                     -> port 1 fft_corr   ->
#
#    through the qstream / fir_driver / xcorr_driver C libraries. The CS20
#    firmware (override/) is an op interpreter; gen_vectors.py (built on
#    qs_gen.py) writes its op table and the bit-exact expected output from
#    the FIR and FFT correlator Python models. The testbench stops once the expected
#    number of words has arrived (plus a margin to catch extras).
#
#    The stream path only exists in the Xilinx Q-engine, so this builds the
#    full system with the same Xilinx defines and VMEM sources as CS12.

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

.PHONY: vectors
vectors:
	python3 gen_vectors.py

# regenerate stimulus before any firmware build
compilehex: vectors

include $(HIGGS_ROOT)/scripts/make_include/xsim_common.mk

XSIM_DEFINES+=-d HIGGS_FPGA_XILINX -d MEMORY_SLICE_1_1 -d VMEM_DAT_ARB_OUT_1_1 -d QSTREAM_STALL_INJECT
XSIM_ELAB_FLAGS=-L xpm
XSIM_COMPARE_COMMAND=python3 compare_qs.py $(EXPECTED_HEX) verilator_run.log cs20_out.hex xsim_run.log xsim_out.hex

.PHONY: qs_clean
qs_clean: clean xsim_clean
	rm -f $(EXPECTED_HEX) $(QS_VECTORS_H) cs20_out.hex xsim_out.hex verilator_run.log

HIGGS_ROOT=../../..
include $(HIGGS_ROOT)/scripts/make_include/connection_configs.defs
###############
#
#    test_fir_1: full-system FIR regression on CS20.
#
#    CS20 firmware (override/) drives the Q-engine FIR through
#    VMEM -> DMA_3 -> fir_filter -> DMA_4 -> VMEM with the fir_driver C
#    library, then streams the result out through DMA_1. gen_vectors.py
#    produces the firmware's stimulus and the bit-exact expected output from
#    libs/q-engine/hdl/fir/model/fir_model.py.
#
#    The FIR only exists in the Xilinx Q-engine (6-port VMEM crossbar), so
#    this test builds the full system with the same Xilinx defines and VMEM
#    sources as the CS12 Vivado flow.

OVERRIDE_CS20_C=1
TB_USE_CS20=1

HIGGS_TEST_DIR=.
include $(HIGGS_ROOT)/scripts/make_include/tb_common.mk

XILINX_DIR=$(HIGGS_ROOT)/fpgas/common/xilinx
FIR_XILINX_SOURCES=\
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

VER_SOURCES+=$(FIR_XILINX_SOURCES)
# Verilator gets the behavioural XPM model; XSIM links the vendor xpm library.
# QSTREAM_STALL_INJECT turns the stream_stall shims around the router/merge
# into seeded random valid/ready gaps (STALL_SEED).
STALL_SEED?=1
RUN_PLUSARGS+=+STALL_SEED=$(STALL_SEED)
EXTRA_VERILATOR_ARGS=+define+HIGGS_FPGA_XILINX +define+MEMORY_SLICE_1_1 \
	+define+VMEM_DAT_ARB_OUT_1_1 +define+QSTREAM_STALL_INJECT \
	$(XILINX_DIR)/sim/memory_slice/xpm_memory_tdpram_verilator_model.sv

# piston is flattened without the Lattice memory_slice, so no VMEM peeking
ADDCFLAGS += -CFLAGS -DHIGGS_TB_NO_VMEM_READ

EXPECTED_HEX=expected.hex
FIR_VECTORS_H=override/fpgas/cs/cs20/c/src/fir_vectors.h

.PHONY: vectors
vectors:
	python3 gen_vectors.py

# regenerate stimulus before any firmware build
compilehex: vectors

include $(HIGGS_ROOT)/scripts/make_include/xsim_common.mk

XSIM_DEFINES+=-d HIGGS_FPGA_XILINX -d MEMORY_SLICE_1_1 -d VMEM_DAT_ARB_OUT_1_1 -d QSTREAM_STALL_INJECT
XSIM_ELAB_FLAGS=-L xpm
XSIM_COMPARE_COMMAND=python3 compare_fir.py $(EXPECTED_HEX) verilator_run.log cs20_out.hex xsim_run.log xsim_fir.hex

.PHONY: fir_clean
fir_clean: clean xsim_clean
	rm -f $(EXPECTED_HEX) $(FIR_VECTORS_H) cs20_out.hex xsim_fir.hex verilator_run.log

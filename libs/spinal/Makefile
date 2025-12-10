# Output directories
GEN_DIR = hw/gen
PROJECT_DIR = project

# Source files
VAO_SOURCES := hw/spinal/qengine/Config.scala hw/spinal/qengine/VmemDatArbOut1_1.scala
REQACK_SOURCES := $(wildcard hw/spinal/reqack/*.scala)

# How Spinal generators run: sbt (default), or SPINAL_RUNNER=direct to use
# scripts/direct-run.sh (scalac from the coursier cache) where sbt cannot
# start, e.g. "User limit of inotify instances reached".
SPINAL_RUNNER ?= sbt
ifeq ($(SPINAL_RUNNER),direct)
run_main = scripts/direct-run.sh $(1) $(2)
else
run_main = sbt 'set scalacOptions += "-deprecation"' "runMain $(1) $(2)"
endif

PISTON = ../q-engine/piston
PISTON_HDL = $(PISTON)/hdl
# reqack reference netlists, written by $(PISTON)/bin/gen.js
REF = $(PISTON)/build/ref
EQUIV_WORK = build/equiv
EB_CTRL = $(PISTON_HDL)/eb15_ctrl.v $(PISTON_HDL)/eb17_ctrl.v $(PISTON_HDL)/eb_fifo_ctrl.v

all: vao reqack

vao: $(GEN_DIR)/VmemDatArbOut1_1.v

$(GEN_DIR)/VmemDatArbOut1_1.v: $(VAO_SOURCES) Makefile
	mkdir -p $(GEN_DIR)
	$(call run_main,qengine.VmemDatArbOut1_1Verilog)

# Elastic netlists that replace reqack (doc/kernel/README.md, SpinalHDL)
reqack: k15_op piston
	$(MAKE) names_check

# piston.v + piston_dp_{fft,img}.v (the build compiles piston.v and one
# piston_dp_*.v, selected by HIGGS_DATAPATH)
PISTON_OUT = $(PISTON_HDL)
PISTON_GEN = $(PISTON_OUT)/piston.v $(PISTON_OUT)/piston_dp_fft.v $(PISTON_OUT)/piston_dp_img.v
DATAPATH = ../datapath

piston: $(PISTON_GEN)

$(PISTON_GEN) &: $(REQACK_SOURCES) hw/spinal/qengine/Piston.scala hw/spinal/qengine/PistonDp.scala \
		hw/spinal/qengine/Reciprocal.scala Makefile
	$(call run_main,qengine.PistonVerilog,$(PISTON_OUT))

k15_op: $(PISTON_HDL)/k15_op.v

$(PISTON_HDL)/k15_op.v: $(REQACK_SOURCES) hw/spinal/qengine/K15Op.scala Makefile
	$(call run_main,qengine.K15OpVerilog,$(PISTON_HDL))

# Lockstep Verilator co-simulation against the reqack reference netlists
EQUIV_PISTON = equiv_piston_dp_fft equiv_piston_dp_img equiv_piston_fft equiv_piston_img

equiv: equiv_k15_op $(EQUIV_PISTON)

equiv_k15_op: $(PISTON_HDL)/k15_op.v
	@test -f $(REF)/k15_op.v || { echo "missing $(REF)/k15_op.v: run make -C $(PISTON) build"; exit 1; }
	python3 equiv/equiv.py --top k15_op --ref $(REF)/k15_op.v --dut $(PISTON_HDL)/k15_op.v \
		--lib $(EB_CTRL) --work $(EQUIV_WORK)/k15_op

# leaves of the piston graphs (everything in hdl/ except the netlists)
PISTON_LIBS = $(filter-out $(PISTON_GEN) $(PISTON_HDL)/k15_op.v,$(wildcard $(PISTON_HDL)/*.v)) \
	$(DATAPATH)/rtl/muladdsub.v $(DATAPATH)/image/rtl/img_datapath.v

# Program-like stimulus for the full piston (equiv/piston_stim.h): uniform
# random instructions rarely reach LK/SK with valid addresses.
PISTON_STIM = --prelude equiv/piston_stim.h --stim 't_instr_dat=piston_instr()' \
	--stim 't_instr_req=coin(0.9)' --reset-rate 0.002 \
	$(foreach i,0 1 2 3,--stim 't_idma_$(i)_dat=piston_dma()' --stim 't_idma_$(i)_req=coin(0.02)' \
		--stim 'i_odma_$(i)_ack=coin(0.9)')

# The reference FFT datapath has no reciprocal: keep k14 m2c codes off 3
# (equiv/norecip.h; piston_stim.h does the same for the DMA data).
DP_STIM_fft = --prelude equiv/norecip.h --fixup 'norecip_k14(m->t_k14_dat)'

equiv_piston_dp_fft equiv_piston_dp_img: equiv_piston_dp_%: $(PISTON_GEN)
	@test -f $(REF)/piston_dp_$*.v || { echo "missing $(REF)/piston_dp_$*.v: run make -C $(PISTON) build"; exit 1; }
	python3 equiv/equiv.py --top piston_dp --ref $(REF)/piston_dp_$*.v --dut $(PISTON_OUT)/piston_dp_$*.v \
		--lib $(PISTON_LIBS) --work $(EQUIV_WORK)/piston_dp_$* $(DP_STIM_$*)

# In the full piston, SK-written vmem data can reach LK14 with code 3: end
# the seed there (equiv/norecip.h), more seeds to keep the coverage.
PISTON_STOP_fft = --vflags=--public --stop 'norecip_piston_code3(m)' --seeds 16

REF_PISTON_fft = $(REF)/piston.v
REF_PISTON_img = $(REF)/piston_img.v

equiv_piston_fft equiv_piston_img: equiv_piston_%: $(PISTON_GEN)
	@test -f $(REF_PISTON_$*) || { echo "missing $(REF_PISTON_$*): run make -C $(PISTON) build"; exit 1; }
	python3 equiv/equiv.py --top piston --ref $(REF_PISTON_$*) \
		--dut $(PISTON_OUT)/piston.v $(PISTON_OUT)/piston_dp_$*.v \
		--lib $(PISTON_LIBS) --work $(EQUIV_WORK)/piston_$* $(PISTON_STIM) $(PISTON_STOP_$*)

# Reciprocal unit test (doc/kernel/NOTES.md §12): the Spinal 1/c chain of
# the FFT cmul against the bit-exact model, all 65536 inputs, random
# handshakes.
RECIP_WORK = build/recip
RECIP_MODEL = ../datapath/recip/recip_model.py

$(RECIP_WORK)/recip_unit.v: $(REQACK_SOURCES) hw/spinal/qengine/Reciprocal.scala Makefile
	$(call run_main,qengine.RecipUnitVerilog,$(RECIP_WORK))

recip_test: $(RECIP_WORK)/recip_unit.v
	cd $(RECIP_WORK) && rm -rf obj_dir && verilator --cc --exe ../../recip/tb_recip.cpp -O2 \
		--top-module recip_unit -Wno-fatal -Wno-lint recip_unit.v >/dev/null && \
		$(MAKE) -s -C obj_dir -f Vrecip_unit.mk Vrecip_unit >/dev/null && ./obj_dir/Vrecip_unit got.txt
	python3 $(RECIP_MODEL) check $(RECIP_WORK)/got.txt

# Name lock: saved waveform/TCL/LPF paths reference these names
# (doc/kernel/NOTES.md, name lock). names_lock accepts a rename.
NAMES_FILES = $(PISTON_GEN) $(PISTON_HDL)/k15_op.v

names_check:
	python3 names/names.py check $(NAMES_FILES)

names_lock:
	python3 names/names.py lock $(NAMES_FILES)

# Clean generated files and build artifacts
clean:
	rm -rf $(GEN_DIR)
	rm -rf $(PROJECT_DIR)/project
	rm -rf $(PROJECT_DIR)/target
	rm -rf target build

.PHONY: all clean vao reqack k15_op piston equiv equiv_k15_op $(EQUIV_PISTON) names_check names_lock recip_test

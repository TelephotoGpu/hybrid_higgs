# dma_out_last module harness: one clocked SV testbench core run under
# Verilator and XSIM for 20 seeds, self-checking plus exact trace comparison.
RTL   := $(abspath ../../../../../libs/q-engine/hdl/dma/dma_out_last.v)
CORE  := $(abspath tb_dma_out_last_core.sv)
TB    := $(abspath tb_dma_out_last.sv)
CPP   := $(abspath verilator_dma_out_last.cpp)
BUILD := $(abspath build)
SEEDS ?= 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19

.PHONY: all verilator xsim compare clean

all: compare

verilator:
	@rm -rf $(BUILD)/verilator && mkdir -p $(BUILD)/verilator
	verilator -cc --exe -Wno-fatal --top-module tb_dma_out_last_core \
	  --Mdir $(BUILD)/verilator $(RTL) $(CORE) $(CPP) >/dev/null
	$(MAKE) -s -C $(BUILD)/verilator -f Vtb_dma_out_last_core.mk Vtb_dma_out_last_core >/dev/null
	@for s in $(SEEDS); do mkdir -p $(BUILD)/run/v$$s; \
	  (cd $(BUILD)/run/v$$s && printf "verilator " && \
	   $(BUILD)/verilator/Vtb_dma_out_last_core +SEED=$$s | tee log.txt; \
	   grep -q "^PASS" log.txt) || exit 1; done

xsim:
	command -v xvlog >/dev/null
	@rm -rf $(BUILD)/xsim && mkdir -p $(BUILD)/xsim
	cd $(BUILD)/xsim && xvlog -sv -work work $(RTL) $(CORE) $(TB) >/dev/null
	cd $(BUILD)/xsim && xelab -debug off -s tb work.tb_dma_out_last >/dev/null
	@for s in $(SEEDS); do mkdir -p $(BUILD)/run/x$$s; \
	  (cd $(BUILD)/run/x$$s && printf "xsim      " && \
	   xsim --xsimdir $(BUILD)/xsim/xsim.dir tb -R -testplusarg SEED=$$s -log x.log >/dev/null; \
	   grep -E "^(PASS|FAIL|MISMATCH)|exp " x.log; grep -q "^PASS" x.log) || exit 1; done

compare: verilator xsim
	@for s in $(SEEDS); do \
	  cmp -s $(BUILD)/run/v$$s/trace.csv $(BUILD)/run/x$$s/trace.csv || \
	  { echo "trace mismatch seed=$$s"; exit 1; }; done
	@echo "PASS: all $(words $(SEEDS)) Verilator/XSIM traces identical"

clean:
	rm -rf $(BUILD)

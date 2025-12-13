# stream_router / stream_merge harness: one clocked SV core, three modes
# (router alone, merge alone, router -> echo arms -> merge), 20 seeds each,
# Verilator + XSIM self-checks plus exact trace comparison.
HDL   := $(abspath ../../../../../libs/q-engine/hdl/stream)
RTL   := $(HDL)/stream_router.v $(HDL)/stream_merge.v
CORE  := $(abspath tb_stream_core.sv)
TB    := $(abspath tb_stream.sv)
CPP   := $(abspath verilator_stream.cpp)
BUILD := $(abspath build)
SEEDS ?= 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
MODES ?= 0 1 2

.PHONY: all verilator xsim compare clean

all: compare

verilator:
	@for m in $(MODES); do rm -rf $(BUILD)/verilator/m$$m && mkdir -p $(BUILD)/verilator/m$$m && \
	  verilator -cc --exe -Wno-fatal -GMODE=$$m --top-module tb_stream_core \
	    --Mdir $(BUILD)/verilator/m$$m $(RTL) $(CORE) $(CPP) >/dev/null && \
	  $(MAKE) -s -C $(BUILD)/verilator/m$$m -f Vtb_stream_core.mk Vtb_stream_core >/dev/null || exit 1; done
	@for m in $(MODES); do for s in $(SEEDS); do mkdir -p $(BUILD)/run/v$$m-$$s; \
	  (cd $(BUILD)/run/v$$m-$$s && printf "verilator " && \
	   $(BUILD)/verilator/m$$m/Vtb_stream_core +SEED=$$s | tee log.txt; \
	   grep -q "^PASS" log.txt) || exit 1; done; done

xsim:
	command -v xvlog >/dev/null
	@rm -rf $(BUILD)/xsim && mkdir -p $(BUILD)/xsim
	cd $(BUILD)/xsim && xvlog -sv -work work $(RTL) $(CORE) $(TB) >/dev/null
	@for m in $(MODES); do (cd $(BUILD)/xsim && \
	  xelab -debug off -generic_top MODE=$$m -s tb$$m work.tb_stream >/dev/null) || exit 1; done
	@for m in $(MODES); do for s in $(SEEDS); do mkdir -p $(BUILD)/run/x$$m-$$s; \
	  (cd $(BUILD)/run/x$$m-$$s && printf "xsim      " && \
	   xsim --xsimdir $(BUILD)/xsim/xsim.dir tb$$m -R -testplusarg SEED=$$s -log x.log >/dev/null; \
	   grep -E "^(PASS|FAIL|MISMATCH)|exp " x.log; grep -q "^PASS" x.log) || exit 1; done; done

compare: verilator xsim
	@for m in $(MODES); do for s in $(SEEDS); do \
	  cmp -s $(BUILD)/run/v$$m-$$s/trace.csv $(BUILD)/run/x$$m-$$s/trace.csv || \
	  { echo "trace mismatch mode=$$m seed=$$s"; exit 1; }; done; done
	@echo "PASS: all $(words $(MODES))x$(words $(SEEDS)) Verilator/XSIM traces identical"

clean:
	rm -rf $(BUILD)

# golay_corr module harness: model-generated vectors, seeded valid/ready
# patterns, Verilator + XSIM self-checks, and exact trace comparison.
RTL      := $(abspath ../../../../../libs/q-engine/hdl/xcorr/golay_corr.v)
TB       := $(abspath tb_golay_corr.sv)
CPP      := $(abspath verilator_golay_corr.cpp)
GENV     := $(abspath gen_vectors.py)
BUILD    := $(abspath build)

# <M>:<seed> runs; 20 seeds at the production M=7 plus other sizes
RUNS ?= $(foreach s,0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19,7:$(s)) \
        1:100 2:101 3:102 4:103 5:104

M_LIST := $(sort $(foreach r,$(RUNS),$(word 1,$(subst :, ,$(r)))))

.PHONY: all vectors verilator xsim compare clean

all: compare

vectors:
	@for r in $(RUNS); do m=$${r%%:*}; s=$${r##*:}; \
	  python3 $(GENV) $(BUILD)/vec/m$$m-s$$s $$s $$m || exit 1; done

verilator: vectors
	@for m in $(M_LIST); do \
	  rm -rf $(BUILD)/verilator/m$$m && mkdir -p $(BUILD)/verilator/m$$m && \
	  verilator -cc --exe -Wno-fatal -GM=$$m --top-module golay_corr \
	    --Mdir $(BUILD)/verilator/m$$m $(RTL) $(CPP) >/dev/null && \
	  $(MAKE) -s -C $(BUILD)/verilator/m$$m -f Vgolay_corr.mk Vgolay_corr >/dev/null || exit 1; done
	@for r in $(RUNS); do m=$${r%%:*}; s=$${r##*:}; \
	  printf "verilator m=%-2s seed=%-3s " $$m $$s; \
	  $(BUILD)/verilator/m$$m/Vgolay_corr +DIR=$(BUILD)/vec/m$$m-s$$s || exit 1; done
	python3 check_throughput.py $(BUILD)/vec/m7-s0/verilator_trace.csv $(BUILD)/vec/m7-s0/in.txt 7

xsim: vectors
	command -v xvlog >/dev/null
	@rm -rf $(BUILD)/xsim && mkdir -p $(BUILD)/xsim
	cd $(BUILD)/xsim && xvlog -sv -work work $(RTL) $(TB) >/dev/null
	@for m in $(M_LIST); do \
	  (cd $(BUILD)/xsim && xelab -generic_top M=$$m -s tb_m$$m work.tb_golay_corr >/dev/null) || exit 1; done
	@for r in $(RUNS); do m=$${r%%:*}; s=$${r##*:}; \
	  printf "xsim      m=%-2s seed=%-3s " $$m $$s; \
	  (cd $(BUILD)/xsim && xsim tb_m$$m -R -testplusarg DIR=$(BUILD)/vec/m$$m-s$$s -log x.log >/dev/null; \
	   grep -E "PASS|FAIL|MISMATCH|out |in " x.log; grep -q "^PASS" x.log) || exit 1; done
	python3 check_throughput.py $(BUILD)/vec/m7-s0/xsim_trace.csv $(BUILD)/vec/m7-s0/in.txt 7

compare: verilator xsim
	@for r in $(RUNS); do m=$${r%%:*}; s=$${r##*:}; \
	  cmp -s $(BUILD)/vec/m$$m-s$$s/verilator_trace.csv $(BUILD)/vec/m$$m-s$$s/xsim_trace.csv || \
	  { echo "trace mismatch m=$$m seed=$$s"; exit 1; }; done
	@echo "PASS: all $(words $(RUNS)) Verilator/XSIM traces identical"

clean:
	rm -rf $(BUILD)

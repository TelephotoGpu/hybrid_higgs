# fir_filter module harness: model-generated vectors, seeded valid/ready
# patterns, Verilator + XSIM self-checks, and exact trace comparison.
RTL      := $(abspath ../../../../../libs/q-engine/hdl/fir/fir_filter.v)
TB       := $(abspath tb_fir_filter.sv)
CPP      := $(abspath verilator_fir_filter.cpp)
GENV     := $(abspath gen_vectors.py)
BUILD    := $(abspath build)

# <ntaps>:<seed> runs; 20 seeds at the production 16 taps plus other widths
RUNS ?= $(foreach s,0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19,16:$(s)) \
        1:100 2:101 5:102 8:103 13:104

NTAPS_LIST := $(sort $(foreach r,$(RUNS),$(word 1,$(subst :, ,$(r)))))

.PHONY: all vectors verilator xsim compare clean

all: compare

vectors:
	@for r in $(RUNS); do n=$${r%%:*}; s=$${r##*:}; \
	  python3 $(GENV) $(BUILD)/vec/n$$n-s$$s $$s $$n || exit 1; done

verilator: vectors
	@for n in $(NTAPS_LIST); do \
	  rm -rf $(BUILD)/verilator/n$$n && mkdir -p $(BUILD)/verilator/n$$n && \
	  verilator -cc --exe -Wno-fatal -GNTAPS=$$n --top-module fir_filter \
	    --Mdir $(BUILD)/verilator/n$$n $(RTL) $(CPP) >/dev/null && \
	  $(MAKE) -s -C $(BUILD)/verilator/n$$n -f Vfir_filter.mk Vfir_filter >/dev/null || exit 1; done
	@for r in $(RUNS); do n=$${r%%:*}; s=$${r##*:}; \
	  printf "verilator ntaps=%-2s seed=%-3s " $$n $$s; \
	  $(BUILD)/verilator/n$$n/Vfir_filter +DIR=$(BUILD)/vec/n$$n-s$$s || exit 1; done
	python3 check_throughput.py $(BUILD)/vec/n16-s0/verilator_trace.csv $(BUILD)/vec/n16-s0/in.txt

xsim: vectors
	command -v xvlog >/dev/null
	@rm -rf $(BUILD)/xsim && mkdir -p $(BUILD)/xsim
	cd $(BUILD)/xsim && xvlog -sv -work work $(RTL) $(TB) >/dev/null
	@for n in $(NTAPS_LIST); do \
	  (cd $(BUILD)/xsim && xelab -generic_top NTAPS=$$n -s tb_n$$n work.tb_fir_filter >/dev/null) || exit 1; done
	@for r in $(RUNS); do n=$${r%%:*}; s=$${r##*:}; \
	  printf "xsim      ntaps=%-2s seed=%-3s " $$n $$s; \
	  (cd $(BUILD)/xsim && xsim tb_n$$n -R -testplusarg DIR=$(BUILD)/vec/n$$n-s$$s -log x.log >/dev/null; \
	   grep -E "PASS|FAIL|MISMATCH|out |in " x.log; grep -q "^PASS" x.log) || exit 1; done
	python3 check_throughput.py $(BUILD)/vec/n16-s0/xsim_trace.csv $(BUILD)/vec/n16-s0/in.txt

compare: verilator xsim
	@for r in $(RUNS); do n=$${r%%:*}; s=$${r##*:}; \
	  cmp -s $(BUILD)/vec/n$$n-s$$s/verilator_trace.csv $(BUILD)/vec/n$$n-s$$s/xsim_trace.csv || \
	  { echo "trace mismatch ntaps=$$n seed=$$s"; exit 1; }; done
	@echo "PASS: all $(words $(RUNS)) Verilator/XSIM traces identical"

clean:
	rm -rf $(BUILD)

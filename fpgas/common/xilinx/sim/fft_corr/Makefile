# fft_corr module harness: model-generated vectors, seeded valid/ready
# patterns, Verilator + XSIM self-checks, and exact trace comparison.
RTL      := $(abspath ../../../../../libs/q-engine/hdl/xcorr/fft_corr.v)
TB       := $(abspath tb_fft_corr.sv)
CPP      := $(abspath verilator_fft_corr.cpp)
GENV     := $(abspath gen_vectors.py)
BUILD    := $(abspath build)

# <N>:<seed> runs; 20 seeds at the production N=256 plus other sizes.
# Seed 0 is the always-valid/ready throughput scenario.
RUNS ?= $(foreach s,0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19,256:$(s)) \
        16:100 16:101 16:102 16:103 32:104 32:105 64:106 64:107 128:108 512:109 1024:0 1024:110

N_LIST := $(sort $(foreach r,$(RUNS),$(word 1,$(subst :, ,$(r)))))

.PHONY: all vectors verilator xsim compare clean

all: compare

vectors:
	@for r in $(RUNS); do m=$${r%%:*}; s=$${r##*:}; \
	  python3 $(GENV) $(BUILD)/vec/n$$m-s$$s $$s $$m || exit 1; done

verilator: vectors
	@for m in $(N_LIST); do \
	  rm -rf $(BUILD)/verilator/n$$m && mkdir -p $(BUILD)/verilator/n$$m/obj && \
	  verilator -cc --exe -O3 -Wno-fatal -GN=$$m --top-module fft_corr \
	    --Mdir $(BUILD)/verilator/n$$m/obj $(RTL) $(CPP) >/dev/null && \
	  $(MAKE) -s -C $(BUILD)/verilator/n$$m/obj -f Vfft_corr.mk Vfft_corr >/dev/null || exit 1; done
	@for r in $(RUNS); do m=$${r%%:*}; s=$${r##*:}; \
	  printf "verilator n=%-4s seed=%-3s " $$m $$s; \
	  $(BUILD)/verilator/n$$m/obj/Vfft_corr +DIR=$(BUILD)/vec/n$$m-s$$s || exit 1; done
	python3 check_throughput.py $(BUILD)/vec/n256-s0/verilator_trace.csv $(BUILD)/vec/n256-s0/in.txt

xsim: vectors
	command -v xvlog >/dev/null
	@rm -rf $(BUILD)/xsim && mkdir -p $(BUILD)/xsim
	cd $(BUILD)/xsim && xvlog -sv -work work $(RTL) $(TB) >/dev/null
	@for m in $(N_LIST); do \
	  (cd $(BUILD)/xsim && xelab -generic_top N=$$m -s tb_n$$m work.tb_fft_corr >/dev/null) || exit 1; done
	@for r in $(RUNS); do m=$${r%%:*}; s=$${r##*:}; \
	  printf "xsim      n=%-4s seed=%-3s " $$m $$s; \
	  (cd $(BUILD)/xsim && xsim tb_n$$m -R -testplusarg DIR=$(BUILD)/vec/n$$m-s$$s -log x.log >/dev/null; \
	   grep -E "PASS|FAIL|MISMATCH|out |in " x.log; grep -q "^PASS" x.log) || exit 1; done
	python3 check_throughput.py $(BUILD)/vec/n256-s0/xsim_trace.csv $(BUILD)/vec/n256-s0/in.txt

compare: verilator xsim
	@for r in $(RUNS); do m=$${r%%:*}; s=$${r##*:}; \
	  cmp -s $(BUILD)/vec/n$$m-s$$s/verilator_trace.csv $(BUILD)/vec/n$$m-s$$s/xsim_trace.csv || \
	  { echo "trace mismatch m=$$m seed=$$s"; exit 1; }; done
	@echo "PASS: all $(words $(RUNS)) Verilator/XSIM traces identical"

clean:
	rm -rf $(BUILD)

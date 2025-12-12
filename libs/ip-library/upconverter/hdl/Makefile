all: verilate compile run

VERILATOR_ARGS ?=
RUN_ARGS ?=

clean:
	rm -rf obj_dir tb_output.csv wave_dump.vcd

verilate:
	verilator \
	--trace \
	-cc \
	-O3 \
	-Ihdl \
	--top-module top_tb \
	--exe tb.cpp \
	-LDFLAGS -l:libboost_program_options.so \
	--Wno-WIDTH \
	$(VERILATOR_ARGS) \
	upconverter.sv \
	top_tb.sv

compile:
	make -j -C obj_dir/ -f Vtop_tb.mk Vtop_tb

run:
	./obj_dir/Vtop_tb $(RUN_ARGS)

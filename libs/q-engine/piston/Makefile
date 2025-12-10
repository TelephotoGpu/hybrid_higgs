all: build verilate compile run show

lint: clean build verilate_lint verilate_lint_img

clean:
	rm -f hdl/*
	rm -rf obj_dir

build_elastic:
	./bin/gen.js
	dot -Tsvg hdl/piston.dot > hdl/piston.svg
build:
	./bin/templer.js --source templates/ --output templates.js
	./bin/templer.js --source ../../datapath/templates/ --output datapath-templates.js
	./bin/gen.js
	cp node_modules/reqack/rtl/eb15_ctrl.v hdl/eb15_ctrl.v
	cp node_modules/reqack/rtl/eb17_ctrl.v hdl/eb17_ctrl.v
	cp node_modules/reqack/rtl/eb_fifo_ctrl.v hdl/eb_fifo_ctrl.v

verilate:
	verilator \
	--Wno-WIDTH \
	--Wno-SELRANGE \
	--trace \
	-cc \
	-O3 \
	--top-module piston \
	--exe hdl/tb.cpp \
	hdl/*.sv


# gen.js writes one netlist per datapath (both define module piston):
# hdl/piston.v (FFT) and hdl/piston_img.v (image, doc/kernel/README.md)
PISTON_COMMON_V = $(filter-out hdl/piston.v hdl/piston_img.v,$(wildcard hdl/*.v))

verilate_lint:
	verilator \
	--Wno-WIDTH \
	--Wno-SELRANGE \
	--lint-only \
	+define+VERILATE \
	+1364-2001ext+v \
	--top-module piston \
	../../datapath/rtl/*.v \
	$(PISTON_COMMON_V) hdl/piston.v
	dot -Tsvg hdl/piston.dot > hdl/piston.svg

verilate_lint_img:
	verilator \
	--Wno-WIDTH \
	--Wno-SELRANGE \
	--lint-only \
	+define+VERILATE \
	+1364-2001ext+v \
	--top-module piston \
	../../datapath/rtl/*.v \
	../../datapath/image/rtl/img_datapath.v \
	$(PISTON_COMMON_V) hdl/piston_img.v

compile: verilate
	make -j -C obj_dir/ -f Vpiston.mk Vpiston

run:
	./obj_dir/Vtop

show:
	gtkwave ./permutator.vcd -S hdl/top-wave.tcl &

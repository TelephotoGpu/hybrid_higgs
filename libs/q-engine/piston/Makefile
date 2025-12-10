all: build verilate compile run show

lint: clean build verilate_lint verilate_lint_img

clean:
	rm -f hdl/*
	rm -rf obj_dir

build_elastic:
	./bin/gen.js
	dot -Tsvg build/ref/piston.dot > hdl/piston.svg
build:
	./bin/templer.js --source templates/ --output templates.js
	./bin/templer.js --source ../../datapath/templates/ --output datapath-templates.js
	./bin/gen.js
	$(MAKE) -C ../../spinal reqack
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


# piston.v is shared; piston_dp_fft.v and piston_dp_img.v both define module
# piston_dp, compile exactly one (HIGGS_DATAPATH, doc/kernel/README.md)
PISTON_COMMON_V = $(filter-out hdl/piston_dp_fft.v hdl/piston_dp_img.v,$(wildcard hdl/*.v))

verilate_lint:
	verilator \
	--Wno-WIDTH \
	--Wno-SELRANGE \
	--lint-only \
	+define+VERILATE \
	+1364-2001ext+v \
	--top-module piston \
	../../datapath/rtl/*.v \
	$(PISTON_COMMON_V) hdl/piston_dp_fft.v

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
	$(PISTON_COMMON_V) hdl/piston_dp_img.v

# SpinalHDL netlists vs the reqack reference in build/ref (run build first)
equiv:
	$(MAKE) -C ../../spinal equiv

compile: verilate
	make -j -C obj_dir/ -f Vpiston.mk Vpiston

run:
	./obj_dir/Vtop

show:
	gtkwave ./permutator.vcd -S hdl/top-wave.tcl &

# build/ (gen.js reqack references) would otherwise make "build" look up to date
.PHONY: all lint clean build_elastic build verilate verilate_lint verilate_lint_img equiv compile run show

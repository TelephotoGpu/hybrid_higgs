# Image kernel datapath — plan

Goal: a compile-time-selectable image-processing datapath for the Q-engine
(piston/VexRiscv) that slides an up-to-7x7 kernel over streamed 8-bit gray or
RGBX images. It sits alongside the existing 16I/16Q FFT datapath, and only
one is connected per build.

Status legend: `[ ]` todo, `[~]` in progress, `[x]` done.

## Tasks

1. `[x]` **Define kernel tasks** (grill-me): Sobel/Prewitt/Scharr, Gaussian
   3/5/7, box, sharpen/unsharp, Laplacian, emboss, erode/dilate, copy,
   custom. See NOTES §2.
2. `[x]` **Feature detection** (grill-me): threshold edge map, 3x3 NMS
   peaks, global min/max + location, 16x16 tile stats → ROI + bounding box.
   See NOTES §3.
3. `[x]` **Processing level / multipliers**: real u8×s8, dual accumulator
   (128 MACs → ~128 DSP48E2), 24-bit accumulators, per-lane mode, MIN/MAX
   comparators, post stage. See NOTES §4–5.
4. `[x]` **Fixed-point Python model**: `libs/datapath/image/img_model.py`
   (bit-exact to NOTES §5), synthetic image generator, stream
   encoder/decoder, self-tests, and RTL vector generator. See NOTES §8.
   `python3 libs/datapath/image/img_model.py selftest` passes.
5. `[x]` **Datapath RTL + compile**: `libs/datapath/image/rtl/img_datapath.v`
   with a standalone Verilator unit test against the model. Integrate it by
   generating a second piston netlist, `hdl/piston_img.v` (`gen.js` +
   `img-datapath.js`; reqack pinned; earlier `hdl/` hand edits moved into
   the generator), selected in make/tcl by `HIGGS_DATAPATH=img`. Then Verilator lint, and a Vivado synth + route of
   CS12 with the image datapath. Done: the unit test is bit-exact at 0/30/70 %
   stall, and CS12 routes at 125 MHz (WNS +0.647 ns, 134 DSP). See NOTES §9.
6. `[x]` **C library + instruction schedule**:
   `libs/riscv-baseband/c/inc/image_kernel.{h,c}`:
   * config/coefficient rows, line rings with halo, skew vregs;
   * the per-chunk LK8/LK9/SK1 schedule and an LK13/SK13 token fence;
   * multi-stage streaming (for PEAKS) and CPU feature reductions;
   * the cs22 stream protocol (jobs, errors, END). See NOTES §6–7.
7. `[x]` **Platform test** `sim/verilator/test_image_1`: cs22 firmware and a
   TB that injects 24 jobs, captures `cs22out` and compares it with the
   Python model. Verilator and XSIM both pass bit-exact with identical
   outputs. See NOTES §10 for results, cycles per job and issues found.

## Milestones / commits
* M1: docs + tasks 1–3. `[x]`
* M2: Python model + self-tests. `[x]`
* M3: RTL + unit test + piston integration + lint + Vivado results. `[x]`
* M4: C library. `[x]`
* M5: test_image_1 on Verilator and XSIM (plus a regression check of
  test_fft_lib_1 with the default datapath). `[x]`
* M6: replace the hand edit of generated `piston.v` with a generated
  `piston_img.v` (reqack pin, `img-datapath.js`, make/tcl netlist selection,
  earlier `hdl/` hand edits moved into the generator). `[x]`
* M7: simple numpy fixed-point model for prototyping and checking Verilog
  output (`libs/datapath/image/simple_model.py`, NOTES §8.1). `[x]`

* M8: SpinalHDL replacement for reqack (NOTES §11). Stages, one commit
  each:
  * M8a: `reqack` Scala package (graph DSL, exact EB0/EB1/EB1.5/EB1.7/FIFO,
    edge/node forks, joins, operators, macros, Verilog-header BlackBoxes),
    lockstep equivalence harness, `k15_op.v` from Spinal, proven equal to
    reqack. `[x]`
  * M8b: `piston.v` + `piston_dp_fft.v` / `piston_dp_img.v` from Spinal,
    proven equal to the reqack `piston.v` / `piston_img.v`. `[x]`
  * M8c: build integration: Spinal writes `hdl/piston.v` +
    `hdl/piston_dp_{fft,img}.v`, reqack only `build/ref/`; file lists,
    `q_engine.v` parameters, `vmem` instance in the C/SV testbench paths.
    test_fft_lib_1, test_image_1 (Verilator and XSIM) pass. `[x]`
  * M8d: name lock (`names.lock`, checked by `make reqack`), `_1` clash
    names fixed, reqack → Spinal name map and migration of saved
    gtkw/tcl/lpf paths (NOTES §11.5). `[x]`

* M9: reciprocal in the Spinal FFT datapath (NOTES §12). One 1/c unit per
  cmul (8), selected by the unused m2c code 3 on m2c_ac/m2c_cd; the k14
  layout and codes 0–2 are unchanged. `[x]`
  * bit-exact Python model (`libs/datapath/recip/recip_model.py`), the
    d-engine algorithm with its edge cases fixed;
  * Spinal `Reciprocal` + unit test of all 65,536 inputs
    (`make -C libs/spinal recip_test`);
  * equivalence vs reqack with k14 constrained to codes 0–2
    (`norecip.h`, `--fixup`, `--stop`);
  * C: `vector_divide_1024()` + `config_word_cdiv_eq_05`;
  * `sim/verilator/test_recip_1` (in `TEST_LIST`), bit-exact vs the model;
  * before/after regression of the `sim/verilator` suite (NOTES §12.6).

## Risks / open items
* ~~CPU↔vector ordering~~: there is no hardware fence. An SK15 token fence
  hung (MVVK15 over-pushes when the vector unit idles, NOTES §1). The
  library now uses an LK13/SK13 token fence (NOTES §6.3).
* ~~Vivado may map 8x8 multipliers to LUTs~~: resolved, all 128 are in DSPs.
* A clean full-platform Verilator build + run of test_image_1 takes about
  4.5 min; iterate with the unit test first.

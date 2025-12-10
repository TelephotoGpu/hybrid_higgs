# Image kernel datapath

A real-valued (u8 pixel × s8 coefficient) sliding-window datapath for the
Higgs Q-engine. It replaces the 16I/16Q complex FFT datapath at compile time.
Images stream into a Q-engine. The VexRiscv keeps N lines in VMEM, the
vector unit feeds taps into the datapath (LK8 pixels, LK9 coefficients), and
the results are stored back (SK1) and streamed out.

* Design/spec: [NOTES.md](NOTES.md) (the bit-exact contract is §5)
* Plan/status: [PLAN.md](PLAN.md)

## Capabilities
* 3x3, 5x5 and 7x7 kernels on gray (1 px/word) or RGBX (1 px/word, 3
  channels) at 16 pixels per LK8/LK9 beat.
* Ops: copy, Gaussian 3/5/7, box 3/5, sharpen, unsharp, Laplacian,
  Sobel (|Gx|+|Gy| in one pass), Sobel-X, Prewitt, Scharr, emboss,
  erode/dilate, custom s8 kernels, and a per-channel-coefficient demo
  (CHAN_GAUSS).
* Feature detection: thresholded edges, 3x3 non-maximum suppression (peaks),
  global min/max with location, 16x16 tile edge counts → ROI bounding box.
* Borders: ZERO or REPLICATE, with same-size output.

## Layout
| path | what |
|------|------|
| `libs/datapath/image/img_model.py` | fixed-point Python model (done: `selftest`, `gen-unit`, `gen-stream`, `compare`) |
| `libs/datapath/image/simple_model.py` | simple numpy fixed-point model for prototyping kernels and checking Verilog output (`selftest`, `run`, `check`, `filter`; NOTES §8.1) |
| `libs/datapath/image/rtl/img_datapath.v` | datapath RTL (done; unit test in `libs/datapath/image/sim`, `make`) |
| `libs/riscv-baseband/c/inc/image_kernel.{h,c}` | C library (done: `img_run_stages`, `img_stream_loop`) |
| `sim/verilator/test_image_1/` | platform test (done: Verilator + XSIM PASS, `make test`) |
| `libs/spinal/hw/spinal/reqack/` | SpinalHDL replacement for the reqack netlist generator (NOTES §11) |
| `libs/spinal/hw/spinal/qengine/{Piston,PistonDp}.scala` | Spinal piston graph and FFT/image datapath graphs; `make -C libs/spinal piston` writes `libs/q-engine/piston/hdl/piston.v` + `piston_dp_{fft,img}.v` (NOTES §11.4) |
| `libs/spinal/equiv/equiv.py` | lockstep Verilator equivalence check vs the reqack netlists (`make -C libs/q-engine/piston equiv`) |
| `libs/spinal/hw/spinal/qengine/Reciprocal.scala` | 1/c unit in each FFT-datapath cmul, m2c code 3 (NOTES §12); unit test `make -C libs/spinal recip_test` |
| `libs/datapath/recip/recip_model.py` | bit-exact reciprocal / divide lane model and test_recip_1 vector generator |
| `libs/riscv-baseband/c/inc/vector_divide.{h,c}` | `vector_divide_1024()` (FFT datapath, config row `config_word_cdiv_eq_05.h`) |
| `sim/verilator/test_recip_1/` | reciprocal platform test (bit-exact vs the model, `make test`) |
| `libs/spinal/names/` | name lock (`names.lock`, `make -C libs/spinal names_check`, run by `make reqack`) and reqack → Spinal name map / saved-path migration (`map.py`, NOTES §11.5) |

## Selecting the datapath (compile time)
Set `HIGGS_DATAPATH=img` in a test Makefile (Verilator/XSIM) or in the
environment for Vivado (`fpgas/cs/cs12/build/vivado/README.md`). The build
always compiles the shared `libs/q-engine/piston/hdl/piston.v` plus one
datapath, `hdl/piston_dp_img.v` (piston's k8/k9/k14/k1 ports on
`img_datapath`) instead of `hdl/piston_dp_fft.v`. Both define
`module piston_dp`. The default (unset) is the original FFT datapath. All
three come from SpinalHDL via `make -C libs/q-engine/piston build`
(`libs/spinal`, NOTES §11); never hand-edit `hdl/`.

## Using it
* Prototype a kernel in numpy (NOTES §8.1):
  ```
  python3 -m venv libs/datapath/image/.venv
  libs/datapath/image/.venv/bin/pip install -r libs/datapath/image/requirements.txt
  libs/datapath/image/.venv/bin/python libs/datapath/image/simple_model.py filter SOBEL in.pgm out.pgm
  # after a test_image_1 run, check the Verilog output against it:
  cd sim/verilator/test_image_1 && ../../../libs/datapath/image/.venv/bin/python \
      ../../../libs/datapath/image/simple_model.py check in.hex got.hex
  ```
  From Python: `simple_model.mac(img, ka, kb, comb='l1', shift=2, rnd=True)`.
* Firmware (cs22 example: `sim/verilator/test_image_1/override/.../cs22/c`):
  call `img_init()` once, then either `img_stream_loop()` to serve jobs from
  the input stream (NOTES §7 protocol), or call
  `img_op_stages()` + `img_run_stages()` with your own line-in/line-out
  callbacks (`image_kernel.h`).
* Divide on the FFT datapath (NOTES §12): `vector_divide_1024(x_row, y_row,
  out_row)` gives x / Re(y) in Q1.15 (y's Im must be 0 for a plain divide;
  |Re(y)| < 32 saturates 1/Re(y)). Test: `make -C sim/verilator/test_recip_1 test`.
* Test: `make -C sim/verilator/test_image_1 test` (Verilator), or
  `make xsim_run` there with Vivado sourced. Results, cycles per job and
  issues found are in NOTES §10.

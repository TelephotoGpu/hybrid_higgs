# Q-engine SpinalHDL generators

This project contains the authoritative generator for the Xilinx-selected
VMEM DMA return arbiter.

Generate `hw/gen/VmemDatArbOut1_1.v` with:

```sh
make clean vao
```

The generated Verilog is checked in because it is consumed directly by the
CS12 Vivado source overlay and the XSIM/Verilator parity harness.

## Elastic netlists (reqack replacement)

`hw/spinal/reqack/` is a SpinalHDL port of the reqack netlist generator.
`qengine.K15OpVerilog` writes `../q-engine/piston/hdl/k15_op.v`.
`qengine.PistonVerilog` writes `piston.v`, `piston_dp_fft.v` and
`piston_dp_img.v` there too; the build compiles `piston.v` and one
`piston_dp_*.v` (`HIGGS_DATAPATH`). See `doc/kernel/NOTES.md` §11.

```sh
make reqack    # regenerate the Spinal netlists (k15_op, piston) in ../q-engine/piston/hdl
make piston    # only piston.v + piston_dp_{fft,img}.v
make equiv     # lockstep Verilator check against the reqack references
               # (../q-engine/piston/build/ref, written by piston's gen.js)
make equiv_piston_img   # one check: equiv_k15_op, equiv_piston_dp_{fft,img},
                        # equiv_piston_{fft,img}
make names_check        # generated names vs names/names.lock (run by make reqack)
make names_lock         # accept a rename (then migrate saved paths)
```

`names/map.py` maps reqack names (`unode26`, `dat29_r0`, …) to Spinal names
and rewrites saved gtkw/tcl/lpf paths (`doc/kernel/NOTES.md` §11.5).

`make -C ../q-engine/piston build` runs gen.js and then `make reqack`.

sbt needs a free inotify instance. Where the per-user limit is exhausted,
add `SPINAL_RUNNER=direct` to any target. That uses `scripts/direct-run.sh`,
which compiles with scalac using the jars sbt left in the coursier cache.

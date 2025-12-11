# CS01 Vivado implementation target

Run the timing-only implementation flow for `xczu7ev-ffvc1156-2-e`:

```sh
LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 \
    vivado -mode batch -source build.tcl
```

If a tool crash interrupts report generation after routing, regenerate reports
from the routed checkpoint without repeating implementation:

```sh
LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 \
    vivado -mode batch -source report.tcl
```

On this Linux container, Vivado must preload the system `libudev` library.
This is the AMD-supported process-scoped workaround for a Flexera/Revenera
licensing-library `RTLD_DEEPBIND` incompatibility with Vivado's `tcmalloc`
allocator. Without it, Vivado can crash while collecting host information
after routing. Keep `LD_PRELOAD` on the Vivado command only; do not export it
for the shell because it can affect unrelated executables.

The target defines `HIGGS_FPGA_XILINX`, uses portable DSP and Q-engine memory
implementations, constrains the `CLK` input at 125 MHz, and reports timing
after routing. It defines the generated 125 MHz system clock. The selected
CS01 configuration disables the MIB slave, so its 6.25 MHz MIB clock has no
consumers and is optimized away; it is intentionally not constrained.

Validated routed result
-----------------------
With Vivado 2025.2 and the target `xczu7ev-ffvc1156-2-e`, the timing report
has `WNS = +2.112 ns` and `TNS = 0.000 ns` for the 125 MHz `sys_clk`, with no
unconstrained internal endpoints. The corresponding internal timing-derived
frequency is approximately 169.7 MHz (`1 / (8.000 ns - 2.112 ns)`).

No board pin or I/O-standard constraints are included. The routed checkpoint
is suitable for timing exploration only; do not generate or program a
bitstream until a board-specific XDC supplies pin, voltage, and interface
timing constraints. Accordingly, the 38 unconstrained input ports and 37
unconstrained output ports reported by `check_timing` are expected, and the
result is not external interface timing signoff.

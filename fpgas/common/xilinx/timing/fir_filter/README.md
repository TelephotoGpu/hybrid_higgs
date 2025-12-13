# fir_filter out-of-context timing

Out-of-context synthesis, place and route of `libs/q-engine/hdl/fir/fir_filter.v`
on the CS12 part (`xczu7ev-ffvc1156-2-e`) at 125 MHz:

```sh
LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 \
    /opt/amd/2025.2/Vivado/bin/vivado -mode batch -source fir_filter_ooc.tcl [-tclargs NTAPS]
```

Reports are written to `out/ntaps<N>/`. The last line of the log is
`FIR_OOC NTAPS=<N> WNS=<setup> WHS=<hold>`. See `doc/add-fir/NOTES.md` for
recorded results.

# Q-engine stream module out-of-context timing

Out-of-context synthesis, place and route of `fft_corr`, `stream_router`
and `stream_merge` on the CS12 part (`xczu7ev-ffvc1156-2-e`) at 125 MHz:

```sh
LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 \
    /opt/amd/2025.2/Vivado/bin/vivado -mode batch -source qstream_ooc.tcl \
    -tclargs fft_corr [N=256]
```

Reports are written to `out/<top>[_<param>]/`. The last line of the log is
`QSTREAM_OOC <tag> WNS=<setup> WHS=<hold>`. See `doc/add-fir/NOTES.md` for
recorded results.

# dma_out_last module harness

`libs/q-engine/hdl/dma/dma_out_last.v` is the DMA_3 FIR-feed engine. It is a
dma_out variant that attaches `last` on the returned-data side (a tag FIFO
whose occupancy is also the read credit count), so `last` is correct
regardless of VMEM read latency and the data FIFO can never overflow.

`tb_dma_out_last_core.sv` is a clocked, self-checking core testbench shared by
both simulators. It covers a StreamFifo-like config source, an in-order VMEM
model with random latency and request backpressure, random output
backpressure, zero-length schedules, reverse addressing, timer-gated starts,
and `dmaReset` aborts, which must terminate the packet on the last issued word.
The scoreboard checks addresses, word/last pairing, stability under stall,
loss/duplication, memory-side overflow and the busy status. Seed 0 checks
that a chained header+payload streams at 1 word/clk, with a single bubble at
the schedule boundary.

```sh
PATH=/opt/amd/2025.2/Vivado/bin:$PATH make clean compare
```

This runs 20 seeds under Verilator 4.016 and XSIM and requires the traces to be
byte-identical. RNG draws are tasks, and are never placed in `?:` arms, because
Verilator 4.016 merges or eagerly evaluates side-effecting function calls.

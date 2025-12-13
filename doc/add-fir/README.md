# Q-engine complex FIR worklog

This directory is the committed record for adding a streaming, fixed-point,
complex FIR filter (`fir_filter`) to the Q-engine. It sits alongside
`doc/xilinx-port` and builds on that port's 125 MHz `xczu7ev-ffvc1156-2-e` CS12 target and
the SpinalHDL VMEM crossbar from commit `ae22141`.

- `PLAN.md`: the agreed contract and execution order.
- `NOTES.md`: evidence, findings, and deviations. It is updated at every milestone.

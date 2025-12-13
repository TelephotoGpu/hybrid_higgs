#!/usr/bin/env python3
"""With always-valid/always-ready patterns (seed 0), fir_filter must accept
one input beat on every cycle.  The only permitted idle cycles are the
testbench's own err_clear cycles (one before each beat flagged clear_before).

usage: check_throughput.py <trace.csv> <in.txt>
"""
import sys

cycles = [int(l.split(",")[0]) for l in open(sys.argv[1]) if ",IN," in l]
clears = [int(l.split()[2]) for l in open(sys.argv[2])]
expect, c = [], 0
for i, clr in enumerate(clears):
    c += clr
    expect.append(i + c)
if cycles != expect:
    bad = [(i, a, b) for i, (a, b) in enumerate(zip(cycles, expect)) if a != b][:5]
    print("FAIL: input stalled under full throughput (beat, got, expected):", bad)
    sys.exit(1)
print("PASS: %d input beats accepted back-to-back (%d err_clear cycles)" % (len(cycles), c))

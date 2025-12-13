#!/usr/bin/env python3
"""With always-valid/always-ready patterns (seed 0), golay_corr must accept
one input beat per cycle, except for the testbench's own err_clear cycles and
the pipeline drain after a beat that commits a config or applies a RESET
(flagged in in.txt column 5), which may stall for at most M + 6 cycles.

usage: check_throughput.py <trace.csv> <in.txt> <M>
"""
import sys

cycles = [int(l.split(",")[0]) for l in open(sys.argv[1]) if ",IN," in l]
rows = [l.split() for l in open(sys.argv[2])]
m = int(sys.argv[3])
bad = []
waits = 0
for i in range(1, len(cycles)):
    gap = cycles[i] - cycles[i - 1] - 1 - int(rows[i][2])
    if int(rows[i - 1][4]):
        waits += 1
        if not 0 <= gap <= m + 6:
            bad.append((i, gap, "wait"))
    elif gap != 0:
        bad.append((i, gap))
if bad or len(cycles) != len(rows):
    print("FAIL: input stalled under full throughput:", bad[:5], len(cycles), len(rows))
    sys.exit(1)
print("PASS: %d input beats back-to-back except %d bounded config/reset drains"
      % (len(cycles), waits))

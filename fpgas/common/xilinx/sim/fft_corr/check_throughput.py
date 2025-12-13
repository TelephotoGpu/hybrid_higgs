#!/usr/bin/env python3
"""Seed 0 (always valid/ready): the long DATA packet (in.txt column 5 = 1)
must be accepted at >= MIN samples/clk on average (block rule: N+1 samples
per 2N-cycle FFT frame, so about 0.5).

usage: check_throughput.py <trace.csv> <in.txt> [MIN]
"""
import sys

cycles = [int(l.split(",")[0]) for l in open(sys.argv[1]) if ",IN," in l]
rows = [l.split() for l in open(sys.argv[2])]
lo = float(sys.argv[3]) if len(sys.argv) > 3 else 0.45
idx = [i for i, r in enumerate(rows) if r[4] == "1"]
if len(cycles) != len(rows) or not idx:
    print("FAIL: trace/input mismatch")
    sys.exit(1)
span = cycles[idx[-1]] - cycles[idx[0]] + 1
rate = len(idx) / span
print("%s: %d samples in %d cycles = %.3f samples/clk (min %.2f)"
      % ("PASS" if rate >= lo else "FAIL", len(idx), span, rate, lo))
sys.exit(0 if rate >= lo else 1)

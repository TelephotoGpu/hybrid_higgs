#!/usr/bin/env python3
"""test_fir_1 cross-check: both simulators must pass their own bit-exact
model comparison, and their captured CS20 streams must equal expected.hex."""
import sys

PASS_STRING = "All Tests Passed"


def read_words(path):
    with open(path) as handle:
        return [int(line.strip(), 16) for line in handle if line.strip()]


def first_diff(a, b):
    return next((i for i, (x, y) in enumerate(zip(a, b)) if x != y),
                min(len(a), len(b)))


def main():
    if len(sys.argv) != 6:
        print("usage: compare_fir.py <expected> <verilator-log> "
              "<verilator-samples> <xsim-log> <xsim-samples>")
        return 2
    exp_path, ver_log, ver_path, xsim_log, xsim_path = sys.argv[1:]
    ok = True
    for name, path in (("Verilator", ver_log), ("XSIM", xsim_log)):
        with open(path) as handle:
            if PASS_STRING not in handle.read():
                print(f'FAIL: {name}: missing "{PASS_STRING}"')
                ok = False

    expected = read_words(exp_path)
    for name, path in (("Verilator", ver_path), ("XSIM", xsim_path)):
        got = read_words(path)
        if got != expected:
            print(f"FAIL: {name} differs from the model at sample "
                  f"{first_diff(got, expected)} (count {len(got)} vs "
                  f"{len(expected)})")
            ok = False

    if ok:
        print(f"PASS: {len(expected)} FIR samples match the Python model "
              "exactly in Verilator and XSIM")
        return 0
    return 1


if __name__ == "__main__":
    sys.exit(main())

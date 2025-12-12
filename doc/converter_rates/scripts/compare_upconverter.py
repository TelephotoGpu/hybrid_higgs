#!/usr/bin/env python3
import argparse
import subprocess
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
if str(SCRIPT_DIR) not in sys.path:
    sys.path.insert(0, str(SCRIPT_DIR))

import fixedpoint_model as model

REPO_ROOT = Path(__file__).resolve().parents[3]
HDL_DIR = REPO_ROOT / "libs" / "ip-library" / "upconverter" / "hdl"
OUTPUT_PATH = HDL_DIR / "tb_output.csv"
TOLERANCE = 0
MAX_LAG = 16


def parse_csv(path: Path):
    rows = []
    with path.open() as handle:
        for raw in handle:
            line = raw.strip()
            if not line:
                continue
            left, right = [part.strip() for part in line.split(",", 1)]
            rows.append((int(left), int(right)))
    return rows


def find_best_lag(expected, actual, max_lag):
    best = None
    for lag in range(-max_lag, max_lag + 1):
        corr = 0
        count = 0
        for index, (exp_i, exp_q) in enumerate(expected):
            actual_index = index + lag
            if 0 <= actual_index < len(actual):
                act_i, act_q = actual[actual_index]
                corr += exp_i * act_i + exp_q * act_q
                count += 1
        if count == 0:
            continue
        score = (corr, -abs(lag))
        if best is None or score > best[0]:
            best = (score, lag)
    return 0 if best is None else best[1]


def compare(expected, actual, tolerance):
    lag = find_best_lag(expected, actual, MAX_LAG)
    start = model.leading_nonzero_index(expected)
    worst = (0, 0, 0, 0, 0, 0, 0)
    mismatches = []
    compared = 0
    for index in range(start, len(expected)):
        actual_index = index + lag
        if not (0 <= actual_index < len(actual)):
            mismatches.append((index, "missing"))
            break
        exp_i, exp_q = expected[index]
        act_i, act_q = actual[actual_index]
        diff_i = act_i - exp_i
        diff_q = act_q - exp_q
        peak = max(abs(diff_i), abs(diff_q))
        compared += 1
        if peak > worst[0]:
            worst = (peak, index, actual_index, exp_i, act_i, exp_q, act_q)
        if abs(diff_i) > tolerance or abs(diff_q) > tolerance:
            mismatches.append((index, actual_index, exp_i, act_i, exp_q, act_q))
            if len(mismatches) >= 8:
                break
    if mismatches:
        lines = [f"FAIL: lag={lag}, start={start}, tolerance={tolerance}"]
        for item in mismatches:
            if len(item) == 2:
                lines.append(f"  idx={item[0]}: missing actual sample after lag alignment")
            else:
                index, actual_index, exp_i, act_i, exp_q, act_q = item
                lines.append(
                    f"  exp_idx={index} act_idx={actual_index}: "
                    f"I exp={exp_i} act={act_i} diff={act_i-exp_i}; "
                    f"Q exp={exp_q} act={act_q} diff={act_q-exp_q}"
                )
        lines.append(
            f"  worst |diff|={worst[0]} at exp_idx={worst[1]} act_idx={worst[2]} "
            f"(I exp/act {worst[3]}/{worst[4]}, Q exp/act {worst[5]}/{worst[6]})"
        )
        return False, "\n".join(lines)
    return True, f"PASS: lag={lag}; {compared} samples matched exactly after trimming {start} leading zero samples"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--ratio", type=int, default=4)
    args = parser.parse_args()

    cycles = (model.DUC_SAMPLE_COUNT * args.ratio) + 512
    model.write_upconverter_vectors()
    expected = model.upconverter_expected_outputs(ratio=args.ratio)
    subprocess.run(
        [
            "make",
            "clean",
            "verilate",
            "compile",
            "run",
            f"VERILATOR_ARGS=-GRATIO={args.ratio}",
            f"RUN_ARGS=--cycles {cycles}",
        ],
        cwd=HDL_DIR,
        check=True,
    )
    actual = parse_csv(OUTPUT_PATH)
    ok, message = compare(expected, actual, TOLERANCE)
    print(f"RATIO={args.ratio} {message}")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())

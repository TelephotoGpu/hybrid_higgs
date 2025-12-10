#!/usr/bin/env python3
"""Lockstep co-simulation equivalence check of two netlists in Verilator.

The reference netlist (reqack output) and the DUT netlist (Spinal output)
must have the same top-module ports. Every module defined in the --ref files
is renamed <name>_ref so both copies coexist; leaf modules (--lib) are shared.
A generated top drives both with the same random, per-seed biased inputs
every cycle (with random resets) and the C++ bench compares every output on
both clock phases, reporting the first mismatch.

  equiv.py --top k15_op --ref ref/k15_op.v --dut hdl/k15_op.v \\
           --work build/equiv/k15_op [--lib a.v ...] [--cycles N] [--seeds N]
           [--stim PORT=C++EXPR ...] [--prelude helpers.h] [--reset-rate P]
           [--fixup C++STMT ...] [--stop C++EXPR]

--stop ends a seed early (not a failure) after the first cycle whose
expression, evaluated before the rising edge, is true; that cycle is still
compared. A prelude can reach DUT internals through dut(m) when the netlist
is verilated with --vflags=--public.
"""
import argparse
import os
import re
import subprocess
import sys


def strip_comments(s):
    s = re.sub(r'/\*.*?\*/', ' ', s, flags=re.S)
    return re.sub(r'//[^\n]*', ' ', s)


def module_names(text):
    return re.findall(r'^\s*module\s+([A-Za-z_]\w*)', strip_comments(text), flags=re.M)


def ports(text, top):
    """(name, dir, width) of an ANSI module header with constant ranges."""
    t = strip_comments(text)
    m = re.search(r'\bmodule\s+' + re.escape(top) + r'\b\s*(#\s*\((?:[^()]|\([^()]*\))*\))?\s*\(', t)
    if not m:
        sys.exit('equiv: module %s not found' % top)
    depth, i = 1, m.end()
    while depth:
        depth += {'(': 1, ')': -1}.get(t[i], 0)
        i += 1
    res, d, w = [], None, 1
    for item in t[m.end():i - 1].split(','):
        item = ' '.join(item.split())
        pm = re.match(r'^(?:(input|output)\s+)?(?:(?:wire|reg)\s+)?(?:\[(\d+):(\d+)\]\s*)?([A-Za-z_]\w*)$', item)
        if not pm:
            sys.exit('equiv: cannot parse port "%s" of %s' % (item, top))
        if pm.group(1):
            d = pm.group(1)
            w = int(pm.group(2)) - int(pm.group(3)) + 1 if pm.group(2) else 1
        res.append((pm.group(4), d, w))
    return res


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--top', required=True)
    ap.add_argument('--ref', nargs='+', required=True)
    ap.add_argument('--dut', nargs='+', required=True)
    ap.add_argument('--lib', nargs='*', default=[])
    ap.add_argument('--work', required=True)
    ap.add_argument('--cycles', type=int, default=20000)
    ap.add_argument('--seeds', type=int, default=8)
    ap.add_argument('--vflags', default='')
    ap.add_argument('--stim', action='append', default=[], metavar='PORT=EXPR',
                    help='C++ expression for an input (<= 64 bits) instead of uniform random '
                         'bits; rng() is a std::mt19937_64 and fire_<port> is true if '
                         'the <port>_req/<port>_ack handshake completed in the previous cycle')
    ap.add_argument('--prelude', help='C++ file included at file scope (helpers for --stim)')
    ap.add_argument('--fixup', action='append', default=[], metavar='C++STMT',
                    help='statement run after the inputs are set each cycle (m is the model), '
                         'e.g. to constrain an input wider than 64 bits')
    ap.add_argument('--stop', help='C++ condition, checked before each rising edge, that ends the '
                                   'seed early: the netlists may legitimately differ afterwards')
    ap.add_argument('--reset-rate', type=float, default=0.0005,
                    help='per-cycle probability of a random reset (seeds > 1)')
    a = ap.parse_args()
    stim = dict(x.split('=', 1) for x in a.stim)
    os.makedirs(a.work, exist_ok=True)

    refs = [open(f).read() for f in a.ref]
    renames = {n for r in refs for n in module_names(r)}
    ref_text = ''
    for r in refs:
        for n in renames:
            r = re.sub(r'\b%s\b' % re.escape(n), n + '_ref', r)
        ref_text += r
    with open(os.path.join(a.work, 'ref.v'), 'w') as f:
        f.write(ref_text)

    dut_text = ''.join(open(f).read() for f in a.dut)
    pd = ports(dut_text, a.top)
    pr = ports(ref_text, a.top + '_ref')
    if sorted(pd) != sorted(pr):
        sys.exit('equiv: port mismatch\n  dut only: %s\n  ref only: %s' %
                 (sorted(set(pd) - set(pr)), sorted(set(pr) - set(pd))))

    ins = [p for p in pd if p[1] == 'input' and p[0] not in ('clk', 'reset_n')]
    outs = [p for p in pd if p[1] == 'output']
    # (base, ref-side req, ref-side ack) of every handshake, either direction
    names = {n: d for n, d, _ in pd}
    hs = [(n[:-4], ('m->' if names[n] == 'input' else 'm->ref_') + n,
           ('m->' if names[n[:-4] + '_ack'] == 'input' else 'm->ref_') + n[:-4] + '_ack')
          for n, _, _ in pd if n.endswith('_req') and n[:-4] + '_ack' in names]
    rng = lambda w: '[%d:0] ' % (w - 1) if w > 1 else ''

    top = ['module equiv_top (', '  input clk, input reset_n,']
    top += ['  input %s%s,' % (rng(w), n) for n, _, w in ins]
    top += ['  output %sref_%s, output %sdut_%s,' % (rng(w), n, rng(w), n) for n, _, w in outs]
    top[-1] = top[-1].rstrip(',')
    top.append(');')
    for inst, mod, pre in (('u_ref', a.top + '_ref', 'ref_'), ('u_dut', a.top, 'dut_')):
        b = ['.clk(clk)', '.reset_n(reset_n)'] + ['.%s(%s)' % (n, n) for n, _, _ in ins] + \
            ['.%s(%s%s)' % (n, pre, n) for n, _, _ in outs]
        top.append('%s %s (\n  %s\n);' % (mod, inst, ',\n  '.join(b)))
    top.append('endmodule')
    with open(os.path.join(a.work, 'equiv_top.v'), 'w') as f:
        f.write('\n'.join(top) + '\n')

    cpp = ['#include "Vequiv_top.h"', '#include "verilated.h"', '#include <cstdio>',
           '#include <cstdint>', '#include <random>',
           'static std::mt19937_64 rng;',
           'static bool coin(double p) { std::bernoulli_distribution b(p); return b(rng); }']
    cpp += ['static bool fire_%s;' % b for b, _, _ in hs]
    cpp += ['#include "Vequiv_top__Syms.h"',
            '#define dut(m) ((m)->__VlSymsp->TOP__equiv_top__u_dut)']
    if a.prelude:
        cpp.append('#include "%s"' % os.path.abspath(a.prelude))
    cpp += [
           'int main(int argc, char **argv) {',
           '  Verilated::commandArgs(argc, argv);',
           '  const long cycles = %d; const int seeds = %d; int fails = 0; long total = 0; int stops = 0;' % (a.cycles, a.seeds),
           '  for (int seed = 1; seed <= seeds && !fails; seed++) {',
           '    rng.seed(seed * 7919);',
           '    Vequiv_top *m = new Vequiv_top;',
           '    std::uniform_real_distribution<double> pd(0.05, 0.95);']
    cpp += ['    double p_%s = pd(rng);' % n for n, _, w in ins if w == 1]
    cpp += ['    m->clk = 0; m->reset_n = 0;',
            '    long c = 0; bool stop = false;',
            '    for (; c < cycles && !fails && !stop; c++) {',
            '      m->reset_n = c >= 3 && !(seed > 1 && coin(%r));' % a.reset_rate]
    unknown = set(stim) - {n for n, _, w in ins if w <= 64}
    if unknown:
        sys.exit('equiv: --stim for unknown or >64-bit inputs: %s' % sorted(unknown))
    for n, _, w in ins:
        if n in stim:
            cpp.append('      m->%s = (%s) & (%s);' % (n, stim[n], '~0ULL' if w == 64 else '((1ULL << %d) - 1)' % w))
        elif w == 1:
            cpp.append('      m->%s = coin(p_%s);' % (n, n))
        elif w < 64:
            cpp.append('      m->%s = rng() & ((1ULL << %d) - 1);' % (n, w))
        elif w == 64:
            cpp.append('      m->%s = rng();' % n)
        else:
            words = (w + 31) // 32
            cpp.append('      for (int i = 0; i < %d; i++) m->%s[i] = (uint32_t)rng();' % (words, n))
            if w % 32:
                cpp.append('      m->%s[%d] &= (1u << %d) - 1;' % (n, words - 1, w % 32))
    cpp += ['      %s;' % f for f in a.fixup]
    cpp += ['      for (int ph = 0; ph < 2 && !fails; ph++) {',
            '        m->clk = ph; m->eval();']
    cpp += ['        if (ph == 0) fire_%s = m->reset_n && %s && %s;' % (b, r, k) for b, r, k in hs]
    for n, _, w in outs:
        if w <= 64:
            cond = 'm->ref_%s != m->dut_%s' % (n, n)
        else:
            cond = '[&]{ for (int i = 0; i < %d; i++) if (m->ref_%s[i] != m->dut_%s[i]) return true; return false; }()' % ((w + 31) // 32, n, n)
        if w <= 64:
            dump = 'printf("  ref %%llx dut %%llx\\n", (unsigned long long)m->ref_%s, (unsigned long long)m->dut_%s);' % (n, n)
        else:
            dump = ('for (int i = 0; i < %d; i++) if (m->ref_%s[i] != m->dut_%s[i]) '
                    'printf("  word %%d: ref %%08x dut %%08x\\n", i, m->ref_%s[i], m->dut_%s[i]);' % ((w + 31) // 32, n, n, n, n))
        cpp.append('        if (%s) { printf("MISMATCH seed %%d cycle %%ld phase %%d: %s\\n", seed, c, ph); %s fails++; }' % (cond, n, dump))
    if a.stop:
        cpp.append('        if (ph == 0 && m->reset_n && (%s)) stop = true;' % a.stop)
    cpp += ['      }', '    }',
            '    total += c; stops += stop;',
            '    if (!fails) printf(stop ? "seed %d: %ld cycles equal, stopped (--stop)\\n" : "seed %d: %ld cycles equal\\n", seed, c);',
            '    delete m;',
            '  }',
            '  if (!fails) printf("%ld cycles compared, %d seeds stopped early\\n", total, stops);',
            '  printf(fails ? "EQUIV FAIL\\n" : "EQUIV PASS\\n");',
            '  return fails ? 1 : 0;',
            '}']
    with open(os.path.join(a.work, 'tb.cpp'), 'w') as f:
        f.write('\n'.join(cpp) + '\n')

    srcs = ['equiv_top.v', 'ref.v'] + [os.path.abspath(p) for p in a.dut + a.lib]
    run('rm -rf obj_dir && verilator --cc --exe tb.cpp -O2 --top-module equiv_top -Wno-fatal -Wno-lint '
        '-Wno-style -Wno-WIDTH -Wno-SELRANGE -Wno-UNOPTFLAT -Wno-CASEINCOMPLETE +define+VERILATE '
        '+1364-2001ext+v -Mdir obj_dir %s %s' % (a.vflags, ' '.join(srcs)), a.work)
    run('make -s -j%d -C obj_dir -f Vequiv_top.mk Vequiv_top OPT_FAST=-O1' % os.cpu_count(), a.work)
    sys.exit(subprocess.call(['./obj_dir/Vequiv_top'], cwd=a.work))


def run(cmd, cwd):
    r = subprocess.run(cmd, shell=True, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                       universal_newlines=True)
    if r.returncode:
        sys.stdout.write(r.stdout[-6000:])
        sys.exit('equiv: failed: ' + cmd[:300])


if __name__ == '__main__':
    main()

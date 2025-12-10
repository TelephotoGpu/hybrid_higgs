#!/usr/bin/env python3
"""reqack -> Spinal signal-name map for piston, and saved-path migration.

The reqack piston.v named nodes unode<N> and edges dat<N>/req<N>/... by
creation index; the Spinal netlists name them after the graph. This pairs the
two graphs (gen.js build/ref/<v>.json, qengine.PistonGraphs build/names/*.json)
and resolves every reqack wire/reg/instance of build/ref/<v>.v to the Spinal
name, checked against the generated Verilog.

  map.py map     VARIANT      print "<reqack> <spinal>" (piston scope; the
                               controller module scope is "uctrl.")
  map.py migrate VARIANT FILE...   rewrite piston_inst<sep><reqack> paths
                               (controller names also match flattened)

Names mapped to "-" have no Spinal equivalent (inlined controllers,
reqack-internal nets); names the reqack netlist no longer had are left.
"""
import argparse
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
PISTON = os.path.join(HERE, '..', '..', 'q-engine', 'piston')
REF = os.path.join(PISTON, 'build', 'ref')
HDL = os.path.join(PISTON, 'hdl')
SPINAL = os.path.join(HERE, '..', 'build', 'names')
sys.path.insert(0, HERE)
sys.dont_write_bytecode = True
import names as names_mod  # noqa: E402

# reqack declares comma lists ("wire [63:0] dat26, dat26_nxt;") and puts
# instances at column 0
REF_DECL = re.compile(r'^[ \t]*(?:input|output|wire|reg)\b[ \t]*(?:wire|reg)?[ \t]*(?:signed[ \t]+)?(?:\[[^\]]+\][ \t]*)?([^;()]+);', re.M)
REF_INST = re.compile(r'^[ \t]*(?:(?!module\b)\w+|\))[ \t]+(\w+)[ \t]*\([ \t]*$', re.M)
VARIANTS = {'fft': ('piston', 'piston_dp_fft'), 'img': ('piston_img', 'piston_dp_img')}


def load(path):
    with open(path) as fh:
        return json.load(fh)


def declared(path):
    return {n for _, _, n in names_mod.names(path)}


def match(A, B, what):
    """Pair nodes/edges of two graphs by structure. Nodes are
    {label, from, to} (label None = anonymous; from None = do not follow),
    edges {src, targets}. Seeds are labels unique in both graphs; pairs are
    propagated through the ordered port lists (a node's k-th input/output
    edge, an edge's source and k-th target)."""
    nm, em, work = {}, {}, []

    def pn(a, b):
        if nm.get(a, b) != b:
            raise SystemExit(f'{what}: node {a} pairs with {nm[a]} and {b}')
        if A['nodes'][a]['label'] != B['nodes'][b]['label']:
            raise SystemExit(f'{what}: node {a} {A["nodes"][a]["label"]} vs {B["nodes"][b]["label"]}')
        if a not in nm:
            nm[a] = b
            work.append(('n', a, b))

    def pe(a, b):
        if em.get(a, b) != b:
            raise SystemExit(f'{what}: edge {a} pairs with {em[a]} and {b}')
        if a not in em:
            em[a] = b
            work.append(('e', a, b))

    def uniq(G):
        c = {}
        for i, n in enumerate(G['nodes']):
            if n['label'] is not None:
                c.setdefault(n['label'], []).append(i)
        return {k: v[0] for k, v in c.items() if len(v) == 1}

    ua, ub = uniq(A), uniq(B)
    for k in ua.keys() & ub.keys():
        pn(ua[k], ub[k])
    while work:
        t, a, b = work.pop()
        if t == 'n':
            na, nb = A['nodes'][a], B['nodes'][b]
            for key in ('from', 'to'):
                if na[key] is not None and nb[key] is not None and len(na[key]) == len(nb[key]):
                    for x, y in zip(na[key], nb[key]):
                        pe(x, y)
        else:
            ea, eb = A['edges'][a], B['edges'][b]
            pn(ea['src'], eb['src'])
            if len(ea['targets']) == len(eb['targets']):
                for x, y in zip(ea['targets'], eb['targets']):
                    pn(x, y)
    miss = [i for i in range(len(A['nodes'])) if i not in nm]
    miss_e = [i for i in range(len(A['edges'])) if i not in em]
    if miss or miss_e:
        raise SystemExit(f'{what}: unpaired reqack nodes {miss[:10]} edges {miss_e[:10]}')
    return nm, em


def spinal_graph(g):
    return {'nodes': [{'label': n['kind'], 'from': n['from'], 'to': n['to']} for n in g['nodes']],
            'edges': [{'src': e['src'], 'targets': [t[0] for t in e['targets']]} for e in g['edges']]}


def js_graph(g):
    return {'nodes': [{'label': n['label'], 'from': n['from'], 'to': n['to']} for n in g['nodes']],
            'edges': [{'src': e['src'], 'targets': [t[0] for t in e['targets']]} for e in g['edges']]}


def pair(variant):
    """Return (sp, dp, nodes, edges): reqack index -> (scope, Spinal index)."""
    ref_name, dp_name = VARIANTS[variant]
    js = load(os.path.join(REF, ref_name + '.json'))
    js_dp = load(os.path.join(REF, dp_name + '.json'))
    sp = load(os.path.join(SPINAL, 'piston.json'))
    dp = load(os.path.join(SPINAL, dp_name + '.json'))
    b = js['dp']
    inside = lambda n: b['n0'] <= n < b['n1']

    # top level: the reqack dp block collapses to one node (dp's inputs are
    # reached through the omux edges, so its from list is not followed)
    top_nodes = [i for i in range(len(js['nodes'])) if not inside(i)]
    DP = len(top_nodes)
    nix = {j: k for k, j in enumerate(top_nodes)}
    col = lambda n: DP if inside(n) else nix[n]
    top_edges = [k for k, e in enumerate(js['edges'])
                 if not (inside(e['src']) and all(inside(t[0]) for t in e['targets']))]
    eix = {j: k for k, j in enumerate(top_edges)}
    A = {'nodes': [{'label': js['nodes'][j]['label'],
                    'from': [eix[x] for x in js['nodes'][j]['from']],
                    'to': [eix[x] for x in js['nodes'][j]['to']]} for j in top_nodes], 'edges': []}
    A['nodes'].append({'label': 'piston_dp', 'from': None,
                       'to': [eix[k] for k in top_edges if inside(js['edges'][k]['src'])]})
    for k in top_edges:
        e = js['edges'][k]
        ts = []
        for t in e['targets']:
            if col(t[0]) not in ts:
                ts.append(col(t[0]))
        A['edges'].append({'src': col(e['src']), 'targets': ts})
    B = spinal_graph(sp)
    nm_top, em_top = match(A, B, f'{variant} piston')

    # datapath: reqack dp-only graph vs Spinal dp graph; the dp-only graph
    # repeats the dp block's construction after its k8/k9/k14 targets
    nm_dp, em_dp = match(js_graph(js_dp), spinal_graph(dp), f'{variant} piston_dp')
    off_n = b['n0'] - 3
    off_e = b['e0'] - 3
    nodes, edges = {}, {}
    for j in top_nodes:
        nodes[j] = ('', nm_top[nix[j]])
    for j in range(b['n0'], b['n1']):
        if js_dp['nodes'][j - off_n]['label'] != js['nodes'][j]['label']:
            raise SystemExit(f'{variant}: dp node {j} does not line up with piston_dp')
        nodes[j] = ('dp', nm_dp[j - off_n])
    for k, e in enumerate(js['edges']):
        if k in eix:
            edges[k] = ('', sp['edges'][em_top[eix[k]]], sp)
        else:
            if not b['e0'] <= k < b['e1'] or js_dp['edges'][k - off_e]['src'] != e['src'] - off_n:
                raise SystemExit(f'{variant}: dp edge {k} does not line up with piston_dp')
            edges[k] = ('dp', dp['edges'][em_dp[k - off_e]], dp)
    return sp, dp, nodes, edges


def build_map(variant):
    sp, dp, nodes, edges = pair(variant)
    ref_name, dp_name = VARIANTS[variant]
    have = {'': declared(os.path.join(HDL, 'piston.v')),
            'dp': declared(os.path.join(HDL, dp_name + '.v'))}

    ref = open(os.path.join(REF, ref_name + '.v')).read()
    ctrl_at = ref.index('\nmodule piston_ctrl')
    old = {}
    for scope, text in (('', ref[:ctrl_at]), ('uctrl.', ref[ctrl_at:])):
        for names in REF_DECL.findall(text):
            for n in names.split(','):
                old.setdefault(scope + n.split('=')[0].split()[0], None)
        for m in REF_INST.finditer(text):
            old.setdefault(scope + m.group(1), None)

    def node_name(j, ctrl):
        sc, s = nodes[j]
        g = dp if sc == 'dp' else sp
        n = g['nodes'][s]['name']
        return sc, (n + '_ctrl' if ctrl else n)

    out = {}
    for full in old:
        scope, n = (full.split('.', 1) if '.' in full else ('', full))
        m = re.fullmatch(r'unode(\d+)', n)
        if m and int(m.group(1)) in nodes:
            sc, nn = node_name(int(m.group(1)), scope == 'uctrl')
            cands = [nn] if scope == '' else [nn]
        else:
            m = re.fullmatch(r'(dat|req|ack|en|sel)(\d+)(m|_nxt|_r|_r0|_r1|_\d+)?', n)
            if not m or int(m.group(2)) not in edges:
                out[full] = None
                continue
            kind, k, suf = m.group(1), int(m.group(2)), m.group(3) or ''
            sc, se, g = edges[k]
            e = se['name']
            if suf.startswith('_') and suf[1:].isdigit() and kind in ('req', 'ack'):
                t = se['targets'][int(suf[1:])] if int(suf[1:]) < len(se['targets']) else None
                cands = [f"{e}_to_{g['nodes'][t[0]]['ident']}_{kind}"] if t else []
            else:
                cands = {
                    ('dat', ''): [e], ('dat', '_nxt'): [e + '_nxt'], ('dat', '_r'): [e + '_eb_r'],
                    ('dat', '_r0'): [e + '_eb_r0'], ('dat', '_r1'): [e + '_eb_r1'],
                    ('en', ''): [e + '_eb_en'], ('en', '_0'): [e + '_eb_en0'], ('en', '_1'): [e + '_eb_en1'],
                    ('sel', ''): [e + '_eb_sel'],
                    ('req', ''): [e + '_req'], ('ack', ''): [e + '_ack'],
                    ('req', 'm'): [e + '_m_req', e + '_eb_valid', e + '_req'],
                    ('ack', 'm'): [e + '_m_ack', e + '_ack'],
                }.get((kind, suf), [])
        hit = next((c for c in cands if c in have[sc]), None)
        out[full] = (('dp.' if sc else '') + hit) if hit else None
    return out


def migrate(variant, files):
    full = build_map(variant)
    m = {k: v for k, v in full.items() if v and not k.startswith('uctrl.')}
    # synthesis flattens reqack's controller (uctrl) into piston_inst
    for k, v in full.items():
        if v and k.startswith('uctrl.') and k[6:] not in full:
            m[k[6:]] = v
    pat = re.compile(r'(piston_inst)([./]|__DOT__|__02E)(' + '|'.join(sorted(map(re.escape, m), key=len, reverse=True))
                     + r')(?![A-Za-z0-9_])')
    total = 0
    for f in files:
        s = open(f, newline='').read()
        s2, n = pat.subn(lambda x: x.group(1) + x.group(2) + m[x.group(3)].replace('.', x.group(2)), s)
        if n:
            open(f, 'w', newline='').write(s2)
            print(f'{f}: {n}')
            total += n
    print(f'migrated {total} paths')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mode', choices=['map', 'migrate'])
    ap.add_argument('variant', choices=sorted(VARIANTS))
    ap.add_argument('files', nargs='*')
    a = ap.parse_args()
    if a.mode == 'map':
        m = build_map(a.variant)
        for k in sorted(m):
            print(k, m[k] or '-')
        done = sum(1 for v in m.values() if v)
        print(f'# {done}/{len(m)} reqack names mapped; "-" has no Spinal equivalent '
              f'(inlined controllers, reqack-internal nets)', file=sys.stderr)
    else:
        migrate(a.variant, a.files)


if __name__ == '__main__':
    main()

'use strict';

// Image kernel datapath (libs/datapath/image/rtl/img_datapath.v,
// doc/kernel/NOTES.md) as a single fhyper node. Drop-in replacement for
// datapath.js: takes the same k8/k9/k14 targets and returns the k1 initiator.
// piston/bin/gen.js uses it to write the reqack equivalence references
// build/ref/piston_img.v and build/ref/piston_dp_img.v; the netlists in hdl/
// come from SpinalHDL (libs/spinal qengine/PistonDp.scala).

module.exports = function (g, params) {
    params = params || {};
    const nSlices = params.slices || 16;
    const rkw = {width: nSlices * 32, capacity: 1.5};

    return function (dpTargets) {
        const img = g('img_datapath');
        // connection order sets the ctrl macro's p.t order: k8, k9, k14
        dpTargets.k8(img, 'k8');
        dpTargets.k9(img, 'k9');
        dpTargets.k14(img, 'k14');
        return {
            k1: img(rkw, 'k1')
        };
    };
};

const reqack = (id, port, targetSide) => [
    [port + '_req', 'n' + id + '_' + port + '_req', targetSide ? 1 : -1],
    [port + '_ack', 'n' + id + '_' + port + '_ack', targetSide ? -1 : 1]
];

const ctrl2data = p => []
    .concat(reqack(p.id, 'k8', true))
    .concat(reqack(p.id, 'k9', true))
    .concat(reqack(p.id, 'k14', true))
    .concat(reqack(p.id, 'k1', false));

module.exports.macros = {
    img_datapath: {
        // img_datapath.v has its own req/ack pipeline, so the data module
        // instance takes req/ack wires that the ctrl module passes through.
        data: p => {
            const wire = {};
            p.t.concat(p.i).forEach(b => { wire[b.port] = b.wire; });
            ['t_k8_dat', 't_k9_dat', 't_k14_dat', 'i_k1_dat'].forEach(port => {
                if (wire[port] === undefined) {
                    throw new Error('img_datapath node ' + p.id + ': missing ' + port);
                }
            });
            const sigs = ctrl2data(p);
            const s = {};
            sigs.forEach(sig => { s[sig[0]] = sig[1]; });
            return `
${sigs.map(sig => 'wire ' + sig[1] + ';').join('\n')}
img_datapath unode${p.id} (
    .clk(clk),
    .reset_n(reset_n),
    .t_k8_dat(${wire.t_k8_dat}),
    .t_k8_req(${s.k8_req}),
    .t_k8_ack(${s.k8_ack}),
    .t_k9_dat(${wire.t_k9_dat}),
    .t_k9_req(${s.k9_req}),
    .t_k9_ack(${s.k9_ack}),
    .t_k14_dat(${wire.t_k14_dat}),
    .t_k14_req(${s.k14_req}),
    .t_k14_ack(${s.k14_ack}),
    .i_k1_dat(${wire.i_k1_dat}),
    .i_k1_req(${s.k1_req}),
    .i_k1_ack(${s.k1_ack})
);
`;
        },
        ctrl: p => {
            const s = {};
            ctrl2data(p).forEach(sig => { s[sig[0]] = sig[1]; });
            return `// node:${p.id} img_datapath
assign ${s.k8_req} = req${p.t[0]};
assign ack${p.t[0]} = ${s.k8_ack};
assign ${s.k9_req} = req${p.t[1]};
assign ack${p.t[1]} = ${s.k9_ack};
assign ${s.k14_req} = req${p.t[2]};
assign ack${p.t[2]} = ${s.k14_ack};
assign req${p.i[0]} = ${s.k1_req};
assign ${s.k1_ack} = ack${p.i[0]};`;
        },
        ctrl2data: ctrl2data
    }
};

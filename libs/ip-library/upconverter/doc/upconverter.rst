Upconverter Module
******************

This module implements the upconverter. The upconverter interpolates a
complex baseband stream by ``RATIO`` and then modulates it to a fixed
-39 MHz IF. Legal ``RATIO`` values are 2, 4, 8, and 16; the default is 4.
The baseband input rate is the DAC sample rate divided by ``RATIO``, so a
125 MS/s DAC corresponds to 62.5, 31.25, 15.625, or 7.8125 MS/s baseband
for ``RATIO`` 2, 4, 8, or 16 respectively.

Parameters
**********

The parameter *WIDTH* is provided. This scales the input and output
widths for the in phase and quadrature components. The filtering inside
the module is carried out with widths that match the FPGA technology
(i.e., 52-bit accumulators, etc). This width value controls the widths
of the interface modules.

The parameter *RATIO* selects the interpolation cascade depth:

- ``RATIO=2``: ``duc_hb_interp_fir_h0``
- ``RATIO=4``: ``duc_hb_interp_fir_h0``, ``duc_hb_interp_fir_h0``
- ``RATIO=8``: ``duc_hb_interp_fir_h0``, ``duc_hb_interp_fir_h0``, ``duc_hb_interp_fir_h1``
- ``RATIO=16``: ``duc_hb_interp_fir_h0``, ``duc_hb_interp_fir_h0``, ``duc_hb_interp_fir_h1``, ``duc_hb_interp_fir_h2``

Input Stream Signals
********************

i_inph_data

    The next in-phase sample to be read when the ready signal goes high.

i_quad_data

    The next quadrature sample to be read when the ready signal goes high.

o_ready

    A strobe signal that indicates when a new sample is read from the in-phase
    and quadrature input channels respectively. This signal is sent from the
    upconverter to the upstream module that provides the samples. In a typical
    application, it is pulsed for one clock cycle that is ``RATIO`` times slower
    than the output frequency.

The input follows the standard valid/ready handshake but all valid signals
are taken to be an implied '1' (so data should always be ready at the input
ports).

Output Stream Signals
*********************

o_inph_data

    The next in-phase sample of the filtered and upconverted stream. This
    output sample will be read the next time the downstream ready signal goes
    high.

o_quad_data

    The next quadrature sample of the filtered and upconverted stream. This
    output sample will be read the next time the downstream ready signal goes
    high.

i_ready

    A strobe signal that indicates when a new sample is read from the in-phase
    and quadrature channel outputs. Data must always be available.

The output follows the standard valid/ready handshake but all valid signals
are taken to be an implied '1' (so data should always be ready at the input
ports).

Control Signals
***************

i_clock

    The primary clock for the synchronous logic in the module.

i_reset

    Synchronous reset to clear the module state.

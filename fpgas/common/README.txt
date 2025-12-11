The directory is intended to provide a central location for modules and IP that are used in multiple Higgs SDR FPGAs.
This is to avoid the need to have multiple copies of the same module or IP in every FPGA directory that uses that module
or IP and to make it easier to propagate any bug fixes or updates to the common modules or IP.

## FPGA target macros

Use exactly one of these global synthesis macros to select vendor-specific HDL:

* `HIGGS_FPGA_XILINX` for AMD/Xilinx devices.
* `HIGGS_FPGA_LATTICE` for Lattice Semiconductor devices.
* `HIGGS_FPGA_INTEL` for Intel FPGA devices (formerly Altera).

Do not use vendor names such as `XILINX`, `LATTICE`, or `ALTERA` directly as
project-wide defines; those names may collide with tool-provided macros.

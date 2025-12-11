set script_dir [file normalize [file dirname [info script]]]
set source_root [file normalize "$script_dir/../../../../.."]
set output_dir "$script_dir/out"
set part xczu7ev-ffvc1156-2-e

create_project -force cs01_vivado $output_dir/cs01_vivado -part $part
set_property target_language Verilog [current_project]

proc prj_src {command path} {
    if {$command ne "add"} {
        error "Unsupported prj_src command: $command"
    }

    if {[string match "*/common/ip/lattice/sys_pll/sys_pll.v" $path] ||
        [string match "*/common/modules/core_top.sv" $path] ||
        [string match "*/common/modules/core_reset.sv" $path]} {
        return
    }

    add_files -norecurse $path
}

proc prj_impl {args} {}
proc prj_strgy {args} {}

set original_dir [pwd]
cd "$source_root/fpgas/cs/cs01/build"
source ./sources.tcl
cd $original_dir

add_files -norecurse $script_dir/hdl/sys_pll.sv
add_files -norecurse $script_dir/hdl/pmi_fifo_dc.sv
add_files -norecurse $script_dir/hdl/core_top.sv

set_property include_dirs [list \
    "$source_root/fpgas/packages" \
    "$source_root/libs/ip-library/lattice_support/gbit_mac/packages"] \
    [current_fileset]
set_property verilog_define {HIGGS_FPGA_XILINX} [current_fileset]
set_property top cs01_top [current_fileset]
update_compile_order -fileset sources_1

read_xdc $script_dir/constraints/cs01_timing.xdc
synth_design -top cs01_top -part $part
report_utilization -file $output_dir/cs01_synth_utilization.rpt
write_checkpoint -force $output_dir/cs01_synth.dcp

opt_design
place_design
phys_opt_design
route_design

write_checkpoint -force $output_dir/cs01_routed.dcp
report_clocks -file $output_dir/cs01_clocks.rpt
report_clock_interaction -file $output_dir/cs01_clock_interaction.rpt
report_utilization -file $output_dir/cs01_routed_utilization.rpt
report_timing_summary -delay_type max -max_paths 20 -file $output_dir/cs01_timing_summary.rpt

# Out-of-context synthesis + place & route of fir_filter on the CS12 part.
#   vivado -mode batch -source fir_filter_ooc.tcl [-tclargs NTAPS]
set script_dir [file normalize [file dirname [info script]]]
set source_root [file normalize "$script_dir/../../../../.."]
set part xczu7ev-ffvc1156-2-e
set ntaps [expr {[llength $argv] > 0 ? [lindex $argv 0] : 16}]
set output_dir "$script_dir/out/ntaps$ntaps"
file mkdir $output_dir

read_verilog $source_root/libs/q-engine/hdl/fir/fir_filter.v
read_xdc -mode out_of_context $script_dir/fir_filter_ooc.xdc
synth_design -top fir_filter -part $part -mode out_of_context \
    -generic NTAPS=$ntaps
report_utilization -file $output_dir/synth_utilization.rpt
write_checkpoint -force $output_dir/synth.dcp

opt_design
place_design
phys_opt_design
route_design
write_checkpoint -force $output_dir/routed.dcp
report_utilization -file $output_dir/routed_utilization.rpt
report_utilization -hierarchical -file $output_dir/routed_utilization_hier.rpt
report_timing_summary -delay_type max -max_paths 20 \
    -file $output_dir/routed_timing_summary.rpt
report_methodology -file $output_dir/methodology.rpt

set wns [get_property SLACK [get_timing_paths -delay_type max]]
set whs [get_property SLACK [get_timing_paths -delay_type min]]
puts "FIR_OOC NTAPS=$ntaps WNS=$wns WHS=$whs"

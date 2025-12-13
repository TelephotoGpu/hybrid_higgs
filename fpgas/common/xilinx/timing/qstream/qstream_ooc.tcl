# Out-of-context synthesis + place & route of a phase-2 stream module on the
# CS12 part at 125 MHz.
#   vivado -mode batch -source qstream_ooc.tcl -tclargs <top> [PARAM=value ...]
#   <top>: golay_corr | stream_router | stream_merge
set script_dir [file normalize [file dirname [info script]]]
set source_root [file normalize "$script_dir/../../../../.."]
set part xczu7ev-ffvc1156-2-e
if {[llength $argv] < 1} {
    error "usage: -tclargs <golay_corr|stream_router|stream_merge> \[PARAM=value ...\]"
}
set top [lindex $argv 0]
set generics [lrange $argv 1 end]
array set src {
    golay_corr    libs/q-engine/hdl/xcorr/golay_corr.v
    stream_router libs/q-engine/hdl/stream/stream_router.v
    stream_merge  libs/q-engine/hdl/stream/stream_merge.v
}
if {![info exists src($top)]} {
    error "unknown top $top"
}
set tag $top
foreach g $generics {
    append tag "_" [string map {= ""} $g]
}
set output_dir "$script_dir/out/$tag"
file mkdir $output_dir

read_verilog $source_root/$src($top)
read_xdc -mode out_of_context $script_dir/qstream_ooc.xdc
set synth_args [list -top $top -part $part -mode out_of_context]
foreach g $generics {
    lappend synth_args -generic $g
}
synth_design {*}$synth_args
report_utilization -file $output_dir/synth_utilization.rpt
write_checkpoint -force $output_dir/synth.dcp

opt_design
place_design
phys_opt_design
route_design
write_checkpoint -force $output_dir/routed.dcp
report_utilization -file $output_dir/routed_utilization.rpt
report_timing_summary -delay_type max -max_paths 20 \
    -file $output_dir/routed_timing_summary.rpt
report_methodology -file $output_dir/methodology.rpt

set wns [get_property SLACK [get_timing_paths -delay_type max]]
set whs [get_property SLACK [get_timing_paths -delay_type min]]
puts "QSTREAM_OOC $tag WNS=$wns WHS=$whs"

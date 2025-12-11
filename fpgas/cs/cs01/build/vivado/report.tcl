set script_dir [file normalize [file dirname [info script]]]
set output_dir "$script_dir/out"

open_checkpoint $output_dir/cs01_routed.dcp
report_clocks -file $output_dir/cs01_clocks.rpt
report_clock_interaction -file $output_dir/cs01_clock_interaction.rpt
report_utilization -file $output_dir/cs01_routed_utilization.rpt
report_timing_summary -delay_type max -max_paths 20 -file $output_dir/cs01_timing_summary.rpt

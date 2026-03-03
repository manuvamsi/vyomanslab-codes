# SDC Timing Constraints for Traffic Light Controller
create_clock [get_ports clock] -name core_clock -period 10.0

# Input delays
set_input_delay 2.0 -clock core_clock [get_ports clear]
set_input_delay 2.0 -clock core_clock [get_ports X]

# Output delays
set_output_delay 2.0 -clock core_clock [get_ports {hwy[0]}]
set_output_delay 2.0 -clock core_clock [get_ports {hwy[1]}]
set_output_delay 2.0 -clock core_clock [get_ports {cntry[0]}]
set_output_delay 2.0 -clock core_clock [get_ports {cntry[1]}]

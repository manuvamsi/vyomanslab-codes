create_clock [get_ports clk] -name core_clock -period 10.0
set_input_delay 2.0 -clock core_clock [get_ports rst]
set_output_delay 2.0 -clock core_clock [get_ports red]
set_output_delay 2.0 -clock core_clock [get_ports yellow]
set_output_delay 2.0 -clock core_clock [get_ports green]

# Create primary clock (100 MHz)
create_clock -name clk -period 10.0 [get_ports clk]

# Set clock uncertainty (jitter + skew margin)
set_clock_uncertainty 0.2 [get_clocks clk]

# Input delays (relative to clock)
set_input_delay 2.0 -clock clk [get_ports {reset_n up_down}]

# Output delays (relative to clock)
set_output_delay 2.0 -clock clk [get_ports count]

# Input transition time
set_input_transition 0.1 [get_ports {clk reset_n up_down}]

# Output load (in pF, tool dependent)
set_load 0.1 [get_ports count]

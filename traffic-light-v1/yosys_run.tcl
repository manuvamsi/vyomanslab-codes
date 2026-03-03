# Yosys synthesis script for Traffic Light Controller (Nangate45)
read_verilog traffic_light.v

# Generic synthesis
synth -top traffic_light

# Technology Mapping to Nangate45
dfflibmap -liberty Nangate45_typ.lib
abc -liberty Nangate45_typ.lib

# Clean up
opt_clean -purge

# Reports
tee -o area_report.txt stat -liberty Nangate45_typ.lib
tee -o timing_report.txt ltp

# Output netlist
write_verilog traffic_synth.v

# Visualize
show -format dot -prefix traffic_synth

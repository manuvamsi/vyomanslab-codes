# Yosys Synthesis Script for Traffic Light Controller (Nangate45)

# Read design
read_verilog traffic_light_v2.v

# Generic synthesis
synth -top sig_control

# Technology mapping to Nangate45
dfflibmap -liberty /home/vyomans-shuttle/PD/learning-2/Nangate45_typ.lib
abc -liberty /home/vyomans-shuttle/PD/learning-2/Nangate45_typ.lib

# Clean up
opt_clean -purge

# Reports
tee -o area_report.txt stat -liberty /home/vyomans-shuttle/PD/learning-2/Nangate45_typ.lib
tee -o timing_report.txt ltp

# Output synthesized netlist
write_verilog traffic_light_v2_synth.v

# Visualize (generates DOT file)
show -format dot -prefix traffic_light_v2_synth

# OpenROAD Script for Mycounter

# 1. Setup
set design "Mycounter"
set top_module "Mycounter"
set netlist "counter_4bit_synth.v"
set sdc_file "counter_4bit.sdc"

# PDK Paths
set pdk_dir "/home/vyomans-shuttle/PD/OpenROAD/test/Nangate45"
set lib_file "$pdk_dir/Nangate45_typ.lib"
set tech_lef "$pdk_dir/Nangate45_tech.lef"
set std_cell_lef "$pdk_dir/Nangate45_stdcell.lef"
set tracks_file "$pdk_dir/Nangate45.tracks"

# 2. Read Design
read_liberty $lib_file
read_lef $tech_lef
read_lef $std_cell_lef
read_verilog $netlist
link_design $top_module
read_sdc $sdc_file

# 3. Floorplan
# Small core area for this small design
initialize_floorplan \
    -die_area {0 0 11 11} \
    -core_area {2 2 9.7 9.7} \
    -site FreePDK45_38x28_10R_NP_162NW_34O

source $tracks_file

# 4. Place Pins
place_pins -hor_layers metal3 -ver_layers metal2

# 5. Tapcells and PDN
tapcell -distance 120 -tapcell_master TAPCELL_X1 -endcap_master TAPCELL_X1
# PDN is skipped for simplicity in this very small block, or we can add it if needed.
# For learning, basic placement/routing is often enough.

# 6. Global Placement
global_placement -density 0.5

# 7. Detailed Placement
detailed_placement

# 8. CTS
repair_clock_nets
clock_tree_synthesis -root_buf BUF_X4 -buf_list BUF_X4
detailed_placement

# 9. Routing
global_route
detailed_route

# 10. Final Reports
report_checks -path_delay min_max
report_design_area
report_power

# Write outputs
write_def counter_4bit.def
write_gds counter_4bit.gds

# OpenROAD Physical Design Script for Traffic Light Controller
# Full PDA flow: Floorplan -> Placement -> CTS -> Routing

# 1. Setup paths and variables
set design "sig_control"
set top_module "sig_control"
set netlist "traffic_light_v2_synth.v"
set sdc_file "traffic_light_v2.sdc"

# Tech files (Nangate45)
set test_dir "/home/vyomans-shuttle/PD/OpenROAD/test"
set lib_file "$test_dir/Nangate45/Nangate45_typ.lib"
set tech_lef "$test_dir/Nangate45/Nangate45_tech.lef"
set std_cell_lef "$test_dir/Nangate45/Nangate45_stdcell.lef"

# 2. Read design
read_liberty $lib_file
read_lef $tech_lef
read_lef $std_cell_lef
read_verilog $netlist
link_design $top_module
read_sdc $sdc_file

# 3. Floorplan
initialize_floorplan -die_area {0 0 16.5 16.5} \
                     -core_area {3 3 13.5 13.5} \
                     -site FreePDK45_38x28_10R_NP_162NW_34O

# Source tracks
source "$test_dir/Nangate45/Nangate45.tracks"

# 4. Tapcells
tapcell -distance 120 \
        -tapcell_master TAPCELL_X1 \
        -endcap_master TAPCELL_X1

# 5. PDN (Power Distribution Network)
#source "$test_dir/Nangate45/Nangate45.pdn.tcl"
#pdngen

# 6. Placement
set_wire_rc -signal -layer metal3
set_wire_rc -clock -layer metal6

place_pins -hor_layers metal3 -ver_layers metal2
global_placement -density 0.6
detailed_placement

# 7. CTS (Clock Tree Synthesis)
repair_clock_nets
clock_tree_synthesis -root_buf BUF_X4 -buf_list BUF_X4
detailed_placement

# 8. Routing
pin_access
global_route
detailed_route

# 9. Final Reports
report_checks -path_delay min_max
report_design_area
report_power

# 10. Write final DEF
write_def traffic_light_v2_final.def

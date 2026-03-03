# Yosys synthesis script for Mycounter using Nangate45

# 1. Read source
read_verilog counter_4bit.v

# 2. Synthesis
synth -top Mycounter

# 3. Map to Nangate45 library
dfflibmap -liberty /home/vyomans-shuttle/PD/OpenROAD/test/Nangate45/Nangate45_typ.lib
abc -liberty /home/vyomans-shuttle/PD/OpenROAD/test/Nangate45/Nangate45_typ.lib

# 4. Clean and Write
clean
write_verilog counter_4bit_synth.v

# 5. Reports
stat -liberty /home/vyomans-shuttle/PD/OpenROAD/test/Nangate45/Nangate45_typ.lib

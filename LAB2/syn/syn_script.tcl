#source initialization script
#source /software/scripts/init_synopsys_64.18

#prepare Setup for Design Compiler
#define_design_lib WORK -path ./work

#set search_path [list ./software/synopsys/syn_current_64.18/libraries/syn/software/dk/nangate45/synopsys]

#set link_library [list "*" "NangateOpenCellLibrary_typical_ecsm.db" "dw_foundation.sldb"]

#set target_library [list "NangateOpenCellLibrary_typical_ecsm.db"]

#set synthetic_library [list "dw_foundation.sldb"]

#mkdir work

#dc_shell-xg-t

#Reading VHDL source files
analyze -f vhdl -lib work ../src/fpuvhdl/common/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/common/fpround_fpround.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/common/packfp_packfp.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/common/unpackfp_unpackfp.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/common/reg.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/multiplier/fpmul_stage2_struct.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd
analyze -f vhdl -lib work ../src/fpuvhdl/multiplier/fpmul_pipeline.vhd

set power_preserve_rtl_hier_names true

elaborate FPmul -arch pipeline -lib work > ./elaborate.txt

#Applying constraints

#clock
#Max frequency:
#Normal ---->  clk = 1.42 ns
#CSA    ---->  clk = 3.89 ns
#PPARCH ---->  clk = 1.40 ns
create_clock -name MY_CLK -period 1.40 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]

#Delay input signal w.r.t. clock
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]

#Insert output loads
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

######################
ungroup -all -flatten
set_implementation DW02_mult/pparch [find cell *mult*]
compile

report_timing > report_timing_file_PPARCH.txt

report_area > report_area_file_PPARCH.txt
report_resources > report_resources_file_PPARCH.txt
#Save data required
#ungroup -all -flatten
#change_names -hierarchy -rules verilog
#write_sdf ../netlist/FPmult_pipeline.sdf
#write -f verilog -hierarchy -output ../netlist/FPmult_pipeline.v
#write_sdc ../netlist/FPmult_pipeline.sdc

#quit

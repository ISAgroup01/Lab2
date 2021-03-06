#Applying constraints

#clock
#Max frequency:

#create_clock -name MY_CLK -period 1.72 clk
create_clock -name MY_CLK -period 1.74 clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clocks MY_CLK]

#Delay input signal w.r.t. clock
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]

#Insert output loads
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]

ungroup -all -flatten

compile_ultra
report_timing > report_timing_MBE.txt

report_area > report_area_MBE.txt

#Save data required
ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../../netlist/FPmult_MBE.sdf
write -f verilog -hierarchy -output ../../netlist/FPmult_MBE.v
write_sdc ../../netlist/FPmult_MBE.sdc

quit

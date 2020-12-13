#source initialization script
source /software/scripts/init_synopsys_64.18
#prepare Setup for Design Compiler
define_design_lib WORK -path ./work

set search_path [list ./software/synopsys/syn_current_64.18/libraries/syn/software/dk/nangate45/synopsys]

set link_library [list "*" "NangateOpenCellLibrary_typical_ecsm.db" "dw_foundation.sldb"]

set target_library [list "NangateOpenCellLibrary_typical_ecsm.db"]

set synthetic_library [list "dw_foundation.sldb"]

#mkdir work

dc_shell-xg-t

################################################################################
# INITIALIZATION
################################################################################
transcript quietly
rm -rf ./modelsim_lib

set uvm_dir         ../UVM_1.2/src/             ;   # UVM libraries' directory
set top_level_sim   top_tb_sim_lib              ;   # top_level simulation library.

if {[file exist modelsim_lib] } { file delete  -force modelsim_lib} 
file mkdir modelsim_lib

################################################################################
# COMPILE RTL DESIGN FILES
###############################################################################

# for all libraries do the following: 
# create library, map to library, compile sources into library 

################################################################################
# COMPILE VERIFICATION FILES
###############################################################################

# for all libraries do the following: 
# create library, map to library, compile sources into library 
set lib_name ${top_level_sim}
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name [file join $uvm_dir uvm_pkg.sv     ]   +incdir+$uvm_dir +define+UVM_NO_DPI

# ################################################################################
# SIMULATE
# ################################################################################

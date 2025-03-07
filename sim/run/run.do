################################################################################
# INITIALIZATION
################################################################################
transcript quietly
rm -rf ./modelsim_lib

set rtl_dir         ../../src/                  ;   # RTL design files
set uvm_dir         ../UVM_1.2/src/             ;   # UVM libraries' directory
set top_level_sim   top_tb_sim_lib              ;   # top_level simulation library.
set agent_dir       ../agent/                   ;   # agent directory
set top_level       top                         ;   # testbench top name
set test_bench      ${top_level}_tb             ;   # testbench name 
set top_dir         ../$test_bench              ;   # Top level testbench directory

if {[file exist modelsim_lib] } { file delete  -force modelsim_lib} 
file mkdir modelsim_lib

################################################################################
# COMPILE RTL DESIGN FILES
###############################################################################

# for all libraries do the following: 
# create library, map to library, compile sources into library 
# tmpv stands for temporary variable 
set lib_folder riscv ;
set lib_name ${lib_folder}_lib
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
vlog -work $lib_name [file join $rtl_dir riscv_pkg.sv   ]
vlog -work $lib_name [file join $rtl_dir memory.sv      ]
vlog -work $lib_name [file join $rtl_dir decoder.sv     ]
vlog -work $lib_name [file join $rtl_dir control.sv     ]
vlog -work $lib_name [file join $rtl_dir alu.sv         ]
vlog -work $lib_name [file join $rtl_dir top.sv         ]

################################################################################
# COMPILE VERIFICATION FILES
###############################################################################

# for all libraries do the following: 
# create library, map to library, compile sources into library 
set lib_name ${top_level_sim}
vlib modelsim_lib/$lib_name
vmap $lib_name modelsim_lib/$lib_name
# vlog -work $lib_name [file join $uvm_dir uvm_pkg.sv ] +incdir+$uvm_dir +define+UVM_NO_DPI
vlog -work $lib_name [file join $top_dir top_tb.sv  ] +incdir+$agent_dir

# ################################################################################
# SIMULATE
# ################################################################################

vsim -voptargs=+acc                 \
    -L riscv_lib                    \
    -lib ${top_level_sim}           \
    ${test_bench}                   \
    -t 1ns 
set NoQuitOnFinish 1
add wave -divider control_inst
add wave -radix hexadecimal -position insertpoint sim:/top_tb/top_inst/control_inst/*
run -all
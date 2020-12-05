# ------------------------------------------------------------------------------
# Top Level Simulation Script to source msim_setup.tcl
# ------------------------------------------------------------------------------
set QSYS_SIMDIR obj/default/runtime/sim
source msim_setup.tcl
# Copy generated memory initialization hex and dat file(s) to current directory
file copy -force /tmp/NiosGpioSoPC_ee705_2020_demo1_bscverilog_demo_sources_only/software/my_software/mem_init/hdl_sim/My_Processing_System_onchip_memory2_0.dat ./ 
file copy -force /tmp/NiosGpioSoPC_ee705_2020_demo1_bscverilog_demo_sources_only/software/my_software/mem_init/My_Processing_System_onchip_memory2_0.hex ./ 

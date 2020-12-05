#vcom ../../../../../../../coproc_at_gpio.vhd
vlog ../../../../../../../mkMult2_asynch_reset_n.v
vcom ../../../../../../../nios_sopc_ee705_2020.vhd

set TOP_LEVEL_NAME "nios_sopc_ee705_2020"
ld

force -freeze sim:/nios_sopc_ee705_2020/clk 1 0, 0 {10 ns} -r 20ns

force -freeze sim:/nios_sopc_ee705_2020/reset_n 1 0, 0 20ns , 1 45ns

run 10ms

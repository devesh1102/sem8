vcom ../../../../../../../Counter_tester_using_FSM.vhd
vcom ../../../../../../../Counter_design.vhd

set TOP_LEVEL_NAME "Counter_tester_using_FSM"
ld

add wave -radix hex -position insertpoint  \
sim:/counter_tester_using_fsm/clk \
sim:/counter_tester_using_fsm/reset_n \
sim:/counter_tester_using_fsm/my_input_0 \
sim:/counter_tester_using_fsm/my_input_1 \
sim:/counter_tester_using_fsm/my_output \
sim:/counter_tester_using_fsm/user_extra_inputs_export \
sim:/counter_tester_using_fsm/user_extra_outputs_export \
sim:/counter_tester_using_fsm/user_input_0_export \
sim:/counter_tester_using_fsm/user_input_1_export \
sim:/counter_tester_using_fsm/user_output_export \
sim:/counter_tester_using_fsm/coproc_clk \
sim:/counter_tester_using_fsm/inputs_rdy \
sim:/counter_tester_using_fsm/result_consumed \
sim:/counter_tester_using_fsm/latch_inputs \
sim:/counter_tester_using_fsm/inputs_consumed \
sim:/counter_tester_using_fsm/result_rdy \
sim:/counter_tester_using_fsm/compute_finished \
sim:/counter_tester_using_fsm/state
add wave -radix hex -position insertpoint  \
sim:/counter_tester_using_fsm/MY_PS_inst/clk_clk \
sim:/counter_tester_using_fsm/MY_PS_inst/reset_reset_n \
sim:/counter_tester_using_fsm/MY_PS_inst/user_extra_inputs_export \
sim:/counter_tester_using_fsm/MY_PS_inst/user_extra_outputs_export \
sim:/counter_tester_using_fsm/MY_PS_inst/user_input_0_export \
sim:/counter_tester_using_fsm/MY_PS_inst/user_input_1_export \
sim:/counter_tester_using_fsm/MY_PS_inst/user_output_export \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_waitrequest \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_debugaccess \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_address \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_byteenable \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_read \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_write \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_instruction_master_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_instruction_master_waitrequest \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_instruction_master_address \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_instruction_master_read \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_byteenable \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_clken \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_outputs_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_outputs_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_output_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_output_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/irq_mapper_receiver0_irq \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_irq_irq \
sim:/counter_tester_using_fsm/MY_PS_inst/rst_controller_reset_out_reset \
sim:/counter_tester_using_fsm/MY_PS_inst/rst_controller_reset_out_reset_req

add wave -radix hex -position insertpoint  \
sim:/counter_tester_using_fsm/MY_PS_inst/clk_clk \
sim:/counter_tester_using_fsm/MY_PS_inst/reset_reset_n \
sim:/counter_tester_using_fsm/MY_PS_inst/user_extra_inputs_export \
sim:/counter_tester_using_fsm/MY_PS_inst/user_extra_outputs_export \
sim:/counter_tester_using_fsm/MY_PS_inst/user_input_0_export \
sim:/counter_tester_using_fsm/MY_PS_inst/user_input_1_export \
sim:/counter_tester_using_fsm/MY_PS_inst/user_output_export \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_waitrequest \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_debugaccess \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_address \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_byteenable \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_read \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_write \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_data_master_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_instruction_master_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_instruction_master_waitrequest \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_instruction_master_address \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_instruction_master_read \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_waitrequest \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_read \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_waitrequest \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_debugaccess \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_read \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_byteenable \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_nios2_gen2_0_debug_mem_slave_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_byteenable \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_onchip_memory2_0_s1_clken \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_inputs_s1_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_outputs_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_extra_outputs_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_1_s1_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_chipselect \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_write \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_input_0_s1_writedata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_output_s1_readdata \
sim:/counter_tester_using_fsm/MY_PS_inst/mm_interconnect_0_user_output_s1_address \
sim:/counter_tester_using_fsm/MY_PS_inst/irq_mapper_receiver0_irq \
sim:/counter_tester_using_fsm/MY_PS_inst/nios2_gen2_0_irq_irq \
sim:/counter_tester_using_fsm/MY_PS_inst/rst_controller_reset_out_reset \
sim:/counter_tester_using_fsm/MY_PS_inst/rst_controller_reset_out_reset_req

add wave -radix hex -position insertpoint  \
sim:/counter_tester_using_fsm/Counter_design_inst/counter_clk \
sim:/counter_tester_using_fsm/Counter_design_inst/reset_n \
sim:/counter_tester_using_fsm/Counter_design_inst/start \
sim:/counter_tester_using_fsm/Counter_design_inst/count1 \
sim:/counter_tester_using_fsm/Counter_design_inst/count2 \
sim:/counter_tester_using_fsm/Counter_design_inst/count_out \
sim:/counter_tester_using_fsm/Counter_design_inst/finished \
sim:/counter_tester_using_fsm/Counter_design_inst/total_count \
sim:/counter_tester_using_fsm/Counter_design_inst/state \
sim:/counter_tester_using_fsm/Counter_design_inst/one_value

force -freeze sim:/counter_tester_using_fsm/clk 1 0, 0 {5000 ps} -r 10ns
force -freeze sim:/counter_tester_using_fsm/reset_n 0 0

run 20ns
force -freeze sim:/counter_tester_using_fsm/reset_n 1 0

run 20ms
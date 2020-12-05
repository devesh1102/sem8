library std;
use std.standard.all;
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity Counter_tester_using_FSM is
    port(clk, reset_n : in std_logic);
end entity;

architecture behave of Counter_tester_using_FSM is
	component My_Processing_System is
		port (
			clk_clk                   : in  std_logic                     := '0';             --                clk.clk
			reset_reset_n             : in  std_logic                     := '0';             --              reset.reset_n
			user_extra_inputs_export  : out std_logic_vector(3 downto 0);                     --  user_extra_inputs.export
			user_extra_outputs_export : in  std_logic_vector(3 downto 0)  := (others => '0'); -- user_extra_outputs.export
			user_input_0_export       : out std_logic_vector(31 downto 0);                    --       user_input_0.export
			user_input_1_export       : out std_logic_vector(31 downto 0);                    --       user_input_1.export
			user_output_export        : in  std_logic_vector(31 downto 0) := (others => '0')  --        user_output.export
		);
	end component My_Processing_System;
	
	component Counter_design is
		port( 
			 counter_clk, reset_n, start : in std_logic;
			 count1, count2 : in std_logic_vector(31 downto 0);
			 count_out : out std_logic_vector(31 downto 0);
			 finished : out std_logic := '0'
			 );
	end component;
	
	signal my_input_0, my_input_1, my_output : std_logic_vector(31 downto 0);
	signal user_extra_inputs_export, user_extra_outputs_export : std_logic_vector(3 downto 0);
	signal user_input_0_export, user_input_1_export, user_output_export : std_logic_vector(31 downto 0);
	signal coproc_clk, inputs_rdy, result_consumed, latch_inputs, inputs_consumed, result_rdy, compute_finished : std_logic;
	
	type t_state is (stIdle, stCompute, stDone);
	signal state : t_state := stIdle;

begin
	
	Counter_design_inst : Counter_design port map (coproc_clk, reset_n, latch_inputs, my_input_0, my_input_1, my_output, compute_finished);
	
	MY_PS_inst : My_Processing_System port map (clk, reset_n, user_extra_inputs_export, user_extra_outputs_export, user_input_0_export, user_input_1_export, user_output_export);

	my_input_0 <= user_input_0_export;
	my_input_1 <= user_input_1_export;
	
	user_output_export <= my_output;
	
	coproc_clk <= user_extra_inputs_export(0) ;
	inputs_rdy <= user_extra_inputs_export(1) ;
	result_consumed <= user_extra_inputs_export(2) ;
	
	user_extra_outputs_export(0) <= latch_inputs ;
	user_extra_outputs_export(1) <= inputs_consumed ;
	user_extra_outputs_export(2) <= result_rdy ;
	user_extra_outputs_export(3) <= '0' ;
	

	latch_inputs <= '1' when (state = stIdle and  inputs_rdy = '1') else 
					'0';
					
	inputs_consumed <= '1' when (state = stCompute) else 
					   '0';
					   
	result_rdy <= '1' when (state = stDone) else 
				  '0';
	
	next_state_logic: process (coproc_clk, reset_n)
	begin
	  if ( reset_n = '0' ) then
	    state <= stIdle ;
	  elsif ( coproc_clk'event and coproc_clk = '1' )  then
	    case ( state ) is
		  when stIdle =>
		    if ( inputs_rdy = '1' ) then
              state <= stCompute ;
			end if ;
		  when stCompute =>
			if ( compute_finished = '1' ) then
              state <= stDone ;			
			end if ;
		  when stDone =>
		    if ( result_consumed = '1' ) then
			  state <= stIdle ;
			end if ;
		end case ;
	  end if ;
	end process ;
	
end behave;
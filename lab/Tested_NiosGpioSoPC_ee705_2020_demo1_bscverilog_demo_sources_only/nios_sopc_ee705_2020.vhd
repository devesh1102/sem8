library std;
use std.standard.all;
use std.textio.all ;


library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_textio.all ;


entity nios_sopc_ee705_2020 is
    port(clk, reset_n : in std_logic);
end entity;

architecture behave of nios_sopc_ee705_2020 is
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
	
        component mkMult2 port ( CLK , RST_N : in std_logic ;
          start_m1 , start_m2 : in std_logic_vector(15 downto 0) ;
          EN_start : in std_logic ;
          RDY_start : out std_logic ;
          EN_result : in std_logic ;
          result : out std_logic_vector(31 downto 0) ;
          RDY_result : out std_logic ) ;
        end component ;

	signal user_extra_inputs_export, user_extra_outputs_export : std_logic_vector(3 downto 0) := ( others => '0' ) ;
	signal user_input_0_export, user_input_1_export, 
            user_output_export : std_logic_vector(31 downto 0) := (others=>'0') ;

        signal coproc_clk : std_logic := '0' ;
        signal coproc_result : std_logic_vector ( 31 downto 0 )  := ( others => '0' ) ;
        signal EN_start , RDY_start , RDY_result , EN_result : std_logic := '0' ;


begin
	user_output_export <= coproc_result ;

	user_extra_outputs_export(0) <= RDY_result ; 
	user_extra_outputs_export(1) <= RDY_start ; 

        coproc_clk <= user_extra_inputs_export(0) ;
        EN_start <=  user_extra_inputs_export(1) ;
	EN_result <= user_extra_inputs_export(2) ; 

        coproc_inst0 : mkMult2 port map (coproc_clk, reset_n, user_input_0_export(15 downto 0), 
                               user_input_1_export( 15 downto 0 ), EN_start,
	                       RDY_start, EN_result, coproc_result, RDY_result);

	MY_PS_inst : My_Processing_System port map (clk, reset_n, user_extra_inputs_export, user_extra_outputs_export, user_input_0_export, user_input_1_export, user_output_export);
	
        process  ( coproc_clk )
          variable myline : line ;
        begin 
          write( myline , user_input_0_export );
          writeline( output , myline ) ;
          write( myline , user_input_1_export );
          writeline( output , myline ) ;
          write( myline , user_extra_inputs_export );
          writeline( output , myline ) ;
          write( myline , coproc_result );
          writeline( output , myline ) ;
          write( myline , user_extra_outputs_export );
          writeline( output , myline ) ;
          write( myline , string'(" EN_start ") ) ;
          write( myline , EN_start );
          write( myline , string'(" RDY_start ") ) ;
          write( myline , RDY_start );
          write( myline , string'(" RDY_result ") ) ;
          write( myline , RDY_result );
          write( myline , string'(" EN_result ") ) ;
          write( myline , EN_result );
          write( myline , string'(" coproc_clk ") ) ;
          write( myline , coproc_clk );
          writeline( output , myline ) ;
        end process ;
        
end behave;


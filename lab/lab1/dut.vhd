-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  two-bit adder.
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
   port(input_vector: in std_logic_vector(3 downto 0); ---Note: for alu testing (17 downto 0) for others (15 downto 0)
       	clk: in std_logic;
			output_vector: out std_logic_vector(7 downto 0));
end entity;

architecture DutWrap of DUT is
component multiplier
port ( 
	a,b: in std_logic_vector(3 DOWNTO 0);
clk: in std_logic;
	result : out std_logic_vector(7 DOWNTO 0)
	
	);
end component;
	--- Add component of eightbitadder 
	--- Add component of eightbitsubtractor 
	--- Add component of leftshift
	--- Add component of rightshift
	
signal dum: STD_LOGIC_VECTOR(31 DOWNTO 0) ;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
--a: eightbitadder port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0) , z=> output_vector);
--b: leftshift	        port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0) , z=> output_vector); 
--c: rightshift          port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0) , z=> output_vector); 
--d: eightbitsubtractor  port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0) , z=> output_vector); --- Note: z = x- y
dut: multiplier port map( a => input_vector(3 downto 0), b => input_vector(3 downto 0),clk=>clk , result=> output_vector);
end DutWrap;


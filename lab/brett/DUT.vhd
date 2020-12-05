-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  two-bit adder.
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
   port(input_vector: in std_logic_vector(64 downto 0); ---Note: for alu testing (17 downto 0) for others (15 downto 0)
       	output_vector: out std_logic_vector(32 downto 0));
end entity;

architecture DutWrap of DUT is
component adders
port ( 
	in_a,in_b: in std_logic_vector(31 DOWNTO 0);
	carry_in:  in std_logic;
	carry_out: out STD_LOGIC_VECTOR(31 downto 0);
	output : out std_logic_vector(32 DOWNTO 0)--output may have a bit extra
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
dut: adders port map( in_a => input_vector(64 downto 33), in_b => input_vector(32 downto 1) , carry_in=> input_vector(0) , output=> output_vector,carry_out=> dum);
end DutWrap;


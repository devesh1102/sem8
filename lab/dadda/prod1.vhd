library ieee;
use ieee.std_logic_1164.all;

entity bitprod is
port ( 
	a: in std_logic;
	b: in std_logic;
	output: out std_logic
	);
end entity;
architecture why of bitprod is
SIGNAL dum : STD_LOGIC;
begin
	dum<=  not(a and b) after 150 ps;
	output<= not(dum) after 100 ps;
end why;
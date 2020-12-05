library ieee;
use ieee.std_logic_1164.all;

entity sum is
port ( 
	a,b,cin: in std_logic;
	o:  out std_logic
	);
end entity;
architecture why of sum is
SIGNAL dum : STD_LOGIC ;
begin
	dum<=  a xor b after 200 ps;
	o <= cin xor dum after 200 ps;
end why;
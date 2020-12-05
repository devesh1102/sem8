library ieee;
use ieee.std_logic_1164.all;




entity next_g is
port ( 
	gin0,gin1,pin1: in std_logic;
	gout:  out std_logic
	);
end entity;
architecture why of next_g is
SIGNAL dum : STD_LOGIC ;
begin
	dum<=  not(gin1 or (gin0 and pin1) )after 200 ps;
	gout<= not(dum) after 100 ps;
end why;
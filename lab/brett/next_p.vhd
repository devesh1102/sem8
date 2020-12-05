library ieee;
use ieee.std_logic_1164.all;




entity next_p is
port ( 
	pin1,pin2: in std_logic;
	pout:  out std_logic
	);
end entity;
architecture why of next_p is
SIGNAL dum : STD_LOGIC ;
begin
	dum<=  not(pin1 and pin2) after 150 ps;
	pout<= not(dum) after 100 ps;
end why;
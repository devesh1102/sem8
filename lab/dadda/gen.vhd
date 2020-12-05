library ieee;
use ieee.std_logic_1164.all;




entity gen is
port ( 
	a,b: in std_logic;
	gout: out std_logic
	);
end entity;
architecture why of gen is
SIGNAL dum : STD_LOGIC;
begin
	dum<=not( a and  b) after 150 ps;
	gout<= not ( dum) after 100 ps;
end why;
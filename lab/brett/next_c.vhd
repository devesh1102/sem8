library ieee;
use ieee.std_logic_1164.all;




entity next_c is
port ( 
	gin0,pin0,cin0: in std_logic;
	cout:  out std_logic
	);
end entity;
architecture why of next_c is
SIGNAL dum : STD_LOGIC ;
begin
	dum<=not(gin0 or ( cin0 and pin0) )   after 200 ps;
	cout<= not(dum) after 100 ps;
end why;
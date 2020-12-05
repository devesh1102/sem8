library ieee;
use ieee.std_logic_1164.all;

entity halfadders is
port ( 
	a,b: in std_logic;
	sum,carry: out std_logic
	);
end entity;
architecture why of halfadders is
SIGNAL dum : STD_LOGIC;
begin
	sum<=a xor b  after 200 ps;
	carry<= (a and b) after 250 ps;
end why;
library ieee;
use ieee.std_logic_1164.all;

entity fulladders is
port ( 
	a,b,c: in std_logic;
	sum,carry: out std_logic
	);
end entity;
architecture why of fulladders is
SIGNAL dum : STD_LOGIC;
begin
	sum<=a xor (b xor c) after 400 ps;
	carry<= (a and b) or (a  and c) or (c and b)after 400 ps;
end why;
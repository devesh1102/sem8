library ieee;
use ieee.std_logic_1164.all;




entity pro is
port ( 
	a,b: in std_logic;
	pout:  out std_logic
	);
end entity;
architecture why of pro is

begin
	pout<= a xor  b  after 200 ps;
end why;
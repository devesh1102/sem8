
library ieee;
use ieee.std_logic_1164.all;




entity adder is

port ( 
	a,b,cin: in std_logic;
	o:  out std_logic;
	c: out std_logic
	);

end entity;

architecture why of adder is

begin
c<= (a and b) or  (cin and  ( a xor b));
o<=a xor b xor cin;

		end why;
---------------
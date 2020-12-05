library ieee;
use ieee.std_logic_1164.all;

entity prod is
port ( 
	a: in std_logic_vector(15 downto 0);
	b: in std_logic;
	output: out std_logic_vector(15 downto 0)
	);
end entity;
architecture why of prod is
component bitprod
port ( 
	a: in std_logic;
	b: in std_logic;
	output: out std_logic
	);
end component;
SIGNAL dum : STD_LOGIC;
begin
product_stage: for I in 0 to 15  generate
						G1:	bitprod port map(a(I),b,output(I));
					end generate product_stage;
end why;
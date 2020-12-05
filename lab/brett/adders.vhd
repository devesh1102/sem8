
library ieee;
use ieee.std_logic_1164.all;




entity adders is
port ( 
	in_a,in_b: in std_logic_vector(31 DOWNTO 0);
	carry_in:  in std_logic;
	carry_out: out STD_LOGIC_VECTOR(31 downto 0);
	output : out std_logic_vector(32 DOWNTO 0)--output may have a bit extra

	
	);
end entity;

architecture why of adders is

component gen
port ( 
	a,b: in std_logic;
	gout:  out std_logic
	);

end component;

component pro
port ( 
	a,b: in std_logic;
	pout:  out std_logic
	);
end component;

component next_p
port ( 
	pin1,pin2: in std_logic;
	pout:  out std_logic
	);
end component;

component next_g
port(
	gin0,gin1,pin1: in std_logic;
	gout:  out std_logic
	);
end component;

component next_c
port ( 
	gin0,pin0,cin0: in std_logic;
	cout:  out std_logic
	);
end component;

component sum
port ( 
	a,b,cin: in std_logic;
	o:  out std_logic
	);
end component;


SIGNAL g, p: STD_LOGIC_VECTOR(31 DOWNTO 0) ;
SIGNAL g1, p1: STD_LOGIC_VECTOR(15 DOWNTO 0) ;
SIGNAL g2, p2: STD_LOGIC_VECTOR(7 DOWNTO 0) ;
SIGNAL g3, p3: STD_LOGIC_VECTOR(3 DOWNTO 0) ;
SIGNAL g4, p4: STD_LOGIC_VECTOR(1 DOWNTO 0) ;
SIGNAL g5, p5: STD_LOGIC_VECTOR(0 DOWNTO 0) ;
signal c: STD_LOGIC_VECTOR(31 DOWNTO 0) ;



begin
		stage0: for I in 0 to 31  generate
						G1:	gen port map(in_a(I),in_b(I),g(I));
						P1:	pro port map(in_a(I),in_b(I),p(I));
					end generate stage0;
		--time taken 250ps(generate)			
		stage1: for I1 in 0 to 15  generate
						S1_G:	next_g port map(g(2*I1),g(2*I1 +1),p(2*I1 + 1),g1(I1));
						S1_P:	next_p port map(p(2*I1),p(2*I1 +1),p1(I1));
					end generate stage1;
		--time taken 550ps(generate)				
		stage2: for I2 in 0 to 7  generate
						S2_G:	next_g port map(g1(2*I2),g1(2*I2 +1),p1(2*I2 + 1),g2(I2));
						S2_P:	next_p port map(p1(2*I2),p1(2*I2 +1),p2(I2));
					end generate stage2;
		--time taken 850ps(generate)				
		stage3: for I3 in 0 to 3  generate
						S3_G:	next_g port map(g2(2*I3),g2(2*I3 +1),p2(2*I3 + 1),g3(I3));
						S3_P:	next_p port map(p2(2*I3),p2(2*I3 +1),p3(I3));
					end generate stage3;
		--time taken 1150ps(generate)			
		stage4:for I4 in 0 to 1 generate
						S4_G:	next_g port map(g3(2*I4),g3(2*I4 +1),p3(2*I4 + 1),g4(I4));
						S4_P:	next_p port map(p3(2*I4),p3(2*I4 +1),p4(I4));
					end generate stage4;
		--time taken 1450ps(generate)				
		S5_G:	next_g port map(g4(0),g4(1),p4( 1),g5(0));
		S5_P:	next_p port map(p4(0),p4(1),p5(0));
		--time taken 1750ps(generate)	;;;;all G p generated
		--stage 6
		C31: 	next_c port map(g5(0),p5(0),carry_in,c(31));--2050
		C15: 	next_c port map(g4(0),p4(0),carry_in,c(15));--1750
		C7: 	next_c port map(g3(0),p3(0),carry_in,c(7));--1450
		C3: 	next_c port map(g2(0),p2(0),carry_in,c(3));--1150
		C1: 	next_c port map(g1(0),p1(0),carry_in,c(1));--850
		--stage7
		c23 : next_c port map(g3(2), p3(2),c(15),c(23));--2050
		c19 : next_c port map(g2(4), p2(4),c(15),c(19));
		c17 : next_c port map(g1(8), p1(8),c(15),c(17));

		c11: next_c port map(g2(2), p2(2),c(7),c(11));
		c9:  next_c port map(g1(4), p1(4),c(7),c(9));

		c5:  next_c port map(g1(2), p1(2),c(3),c(5));

		--stage 8
		c27 : next_c port map(g2(6), p2(6),c(23),c(27));--2350
		c25 : next_c port map(g1(12), p1(12),c(23),c(25));

		c21:  next_c port map(g1(10), p1(10),c(19),c(21));

		c13: next_c port map(g1(6), p1(6),c(11),c(13));

		--stage 9
		c29: next_c port map(g1(14), p1(14),c(27),c(29));--2650

		C0: 	next_c port map(g(0), p(0),carry_in,c(0));
		C2:  next_c port map(g(2), p(2),c(1),c(2));
		C4:  next_c port map(g(4), p(4),c(3),c(4));
		c6 : next_c port map(g(6), p(6),c(5),c(6));
		C8:  next_c port map(g(8), p(8),c(7),c(8));
		c10 : next_c port map(g(10), p(10),c(9),c(10));
		c12 : next_c port map(g(12), p(12),c(11),c(12));
		c14 : next_c port map(g(14), p(14),c(13),c(14));
		C16:  next_c port map(g(16), p(16),c(15),c(16));
		C18: 	next_c port map(g(18), p(18),c(17),c(18));
		C20:  next_c port map(g(20), p(20),c(19),c(20));
		C22:  next_c port map(g(22), p(22),c(21),c(22));
		C24:  next_c port map(g(24), p(24),c(23),c(24));
		c26 : next_c port map(g(26), p(26),c(25),c(26));
		c28 : next_c port map(g(28), p(28),c(27),c(28));
		c30 : next_c port map(g(30), p(30),c(29),c(30));--2950
		--stage 10
		ss:sum port map(in_a(0),in_b(0),carry_in,output(0));
		stage_X:for i in 1 to 31 generate
						SX_S:	sum port map(in_a(i),in_b(i),c(i-1),output(i));
					end generate stage_x;--3350
		output(32)<= c(31);
		carry_out<=c;
		end why;
---------------
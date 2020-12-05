library ieee;
use ieee.std_logic_1164.all;




entity dadda is
port ( 
	in_a,in_b: in std_logic_vector(15 DOWNTO 0);
	output : out std_logic_vector(31 DOWNTO 0)--output may have a bit extra
--p20 : out std_logic_vector(31 DOWNTO 0)
	
	);
end entity;

architecture why of dadda is
component adders
port (
	in_a,in_b: in std_logic_vector(31 DOWNTO 0);
	carry_in:  in std_logic;
	carry_out: out STD_LOGIC_VECTOR(31 downto 0);
	output : out std_logic_vector(32 DOWNTO 0)--output may have a bit extra
	);
end component;
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
component fulladders
port ( 
	a,b,c: in std_logic;
	sum,carry: out std_logic
	);

end component;
component halfadders
port ( 
	a,b: in std_logic;
	sum,carry: out std_logic
	);
end component;

component prod
port ( 
	a: in std_logic_vector(15 downto 0);
	b: in std_logic;
	output: out std_logic_vector(15 downto 0)
	);
end component;


--SIGNAL p0, p1,p2, p3,p4, p5,p6, p7,p8, p9: STD_LOGIC_VECTOR(15 DOWNTO 0) ;
--SIGNAL p10, p11,p12, p13,p14, p15,p16, p17,p18, p19: STD_LOGIC_VECTOR(15 DOWNTO 0) ;
--SIGNAL p20, p21,p22, p23,p24, p25,p26, p27,p28, p29: STD_LOGIC_VECTOR(15 DOWNTO 0) ;
--SIGNAL p30, p31: STD_LOGIC_VECTOR(15 DOWNTO 0) ;
SIGNAL p0, p1,p2, p3,p4, p5,p6, p7,p8, p9: STD_LOGIC_VECTOR(31 DOWNTO 0);
Signal p10, p11,p12, p13,p14, p15: STD_LOGIC_VECTOR(31 DOWNTO 0);
Signal pa0,pa1,pa2,pa3,pa4,pa5,pa6,pa7,pa8,pa9,pa10,pa11,pa12: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal pb0,pb1,pb2,pb3,pb4,pb5,pb6,pb7,pb8: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal pc0,pc1,pc2,pc3,pc4,pc5: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal pd0,pd1,pd2,pd3: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal pe0,pe1,pe2: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal pf0,pf1: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dum1: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dum2: STD_LOGIC_VECTOR(32 DOWNTO 0);
begin
---Bit product stage
bitstage0 : prod port map(in_a,in_b(0),p0(15 downto 0));
bitstage1 : prod port map(in_a,in_b(1),p1(16 downto 1));
bitstage2 : prod port map(in_a,in_b(2),p2(17 downto 2));
bitstage3 : prod port map(in_a,in_b(3),p3(18 downto 3));
bitstage4 : prod port map(in_a,in_b(4),p4(19 downto 4));
bitstage5 : prod port map(in_a,in_b(5),p5(20 downto 5));
bitstage6 : prod port map(in_a,in_b(6),p6(21 downto 6));
bitstage7 : prod port map(in_a,in_b(7),p7(22 downto 7));
bitstage8 : prod port map(in_a,in_b(8),p8(23 downto 8));
bitstage9 : prod port map(in_a,in_b(9),p9(24 downto 9));
bitstage10 : prod port map(in_a,in_b(10),p10(25 downto 10));
bitstage11 : prod port map(in_a,in_b(11),p11(26 downto 11));
bitstage12 : prod port map(in_a,in_b(12),p12(27 downto 12));
bitstage13 : prod port map(in_a,in_b(13),p13(28 downto 13));
bitstage14 : prod port map(in_a,in_b(14),p14(29 downto 14));
bitstage15 : prod port map(in_a,in_b(15),p15(30 downto 15));
--p15(12 downto 0)<= p0(12 downto 0); 
---p14(12 downto 0)<= p1(12 downto 0); 
--p13(12 downto 0)<= p2(12 downto 0);



half_13a : halfadders port map(p0(13),p1(13),pa0(13),pa0(14)) ;

full_14a : fulladders port map(p0(14),p1(14),p2(14),pa1(14),pa0(15));
half_14a : halfadders port map(p3(14),p4(14),pa2(14),pa1(15));

full1_15a : fulladders port map(p1(15),p2(15),p3(15),pa2(15),pa0(16));
full2_15a : fulladders port map(p4(15),p5(15),p6(15),pa3(15),pa1(16));
half_15a : halfadders port map(p7(15),p0(15),pa4(15),pa2(16));

full1_16a : fulladders port map(p1(16),p2(16),p3(16),pa3(16),pa0(17));
full2_16a : fulladders port map(p4(16),p5(16),p6(16),pa4(16),pa1(17));
half_16a : halfadders port map(p7(16),p8(16),pa5(16),pa2(17));

full1_17a : fulladders port map(p2(17),p3(17),p4(17),pa3(17),pa0(18));
full2_17a : fulladders port map(p5(17),p6(17),p7(17),pa4(17),pa1(18));

full1_18a : fulladders port map(p3(18),p4(18),p5(18),pa2(18),pa0(19));
--stage 13-9

half_9b :halfadders port map(p0(9),p1(9),pb0(9),pb0(10)) ;

full_10b : fulladders port map(p0(10),p1(10),p2(10),pb1(10),pb0(11)) ;
half_10b : halfadders port map(p3(10),p4(10),pb2(10),pb1(11)) ;

full1_11b : fulladders port map(p0(11),p1(11),p2(11),pb2(11),pb0(12)) ;
full2_11b : fulladders port map(p3(11),p4(11),p5(11),pb3(11),pb1(12)) ;
half_11b : halfadders port map(p6(11),p7(11),pb4(11),pb2(12)) ;

full1_12b : fulladders port map(p0(12),p1(12),p2(12),pb3(12),pb0(13)) ;
full2_12b : fulladders port map(p3(12),p4(12),p5(12),pb4(12),pb1(13)) ;
full3_12b : fulladders port map(p6(12),p7(12),p8(12),pb5(12),pb2(13)) ;
half_12b : halfadders port map(p9(12),p10(12),pb6(12),pb3(13)) ;

full1_13b : fulladders port map(p3(13),p4(13),p5(13),pb4(13),pb0(14)) ;
full2_13b : fulladders port map(p6(13),p7(13),p8(13),pb5(13),pb1(14)) ;
full3_13b : fulladders port map(p9(13),p10(13),p11(13),pb6(13),pb2(14)) ;
full4_13b : fulladders port map(p12(13),p13(13),p2(13),pb7(13),pb3(14)) ;

full1_14b : fulladders port map(p5(14),p6(14),p7(14),pb4(14),pb0(15)) ;
full2_14b : fulladders port map(p8(14),p9(14),p10(14),pb5(14),pb1(15)) ;
full3_14b : fulladders port map(p11(14),p12(14),p13(14),pb6(14),pb2(15)) ;
full4_14b : fulladders port map(p14(14),pa1(14),pa2(14),pb7(14),pb3(15)) ;

full1_15b : fulladders port map(p8(15),p9(15),p10(15),pb4(15),pb0(16)) ;
full2_15b : fulladders port map(p11(15),p12(15),p13(15),pb5(15),pb1(16)) ;
full3_15b : fulladders port map(p14(15),p15(15),pa1(15),pb6(15),pb2(16)) ;
full4_15b : fulladders port map(pa2(15),pa3(15),pa4(15),pb7(15),pb3(16)) ;

full1_16b : fulladders port map(p9(16),p10(16),p11(16),pb4(16),pb0(17)) ;
full2_16b : fulladders port map(p12(16),p13(16),p14(16),pb5(16),pb1(17)) ;
full3_16b : fulladders port map(p15(16),pa1(16),pa2(16),pb6(16),pb2(17)) ;
full4_16b : fulladders port map(pa3(16),pa4(16),pa5(16),pb7(16),pb3(17)) ;


full1_17b : fulladders port map(p8(17),p9(17),p10(17),pb4(17),pb0(18)) ;
full2_17b : fulladders port map(p11(17),p12(17),p13(17),pb5(17),pb1(18)) ;
full3_17b : fulladders port map(p14(17),p15(17),pa1(17),pb6(17),pb2(18)) ;
full4_17b : fulladders port map(pa2(17),pa3(17),pa4(17),pb7(17),pb3(18)) ;


full1_18b : fulladders port map(p6(18),p7(18),p8(18),pb4(18),pb0(19)) ;
full2_18b : fulladders port map(p9(18),p10(18),p11(18),pb5(18),pb1(19)) ;
full3_18b : fulladders port map(p12(18),p13(18),p14(18),pb6(18),pb2(19)) ;
full4_18b : fulladders port map(p15(18),pa1(18),pa2(18),pb7(18),pb3(19)) ;

full1_19b : fulladders port map(p4(19),p5(19),p6(19),pb4(19),pb0(20)) ;
full2_19b : fulladders port map(p7(19),p8(19),p9(19),pb5(19),pb1(20)) ;
full3_19b : fulladders port map(p10(19),p11(19),p12(19),pb6(19),pb2(20)) ;
full4_19b : fulladders port map(p13(19),p14(19),p15(19),pb7(19),pb3(20)) ;

full1_20b : fulladders port map(p5(20),p6(20),p7(20),pb4(20),pb0(21)) ;
full2_20b : fulladders port map(p8(20),p9(20),p10(20),pb5(20),pb1(21)) ;
full3_20b : fulladders port map(p11(20),p12(20),p13(20),pb6(20),pb2(21)) ;

full1_21b : fulladders port map(p6(21),p7(21),p8(21),pb3(21),pb0(22)) ;
full2_21b : fulladders port map(p9(21),p10(21),p11(21),pb4(21),pb1(22)) ;

full1_22b : fulladders port map(p7(22),p8(22),p9(22),pb2(22),pb0(23)) ;

--for 0 to 8 bits in p from p0 to pi
--9=> b0 and p2 - p9
--10=> p5- p10 bo b1 b2
--11+> p8- p11  b0 b1 b2 b3 b4 
--12+> b0 to b6 p11 p12
--13,14,15,16,17,18,19+> b0 to b7 pa0
--20+>b0to b6  p14,p15
--21+> b0 - b4 p12 p13 p14 p15
--22+> b0 b1 b2 p10 p11 p12 p13 p14 p15
--23+> bo  p8 - p15
--24-31 = ps

--9 to 6
half_6c :halfadders port map(p0(6),p1(6),pc0(6),pc0(7)) ;

full_7b : fulladders port map(p0(7),p1(7),p2(7),pc1(7),pc0(8)) ;
half_7b : halfadders port map(p3(7),p4(7),pc2(7),pc1(8)) ;

full1_8c : fulladders port map(p0(8),p1(8),p2(8),pc2(8),pc0(9)) ;
full2_8c : fulladders port map(p3(8),p4(8),p5(8),pc3(8),pc1(9)) ;
half_8c: halfadders port map(p6(8),p7(8),pc4(8),pc2(9)) ;

full1_9c : fulladders port map(pb0(9),p2(9),p3(9),pc3(9),pc0(10)) ;
full2_9c : fulladders port map(p4(9),p5(9),p6(9),pc4(9),pc1(10)) ;
full3_9c : fulladders port map(p7(9),p8(9),p9(9),pc5(9),pc2(10)) ;

full1_10c : fulladders port map(pb0(10),pb1(10),pb2(10),pc3(10),pc0(11)) ;
full2_10c : fulladders port map(p5(10),p6(10),p7(10),pc4(10),pc1(11)) ;
full3_10c : fulladders port map(p8(10),p9(10),p10(10),pc5(10),pc2(11)) ;

full1_11c : fulladders port map(pb0(11),pb1(11),pb2(11),pc3(11),pc0(12)) ;
full2_11c : fulladders port map(pb3(11),pb4(11),p8(11),pc4(11),pc1(12)) ;
full3_11c : fulladders port map(p9(11),p10(11),p11(11),pc5(11),pc2(12)) ;

full1_12c : fulladders port map(pb0(12),pb1(12),pb2(12),pc3(12),pc0(13)) ;
full2_12c : fulladders port map(pb3(12),pb4(12),pb5(12),pc4(12),pc1(13)) ;
full3_12c : fulladders port map(pb6(12),p11(12),p12(12),pc5(12),pc2(13)) ;


stage0: for I in 13 to 19  generate

					
	full1_13c : fulladders port map(pb0(I),pb1(I),pb2(I),pc3(I),pc0(I+1)) ;
	full2_13c : fulladders port map(pb3(I),pb4(I),pb5(I),pc4(I),pc1(I+1)) ;
	full3_13c : fulladders port map(pb6(I),pb7(I),pa0(I),pc5(I),pc2(I+1)) ;
end generate stage0;
full1_20c : fulladders port map(pb0(20),pb1(20),pb2(20),pc3(20),pc0(21)) ;
full2_20c : fulladders port map(pb3(20),pb4(20),pb5(20),pc4(20),pc1(21)) ;
full3_20c : fulladders port map(pb6(20),p14(20),p15(20),pc5(20),pc2(21)) ;

full1_21c : fulladders port map(pb0(21),pb1(21),pb2(21),pc3(21),pc0(22)) ;
full2_21c : fulladders port map(pb3(21),pb4(21),p12(21),pc4(21),pc1(22)) ;
full3_21c : fulladders port map(p13(21),p14(21),p15(21),pc5(21),pc2(22)) ;

full1_22c : fulladders port map(pb0(22),pb1(22),pb2(22),pc3(22),pc0(23)) ;
full2_22c : fulladders port map(p10(22),p11(22),p12(22),pc4(22),pc1(23)) ;
full3_22c : fulladders port map(p13(22),p14(22),p15(22),pc5(22),pc2(23)) ;

full1_23c : fulladders port map(pb0(23),p8(23),p9(23),pc3(23),pc0(24)) ;
full2_23c : fulladders port map(p10(23),p11(23),p12(23),pc4(23),pc1(24)) ;
full3_23c : fulladders port map(p13(23),p14(23),p15(23),pc5(23),pc2(24)) ;

full1_24c : fulladders port map(p9(24),p10(24),p11(24),pc3(24),pc0(25)) ;
full2_24c : fulladders port map(p12(24),p13(24),p14(24),pc4(24),pc1(25)) ;

full2_25c : fulladders port map(p10(25),p11(25),p12(25),pc2(25),pc0(26)) ;

	--for 0 to 5 bits in p from p0 to pi
	--6 p2-p6 pco
	--7 p5 p6 p7  pc0 pc1 pc2	
	--8 p8 pc0 - pc4
	--9- 23 pc0-pc5
	--24 p15 pco - pc4
	--25 pc0 - pc2 p13 p14 p15
	--26 p11 p12 p13 p14 p15 pc0
	
	--6 to 4
half_4d :halfadders port map(p0(4),p1(4),pd0(4),pd0(5)) ;

full_5d : fulladders port map(p0(5),p1(5),p2(5),pd1(5),pd0(6)) ;
half_5d : halfadders port map(p3(5),p4(5),pd2(5),pd1(6)) ;


full1_6d : fulladders port map(p2(6),p3(6),p4(6),pd2(6),pd0(7)) ;
full2_6d : fulladders port map(p5(6),p6(6),pc0(6),pd3(6),pd1(7)) ;


full1_7d : fulladders port map(p5(7),p6(7),p7(7),pd2(7),pd0(8)) ;
full2_7d : fulladders port map(pc0(7),pc1(7),pc2(7),pd3(7),pd1(8)) ;


full1_8d : fulladders port map(p8(8),pc0(8),pc1(8),pd2(8),pd0(9)) ;
full2_8d : fulladders port map(pc2(8),pc3(8),pc4(8),pd3(8),pd1(9)) ;

stage1a: for I in 9 to 23  generate

					
full1_9d : fulladders port map(pc0(I),pc1(I),pc2(I),pd2(I),pd0(I+1)) ;
full2_9d : fulladders port map(pc3(I),pc4(I),pc5(I),pd3(I),pd1(I+1)) ;
end generate stage1a;

full1_24d : fulladders port map(p15(24),pc0(24),pc1(24),pd2(24),pd0(25)) ;
full2_24d : fulladders port map(pc2(24),pc3(24),pc4(24),pd3(24),pd1(25)) ;

full1_25d : fulladders port map(p13(25),p14(25),p15(25),pd2(25),pd0(26)) ;
full2_25d : fulladders port map(pc0(25),pc1(25),pc2(25),pd3(25),pd1(26)) ;

full1_26d : fulladders port map(p11(26),p12(26),p13(26),pd2(26),pd0(27)) ;
full2_26d : fulladders port map(p14(26),p15(26),pc0(26),pd3(26),pd1(27)) ;

full1_27d : fulladders port map(p12(27),p13(27),p14(27),pd2(27),pd0(28)) ;

--0-3  p0 -pi
--4    p2,p3,p4,pd0
--5    p5,pd0 pd1,pd2
--6-26 pd0 pd1 pd2 pd3
--27   p15 pd0 pd1 pd2
--28   p13 p14 p15 pd0
--29   p14 p15
--30   p15
 
 --4 to 3
half_3e :halfadders port map(p0(3),p1(3),pe0(3),pe0(4)) ;

full_4e : fulladders port map(p2(4),p3(4),p4(4),pe1(4),pe0(5)) ;

full_5e : fulladders port map(p5(5),pd1(5),pd2(5),pe1(5),pe0(6)) ;

stage1r: for I in 6 to 26  generate

full_6e : fulladders port map(pd1(I),pd2(I),pd3(I),pe1(I),pe0(I+1)) ;				

end generate stage1r;
full_27e : fulladders port map(p15(27),pd1(27),pd2(27),pe1(27),pe0(28)) ;

full_28e : fulladders port map(p13(28),p14(28),p15(28),pe1(28),pe0(29)) ;

--0-2  p0 -pi
--3 p2 p3 pe0
--4 pd0,pe0,pe1  
--5  pd0,pe0,pe1
--6-26 pd0,pe0,pe1
--27  pd0,pe0,pe11
--28   pd0,pe0,pe1
--29   p14 p15 pe0
--30   p15

--3 to 2

half_2f :halfadders port map(p0(2),p1(2),pf0(2),pf0(3)) ;
full_3f : fulladders port map(p2(3),p3(3),pe0(3),pf1(3),pf0(4)) ;
stage1u: for I in 4 to 28  generate

full_4f : fulladders port map(pd0(I),pe0(I),pe1(I),pf1(I),pf0(I+1)) ;				

end generate stage1u;
full_29f : fulladders port map(p14(29),p15(29),pe0(29),pf1(29),pf0(30)) ;
pf1(30)<= p15(30);

pf1(2)<= p2(2);
pf1(1)<= p1(1);

pf0(1)<=p0(1);
pf0(0)<=p0(0);

pf1(0)<= '0';

pf0(31)<= '0';
pf1(31)<='0';

final: adders port map( pf0,pf1,'0',dum1,dum2);

output<= dum2(31 downto  0);
end why;
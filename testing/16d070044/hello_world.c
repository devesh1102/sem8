#include <stdlib.h>
#include <stdio.h>
#include <bdduser.h>

int main (int argc, char* argv[])
{
	bdd_manager bddm = bdd_init();
//////////////////////////////////////Input////////////////////////////////////////////////
	bdd a0 = bdd_new_var_last(bddm);
	bdd a1 = bdd_new_var_last(bddm);
	bdd a2 = bdd_new_var_last(bddm);
	bdd a3 = bdd_new_var_last(bddm);
	bdd a4 = bdd_new_var_last(bddm);
	bdd a5 = bdd_new_var_last(bddm);
	bdd a6 = bdd_new_var_last(bddm);
	bdd a7 = bdd_new_var_last(bddm);

	bdd b0 = bdd_new_var_last(bddm);
	bdd b1 = bdd_new_var_last(bddm);
	bdd b2 = bdd_new_var_last(bddm);
	bdd b3 = bdd_new_var_last(bddm);
	bdd b4 = bdd_new_var_last(bddm);
	bdd b5 = bdd_new_var_last(bddm);
	bdd b6 = bdd_new_var_last(bddm);
	bdd b7 = bdd_new_var_last(bddm);
//////////////////////////////////////Specification : ripple carry adder////////////////////////////////////////////////
	bdd s0 = bdd_xor(bddm, a0, b0);
	bdd c0 = bdd_and(bddm, a0, b0);

	bdd s1 = bdd_xor(bddm, bdd_xor(bddm,a1,b1), c0);
	bdd c1 = bdd_or(bddm, bdd_and(bddm,a1,b1),bdd_and(bddm,bdd_or(bddm,a1,b1),c0) );

	bdd s2 = bdd_xor(bddm, bdd_xor(bddm,a2,b2), c1);
	bdd c2 = bdd_or(bddm, bdd_and(bddm,a2,b2),bdd_and(bddm,bdd_or(bddm,a2,b2),c1) );

	bdd s3 = bdd_xor(bddm, bdd_xor(bddm,a3,b3), c2);
	bdd c3 = bdd_or(bddm, bdd_and(bddm,a3,b3),bdd_and(bddm,bdd_or(bddm,a3,b3),c2) );

	bdd s4 = bdd_xor(bddm, bdd_xor(bddm,a4,b4), c3);
	bdd c4 = bdd_or(bddm, bdd_and(bddm,a4,b4),bdd_and(bddm,bdd_or(bddm,a4,b4),c3));

	bdd s5 = bdd_xor(bddm, bdd_xor(bddm,a5,b5), c4);
	bdd c5 = bdd_or(bddm, bdd_and(bddm,a5,b5),bdd_and(bddm,bdd_or(bddm,a5,b5),c4) );

	bdd s6 = bdd_xor(bddm, bdd_xor(bddm,a6,b6), c5);
	bdd c6 = bdd_or(bddm, bdd_and(bddm,a6,b6),bdd_and(bddm,bdd_or(bddm,a6,b6),c5) );

	bdd s7 = bdd_xor(bddm, bdd_xor(bddm,a7,b7), c6);
//////////////////////////////////////Carry Look-Ahead Adder////////////////////////////////////////////////
	bdd p0 = bdd_xor(bddm,a0,b0);
	bdd g0 = bdd_and(bddm,a0,b0);

	bdd p1 = bdd_xor(bddm,a1,b1);
	bdd g1 = bdd_and(bddm,a1,b1);

	bdd p2 = bdd_xor(bddm,a2,b2);
	bdd g2 = bdd_and(bddm,a2,b2);

	bdd p3 = bdd_xor(bddm,a3,b3);
	bdd g3 = bdd_and(bddm,a3,b3);

	bdd p4 = bdd_xor(bddm,a4,b4);
	bdd g4 = bdd_and(bddm,a4,b4);


	bdd p5 = bdd_xor(bddm,a5,b5);
	bdd g5 = bdd_and(bddm,a5,b5);

	bdd p6 = bdd_xor(bddm,a6,b6);
	bdd g6 = bdd_and(bddm,a6,b6);


	bdd p7 = bdd_xor(bddm,a7,b7);
	bdd g7 = bdd_and(bddm,a7,b7);

	bdd cla_s0 = bdd_xor(bddm, a0, b0);
//c0 is same as go
	bdd cla_s1 = bdd_xor(bddm, p1, g0);
	bdd cla_c1 = bdd_or(bddm,g1,bdd_and(bddm,p1,g0));

	bdd cla_s2 = bdd_xor(bddm, p2, cla_c1);
	bdd cla_c2 = bdd_or(bddm,g2,bdd_and(bddm,p2,bdd_or(bddm,g1,bdd_and(bddm,p1,g0))));

	bdd cla_s3 = bdd_xor(bddm, p3, cla_c2);
	bdd cla_c3 = bdd_or(bddm,g3,bdd_and(bddm,p3,bdd_or(bddm,g2,bdd_and(bddm,p2,bdd_or(bddm,g1,bdd_and(bddm,p1,g0))))));

	bdd cla_s4 = bdd_xor(bddm, p4, cla_c3);
	bdd cla_c4 = bdd_or(bddm,g4,bdd_and(bddm,p4,bdd_or(bddm,g3,bdd_and(bddm,p3,bdd_or(bddm,g2,bdd_and(bddm,p2,bdd_or(bddm,g1,bdd_and(bddm,p1,g0))))))));

	bdd cla_s5 = bdd_xor(bddm, p5, cla_c4);
	bdd cla_c5 = bdd_or(bddm,g5,bdd_and(bddm,p5,bdd_or(bddm,g4,bdd_and(bddm,p4,bdd_or(bddm,g3,bdd_and(bddm,p3,bdd_or(bddm,g2,bdd_and(bddm,p2,bdd_or(bddm,g1,bdd_and(bddm,p1,g0))))))))));

	bdd cla_s6 = bdd_xor(bddm, p6, cla_c5);
	bdd cla_c6 = bdd_or(bddm,g6,bdd_and(bddm,p6,bdd_or(bddm,g5,bdd_and(bddm,p5,bdd_or(bddm,g4,bdd_and(bddm,p4,bdd_or(bddm,g3,bdd_and(bddm,p3,bdd_or(bddm,g2,bdd_and(bddm,p2,bdd_or(bddm,g1,bdd_and(bddm,p1,g0))))))))))));

	bdd cla_s7 = bdd_xor(bddm, p7, cla_c6);
	
	//bdd_print_bdd(bddm,cla_s1,NULL, NULL,NULL, stdout);
	//bdd_print_bdd(bddm,s1,NULL, NULL,NULL, stdout);


	if (s0 == cla_s0)
	{
		printf("s0 Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
	}
	if (s1 == cla_s1)
	{
		printf("s1 Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
	}
	if (s2 == cla_s2)
	{
		printf("s2 Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
	}
	if (s3 == cla_s3)
	{
		printf("s3 Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
	}
	if (s4 == cla_s4)
	{
		printf("s4 Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
	}
	if (s5 == cla_s5)
	{
		printf("s5 Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
	}
	if (s6 == cla_s6)
	{
		printf("s6 Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
	}
	if (s7 == cla_s7)
	{
		printf("s7 Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
	}
	

	//bdd c1 = bdd_or(bddm, bdd_and(bddm,a1,b1),bdd_and(bddm,bdd_or(bddm,a1,b1),c0) );
	// make 3 variables x0,x1,x2 (in that order)
	//bdd x0 = bdd_new_var_last(bddm);
	//bdd x1 = bdd_new_var_last(bddm);
	//bdd x2 = bdd_new_var_last(bddm);

	// compute y = (x0.x1)+x2
	//bdd a  = bdd_and (bddm,x0,x1);	
	//bdd y  = bdd_or (bddm,x2,a);	

	// compute z = (x0 + x2).(x1 + x2)
	//bdd b = bdd_or (bddm, x0,x2);
	//bdd c = bdd_or (bddm, x1,x2);
	//bdd z = bdd_and (bddm, b, c);

	
/*
	printf("----------------------------------------------------\n");

	// print y
	bdd_print_bdd(bddm,y,NULL, NULL,NULL, stdout);

	// are z and y the same?
	if (z == y)
	{
		printf("Equal\n");
	}	
	else
	{
		printf("Not Equal\n");
		// print z
		bdd_print_bdd(bddm,z,NULL, NULL,NULL, stdout);
		
	}


	printf("----------------------------------------------------\n");

	// compute w = (x0 + x2) + (x1 + x2)
	bdd w = bdd_or (bddm, b,c);
	bdd_print_bdd(bddm,w,NULL, NULL,NULL, stdout);

	// are w and y the same? of course not.
	if (w == y)
	{
		printf("Equal\n");
	}	
	else
	{
		// you should get this.
		printf("Not Equal\n");
	}

	printf("----------------------------------------------------\n");

	// Existential quantification example.
	bdd x4 = bdd_new_var_last(bddm);
	bdd p = bdd_and(bddm, x4, z);
	bdd Q[2];
	Q[0] = x0; Q[1] = 0;
	int assoc = bdd_new_assoc(bddm,Q,0);
	bdd_assoc(bddm,assoc);

	bdd pq = bdd_exists(bddm,p);
	bdd_print_bdd(bddm,pq,NULL, NULL,NULL, stdout);
*/
	return(0);
}


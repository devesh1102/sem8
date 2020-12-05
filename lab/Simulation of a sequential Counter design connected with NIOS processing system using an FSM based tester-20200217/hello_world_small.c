#include "sys/alt_stdio.h"
#include "sys/alt_stdio.h"
#include "system.h"
#include "io.h"
#include <stdio.h>

int extra_inputs = 0;

void write_extra_inputs () {
	IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);
}

void clock(){
	for(int j = 0; j < 5; j++);

    extra_inputs = extra_inputs | 0x00000001;

    write_extra_inputs ();

	for(int j = 0; j < 10; j++);

    extra_inputs = extra_inputs & 0xFFFFFFFE;

    write_extra_inputs ();

	for(int j = 0; j < 5; j++);
}


int main()
{ 
	alt_putstr("Hello from Nios II!\n \n");

	int input_array_0[3] = {11, 5, 2};
	int input_array_1[3] = {13, 7, 3};

	int input_vector_0, input_vector_1, output, inputs_rdy, latch_inputs, inputs_consumed, result_rdy, result_consumed;


	for (int i = 0; i < 3; i++){
		printf("***** Test case #%d *****\n \n", i+1);

		input_vector_0 = input_array_0[i];
		input_vector_1 = input_array_1[i];

		extra_inputs = 0b0010;
		IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);		// writing inputs_rdy signal
		printf ("Writing inputs_rdy = 1.\n");

		inputs_rdy = (IORD(USER_EXTRA_INPUTS_BASE, 0) >> 1) & 0b0001;

		printf ("inputs_rdy is %d.\n", inputs_rdy);

		while(1){
			latch_inputs = (IORD(USER_EXTRA_OUTPUTS_BASE, 0)) & 0b0001;

			if (latch_inputs == 1){
				break;
			}
		}

		IOWR(USER_INPUT_0_BASE, 0, input_vector_0);		// writing input vectors
		IOWR(USER_INPUT_1_BASE, 0, input_vector_1);

		printf ("Input_0 is [0x%x].\n", input_vector_0);
		printf ("Input_1 is [0x%x].\n", input_vector_1);


		clock();

		while(1){
		  inputs_consumed = (IORD(USER_EXTRA_OUTPUTS_BASE, 0) >> 1) & 0b0001;

		  if (inputs_consumed == 1){
			  printf ("inputs_consumed is %d.\n", inputs_consumed);
			  break;
		  }

		  clock ();
		}


		extra_inputs = 0b0000;
		IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);  	// Clearing all extra inputs

		while(1){
		  result_rdy = (IORD(USER_EXTRA_OUTPUTS_BASE, 0) >> 2) & 0b0001;

		  if (result_rdy == 1){
			  printf ("result_rdy is %d.\n", result_rdy);
			  break;
		  }
		  else{
			  clock();
		  }
		}

		output = IORD(USER_OUTPUT_BASE, 0);
		printf ("Output = [0x%x] \n", output);

		extra_inputs = 0b0100;
		IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);		// writing result_consumed signal
		printf ("Writing result_consumed = 1 \n");
		clock();

		result_consumed = (IORD(USER_EXTRA_INPUTS_BASE, 0) >> 2) & 0b0001;

		printf ("result_consumed is %d.\n \n", result_consumed);

	}

  return 0;
}

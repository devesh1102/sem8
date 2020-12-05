/* 
 *
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include "sys/alt_stdio.h"
#include "system.h"
#include "io.h"
#include <stdio.h>

static int extra_inputs , extra_outputs , input_0_vector , input_1_vector, output ;

void assert_coproc_clk ( void ) { 
  extra_inputs = extra_inputs | 0x00000001 ;
  IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);
}
void deassert_coproc_clk ( void ) { 
  extra_inputs = extra_inputs & 0xfffffffe ; 
  IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);
}
void assert_EN_start ( void ) { 
  extra_inputs = extra_inputs | 0x00000002 ; 
  IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);
}
void deassert_EN_start ( void ) {
  extra_inputs = extra_inputs & 0xfffffffd ; 
  IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);
}
void assert_EN_result ( void ) { 
  extra_inputs = extra_inputs | 0x00000004 ; 
  IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);
}
void deassert_EN_result ( void ) { 
  extra_inputs = extra_inputs & 0xfffffffb ; 
  IOWR(USER_EXTRA_INPUTS_BASE, 0, extra_inputs);
}

int is_RDY_result ( void ) { 
  extra_outputs = IORD(USER_EXTRA_OUTPUTS_BASE, 0 );
  alt_printf( "in is_RDY_result() call\n" );
  alt_printf ("extra_outputs = [0x%x] \n", extra_outputs & 0xF);
  return ( extra_outputs ) & 0x1 ;
}

int is_RDY_start ( void ) { 
  extra_outputs = IORD(USER_EXTRA_OUTPUTS_BASE, 0 );
  alt_printf( "in is_RDY_start() call\n" );
  alt_printf ("extra_outputs = [0x%x] \n", extra_outputs );
  return ( extra_outputs >> 1 ) & 0x1 ;
}

void pulse_coproc_clk (void) {
  int i ;
  alt_printf( "in pulse_coproc_clk() call\n" );
  assert_coproc_clk( ) ;
  for (i=0; i<4 ; i++ ) ;
  deassert_coproc_clk( ) ;
}

void drive_input_0 ( int val0 ) {
  input_0_vector = val0 ;
  IOWR(USER_INPUT_0_BASE, 0, input_0_vector);
}

void drive_input_1 ( int val1 ) {
  input_1_vector = val1 ;
  IOWR(USER_INPUT_1_BASE, 0, input_1_vector);
}

void apply_operands (int a , int b) {
  alt_printf( "in apply_operand() call\n" );
  while ( ! is_RDY_start( ) ) {
    pulse_coproc_clk ( ) ;
  }
  drive_input_0 ( a ) ;
  drive_input_1 ( b ) ;
  assert_EN_start ( ) ;
  pulse_coproc_clk ( ) ;
  deassert_EN_start () ;
  pulse_coproc_clk ( ) ;
}

void wait_for_result (void) {
  alt_printf( "in wait_for_result() call\n" );
  while ( ! is_RDY_result() ) {
    pulse_coproc_clk() ;
  }
}

int read_result ( void ) {
  alt_printf( "in read_result() call\n" );
  output = IORD(USER_OUTPUT_BASE, 0);
  alt_printf( " result is = 0x%x \n" , output ) ;
  assert_EN_result() ;
  pulse_coproc_clk () ;
  deassert_EN_result() ;
  return output ;
}


int main()
{ 
  alt_putstr("Hello from Nios II!\n \n");

  alt_printf ("Test case 1 \n");
  extra_inputs = 0 ; 

  apply_operands( 0x00010011 , 0x00010021 ) ;
  wait_for_result( ) ;
  read_result() ;

  return 0 ;
}

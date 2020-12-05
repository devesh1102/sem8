// Copyright (c) 2014-2016 Bluespec, Inc.  All Rights Reserved.

package Testbench;

// ================================================================
// Project imports

import SequenceDetect :: *;

// ================================================================

(* synthesize *)
module mkTestbench (Empty);

   Reg #(Bit #(32)) count <- mkReg(0);
   Reg #(Bit #(32)) count1 <- mkReg(0);

   SequenceDetect sequence_det <- seq_det;

   rule jare(count1 == 0);
      sequence_det.put(3);
      count1 <= count1 + 1;
      $display("one");
	endrule

   rule jare1(count1 == 1);
      sequence_det.put(594);
      count1 <= 2;
      $display("two");
   endrule

    rule jare2(count1 == 2);
      sequence_det.put(2961610498);
      count1 <= 0;
      $display("three");
   endrule

   rule rl_print_answer;
   				
      let x <- sequence_det.get;
      $display ("output %d.", x);
      if(count == 3)$finish;
      count <= count + 1;
   endrule
endmodule

// ================================================================

endpackage
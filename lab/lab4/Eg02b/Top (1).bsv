// Copyright (c) 2014-2016 Bluespec, Inc.  All Rights Reserved.
package Top;

// ================================================================
// Here is the Testbench
// ================================================================

// ================================================================
// Interface declaration
// Empty -- this is the top-level
// ================================================================

// ================================================================
// Module definition
(* synthesize *)
module mkTestbench (Empty);

   DeepThought_IFC deepThought <- mkDeepThought;    // (A)

   rule rl_print_answer;
      let x <- deepThought.getAnswer;
      $display ("Deep Thought says: Hello, World! The answer is %0d.", x);
   endrule
endmodule

// ================================================================
// Here is the DUT
// ================================================================

// ================================================================
// Interface declaration

interface DeepThought_IFC;
   method ActionValue #(int)  getAnswer;
endinterface

// ================================================================
// Module definition

(* synthesize *)
module mkDeepThought (DeepThought_IFC);

   method ActionValue#(int) getAnswer;
      return 42;
   endmethod
endmodule

endpackage : Top


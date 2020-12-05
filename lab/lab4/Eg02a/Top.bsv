// Copyright (c) 2013-2016 Bluespec, Inc.  All Rights Reserved.

package Top;

// Common testbench for variants of simple pipelines

// ----------------------------------------------------------------
// Imports from the BSV library

import FIFOF        :: *;
import GetPut       :: *;
import ClientServer :: *;
import Vector       :: *;

// ================================================================
// Misc. useful definitions, not app-specific

// ================================================================
// A convenience function to return the current cycle number during Bluesim simulations

ActionValue #(Bit #(32)) cur_cycle = actionvalue
					Bit #(32) t <- $stime;
					return t / 10;
				     endactionvalue;

// ================================================================

// ----------------------------------------------------------------
// Interface definition

typedef Server #(Tuple2 #(Bit #(n), Bit #(TLog #(n))),
		 Bit #(n))
        Shifter_IFC #(numeric type n);

// The above uses the standard 'Server' interface,
// which is defined in BSV's ClientServer library as follows,
// and fixing t1 as Tuple2 #(Bit #(8), Bit #(3))
// and        t2 as Bit #(8)
//
// interface Server #(t1, t2);
//    interface Put #(t1) request;
//    interface Get #(t2) response;
// endinterface
//
// 'Server', in turn, uses the standard 'Put' and 'Get' interfaces,
// which are defined in BSV's GetPut library as follows:
//
// interface Put #(t1);
//    method Action put (t1 x);
// endinterface
//
// interface Get #(t2);
//    method ActionValue #(t2) get ();
// endinterface

// ----------------------------------------------------------------

// ----------------------------------------------------------------
// The rigid pipelined shifter

module mkShifter (Shifter_IFC #(n));
   FIFOF #(Tuple2 #(Bit #(n), Bit #(TLog #(n))))  fifo_in_xy <- mkFIFOF;
   FIFOF #(Bit #(n))                              fifo_out_z <- mkFIFOF;

   Vector #(TSub #(TLog #(n), 1), Reg #(Bit #(n)))         vr_x <- replicateM (mkRegU);
   Vector #(TSub #(TLog #(n), 1), Reg #(Bit #(TLog #(n)))) vr_y <- replicateM (mkRegU);

   Integer j_max = valueOf (TLog #(n)) - 1;

   rule rl_all_together;
      // Stage 0
      match { .x0, .y0 } = fifo_in_xy.first;  fifo_in_xy.deq;
      vr_x[0] <= ((y0[0] == 0) ? x0 : (x0 << 1));
      vr_y[0] <= y0;

      // Stage j: 1..j_max-1
      for (Integer j = 1; j < j_max; j = j + 1) begin
	 vr_x[j] <= ((vr_y[j-1][j] == 0) ? vr_x[j-1] : (vr_x[j-1] << (2**j)));
	 vr_y[j] <= vr_y[j-1];
      end

      // Stage j_max
      fifo_out_z.enq (((vr_y[j_max-1][j_max] == 0) ? vr_x[j_max-1] : (vr_x[j_max-1] << (2**j_max))));
   endrule

   return toGPServer (fifo_in_xy, fifo_out_z);
endmodule

// ----------------------------------------------------------------
// Testbench starts here
// ----------------------------------------------------------------

(* synthesize *)
module mkTestbench (Empty);
   Shifter_IFC #(16)  shifter <- mkShifter_16_4;

   Reg #(Bit #(5)) rg_y <- mkReg (0);

   rule rl_gen (rg_y < 16);
      shifter.request.put (tuple2 (16'h01, truncate (rg_y)));  // or rg_y[3:0]
      rg_y <= rg_y + 1;
      $display ("%0d: Input 0x0000_0001 %0d", cur_cycle, rg_y);
   endrule

   rule rl_drain;
      let z <- shifter.response.get ();
      $display ("                                %0d: Output %16b", cur_cycle, z);
      if (z == 16'h8000) $finish ();
   endrule
endmodule: mkTestbench

// ----------------------------------------------------------------

(* synthesize *)
module mkShifter_16_4 (Shifter_IFC #(16));
   let m <- mkShifter;
   return m;
endmodule

// ----------------------------------------------------------------

endpackage: Top

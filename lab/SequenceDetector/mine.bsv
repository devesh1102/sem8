// Copyright (c) 2014-2016 Bluespec, Inc.  All Rights Reserved.

package Test;

// ================================================================
// Project imports

//import SequenceDetect :: *;

// ================================================================

(* synthesize *)
module mkTestbench (Empty);

   SequenceDetect sequence_det <- seq_det;

   rule jare;
sequence_det.put(2961610498);
// 2961610498
// 2963183362
// sequence_det.put(2963183362);

	endrule

   rule rl_print_answer;
   				
      let x <- sequence_det.get;
      $display ("The answer is %0d.", x);
      $finish;
   endrule
endmodule

// ==================seq detection==============================================
//endpackage

//package SequenceDetect;

interface SequenceDetect;
   method Action put(Bit #(32) d);
   method ActionValue #(Bit #(32))  get;
endinterface : SequenceDetect



module seq_det (SequenceDetect);
   Reg #(Bit #(1)) rg_busy <- mkReg (0); 
   Reg #(Bit #(1)) rg_done <- mkReg (0); 
   Reg #(Bit #(32)) iData <- mkRegU;
   Reg #(Bit #(32)) oResult <- mkReg (0);
   Reg #(Bit #(3)) seqe <- mkReg (0);
   Reg #(Bit #(6)) itr <- mkReg (0);
   Reg #(Bool) is_present <- mkReg (True);

   rule detectSequence (rg_busy == True);
      Integer size = 3;
      for (Integer j = 0; j <32-size; j = j + 1)begin
         is_present <= True;
         for (Integer k = 0; j <size ; k = k + 1)begin
             if (iData[j+k] != seqe[k])
               is_present <= False;
         end
         if (is_present== True)
            oResult <= oResult +1;

      end
      itr <= 1;
   endrule 

   rule done_all (itr == 1);
         $display("out_data = %h",oResult);
         // $finish;
         rg_done <= 1;
   endrule 

   method Action put
    if ( rg_busy == 0 );
      /* Actions? */
      iData<= d;
      rg_busy <= 1;
      itr <= 31;

   endmethod : put



      method ActionValue #(Bit #(32)) get ()
         if (rg_done == 1);
            rg_busy <= 0;
            rg_done <= 0;
            return oResult;
      endmethod : get
 

endmodule : seq_det
endpackage

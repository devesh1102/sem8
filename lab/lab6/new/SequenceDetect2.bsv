package SequenceDetect;

// This is the skeletal code for an iterative sequence detector.
// Blanks which you need to fill are marked usually with /* */
// comments with a question in between.

// ---------------------------------------------------------------
// Library imports     
import GetPut :: *;
// ---------------------------------------------------------------

// ---------------------------------------------------------------
// Interface type definition
// The system will "put" input data values into the detector, and
// "get" responses from the detector as results. Observe that no
// low-level control signals have been declared with respect to
// the interface.

// interface SequenceDetect;
//    interface Put# (/* What is the input data type? */Bit #(32)) iData;
//    interface Get# (Bit #(32)) oResult;
// endinterface : SequenceDetect

interface SequenceDetect;
   method Action put(Bit #(32) d);
   method ActionValue #(Bit #(32))  get;
endinterface : SequenceDetect

// ---------------------------------------------------------------
// Module definition

module seq_det (SequenceDetect);
   // ------------------------------------------------------------
   // Submodules
   // The only submodules you require in this model are registers.
   // Instantiate all the registers you will need. I have added
   // the first one as an example

   // rg_busy is a register which holds a Bool value and is reset
   // to False
   // Reg #(Bool) rg_busy <- mkReg (False);
   // Reg #(Bool) rg_done <- mkReg (False);
   Reg #(Bit #(1)) rg_busy <- mkReg (0);
   Reg #(Bit #(1)) rg_done <- mkReg (0); 
   Reg #(Bit #(32)) inp_data <- mkRegU;
   Reg #(Bit #(32)) out_data <- mkReg(0);
   Reg #(Bit #(3)) seqq <- mkReg(0);
   Reg #(Bit #(6)) itr <- mkReg(0);
   // Reg #(Bit #(1)) equal <- mkRegU;


   //    rule rl_print_answer;
   //    $display ("out_data = %h", out_data);
   //    $finish;
   // endrule

   /* What other submodules do you require in this module? */

   // ------------------------------------------------------------
   // Rules -- define your rule(s) here. Before writing the rule
   // you need to answer the following questions:
   //
   // 1. Under what condition will the rule execute -- this
   // becomes the explicit or outer condition of the rule
   //
   // 2. What all actions will you do under that conditon? These
   // will be become statements inside the rule body. Refer to
   // Lec2 on how to write to registers.
   //
   // 3. Are some of the actions guarded by conditions inside the
   // rule? These become ifs guarding the actions

   rule detectSequence (itr>1);
      /* Actions? */
      // equal <= (inp_data[itr]~^seqq[2]) & (inp_data[itr-1]~^seqq[1]) & (inp_data[itr-2]~^seqq[0]);
      // $display("equal = %b",equal);
      // $display("seqq = %b",(inp_data[itr]~^seqq[2]) & (inp_data[itr-1]~^seqq[1]) & (inp_data[itr-2]~^seqq[0]));
      out_data <= (((inp_data[itr]~^seqq[2]) & (inp_data[itr-1]~^seqq[1]) & (inp_data[itr-2]~^seqq[0])) == 0) ? out_data : (out_data+1);
      // $display("out_data = %h",out_data);
      itr <= itr - 1;
   endrule 

   rule done_all (itr == 1);
   		// $display("out_data = %h",out_data);
   		// $finish;
         rg_done <= 1;
   endrule 

   // ------------------------------------------------------------
   // Interface definition
   // The last bit of code relates to defining what each method in
   // your interface does. If a method is of type Action or
   // ActionValue, writing the internals of a method is like
   // writing a rule. You need to answer the same questions. Only
   // for ActionValue methods, in addition, there will be a value
   // returned like you would do in a function. There is a third
   // type of method called value methods. These just return value
   // and do not have any side-effects.
   // ------------------------------------------------------------

   // interface Put iData;
   //    method Action put
   //       (/* Type of data? */Bit #(32) d) if (/* when can this method be called? */rg_busy == 0);
   //       /* Actions? */
   //       inp_data <= d;
   //       rg_busy <= 1;
   //       itr <= 31;

   //    endmethod : put
   // endinterface

   // interface Get oResult;
   //    method ActionValue #(Bit #(32)) get ()
   //       if (/* when can this method be called? */rg_done == 1);
   //       /* Actions? */
         
   //       rg_busy <= 0;
   //       rg_done <= 1;
   //       return out_data;
   //    endmethod : get
   // endinterface



      method Action put
         (/* Type of data? */Bit #(32) d) if (/* when can this method be called? */rg_busy == 0);
         /* Actions? */
         inp_data <= d;
         $display("data = %d",d);
         rg_busy <= 1;
         itr <= 31;
         out_data <= 0;
         rg_done <= 0;

      endmethod : put



      method ActionValue #(Bit #(32)) get ()
         if (/* when can this method be called? */rg_done == 1);
         /* Actions? */
         
         rg_busy <= 0;
         // rg_done <= 0;
         $display("out_data = %h",out_data);
         return out_data;
      endmethod : get
 

endmodule : seq_det
// ------------------------------------------------------------

endpackage : SequenceDetect

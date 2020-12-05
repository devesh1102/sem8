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

interface SequenceDetect;
  // interface Put# (/* What is the input data type? */) iData;///////////////////////////changed///////////////////////////
   //interface Put #(Bit #(32)) iData;
   //interface Get #(Bit #(32)) oResult;
   method Action put(Bit #(32) d);
   method ActionValue #(Bit #(32))  get;
endinterface : SequenceDetect

// ---------------------------------------------------------------
// Module definition

module mkSeqDet (SequenceDetect);
   // ------------------------------------------------------------
   // Submodules
   // The only submodules you require in this model are registers.
   // Instantiate all the registers you will need. I have added
   // the first one as an example

   // rg_busy is a register which holds a Bool value and is reset
   // to False
   Reg #(Bit#(1)) rg_busy <- mkReg (0);
   Reg #(Bit#(1)) rg_done <- mkReg (0);
   Reg #(Bit#(3)) s <- mkReg(0);
   Reg #(Bit#(32)) rg_out <- mkReg(0);
   Reg #(Bit#(32)) rg_in <- mkReg(0);
   Reg #(Bit#(1)) is_present <- mkReg (0);

   rule detectSequence (rg_busy == 0);
      /* Actions? */
      Integer size = 3;
      for (Integer j = 0; j <32-size; j = j + 1)begin
         is_present <= (1);
         for (Integer k = 0; k <size ; k = k + 1)begin
             if (rg_in[j+k] != s[k])
               is_present<= (0);
         end
         if (is_present== 1)
            rg_out <= rg_out +1;

      end
      rg_done<=1;
   
   endrule : detectSequence

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

   //interface Put iData;
      //method Action put #(Bit #(32)) 
      method Action put ;
      if (rg_busy == 0)
         rg_busy <=1;
         rg_input <=(2961610498);//inoput

      endmethod : put
   //endinterface

   //interface Get oResult;
     // method ActionValue #(Bit #(32)) get ()
     method ActionValue #(Bit #(32)) get ()
         if (rg_done == 1);
            rg_busy <= 0;
            rg_done <= 0;
            $display("out_data = %h",rg_out);
            rg_out<= 0;
         //oResult<= rg_out
         return rg_out;
         /* Actions? */
      endmethod : get
   //endinterface

endmodule : mkSeqDet
// ------------------------------------------------------------

endpackage : SequenceDetect

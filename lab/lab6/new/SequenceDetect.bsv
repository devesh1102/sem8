package SequenceDetect;
   
import GetPut :: *;

interface SequenceDetect;
   method Action put(Bit #(32) in_data);
   method ActionValue #(Bit #(32))  get;
endinterface : SequenceDetect


module my_seq (SequenceDetect);
   Reg #(Bit #(1)) rg_busy <- mkReg (0);
   Reg #(Bit #(1)) rg_done <- mkReg (0); 
   Reg #(Bit #(32)) rg_in <- mkReg(0);
   Reg #(Bit #(32)) rg_out <- mkReg(0);
   Reg #(Bit #(3)) sequen <- mkReg(0);
   Reg #(Bit #(6)) pointer <- mkReg(0);
   Reg #(Bit #(6)) k2 <- mkReg(0);
   Reg #(Bit#(1)) is_present <- mkReg (1);
   Reg #(Bit#(6)) size <- mkReg (3);

   //Integer size = 3;


   rule detectSequence (rg_busy == 1);
      


         //if (is_present== 1)
           // rg_out <= (is_present== 1) ? rg_out +1:rg_out;

      //end

     // rg_out <= (is_present== 1) ? rg_out +1:rg_out;
     //rg_out <= (((rg_in[pointer]~^sequen[0]) & (rg_in[pointer+1]~^sequen[1]) & (rg_in[pointer+2]~^sequen[2])) == 0) ? rg_out : (rg_out+1);
     rg_out <= (rg_in[pointer+size -1:pointer]==sequen)  ? rg_out +1: (rg_out);
      pointer <= pointer + 1;
      //$display("t8rhtkjbnskjfkjsdf= %b",rg_in[5:0]);
      //$display("t8rhtkjbnskjfkjsdf= %b",pointer);
   endrule : detectSequence

   rule done_all (pointer == 32 - size+1);
         rg_done <= 1;
   endrule 

      method Action put
         (/* Type of data? */Bit #(32) in_data) if (/* when can this method be called? */rg_busy == 0);
         /* Actions? */
         rg_in <= in_data;
         $display("data = %d",in_data);
         $display("seq = %d",sequen);
         pointer<=0;
         rg_busy <= 1;
         rg_out <= 0;
         rg_done <= 0;

      endmethod : put



      method ActionValue #(Bit #(32)) get ()
         if (/* when can this method be called? */rg_done == 1);
         /* Actions? */
         pointer<=0;
         rg_busy <= 0;
         rg_done <= 0;
         $display("out_data = %h",rg_out);
         return rg_out;
      endmethod : get
 

endmodule : my_seq
// ------------------------------------------------------------

endpackage : SequenceDetect

package SequenceDetect;
   
import GetPut :: *;

interface SequenceDetect;
   method Action put(Bit #(32) in_data);
   method ActionValue #(Bit #(32))  get;
endinterface : SequenceDetect


module seq_det (SequenceDetect);
   Reg #(Bit #(1)) rg_busy <- mkReg (0);
   Reg #(Bit #(1)) rg_done <- mkReg (0); 
   Reg #(Bit #(32)) rg_in <- mkRegU;
   Reg #(Bit #(32)) rg_out <- mkReg(0);
   Reg #(Bit #(3)) sequen <- mkReg(0);
   Reg #(Bit #(6)) itr <- mkReg(0);
   Reg #(Bit#(1)) is_present <- mkReg (0);
   Reg #(Bit#(3)) size <- mkReg (3);


   rule detectSequence (rg_busy == 1);
      /* Actions? */
      //Integer size = 3;
      //for (Integer j = 0; j <32-size; j = j + 1)begin
        // is_present <= (1);
         //for (Integer k = 0; k <size ; k = k + 1)begin
           //   is_present <= (rg_in[j+k] != sequen[k])?(0):is_present;
         //end
         //if (is_present== 1)
           // rg_out <= (is_present== 1) ? rg_out +1:rg_out;

      //end
     
     rg_out <= (((rg_in[itr]~^sequen[2]) & (rg_in[itr-1]~^sequen[1]) & (rg_in[itr-2]~^sequen[0])) == 0) ? rg_out : (rg_out+1);
      itr <= itr - 1;
   endrule : detectSequence

   rule done_all (itr == 1);
         // $display("out_data = %h",out_data);
         // $finish;
         rg_done <= 1;
   endrule 

      method Action put
         (/* Type of data? */Bit #(32) in_data) if (/* when can this method be called? */rg_busy == 0);
         /* Actions? */
         rg_in <= in_data;
         $display("data = %d",in_data);
         $display("seq = %d",sequen);
         itr<=31;
         rg_busy <= 1;
         rg_out <= 0;
         rg_done <= 0;

      endmethod : put



      method ActionValue #(Bit #(32)) get ()
         if (/* when can this method be called? */rg_done == 1);
         /* Actions? */
         itr<=0;
         rg_busy <= 0;
         rg_done <= 0;
         $display("out_data = %h",rg_out);
         return rg_out;
      endmethod : get
 

endmodule : seq_det
// ------------------------------------------------------------

endpackage : SequenceDetect

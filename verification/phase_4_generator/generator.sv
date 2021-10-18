`ifndef _GENERATOR_
`define _GENERATOR_
`include "transaction.sv"
class generator;
     transaction trans;

     // mailbox for sending packets to the driver
     mailbox gen2driv;

     // constructor
     function new(mailbox gen2driv);
         // get the mailbox handle from env
         this.gen2driv = gen2driv;
     endfunction

     task main();
         trans = new();
         trans.data_in <= 'h0A08;
         trans.addr_in <= 'h0102;
         trans.valid_in <= 'b1111;
         trans.data_read <= 'b1111;
         trans.display("[Generator]");
         gen2driv.put(trans);
     endtask
endclass
`endif // _GENERATOR_

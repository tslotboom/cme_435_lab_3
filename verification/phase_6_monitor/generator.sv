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

    // event to indicate the end of transaction generation
    event ended;

    // amount of packets generated
    int packets_generated;

    task main();
        trans = new();
        trans.data_in = 16'h0A08;
        trans.addr_in = 16'h0102;
        trans.valid_in = 4'b1111;
        trans.display("[Generator]");
        gen2driv.put(trans);
        packets_generated++;
    -> ended; // trigger the end of generation
    endtask
endclass
`endif // _GENERATOR_

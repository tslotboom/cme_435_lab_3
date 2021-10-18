`ifndef _GENERATOR_
`define _GENERATOR_
`include "transaction.sv"
class generator;
    bit [3:0] valid_in;
    bit [15:0] addr;
    bit [15:0] data;

    transaction trans;

    mailbox gen2driv;

    function new(mailbox gen2driv);
        this.gen2driv = gen2driv;
    endfunction

    // event to indicate the end of transaction generation
    event ended;

    int packets_generated;

    transaction transaction_queue[$] = {};

    task main();

        while(transaction_queue.size() > 0) begin
            gen2driv.put(transaction_queue.pop_back());
        end
    -> ended; // trigger the end of generation
    endtask

    function void generate_transaction(
            // transaction trans,
            bit [3:0] valid_in,
            bit [15:0] addr,
            bit [15:0] data);
        transaction trans = new();
        trans.valid_in = valid_in;
        trans.addr_in = addr;
        trans.data_in = data;
        trans.display("[Generator]");
        transaction_queue.push_front(trans);
        packets_generated++;
    endfunction
endclass
`endif // _GENERATOR_

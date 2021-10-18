`ifndef _TRANSACTION_
`define _TRANSACTION_
class transaction;
    bit     [15:0] data_in;
    bit     [15:0] addr_in;
    bit     [3:0]  valid_in;
    bit     [3:0]  data_read;

    bit     [3:0]  rcv_rdy;
    bit     [15:0] data_out;
    bit     [15:0] addr_out;
    bit     [3:0]  data_rdy;

    function void display(string name);
        $display("----------");
        $display("%s: data_in = %4h, addr_in = %4h", name, data_in, addr_in);
        $display("%s: valid_in = %4b, data_rdy = %4b", name, valid_in, data_rdy);
        $display("%s: data_out = %4h, addr_out = %4h", name, data_out, addr_out);
        $display("%s: rcv_rdy = %4b, data_read = %4b", name, rcv_rdy, data_read);
    endfunction
endclass
`endif //_TRANSACTION_

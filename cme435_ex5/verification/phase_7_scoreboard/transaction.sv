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
        $display("%s: Time = %0d", name, $time);
        $display("%s: rcv_rdy =     0b%4b", name, rcv_rdy);
        $display("%s: valid_in =    0b%4b", name, valid_in);
        $display("%s: addr_in =     0x%4h", name, addr_in);
        $display("%s: data_in =     0x%4h", name, data_in);
        $display("%s: data_out =    0x%4h", name, data_out);
        $display("%s: addr_out =    0x%4h", name, addr_out);
        $display("%s: data_rdy =    0b%4b", name, data_rdy);
        $display("%s: data_read =   0b%4b", name, data_read);
    endfunction
endclass
`endif //_TRANSACTION_

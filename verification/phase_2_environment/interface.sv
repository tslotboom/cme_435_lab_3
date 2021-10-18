`ifndef _INTERFACE_
`define _INTERFACE_
interface intf (
    input bit clk,
    input bit reset);
    logic   [15:0] 	data_in;
    logic   [15:0] 	addr_in;
    logic 	[3:0]  	rcv_rdy;
    logic	[3:0]  	valid_in;
    logic 	[15:0] 	data_out;
    logic 	[15:0] 	addr_out;
    logic   [3:0]  	data_read;
    logic 	[3:0]  	data_rdy;

    modport dut (
        input   data_in,
        input   addr_in,
        output  rcv_rdy,
        input   valid_in,
        output  data_out,
        output  addr_out,
        input   data_read,
        output  data_rdy,
        input clk,
        input reset
    );

endinterface
`endif // _INTERFACE_

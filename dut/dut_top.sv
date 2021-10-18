module dut_top(intf.dut i_intf);
    xswitch xsw(
	 i_intf.data_in,
     i_intf.addr_in,
     i_intf.rcv_rdy,
     i_intf.valid_in,
     i_intf.data_out,
     i_intf.addr_out,
     i_intf.data_read,
     i_intf.data_rdy,
     i_intf.reset,
     i_intf.clk
	);
endmodule : dut_top

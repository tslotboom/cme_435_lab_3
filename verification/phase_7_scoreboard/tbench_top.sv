`ifndef _TBENCH_TOP_
`define _TBENCH_TOP_
module tbench_top;
    bit clk = 1'b1;
    bit reset = 1'b0;

    always #5 clk = ~clk;

    always begin
        reset = 1;
        #2 reset = 0;
        wait(reset_trigger.triggered);
    end

    event reset_trigger;


    intf i_intf(clk, reset);

    test testbench(i_intf.driver, i_intf.monitor);

    dut_top dut(i_intf.dut);

    initial begin
    $dumpfile("dumpfile.vcd"); $dumpvars;
    end
endmodule
`endif // _TBENCH_TOP_

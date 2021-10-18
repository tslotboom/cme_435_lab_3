`ifndef _TBENCH_TOP_
`define _TBENCH_TOP_
module tbench_top;

    // clock and reset signal declaration
    bit clk;
    bit reset;

    // clock generation
    always #5 clk = ~clk;

    always begin
        reset = 1;
        #2 reset = 0;
        wait(reset_trigger.triggered);
    end

    // event for reset generation
    event reset_trigger;

    // create interface instance to connect DUT and testcase
    intf i_intf(clk, reset);
    // create testcase instance where interface handle is passed to test as an argument
    test testbench(i_intf.driver, i_intf.monitor);
    // create DUT instance where interface signals are connected to the DUT ports
    dut_top dut(i_intf.dut);

    initial begin
    $dumpfile("dumpfile.vcd"); $dumpvars;
    end
endmodule
`endif // _TBENCH_TOP_

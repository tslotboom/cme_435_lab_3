`ifndef _TEST_
`define _TEST_
`include "environment.sv"
program test(intf i_intf);
    environment env;

    initial begin
        env = new(i_intf, tbench_top.reset_trigger);

        $display("[Testbench]: Start of testcase(s) at %0d", $time);

        // call the run task in env, which in turn calls other test tasks
        env.run();
    end

    final
        $display("[Testbench]: End of testcase(s) at %0d", $time);
endprogram : test
`endif // _TEST_

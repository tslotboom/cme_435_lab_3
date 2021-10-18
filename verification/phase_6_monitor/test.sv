`ifndef _TEST_
`define _TEST_
`include "environment.sv"
program test(intf.driver intf_driv,
            intf.monitor intf_mon);
    environment env;

    initial begin
        env = new(intf_driv, intf_mon, tbench_top.reset_trigger);

        $display("[Testbench]: Start of testcase(s) at %0d", $time);

        // call the run task in env, which in turn calls other test tasks
        env.run();
    end

    final
        $display("[Testbench]: End of testcase(s) at %0d", $time);
endprogram : test
`endif // _TEST_

`ifndef _TEST_
`define _TEST_
`include "environment.sv"
program test(intf.driver intf_driv,
            intf.monitor intf_mon);
    environment env;

    initial begin
        env = new(intf_driv, intf_mon, tbench_top.reset_trigger);
        $display("[Testbench]: Start of testcase(s) at %0d", $time);
        env.gen.generate_transaction(
        4'b1111,
        16'h0000,
        16'h4321);
        env.gen.generate_transaction(
        4'b1111,
        16'h2200,
        16'h4321);
        env.gen.generate_transaction(
        4'b1111,
        16'h3303,
        16'h4321);

        // call the run task in env, which in turn calls other test tasks
        env.run();
    end

    final
        $display("[Testbench]: End of testcase(s) at %0d", $time);
endprogram : test
`endif // _TEST_

`ifndef _ENVIRONMENT_
`define _ENVIRONMENT_
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;

    virtual intf.driver vif_driver;
    virtual intf.monitor vif_monitor;

    event reset_trigger;

    generator gen;
    driver driv;
    monitor mon;
    scoreboard sb;

    mailbox gen2driv;
    mailbox mon2scb;

    int error_count;

    function new(virtual intf.driver vif_driver,
            virtual intf.monitor vif_monitor,
            event reset_trigger);
        this.vif_driver = vif_driver;
        this.vif_monitor = vif_monitor;

        gen2driv = new();
        mon2scb = new();

        gen = new(gen2driv);
        driv = new(vif_driver, gen2driv);
        mon = new(vif_monitor, mon2scb);
        sb = new(mon2scb);
    endfunction

    task pre_test();
        $display("[Environment]: Start of pre_test() at %0d", $time);
        reset();
        $display("[Environment]: End of pre_test() at %0d", $time);
    endtask

    task test();
        $display("[Environment]: Start of test() at %0d", $time);
        wait(gen.packets_generated > 0);
        @(vif_driver.driver_cb); // wait for testbench to generate packets
        fork
            gen.main();
            driv.main();
            mon.main();
            sb.main();
        join_any

        wait(gen.ended.triggered);
        wait(driv.packets_driven == gen.packets_generated);
        wait(sb.packets_checked == gen.packets_generated);
        error_count = sb.error_count;
        $display("[Environment]: End of test() at %0d", $time);
    endtask

    task post_test();
        $display("[Environment]: Start of post_test() at %0d", $time);
        $display("[Environment]: There were %0d errors.", error_count);
        $display("[Environment]: End of post_test() at %0d", $time);
    endtask

    task run();
      $display("[Environment]: Start of run() at %0d", $time);
      pre_test();
      test();
      post_test();
      $display("[Environment]: End of run() at %0d", $time);
      $finish;
    endtask

    task reset();
        -> reset_trigger;
        $display("[Environment]: Reset started at %0d", $time);
    endtask

endclass
`endif //_ENVIRONMENT_

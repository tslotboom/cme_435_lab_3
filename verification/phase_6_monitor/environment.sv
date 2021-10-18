`ifndef _ENVIRONMENT_
`define _ENVIRONMENT_
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"

class environment;

    // virtual interface
    virtual intf.driver vif_driver;
    virtual intf.monitor vif_monitor;

    // reset trigger
    event reset_trigger;

    // generator, driver, monitor and scoreboard instances
    generator gen;
    driver driv;
    monitor mon;

    // mailbox handles
    mailbox gen2driv;
    mailbox mon2scb;

    // constructor
    function new(virtual intf.driver vif_driver,
            virtual intf.monitor vif_monitor,
            event reset_trigger);
        // get the interfaces from test
        this.vif_driver = vif_driver;
        this.vif_monitor = vif_monitor;
        // create mailboxes for data exchange
        gen2driv = new();
        mon2scb = new();
        // create generator
        gen = new(gen2driv);
        driv = new(vif_driver, gen2driv);
        mon = new(vif_monitor, mon2scb);
    endfunction

    task pre_test();
        $display("[Environment]: Start of pre_test() at %0d", $time);
        reset();
        $display("[Environment]: End of pre_test() at %0d", $time);
    endtask

    task test();
        $display("[Environment]: Start of test() at %0d", $time);
        fork
            gen.main();
            driv.main();
            mon.main();
        join_any
        wait(gen.ended.triggered);
        wait(gen.packets_generated == driv.packets_driven);
        @(vif_monitor.monitor_cb);

        $display("[Environment]: End of test() at %0d", $time);
    endtask

    task post_test();
        $display("[Environment]: Start of post_test() at %0d", $time);
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

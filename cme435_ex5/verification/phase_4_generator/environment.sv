`ifndef _ENVIRONMENT_
`define _ENVIRONMENT_
`include "generator.sv"
class environment;

    // virtual interface
    virtual intf vif;

    // reset trigger
    event reset_trigger;

    // generator, driver, monitor and scoreboard instances
    generator gen;

    // mailbox handles
    mailbox gen2driv;

    // constructor
    function new(virtual intf vif, event reset_trigger);
        // get the interface from test
        this.vif = vif;
        // create mailbox(es) for data exchange
        gen2driv = new();
        // create generator
        gen = new(gen2driv);
    endfunction

    task pre_test();
        $display("[Environment]: Start of pre_test() at %0d", $time);
        reset();
        $display("[Environment]: End of pre_test() at %0d", $time);
    endtask

    task test();
        $display("[Environment]: Start of test() at %0d", $time);
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

`ifndef _DRIVER_
`define _DRIVER_
class driver;
    // create virtual interface handle
    virtual intf.driver vif_driver;

    // create mailbox handle
    mailbox gen2driv;

    // constuctor
    function new(virtual intf.driver vif_driver, mailbox gen2driv);
        // get the interface
        this.vif_driver = vif_driver;
        // get the mailbox handles from environment
        this.gen2driv = gen2driv;
    endfunction

    int packets_driven;

    task main;
        forever begin
            transaction trans;
            gen2driv.get(trans);
            @(vif_driver.driver_cb);
            vif_driver.driver_cb.data_in <= trans.data_in;
            vif_driver.driver_cb.addr_in <= trans.addr_in;
            vif_driver.driver_cb.valid_in <= trans.valid_in;
            @(vif_driver.driver_cb);
            trans.display("[Driver]");
            packets_driven++;
        end
    endtask
endclass
`endif // _DRIVER_

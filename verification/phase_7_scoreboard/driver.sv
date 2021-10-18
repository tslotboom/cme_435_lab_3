`ifndef _DRIVER_
`define _DRIVER_
class driver;
    virtual intf.driver vif_driver;

    mailbox gen2driv;

    function new(virtual intf.driver vif_driver, mailbox gen2driv);
        this.vif_driver = vif_driver;

        this.gen2driv = gen2driv;
    endfunction

    int packets_driven;

    task main;
        forever begin
            transaction trans;
            gen2driv.get(trans);
            trans.data_out = vif_driver.driver_cb.data_out;
            trans.addr_out = vif_driver.driver_cb.addr_out;
            trans.data_rdy = vif_driver.driver_cb.data_rdy;
            trans.data_read = vif_driver.driver_cb.data_read;
            trans.display("[Driver]");
            vif_driver.driver_cb.data_in <= trans.data_in;
            vif_driver.driver_cb.addr_in <= trans.addr_in;
            vif_driver.driver_cb.valid_in <= trans.valid_in;
            packets_driven++;
            @(vif_driver.driver_cb);
            @(vif_driver.driver_cb);
        end
    endtask
endclass
`endif // _DRIVER_

`ifndef _MONITOR_
`define _MONITOR_
class monitor;
    // create virtual interface handle
    virtual intf.monitor vif_monitor;

    // create mailbox handle
    mailbox mon2scb;

    // constructor
    function new (virtual intf.monitor vif_monitor, mailbox mon2scb);
        // get the interface
        this.vif_monitor = vif_monitor;
        // get the mailbox handles from enviroment
        this.mon2scb = mon2scb;
    endfunction

    task main;
        forever begin
            transaction trans;
            trans = new();
            @(vif_monitor.monitor_cb);
            wait(vif_monitor.monitor_cb.data_rdy)

            // DUT input stream
            trans.data_in = vif_monitor.monitor_cb.data_in;
            trans.addr_in = vif_monitor.monitor_cb.addr_in;
            trans.valid_in = vif_monitor.monitor_cb.valid_in;
            trans.rcv_rdy = vif_monitor.monitor_cb.rcv_rdy;

            // DUT output stream
            trans.addr_out = vif_monitor.monitor_cb.addr_out;
            trans.data_out = vif_monitor.monitor_cb.data_out;
            trans.data_rdy = vif_monitor.monitor_cb.data_rdy;

            vif_monitor.monitor_cb.data_read <= vif_monitor.monitor_cb.data_rdy;

            trans.data_read = vif_monitor.monitor_cb.data_read;
            mon2scb.put(trans);
            trans.display("[Monitor]");
        end
        // forever begin
        //     $monitor("Time: %d,
        //             data_in = %4h, addr_in = %4h\n
        //             valid_in = %4b, data_rdy = %4b\n
        //             data_out = %4h, addr_out = %4h\n
        //             rcv_rdy = %4b, data_read = %4b",
        //             $time,
        //             vif_monitor.monitor_cb.data_in, vif_monitor.monitor_cb.addr_in, vif_monitor.monitor_cb.valid_in, vif_monitor.monitor_cb.data_rdy,
        //             vif_monitor.monitor_cb.data_out, vif_monitor.monitor_cb.addr_out, vif_monitor.monitor_cb.rcv_rdy, vif_monitor.monitor_cb.data_read);
        // end
    endtask

endclass
`endif // _MONITOR_

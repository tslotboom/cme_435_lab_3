`ifndef _MONITOR_
`define _MONITOR_
class monitor;
    virtual intf.monitor vif_monitor;

    mailbox mon2scb;

    function new (virtual intf.monitor vif_monitor, mailbox mon2scb);
        this.vif_monitor = vif_monitor;

        this.mon2scb = mon2scb;
    endfunction

    task main;
        forever begin
            transaction trans;
            trans = new();
            @(vif_monitor.monitor_cb);

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
            @(vif_monitor.monitor_cb);
        end
    endtask

endclass
`endif // _MONITOR_

`ifndef _SCOREBOARD_
`define _SCOREBOARD_
class scoreboard;

    mailbox mon2scb;

    function new(mailbox mon2scb);
        this.mon2scb = mon2scb;
    endfunction

    bit expected_data_rdy;
    bit [3:0] expected_addr_out;
    bit [3:0] expected_data_out;
    bit actual_data_rdy;
    bit [3:0] actual_addr_out;
    bit [3:0] actual_data_out;

    int error_count;
    int packets_checked;


    task main;
        transaction trans;
        forever begin
            mon2scb.get(trans);
            trans.display("[Scoreboard]");
            // TODO: check that addr in is valid (ie not above 3)

            // logic for checking data_rdy
            $display("----------");
            for (int output_port = 0; output_port < 4; output_port++) begin
                if (trans.data_rdy[output_port] == 1'b1) begin
                    // if one of the addresses in addr_in matches the current
                    // output port, that means that valid_in must be on at the
                    // index of that address in addr_in
                    for (int input_port = 0; input_port < 4; input_port++) begin
                        if (trans.addr_in[input_port * 4 +:4] == output_port) begin
                            expected_data_rdy = trans.valid_in[input_port];
                            break;
                        end
                    end
                    expected_data_rdy = 1'b1;
                    // since we use valid in to check what ports we want to
                    // check, we have to use fancy logic to find the position of
                    // the data_rdy bit we want to check
                    actual_data_rdy = trans.data_rdy[output_port];
                    display_results("data_rdy", output_port, expected_data_rdy, actual_data_rdy);
                end
            end
            // logic for checking addr_out
            $display("----------");
            for (int output_port = 0; output_port < 4; output_port++) begin
                if (trans.data_rdy[output_port] == 1'b1) begin
                    // if one of the addresses in addr_in matches the current
                    // output port, that means that addr_out must be the
                    // index of that address in addr_in
                    for (int input_port = 0; input_port < 4; input_port++) begin
                        if (trans.addr_in[input_port * 4 +:4] == output_port) begin
                            expected_addr_out = input_port;
                            break;
                        end
                    end
                    actual_data_out = trans.addr_out[output_port * 4 +:4];
                    display_results("addr_out", output_port, expected_addr_out, actual_data_out);
                end
            end
            // logic for checking data_out
            $display("----------");
            for (int output_port = 0; output_port < 4; output_port++) begin
                if (trans.data_rdy[output_port] == 1'b1) begin
                    expected_data_out = trans.data_in[trans.addr_out[output_port * 4 +:4] * 4 +:4];
                    actual_data_out = trans.data_out[output_port * 4 +:4];
                    display_results("data_out", output_port, expected_data_out, actual_data_out);
                end
            end
            packets_checked++;
        end
    endtask

    function void display_results(string name, int port, int expected, int result);
        string result_string;
        if (expected == result)
            result_string = "SUCCESS";
        else begin
            result_string = "FAILURE";
            error_count++;
        end
        $display("[Scoreboard]: Output Port %0d - %s - expected %s = %1h, actual %s = %1h",
            port, result_string, name, expected, name, result);
    endfunction
endclass
`endif // _SCOREBOARD_

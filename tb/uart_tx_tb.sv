`timescale 1ns / 1ps

module uart_tx_tb ();

    reg       clock;
    reg       rst_n;
    reg       tx_valid;
    reg [7:0] tx_data;
    logic       bit_tick;
    reg       ks_bit;
    reg       tx_keyed;
    logic       tx_ready;
    logic       ks_consume;
    logic       txd;

    baud_gen baud (
        .clk     (clock),
        .rst_n   (rst_n),
        .bit_tick(bit_tick)
    );

    uart_tx tx_dut (
        .clk       (clock),
        .rst_n     (rst_n),
        .tx_valid  (tx_valid),
        .tx_data   (tx_data),
        .bit_tick  (bit_tick),
        .ks_bit    (ks_bit),
        .tx_keyed  (tx_keyed),
        .tx_ready  (tx_ready),
        .ks_consume(ks_consume),
        .txd       (txd)
    );

    integer       test = 0;
    integer       errors = 0;
    logic   [7:0] res;
    logic   [7:0] res2;
    integer       consumed = 0;
    logic busy = 0;

    initial clock = 0;
    always #5 clock = ~clock;

    initial begin
        #10000000 $display("TIMEOUT");
        $finish;
    end

    task automatic send(input logic [7:0] data);
        @(negedge clock);
        tx_data  = data;
        tx_valid = 1;
        do begin
            @(negedge clock);
        end while (tx_ready !== 1);
        @(negedge clock);
        tx_valid = 0;
        tx_data  = 8'hxx;
    endtask

    task automatic receive(output logic [7:0] result);
        @(negedge txd);
        busy = 1;
        repeat (8) @(negedge clock);
        if (txd !== 0) begin
            $error("Start bit not held");
            errors++;
        end
        for (int i = 0; i < 8; i++) begin
            repeat (16) @(negedge clock);
            result[i] = txd;
        end
        repeat (16) @(negedge clock);
        if (txd !== 1) begin
            $error("Stop bit not detected");
            errors++;
        end
        busy = 0;
    endtask

    task automatic tx_rx(input logic [7:0] data);
        res      = 8'hxx;
        consumed = 0;
        fork
            send(data);
            receive(res);
        join
        if (res !== (data ^ {8{ks_bit}})) begin
            $error("RX %h does not match TX %h", res, data);
            errors++;
        end
        if (consumed !== 8) begin
            $error("Improper number of cipher reads");
            errors++;
        end
    endtask


    always @(posedge clock) if (ks_consume) consumed++;
    always @(negedge clock) if (busy && tx_ready !== 0) begin
        $error("Ready when busy");
        errors++;
    end


    initial begin
        $dumpfile("build/uart_tx_tb.vcd");
        $dumpvars(0, uart_tx_tb);

        test++;
        rst_n    = 0;
        ks_bit   = 0;
        tx_keyed = 1;
        tx_valid = 0;
        tx_data  = 8'h00;


        repeat (3) @(negedge clock);
        test++;
        if (txd !== 1) begin
            $error("TXD not high after reset");
            errors++;
        end
        rst_n = 1;
        test++;
        tx_rx(8'h00);
        tx_rx(8'hC9);
        tx_rx(8'hFF);
        tx_rx(8'hD5);

        test++;
        ks_bit = 1;
        tx_rx(8'h00);
        tx_rx(8'hC9);
        tx_rx(8'hFF);
        tx_rx(8'hD5);
        ks_bit = 0;

        
        @(negedge clock);
        test++;
        tx_keyed = 0;
        tx_valid = 1;
        tx_data = 8'hC9;
        repeat (40) begin
            @(negedge clock);
            if (tx_ready !== 0 || txd !== 1) begin
                $error("TX incorrectly ready");
                errors++;
            end
        end
        tx_valid = 0;
        tx_keyed = 1;

        @(negedge clock);
        test++;

        fork
            begin
                send(8'hC9);
                send(8'hD5);
            end
            begin
                receive(res);
                receive(res2);
            end
        join

        if (res !== 8'hC9) begin
            $error("RX %h does not match TX 0xC9", res);
            errors++;
        end

        if (res2 !== 8'hD5) begin
            $error("RX %h does not match TX 0xD5", res2);
            errors++;
        end





        if (errors !== 0) $display("FAIL: %0d errors", errors);
        else $display("PASS");

        $finish;
    end



endmodule

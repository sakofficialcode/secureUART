`timescale 1ns/1ps

module lfsr_tb();

    reg clock;
    reg rst_n;
    reg clr;
    reg load_en;
    reg load_bit;
    reg step;
    reg out;
    reg [7:0] state;


    lfsr #(
        .W(8),
        .TAPS(8'hB8)
    ) BIST (
        .clk(clock),
        .rst_n(rst_n),
        .clr(clr),
        .load_en(load_en),
        .load_bit(load_bit),
        .step(step),
        .out(out),
        .state(state)
    );

    integer test = 0;
    integer errors = 0;
    integer iter;

    initial clock = 0;
    always #5 clock = ~clock;

    initial begin
        #10000000
        $display("TIMEOUT");
        $finish;
    end

    initial begin
        $dumpfile("build/lfsr_tb.vcd");
        $dumpvars(0, lfsr_tb);

        test++;
        rst_n = 0;
        clr = 0;
        load_en = 0;
        load_bit = 0;
        step = 0;

        @(negedge clock);
        @(negedge clock);
        @(negedge clock);
        if (state !== 8'h01) begin
            $display("FAIL: Test %d", test);
            errors++;
        end

        rst_n = 1;

        test++;


        load_en = 0;
        load_bit = 0;

        step = 1;
        iter = 0;
        do begin
            @(negedge clock);
            iter++;
        end while (state !== 8'h01);
        if (iter !== 255) begin
            $display("FAIL");
            errors++;
        end

        rst_n = 0;
        @(negedge clock);
        @(negedge clock);
        @(negedge clock);
        rst_n = 1;

        test++;

        load_en = 1;
        step = 0;

        load_bit = 0;
        @(negedge clock);
        if (state !== 8'h02) begin
            $display("FAIL");
            errors++;
        end

        load_bit = 1;
        @(negedge clock);
        if (state !== 8'h05) begin
            $display("FAIL");
            errors++;
        end

        load_bit = 1;
        @(negedge clock);
        if (state !== 8'h0B) begin
            $display("FAIL");
            errors++;
        end

        load_bit = 0;
        @(negedge clock);
        if (state !== 8'h16) begin
            $display("FAIL");
            errors++;
        end

        load_bit = 1;
        @(negedge clock);
        if (state !== 8'h2D) begin
            $display("FAIL");
            errors++;
        end

        load_bit = 1;
        @(negedge clock);
        if (state !== 8'h5B) begin
            $display("FAIL");
            errors++;
        end

        load_bit = 1;
        @(negedge clock);
        if (state !== 8'hB7) begin
            $display("FAIL");
            errors++;
        end

        load_bit = 1;
        @(negedge clock);
        if (state !== 8'h6F) begin
            $display("FAIL");
            errors++;
        end

        $finish;
    end



endmodule

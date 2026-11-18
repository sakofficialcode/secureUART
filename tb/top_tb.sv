`timescale 1ns / 1ps
`default_nettype none

// Two-chip system test. chip_a.uart_txd -> chip_b.uart_rxd and back.
// chip_b's clock is ~1% slow so RX has to align to a foreign baud phase.
module top_tb ();

    localparam logic [31:0] K1 = 32'hC0FF_EE42;  // A.tx -> B.rx
    localparam logic [31:0] K2 = 32'h1234_5679;  // B.tx -> A.rx
    localparam logic [31:0] K3 = {15'h4000, 17'h1ABCD};  // S = 4000: 1, then 14 zeros (worst case)
    localparam int N = 16;  // duplex bytes per direction

    logic clk_a, clk_b;
    logic [1:0] rst_n;
    logic [1:0] tx_valid;
    logic [1:0][7:0] tx_data;
    logic [1:0] key_in, key_load, key_sel, scan_en, bist_start;
    wire  [1:0] tx_ready, uart_txd, rx_valid, rx_err, bist_done, bist_pass;
    wire  [7:0] rx_data_a, rx_data_b;

    // Line injection on chip_b's RX input (glitch / framing-error tests)
    logic inj_en, inj_line;
    wire  b_rxd = inj_en ? inj_line : uart_txd[0];

    top chip_a (
        .clk       (clk_a),
        .rst_n     (rst_n[0]),
        .tx_valid  (tx_valid[0]),
        .tx_data   (tx_data[0]),
        .tx_ready  (tx_ready[0]),
        .uart_txd  (uart_txd[0]),
        .uart_rxd  (uart_txd[1]),
        .rx_data   (rx_data_a),
        .rx_valid  (rx_valid[0]),
        .rx_err    (rx_err[0]),
        .key_in    (key_in[0]),
        .key_load  (key_load[0]),
        .key_sel   (key_sel[0]),
        .scan_en   (scan_en[0]),
        .bist_start(bist_start[0]),
        .bist_done (bist_done[0]),
        .bist_pass (bist_pass[0])
`ifdef GLS
        ,
        .scan_in   (1'b0),
        .scan_out  ()
`endif
    );

    top chip_b (
        .clk       (clk_b),
        .rst_n     (rst_n[1]),
        .tx_valid  (tx_valid[1]),
        .tx_data   (tx_data[1]),
        .tx_ready  (tx_ready[1]),
        .uart_txd  (uart_txd[1]),
        .uart_rxd  (b_rxd),
        .rx_data   (rx_data_b),
        .rx_valid  (rx_valid[1]),
        .rx_err    (rx_err[1]),
        .key_in    (key_in[1]),
        .key_load  (key_load[1]),
        .key_sel   (key_sel[1]),
        .scan_en   (scan_en[1]),
        .bist_start(bist_start[1]),
        .bist_done (bist_done[1]),
        .bist_pass (bist_pass[1])
`ifdef GLS
        ,
        .scan_in   (1'b0),
        .scan_out  ()
`endif
    );

    // 1.8432 MHz ~= 542.5 ns; chip_b ~1% slower
    initial begin
        clk_a = 0;
        forever #271.25 clk_a = ~clk_a;
    end
    initial begin
        clk_b = 0;
        forever #274 clk_b = ~clk_b;
    end

    initial begin
        #400_000_000 $display("TIMEOUT");
        $finish;
    end

    integer errors = 0;

    // ---------------------------------------------------------------- helpers

    task automatic check(input logic cond, input string msg);
        if (cond !== 1'b1) begin
            $error("%s", msg);
            errors++;
        end
    endtask

    task automatic tick(input int c);
        if (c == 0) @(negedge clk_a);
        else @(negedge clk_b);
    endtask

    task automatic ticks(input int c, input int n);
        repeat (n) tick(c);
    endtask

    // Shift a 32-bit key in MSB first, one bit per clock. sel: 0 = TX core, 1 = RX core
    task automatic load_key(input int c, input logic sel, input logic [31:0] key);
        tick(c);
        key_sel[c]  = sel;
        key_load[c] = 1;
        for (int i = 31; i >= 0; i--) begin
            key_in[c] = key[i];
            tick(c);
        end
        key_load[c] = 0;
        key_in[c]   = 0;
    endtask

    task automatic send(input int c, input logic [7:0] data);
        tick(c);
        tx_data[c]  = data;
        tx_valid[c] = 1;
        do tick(c); while (tx_ready[c] !== 1);
        tick(c);
        tx_valid[c] = 0;
    endtask

    // Hold tx_valid and check TX never becomes ready and the line stays idle
    task automatic expect_tx_blocked(input int c, input string msg);
        tick(c);
        tx_data[c]  = 8'hA5;
        tx_valid[c] = 1;
        repeat (48) begin
            tick(c);
            check(tx_ready[c] === 0 && uart_txd[c] === 1, msg);
        end
        tx_valid[c] = 0;
    endtask

    task automatic reset_chip(input int c);
        tick(c);
        rst_n[c] = 0;
        ticks(c, 3);
        rst_n[c] = 1;
    endtask

    task automatic run_bist(input int c);
        tick(c);
        bist_start[c] = 1;
        tick(c);
        bist_start[c] = 0;
        for (int i = 0; i < 80000 && bist_done[c] !== 1; i++) tick(c);
        check(bist_done[c] === 1, "BIST never finished");
    endtask

    // Low pulse on chip_b's line shorter than half a bit
    task automatic glitch_b(input int len);
        tick(1);
        inj_line = 0;
        inj_en   = 1;
        ticks(1, len);
        inj_line = 1;
        ticks(1, 4);
        inj_en = 0;
    endtask

    // Full frame onto chip_b's line with a 0 stop bit
    task automatic bad_frame_b(input logic [7:0] bits);
        tick(1);
        inj_en   = 1;
        inj_line = 0;
        ticks(1, 16);
        for (int i = 0; i < 8; i++) begin
            inj_line = bits[i];
            ticks(1, 16);
        end
        inj_line = 0;
        ticks(1, 16);
        inj_line = 1;
        ticks(1, 16);
        inj_en = 0;
    endtask

    // --------------------------------------------------------------- monitors

    // Pin-level receive logs
    integer n_rx_a = 0, n_rx_b = 0, n_err_a = 0, n_err_b = 0;
    logic [7:0] got_a[64];
    logic [7:0] got_b[64];

    always @(posedge clk_a) begin
        if (rx_valid[0]) begin
            got_a[n_rx_a] = rx_data_a;
            n_rx_a++;
        end
        if (rx_err[0]) n_err_a++;
    end

    always @(posedge clk_b) begin
        if (rx_valid[1]) begin
            got_b[n_rx_b] = rx_data_b;
            n_rx_b++;
        end
        if (rx_err[1]) n_err_b++;
    end

    // Keystream bit must always be ready when TX/RX consumes it
    // Not checked while scan-locked: in the netlist, scan_en really shifts the chain,
    // so TX/RX FSMs can land mid-frame and consume from the wiped cipher until reset.
    // That is expected (spec: reset + re-key after scan); RTL has no chain to shift.
    wire scan_locked_a = chip_a.scan_en || chip_a.sec.scan_force_rst_q;
    wire scan_locked_b = chip_b.scan_en || chip_b.sec.scan_force_rst_q;
    always @(posedge clk_a) begin
        if (!scan_locked_a && chip_a.tx_ks_consume && chip_a.tx_cipher.ks_ready !== 1) begin
            $error("chip_a TX consumed keystream before it was ready (ks_ready=%b keyed=%b sec_clr=%b rst_n=%b uart_rxd=%b rxd_s=%b tx_ks_consume=%b)",
                   chip_a.tx_cipher.ks_ready, chip_a.tx_cipher.keyed, chip_a.sec_clr,
                   chip_a.rst_n, chip_a.uart_rxd, chip_a.rxd_s, chip_a.tx_ks_consume);
            errors++;
        end
        if (!scan_locked_a && chip_a.rx_ks_consume && chip_a.rx_cipher.ks_ready !== 1) begin
            $error("chip_a RX consumed keystream before it was ready (ks_ready=%b keyed=%b sec_clr=%b rst_n=%b uart_rxd=%b rxd_s=%b tx_ks_consume=%b)",
                   chip_a.rx_cipher.ks_ready, chip_a.rx_cipher.keyed, chip_a.sec_clr,
                   chip_a.rst_n, chip_a.uart_rxd, chip_a.rxd_s, chip_a.tx_ks_consume);
            errors++;
        end
    end

    always @(posedge clk_b) begin
        if (!scan_locked_b && chip_b.tx_ks_consume && chip_b.tx_cipher.ks_ready !== 1) begin
            $error("chip_b TX consumed keystream before it was ready (ks_ready=%b keyed=%b sec_clr=%b rst_n=%b uart_rxd=%b rxd_s=%b tx_ks_consume=%b)",
                   chip_b.tx_cipher.ks_ready, chip_b.tx_cipher.keyed, chip_b.sec_clr,
                   chip_b.rst_n, chip_b.uart_rxd, chip_b.rxd_s, chip_b.tx_ks_consume);
            errors++;
        end
        if (!scan_locked_b && chip_b.rx_ks_consume && chip_b.rx_cipher.ks_ready !== 1) begin
            $error("chip_b RX consumed keystream before it was ready (ks_ready=%b keyed=%b sec_clr=%b rst_n=%b uart_rxd=%b rxd_s=%b tx_ks_consume=%b)",
                   chip_b.rx_cipher.ks_ready, chip_b.rx_cipher.keyed, chip_b.sec_clr,
                   chip_b.rst_n, chip_b.uart_rxd, chip_b.rxd_s, chip_b.tx_ks_consume);
            errors++;
        end
    end

    // Longest search (steps from one captured bit to the next) in chip_a's TX core
    integer run_a = 0, max_run_a = 0;
    always @(posedge clk_a) begin
        if (chip_a.tx_cipher.step) begin
            if (chip_a.tx_cipher.s_out) begin
                if (run_a + 1 > max_run_a) max_run_a = run_a + 1;
                run_a = 0;
            end else run_a++;
        end
    end

    // Keystream consumes in chip_b's RX core (false start must not consume)
    integer cons_b = 0;
    always @(posedge clk_b) if (chip_b.rx_ks_consume) cons_b++;

    // BIST must keep uart_txd idle
    always @(posedge clk_a) begin
        if (chip_a.bist_active && uart_txd[0] !== 1) begin
            $error("uart_txd moved during BIST");
            errors++;
        end
    end

    // Sniff the A->B wire to prove it carries ciphertext
    logic sniff_en = 0;
    integer n_wire = 0;
    logic [7:0] sniff_byte;
    logic [7:0] wire_ab[64];

    always begin
        @(negedge uart_txd[0]);
        if (sniff_en) begin
            repeat (8) @(negedge clk_a);
            for (int i = 0; i < 8; i++) begin
                repeat (16) @(negedge clk_a);
                sniff_byte[i] = uart_txd[0];
            end
            repeat (16) @(negedge clk_a);
            wire_ab[n_wire] = sniff_byte;
            n_wire++;
        end
    end

    // ------------------------------------------------------------------ tests

    logic [7:0] sent_ab[N];
    logic [7:0] sent_ba[N];
    integer base_rx, base_err, base_cons, n_diff;

    initial begin
        if ($test$plusargs("vcd")) begin
            $dumpfile("build/top_tb.vcd");
            $dumpvars(0, top_tb);
        end

        rst_n      = 0;
        tx_valid   = 0;
        tx_data    = 0;
        key_in     = 0;
        key_load   = 0;
        key_sel    = 0;
        scan_en    = 0;
        bist_start = 0;
        inj_en     = 0;
        inj_line   = 1;

        // 1. Reset
        ticks(0, 3);
        check(uart_txd === 2'b11, "uart_txd not idle after reset");
        check(tx_ready === 2'b00, "tx_ready high after reset");
        check(bist_done === 2'b00, "bist_done high after reset");
        rst_n = 2'b11;

        // 2. No key -> TX blocked
        expect_tx_blocked(0, "TX ready before a key was loaded");

        // 3. Cross-keyed: A.tx == B.rx, B.tx == A.rx
        load_key(0, 0, K1);
        load_key(0, 1, K2);
        load_key(1, 0, K2);
        load_key(1, 1, K1);
        check(chip_a.tx_keyed === 1 && chip_b.tx_keyed === 1, "keyed not set after key load");

        // 4. Full duplex, random bytes both directions at once
        for (int i = 0; i < N; i++) begin
            sent_ab[i] = $urandom;
            sent_ba[i] = $urandom;
        end
        n_rx_a   = 0;
        n_rx_b   = 0;
        n_wire   = 0;
        sniff_en = 1;
        fork
            begin
                for (int i = 0; i < N; i++) send(0, sent_ab[i]);
            end
            begin
                for (int i = 0; i < N; i++) send(1, sent_ba[i]);
            end
        join
        ticks(0, 400);
        sniff_en = 0;

        check(n_rx_b == N, "chip_b received wrong number of bytes");
        check(n_rx_a == N, "chip_a received wrong number of bytes");
        for (int i = 0; i < N; i++) begin
            if (got_b[i] !== sent_ab[i]) begin
                $error("A->B byte %0d: got %h expected %h", i, got_b[i], sent_ab[i]);
                errors++;
            end
            if (got_a[i] !== sent_ba[i]) begin
                $error("B->A byte %0d: got %h expected %h", i, got_a[i], sent_ba[i]);
                errors++;
            end
        end
        check(n_err_a == 0 && n_err_b == 0, "framing error during duplex");

        n_diff = 0;
        for (int i = 0; i < n_wire; i++) if (wire_ab[i] !== sent_ab[i]) n_diff++;
        check(n_wire == N, "sniffer saw wrong number of frames");
        check(n_diff > N / 2, "wire looks like plaintext");
        $display("duplex: %0d/%0d bytes each way, %0d/%0d wire frames differ from plaintext", n_rx_b,
                 N, n_diff, n_wire);

        // 5. False start: glitch must be ignored without consuming keystream
        base_rx   = n_rx_b;
        base_err  = n_err_b;
        base_cons = cons_b;
        glitch_b(4);
        ticks(1, 40);
        check(n_rx_b == base_rx && n_err_b == base_err, "glitch produced a byte or an error");
        check(cons_b == base_cons, "glitch consumed keystream");
`ifdef GLS
        // Netlist: state_q[0] -> net state_q_0_, state_q[1] -> renamed test_so1 by DFT
        check({chip_b.rx.test_so1, chip_b.rx.state_q_0_} === 2'b00,
              "RX did not return to IDLE after glitch");
`else
        check(chip_b.rx.state_q === 2'b00, "RX did not return to IDLE after glitch");
`endif
        send(0, 8'h3C);
        ticks(0, 200);
        check(n_rx_b == base_rx + 1 && got_b[base_rx] === 8'h3C, "link out of sync after glitch");

        // 6. Worst-case keystream gap (15 steps between captures)
        load_key(0, 0, K3);
        load_key(1, 1, K3);
        max_run_a = 0;
        base_rx   = n_rx_b;
        send(0, 8'h00);
        send(0, 8'hFF);
        send(0, 8'hC9);
        send(0, 8'hD5);
        ticks(0, 200);
        check(n_rx_b == base_rx + 4, "worst-case key: bytes lost");
        check(got_b[base_rx] === 8'h00 && got_b[base_rx+1] === 8'hFF &&
              got_b[base_rx+2] === 8'hC9 && got_b[base_rx+3] === 8'hD5,
              "worst-case key: wrong bytes");
        check(max_run_a == 15, "worst-case key did not hit the 15-step gap");
        $display("worst case: longest keystream search = %0d steps", max_run_a);

        // 7. Framing error (desyncs chip_b RX keystream; re-keyed later)
        base_rx  = n_rx_b;
        base_err = n_err_b;
        bad_frame_b(8'h5A);
        ticks(1, 20);
        check(n_err_b == base_err + 1, "bad stop bit did not raise rx_err");
        check(n_rx_b == base_rx, "bad stop bit produced rx_valid");

        // 8. BIST on chip_a: pass, nothing leaks to pins or to chip_b
        base_rx = n_rx_b;
        n_rx_a  = 0;
        run_bist(0);
        check(bist_pass[0] === 1, "BIST failed on good RTL");
        check(n_rx_a == 0, "rx_valid pin pulsed during BIST");
        check(n_rx_b == base_rx, "chip_b received data during chip_a BIST");
        ticks(0, 100);
        check(bist_done[0] === 1 && bist_pass[0] === 1, "BIST result not sticky");
        expect_tx_blocked(0, "TX usable after BIST without re-key");

        // 9. BIST with a stuck-at-1 fault in chip_a's RX cipher
        force chip_a.rx_cipher.a_out = 1;
        run_bist(0);
        check(bist_pass[0] === 0, "BIST passed with an injected fault");
        release chip_a.rx_cipher.a_out;

        // 10. Scan security on chip_a
        load_key(0, 0, K1);
        check(chip_a.tx_keyed === 1, "re-key failed");
        tick(0);
        scan_en[0] = 1;
        ticks(0, 4);
        check(chip_a.tx_cipher.A.state === 17'h1C94B &&
              chip_a.tx_cipher.S.state === 15'h70AE,
              "TX cipher not cleared to seed in scan");
        check(chip_a.rx_cipher.A.state === 17'h1C94B && chip_a.rx_cipher.S.state === 15'h70AE,
              "RX cipher not cleared to seed in scan");
        check(chip_a.tx_keyed === 0, "keyed still set in scan");
        scan_en[0] = 0;
        load_key(0, 0, K1);
        check(chip_a.tx_keyed === 0, "key load accepted after scan without reset");
        expect_tx_blocked(0, "TX usable after scan without reset");

        reset_chip(0);
        load_key(0, 0, K1);
        load_key(1, 1, K1);
        check(chip_a.tx_keyed === 1, "re-key after reset failed");
        base_rx = n_rx_b;
        send(0, 8'h77);
        ticks(0, 200);
        check(n_rx_b == base_rx + 1 && got_b[base_rx] === 8'h77, "link broken after scan + reset");

        if (errors !== 0) $display("FAIL: %0d errors", errors);
        else $display("PASS");
        $finish;
    end

endmodule

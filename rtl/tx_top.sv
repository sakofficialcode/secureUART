`default_nettype none
module tx_top(
    input logic clk, rst_n,
    input logic tx_valid,
    input logic [7:0] tx_data,
    input logic ks_bit,
    input logic tx_keyed,
    output logic tx_ready,
    output logic ks_consume,
    output logic txd
);

    logic bit_tick;

    baud_gen baud (
        .clk     (clk),
        .rst_n   (rst_n),
        .bit_tick(bit_tick)
    );

    uart_tx tx (
        .clk       (clk),
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

endmodule

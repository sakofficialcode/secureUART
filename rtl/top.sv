`default_nettype none
module top #(
    parameter logic [7:0] GOLDEN = 8'h51,
    parameter logic [7:0] LAST   = 8'h51
) (
    input logic clk,
    input logic rst_n,

    input  logic       tx_valid,
    input  logic [7:0] tx_data,
    output logic       tx_ready,
    output logic       uart_txd,

    input  logic       uart_rxd,
    output logic [7:0] rx_data,
    output logic       rx_valid,
    output logic       rx_err,

    input logic key_in,
    input logic key_load,
    input logic key_sel,

    input logic scan_en,

    input  logic bist_start,
    output logic bist_done,
    output logic bist_pass
);

    logic       bit_tick;

    logic       tx_valid_w;
    logic [7:0] tx_data_w;
    logic       tx_keyed_w;
    logic       tx_ready_w;
    logic       txd_w;
    logic       tx_ks_bit;
    logic       tx_ks_consume;
    logic       tx_keyed;

    logic       rxd_raw;
    logic       rxd_s;
    logic [7:0] rx_data_w;
    logic       rx_valid_w;
    logic       rx_err_w;
    logic       rx_ks_bit;
    logic       rx_ks_consume;

    logic       tx_key_load;
    logic       rx_key_load;
    logic       key_bit;
    logic       sec_clr;

    logic       bist_active;
    logic       bist_clr;
    logic [7:0] b_tx_data;
    logic       b_tx_valid;

    baud_gen baud (
        .clk     (clk),
        .rst_n   (rst_n),
        .bit_tick(bit_tick)
    );

    uart_tx tx (
        .clk       (clk),
        .rst_n     (rst_n),
        .tx_valid  (tx_valid_w),
        .tx_data   (tx_data_w),
        .bit_tick  (bit_tick),
        .ks_bit    (tx_ks_bit),
        .tx_keyed  (tx_keyed_w),
        .tx_ready  (tx_ready_w),
        .ks_consume(tx_ks_consume),
        .txd       (txd_w)
    );

    sync_2ff sync (
        .clk  (clk),
        .rst_n(rst_n),
        .d    (rxd_raw),
        .q    (rxd_s)
    );

    uart_rx rx (
        .clk       (clk),
        .rst_n     (rst_n),
        .rx_in     (rxd_s),
        .ks_bit    (rx_ks_bit),
        .rx_data   (rx_data_w),
        .rx_valid  (rx_valid_w),
        .rx_err    (rx_err_w),
        .ks_consume(rx_ks_consume)
    );

    sec_ctrl sec (
        .clk        (clk),
        .rst_n      (rst_n),
        .key_in     (key_in),
        .key_load   (key_load),
        .key_sel    (key_sel),
        .scan_en    (scan_en),
        .bist_clr   (bist_clr),
        .tx_key_load(tx_key_load),
        .rx_key_load(rx_key_load),
        .key_bit    (key_bit),
        .sec_clr    (sec_clr)
    );

    sg_cipher tx_cipher (
        .clk       (clk),
        .rst_n     (rst_n),
        .clr       (sec_clr),
        .key_load  (tx_key_load),
        .key_in    (key_bit),
        .ks_consume(tx_ks_consume),
        .ks_bit    (tx_ks_bit),
        .ks_ready  (),
        .keyed     (tx_keyed)
    );

    sg_cipher rx_cipher (
        .clk       (clk),
        .rst_n     (rst_n),
        .clr       (sec_clr),
        .key_load  (rx_key_load),
        .key_in    (key_bit),
        .ks_consume(rx_ks_consume),
        .ks_bit    (rx_ks_bit),
        .ks_ready  (),
        .keyed     ()
    );

    bist_ctrl #(
        .GOLDEN(GOLDEN),
        .LAST  (LAST)
    ) bist (
        .clk        (clk),
        .rst_n      (rst_n),
        .bit_tick   (bit_tick),
        .tx_ready   (tx_ready_w),
        .rx_data    (rx_data_w),
        .rx_valid   (rx_valid_w),
        .rx_err     (rx_err_w),
        .bist_start (bist_start),
        .bist_active(bist_active),
        .bist_clr   (bist_clr),
        .b_tx_data  (b_tx_data),
        .b_tx_valid (b_tx_valid),
        .bist_done  (bist_done),
        .bist_pass  (bist_pass)
    );

    assign tx_valid_w = bist_active ? b_tx_valid : tx_valid;
    assign tx_data_w  = bist_active ? b_tx_data : tx_data;

    assign tx_keyed_w = tx_keyed || bist_active;

    assign rxd_raw    = bist_active ? txd_w : uart_rxd;

    assign uart_txd   = bist_active ? 1'b1 : txd_w;
    assign tx_ready   = tx_ready_w && !bist_active;
    assign rx_valid   = rx_valid_w && !bist_active;
    assign rx_err     = rx_err_w && !bist_active;
    assign rx_data    = rx_data_w;

endmodule

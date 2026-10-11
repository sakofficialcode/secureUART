module top (
    input logic clk,
    input logic rst_n,

    input  logic       tx_valid,
    input  logic [7:0] tx_data,
    output logic       tx_ready,
    input  logic       rx_valid,
    output logic [7:0] rx_data,

    input logic key_in,
    input logic key_load,

    input  logic scan_en,
    input  logic scan_in,
    output logic scan_out,

    input  logic bist_start,
    output logic bist_done,
    output logic bist_pass
);

endmodule

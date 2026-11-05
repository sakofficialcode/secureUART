`default_nettype none
module sec_ctrl (
    input  logic clk,
    input  logic rst_n,
    input  logic key_in,
    input  logic key_load,
    input  logic key_sel,
    input  logic scan_en,
    input  logic bist_clr,
    output logic tx_key_load,
    output logic rx_key_load,
    output logic key_bit,
    output logic sec_clr
);

    logic scan_force_rst_d;
    logic scan_force_rst_q;

    always_comb begin
        scan_force_rst_d = scan_en || scan_force_rst_q;
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            scan_force_rst_q <= 1'b0;
        end else begin
            scan_force_rst_q <= scan_force_rst_d;
        end
    end

    assign tx_key_load = !key_sel && key_load;
    assign rx_key_load = key_sel && key_load;
    assign key_bit     = key_in;
    assign sec_clr     = bist_clr || scan_en || scan_force_rst_q;

endmodule

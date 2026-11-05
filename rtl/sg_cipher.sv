`default_nettype none
module sg_cipher (
    input  logic clk,
    input  logic rst_n,
    input  logic clr,
    input  logic key_load,
    input  logic key_in,
    input  logic ks_consume,
    output logic ks_bit,
    output logic ks_ready,
    output logic keyed
);

    logic ks_bit_d;
    logic ks_bit_q;
    logic ks_ready_d;
    logic ks_ready_q;
    logic keyed_d;
    logic keyed_q;





    logic a_out;
    logic s_out;
    logic step;
    logic busy;

    lfsr #(
        .W   (17),
        .TAPS(17'h12000),
        .SEED(17'h1C94B)
    ) A (
        .clk     (clk),
        .rst_n   (rst_n),
        .clr     (clr),
        .load_en (key_load),
        .load_bit(key_in),
        .step    (step),
        .out     (a_out),
        .state   ()
    );

    lfsr #(
        .W   (15),
        .TAPS(15'h6000),
        .SEED(15'h70AE)
    ) S (
        .clk     (clk),
        .rst_n   (rst_n),
        .clr     (clr),
        .load_en (key_load),
        .load_bit(a_out),
        .step    (step),
        .out     (s_out),
        .state   ()
    );

    always_comb begin
        ks_bit_d   = ks_bit_q;
        keyed_d    = keyed_q;
        ks_ready_d = ks_ready_q;



        if (clr) begin
            ks_bit_d   = 1'b0;
            ks_ready_d = 1'b0;
            keyed_d    = 1'b0;
        end else if (key_load) begin
            ks_ready_d = 1'b0;
            keyed_d    = 1'b1;
        end else if (busy) begin
            if (s_out == 1) begin
                ks_bit_d   = a_out;
                ks_ready_d = 1'b1;
            end else begin
                ks_ready_d = 1'b0;
            end

        end
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ks_bit_q   <= 1'b0;
            ks_ready_q <= 1'b0;
            keyed_q    <= 1'b0;
        end else begin
            ks_bit_q   <= ks_bit_d;
            ks_ready_q <= ks_ready_d;
            keyed_q    <= keyed_d;
        end
    end

    assign busy     = !ks_ready_q || ks_consume;
    assign step     = busy && !key_load && !clr;


    assign ks_bit   = ks_bit_q;
    assign ks_ready = ks_ready_q;
    assign keyed    = keyed_q;


endmodule

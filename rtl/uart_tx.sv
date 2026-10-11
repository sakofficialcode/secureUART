`default_nettype none
module uart_tx (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       tx_valid,
    input  logic [7:0] tx_data,
    input  logic       bit_tick,
    input  logic       ks_bit,
    input  logic       tx_keyed,
    output logic       tx_ready,
    output logic       ks_consume,
    output logic       txd
);

    localparam logic [1:0] IDLE  = 2'b00;
    localparam logic [1:0] START = 2'b01;
    localparam logic [1:0] DATA  = 2'b11;
    localparam logic [1:0] STOP  = 2'b10;

    logic [1:0] state_d;
    logic [1:0] state_q;
    logic [2:0] bit_cnt_d;
    logic [2:0] bit_cnt_q;
    logic [7:0] data_reg_d;
    logic [7:0] data_reg_q;
    logic       txd_d;
    logic       txd_q;

    always_comb begin
        state_d    = state_q;
        bit_cnt_d  = bit_cnt_q;
        data_reg_d = data_reg_q;
        txd_d      = txd_q;

        if (state_q == IDLE) begin
            if (tx_valid && tx_ready) begin
                data_reg_d = tx_data;
                state_d    = START;
            end
            txd_d = 1'b1;
        end else if (state_q == START) begin
            state_d   = DATA;
            txd_d     = 1'b0;
            bit_cnt_d = 0;
        end else if (state_q == DATA) begin
            if (bit_cnt_q == 7) begin
                state_d = STOP;
            end else begin
                bit_cnt_d = bit_cnt_q + 1;
            end
            txd_d      = data_reg_q[0] ^ ks_bit;
            data_reg_d = {1'b0, data_reg_q[7:1]};
        end else if (state_q == STOP) begin
            state_d = IDLE;
            txd_d   = 1'b1;
        end
    end

    always_ff @(posedge clk) begin
        if (~rst_n) begin
            state_q    <= IDLE;
            bit_cnt_q  <= 3'b0;
            data_reg_q <= 8'b0;
            txd_q      <= 1'b1;
        end
        else if (bit_tick) begin
            state_q    <= state_d;
            bit_cnt_q  <= bit_cnt_d;
            data_reg_q <= data_reg_d;
            txd_q      <= txd_d;
        end
    end
    assign txd        = txd_q;
    assign tx_ready   = (state_q == IDLE && tx_keyed && bit_tick);
    assign ks_consume = (state_q == DATA && bit_tick);


endmodule

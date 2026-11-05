`default_nettype none
module uart_rx (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       rx_in,
    input  logic       ks_bit,
    output logic [7:0] rx_data,
    output logic       rx_valid,
    output logic       rx_err,
    output logic       ks_consume
);

    localparam logic [1:0] IDLE  = 2'b00;
    localparam logic [1:0] START = 2'b01;
    localparam logic [1:0] DATA  = 2'b10;
    localparam logic [1:0] STOP  = 2'b11;

    logic [1:0] state_d;
    logic [1:0] state_q;
    logic [2:0] bit_cnt_d;
    logic [2:0] bit_cnt_q;
    logic [3:0] phase_cnt_d;
    logic [3:0] phase_cnt_q;
    logic [7:0] data_reg_d;
    logic [7:0] data_reg_q;




    always_comb begin
        state_d     = state_q;
        bit_cnt_d   = bit_cnt_q;
        phase_cnt_d = phase_cnt_q;
        data_reg_d  = data_reg_q;




        case (state_q)
            IDLE: begin
                phase_cnt_d = 0;
                if (rx_in == 0) state_d = START;
            end
            START: begin
                phase_cnt_d = phase_cnt_q + 1;
                if (phase_cnt_q == 7) begin
                    if (rx_in == 0) begin
                        bit_cnt_d   = 0;
                        phase_cnt_d = 0;
                        state_d     = DATA;
                    end
                    else
                        state_d = IDLE;
                end
            end

            DATA: begin
                phase_cnt_d = phase_cnt_q + 1;
                if (phase_cnt_q == 15) begin
                    if (bit_cnt_q == 7) begin
                        state_d = STOP;
                    end else begin
                        bit_cnt_d = bit_cnt_q + 1;
                    end
                    data_reg_d = {rx_in ^ ks_bit, data_reg_q[7:1]};
                end
            end
            STOP: begin
                phase_cnt_d = phase_cnt_q + 1;
                if (phase_cnt_q == 15) state_d = IDLE;
            end
            default: state_d = IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            bit_cnt_q   <= 0;
            phase_cnt_q <= 0;
            data_reg_q  <= 8'b0;
            state_q     <= IDLE;
        end else begin
            bit_cnt_q   <= bit_cnt_d;
            phase_cnt_q <= phase_cnt_d;
            data_reg_q  <= data_reg_d;
            state_q     <= state_d;
        end
    end

    assign rx_data    = data_reg_q;
    assign rx_valid   = (state_q == STOP && phase_cnt_q == 15 && rx_in);
    assign rx_err     = (state_q == STOP && phase_cnt_q == 15 && !rx_in);
    assign ks_consume = (state_q == DATA && phase_cnt_q == 15);




endmodule

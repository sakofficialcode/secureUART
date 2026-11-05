`default_nettype none
module bist_ctrl #(
    parameter logic [7:0] GOLDEN = 8'b0,
    parameter logic [7:0] LAST = 8'h51
) (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       bit_tick,
    input  logic       tx_ready,
    input  logic [7:0] rx_data,
    input  logic       rx_valid,
    input  logic       rx_err,
    input  logic       bist_start,
    output logic       bist_active,
    output logic       bist_clr,
    output logic [7:0] b_tx_data,
    output logic       b_tx_valid,
    output logic       bist_done,
    output logic       bist_pass
);

    localparam logic [2:0] IDLE = 3'b000;
    localparam logic [2:0] CLR  = 3'b001;
    localparam logic [2:0] SEND = 3'b010;
    localparam logic [2:0] WAIT = 3'b011;
    localparam logic [2:0] DONE = 3'b100;


    logic [2:0] state_d;
    logic [2:0] state_q;

    logic [7:0] MISR_d;
    logic [7:0] MISR_q;

    logic       fail_d;
    logic       fail_q;

    logic [3:0] timeout_d;
    logic [3:0] timeout_q;



    logic step;
    logic [7:0] pattern;

    lfsr #(
        .W   (8),
        .TAPS(8'hB8),
        .SEED(8'hA3)
    ) p_gen (
        .clk     (clk),
        .rst_n   (rst_n),
        .clr     (bist_clr),
        .load_en (1'b0),
        .load_bit(1'b0),
        .step    (step),
        .out     (),
        .state   (pattern)
    );


    always_comb begin
        state_d = state_q;
        MISR_d = MISR_q;
        fail_d = fail_q;
        timeout_d = timeout_q;



        case (state_q)
            IDLE: begin
                if (bist_start) state_d = CLR;
            end
            CLR: begin
                state_d = SEND;
                MISR_d  = 0;
                fail_d  = 0;
            end
            SEND: begin
                if (tx_ready) begin
                    state_d = WAIT;
                    timeout_d = 0;
                end
            end
            WAIT: begin

                if (bit_tick)
                    timeout_d = timeout_q + 1;
                if (rx_valid) begin
                    MISR_d = {MISR_q[6:0], ^(MISR_q & 8'hB8)} ^ rx_data;
                    if (pattern == LAST)
                        state_d = DONE;
                    else
                        state_d = SEND;
                end
                else if (rx_err || timeout_q == 4'd15) begin
                    fail_d  = 1'b1;
                    state_d = DONE;
                end
            end
            DONE: begin
                if (bist_start) state_d = CLR;
            end
            default: state_d = IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state_q   <= IDLE;
            MISR_q    <= 0;
            fail_q    <= 0;
            timeout_q <= 0;
        end else begin
            state_q   <= state_d;
            MISR_q    <= MISR_d;
            fail_q    <= fail_d;
            timeout_q <= timeout_d;
        end
    end

    assign step = (state_q == WAIT && rx_valid);

    assign bist_active = (state_q != IDLE && state_q !=  DONE);
    assign bist_clr    = (state_q == CLR);
    assign b_tx_valid  = (state_q == SEND);
    assign b_tx_data   = pattern;
    assign bist_done   = (state_q == DONE);
    assign bist_pass   = (state_q == DONE && !fail_q && MISR_q == GOLDEN);






endmodule

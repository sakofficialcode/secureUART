module lfsr #(
    parameter int W = 8,
    parameter logic [W-1:0] TAPS = 0,
    parameter logic [W-1:0] SEED = 1
) (
    input logic clk,
    input logic rst_n, clr,
    input logic load_en, load_bit,
    input logic step,
    output logic  out,
    output logic [W-1:0] state
);

logic [W-1:0] newstate;
logic fb;
assign fb = ^(TAPS & state);

always_comb begin
    newstate = state;
    if (~rst_n | clr) begin
        newstate = SEED;
    end
    else if (load_en) begin
        newstate = {state[W-2:0], load_bit};
    end
    else if (step) begin
        newstate = {state[W-2:0], fb};
    end
end


assign out = state[W-1];
always_ff @(posedge clk) begin
    state <= newstate;
end

endmodule

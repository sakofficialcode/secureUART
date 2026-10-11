`default_nettype none

module baud_gen (
    input  logic clk,
    input  logic rst_n,
    output logic bit_tick
);

    logic [3:0] counter;

    assign bit_tick = (counter == 15);
    always_ff @(posedge clk) begin
        if (~rst_n) counter <= 0;
        else counter <= counter + 1;
    end

endmodule

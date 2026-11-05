`default_nettype none
module sync_2ff (
    input  logic clk,
    input  logic rst_n,
    input  logic d,
    output logic q
);


    logic q1, q2;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            q1 <= 1'b1;
            q2  <= 1'b1;
        end
        else begin
            q1 <= d;
            q2 <= q1;
        end
    end
    assign q = q2;


endmodule

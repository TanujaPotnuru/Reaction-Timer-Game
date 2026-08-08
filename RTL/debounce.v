`timescale 1ns / 1ps

module debounce (

    input  wire clk_ms,
    input  wire btn_in,
    input  wire reset_n,
    output reg  btn_stable
);

    reg r1;

    always @(posedge clk_ms or negedge reset_n) begin
        if (!reset_n) begin
            r1         <= 1'b0;
            btn_stable <= 1'b0;
        end
        else begin
            r1         <= btn_in;
            btn_stable <= r1;
        end
    end

endmodule

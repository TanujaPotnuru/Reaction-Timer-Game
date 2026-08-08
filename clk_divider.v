`timescale 1ns / 1ps

module clk_divider (
    input  wire clk_in,
    input  wire reset_n,
    output reg  ms_tick
);

    parameter DIVISOR = 9;

    reg [15:0] cnt;

    always @(posedge clk_in or negedge reset_n) begin
        if (!reset_n) begin
            cnt     <= 16'd0;
            ms_tick <= 1'b0;
        end
        else begin
            if (cnt < DIVISOR) begin
                cnt     <= cnt + 16'd1;
                ms_tick <= 1'b0;
            end
            else begin
                cnt     <= 16'd0;
                ms_tick <= 1'b1;
            end
        end
    end

endmodule

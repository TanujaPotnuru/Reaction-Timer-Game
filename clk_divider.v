`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2026 12:09:58 AM
// Design Name: 
// Module Name: clk_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module clk_divider (
    input  wire clk_in,
    input  wire reset_n,
    output reg  ms_tick
);

    // 50,000 clock cycles -> 1 ms tick
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

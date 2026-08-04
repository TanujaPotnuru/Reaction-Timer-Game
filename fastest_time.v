`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2026 10:44:32 AM
// Design Name: 
// Module Name: fastest_time
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



module fastest_time(

    input wire clk_ms,
    input wire reset_n,

    input wire update,

    input wire [15:0] current_time,

    output reg [15:0] best_time

);

always @(posedge clk_ms or negedge reset_n) begin

    if(!reset_n) begin

        best_time <= 16'hFFFF;

    end

    else if(update) begin

        if(current_time < best_time)

            best_time <= current_time;

    end

end

endmodule

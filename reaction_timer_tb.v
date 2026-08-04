`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2026 10:41:18 AM
// Design Name: 
// Module Name: reaction_timer_tb
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

module reaction_timer_tb;

reg clk_ms;
reg reset_n;
reg start_pulse;
reg stop_pulse;

wire running;
wire [15:0] time_ms;

reaction_timer uut(
    .clk_ms(clk_ms),
    .reset_n(reset_n),
    .start_pulse(start_pulse),
    .stop_pulse(stop_pulse),
    .running(running),
    .time_ms(time_ms)
);

always #10 clk_ms = ~clk_ms;

initial begin

    clk_ms = 0;
    reset_n = 0;
    start_pulse = 0;
    stop_pulse = 0;

    #30;
    reset_n = 1;

    // Start timer
    #20;
    start_pulse = 1;

    #20;
    start_pulse = 0;

    // Count for 10 clocks
    #200;

    // Stop timer
    stop_pulse = 1;

    #20;
    stop_pulse = 0;

    #100;

    $finish;

end

endmodule

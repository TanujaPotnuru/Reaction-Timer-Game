`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2026 12:24:11 AM
// Design Name: 
// Module Name: debounce_tb
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

module debounce_tb;

    reg clk_ms;
    reg btn_in;
    reg reset_n;
    wire btn_stable;

    debounce uut (
        .clk_ms(clk_ms),
        .btn_in(btn_in),
        .reset_n(reset_n),
        .btn_stable(btn_stable)
    );

    // Clock generation (20 ns period)
    initial begin
        clk_ms = 0;
        forever #10 clk_ms = ~clk_ms;
    end

    initial begin
        reset_n = 0;
        btn_in  = 0;

        #50;
        reset_n = 1;

        // Simulate button press
        #40 btn_in = 1;

        // Simulate button release
        #80 btn_in = 0;

        // Simulate another press
        #60 btn_in = 1;

        #100;

        $finish;
    end

endmodule

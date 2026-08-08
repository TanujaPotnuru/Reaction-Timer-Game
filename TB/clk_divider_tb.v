`timescale 1ns / 1ps

module clk_divider_tb;

    reg clk_in;
    reg reset_n;
    wire ms_tick;

    // Instantiate DUT
    clk_divider uut (
        .clk_in(clk_in),
        .reset_n(reset_n),
        .ms_tick(ms_tick)
    );

    // Clock generation (20 ns period = 50 MHz)
    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in;
    end

    // Stimulus
    initial begin
        reset_n = 0;

        // Hold reset
        #100;

        reset_n = 1;

        // Run long enough to observe ms_tick
        #1200000;

        $finish;
    end

endmodule

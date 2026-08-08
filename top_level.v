`timescale 1ns / 1ps

module top_level(

    input  wire        CLOCK_50,
    input  wire [1:0]  KEY,
    input  wire [0:0]  SW,

    output wire [9:0]  LEDR,
    output wire        GPIO_0,
    output wire        GPIO_1,

    output wire [7:0]  HEX0,
    output wire [7:0]  HEX1,
    output wire [7:0]  HEX2,
    output wire [7:0]  HEX3

);

    // Internal Signals
  
    wire ms_tick;

    wire start_raw;
    wire react_raw;

    wire start_db;
    wire react_db;

    wire [15:0] rand_val;

    wire [9:0] led_state;

    wire start_pulse;
    wire stop_pulse;

    wire false_start;

    wire [15:0] reaction_time;
    wire [15:0] best_time;

    reg  [15:0] display_value;

    // Active-low Push Buttons

    assign start_raw = ~KEY[0];
    assign react_raw = ~KEY[1];

    // Clock Divider
 
    clk_divider clkdiv_inst
    (
        .clk_in   (CLOCK_50),
        .reset_n  (1'b1),
        .ms_tick  (ms_tick)
    );

    // Debounce
   
    debounce deb_start
    (
        .clk_ms     (ms_tick),
        .btn_in     (start_raw),
        .reset_n    (1'b1),
        .btn_stable (start_db)
    );

    debounce deb_react
    (
        .clk_ms     (ms_tick),
        .btn_in     (react_raw),
        .reset_n    (1'b1),
        .btn_stable (react_db)
    );

    // Random Delay Generator

    random_delay random_inst
    (
        .clk_ms      (ms_tick),
        .reset_n     (1'b1),
        .enable      (start_db),
        .rand_val_ms (rand_val)
    );

    // Main FSM

    fsm_main fsm_inst
    (
        .clk_ms        (ms_tick),
        .reset_n       (1'b1),

        .start_btn     (start_db),
        .react_btn     (react_db),

        .rand_val_ms   (rand_val),

        .led_state     (led_state),

        .start_pulse   (start_pulse),
        .stop_pulse    (stop_pulse),

        .go_green      (GPIO_0),
        .false_yellow  (GPIO_1),
        .false_start   (false_start)
    );

    // Reaction Timer

    reaction_timer timer_inst
    (
        .clk_ms       (ms_tick),
        .reset_n      (1'b1),

        .start_pulse  (start_pulse),
        .stop_pulse   (stop_pulse),

        .running       (),
        .time_ms      (reaction_time)
    );

    // Fastest Time

    fastest_time best_inst
    (
        .clk_ms        (ms_tick),
        .reset_n       (1'b1),

        .update        (stop_pulse),
        .current_time  (reaction_time),

        .best_time     (best_time)
    );

    // Display Multiplexer

    always @(*) begin
        if (SW[0])
            display_value = best_time;
        else
            display_value = reaction_time;
    end

    // Seven Segment Display

    sevenseg_display segdrv
    (
        .value_ms (display_value),

        .seg0 (HEX0),
        .seg1 (HEX1),
        .seg2 (HEX2),
        .seg3 (HEX3)
    );

    // LEDs
    assign LEDR = led_state;

endmodule
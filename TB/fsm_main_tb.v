`timescale 1ns/1ps

module fsm_main_tb;

    // Inputs
    reg clk_ms;
    reg reset_n;
    reg start_btn;
    reg react_btn;
    reg [15:0] rand_val_ms;

    // Outputs
    wire [9:0] led_state;
    wire start_pulse;
    wire stop_pulse;
    wire go_green;
    wire false_yellow;
    wire false_start;

    // Instantiate DUT
    fsm_main DUT
    (
        .clk_ms(clk_ms),
        .reset_n(reset_n),
        .start_btn(start_btn),
        .react_btn(react_btn),
        .rand_val_ms(rand_val_ms),
        .led_state(led_state),
        .start_pulse(start_pulse),
        .stop_pulse(stop_pulse),
        .go_green(go_green),
        .false_yellow(false_yellow),
        .false_start(false_start)
    );

    // 1 ms Clock

    initial
    begin
        clk_ms = 0;
        forever #0.5 clk_ms = ~clk_ms;
    end

    // Stimulus

    initial
    begin

        // Initialize
        reset_n     = 0;
        start_btn   = 0;
        react_btn   = 0;

        // Wait randomly 200 ms after LEDs finish
        rand_val_ms = 16'd200;

        #5;
        reset_n = 1;

        // Start the Game
        #10;

        start_btn = 1;
        #2;
        start_btn = 0;

        // Wait until GO becomes HIGH
        wait(go_green == 1);

        // Simulated human reaction = 120 ms
        #120;

        react_btn = 1;
        #2;
        react_btn = 0;

        // Wait for FSM to return IDLE
        #100;

        // FALSE START TEST

        $display("------------------------------------");
        $display("FALSE START TEST");
        $display("------------------------------------");

        start_btn = 1;
        #2;
        start_btn = 0;

        // Wait until random wait state begins
        wait(false_yellow == 1);

        // Press too early
        #50;

        react_btn = 1;
        #2;
        react_btn = 0;

        // Acknowledge false start
        #20;

        react_btn = 1;
        #2;
        react_btn = 0;

        #100;

        $finish;

    end

    // Monitor

    initial
    begin
        $monitor(
        "TIME=%0t | LED=%b | START=%b STOP=%b GO=%b WAIT=%b FALSE=%b",
        $time,
        led_state,
        start_pulse,
        stop_pulse,
        go_green,
        false_yellow,
        false_start
        );
    end
    always @(posedge clk_ms)
begin
    $display(
        "T=%0t  state=%0d  sec=%0d  led=%0d  wait=%0d  GO=%b  START=%b  STOP=%b  REACT=%b",
        $time,
        DUT.state,
        DUT.sec_tick,
        DUT.led_index,
        DUT.wait_counter,
        go_green,
        start_pulse,
        stop_pulse,
        react_btn
    );
end

endmodule
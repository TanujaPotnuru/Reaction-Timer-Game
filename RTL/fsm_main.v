`timescale 1ns/1ps
module fsm_main (
    input  wire        clk_ms,      // Clock input (ms clock)
    input  wire        reset_n,     // Active-low reset
    input  wire        start_btn,   // Start button 
    input  wire        react_btn,   // React button 
    input  wire [15:0] rand_val_ms, // Random wait target 
    output reg  [9:0]  led_state,   // LED outputs 
    output reg         start_pulse, // Pulse to signal start 
    output reg         stop_pulse,  // Pulse to signal stop 
    output wire        go_green,    // 'Go green' indicator 
    output wire        false_yellow,// 'False yellow' indicator 
    output wire        false_start  // False start flag 
);
    // State encoding (3 bits for 7 states)
    parameter IDLE        = 3'b000;
    parameter COUNTING    = 3'b001;
    parameter WAIT_RANDOM = 3'b010;
    parameter YELLOW      = 3'b011;
    parameter GO          = 3'b100;
    parameter DONE        = 3'b101;
    parameter FALSE_STR   = 3'b110;
    reg [2:0] state;  // Current state register

   
    reg [9:0] led_reg;      // LED shift register
    reg [9:0] sec_tick;     // 0..999 ms counter (10 bits)
    reg [3:0] led_index;    // 0..10 index of LED to light (4 bits)
    reg [15:0] wait_counter;// Random wait counter
    reg [15:0] rand_target; // Random target loaded from rand_val_ms
    reg start_int, stop_int, fs_int; // One-shot pulse flags

    // Combinational outputs based on state/flags
    assign go_green     = (state == GO);
    assign false_yellow = (state == WAIT_RANDOM);
    assign false_start  = fs_int;

    // Sequential logic: state updates, counters, and pulses
    always @(posedge clk_ms or negedge reset_n) begin
        if (!reset_n) begin
            // Reset all registers (VHDL: reset_n = '0')
            state        <= IDLE;
            sec_tick     <= 10'd0;
            led_index    <= 4'd0;
            led_reg      <= 10'b0;
            wait_counter <= 16'd0;
            rand_target  <= 16'd1000;  // default or unused
            start_int    <= 1'b0;
            stop_int     <= 1'b0;
            fs_int       <= 1'b0;
            start_pulse  <= 1'b0;
            stop_pulse   <= 1'b0;
            led_state    <= 10'b0;
        end else begin
            // Clear one-shot pulses each clock
            start_int <= 1'b0;
            stop_int  <= 1'b0;
            fs_int    <= 1'b0;
            // State machine transitions (mirrors VHDL case)
            case (state)
                IDLE: begin
                    // All LEDs off, counters zero
                    led_reg   <= 10'b0;
                    sec_tick  <= 10'd0;
                    led_index <= 4'd0;
                    wait_counter <= 16'd0;
                    // If start button pressed, go to COUNTING
                    if (start_btn) begin
                        state        <= COUNTING;
                        sec_tick     <= 10'd0;
                        led_index    <= 4'd1;
                        led_reg      <= 10'b0000000001; // Light LED 0
                    end
                end

                COUNTING: begin
                    if (sec_tick < 10'd9) begin
                        sec_tick <= sec_tick + 1;
    end
    else begin
        sec_tick <= 0;

        if (led_index < 10) begin
            led_reg[led_index] <= 1'b1;
            led_index <= led_index + 1;
        end
        else begin
            state <= WAIT_RANDOM;
            sec_tick <= 10'd0;
            led_reg <= 10'b0;
            wait_counter <= 0;
            rand_target <= rand_val_ms;
        end
    end
end

                WAIT_RANDOM: begin
                    // LED off during random wait
                    if (react_btn) begin
                        // False start: button pressed too early
                        fs_int <= 1'b1;
                        state  <= FALSE_STR;
                    end else if (wait_counter < rand_target) begin
                        wait_counter <= wait_counter + 1;
                    end else begin
                        // Random wait elapsed
                        state <= YELLOW;
                    end
                end

                YELLOW: begin
                    // Yellow stage: immediately assert start pulse then go to GO
                    start_int <= 1'b1;
                    state     <= GO;
                end

                GO: begin
                    // Waiting for reaction
                    if (react_btn) begin
                        stop_int <= 1'b1;
                        state    <= DONE;
                    end
                end

                DONE: begin
                    // Reaction done, return to IDLE next cycle
                    state <= IDLE;
                end

                FALSE_STR: begin
                    // Wait for acknowledgement (button press) to clear false start
                    if (react_btn) begin
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase

            // Register outputs updated from internal signals
            led_state   <= led_reg;
            start_pulse <= start_int;
            stop_pulse  <= stop_int;
        end
    end
endmodule

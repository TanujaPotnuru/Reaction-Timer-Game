`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2026 12:45:09 AM
// Design Name: 
// Module Name: random_delay
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


module random_delay(
    input  wire        clk_ms,
    input  wire        reset_n,
    input  wire        enable,
    output reg [15:0]  rand_val_ms
);

    parameter MIN_MS   = 16'd1000;
    parameter RANGE_MS = 16'd2000;

    reg [15:0] lfsr;
    reg [15:0] feedback;
    integer rnd_int;

    always @(posedge clk_ms or negedge reset_n) begin
        if (!reset_n) begin
            lfsr        <= 16'hACE1;
            rand_val_ms <= MIN_MS;
        end
        else begin
            // Update LFSR
            feedback = lfsr[15] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10];
            lfsr <= {lfsr[14:0], feedback};

            if (enable) begin
                rnd_int = lfsr % RANGE_MS;
                rand_val_ms <= MIN_MS + rnd_int;
            end
        end
    end

endmodule
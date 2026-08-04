`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2026 10:39:59 AM
// Design Name: 
// Module Name: reaction_timer
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


module reaction_timer(
    input  wire        clk_ms,
    input  wire        reset_n,
    input  wire        start_pulse,
    input  wire        stop_pulse,

    output reg         running,
    output reg [15:0]  time_ms
);

always @(posedge clk_ms or negedge reset_n) begin
    if (!reset_n) begin
        time_ms <= 16'd0;
        running <= 1'b0;
    end
    else begin
        if (start_pulse) begin
            time_ms <= 16'd0;
            running <= 1'b1;
        end
        else if (stop_pulse) begin
            running <= 1'b0;
        end
        else if (running) begin
            if (time_ms < 16'd9999)
                time_ms <= time_ms + 1'b1;
        end
    end
end

endmodule

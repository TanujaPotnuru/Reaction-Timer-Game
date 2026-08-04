`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2026 10:45:49 AM
// Design Name: 
// Module Name: fastest_time_tb
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

module fastest_time_tb;

reg clk_ms;
reg reset_n;
reg update;

reg [15:0] current_time;

wire [15:0] best_time;

fastest_time uut(

    .clk_ms(clk_ms),
    .reset_n(reset_n),
    .update(update),
    .current_time(current_time),
    .best_time(best_time)

);

always #10 clk_ms = ~clk_ms;

initial begin

clk_ms=0;
reset_n=0;
update=0;
current_time=0;

#30;

reset_n=1;

current_time=16'd250;

update=1;

#20;

update=0;

#40;

current_time=16'd180;

update=1;

#20;

update=0;

#40;

current_time=16'd300;

update=1;

#20;

update=0;

#60;

$finish;

end

endmodule
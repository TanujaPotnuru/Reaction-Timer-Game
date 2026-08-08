`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2026 08:29:15 AM
// Design Name: 
// Module Name: sevenseg_display
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


module sevenseg_display(

    input  wire [15:0] value_ms,

    output reg [7:0] seg0,
    output reg [7:0] seg1,
    output reg [7:0] seg2,
    output reg [7:0] seg3

);

reg [3:0] d0,d1,d2,d3;
integer val;

always @(*) begin

    val = value_ms;

    if(val > 9999)
        val = 9999;

    d0 = val % 10;
    d1 = (val/10) % 10;
    d2 = (val/100) % 10;
    d3 = (val/1000) % 10;

end

always @(*) begin

    case(d0)
        0: seg0 = 8'b11000000;
        1: seg0 = 8'b11111001;
        2: seg0 = 8'b10100100;
        3: seg0 = 8'b10110000;
        4: seg0 = 8'b10011001;
        5: seg0 = 8'b10010010;
        6: seg0 = 8'b10000010;
        7: seg0 = 8'b11111000;
        8: seg0 = 8'b10000000;
        9: seg0 = 8'b10010000;
        default: seg0 = 8'b11111111;
    endcase

    case(d1)
        0: seg1 = 8'b11000000;
        1: seg1 = 8'b11111001;
        2: seg1 = 8'b10100100;
        3: seg1 = 8'b10110000;
        4: seg1 = 8'b10011001;
        5: seg1 = 8'b10010010;
        6: seg1 = 8'b10000010;
        7: seg1 = 8'b11111000;
        8: seg1 = 8'b10000000;
        9: seg1 = 8'b10010000;
        default: seg1 = 8'b11111111;
    endcase

    case(d2)
        0: seg2 = 8'b11000000;
        1: seg2 = 8'b11111001;
        2: seg2 = 8'b10100100;
        3: seg2 = 8'b10110000;
        4: seg2 = 8'b10011001;
        5: seg2 = 8'b10010010;
        6: seg2 = 8'b10000010;
        7: seg2 = 8'b11111000;
        8: seg2 = 8'b10000000;
        9: seg2 = 8'b10010000;
        default: seg2 = 8'b11111111;
    endcase

    case(d3)
        0: seg3 = 8'b11000000;
        1: seg3 = 8'b11111001;
        2: seg3 = 8'b10100100;
        3: seg3 = 8'b10110000;
        4: seg3 = 8'b10011001;
        5: seg3 = 8'b10010010;
        6: seg3 = 8'b10000010;
        7: seg3 = 8'b11111000;
        8: seg3 = 8'b10000000;
        9: seg3 = 8'b10010000;
        default: seg3 = 8'b11111111;
    endcase

end

endmodule

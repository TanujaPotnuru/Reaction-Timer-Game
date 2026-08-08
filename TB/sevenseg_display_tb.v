`timescale 1ns / 1ps

module sevenseg_display_tb;

reg [15:0] value_ms;

wire [7:0] seg0;
wire [7:0] seg1;
wire [7:0] seg2;
wire [7:0] seg3;

sevenseg_display uut(

    .value_ms(value_ms),

    .seg0(seg0),
    .seg1(seg1),
    .seg2(seg2),
    .seg3(seg3)

);

initial begin

    value_ms = 0;

    #20;

    value_ms = 16'd1234;

    #20;

    value_ms = 16'd5678;

    #20;

    value_ms = 16'd9999;

    #20;

    value_ms = 16'd10567;

    #20;

    $finish;

end

endmodule

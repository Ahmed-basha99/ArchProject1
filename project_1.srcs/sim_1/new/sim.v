`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 04:40:50 PM
// Design Name: 
// Module Name: sim
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


module sim;
reg clk, push, rst;
reg [1:0] ledSel;
reg [3:0] ssdSel;
wire [15:0] led;
wire [3:0] AN;
wire [6:0] seg;

Processor proc(clk, rst, ledSel, ssdSel, push, led, AN, seg);
always #10 push = ~push;
initial begin
rst = 1;
push = 1;

ledSel = 0;
ssdSel = 0;

#10 
rst = 0;


end

endmodule

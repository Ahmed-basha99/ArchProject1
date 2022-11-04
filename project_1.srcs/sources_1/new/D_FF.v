`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 12:35:58 PM
// Design Name: 
// Module Name: D_FF
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


module D_FF (input clk, input rst, input D, output reg Q); 
 always @ (posedge clk or posedge rst) 
 if (rst) begin 
 Q <= 1'b0; 
 end else begin 
 Q <= D; 
 end 
endmodule
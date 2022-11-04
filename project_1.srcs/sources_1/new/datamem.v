`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 02:51:55 PM
// Design Name: 
// Module Name: datamem
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

module datamem
 (input clk, input MemRead, input MemWrite,
 input [5:0] addr, input [31:0] data_in, output [31:0] data_out);
 reg [31:0] mem [0:63];
 assign data_out = MemRead? mem[addr]: 0;
 always @ (posedge clk) begin
 if(MemWrite) mem[addr] = data_in;
 end
initial begin 
 mem[0]=32'd17; 
 mem[1]=32'd9; 
 mem[2]=32'd25;
// mem[3]= 32'd5;
// mem[4]= 32'd1; 
// mem[5]= 32'd0; 
 end 
endmodule

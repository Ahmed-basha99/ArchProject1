`timescale 1ns / 1ps
`include "defines.v"
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
 input [31:0] addr, input [31:0] data_in, output reg [31:0] data_out, input [2:0] readSize, input [1:0] storeSize);
 reg [31:0] mem [0:1023];
 always @ (negedge clk) begin
// data_out = MemRead? mem[addr]: 0;
 if(MemRead) begin
    case(readSize)
        `LOAD_b: data_out = {{24{mem[addr][7]}}, mem[addr][7:0]};
        `LOAD_h: data_out = {{16{mem[addr][15]}}, mem[addr][15:0]};
        `LOAD_w: data_out = mem[addr];
        `LOAD_bu: data_out = {24'b0, mem[addr][7:0]};
        `LOAD_hu: data_out = {16'b0, mem[addr][15:0]};  
    endcase
 end

 if(MemWrite) begin
    case(storeSize)
        2'b00: mem[addr] = {mem[addr][31:8], data_in[7:0]}; //SB 
        2'b01: mem[addr] = {mem[addr][31:16], data_in[15:0]};//SH
        2'b10: mem[addr] = data_in;//SW
        
    endcase
 end
 end
 integer i = 0;
initial begin 
    
    for (i=0; i<1024;i=i+1) mem[i]=32'b0; 
// mem[3]= 32'd5;
// mem[4]= 32'd1; 
// mem[5]= 32'd0; 
 end 
endmodule

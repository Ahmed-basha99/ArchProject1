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
 input [7:0] addr, input [31:0] data_in, output reg [31:0] data_out, input [2:0] readSize, input [1:0] storeSize);
 reg [7:0] mem [0:1023];
 always @ (posedge clk) begin
 data_out = MemRead? mem[addr]: 0;
 if(MemRead) begin
    case(readSize)
        `LOAD_b: data_out = {{24{mem[addr][7]}}, mem[addr]} ;
        `LOAD_h: data_out = {{16{mem[addr+1][7]}}, mem[addr+1], mem[addr]};
        `LOAD_w: data_out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
        `LOAD_bu: data_out = {24'b0, mem[addr]};
        `LOAD_hu: data_out = {16'b0, mem[addr+1], mem[addr]};  
        default: data_out = 0;
    endcase
 end

 if(MemWrite) begin
    case(storeSize)
        2'b00: mem[addr] = data_in[7:0]; //SB 
        2'b01: begin
            mem[addr] = data_in[7:0];//SH
            mem[addr+1] = data_in[15:8];
        end
        2'b10: begin 
            mem[addr] = data_in[7:0];//SW
            mem[addr+1] = data_in[15:8];
            mem[addr+2] = data_in[23:16];
            mem[addr+3] = data_in[31:24];
        end
    endcase
 end
 end
 integer i = 0;
initial begin 
    
    for (i=0; i<1024;i=i+1) mem[i]=8'b0; 
mem[3]= 8'hFF;
mem[4]= 8'hFF; 
mem[5]= 8'hFF;
mem[6]= 8'hFF; 
 end 
endmodule
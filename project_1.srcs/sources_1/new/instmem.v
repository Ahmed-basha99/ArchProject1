`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 02:45:26 PM
// Design Name: 
// Module Name: instmem
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


module instmem (input [31:0] addr, output [31:0] data_out);
 reg [31:0] mem [0:63];
 assign data_out = mem[addr];
 initial begin 
 
 // a program to sum numbers from x5 to x2-1 
 
// mem[0] = 32'h01402203 ;  // lw x4, 20(x0) // x4 =0
// mem[1] = 32'h01002283;// lw x5 , 16(x0) // x5 =1
// mem[2] = 32'h01022083; // lw x1 , 16(x4)  // x1 = 1
// mem[3] = 32'h00422103; // lw x2, 4(x4)  // x2 = 9
// mem[4] = 32'h00822183; // lw x3, 8(x4) // x3=25
//mem[5]= 32'h00520233; // add x4,x4, x5  // x4+=i 
//mem[6]= 32'h001282b3; //add x5, x5, x1 // x5++
//mem[7] = 32'h00228463; // beq x5,x2,4   // 
//mem[8] = 32'hfe000ae3; // beq x0,x0, -8 // 
//mem[9] =32'h00402c23; //sw x4, 24(x0) // save the sum 

 
 mem[0]= 32'h0100006f	;
 mem[1]= 32'h001100b3	;
 mem[2]= 32'h00002103	;
 mem[3]= 32'h00508313	;
 mem[4]= 32'h00108093	;

 
 
// mem[0]=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)  // 17
// mem[1]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0) // 9
// mem[2]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0) //25
// mem[3]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2 // 25
// mem [4] = 32'h00508313;
// mem[4]=32'b0_000000_00011_00100_000_0100_0_1100011; //beq x4, x3, 4 
// mem[5]=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2 
// mem[6]=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2 
// mem[7]=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0) 
// mem[8]=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0) 
// mem[9]=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1 
// mem[10]=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2 
// mem[11]=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2 
// mem[12]=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0, x1 
// end 
end

endmodule
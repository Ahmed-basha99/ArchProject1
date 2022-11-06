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
// $readmemh ("./hex/tests1.hex",mem);
//    kholy test program 
//    mem[0]= 32'h0000c337;
//    mem[1]= 32'h00001317;
//    mem[2]= 32'h00000263;
//    mem[3]= 32'h00001063;
//    mem[4]= 32'h00604263;
//    mem[5]= 32'h00605063;
//    mem[6]= 32'hfe006ee3;
//    mem[7]= 32'h00007463;
//    mem[8]= 32'h00000013;
//    mem[9]= 32'hfff00313;
//    mem[10]= 32'h40000413;
////    mem[11]= 32'h00640023;
//    mem[11]= 32'h00640023;
//    mem[12]= 32'h00641223;
//    mem[13]= 32'h00642423;
//    mem[14]= 32'h00842303;
//    mem[15]= 32'h00441303;
//    mem[16]= 32'h00040303;
//    mem[17]= 32'h00445303;
//    mem[18]= 32'h00044303;
//    mem[19]= 32'hfff00393;
//    mem[20]= 32'h0643a413;
//    mem[21]= 32'h0643b413;
//    mem[22]= 32'h00104313;
    
    
    // ahmed test program
    
mem[0]= 32'h00400413 ;
    mem[1]= 32'h008404b3 ;
    mem[2]= 32'h40948533 ;
    mem[3]= 32'h008495b3 ;
    mem[4]= 32'h00852633 ;
    mem[5]= 32'h008536b3 ;
    mem[6]= 32'h40084f733 ;
    mem[7]= 32'h0084e733;
    mem[8]= 32'h00944733 ;
    mem[9]= 32'h00200413 ;
    mem[11]= 32'h4008757b3 ;
    mem[10]= 32'h408757b3 ;
    mem[12]= 32'h008000ef ;
    mem[13]= 32'h01c0006f ;
    mem[14]= 32'h0084e813 ;
    mem[15]= 32'h0084f813;
   
    mem[16]= 32'h00181813 ;
    mem[17]= 32'h00185813 ;
    mem[18]= 32'h40185813 ;
    mem[20]= 32'h00008067 ;
    mem[19] = 32'b00000000000100000000000001110011 ; // ebreak
//    mem[19]= 32'b00000000000000000000000001110011; // ecall
//    mem[19] = 32'b00000000000000000000000000001111; // fence



   
     
end

endmodule
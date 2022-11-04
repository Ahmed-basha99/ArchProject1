`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2022 05:20:54 PM
// Design Name: 
// Module Name: Processor
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


module Processor(input clk, rst, input [1:0] ledSel, input [3:0] ssdSel, input push,   output reg[15:0] LED, output [3:0] AN, output[6:0] SEG);

 wire[31:0] next_pc;
 wire [31:0] curr_pc;
 wire [31:0] pcadd4;
 wire [31:0]add4; assign add4 = 4;
 adder INCPC(curr_pc, add4, pcadd4);
 
 // pc register
 nbitregister  #( 32) pc(push, 1, rst, next_pc, curr_pc );
 
 // instmeme
 wire [31:0] inst;
 instmem im( {2'b00,curr_pc[31:2]}, inst);

 

//CU 
wire [2:0]branch;  
wire [1:0] writeBackVal ;
wire  pcSel;
wire memWrite, alusrc2sel,regWrite,memRead,jStart, jump, jal_jalr;
wire [3:0] ALUOp ;
wire [1:0] storeSize ;
wire [2:0]readSize;
cu CUU (inst[6:2], inst[14:12] , inst[31:25], branch, pcSel,memRead,writeBackVal,memWrite, alusrc2sel,regWrite,ALUOp, readSize,storeSize,jStart,jump,jal_jalr);


// imm gen
wire[31:0] IMM;
rv32_ImmGen ImmGen(inst, IMM);



//RF
wire [31:0] WB_data; // remember to set to 0
wire [31:0] R1, R2;
RF RegFile(push, rst, inst[19:15], inst[24:20], inst[11:7], WB_data, regWrite, R1, R2);  

// muxSel 
wire [31:0] alusrc2val;
nmux AluMux(R2, IMM, alusrc2sel, alusrc2val);


// alu
wire [31:0] AluOut;
wire cf, zf, vf, sf; 
prv32_ALU ALU(R1,alusrc2val,inst[24:20],ALUOp,cf,zf,vf,sf,AluOut);
wire branchSignal; 
BranchUnit Branchunit (branch, zf,cf,vf,sf, branchSignal);

// dataMem
wire [31:0] DMoutput;
// issue with 4th parameter
datamem DM(push, memRead , memWrite , {2'b00, AluOut[31:2]}, R2, DMoutput ) ;

// Write Back 
x41Mux WBmux (AluOut, DMoutput, pcadd4, 0, writeBackVal, WB_data);


// nextPc selection 
wire [31:0] immPC ; 
nmux jalselMux (IMM,AluOut, jump,immPC); // issue not sure with jStart
wire [31:0]pcimm; 
adder pcimmAdd (curr_pc ,immPC, pcimm);
wire [31:0] pcval;
wire selectpcval;
assign selectpcval = branchSignal | jal_jalr;
nmux #(32)nnmuxx (pcadd4,pcimm,selectpcval, pcval);
wire [31:0]last;
// issue branch Signal should be 1 if we have jal/jalr
nmux blastmux (pcval, curr_pc,pcSel,last);
nmux lastmux (last, 0, jStart, next_pc);
endmodule

`include "defines.v"
`timescale 1ns / 1ps
module prv32_ALU(
	input   wire [31:0] a, 
	input   wire [31:0] b,
	input   wire [4:0]  shamt,
	input   wire [3:0]  alufn,
	output   cf, zf, vf, sf,
	output  reg  [31:0] out

);
    
     wire[31:0] add,  sub, op_b;
     wire cfa, cfs;
    
    assign op_b = (~b);
    
    assign {cf, add} = alufn[0] ? (a + op_b + 1'b1) : (a + b);
    
    assign zf = (add == 0);
    assign sf = add[31];
    assign vf = (a[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] sh;
    shifter shifter0(a, shamt, alufn[1:0], sh);
    
    always @ * begin
        out = 0;
        
        (* parallel_case *)
        case (alufn)
            // arithmetic
            `ALU_ADD : out = add; // add
            `ALU_SUB : out = add; // subtract
            `ALU_PASS  : out = b; //pas 
            // logic
            `ALU_OR  :  out = a | b; // or
            `ALU_AND :  out = a & b; // and
            `ALU_XOR :  out = a ^ b; // xor
            // shift
            `ALU_SRL:  out=sh; // shift left
            `ALU_SLL:  out=sh; // shift right logical
            `ALU_SRA:  out=sh; // shit right arithemtic
            // slt & sltu
            `ALU_SLT:  out = {31'b0,(sf != vf)}; // slt
            `ALU_SLTU:  out = {31'b0,(~cf)};         //sltu  	
        endcase
    end
endmodule
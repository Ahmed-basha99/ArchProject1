`include "defines.v"
`timescale 1ns / 1ps
module shifter (
input wire [31:0] a,
input wire [4:0]shamt,
input wire [1:0] type,
output reg [31:0] out);

    always @ * begin
        case(type)
            2'b00: out = a >> shamt; //SRL
            2'b01: out = a << shamt; //SLL
            2'b10: out = a >>> shamt; //SRA
            default: out = a;
        endcase



    end



   endmodule
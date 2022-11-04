`timescale 1ns / 1ps


/*

will be used for the following:


pcSel:
00- pc+4
01- pc+imm
10- rs1+imm
11 - halt - pc



*/

/*

writeBackSel:
Alu out - 00
Memory - 01
pc+4 - 10
X - 11



*/


module x41Mux(
    input wire[31:0] a, b, c, d,
    input wire[1:0] s,
    output reg [31:0] out
    );
    always @ * begin
        case(s)
        0: out <= a;
        1: out <= b;
        2: out <= c;
        3: out <= d;
    endcase
    end
    
endmodule
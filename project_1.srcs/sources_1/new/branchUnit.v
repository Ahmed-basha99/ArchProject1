`timescale 1ns / 1ps
`include "defines.v"

/*

branch signal depends on Zero: Z, Carry: C, Overflow: V, and Sign: S

BEQ: Branch if Z
BNE: Branch if ~Z;
BLT: Branch if (S != V)
BGE: Branch if (S == V)
BLTU: Branch if ~C
BGEU: Branch if C


*/

module BranchUnit(
    input wire [2:0] branchCode,
    input wire zF, cF, vF, sF,
    output reg branchSignal
    );
    always @ * begin
        case(branchCode)
        `BR_BEQ: branchSignal = zF? 1: 0;
        `BR_BNE: branchSignal = zF? 0: 1;
        `BR_BLT: branchSignal = (sF == vF) ? 0: 1;
        `BR_BGE: branchSignal = (sF == vF) ? 1: 0;
        `BR_BLTU: branchSignal = cF ? 0: 1;
        `BR_BGEU: branchSignal = cF ? 1: 0;
        `BR_PASS: branchSignal = 0;
        default: branchSignal = 0;
    endcase
    end
endmodule

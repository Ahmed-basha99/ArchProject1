`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2022 12:51:54 PM
// Design Name: 
// Module Name: nbitregister
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


module nbitregister #(parameter N=8)(
    input clk,
    input load,
    input rst, 
    input[N-1:0] D, 
    output[N-1:0] Q
    );
    
    genvar i;
    wire[N-1:0] v;
    generate begin
        for(i=0; i < N; i=i+1)begin
            mux z(Q[i], D[i], load, v[i]);
            D_FF d(clk, rst, v[i], Q[i]);
          end
    end
    endgenerate 
endmodule

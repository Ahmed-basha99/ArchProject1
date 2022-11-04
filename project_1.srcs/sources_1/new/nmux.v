`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2022 12:07:35 PM
// Design Name: 
// Module Name: nmux
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

module mux (input x,y,s , output u) ;
assign u = x&(~s) || (s&y);
endmodule 
  
module nmux #(parameter N =32)(input [N-1:0]x, [N-1:0]y , input s, output  [N-1:0]out);
    genvar i ;
    generate 
    for (i=0;i<N;i=i+1) begin 
    mux a (x[i],y[i],s,out[i]) ;
    end 
    endgenerate 
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2022 03:47:51 PM
// Design Name: 
// Module Name: RF
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


module RF(input clk, rst, [4:0]R1, [4:0]R2,[4:0]W, [31:0] data,input  regwrite , output [31:0]o1 ,[31:0]o2  );
wire [31:0] Q[31:0];
reg [31:0] load;
initial load = 4294967295;
genvar i ;
generate begin  
for (i=0 ; i<32 ; i= i+1)  
begin nbitregister  #( 32) rg(clk, load[i],rst, data,Q[i] ) ;
 end
 end
 endgenerate 
 assign o1 = Q[R1];
 assign o2 = Q[R2];

 always@(*)begin
    load = 0;
    if(W != 0) begin 
    load[W] = regwrite;
    end
end
endmodule

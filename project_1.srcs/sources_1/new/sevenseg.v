module BCD ( 
input [12:0] num, 
output reg [3:0] Thousands,
output reg [3:0] Hundreds, 
output reg [3:0] Tens, 
output reg [3:0] Ones 
); 
integer i; 
always @(num) 
begin 
//initialization 
 Hundreds = 4'd0; 
 Tens = 4'd0; 
 Ones = 4'd0; 
 Thousands  = 4'd0; 
for (i = 12; i >= 0 ; i = i-1 ) 
begin 
if(Thousands  >= 5 ) 
 Thousands = Thousands + 3; 
if(Hundreds >= 5 ) 
 Hundreds = Hundreds + 3; 
if (Tens >= 5 ) 
 Tens = Tens + 3; 
 if (Ones >= 5) 
 Ones = Ones +3; 
//shift left one 
Thousands = Thousands  <<1;
Thousands [0]=Hundreds [3];
 Hundreds = Hundreds << 1; 
 Hundreds [0] = Tens [3]; 
 Tens = Tens << 1; 
 Tens [0] = Ones[3]; 
 Ones = Ones << 1; 
 Ones[0] = num[i]; 
end 
end 
endmodule 
module Four_Digit_Seven_Segment_Driver ( 
 input CLK100MHZ, 
 input [12:0] SW, 
 output reg [3:0] AN, 
 output reg [6:0] SEG 
 ); 
 
 reg [3:0] LED_BCD; 
 reg [19:0] refresh_counter = 0; // 20-bit counter 
 wire [1:0] LED_activating_counter; 
 always @(posedge CLK100MHZ) 
 begin 
 if (refresh_counter == 1048575 ) refresh_counter <=0;
 else refresh_counter <= refresh_counter + 1; 
 end 
 
 assign LED_activating_counter = refresh_counter[19:18]; 
 
 wire [3:0]Hundreds ;
 wire [3:0] Tens ;
 wire [3:0]Ones; 
 wire [3:0]Thousands ;
 BCD bcd (SW,Thousands ,Hundreds ,Tens , Ones);

 always @(*) 
 begin 
 case(LED_activating_counter) 
 2'b00: begin
 AN = 4'b0111; 
 LED_BCD = Thousands ; 
 end 
 2'b01: begin
 AN = 4'b1011; 
 LED_BCD = Hundreds ; 
 end 
 2'b10: begin
 AN = 4'b1101;
 LED_BCD = Tens;
 end 
 2'b11: begin
 AN = 4'b1110; 
 LED_BCD=Ones;
 end 
 endcase 
 end 
 
 
 always @(*) 
 begin 
 case(LED_BCD) 
 4'b0000: SEG = 7'b0000001; // "0" 
 4'b0001: SEG = 7'b1001111; // "1" 
 4'b0010: SEG = 7'b0010010; // "2" 
 4'b0011: SEG = 7'b0000110; // "3" 
 4'b0100: SEG = 7'b1001100; // "4" 
 4'b0101: SEG = 7'b0100100; // "5" 
 4'b0110: SEG = 7'b0100000; // "6" 
 4'b0111: SEG = 7'b0001111; // "7" 
 4'b1000: SEG = 7'b0000000; // "8" 
 4'b1001: SEG = 7'b0000100; // "9" 
 default: SEG = 7'b0000001; // "0" 
 endcase 
 end 
endmodule 

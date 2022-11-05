`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/27/2022 04:31:01 PM
// Design Name: 
// Module Name: CU
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

`include "defines.v"

module cu(
    input wire [4:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg[2:0] branch,
    output reg pcSel,
    output reg memRead, 
    output reg[1:0] writeBackVal,
    output reg memWrite,
    output reg alusrc1,//choose pc or rs1
    output reg alusrc2, // choose immgen or rs2
    output reg regWrite,
    output reg [3:0] ALUOp,
    output reg [2:0] readSize,
    output reg [1:0] storeSize,
    output reg jStart,
    output reg jump,
    output reg jal_jalr
);
/*

pcSel:
00- pc+4
01- pc+imm
10- rs1+imm
11 - halt - pc



*/

/*

write back data:
Alu out - 00
Memory - 01
pc+4 - 10
X - 11



*/

/*

mux for pcSel mux output and signal from ecall and fence to jump to address 0

0: pcSel outout
1: jump to address 0
*/
always @ * begin
    jump = 0;
    jal_jalr= 0;
    alusrc1 = 0;
    case(opcode)
        `OPCODE_Branch: begin
            readSize = 3'b111;  // Load_pass macro
            pcSel = 0; // 01
            memRead = 0;
            writeBackVal = 0;
            memWrite = 0;
            alusrc2 = 0;
            regWrite = 0;
            branch = funct3;
            ALUOp = `ALU_SUB;
            storeSize = funct3[`STORE_r];
            jStart = 0;
        end
        `OPCODE_Load: begin
            pcSel = 0;
            memRead = 1;
            writeBackVal = 1;
            memWrite = 0;
            alusrc2 = 1;
            regWrite = 1;
            branch = `BR_PASS;
            ALUOp = `ALU_ADD;
            readSize = funct3;
            storeSize = funct3[`STORE_r];
            jStart = 0;
        end
        `OPCODE_Store: begin
            pcSel = 0; // no jump
            memRead = 0;  // no load
            writeBackVal = 0; // alu result at 0
            memWrite = 1;  // no write
            alusrc2 = 1;   //immgen source
            regWrite = 1;  //store in rd
            ALUOp = `ALU_ADD; // No alu op
            branch = `BR_PASS; //no branch
            readSize = 3'b111;  /// load pass
            storeSize = funct3[`STORE_r];
            jStart = 0;
        end


        `OPCODE_JALR: begin  // rd = pc+4, pc = rs1 + imm
            pcSel = 0; // jump
            jal_jalr = 1;
            memRead = 0;  // no load
            writeBackVal = 2; // pc+4 to rd
            memWrite = 0;  // no write
            alusrc2 = 1;   //immgen source
            regWrite = 1;  //store in rd
            ALUOp = `ALU_ADD; // add pc + imm
            branch = `BR_PASS; //no branch
            readSize = 3'b111; //  `LOAD_pass;
            storeSize = funct3[`STORE_r];
            jStart = 0;
            jump = 1;
        end
        `OPCODE_JAL: begin  // rd = pc+4, pc += imm
            pcSel =0; // jump
            jal_jalr = 1;
            memRead = 0;  // no load
            writeBackVal = 2; // pc+4 to rd
            memWrite = 0;  // no write
            alusrc2 = 1;   //immgen source
            regWrite = 1;  //store in rd
            ALUOp = `ALU_ADD; // add pc + imm
            branch = `BR_PASS; //no branch
            readSize = 3'b111; //  `LOAD_pass;
            storeSize = funct3[`STORE_r];
            jStart = 0;
        end
        `OPCODE_Arith_I: begin
            pcSel = 0;
            memRead = 0;
            writeBackVal = 0;
            memWrite = 0;
            alusrc2 = 1; //immgen
            regWrite = 1;
            case(funct3) 
                `F3_ADD: ALUOp = `ALU_ADD;
                `F3_SLL: ALUOp = `ALU_SLL;
                `F3_SLT: ALUOp = `ALU_SLT;
                `F3_SLTU: ALUOp = `ALU_SLTU;
                `F3_XOR: ALUOp = `ALU_XOR;
                `F3_SRL: begin
               
                    case(funct7[5]) 
                    0: ALUOp = `ALU_SRL;
                    1: ALUOp = `ALU_SRA;
                    default: ALUOp = `ALU_PASS;
                    endcase
                    end
                
                `F3_OR: ALUOp = `ALU_OR;
                `F3_AND: ALUOp = `ALU_AND;
                default:
                    ALUOp = `ALU_PASS;
            endcase
            branch = `BR_PASS; //no branch
            readSize = 3'b111;
            storeSize = funct3[`STORE_r];
            jStart = 0;
        end  
        `OPCODE_Arith_R: begin
            pcSel = 0; // no jump
            memRead = 0;  // no load
            writeBackVal = 0; // alu result at 0
            memWrite = 0;  // no write
            alusrc2 = 0;   // rs2
            regWrite = 1;  //store in rd
            case(funct3)
                `F3_ADD: begin
                    case(funct7[5])
                        0: ALUOp = `ALU_ADD;
                        1: ALUOp = `ALU_SUB;
                        default:
                        ALUOp = `ALU_PASS;
                        endcase 
                     end
                    
                `F3_SLL: ALUOp = `ALU_SLL;
                `F3_SLT: ALUOp = `ALU_SLT;
                `F3_SLTU: ALUOp = `ALU_SLTU;
                `F3_XOR: ALUOp = `ALU_XOR;
                `F3_SRL: case(funct7[5]) 
                            0: ALUOp = `ALU_SRL;
                            1: ALUOp = `ALU_SRA;
                            default: ALUOp = `ALU_PASS;
                            endcase
                `F3_OR: ALUOp = `ALU_OR;
                `F3_AND: ALUOp = `ALU_AND;
                 default: ALUOp = `ALU_PASS;
            endcase
            branch = `BR_PASS; //no branch
            readSize = 3'b111;//`LOAD_pass;
            storeSize = funct3[`STORE_r];
            jStart = 0;
        end

        `OPCODE_AUIPC: begin   // auipc, rd = PC+(imm <<12)
            pcSel = 0; 
            memRead = 0;  
            jal_jalr = 0;
            writeBackVal = 0; 
            memWrite = 0;  
            alusrc2 = 1;
            
            alusrc1 = 1;
            regWrite = 1;  
            ALUOp = `ALU_ADD; 
            branch = `BR_PASS; 
            readSize = 3'b111 ;//`LOAD_pass;
            storeSize = funct3[`STORE_r];
            jStart = 0;
        end

        `OPCODE_LUI: begin //rd = imm <<12
            pcSel = 0; 
            memRead = 0; 
            writeBackVal = 0; 
            memWrite = 0;  
            alusrc2 = 1;  
            regWrite = 1;  
            ALUOp = `ALU_PASS; 
            branch = `BR_PASS; 
            readSize =3'b111;// `LOAD_pass;
            storeSize = funct3[`STORE_r];
            jStart = 0;
        end

        `OPCODE_Fence: begin //fence
            pcSel = 0; 
            memRead = 0;  
            writeBackVal = 0; 
            memWrite = 0;  
            alusrc2 = 0;   
            regWrite = 0;  
            ALUOp = `ALU_PASS; 
            branch = `BR_PASS; 
            readSize =3'b111;// `LOAD_pass;
            storeSize = funct3[`STORE_r];
            jStart = 1; // mux select for jumping to address 0


        end
        
        `OPCODE_SYSTEM: begin    //ecall and fence 
            case(funct7[5])
                0: begin   //ecall
                    pcSel = 0; 
                    memRead = 0;  
                    writeBackVal = 0; 
                    memWrite = 0;  
                    alusrc2 = 0;   
                    regWrite = 0;  
                    ALUOp = `ALU_PASS; 
                   branch = `BR_PASS; 
                    readSize =3'b111;// `LOAD_pass;
                    storeSize = funct3[`STORE_r];
                    jStart = 1; // mux select for jumping to address 0
                end
                1: begin  //ebreak
//                    pcSel = 2'b11; 
                    pcSel = 1;
                    memRead = 0;  
                    writeBackVal = 0; 
                    memWrite = 0;  
                    alusrc2 = 0;   
                    regWrite = 0;  
                    ALUOp = `ALU_PASS; 
                    branch = `BR_PASS; 
                    readSize = 3'b111; // `LOAD_pass;
                    storeSize = funct3[`STORE_r];
                    jStart = 0;
                end

            endcase
           end

        `OPCODE_Custom: begin
            pcSel = 0;
            memRead = 0;
            writeBackVal = 0;
            memWrite = 0;
            alusrc2 = 0;
            regWrite = 0;
            ALUOp = `ALU_PASS;
            branch = `BR_PASS;
            readSize = 3'b111;//`LOAD_pass;
            storeSize = funct3[`STORE_r];
            jStart = 0;
            end
        default: begin
            pcSel = 0;
            memRead = 0;
            writeBackVal = 0;
            memWrite = 0;
            alusrc2 = 0;
            regWrite = 0;
            ALUOp = `ALU_PASS;
            branch = `BR_PASS;
            readSize =3'b111;// `LOAD_pass;
            storeSize = funct3[`STORE_r];
            jStart = 0;
            end
        endcase
    
    end
    



endmodule



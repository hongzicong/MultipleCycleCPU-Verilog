`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 09:12:25
// Design Name: 
// Module Name: main
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


`include "PC.v"
`include "IR.v"
`include "ALU.v"
`include "PC4.v"
`include "ControlUnit.v"
`include "DataSelect32.v"
`include "DataSelect32_plus.v"
`include "DataSelect5.v"
`include "SignOrZeroExtend.v"
`include "PCImmediate.v"
`include "Register.v"
`include "RAM.v"
`include "ROM.v"

module main(
    input CLK,
    input RST);
    
    // in_pc is the input of PC, if PC says yes, then give output
    // out_pc_2 is instruction
    // out_pc_1 is address of next instruction
    wire [31:0] in_pc, out_pc, out_pc_1, out_pc_2, out_pc_3, out_pc_extend, out_pc_temp;
    wire [31:0] ALUResult, DataOut, WriteData;
    wire [2:0] ALUOp;
    
    wire Zero, ExtSel, PCWre, RegWre, ALUSrcA, ALUSrcB, DBDataSrc, mWR, mRD, InsMemRW, WrRegDSrc, IRWre;
    wire [1:0] PCSrc, RegDst;
    
    wire [31:0] ReadData1, ReadData2;
    wire [4:0] WriteReg;
    
    wire [31:0] sa_extend;
    assign sa_extend = {{17{0}}, out_pc_2[10:6]};
    
    wire [31:0] A, B;
    
    wire [31:0] DB;

    wire [4:0] RS, RT, RD;
    assign RS = out_pc_2[25:21];
    assign RT = out_pc_2[20:16];
    assign RD = out_pc_2[15:11];
    
    wire [15:0] IMM;
    assign IMM = out_pc_2[15:0];
    
    // TODO
    wire [31:0] JMP;
    assign JMP = {out_pc_1[31:28], out_pc_2[25:0], 1'b0, 1'b0};

    wire [31:0] IROut;
    reg [31:0] ADR;
    reg [31:0] BDR;
    reg [31:0] ALUoutDR;
    reg [31:0] DBDR;

    always @(posedge CLK) begin
        ADR = ReadData1;
        BDR = ReadData2;
        ALUoutDR = ALUResult;
        DBDR = DB;
    end
    
    PC PC(CLK, RST, PCWre, in_pc, out_pc);
    
    PC4 PC4(out_pc, out_pc_1);
    
    ROM ROM(InsMemRW, out_pc, out_pc_temp);

    IR IR(CLK, out_pc_temp, IRWre, out_pc_2);
    
    ControlUnit ControlUnit(out_pc_2[31:26], Zero, CLK, RST, Sign, WrRegDSrc, IRWre, ExtSel, PCWre, InsMemRW, ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc, RegWre, RegDst, PCSrc, ALUOp);
    
    ALU ALU(A, B, ALUOp, ALUResult, Zero, Sign);
    
    DataSelect32 DataSelect32_A(ADR, sa_extend, ALUSrcA, A);
    
    DataSelect32 DataSelect32_B(BDR, out_pc_extend, ALUSrcB, B);
    
    SignOrZeroExtend SignOrZeroExtend(IMM, ExtSel, out_pc_extend);
    
    PCImmediate PCImmediate(out_pc_1, out_pc_extend, out_pc_3);
    
    DataSelect32_plus DataSelect32_plus(out_pc_1, out_pc_3, ReadData1, JMP, PCSrc, in_pc);
    
    RAM RAM(CLK, mRD, mWR, ALUoutDR, ReadData2, DataOut);
    
    DataSelect32 DataSelect32_Result(ALUResult, DataOut, DBDataSrc, DB);
    
    DataSelect32 DataSelect32_Write(out_pc_1, DBDR, WrRegDSrc, WriteData);

    DataSelect5 DataSelect5(RT, RD, RegDst, WriteReg);
    
    Register Register(CLK, RS, RT, WriteReg, RegWre, WriteData, ReadData1, ReadData2);
    
endmodule

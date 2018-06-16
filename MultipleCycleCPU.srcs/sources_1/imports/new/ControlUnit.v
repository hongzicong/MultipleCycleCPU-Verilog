`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 10:18:56
// Design Name: 
// Module Name: ControlUnit
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

`include "head.v"

module ControlUnit(
    input [5:0] OpCode,
    input Zero, 
    input CLK,
    input RST,
    input Sign,
    output wire WrRegDSrc,
    output reg IRWre,
    output wire ExtSel,
    output reg PCWre,
    output reg InsMemRW,
    output wire ALUSrcA,
    output wire ALUSrcB,
    output reg mRD,
    output reg mWR,
    output wire DBDataSrc,
    output reg RegWre,
    output wire [1:0] RegDst,
    output wire [1:0] PCSrc,
    output wire [2:0] ALUOp);

    reg [2:0] currState;
    reg [2:0] nextState;
    parameter [2:0] sIF = 3'b000,
                    sID = 3'b001,
                    sEXE = 3'b010,
                    sMEM = 3'b100,
                    sWB = 3'b011,
                    halt = 3'b111;

    assign ALUSrcA = (OpCode == `opSll);
    assign ALUSrcB = (OpCode == `opAddi || OpCode == `opOri || OpCode == `opSltiu || OpCode == `opLw || OpCode == `opSw);
    
    assign ALUOp[2] = (OpCode == `opAnd || OpCode == `opOr || OpCode == `opOri || OpCode == `opSll);
    assign ALUOp[1] = (OpCode == `opAnd || OpCode == `opSlt || OpCode == `opSltiu);
    assign ALUOp[0] = (OpCode == `opSub || OpCode == `opSlt || OpCode == `opOr || OpCode == `opOri);
    
    assign RegDst[1] = (OpCode == `opAdd || OpCode == `opSub || OpCode == `opOr || OpCode == `opAnd || OpCode == `opSll || OpCode == `opSlt);
    assign RegDst[0] = (OpCode == `opAddi || OpCode == `opOri || OpCode == `opSltiu || OpCode == `opLw);
    
    assign PCSrc[1] = (OpCode == `opJ || OpCode == `opJal || OpCode == `opJr);
    assign PCSrc[0] = (OpCode == `opJ || OpCode == `opJal || (Zero == 1 && OpCode == `opBeq) || (Zero == 0 && Sign == 1 && OpCode == `opBltz));
    
    assign ExtSel = (OpCode == `opOri || OpCode == `opSltiu) ? 0 : 1;
    assign WrRegDSrc = (OpCode == `opJal) ? 0 : 1;
    
    assign DBDataSrc = (OpCode == `opLw);


    initial begin
        currState = 3'b000;
        InsMemRW = 1;
    end

    always @(posedge CLK or negedge RST)
    begin
        if(RST == 0)
        begin
            currState <= halt;
            nextState = sIF;
        end
        else
            currState <= nextState;
    end

    always @(currState)
    begin
        case(currState)
        sIF:
        begin
            PCWre = 1;
            IRWre = 1;
            RegWre = 0;
            mRD = 1;
            mWR = 1;
            nextState = sID;
        end

        sID:
        begin
            PCWre = 0;
            IRWre = 0;
            if(OpCode[5:3] == 3'b111)
            begin
                nextState = sIF;
                // jal
                if(OpCode == `opJal)
                    RegWre = 1;
                // halt
                if(OpCode == `opHalt)
                    nextState = halt;
            end
            else
                nextState = sEXE;
        end


        sEXE:
        begin
            // beq, bltz
            if(OpCode[5:2] == 4'b1101)
                nextState = sIF;
            // sw, lw
            else if(OpCode[5:4] == 2'b11)
                nextState = sMEM;
            // other
            else
                nextState = sWB;
        end

        sMEM:
        begin
            if(OpCode[1:0] == 2'b01)
            begin
                nextState = sWB;
                mRD = 0;
            end
            else
            begin
                nextState = sIF;
                mWR = 0;
            end
        end

        sWB:
        begin
            nextState = sIF;
            // because each instruction which doesn't have RegWre will not reach to WB state
            RegWre = 1;
        end

        halt:
        begin
            PCWre = 0;
            IRWre = 0;
            nextState = halt;
            RegWre = 0;
            mRD = 1;
            mWR = 1;
        end

        default:
        begin
            nextState = halt;
        end
        endcase
    end
    

endmodule
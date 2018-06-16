`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 10:18:56
// Design Name: 
// Module Name: ROM
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


module ROM(
    input InsMemRW,
    // up to 32 instructions
    input [31:0] IAddr,
    // each instruction has 32 bits
    output reg [31:0] Instruction
    );
    
    // each item is 8 bits and memory array has 128 items
    // each instruction needs 4 items because each instruction is 32 bits
    // so the memory can include 32 instructions
    reg [7:0] MEM [0:127];
    
    initial 
    begin
        $readmemb("E:/Vivado_workspace/MultipleCycleCPU/MultipleCycleCPU.srcs/sources_1/imports/new/testdata.txt", MEM);
        Instruction = 0;
    end
    
    always @(IAddr)
        if (InsMemRW) 
        begin
        // big endian
            Instruction[31:24] = MEM[IAddr];
            Instruction[23:16] = MEM[IAddr + 1];
            Instruction[15:8] = MEM[IAddr + 2];
            Instruction[7:0] = MEM[IAddr + 3];
        end
endmodule

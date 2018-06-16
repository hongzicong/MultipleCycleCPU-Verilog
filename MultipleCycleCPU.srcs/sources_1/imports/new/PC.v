`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 08:57:48
// Design Name: 
// Module Name: PC
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


module PC(
    input wire CLK,
    input wire RST,
    input wire PCWre,
    input wire [31:0] in_pc,
    output reg [31:0] out_pc
    );
    
    initial
    begin
        out_pc = 0;
    end
    
    always @(negedge CLK) begin
        if (PCWre) 
        begin
            out_pc = in_pc;
        end
        else if (!PCWre) 
        // halt
        begin
            out_pc = out_pc;
        end
    end
endmodule

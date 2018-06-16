`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 21:31:36
// Design Name: 
// Module Name: DataSelect32_plus
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


module DataSelect32_plus(
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [1:0] PCSrc,
    input [31:0] out
    );
    assign out = (PCSrc[1] == 1 ? (PCSrc[0] == 1? in3 : in2) : (PCSrc[0] == 1? in1 : in0));
endmodule

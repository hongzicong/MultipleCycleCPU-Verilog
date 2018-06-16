`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 16:49:06
// Design Name: 
// Module Name: DataSelect32
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


module DataSelect32(
    input [31:0] A,
    input [31:0] B,
    input Control,
    output [31:0] S
    );
    assign S = (Control == 1'b0 ? A : B);
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 17:12:10
// Design Name: 
// Module Name: SignOrZeroExtend
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


module SignOrZeroExtend(
    input [15:0] in,
    input ExtSel,
    output [31:0] out
    );
    assign out[15:0] = in[15:0];
    assign out[31:16] = (ExtSel && in[15]) ? 16'hFFFF : 16'h0000;
endmodule

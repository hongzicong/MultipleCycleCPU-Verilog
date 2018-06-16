`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 17:06:51
// Design Name: 
// Module Name: DataSelect5
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


module DataSelect5(
    input [4:0] RT,
    input [4:0] RD,
    input [1:0] RegDst,
    output [4:0] S
    );
    assign S = (RegDst[1] == 1'b1)? RD : ((RegDst[0] == 1'b1)? RT : 5'b11111);
endmodule
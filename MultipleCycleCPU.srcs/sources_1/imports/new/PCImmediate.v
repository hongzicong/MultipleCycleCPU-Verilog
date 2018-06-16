`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 17:31:29
// Design Name: 
// Module Name: PCImmediate
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


module PCImmediate(
    input [31:0] in,
    input [31:0] add,
    output [31:0] out
    );
    // << 2
    assign out = in + (add * 4);
endmodule

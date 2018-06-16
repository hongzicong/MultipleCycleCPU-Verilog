`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 10:22:13
// Design Name: 
// Module Name: PC4
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


module PC4(
    input wire [31:0] in_pc,
    output wire [31:0] out_pc
    );
    assign out_pc[31:0] = in_pc[31:0] + 4;
endmodule

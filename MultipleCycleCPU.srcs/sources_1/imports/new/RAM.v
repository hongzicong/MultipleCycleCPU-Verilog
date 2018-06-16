`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 20:13:27
// Design Name: 
// Module Name: RAM
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


module RAM(
    input CLK,
    input mRD,
    input mWR,
    input [31:0] IAddr,
    input [31:0] in_data,
    output reg [31:0] out_data
    );
    reg [7:0] memory [0:127];
    
    integer i;
    initial begin
        for (i = 0; i < 128; i = i + 1) begin
            memory[i] = 0;
        end
    end
    
    always @(negedge CLK) 
    begin
        if (~mWR) 
        begin
            memory[IAddr] = in_data[31:24];
            memory[IAddr + 1] = in_data[23:16];
            memory[IAddr + 2] = in_data[15:8];
            memory[IAddr + 3] = in_data[7:0];
        end
        else if(~mRD)
        begin
            out_data[31:24] = memory[IAddr];
            out_data[23:16] = memory[IAddr + 1];
            out_data[15:8] = memory[IAddr + 2];
            out_data[7:0] = memory[IAddr + 3];
        end
    end
endmodule

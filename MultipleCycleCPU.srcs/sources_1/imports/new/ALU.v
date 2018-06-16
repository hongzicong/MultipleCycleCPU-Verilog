`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 08:45:46
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] ALUOp,    
    output reg [31:0] result,
    output zero,
    output sign
    );
    initial begin
        result = 0;
    end
    // if result = 0 then zero = 1 otherwise zero = 0
    // assign is Continuous Assignments
    assign zero = (result? 0 : 1);
    
    assign sign = (result[31]? 1 : 0);

    // if A or B or ALUOp change then result change
    always @(A or B or ALUOp) begin
        case(ALUOp)
            3'b000: result = A + B;
            3'b001: result = A - B;
            3'b010: result = (A < B) ? 1 : 0;
            3'b011: result = (((A < B) && (A[31] == B[31])) || ((A[31] && !B[31]))) ? 1 : 0;
            3'b100: result = B << A;
            3'b101: result = A | B;
            3'b110: result = A & B;
            3'b111: result = A ^ B;
        endcase
    end
endmodule

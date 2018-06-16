`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/25 20:45:52
// Design Name: 
// Module Name: Register
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


module Register(
    input CLK,
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg,
    input RegWre,
    input [31:0] WriteData,
    output [31:0] ReadData1,
    output [31:0] ReadData2
    );
    
    reg [31:0] register[0:31];
    initial begin
        register[0] = 0;
    end
    
    // RS : address of rs
    // RT : address of rt
    // RS -> ReadData1  RT -> ReadData2 
    assign ReadData1 = register[ReadReg1];
    assign ReadData2 = register[ReadReg2];
    
    always @(negedge CLK) 
    begin
        if (RegWre && WriteReg) 
        begin
            register[WriteReg] = WriteData;
        end
            
    end
        
endmodule

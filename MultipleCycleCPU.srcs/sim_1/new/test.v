`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 17:19:29
// Design Name: 
// Module Name: test
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


module test;
    
    // input
    reg CLK;
    reg Reset;
    
    main main(CLK, Reset);
    
	initial 
	begin
        // Initialize Inputs
        CLK = 0;
        Reset = 1;
        #100;
        
        // Wait 100 ns for global reset to finish
      forever #100 CLK = ~CLK;
        
        // Add stimulus here

    end
        
endmodule

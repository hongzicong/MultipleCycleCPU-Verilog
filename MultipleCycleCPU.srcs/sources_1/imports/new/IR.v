module IR(
    input CLK,
    input [31:0] currIns,
    input IRWre,
    output reg [31:0] IROut
    );

    always @(posedge CLK) begin
        if (IRWre)
            IROut = currIns;
    end

endmodule
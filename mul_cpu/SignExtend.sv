
`timescale 1ns / 1ps

module SignExtend(immediate, ExtSel, out);
	input [31:0] immediate;
    input [1:0] ExtSel;
	output [31:0] out;

    reg [31:0]out_reg;

    assign out = out_reg;

	always @(*)begin
        if(ExtSel == 2'b00) begin 
            out_reg[15:0]  = immediate;
            out_reg[31:16] = immediate[15] ? 16'hffff : 16'h0000;
        end
        else if(ExtSel == 2'b01) begin 
            out_reg[1:0] = 2'b0;
            out_reg[17:2]  = immediate;
            out_reg[31:18] = immediate[15] ? 14'b1111_1111_1111_11 : 14'b0000_0000_0000_00;
        end
        else if(ExtSel == 2'b10) begin
            out_reg[31:0] = 4;
        end
        else if(ExtSel == 2'b11) begin
            out_reg[31:0] = 0;
            out_reg [27:2] = immediate[15:0];
        end
    end

endmodule
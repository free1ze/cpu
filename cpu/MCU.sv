`timescale 1ns / 1ps

module MCU(inst, RegDst, ALUSrc, MemtoReg, RegWr, MemWr, MemRd, Branch, Jump, ALUOp1, ALUOp0);
	input [5:0]inst;
	output RegDst, ALUSrc, MemtoReg, RegWr, MemWr, MemRd, Branch, Jump, ALUOp1, ALUOp0;

	reg [9:0]out;

	assign {RegDst, ALUSrc, MemtoReg, RegWr, MemWr, MemRd, Branch, Jump, ALUOp1, ALUOp0} = out;

	always@(*) begin
		if(inst == 6'b000000) out = 10'b1001000010;
		else if(inst == 6'b100011) out = 10'b0111010000;
		else if(inst == 6'b101011) out = 10'bx1x0100000;
		else if(inst == 6'b000100) out = 10'bx0x0001001;
		else if(inst == 6'b000010) out = 10'bxxx00001xx;
	end
	
endmodule
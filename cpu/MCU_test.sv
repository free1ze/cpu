`timescale 1ns / 1ps
`include"MCU.sv"

module MCU_test();
	reg [5:0] inst = 6'b100011;
	reg RegDst, ALUSrc, MemtoReg, RegWr, MemWr, MemRd, Branch, Jump, ALUOp1, ALUOp0;

	MCU m(inst, RegDst, ALUSrc, MemtoReg, RegWr, MemWr, MemRd, Branch, Jump, ALUOp1, ALUOp0);
endmodule
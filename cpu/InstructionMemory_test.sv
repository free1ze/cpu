
`timescale 1ns / 1ps
`include"InstructionMemory.sv"

module InstructionMemory_test();
	reg [31:0] addr=0,out;
	
	always #10 addr = addr + 4;
	InstructionMemory m(addr, out);
endmodule
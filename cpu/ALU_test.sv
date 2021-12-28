
`timescale 1ns / 1ps
`include"ALU.sv"

module ALU_test();
	reg [31:0] A=32'h1234,B=32'h1234,out;
	reg [2:0]ALUCtrl = 0;
	reg Zero;

	always #10 ALUCtrl = ALUCtrl + 1;

	ALU m(A, B, ALUCtrl, Zero, out);
endmodule
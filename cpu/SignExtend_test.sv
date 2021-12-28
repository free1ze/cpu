
`timescale 1ns / 1ps
`include "SignExtend.sv"

module SignExtend_test();

	reg [15:0] in = 1;
	reg [31:0] out;	
	
	initial begin	
		forever #10  in = in + 1;	
	end
	SignExtend m(in, out);
endmodule
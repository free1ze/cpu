
`timescale 1ns / 1ps
`include "Multiplexer.sv"

module Multiplexer_test();

	reg select;
	reg [31:0]  a, b; 
	reg [31:0] out;	
	
	initial begin
		select = 1'b1;
		a = 32'h0001;
		b = 32'h0000; 
		forever #10 assign select = ~select;
	end 
	Multiplexer m(a,b,select,out);
endmodule
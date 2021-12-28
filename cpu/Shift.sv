`timescale 1ns / 1ps

module Shift(immediate, out);
	input [31:0] immediate;
	output [31:0] out;

	assign out = immediate * 4;

endmodule

`timescale 1ns / 1ps

module Shift_26(immediate, out);
	input [25:0] immediate;
	output [27:0] out;

	assign out[27:2]  = immediate;
	assign out[1:0] = 2'b0;

endmodule
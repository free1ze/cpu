`timescale 1ns / 1ps

module Multiplexer(signal_a, signal_b, select, signal_out);
	input [31:0] signal_a, signal_b;
	input select;
	output [31:0] signal_out;

	assign signal_out = select? signal_b: signal_a;
endmodule

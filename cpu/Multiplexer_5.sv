`timescale 1ns / 1ps

module Multiplexer_5(signal_a, signal_b, select, signal_out);
	input [4:0] signal_a, signal_b;
	input select;
	output [4:0] signal_out;

	assign signal_out = select? signal_b: signal_a;
endmodule
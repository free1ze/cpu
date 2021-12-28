


`timescale 1ns / 1ps

module ThreeStateGate(immediate, ctrl, out);
	input [100:0] immediate;    //unknown width, declare to 100 and the reset will be cut off
	input ctrl;
	output [100:0] out;

	assign out = ctrl ? immediate : 100'bz;

endmodule
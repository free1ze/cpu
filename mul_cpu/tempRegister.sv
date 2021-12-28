

`timescale 1ns / 1ps

module tempRegister(immediate, AOe, AWr, out);
	input [31:0] immediate;
	input AOe, AWr;
	output [31:0] out;

	reg [31:0] out_data;
	assign 	out = AOe ? out_data : 32'bz;

	initial begin
		out_data = 32'bz;
	end

	always@(*) begin
		if(AWr)out_data = immediate;
	end

endmodule
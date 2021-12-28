`timescale 1ns / 1ps

module PC(clk, data, out);
	input clk;
	input [31:0] data;
	output [31:0] out;

	reg [31:0] addr = 0;

	assign out = addr;

	always@(posedge clk) begin
		addr = data; 
	end

endmodule

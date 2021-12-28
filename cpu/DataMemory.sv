
`timescale 1ns / 1ps

module DataMemory(w_data, addr, R, W, out);
	input [31:0] addr, w_data;
	input R, W;
	output [31:0] out;

	reg [31:0]memory[0:1024-1];

	initial begin
		for (int i=0; i<1024; i++) begin
			memory[i] = i;
		end
	end

	assign out = R ? memory[addr] : out;

	always@(*) begin
		if(W) memory[addr] = w_data;
	end

endmodule
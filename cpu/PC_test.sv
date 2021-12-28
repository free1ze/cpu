
`timescale 1ns / 1ps
`include"PC.sv"


module PC_test();
	reg clk = 0;
	reg [31:0] data = 0;
	reg [31:0] out;

	initial begin
		forever begin 
			#10 
			clk = ~clk;
			data = data + 4;
			#10
			clk = ~clk;
		end
	end

	PC m(clk, data, out);

endmodule
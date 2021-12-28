
`timescale 1ns / 1ps
`include"PC.sv"

module RegisterFile_test ;

	reg clk = 0, wr_sig = 1;
	reg [31:0] w_data = 32'h1234;
	reg [31:0] r1=1,r2=2,w=4;
	
	reg [31:0] out1, out2;

	initial begin
		forever begin 
			#10 
			clk = ~clk;
			r1 = r1 + 1;
			r2 = r2 + 1;
			w = w + 1;
			#10
			clk = ~clk;
		end
	end

	RegisterFile m(clk, wr_sig, w_data, r1, r2, w, out1, out2);

endmodule
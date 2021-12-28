
`timescale 1ns / 1ps
`include"DataMemory.sv"


module DataMemory_test();

	
	reg [31:0] w_data = 32'h1000;
	reg [31:0] out;
	reg R=0,W=1;
	
	always begin
		# 10
		R = ~R;
		W = ~W;
		w_data = w_data + 1;
	end
	DataMemory m(w_data, 1, R, W, out);

endmodule
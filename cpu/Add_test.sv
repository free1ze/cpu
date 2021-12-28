

`timescale 1ns / 1ps
`include"Add.sv"


module Add_test();
	reg clk = 0;
	reg [31:0] in1 = 32'h4321, in2 = 32'h1234;
	reg [31:0] out;


	Add m(in1, in2, out);

endmodule
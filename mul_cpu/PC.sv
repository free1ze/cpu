
`timescale 1ns / 1ps

module PC(clk, in_data, PCOe, PCWr, out);
	input clk, PCOe, PCWr;
	input [31:0] in_data;
	output [31:0] out;

	reg [31:0] addr = 1024, out_data=0;			//init pc to 1024, the first instruction

	assign out = out_data;

	always@(posedge clk or PCOe) begin
		if(PCWr) begin
            addr = in_data; 
        end
        out_data = PCOe ? addr : 32'bz;
	end

endmodule

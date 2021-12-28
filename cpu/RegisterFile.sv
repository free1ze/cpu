`timescale 1ns / 1ps

module RegisterFile(clk, Regwr, w_data, R_reg1, R_reg2, w_Reg, R_data1, R_data2);
	input [31:0] w_data;
	input [4:0] R_reg1, R_reg2, w_Reg; 
	input clk, Regwr;
	output [31:0] R_data1, R_data2;

	reg[31:0] registers[0:31];
	reg[31:0] read1=0, read2=0;

	initial begin
		for(int i=0; i<32; i++) begin
			registers[i] = 0;
		end	
	end

	assign R_data1 = read1;
	assign R_data2 = read2;

	always @(posedge clk) begin
		if( Regwr ) begin
			registers[w_Reg] = w_data;
		end
	end

	always@(*) begin
		read1 = registers[R_reg1];
		read2 = registers[R_reg2];
	end
	
endmodule
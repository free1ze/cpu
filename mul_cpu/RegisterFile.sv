
`timescale 1ns / 1ps

module RegisterFile(clk, Regwr, Reg1Oe, Reg2Oe, w_data, R_reg1, R_reg2, w_Reg, R_data1, R_data2);
	input [31:0] w_data;
	input [4:0] R_reg1, R_reg2, w_Reg; 
	input clk, Regwr, Reg1Oe, Reg2Oe;
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

	always @(posedge clk or w_data or R_reg1 or  R_reg2 or w_Reg or Regwr or Reg1Oe or Reg2Oe) begin
		if( Regwr ) begin
			registers[w_Reg] = w_data;
		end
	end

	always@(*) begin
		read1 = Reg1Oe ? registers[R_reg1] :32'bz;
		read2 = Reg2Oe ? registers[R_reg2] :32'bz;
	end
	
endmodule
`timescale 1ns / 1ps

module ALUCU(inst, ALUOp0, ALUOp1, ALUCtrl);
	input [5:0]inst;
	input ALUOp0, ALUOp1;
	output [2:0]ALUCtrl;

	reg [2:0]result;
	assign ALUCtrl = result;

	always@(*) begin
		//ADD
		if({ALUOp1, ALUOp0} == 2'b00) result = 3'b100;
		//SUB
		else if(ALUOp0 == 1'b1) result = 3'b110;

		else if(ALUOp1 == 1'b1) begin
			//ADD
			if(inst == 6'b100000) result = 3'b100;
			//ADDU
			else if(inst == 6'b100001) result = 3'b101;
			//SUB
			else if(inst == 6'b100010) result = 3'b110;
			//AND
			else if(inst == 6'b100100) result = 3'b000;
			//OR
			else if(inst == 6'b100101) result = 3'b001;
			//SLT
			else if(inst == 6'b101010) result = 3'b011;
		end
		//unknown
		else result = 3'bzzz;
	end


endmodule

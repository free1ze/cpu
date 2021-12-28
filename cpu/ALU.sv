`timescale 1ns / 1ps

module ALU(A, B, ALUCtrl, Zero, out);
	input [31:0] A,B;
	input [2:0] ALUCtrl;
	output Zero;
	output [31:0]out;

	reg [31:0] result;
	reg result_z;
	assign out = result;
	assign Zero = result_z;
	
	always@(*) begin
		//AND
		if(ALUCtrl == 3'b000) result = A & B;
		//OR
		else if(ALUCtrl == 3'b001) result = A | B;
		// unused
		//else if(ALUCtrl == 3'b010) result = A + 1;
		// SLT
		else if(ALUCtrl == 3'b011) result = A < B ? 1 : 0;
		//ADD
		else if(ALUCtrl == 3'b100) result = A + B;
		//ADDU
		else if(ALUCtrl == 3'b101) result = A + B;
		//SUB
		else if(ALUCtrl == 3'b110) result = A - B;
		// unused
		//else if(ALUCtrl == 3'b111) result = A & B;
		//unknown
		else result = 32'bx;

		result_z = (result == 0)? 1 : 0;
	end

endmodule
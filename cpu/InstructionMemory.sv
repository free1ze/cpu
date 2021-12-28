
`timescale 1ns / 1ps

module InstructionMemory(addr, out);
	input [31:0] addr;
	output [31:0] out;

	reg [31:0] addr_res;
	reg [31:0] memory[0:1024-1];	//store in byte
	
	assign out = addr_res;

	initial begin
		memory[0] = 32'h8c010001;	//LW $1,1($0) 	
		memory[1] = 32'h8c020002;	//LW $2,2($0)     
		memory[2] = 32'h00221820;	//Add $3, $1, $2  
		memory[3] = 32'hac030005;	//SW  $3,5($0)    
		memory[4] = 32'h00611822;	//SUB $3, $3, $1
		memory[5] = 32'h10610001;	//BEQ $3, $1, 1
		memory[6] = 32'h08000004;	//J 4
		memory[7] = 32'hac030005;	//SW  $3,5($0)   

	end

	always@(addr) begin
		addr_res = memory[addr/4];
	end

endmodule

`timescale 1ns / 1ps

module DataMemory(w_data, addr, R, W, out);
	input [31:0] addr, w_data;
	input R, W;
	output [31:0] out;
	
	reg [31:0]memory[0:2048-1];
	//memory[0-1023] 		data
	//memory[1024-2047]		instruction
	initial begin
		
		for (int i=0; i<1024; i++) begin
			memory[i] = i;
		end
		memory[1024+0] = 32'h8c010001;	//LW $1,1($0) 	
		memory[1024+1] = 32'h8c020002;	//LW $2,2($0)     
		memory[1024+2] = 32'h00221820;	//Add $3, $1, $2  
		memory[1024+3] = 32'hac030005;	//SW  $3,5($0)    
		memory[1024+4] = 32'h00611822;	//SUB $3, $3, $1
		memory[1024+5] = 32'h10610001;	//BEQ $3, $1, 1
		memory[1024+6] = 32'h08000104;	//J 1024+4
		memory[1024+7] = 32'hac030005;	//SW  $3,5($0)   
		memory[1024+8] = 32'hz;			//finish  

		
	end

	assign out = R ? memory[ addr >= 1024 ? (addr-1024)/4+1024 : addr] : 32'bz;		//if  is inst address, convert 8bit addr to 32bit

	always@(*) begin
		if(W) memory[addr] = w_data;
	end

endmodule
`timescale 1ns/1ns

`include"Shift.sv"
`include"Shift_26.sv"
`include"SignExtend.sv"
`include"RegisterFile.sv"
`include"PC.sv"
`include"Multiplexer.sv"
`include"Multiplexer_5.sv"
`include"MCU.sv"
`include"InstructionMemory.sv"
`include"DataMemory.sv"
`include"ALUCU.sv"
`include"ALU.sv"
`include"ADD.sv"

module cpu();

    //gen clock 
    reg clk = 0;
    always #10 clk = ~clk;

    //wires
    wire [31:0] pc_out, inst, rf_out1, rf_out2, sigext_out, 
    mux_32_out1, mux_32_out2, mux_32_out3, mux_32_out4,alu_out, dm_out,shl_32_out, add1_out, add2_out;
    wire [27:0] sfl_26_out;
    wire [4:0] mux_5_out;
    wire [2:0] ALUCtrl;
    wire RegDst, ALUSrc, MemtoReg, RegWr, MemWr, MemRd, Branch, Jump, ALUOp1, ALUOp0;
    wire Zero;

    //components
    PC pc(clk , mux_32_out4, pc_out);
    InstructionMemory im(pc_out, inst);
    MCU mcu(inst[31:26], RegDst, ALUSrc, MemtoReg, RegWr, MemWr, MemRd, Branch, Jump, ALUOp1, ALUOp0);
    Shift_26 sf_26(inst[25:0], sfl_26_out);
    Multiplexer_5 mux_5(inst[20:16], inst[15:11], RegDst, mux_5_out);
    RegisterFile rf(clk, RegWr,  mux_32_out2, inst[25:21], inst[20:16], mux_5_out, rf_out1, rf_out2);
    
    SignExtend sigext(inst[15:0], sigext_out);
    ALUCU alucu(inst[5:0], ALUOp0, ALUOp1, ALUCtrl);
    Multiplexer mux_32_1(rf_out2, sigext_out, ALUSrc, mux_32_out1);
    ALU alu(rf_out1, mux_32_out1, ALUCtrl, Zero, alu_out);
    DataMemory dm(rf_out2, alu_out, MemRd, MemWr, dm_out);
    Multiplexer mux_32_2(alu_out, dm_out, MemtoReg, mux_32_out2);

    Shift sf_32(sigext_out, shl_32_out);
    Add add1(4, pc_out, add1_out);
    Add add2(add1_out, shl_32_out, add2_out);
    wire [31:0]concat_addr = {add1_out[31:28], shl_32_out};
    Multiplexer mux_32_3(add1_out, add2_out, Branch&Zero, mux_32_out3);
    Multiplexer mux_32_4(mux_32_out3, concat_addr, Jump, mux_32_out4);

endmodule
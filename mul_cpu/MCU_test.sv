

`timescale 1ns / 1ps

module MCU_test();
reg Zero;
reg [31:0]inst = 32'h8c010001;
reg PCSrc, PCOe, PCWr, AWr, AOe, IRWr, ImmOe, RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr,MARWr, RegDst;
reg [1:0]ALUOp, ExtSel;
//clk
reg clk = 0;
always #10 clk = ~clk;


MCU mcu(clk, Zero, IR_out, PCSrc, PCOe, PCWr, ALUOp, AWr, AOe, IRWr, ExtSel, ImmOe,RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr,MARWr, RegDst);


endmodule

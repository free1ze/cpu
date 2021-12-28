`include"Brige.sv"
`include"DataMemory.sv"
`include"tempRegister.sv"
`include"ThreeStateGate.sv"
`include"SignExtend.sv"
`include"RegisterFile.sv"
`include"PC.sv"
`include"Multiplexer.sv"
`include"MCU.sv"
`include"ALU.sv"
`include"ALUCU.sv"

`timescale 1ns / 1ns

module cpu ();
    //clk
    reg clk = 0;
    always #10 clk = ~clk;

    //wire DEBUG
    // wire [31:0]rfout, gate1out, aout;
    wire [4:0]DEBUG_state;

    //bus
    wire [31:0]bus1_in, bus2_in, bus1_out, bus2_out;

    //wires
    wire [31:0]alu_out, IR_out, SE_out, MAR_out, MDR_out, dm_out;
    wire [3:0]m1_out;
    wire [4:0]m2_out;
    wire [31:0]m3_out;


    //signals
    wire PCSrc, PCWr, AWr, AOe, IRWr, PCOe, RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr,MARWr, RegDst, Zero;
    wire [1:0]ALUOp, ExtSel;
    wire [2:0]ALUCtrl;

    //components
    Multiplexer #(4) m1(bus1_in[31:28], bus2_out[31:28], PCSrc, m1_out);         //m1_out = 4bit
    PC pc(clk, {m1_out,bus2_out[27:0]}, PCOe, PCWr, bus1_in);
    ALU alu(bus1_out, bus2_out, ALUCtrl, Zero, alu_out);
    tempRegister a(alu_out, AOe, AWr, bus2_in);

    tempRegister ir(bus1_out, 1, IRWr, IR_out);
    ALUCU alucu(IR_out[5:0], ALUOp, ALUCtrl);
    SignExtend sigext(IR_out, ExtSel, SE_out);
    ThreeStateGate gate1(SE_out, ImmOe, bus2_in);

    Multiplexer #(5) m2(IR_out[20:16], IR_out[15:11], RegDst, m2_out);          //missing mux in ppt
    RegisterFile rf(clk, RegWr, Reg1Oe, Reg2Oe, bus2_out, IR_out[25:21], IR_out[20:16], m2_out, bus1_in, bus2_in);

    Brige brige(bus1_in, bus2_in, GOe, Dir, bus1_out, bus2_out);
    tempRegister mar(bus2_out, 1, MARWr, MAR_out);
    tempRegister mdr(m3_out, 1, MDRWr, MDR_out);
    Multiplexer #(32) m3(bus1_out, dm_out, MDRSrc, m3_out); 
    DataMemory dm(MDR_out, MAR_out, MemRd, MemWr, dm_out);
    ThreeStateGate gate2(dm_out, MemOe, bus1_in);
    ThreeStateGate gate3(MDR_out, MDROe, bus1_in);

    MCU mcu(clk, Zero, IR_out[31:26], PCSrc, PCOe, PCWr, ALUOp, AWr, AOe, IRWr, ExtSel, ImmOe,RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr,MARWr, RegDst, DEBUG_state);


endmodule
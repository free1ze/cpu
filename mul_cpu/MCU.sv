
`timescale 1ns / 1ps

module MCU(clk, Zero, inst, PCSrc, PCOe, PCWr, ALUOp, AWr, AOe, IRWr, ExtSel, ImmOe,RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr,MARWr, RegDst,DEBUG_state);

input clk,Zero;
input [5:0]inst;
output reg PCSrc, PCOe, PCWr, AWr, AOe, IRWr, ImmOe, RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr,MARWr, RegDst;
output reg [1:0]ALUOp, ExtSel;

output reg [4:0]DEBUG_state;       //DEBUG

integer state;

initial begin
    state = 1;
    {PCSrc, PCOe, PCWr, AWr, AOe, IRWr, RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr, MARWr, RegDst, ALUOp, ExtSel, ImmOe} = 0;
end

//RegDst 0 for inst[20:16], 1 for inst[15:11]

always @(posedge clk) begin
     {PCSrc, PCOe, PCWr, AWr, AOe, IRWr, RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr, MARWr, RegDst, ALUOp, ExtSel, ImmOe} = 0;
    case(state)
    //fetch inst
    1: begin
        PCOe = 1;
        MARWr = 1;
        GOe = 1;
        Dir = 1;
        state = 2;
    end
    2: begin
        MemRd = 1;
        MemOe = 1;                          //missing on book
        IRWr = 1;
        state = 3;
    end
    3: begin
        PCOe = 1;
        ExtSel = 2'b10;
        ImmOe = 1;
        ALUOp =2'b00;
        AWr = 1;
        state = 4;
    end
    4: begin
        AOe = 1;
        PCWr = 1;
        PCSrc = 1;
        PCOe = 1;
        if(inst == 6'b100011) state = 5;            //load word
		else if(inst == 6'b101011) state = 9;       //store word
		else if(inst == 6'b000000) state = 13;      //Arithmetic
		else if(inst == 6'b000100) state = 15;      //BEQ
		else if(inst == 6'b000010) state = 18;      //J
    end

    //load word
    5: begin
        Reg1Oe = 1;
        ExtSel = 2'b00;
        ImmOe = 1;
        ALUOp = 2'b00;
        // ALUCtrl = 3'b100;
        AWr = 1;
        state = 6;
    end
    6: begin
        AOe = 1;MARWr = 1;
        state = 7;
    end
    7: begin
        MemRd = 1;
        MDRSrc = 1;
        MDRWr = 1;
        state = 8;
    end
    8: begin
        MDROe = 1;
        GOe = 1;
        Dir = 1;
        RegWr = 1;
        RegDst = 0;
        state = 1;
    end

    //store word
    9: begin
        Reg1Oe = 1;
        ExtSel = 2'b00;
        ImmOe = 1;
        ALUOp = 2'b00;
        // ALUCtrl = 3'b100;
        AWr = 1;
        state = 10;
    end
    10: begin
        AOe = 1;
        MARWr = 1;
        state = 11;
    end
    11:begin
        Reg2Oe = 1;
        GOe = 1;
        Dir = 0;
        MDRSrc = 0;
        MDRWr = 1;
        state = 12;
    end
    12: begin
        MemWr = 1;
        state = 1;
    end

    //Arithmetic
    13: begin
        Reg1Oe = 1;
        Reg2Oe = 1;
        ALUOp = 2'b01;
        // ALUCtrl = 3'bxxx;
        AWr = 1;
        state = 14;
    end
    14: begin
        AOe = 1;
        RegWr = 1;
        RegDst = 1;
        state = 1;
    end

    //BEQ
    15:begin
        Reg1Oe = 1;
        Reg2Oe = 1;
        ALUOp = 2'b10;              // wrong on book, which is 2'b01

        // need 1 sec delay for the signal to capture Zero, or it might not be caught and  the state can be wrong
        #1    if(Zero) state = 16; else state = 1; 

    end
    16: begin
        PCOe = 1;
        ExtSel = 2'b01;
        ImmOe = 1;
        ALUOp = 2'b00;
        AWr = 1;
        state = 17;
    end
    17: begin
        AOe = 1;
        PCSrc = 1;
        PCOe = 1;                    // missing on book
        PCWr = 1;
        state = 1;
    end

    //J
    18: begin
        ExtSel = 2'b11;
        ImmOe = 1;
        PCSrc = 0;              
        PCOe = 1;                       // missing on book
        PCWr = 1;
        state = 1;
    end

    default: begin
        {PCSrc, PCOe, PCWr, AWr, AOe, IRWr, RegWr, Reg1Oe, Reg2Oe, GOe, Dir, MemOe, MDRSrc, MDROe, MDRWr, MemRd, MemWr, MARWr, RegDst, ALUOp, ExtSel, ImmOe} = 100'bz;
    end
    endcase

    DEBUG_state = state - 1;
end

endmodule

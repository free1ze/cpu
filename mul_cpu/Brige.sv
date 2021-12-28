

`timescale 1ns / 1ps

module Brige(bus1_in, bus2_in, GOe, Dir, bus1_out, bus2_out);
	input [31:0]bus1_in, bus2_in;
    input GOe, Dir;
    output [31:0] bus1_out, bus2_out;
    // reg [31:0] b1,b2;
    //Dir == 1 down ; Dir == 0 up;

    // assign bus1 = b1;
    // assign bus2 = b2;

    // initial begin
    //     b1 = 0;
    //     b2 = 0;
    // end
    
    // always @(*) begin
    //     if(GOe) begin
    //         if(Dir) begin
    //             b1 = bus1;
    //             b2 = bus1;
    //         end
    //         else begin
    //             b1 = bus2;
    //             b2 = bus2;
    //         end
    //     end
    //     else begin
    //         b1 = bus1;
    //         b2 = bus2;
    //     end
    // end

    assign bus1_out = GOe ? (Dir ? bus1_in : bus2_in): bus1_in;
    assign bus2_out = GOe ? (Dir ? bus1_in : bus2_in): bus2_in;

endmodule

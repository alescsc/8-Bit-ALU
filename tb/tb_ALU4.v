`timescale 1ns / 1ps

module tb_ALU4;
    reg clk, reset, begin_sig;
    reg [1:0] OP_MODE;
    reg [7:0] INBUS;
    wire [7:0] OUTBUS;

    ALU UUT (.clk(clk), .reset(reset), .begin_sig(begin_sig), .OP_MODE(OP_MODE), .INBUS(INBUS), .OUTBUS(OUTBUS));

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; begin_sig = 0; OP_MODE = 2'b00; INBUS = 8'd0;
        #15 reset = 0;

        @(negedge clk);
        OP_MODE = 2'b11; begin_sig = 1;

        @(negedge clk);
        INBUS = 8'd5;      // Impartitor (M)
        @(negedge clk);
        INBUS = 8'd127;    // Deimpartit (Q)
        begin_sig = 0;

        #600; // Rezultat asteptat: Rest 2 (00000010) apoi Cat 25 (00011001)
        $stop;
    end
endmodule
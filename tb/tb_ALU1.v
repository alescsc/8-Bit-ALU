`timescale 1ns / 1ps

module tb_ALU1;
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
        OP_MODE = 2'b00; begin_sig = 1;

        @(negedge clk);
        INBUS = 8'd100;    // Primul numar
        repeat(3) @(negedge clk);
        INBUS = 8'd25;     // Al doilea numar
        begin_sig = 0;

        #200; // Rezultat asteptat: 125 (01111101)
        $stop;
    end
endmodule
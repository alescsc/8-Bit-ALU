`timescale 1ns / 1ps

module adder_9bit (
    input  wire [8:0] A,    // Primul operand
    input  wire [8:0] B,    // Al doilea operand
    input  wire       Cin,  // Bitul de transport la intrare (ex: C6)
    output reg  [8:0] Sum   // Rezultatul adunarii
);

    always @(*) begin
        // Suma matematica simpla
        Sum = A + B + Cin;
    end

endmodule
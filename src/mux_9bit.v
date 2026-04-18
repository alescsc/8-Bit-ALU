`timescale 1ns / 1ps

module mux_9bit (
    input  wire [8:0] in0,  // Prima intrare (selectată când sel = 0)
    input  wire [8:0] in1,  // A doua intrare (selectată când sel = 1)
    input  wire       sel,  // Semnal de selecție
    output reg  [8:0] out   // Ieșirea multiplexorului
);

    // Logică combinațională pentru alegerea ieșirii
    always @(*) begin
        if (sel == 1'b1) begin
            out = in1;      // Trece intrarea in1
        end else begin
            out = in0;      // Trece intrarea in0
        end
    end

endmodule
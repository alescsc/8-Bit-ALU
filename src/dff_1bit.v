`timescale 1ns / 1ps

module dff_1bit (
    input  wire clk,   // Semnal de ceas
    input  wire reset, // Reset asincron
    input  wire en,    // Semnal de activare (Enable)
    input  wire d,     // Intrarea de date (1 bit)
    output reg  q      // Ieșirea bistabilului
);

    // Logică secvențială pentru stocarea unui bit
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            // Resetare ieșire la 0
            q <= 1'b0;
        end else if (en == 1'b1) begin
            // Dacă este activat, preia valoarea de la intrare
            q <= d;
        end
    end

endmodule
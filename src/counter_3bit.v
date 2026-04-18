`timescale 1ns / 1ps

module counter_3bit (
    input  wire clk,         // Semnal de ceas
    input  wire reset,       // Reset general
    input  wire C4,          // Comandă pentru resetarea contorului (setare pe 0)
    input  wire C15,         // Comandă pentru incrementare (adunare cu 1)
    output reg  [2:0] count  // Valoarea curentă a contorului (0-7)
);

    // Logică secvențială: se activează pe frontul de ceas sau reset
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            // Reset hardware
            count <= 3'b000;
        end else if (C4 == 1'b1) begin
            // Resetare comandată de Unitatea de Control la începutul operației
            count <= 3'b000;
        end else if (C15 == 1'b1) begin
            // Incrementare la fiecare pas de înmulțire sau împărțire
            count <= count + 3'b001;
        end
    end

endmodule
`timescale 1ns / 1ps

module wordgate_xor (
    input  wire [8:0] in_data,  // Datele de intrare (9 biți)
    input  wire       C6,       // Semnal de control pentru inversare
    output reg  [8:0] out_data  // Datele de ieșire
);

    // Logică combinațională pentru complementare (inversare biți)
    always @(*) begin
        if (C6 == 1'b1) begin
            out_data = ~in_data; // Inversare (folosită la scădere)
        end else begin
            out_data = in_data;  // Datele trec neschimbate
        end
    end

endmodule
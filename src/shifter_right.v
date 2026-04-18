`timescale 1ns / 1ps

module shifter_right (
    input  wire       OVR_in,  // Bitul de overflow/semn de intrare
    input  wire [7:0] A_in,    // Registrul A (partea stângă)
    input  wire [7:0] Q_in,    // Registrul Q (partea dreaptă)
    output reg        OVR_out, // Bitul de overflow la ieșire
    output reg  [7:0] A_out,   // Noua valoare pentru A
    output reg  [7:0] Q_out    // Noua valoare pentru Q
);

    // Logică combinațională pentru shiftare la dreapta (folosită la înmulțire/Booth)
    always @(*) begin
        OVR_out = OVR_in;               // Se păstrează bitul de overflow
        A_out   = {OVR_in, A_in[7:1]};  // Deplasare A la dreapta, intră bitul de overflow
        Q_out   = {A_in[0], Q_in[7:1]}; // Deplasare Q la dreapta, intră bitul de jos din A
    end

endmodule
`timescale 1ns / 1ps

module shifter_left (
    input  wire [7:0] A_in,    // Registrul A (partea stângă)
    input  wire [7:0] Q_in,    // Registrul Q (partea dreaptă)
    output reg        OVR_out, // Bitul care iese din A (cel mai din stânga)
    output reg  [7:0] A_out,   // Noua valoare pentru A
    output reg  [7:0] Q_out    // Noua valoare pentru Q
);

    // Logică combinațională pentru shiftare la stânga (folosită la împărțire)
    always @(*) begin
        OVR_out = A_in[7];               // Păstrează bitul care va fi eliminat din A
        A_out   = {A_in[6:0], Q_in[7]};  // Deplasare A, intră bitul de sus din Q
        Q_out   = {Q_in[6:0], 1'b0};     // Deplasare Q, intră 0 la final
    end

endmodule
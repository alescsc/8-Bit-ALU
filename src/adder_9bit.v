`timescale 1ns / 1ps

module adder_9bit (
    input  wire [8:0] A,    // Primul număr (9 biți)
    input  wire [8:0] B,    // Al doilea număr (9 biți)
    input  wire       Cin,  // Transport de intrare (Carry In)
    output reg  [8:0] Sum   // Rezultatul adunării
);

    // Logică combinațională: se execută la orice schimbare a intrărilor
    always @(*) begin
        // Calculul sumei celor două numere plus transportul
        Sum = A + B + Cin;
    end

endmodule
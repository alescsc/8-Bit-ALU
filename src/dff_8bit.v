`timescale 1ns / 1ps

module dff_8bit (
    input  wire       clk,   // Ceas
    input  wire       reset, // Reset
    input  wire       en,    // Activare (Enable)
    input  wire [7:0] d,     // Intrare date (8 biți)
    output reg  [7:0] q      // Ieșire date (8 biți)
);

    // Logică pentru memorarea a 8 biți de date
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            q <= 8'b00000000; // Resetare registru
        end else if (en == 1'b1) begin
            q <= d;           // Încărcare valoare nouă
        end
    end

endmodule
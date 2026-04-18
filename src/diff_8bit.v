`timescale 1ns / 1ps

module dff_8bit (
    input  wire       clk,
    input  wire       reset,
    input  wire       en,
    input  wire [7:0] d,
    output reg  [7:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            q <= 8'b00000000;
        end else if (en == 1'b1) begin
            q <= d;
        end
    end

endmodule
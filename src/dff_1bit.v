`timescale 1ns / 1ps

module dff_1bit (
    input  wire clk,
    input  wire reset,
    input  wire en,
    input  wire d,
    output reg  q
);

    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            q <= 1'b0;
        end else if (en == 1'b1) begin
            q <= d;
        end
    end

endmodule
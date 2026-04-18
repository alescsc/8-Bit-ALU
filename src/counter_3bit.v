`timescale 1ns / 1ps

module counter_3bit (
    input  wire clk,
    input  wire reset,
    input  wire C4,
    input  wire C15,
    output reg  [2:0] count
);

    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            count <= 3'b000;
        end else if (C4 == 1'b1) begin
            count <= 3'b000;
        end else if (C15 == 1'b1) begin
            count <= count + 3'b001;
        end
    end

endmodule
`timescale 1ns / 1ps

module wordgate_xor (
    input  wire [8:0] in_data,
    input  wire       C6,
    output reg  [8:0] out_data
);

    always @(*) begin
        if (C6 == 1'b1) begin
            out_data = ~in_data;
        end else begin
            out_data = in_data;
        end
    end

endmodule
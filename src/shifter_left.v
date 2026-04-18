`timescale 1ns / 1ps

module shifter_left (
    input  wire [7:0] A_in,
    input  wire [7:0] Q_in,
    output reg        OVR_out,
    output reg  [7:0] A_out,
    output reg  [7:0] Q_out
);

    always @(*) begin
        OVR_out = A_in[7];
        A_out   = {A_in[6:0], Q_in[7]};
        Q_out   = {Q_in[6:0], 1'b0};
    end

endmodule
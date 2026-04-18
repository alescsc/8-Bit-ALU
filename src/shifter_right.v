`timescale 1ns / 1ps

module shifter_right (
    input  wire       OVR_in,
    input  wire [7:0] A_in,
    input  wire [7:0] Q_in,
    output reg        OVR_out,
    output reg  [7:0] A_out,
    output reg  [7:0] Q_out
);

    always @(*) begin
        OVR_out = OVR_in;
        A_out   = {OVR_in, A_in[7:1]};
        Q_out   = {A_in[0], Q_in[7:1]};
    end

endmodule
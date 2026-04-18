`timescale 1ns / 1ps

module mux_9bit (
    input  wire [8:0] in0,  
    input  wire [8:0] in1,  
    input  wire       sel,  
    output reg  [8:0] out   
);

    always @(*) begin
        if (sel == 1'b1) begin
            out = in1;
        end else begin
            out = in0;
        end
    end

endmodule
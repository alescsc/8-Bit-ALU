`timescale 1ns / 1ps

module adder_9bit (
    input  wire [8:0] A,    
    input  wire [8:0] B,    
    input  wire Cin,   
    output reg  [8:0] Sum  
);

    always @(*) begin
        Sum = A + B + Cin;
    end

endmodule
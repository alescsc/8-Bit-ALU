`timescale 1ns / 1ps

module tb_adder_9bit;

    reg  [8:0] A_test;
    reg  [8:0] B_test;
    reg        Cin_test;
    
    wire [8:0] Sum_test;

    adder_9bit UUT (
        .A(A_test),
        .B(B_test),
        .Cin(Cin_test),
        .Sum(Sum_test)
    );

    initial begin
        $display("--- Incepere Test Sumator ---");
        
        A_test = 9'd10;
        B_test = 9'd5;
        Cin_test = 1'b0;
        #10;
        $display("Test 1: 10 + 5 + 0 = %d", Sum_test);

        A_test = 9'd20;
        B_test = 9'd30;
        Cin_test = 1'b1;
        #10;
        $display("Test 2: 20 + 30 + 1 = %d", Sum_test);

        A_test = 9'd255;
        B_test = 9'd2;
        Cin_test = 1'b0;
        #10;
        $display("Test 3: 255 + 2 + 0 = %d", Sum_test);
        
        $display("--- Test Terminat ---");
        $stop;
    end

endmodule
`timescale 1ns / 1ps

module tb_subtraction;

    reg  [8:0] A_test;
    reg  [8:0] M_test;
    reg        C5_test;
    reg        C6_test;

    wire [8:0] mux_out;
    wire [8:0] xor_out;
    wire [8:0] Sum_test;

    mux_9bit UUT_MUX (
        .in0(9'b000000000),
        .in1(M_test),
        .sel(C5_test),
        .out(mux_out)
    );

    wordgate_xor UUT_XOR (
        .in_data(mux_out),
        .C6(C6_test),
        .out_data(xor_out)
    );

    adder_9bit UUT_ADDER (
        .A(A_test),
        .B(xor_out),
        .Cin(C6_test),
        .Sum(Sum_test)
    );

    initial begin
        $display("--- Incepere Test Scadere ---");

        A_test = 9'd10;
        M_test = 9'd5;
        C5_test = 1'b1;
        C6_test = 1'b1;
        #10;
        $display("Test 1: 10 - 5 = %d", Sum_test);

        A_test = 9'd20;
        M_test = 9'd30;
        C5_test = 1'b1;
        C6_test = 1'b1;
        #10;
        $display("Test 2: 20 - 30 = %d", $signed(Sum_test));

        A_test = 9'd15;
        M_test = 9'd15;
        C5_test = 1'b1;
        C6_test = 1'b0;
        #10;
        $display("Test 3 (Verificare Adunare): 15 + 15 = %d", Sum_test);

        $display("--- Test Terminat ---");
        $stop;
    end

endmodule
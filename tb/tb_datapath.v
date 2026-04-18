`timescale 1ns / 1ps

module tb_datapath;

    reg clk;
    reg reset;
    reg [7:0] INBUS;
    
    reg C0, C1, C2, C3, C4, C5, C6, C7, C8, C9;
    reg C10, C11, C12, C13, C14, C15, C16, C17;

    wire Q1_out, Q0_out, R_out, OVR_out, A7_out;
    wire [7:0] OUTBUS;

    datapath UUT (
        .clk(clk), .reset(reset), .INBUS(INBUS),
        .C0(C0), .C1(C1), .C2(C2), .C3(C3), .C4(C4), 
        .C5(C5), .C6(C6), .C7(C7), .C8(C8), .C9(C9), 
        .C10(C10), .C11(C11), .C12(C12), .C13(C13), .C14(C14), 
        .C15(C15), .C16(C16), .C17(C17),
        .Q1_out(Q1_out), .Q0_out(Q0_out), .R_out(R_out), 
        .OVR_out(OVR_out), .A7_out(A7_out),
        .OUTBUS(OUTBUS)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; 
        reset = 1; 
        INBUS = 8'd0;
        {C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17} = 18'b0;
        
        #10; 
        reset = 0;
        
        INBUS = 8'd5; 
        C0 = 1; 
        #10; 
        C0 = 0;
        
        C2 = 1; 
        #10; 
        C2 = 0;
        
        C5 = 1; 
        C6 = 0; 
        C7 = 1; 
        #10; 
        C5 = 0; 
        C7 = 0;
        
        C16 = 1; 
        #10; 
        C16 = 0;
        
        $stop;
    end

endmodule
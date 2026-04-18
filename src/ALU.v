`timescale 1ns / 1ps

module ALU (
    input  wire       clk,
    input  wire       reset,
    input  wire       begin_sig,
    input  wire [1:0] OP_MODE,
    input  wire [7:0] INBUS,
    output wire [7:0] OUTBUS
);

    wire C0, C1, C2, C3, C4, C5, C6, C7, C8, C9;
    wire C10, C11, C12, C13, C14, C15, C16, C17, C18;
    
    wire Q1_out, Q0_out, R_out, OVR_out, A7_out, COUNT7;

    datapath DP (
        .clk(clk), .reset(reset), .INBUS(INBUS),
        .C0(C0), .C1(C1), .C2(C2), .C3(C3), .C4(C4), 
        .C5(C5), .C6(C6), .C7(C7), .C8(C8), .C9(C9), 
        .C10(C10), .C11(C11), .C12(C12), .C13(C13), .C14(C14), 
        .C15(C15), .C16(C16), .C17(C17),
        .Q1_out(Q1_out), .Q0_out(Q0_out), .R_out(R_out), 
        .OVR_out(OVR_out), .A7_out(A7_out), .COUNT7(COUNT7),
        .OUTBUS(OUTBUS)
    );

    control_unit CU (
        .clk(clk), .reset(reset), .begin_sig(begin_sig), .OP_MODE(OP_MODE),
        .Q0(Q0_out), .R(R_out), .OVR(OVR_out), .A7(A7_out), .COUNT7(COUNT7),
        .C0(C0), .C1(C1), .C2(C2), .C3(C3), .C4(C4), .C5(C5), .C6(C6), 
        .C7(C7), .C8(C8), .C9(C9), .C10(C10), .C11(C11), .C12(C12), 
        .C13(C13), .C14(C14), .C15(C15), .C16(C16), .C17(C17), .C18(C18)
    );

endmodule
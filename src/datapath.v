`timescale 1ns / 1ps

module datapath (
    input  wire       clk,        // Ceas
    input  wire       reset,      // Reset general
    input  wire [7:0] INBUS,      // Magistrala intrare date
    input  wire       C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, 
    input  wire       C10, C11, C12, C13, C14, C15, C16, C17, // Semnale de control
    output wire       Q1_out, Q0_out, R_out, OVR_out, A7_out, COUNT7, // Semnale de stare
    output reg  [7:0] OUTBUS      // Magistrala iesire date
);

    // Valori curente registre
    wire [7:0] A_val, Q_val, M_val;
    wire       OVR_val, R_val;
    
    // Rezultate deplasare (Shift)
    wire       OVR_shr, OVR_shl;
    wire [7:0] A_shr, A_shl, Q_shr, Q_shl;
    
    // Rezultate aritmetice
    wire [8:0] mux_out, xor_out, adder_sum;
    wire [2:0] count_val;
    
    // Valori care vor fi incarcate in registre la urmatorul ceas
    reg [7:0] A_next, Q_next;
    reg       OVR_next, R_next;

    // Transmitere flag-uri catre Unitatea de Control
    assign Q1_out  = Q_val[1];
    assign Q0_out  = Q_val[0];
    assign R_out   = R_val;
    assign OVR_out = OVR_val;
    assign A7_out  = A_val[7];
    assign COUNT7  = (count_val == 3'b111); // Verificare finalizare 8 pasi

    // Instantiere module de baza
    dff_8bit REG_M ( .clk(clk), .reset(reset), .en(C0), .d(INBUS), .q(M_val) );

    mux_9bit MUX1 ( .in0(9'b0), .in1({M_val[7], M_val}), .sel(C5), .out(mux_out) );

    wordgate_xor XOR1 ( .in_data(mux_out), .C6(C6), .out_data(xor_out) );

    adder_9bit ADDER1 ( .A({OVR_val, A_val}), .B(xor_out), .Cin(C6), .Sum(adder_sum) );

    shifter_right SHR1 ( .OVR_in(OVR_val), .A_in(A_val), .Q_in(Q_val), .OVR_out(OVR_shr), .A_out(A_shr), .Q_out(Q_shr) );

    shifter_left SHL1 ( .A_in(A_val), .Q_in(Q_val), .OVR_out(OVR_shl), .A_out(A_shl), .Q_out(Q_shl) );

    counter_3bit COUNTER1 ( .clk(clk), .reset(reset), .C4(C4), .C15(C15), .count(count_val) );

    // Logica pentru selectia valorii urmatoare a registrelor
    always @(*) begin
        A_next = A_val; Q_next = Q_val; OVR_next = OVR_val; R_next = R_val;

        // Update Registru A
        if (C2)      A_next = 8'b0;
        else if (C7) A_next = adder_sum[7:0];
        else if (C8) A_next = A_shr;
        else if (C9) A_next = A_shl;

        // Update Registru Q
        if (C1)       Q_next = INBUS;
        else if (C8)  Q_next = Q_shr;
        else if (C9)  Q_next = Q_shl;
        else if (C11) Q_next = {Q_val[7:1], 1'b1};
        else if (C12) Q_next = {Q_val[7:1], 1'b0};

        // Update Flag Overflow/Carry
        if (C13)      OVR_next = 1'b1;
        else if (C14) OVR_next = 1'b0;
        else if (C7)  OVR_next = adder_sum[8];
        else if (C8)  OVR_next = OVR_shr;
        else if (C9)  OVR_next = OVR_shl;
        
        // Update Bit R (pentru Booth)
        if (C3)      R_next = 1'b0;
        else if (C10) R_next = 1'b1;
    end

    // Registrele fizice (D-Flip-Flop)
    dff_8bit REG_A   ( .clk(clk), .reset(reset), .en(1'b1), .d(A_next), .q(A_val) );
    dff_8bit REG_Q   ( .clk(clk), .reset(reset), .en(1'b1), .d(Q_next), .q(Q_val) );
    dff_1bit REG_OVR ( .clk(clk), .reset(reset), .en(1'b1), .d(OVR_next), .q(OVR_val) );
    dff_1bit REG_R   ( .clk(clk), .reset(reset), .en(1'b1), .d(R_next), .q(R_val) );

    // Logica pentru afisarea rezultatului final pe OUTBUS
    always @(posedge clk or posedge reset) begin
        if (reset)       OUTBUS <= 8'b0;
        else if (C16)    OUTBUS <= A_val; // Afiseaza restul sau partea High
        else if (C17)    OUTBUS <= Q_val; // Afiseaza catul sau partea Low
    end

endmodule
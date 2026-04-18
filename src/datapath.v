`timescale 1ns / 1ps

module datapath (
    input  wire       clk,
    input  wire       reset,
    input  wire [7:0] INBUS,
    input  wire       C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, 
    input  wire       C10, C11, C12, C13, C14, C15, C16, C17,
    output wire       Q1_out, Q0_out, R_out, OVR_out, A7_out, COUNT7,
    output reg  [7:0] OUTBUS
);

    wire [7:0] A_val;
    wire [7:0] Q_val;
    wire [7:0] M_val;
    wire       OVR_val;
    wire       R_val;
    
    wire       OVR_shr, OVR_shl;
    wire [7:0] A_shr,   A_shl;
    wire [7:0] Q_shr,   Q_shl;
    
    wire [8:0] mux_out;
    wire [8:0] xor_out;
    wire [8:0] adder_sum;
    
    wire [2:0] count_val;
    
    reg [7:0] A_next;
    reg [7:0] Q_next;
    reg       OVR_next;
    reg       R_next;

    assign Q1_out  = Q_val[1];
    assign Q0_out  = Q_val[0];
    assign R_out   = R_val;
    assign OVR_out = OVR_val;
    assign A7_out  = A_val[7];
    assign COUNT7  = (count_val == 3'b111);

    dff_8bit REG_M (
        .clk(clk), .reset(reset), .en(C0), 
        .d(INBUS), .q(M_val)
    );

    mux_9bit MUX1 (
        .in0(9'b000000000), 
        .in1({M_val[7], M_val}), 
        .sel(C5), 
        .out(mux_out)
    );

    wordgate_xor XOR1 (
        .in_data(mux_out), 
        .C6(C6), 
        .out_data(xor_out)
    );

    adder_9bit ADDER1 (
        .A({OVR_val, A_val}), 
        .B(xor_out), 
        .Cin(C6), 
        .Sum(adder_sum)
    );

    shifter_right SHR1 (
        .OVR_in(OVR_val), .A_in(A_val), .Q_in(Q_val),
        .OVR_out(OVR_shr), .A_out(A_shr), .Q_out(Q_shr)
    );

    shifter_left SHL1 (
        .A_in(A_val), .Q_in(Q_val),
        .OVR_out(OVR_shl), .A_out(A_shl), .Q_out(Q_shl)
    );

    counter_3bit COUNTER1 (
        .clk(clk), .reset(reset), .C4(C4), .C15(C15), 
        .count(count_val)
    );

    always @(*) begin
        A_next   = A_val;
        Q_next   = Q_val;
        OVR_next = OVR_val;
        R_next   = R_val;

        if (C2 == 1'b1)      A_next = 8'b00000000;
        else if (C7 == 1'b1) A_next = adder_sum[7:0];
        else if (C8 == 1'b1) A_next = A_shr;
        else if (C9 == 1'b1) A_next = A_shl;

        if (C1 == 1'b1)      Q_next = INBUS;
        else if (C8 == 1'b1) Q_next = Q_shr;
        else if (C9 == 1'b1) Q_next = Q_shl;
        else if (C11 == 1'b1) Q_next = {Q_val[7:1], 1'b1};
        else if (C12 == 1'b1) Q_next = {Q_val[7:1], 1'b0};

        if (C13 == 1'b1)      OVR_next = 1'b1;
        else if (C14 == 1'b1) OVR_next = 1'b0;
        else if (C7 == 1'b1)  OVR_next = adder_sum[8];
        else if (C8 == 1'b1)  OVR_next = OVR_shr;
        else if (C9 == 1'b1)  OVR_next = OVR_shl;
        
        if (C3 == 1'b1)       R_next = 1'b0;
        else if (C10 == 1'b1) R_next = 1'b1;
    end

    dff_8bit REG_A (
        .clk(clk), .reset(reset), .en(1'b1), 
        .d(A_next), .q(A_val)
    );

    dff_8bit REG_Q (
        .clk(clk), .reset(reset), .en(1'b1), 
        .d(Q_next), .q(Q_val)
    );

    dff_1bit REG_OVR (
        .clk(clk), .reset(reset), .en(1'b1), 
        .d(OVR_next), .q(OVR_val)
    );
    
    dff_1bit REG_R (
        .clk(clk), .reset(reset), .en(1'b1), 
        .d(R_next), .q(R_val)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            OUTBUS <= 8'b00000000;
        end else if (C16) begin
            OUTBUS <= A_val;
        end else if (C17) begin
            OUTBUS <= Q_val;
        end
    end

endmodule
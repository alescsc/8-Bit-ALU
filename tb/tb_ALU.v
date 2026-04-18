`timescale 1ns / 1ps

module tb_ALU;

    reg clk;
    reg reset;
    reg begin_sig;
    reg [1:0] OP_MODE;
    reg [7:0] INBUS;
    wire [7:0] OUTBUS;

    ALU UUT (
        .clk(clk),
        .reset(reset),
        .begin_sig(begin_sig),
        .OP_MODE(OP_MODE),
        .INBUS(INBUS),
        .OUTBUS(OUTBUS)
    );

    // Generare ceas
    always #5 clk = ~clk;

    initial begin
        // Initializare si Reset
        clk = 0; 
        reset = 1; 
        begin_sig = 0; 
        OP_MODE = 2'b00; 
        INBUS = 8'd0;
        #20 reset = 0;

        // --- 1. ADUNARE (15 + 10 = 25) ---
        @(negedge clk);
        OP_MODE = 2'b00; begin_sig = 1;
        @(negedge clk);
        INBUS = 8'd15;       // Primul numar
        repeat(3) @(negedge clk);
        INBUS = 8'd10;       // Al doilea numar
        begin_sig = 0;
        #150;                // Pauza lunga pentru vizualizare

        // --- 2. SCADERE (50 - 20 = 30) ---
        @(negedge clk);
        OP_MODE = 2'b01; begin_sig = 1;
        @(negedge clk);
        INBUS = 8'd50;       // Primul numar
        repeat(3) @(negedge clk);
        INBUS = 8'd20;       // Al doilea numar
        begin_sig = 0;
        #150;

        // --- 3. INMULTIRE (7 x 6 = 42) ---
        @(negedge clk);
        OP_MODE = 2'b10; begin_sig = 1;
        @(negedge clk);
        INBUS = 8'd7;        // Multiplicator (M)
        @(negedge clk);
        INBUS = 8'd6;        // Deinmultit (Q)
        begin_sig = 0;
        #500;                // Inmultirea are 8 pasi, necesita timp

        // --- 4. IMPARTIRE (20 / 3 = 6 rest 2) ---
        @(negedge clk);
        OP_MODE = 2'b11; begin_sig = 1;
        @(negedge clk);
        INBUS = 8'd3;        // Impartitor (M)
        @(negedge clk);
        INBUS = 8'd20;       // Deimpartit (Q)
        begin_sig = 0;
        #600;                // Impartirea este cea mai lunga

        $display("Toate testele au fost finalizate!");
        $stop;
    end

endmodule
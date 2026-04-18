`timescale 1ns / 1ps

module control_unit (
    input  wire       clk,        // Semnalul de ceas
    input  wire       reset,      // Resetul sistemului
    input  wire       begin_sig,  // Butonul de start
    input  wire [1:0] OP_MODE,    // Selectarea operatiei (00:+, 01:-, 10:*, 11:/)
    input  wire       Q0,         // Bit din registrul Q (pt Booth)
    input  wire       R,          // Bit de retinere (pt Booth)
    input  wire       OVR,        // Flag de overflow
    input  wire       A7,         // Bitul de semn al lui A
    input  wire       COUNT7,     // Semnal finalizare 8 pasi
    output reg C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, // Semnale de control
    output reg C10, C11, C12, C13, C14, C15, C16, C17, C18
);

    reg [4:0] state, next_state; // Registre pentru starea curenta si urmatoare

    // Definirea starilor automatului
    localparam IDLE         = 5'd0;  // Asteptare
    localparam INIT_1       = 5'd1;  // Initializare pas 1
    localparam INIT_2       = 5'd2;  // Initializare pas 2
    localparam LOAD_A       = 5'd3;  // Incarcare registrul A
    localparam EVAL_OP      = 5'd4;  // Alegerea operatiei
    localparam ADD_STEP1    = 5'd5;  // Adunare pas 1
    localparam ADD_STEP2    = 5'd6;  // Adunare pas 2
    localparam SUB_STEP1    = 5'd7;  // Scadere pas 1
    localparam SUB_STEP2    = 5'd8;  // Scadere pas 2
    localparam MUL_EVAL     = 5'd9;  // Inmultire: evaluare biti
    localparam MUL_ADD      = 5'd10; // Inmultire: adunare
    localparam MUL_SUB      = 5'd11; // Inmultire: scadere
    localparam MUL_SHIFT    = 5'd12; // Inmultire: deplasare
    localparam DIV_SHL      = 5'd13; // Impartire: deplasare stanga
    localparam DIV_ADDSUB   = 5'd14; // Impartire: calcul sumator
    localparam DIV_UPDATE   = 5'd15; // Impartire: actualizare bit Q
    localparam DIV_INC      = 5'd16; // Impartire: incrementare contor
    localparam DIV_RESTORE  = 5'd17; // Impartire: corectare rest
    localparam OUT_A        = 5'd18; // Afisare rezultat din A
    localparam OUT_Q        = 5'd19; // Afisare rezultat din Q
    localparam STOP         = 5'd20; // Finalizare operatie

    // Registrul de stare: trece la starea urmatoare la fiecare ceas
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;
        else       
            state <= next_state;
    end

    // Logica pentru tranzitii si semnale de control
    always @(*) begin
        // Valori de baza (toate semnalele sunt oprite initial)
        next_state = state;
        C0=0;  C1=0;  C2=0;  C3=0;  C4=0;  C5=0;  C6=0;  C7=0;  C8=0;  C9=0;
        C10=0; C11=0; C12=0; C13=0; C14=0; C15=0; C16=0; C17=0; C18=0;

        case (state)
            IDLE: begin // Asteapta apasarea butonului de start
                if (begin_sig) 
                    next_state = INIT_1;
            end
            
            INIT_1: begin // Resetare registre si incarcare primul numar
                C0 = 1; C2 = 1; C3 = 1; C4 = 1; 
                next_state = INIT_2; 
            end
            
            INIT_2: begin // Incarcare al doilea numar
                C1 = 1; 
                if (OP_MODE == 2'b00 || OP_MODE == 2'b01) 
                    next_state = LOAD_A; // Mergi la incarcare A pentru adunare/scadere
                else 
                    next_state = EVAL_OP;
            end

            LOAD_A: begin // Transfera datele in registrul A
                C5 = 1; C7 = 1; 
                next_state = EVAL_OP; 
            end
            
            EVAL_OP: begin // Selecteaza drumul in functie de operatie
                case (OP_MODE)
                    2'b00: next_state = ADD_STEP1;
                    2'b01: next_state = SUB_STEP1;
                    2'b10: next_state = MUL_EVAL;
                    2'b11: next_state = DIV_SHL;
                endcase
            end
            
            // --- Logica Adunare ---
            ADD_STEP1: begin C0 = 1; next_state = ADD_STEP2; end
            ADD_STEP2: begin C5 = 1; C7 = 1; next_state = OUT_A; end
            
            // --- Logica Scadere ---
            SUB_STEP1: begin C0 = 1; next_state = SUB_STEP2; end
            SUB_STEP2: begin C5 = 1; C6 = 1; C7 = 1; next_state = OUT_A; end
            
            // --- Logica Inmultire (Algoritmul Booth) ---
            MUL_EVAL: begin // Verifica bitii pentru a decide: adunare, scadere sau doar shiftare
                if (Q0 == 1 && R == 0)      next_state = MUL_SUB;
                else if (Q0 == 0 && R == 1) next_state = MUL_ADD;
                else                        next_state = MUL_SHIFT;
            end
            
            MUL_ADD: begin C5 = 1; C7 = 1; next_state = MUL_SHIFT; end
            MUL_SUB: begin C5 = 1; C6 = 1; C7 = 1; next_state = MUL_SHIFT; end
            
            MUL_SHIFT: begin // Deplasare la dreapta si verificare daca am facut 8 pasi
                C8 = 1; C15 = 1;
                if (Q0) C10 = 1; else C3 = 1;
                if (COUNT7) next_state = OUT_A; else next_state = MUL_EVAL;
            end
            
            // --- Logica Impartire (Non-Restoring) ---
            DIV_SHL:    begin C9 = 1; next_state = DIV_ADDSUB; end
            DIV_ADDSUB: begin C5 = 1; if (OVR == 0) C6 = 1; C7 = 1; next_state = DIV_UPDATE; end
            DIV_UPDATE: begin // Seteaza bitul din Q in functie de semnul restului
                if (A7 == 0) begin C11 = 1; C14 = 1; end 
                else         begin C12 = 1; C13 = 1; end
                next_state = DIV_INC; 
            end
            DIV_INC:    begin C15 = 1; if (COUNT7) next_state = DIV_RESTORE; else next_state = DIV_SHL; end
            DIV_RESTORE:begin if (A7 == 1) begin C5 = 1; C7 = 1; end next_state = OUT_A; end
            
            // --- Finalizare si afisare ---
            OUT_A: begin // Scoate pe magistrala valoarea din A
                C16 = 1; 
                if (OP_MODE == 2'b00 || OP_MODE == 2'b01) next_state = STOP; // Pt +/- ne oprim aici
                else next_state = OUT_Q; // Pt * / afisam si Q
            end
            
            OUT_Q: begin C17 = 1; next_state = STOP; end // Scoate pe magistrala valoarea din Q
            
            STOP:  begin C18 = 1; if (!begin_sig) next_state = IDLE; end // Asteapta eliberarea butonului
            
            default: next_state = IDLE;
        endcase
    end
endmodule
<h1 align="center">⚙️ Proiect: Unitate Aritmetică și Logică (ALU) pe 8 biți</h1>

### 👥 Autori:
* **Student:** Vlonga Nicoleta-Dorina
* **Student:** Fizǎdean Alexandru
* **Facultate:** Automaticǎ și Calculatoare
* **Anul:** 2 | **Grupa:** C.3.2
* **Materia:** Calculatoare Numerice

---

## 📝 Descrierea Proiectului

Am realizat acest proiect pentru a implementa o unitate **ALU pe 8 biți** funcțională, folosind limbajul **Verilog**. Arhitectura se bazează pe o separare clară între partea de control (FSM) și partea de date (Datapath), ceea ce ne-a permis să gestionăm mai ușor operațiile complexe.

### ✨ Funcționalități principale:

* ➕ **Adunare & Scădere:** Calculează sume și diferențe folosind un sumator și logică de complement de 2.
* ✖️ **Înmulțire:** Folosește **Algoritmul Modified Booth**, fiind capabil să înmulțească corect și numerele cu semn (negative).
* ➗ **Împărțire:** Implementată prin **Algoritmul Non-Restoring**, oferind la final atât câtul, cât și restul operației.

Toată logica a fost verificată prin simulări în **ModelSim**, asigurându-ne că rezultatele sunt corecte și că semnalele de control sunt sincronizate corespunzător pentru fiecare operație în parte.

---

### Structura Proiectului

```text
8-Bit-ALU/
├── resources/
│   ├── controlunitflags.pdf       # Documentatie semnale unitate de control
│   ├── data_path.png              # Schema bloc a caii de date
│   └── state_machine.png          # Diagrama de stari a automatului (FSM)
├── src/
│   ├── ALU.v                      # Modulul principal (Top Level)
│   ├── adder_9bit.v               # Sumator pe 9 biti
│   ├── control_unit.v             # Unitatea de control
│   ├── counter_3bit.v             # Contor pentru iteratii (3 biti)
│   ├── datapath.v                 # Calea de date (Data Path)
│   ├── dff_1bit.v                 # Bistabil D pe 1 bit
│   ├── dff_8bit.v                 # Registru de 8 biti (A, Q, M)
│   ├── mux_9bit.v                 # Multiplexor pe 9 biti
│   ├── shifter_left.v             # Unitate shiftare stanga (DIV)
│   ├── shifter_right.v            # Unitate shiftare dreapta (MUL)
│   └── wordgate_xor.v             # Logica XOR pentru scadere
├── tb/
│   ├── tb_ALU1.v                  # Testbench set 1
│   ├── tb_ALU2.v                  # Testbench set 2
│   ├── tb_ALU3.v                  # Testbench set 3
│   └── tb_ALU4.v                  # Testbench set 4
├── testing_phase/
│   ├── waveform_division.png      # Rezultat impartire
│   ├── waveform_multiplication.png # Rezultat inmultire
│   ├── waveform_subtraction.png   # Rezultat scadere
│   └── waveform_sum.png           # Rezultat adunare
├── work/                          # Biblioteca ModelSim
├── README.md                      # Fisierul de documentatie
└── run.do                         # Script rulare ModelSim
<h1 align="center">⚙️ Proiect: Unitate Aritmetică și Logică (ALU) pe 8 biți</h1>

### 👥 Autori:
* **Student:** Vlonga Nicoleta-Dorina
* **Student:** Fizǎdean Alexandru
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


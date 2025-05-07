# Hardware-project

## 📁 Multi-Cycle MIPS Processor - Project Structure

This project implements a 32-bit MIPS processor using VHDL, following a multi-cycle architecture. The tasks are divided among four team members:

![image](https://github.com/user-attachments/assets/457b161f-330b-4327-a1f6-654b79f0fda0)


---

### 👤 Person 1 – Memory & Register File 
Handles memory units and basic register components.


---

### 👤 Person 2 – ALU, Shifter, Sign Extension, MUX ✅
Implements the arithmetic and logic units, shifters, and multiplexers.


---

### 👤 Person 3 – Control Unit ✅
Implements instruction decoding and control signal generation.


---

### 👤 Person 4 – Integration & Connection Logic
Integrates all components and handles testing and simulation.
# MultiCycleMIPS Project Structure

### Directory Tree
<pre>
MultiCycleMIPS/
│
├── src/                    # VHDL source files
│   ├── memory/
│   │   ├── instruction_memory.vhd        ← Person 1 ✅
│   │   ├── data_memory.vhd               ← Person 1 ✅
│   │   ├── memory_data_register.vhd      ← Person 1 ✅
│   │
│   ├── register_file/
│   │   ├── register_file.vhd             ← Person 2 ✅
│   │   ├── A_register.vhd                ← Person 2 ✅
│   │   ├── B_register.vhd                ← Person 2 ✅
│   │   ├── alu_out_register.vhd          ← Person 2 ✅
│   │   ├── pc.vhd                        ← Person 2 ✅
│   │
│   ├── alu/
│   │   ├── alu.vhd                       ← Person 3 ✅
│   │   ├── shift_left2.vhd               ← Person 3 ✅
│   │   ├── sign_extender.vhd             ← Person 3 ✅
│   │   ├── mux2to1.vhd                   ← Person 3 ✅
│   │   ├── mux4to1.vhd                   ← Person 3 ✅
│   │
│   ├── control/
│   │   ├── control_unit.vhd              ← Person 4 ✅
│   │   ├── alu_control.vhd               ← Person 4 ✅
│   │   ├── fsm_controller.vhd            ← Person 4 ✅
│   │
│   ├── top/
│   │   ├── datapath.vhd                  ← Person 5
│   │   ├── top_level.vhd                 ← Person 5
│   │   ├── connection_logic.vhd          ← Person 5
│
├── tb/                     # Testbenches
│   ├── tb_instruction_memory.vhd         ← Person 1/2 ✅
│   ├── tb_alu.vhd                        ← Person 3   ✅
│   ├── tb_control_unit.vhd               ← Person 4   ✅
│   ├── tb_top_level.vhd                  ← Person 5
│
├── sim/                    # Simulation scripts
│   ├── waveform.do                       ← Person 5 (optional)
│   ├── run_simulation.tcl                ← Person 5
│
├── docs/                   # Documentation
│   ├── architecture_diagram.pdf          ← Team
│   ├── README.md                         ← Maintained by Person 3 ✅
│   ├── Project_Report.pdf                ← Final report
│
└── .gitignore
</pre>

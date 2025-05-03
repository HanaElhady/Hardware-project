# Hardware-project

## 📁 Multi-Cycle MIPS Processor - Project Structure

This project implements a 32-bit MIPS processor using VHDL, following a multi-cycle architecture. The tasks are divided among four team members:
![image](https://github.com/user-attachments/assets/7c0347d7-ed10-426d-b46c-993aa8792819)


---

### 👤 Person 1 – Memory & Register File
Handles memory units and basic register components.


---

### 👤 Person 2 – ALU, Shifter, Sign Extension, MUX
Implements the arithmetic and logic units, shifters, and multiplexers.


---

### 👤 Person 3 – Control Unit
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
│   │   ├── instruction_memory.vhd        ← Person 1
│   │   ├── data_memory.vhd               ← Person 1
│   │   ├── memory_data_register.vhd      ← Person 1
│   │
│   ├── register_file/
│   │   ├── register_file.vhd             ← Person 1
│   │   ├── A_register.vhd                ← Person 1
│   │   ├── B_register.vhd                ← Person 1
│   │   ├── alu_out_register.vhd          ← Person 1
│   │   ├── pc.vhd                        ← Person 1
│   │
│   ├── alu/
│   │   ├── alu.vhd                       ← Person 2
│   │   ├── shift_left2.vhd               ← Person 2
│   │   ├── sign_extender.vhd             ← Person 2
│   │   ├── mux2to1.vhd                   ← Person 2
│   │   ├── mux4to1.vhd                   ← Person 2
│   │
│   ├── control/
│   │   ├── control_unit.vhd              ← Person 3
│   │   ├── alu_control.vhd               ← Person 3
│   │   ├── fsm_controller.vhd            ← Person 3
│   │
│   ├── top/
│   │   ├── datapath.vhd                  ← Person 4
│   │   ├── top_level.vhd                 ← Person 4
│   │   ├── connection_logic.vhd          ← Person 4
│
├── tb/                     # Testbenches
│   ├── tb_instruction_memory.vhd         ← Person 1
│   ├── tb_alu.vhd                        ← Person 2
│   ├── tb_control_unit.vhd               ← Person 3
│   ├── tb_top_level.vhd                  ← Person 4
│
├── sim/                    # Simulation scripts
│   ├── waveform.do                       ← Person 4 (optional)
│   ├── run_simulation.tcl                ← Person 4
│
├── docs/                   # Documentation
│   ├── architecture_diagram.pdf          ← Team
│   ├── README.md                         ← Maintained by Person 4
│   ├── Project_Report.pdf                ← Final report
│
└── .gitignore
</pre>

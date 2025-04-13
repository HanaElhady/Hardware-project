# Hardware-project

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
│   │   ├── pc.vhd                         ← Person 1
│   │
│   ├── alu/
│   │   ├── alu.vhd                        ← Person 2
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
│   ├── tb_control_unit.vhd              ← Person 3
│   ├── tb_top_level.vhd                 ← Person 4
│
├── sim/                    # Simulation scripts or waveforms
│   ├── waveform.do                     ← Person 4 (optional)
│   ├── run_simulation.tcl             ← Person 4
│
├── docs/                   # Reports and references
│   ├── architecture_diagram.pdf       ← All
│   ├── README.md                      ← All (maintained by Person 4)
│   ├── Project_Report.pdf             ← Final report
│
└── .gitignore

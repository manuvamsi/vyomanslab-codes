# ⚡ VyomansLab — VLSI Design Projects

Open-source VLSI design projects exploring the complete RTL-to-GDSII flow using **Icarus Verilog**, **Yosys**, and **OpenROAD** on the **Nangate45** PDK.

🌐 **Website:** [manuvamsi.github.io/vyomansLAB](https://manuvamsi.github.io/vyomansLAB/)

---

## 📂 Projects

| # | Project | Folder | Flow | Highlights |
|---|---------|--------|------|------------|
| 1 | **Traffic Light v2** | `traffic-light-v2/` | RTL → Synth → PDA | 5-state FSM, 42 cells, 85% utilization |
| 2 | **Traffic Light v1** | `traffic-light-v1/` | RTL → Sim → Coverage → Synth → PDA | 3-state FSM, 20 cells, timer-based |
| 3 | **4-Bit Counter (Full PDA)** | `counter-full-pda/` | RTL → Sim → Coverage → Synth → PDA | 14 cells, complete flow |
| 4 | **Up/Down Counter with SDC** | `counter-sdc/` | RTL → Sim → SDC | Bidirectional counter, timing constraints |
| 5 | **4-Bit Counter (Sim Only)** | `counter-sim/` | RTL → Sim → Coverage | First-principles Verilog |

---

## 🔧 Toolchain

| Tool | Purpose | Install |
|------|---------|---------|
| [Icarus Verilog](https://github.com/steveicarus/iverilog) | RTL simulation | `sudo apt install iverilog` |
| [GTKWave](https://gtkwave.sourceforge.net/) | Waveform viewer | `sudo apt install gtkwave` |
| [Covered](https://github.com/hpretl/verilog-covered) | Code coverage | Build from source |
| [Yosys](https://github.com/YosysHQ/yosys) | Logic synthesis | `sudo apt install yosys` |
| [OpenROAD](https://github.com/The-OpenROAD-Project/OpenROAD) | Physical design | Build from source |

**PDK:** [Nangate45](https://github.com/The-OpenROAD-Project/OpenROAD/tree/master/test/Nangate45) (included with OpenROAD)

📖 **Full installation guide:** [manuvamsi.github.io/vyomansLAB/install.html](https://manuvamsi.github.io/vyomansLAB/install.html)

---

## 🚀 Quick Start

```bash
# Clone this repo
git clone https://github.com/manuvamsi/vyomanslab-codes.git
cd vyomanslab-codes

# Run a project (e.g., counter-full-pda)
cd counter-full-pda

# 1. Simulate
iverilog -o counter counter_4bit.v tb_counter_4bit.v && vvp counter

# 2. View waveforms
gtkwave counter.vcd

# 3. Synthesize
yosys -s yosys_run.tcl

# 4. Physical Design
openroad openroad_run.tcl
```

---

## 📁 Repo Structure

```
vyomanslab-codes/
├── traffic-light-v2/                # 5-state FSM (highway/country road)
│   ├── traffic_light_v2.v           # RTL design
│   ├── tb_traffic_light_v2.v        # Testbench
│   ├── traffic_light_v2.sdc         # Timing constraints
│   ├── yosys_run.tcl                # Synthesis script
│   └── openroad_run.tcl             # PDA script
│
├── traffic-light-v1/                # 3-state FSM (RED/GREEN/YELLOW)
│   ├── traffic_light.v
│   ├── tb_traffic_light.v
│   ├── traffic_light.sdc
│   ├── yosys_run.tcl
│   └── openroad_run.tcl
│
├── counter-full-pda/                # 4-bit counter full flow
│   ├── counter_4bit.v
│   ├── tb_counter_4bit.v
│   ├── counter_4bit.sdc
│   ├── yosys_run.tcl
│   └── openroad_run.tcl
│
├── counter-sdc/                     # Up/down counter with SDC
│   ├── up_down_counter.v
│   ├── tb_up_down_counter.v
│   └── up_down_counter.sdc
│
└── counter-sim/                     # Simulation-only counter
    ├── counter_4bit.v
    └── tb_counter_4bit.v
```

---

## 📜 License

This project is open-source and available under the [MIT License](LICENSE).

---

<p align="center">
  Made with ⚡ by <a href="https://manuvamsi.github.io/vyomansLAB/">VyomansLab</a>
</p>

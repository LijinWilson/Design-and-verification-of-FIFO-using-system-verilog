# 🚀 Design and Verification of Synchronous FIFO using Verilog

A parameterized **Synchronous FIFO (First-In-First-Out)** designed in **Verilog HDL** with a functional testbench for verification. The project demonstrates FIFO memory architecture, pointer management, and full/empty flag generation.

---

## 📌 Features

- ✅ Parameterized FIFO Depth & Data Width
- ✅ Single Clock (Synchronous FIFO)
- ✅ Active-Low Asynchronous Reset
- ✅ Circular Buffer Architecture
- ✅ Read & Write Pointer Management
- ✅ Full and Empty Flag Detection
- ✅ Functional Verification Testbench
- ✅ GTKWave Compatible (`dump.vcd`)

---

## ⚙️ Specifications

| Parameter | Value |
|-----------|-------|
| FIFO Type | Synchronous |
| Depth | 8 Entries |
| Data Width | 32-bit |
| Clock | Single Clock |
| Reset | Active-Low |

---

## 🏗️ FIFO Operation

📥 **Write**
- `cs = 1`
- `wr_en = 1`
- FIFO not Full

📤 **Read**
- `cs = 1`
- `rd_en = 1`
- FIFO not Empty

---

## 🧠 Flag Logic

**Empty**

```verilog
read_pointer == write_pointer
```

**Full**

```verilog
read_pointer ==
{~write_pointer[MSB], write_pointer[LSB]}
```

---

## 🧪 Test Scenarios

| Test | Description |
|------|-------------|
| ✅ Scenario 1 | Write 3 values → Read 3 values |
| ✅ Scenario 2 | Alternate Write & Read Operations |
| ✅ Scenario 3 | Fill FIFO → Read Complete FIFO |

All scenarios successfully verify **FIFO (First-In-First-Out)** behavior.

---

## ▶️ Run Simulation

```bash
iverilog -g2012 -o fifo_sim fifo.sv testbench.sv
vvp fifo_sim
gtkwave dump.vcd
```

---

## 📂 Repository

```
├── fifo.sv          # FIFO RTL Design
├── testbench.sv     # Testbench
├── output.sv        # Simulation Output
└── README.md
```

---

## 🎯 Learning Outcomes

- FIFO Design
- Pointer-Based Memory Access
- Full & Empty Flag Logic
- RTL Verification
- Verilog Testbench Development
- Waveform Analysis

---

## 👨‍💻 Author

**Lijin Wilson**  
*M.Tech VLSI Design*

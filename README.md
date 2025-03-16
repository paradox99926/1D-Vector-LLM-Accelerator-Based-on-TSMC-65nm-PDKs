# 1D Vector LLM Accelerator

## Overview

1D Vector LLM accelerator, course project for ECE 260B VLSI Integrated Circuits & Systems Design (Prof. Mingu Kang). 

- The design aims to speed up Q * K calculation of transformers.
- For simplicity, we use normalization instead of softmax.
- The results are unsigned number

## File Structure

```
Root Directory
├── syn
│   ├── core_syn
│   ├── sramin_syn
|   └── sramout_syn
├── pnr
│   ├── core_pnr
│   ├── sramin_pnr
|   └── sramout_pnr
└── source_file
```


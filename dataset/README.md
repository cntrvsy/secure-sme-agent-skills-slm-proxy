# Secure SME Agentic AI: Data Generation & Evaluation Pipeline

This repository contains the programmatic dataset synthesis and evaluation suite for the secure Small Language Model (SLM) proxy designed to secure SME Agent Skills (`SKILL.md`) against Indirect Prompt Injection (IPI) attacks.

The pipeline maps the 17 tool interfaces of the `InjecAgent` benchmark to industry-representative SME contexts, generates both Standard (unfiltered) and Domain-Aligned (context-matched) poisoned skills datasets, and evaluates the security and compression performance of the defensive proxy.

---

## Project Directory Structure

```
.
├── base_templates/                     # Standard clean SME Agent Skill templates
├── poisoned_skills/                    # Programmatically generated datasets
│   ├── standard/                       # Standard Mode (full cross-multiplication matrix)
│   │   ├── base/                       # Malicious payload only
│   │   └── enhanced/                   # Payload prepended with forced hacking prompt
│   └── domain_aligned/                 # Domain-Aligned Mode (contextually mapped subsets)
│       ├── base/
│       └── enhanced/
├── scripts/                            # Core python scripts
│   ├── create_base_templates.py        # Generates clean base templates
│   ├── generate_poisoned_skills.py     # Synthesizes poisoned datasets
│   └── evaluate_proxy.py               # Runs evaluation suite
└── temp_injecagent/                    # Original InjecAgent source repository
```

---

## Step-by-Step Execution Guide

All commands are fully compatible with standard shells and the **Fish** terminal environment.

### Step 1: Initialize Base Templates
Generate the 17 base Agent Skill templates framed in realistic SME contexts:
```bash
python3 scripts/create_base_templates.py
```

### Step 2: Generate Poisoned Skill Datasets

* **Generate Standard Dataset (2,108 files total)**
  Creates the full cross-domain matrix under `poisoned_skills/standard/` ($17 \text{ tools} \times 62 \text{ payloads} = 1,054$ cases per setting):
  ```bash
  python3 scripts/generate_poisoned_skills.py
  ```

* **Generate Domain-Aligned Dataset (828 files total)**
  Creates the contextually matched matrix under `poisoned_skills/domain_aligned/` (414 cases per setting):
  ```bash
  python3 scripts/generate_poisoned_skills.py --domain-aligned
  ```

---

## Evaluation Suite

The evaluation suite calculates three core metrics: **Format Integrity Pass Rate**, **ASR-valid (Attack Success Rate)**, and **Token Compression Ratio**.

### 1. Dry-Run / Validation (Mock Backend)
Run evaluation on a small sample of holdout cases using the `mock` backend to verify the pipeline, caching, and logging:

* **Evaluate Standard Mode (Base Setting, 10 sample cases)**:
  ```bash
  python3 scripts/evaluate_proxy.py --setting base --model-type mock --sample-size 10
  ```

* **Evaluate Domain-Aligned Mode (Base Setting, 10 sample cases)**:
  ```bash
  python3 scripts/evaluate_proxy.py --setting base --model-type mock --domain-aligned --sample-size 10
  ```

* **Evaluate Domain-Aligned Mode (Enhanced Setting, 10 sample cases)**:
  ```bash
  python3 scripts/evaluate_proxy.py --setting enhanced --model-type mock --domain-aligned --sample-size 10
  ```

### 2. Local Model Inference (Ollama & LM Studio)

#### Using Ollama
Ensure [Ollama](https://ollama.com/) is running locally and has the target model pulled (e.g., `ollama run gemma:2b`). Then execute evaluation:
```bash
python3 scripts/evaluate_proxy.py --setting base --model-type ollama --domain-aligned
```

#### Using LM Studio (OpenAI-Compatible Local API)
Launch the Local Server in LM Studio (usually runs on port `1234`). Then run the evaluation using the `lmstudio` backend:
```bash
python3 scripts/evaluate_proxy.py --setting base --model-type lmstudio --domain-aligned
```
*(Note: Progress is cached case-by-case under the `results/` folder, allowing evaluation to resume automatically if interrupted).*

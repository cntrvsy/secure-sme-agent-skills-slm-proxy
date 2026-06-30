# Secure SME Agentic AI: Data Generation & Evaluation Pipeline

This repository contains the programmatic dataset synthesis, SFT training preparation, and evaluation suite for the secure Small Language Model (SLM) proxy designed to protect SME Agent Skills (`SKILL.md`) against Indirect Prompt Injection (IPI) attacks.

The pipeline maps the 17 tool interfaces of the `InjecAgent` benchmark to industry-representative SME contexts, generates both Standard (unfiltered) and Domain-Aligned (context-matched) poisoned skills datasets, and evaluates the security and compression performance of the defensive proxy.

**Note**: To keep the repository clean and efficient, this pipeline operates as a **JSON-only, in-memory pipeline**. Synthesized skill contents are stored directly inside the metadata JSON files under the `"raw_skill_content"` key, eliminating the need to write thousands of individual `SKILL.md` files to disk.

---

## Methodological Design & Justifications

### 1. Target Output Synthesis (Gold Distilled Targets)

The original `InjecAgent` benchmark is an evaluation test suite and does not provide training targets or gold-standard defensive outputs. To enable Supervised Fine-Tuning (SFT) of a defensive proxy, we synthesized **17 hand-crafted "gold distilled" target skills** (defined in `scripts/create_base_templates.py).

For any given input case using a specific tool, the target output is the corresponding clean, compressed, and fully sanitized `gold_distilled` skill. This teaches the SLM a robust many-to-one mapping: regardless of what malicious or benign content is injected into the input, the model learns to discard it and output only the clean tool schema.

### 2. Shortcut Learning Mitigation

Small Language Models (SLMs) are highly prone to _shortcut learning_—memorizing superficial patterns (e.g., always stripping text following a colon after the word _"untrusted"_ at the end of a description). To ensure the model learns semantic security rather than pattern memorization, we:

- **Vary Injection Positions**: The `<Attacker Instruction>` placeholder is placed in different locations across the 17 templates (some in YAML `description`, some in custom YAML fields like `external_context`, some in Markdown parameters, some in usage procedures, and others in body notes).
- **Vary Phrasing**: Each template uses a unique warning and contextual phrasing.

### 3. Benign Hard Negatives

To evaluate and prevent **over-refusal** or **false-positives** (where the model mangles or refuses a skill just because it contains warning language), we generate **170 benign hard negatives** (17 templates × 10 benign payloads like `"none"`, `"no unusual activity"`, etc.). These contain the warning scaffolding but no malicious instructions.

---

## Project Directory Structure

```
.
├── poisoned_skills/                    # Consolidated SFT & Evaluation Metadata
│   ├── standard_base_cases.json        # Standard Mode (base setting metadata & content)
│   ├── standard_enhanced_cases.json    # Standard Mode (enhanced setting metadata & content)
│   ├── standard_benign_cases.json      # Standard Mode (benign setting metadata & content)
│   ├── domain_aligned_base_cases.json  # Domain-Aligned (base setting metadata & content)
│   ├── domain_aligned_enhanced_cases.json
│   └── domain_aligned_benign_cases.json
├── results/                            # Cached evaluation results (.jsonl)
├── scripts/                            # Core python scripts
│   ├── create_base_templates.py        # Holds the base templates and gold distilled targets
│   ├── generate_poisoned_skills.py     # Synthesizes poisoned & benign datasets (in-memory)
│   ├── prepare_sft_dataset.py          # Formats datasets for Unsloth SFT training (in-memory)
│   └── evaluate_proxy.py               # Runs evaluation suite (in-memory)
├── temp_injecagent/                    # InjecAgent source data
│   └── data/                           # test_cases_dh_base.json, etc.
├── sft_dataset_alpaca.jsonl            # Compiled Alpaca-format SFT dataset
├── sft_dataset_chatml.jsonl            # Compiled ChatML-format SFT dataset
└── sft_dataset_domain_aligned.jsonl    # Compiled Domain-Aligned SFT dataset
```

---

## Step-by-Step Execution Guide

### Step 1: Generate Poisoned & Benign Skill Datasets (In-Memory)

Generate the datasets containing the poisoned and benign skills. The templates are loaded programmatically from the Python module, and the synthesized skill text is stored directly inside the metadata `.json` files.

- **Generate Standard Dataset**
  Creates the full cross-domain matrix ($17 \text{ tools} \times 62 \text{ payloads} = 1,054$ cases per setting, plus 170 benign cases):

  ```bash
  python3 scripts/generate_poisoned_skills.py
  ```

- **Generate Domain-Aligned Dataset**
  Creates the contextually matched matrix (414 cases per setting, plus 170 benign cases):
  ```bash
  python3 scripts/generate_poisoned_skills.py --domain-aligned
  ```

### Step 2: Prepare SFT Training Dataset (For Unsloth)

Convert the synthesized skill content (stored in the `.json` files) and their corresponding `gold_distilled` targets into a flat JSONL file ready for Unsloth SFT. The script automatically deduplicates identical rows.

- **Compile Alpaca Format (Recommended)**:

  ```bash
  python3 scripts/prepare_sft_dataset.py --format alpaca --output sft_dataset_alpaca.jsonl
  ```

- **Compile ChatML/ShareGPT Format**:

  ```bash
  python3 scripts/prepare_sft_dataset.py --format chatml --output sft_dataset_chatml.jsonl
  ```

- **Compile Domain-Aligned Only**:
  ```bash
  python3 scripts/prepare_sft_dataset.py --mode domain_aligned --format alpaca --output sft_dataset_domain_aligned.jsonl
  ```

### Step 3: Run the Evaluation Suite (In-Memory)

The evaluation suite runs entirely in-memory using the synthesized skill text stored in the JSON metadata. It calculates three core metrics: **Format Integrity Pass Rate**, **ASR-valid (Attack Success Rate)**, and **Token Compression Ratio**.

- **Dry-Run / Validation (Mock Backend, 10 sample cases)**:

  ```bash
  python3 scripts/evaluate_proxy.py --setting base --model-type mock --sample-size 10
  ```

- **Evaluate Benign Hard Negatives (Mock Backend, 10 sample cases)**:

  ```bash
  python3 scripts/evaluate_proxy.py --setting benign --model-type mock --sample-size 10
  ```

- **Local Model Inference (Ollama - Gemma 2B)**:
  Ensure Ollama is running and has the target model pulled (e.g., `ollama run gemma:2b`). Then run:

  ```bash
  python3 scripts/evaluate_proxy.py --setting base --model-type ollama --domain-aligned
  ```

- **Local Model Inference (LM Studio / OpenAI-Compatible API)**:
  1. Open **LM Studio**.
  2. Go to the **Local Server** tab (double-chat bubble icon on the left sidebar).
  3. Select your trained SLM from the dropdown at the top.
  4. Click **Start Server** (default port is `1234`).
  5. Run the evaluation script targeting the server:
     * *Evaluate Standard dataset*:
       ```bash
       python3 scripts/evaluate_proxy.py --setting base --model-type lmstudio
       ```
     * *Evaluate Domain-Aligned dataset*:
       ```bash
       python3 scripts/evaluate_proxy.py --setting base --model-type lmstudio --domain-aligned
       ```
     * *Evaluate Benign Hard Negatives*:
       ```bash
       python3 scripts/evaluate_proxy.py --setting benign --model-type lmstudio
       ```
  _(Note: Progress is cached case-by-case under `results/`, allowing the evaluation to resume automatically if interrupted)._

# Evaluation Results Summary

This file logs the security, formatting, and compression performance of the fine-tuned defensive proxy model versus the baseline vanilla model on the holdout evaluation split. [link to dataset](https://huggingface.co/datasets/cntrvsy/synthezised_sme_poisoned_skillsmd)

---

## 1. Fine-Tuned Model: `qwen2.5-3b-instruct_skills_security_proxy`

[qwen2.5-3b-instruct-skills-security-proxy](https://huggingface.co/cntrvsy/qwen2.5-3B-Instruct_skills_security_proxy)

### Base (Standard Attacks)

- **Status**: Completed
- **Format Integrity Pass Rate**: 100.00% (554/554)
- **Attack Success Rate (ASR-valid)**: 0.00% (0/554)
- **Average Token Compression Ratio**: 1.39x
- **Log Location**: `results/evaluation_lmstudio_standard_base_results.jsonl`

### Enhanced (Jailbreak Attacks)

- **Status**: Completed
- **Format Integrity Pass Rate**: 100.00% (554/554)
- **Attack Success Rate (ASR-valid)**: 0.00% (0/554)
- **Average Token Compression Ratio**: 1.53x
- **Log Location**: `results/evaluation_lmstudio_standard_enhanced_results.jsonl`

### Benign (Hard Negatives)

- **Status**: Completed
- **Format Integrity Pass Rate**: 100.00% (90/90)
- **False-Alarm Rate (mangle rate)**: 0.00%
- **Average Token Compression Ratio**: 1.14x
- **Log Location**: `results/evaluation_lmstudio_standard_benign_results.jsonl`

---

## 2. Baseline Model: `qwen2.5-vl-3b-instruct`

[qwen2.5-vl-3b-instruct](https://huggingface.co/lmstudio-community/Qwen2.5-VL-3B-Instruct-GGUF)

### Base (Standard Attacks)

- **Status**: Completed
- **Format Integrity Pass Rate**: 96.21% (533/554)
- **Attack Success Rate (ASR-valid)**: 3.38% (18/533)
- **Average Token Compression Ratio**: 4.69x
- **Log Location**: `results/evaluation_lmstudio_standard_base_results.jsonl`

### Enhanced (Jailbreak Attacks)

- **Status**: Completed
- **Format Integrity Pass Rate**: 96.75% (536/554)
- **Attack Success Rate (ASR-valid)**: 2.24% (12/536)
- **Average Token Compression Ratio**: 5.08x
- **Log Location**: `results/evaluation_lmstudio_standard_enhanced_results.jsonl`

### Benign (Hard Negatives)

- **Status**: Completed
- **Format Integrity Pass Rate**: 96.67% (87/90)
- **False-Alarm Rate (mangle rate)**: 3.33% (3/90)
- **Average Token Compression Ratio**: 4.02x
- **Log Location**: `results/evaluation_lmstudio_standard_benign_results.jsonl`

---

## Combined Comparison Matrix

| Model & Setting           | Format Pass Rate        | ASR-Valid               | Avg. Compression |
| :------------------------ | :---------------------- | :---------------------- | :--------------- |
| **Fine-Tuned - Base**     | **100.00%**             | **0.00%**               | 1.39x            |
| **Fine-Tuned - Enhanced** | **100.00%**             | **0.00%**               | 1.53x            |
| **Fine-Tuned - Benign**   | **100.00%** (Usability) | **0.00%** (False-Alarm) | 1.14x            |
| **Vanilla - Base**        | 96.21%                  | 3.38%                   | **4.69x**        |
| **Vanilla - Enhanced**    | 96.75%                  | 2.24%                   | **5.08x**        |
| **Vanilla - Benign**      | 96.67% (Usability)      | 3.33% (False-Alarm)     | **4.02x**        |

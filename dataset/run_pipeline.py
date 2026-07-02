#!/usr/bin/env python3
"""
run_pipeline.py

A parent script to run the entire data generation and SFT preparation pipeline in order.
It programmatically generates the standard and domain-aligned poisoned skills and compiles
the corresponding train/holdout splits for training.
"""

import os
import subprocess
import argparse
import sys

def run_command(cmd, cwd=None):
    """Helper to run a shell command and print outputs."""
    print(f"\n[Running] {' '.join(cmd)}")
    result = subprocess.run(cmd, cwd=cwd)
    if result.returncode != 0:
        print(f"[Error] Command failed with exit code {result.returncode}")
        sys.exit(result.returncode)

def main():
    parser = argparse.ArgumentParser(description="Orchestrate the dataset generation and compilation pipeline.")
    parser.add_argument("--format", choices=["alpaca", "chatml"], default="alpaca",
                        help="Dataset format: alpaca or chatml (default: alpaca).")
    parser.add_argument("--split", choices=["all", "train", "holdout"], default="train",
                        help="Which split to compile: all, train, or holdout (default: train).")
    args = parser.parse_args()

    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Step 1: Generate Standard Poisoned Skills
    print("=== Step 1: Generating Standard Mode Poisoned Skills ===")
    run_command(["python3", "scripts/generate_poisoned_skills.py"], cwd=script_dir)

    # Step 2: Generate Domain-Aligned Poisoned Skills
    print("\n=== Step 2: Generating Domain-Aligned Mode Poisoned Skills ===")
    run_command(["python3", "scripts/generate_poisoned_skills.py", "--domain-aligned"], cwd=script_dir)

    # Step 3: Compile SFT Dataset for Standard Mode
    standard_output = f"sft_dataset_standard_{args.split}.jsonl"
    print(f"\n=== Step 3: Compiling SFT Dataset for Standard Mode ({args.split} split) ===")
    run_command([
        "python3", "scripts/prepare_sft_dataset.py",
        "--mode", "standard",
        "--setting", "all",
        "--split", args.split,
        "--format", args.format,
        "--output", standard_output
    ], cwd=script_dir)

    # Step 4: Compile SFT Dataset for Domain-Aligned Mode
    domain_aligned_output = f"sft_dataset_domain_aligned_{args.split}.jsonl"
    print(f"\n=== Step 4: Compiling SFT Dataset for Domain-Aligned Mode ({args.split} split) ===")
    run_command([
        "python3", "scripts/prepare_sft_dataset.py",
        "--mode", "domain_aligned",
        "--setting", "all",
        "--split", args.split,
        "--format", args.format,
        "--output", domain_aligned_output
    ], cwd=script_dir)

    print("\n" + "=" * 50)
    print("Pipeline Execution Complete!")
    print(f"Generated SFT files in '{script_dir}':")
    print(f"  - {standard_output}")
    print(f"  - {domain_aligned_output}")
    print("=" * 50)

if __name__ == "__main__":
    main()

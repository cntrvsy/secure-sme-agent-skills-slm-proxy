#!/usr/bin/env bash
# Exit immediately if a command exits with a non-zero status
set -e

# Target GPU card and hwmon paths (Radeon RX 9060 XT is card1)
CARD_PATH="/sys/class/drm/card1/device/hwmon/hwmon1/power1_cap"
SAFE_POWER_LIMIT="135000000" # 135 Watts (in microwatts)

echo "=========================================================="
echo "           Unsloth AMD Training Launcher                  "
echo "=========================================================="

if [ -f "$CARD_PATH" ]; then
    echo "[Hardware] Configuring GPU (card1) power cap to 135W for stability..."
    # Write to sysfs power cap using sudo (will prompt for password if needed)
    echo "$SAFE_POWER_LIMIT" | sudo tee "$CARD_PATH" > /dev/null
    echo "[Hardware] Power cap applied successfully."
else
    echo "[Warning] GPU power cap path not found at $CARD_PATH."
    echo "          Skipping hardware power cap."
fi

# Locate the Python script and virtual environment
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_BIN="/home/cntrvsy/.gemini/antigravity/scratch/unsloth-setup/.venv/bin/python"

echo "[Python] Launching training script..."
echo "----------------------------------------------------------"

# Execute python script and pass all command-line arguments to it
"$PYTHON_BIN" "$SCRIPT_DIR/Qwen2_5_3B_SKILLmd_Sanitizer_Finetune.py" "$@"

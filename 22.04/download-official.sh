#!/bin/bash
set -euo pipefail

# Download official Ubuntu 22.04.5 LTS ISO directly from Ubuntu servers
ISO_URL="https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
OUTPUT_FILE="ubuntu-22.04.5-live-server-amd64.iso"

echo "[INFO] Downloading Ubuntu 22.04.5 LTS ISO from official mirror..."
wget -O "${OUTPUT_FILE}" "${ISO_URL}"

echo "[OK] Download completed: ${OUTPUT_FILE}"
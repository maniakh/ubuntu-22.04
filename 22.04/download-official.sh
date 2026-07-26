#!/bin/bash
set -euo pipefail

ISO_URL="https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
OUTPUT="ubuntu-22.04.5-live-server-amd64.iso"

echo "[INFO] Downloading Ubuntu 22.04.5 LTS ISO directly from official server..."
curl -L -o "${OUTPUT}" "${ISO_URL}"
echo "[OK] Download completed: ${OUTPUT}"
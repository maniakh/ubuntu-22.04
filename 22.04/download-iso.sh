#!/bin/bash
set -euo pipefail

# Official public download script for users
ISO_URL="https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
OUTPUT="ubuntu-22.04.5-live-server-amd64.iso"

echo "[INFO] Downloading official Ubuntu 22.04.5 LTS ISO..."
curl -L -o "${OUTPUT}" "${ISO_URL}"
echo "[OK] Download completed: ${OUTPUT}"
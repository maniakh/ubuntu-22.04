#!/bin/bash
set -euo pipefail

# Private Google Drive download script for repository owner
FILE_ID="${1:-YOUR_PRIVATE_GOOGLE_DRIVE_FILE_ID}"
OUTPUT="ubuntu-22.04.5-live-server-amd64.iso"

if [[ "${FILE_ID}" == "YOUR_PRIVATE_GOOGLE_DRIVE_FILE_ID" ]]; then
  echo "[ERROR] Please provide your private Google Drive File ID."
  echo "Usage: bash my-drive-download.sh <GOOGLE_DRIVE_FILE_ID>"
  exit 1
fi

echo "[INFO] Downloading ISO from private Google Drive..."

curl -L -c /tmp/cookies.txt "https://docs.google.com/uc?export=download&id=${FILE_ID}" > /dev/null 2>&1
CONFIRM=$(cat /tmp/cookies.txt | grep -i download_warning | awk '{print $NF}' || true)
curl -L -b /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILE_ID}" -o "${OUTPUT}"
rm -f /tmp/cookies.txt

echo "[OK] Private download completed: ${OUTPUT}"
#!/bin/bash
set -euo pipefail

# Place your Google Drive File ID here
FILE_ID="${1:-YOUR_GOOGLE_DRIVE_FILE_ID}"
OUTPUT="ubuntu-22.04.5-live-server-amd64.iso"

if [[ "${FILE_ID}" == "YOUR_GOOGLE_DRIVE_FILE_ID" ]]; then
  echo "[ERROR] Please pass a valid Google Drive File ID or configure it in the script."
  echo "Usage: bash download-drive.sh <GOOGLE_DRIVE_FILE_ID>"
  exit 1
fi

echo "[INFO] Downloading Ubuntu 22.04.5 ISO directly from Google Drive..."

curl -L -c /tmp/cookies.txt "https://docs.google.com/uc?export=download&id=${FILE_ID}" > /dev/null 2>&1
CONFIRM=$(cat /tmp/cookies.txt | grep -i download_warning | awk '{print $NF}' || true)
curl -L -b /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILE_ID}" -o "${OUTPUT}"
rm -f /tmp/cookies.txt

echo "[OK] Download completed: ${OUTPUT}"
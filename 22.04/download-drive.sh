#!/bin/bash
set -euo pipefail

# Download ISO from private Google Drive using File ID
# Requires: File ID and Access Token or public/api key

if [[ -z "${1:-}" ]]; then
  echo "[ERROR] Usage: bash download-private-drive.sh <FILE_ID> [ACCESS_TOKEN]"
  echo "Example: bash download-private-drive.sh 1A2B3C4D5E6F7G"
  exit 1
fi

FILE_ID="$1"
TOKEN="${2:-}"
OUTPUT_FILE="ubuntu-22.04.5-live-server-amd64.iso"

echo "[INFO] Downloading ISO from Google Drive (ID: ${FILE_ID})..."

if [[ -n "${TOKEN}" ]]; then
  # Authorized request with Bearer Token (for private non-public files)
  curl -H "Authorization: Bearer ${TOKEN}" \
       -o "${OUTPUT_FILE}" \
       "https://www.googleapis.com/drive/v3/files/${FILE_ID}?alt=media"
else
  # Direct confirmation download logic for large files
  curl -L -c /tmp/cookies.txt "https://docs.google.com/uc?export=download&id=${FILE_ID}" > /dev/null 2>&1
  CONFIRM=$(cat /tmp/cookies.txt | grep -i download_warning | awk '{print $NF}' || true)
  curl -L -b /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=${CONFIRM}&id=${FILE_ID}" -o "${OUTPUT_FILE}"
  rm -f /tmp/cookies.txt
fi

echo "[OK] Download attempt finished: ${OUTPUT_FILE}"
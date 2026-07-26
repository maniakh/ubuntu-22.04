#!/bin/bash
set -euo pipefail

# ============================================================
# Ubuntu 22.04 VM - VirtualBox
# Gereksinim: VirtualBox kurulu olmalı
# Kullanım: bash create-vm.sh
# ============================================================

if ! command -v VBoxManage &>/dev/null; then
  echo "[ERROR] VirtualBox not found. Install from: https://www.virtualbox.org/wiki/Downloads"
  exit 1
fi

# ── Ayarlar ─────────────────────────────────────────────────
VM_NAME="ubuntu-2204"
RAM_MB=2048
VCPUS=2
DISK_GB=20
ISO_PATH="${1:-ubuntu-22.04.5-live-server-amd64.iso}"
VM_DIR="$HOME/VirtualBox VMs"

# ── ISO kontrolü ────────────────────────────────────────────
if [[ ! -f "$ISO_PATH" ]]; then
  echo "[ERROR] ISO not found: $ISO_PATH"
  echo "[INFO] Download: wget https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
  exit 1
fi

echo "[INFO] Creating VirtualBox VM: $VM_NAME"

# ── VM oluştur ──────────────────────────────────────────────
VBoxManage createvm --name "$VM_NAME" --ostype Ubuntu_64 --register

VBoxManage modifyvm "$VM_NAME" \
  --memory "$RAM_MB" \
  --cpus "$VCPUS" \
  --nic1 nat \
  --natpf1 "ssh,tcp,,2222,,22" \
  --boot1 dvd \
  --boot2 disk \
  --audio none

# ── Disk oluştur ────────────────────────────────────────────
DISK_PATH="${VM_DIR}/${VM_NAME}/${VM_NAME}.vdi"
VBoxManage createhd --filename "$DISK_PATH" --size $((DISK_GB * 1024)) --format VDI

VBoxManage storagectl "$VM_NAME" --name "SATA" --add sata --controller IntelAhci
VBoxManage storageattach "$VM_NAME" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "$DISK_PATH"

VBoxManage storagectl "$VM_NAME" --name "IDE" --add ide
VBoxManage storageattach "$VM_NAME" --storagectl "IDE" --port 0 --device 0 --type dvddrive --medium "$(realpath $ISO_PATH)"

echo "[OK] VM created: $VM_NAME"
echo "[INFO] Start: VBoxManage startvm '$VM_NAME'"
echo "[INFO] SSH after install: ssh -p 2222 user@localhost"
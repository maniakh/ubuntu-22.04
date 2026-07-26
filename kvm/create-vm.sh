#!/bin/bash
set -euo pipefail

# ============================================================
# Ubuntu 22.04 VM - KVM/QEMU
# Gereksinim: qemu-kvm libvirt-daemon-system virtinst
# Kullanım: sudo bash create-vm.sh
# ============================================================

if [[ $EUID -ne 0 ]]; then
  echo "[ERROR] Run as root: sudo bash create-vm.sh"
  exit 1
fi

# ── Ayarlar ─────────────────────────────────────────────────
VM_NAME="ubuntu-2204"
RAM_MB=2048
VCPUS=2
DISK_GB=20
DISK_PATH="/var/lib/libvirt/images/${VM_NAME}.qcow2"
ISO_PATH="${1:-ubuntu-22.04.5-live-server-amd64.iso}"
NETWORK="default"

# ── Gerekli paketler ────────────────────────────────────────
echo "[INFO] Installing KVM dependencies..."
apt-get update -qq
apt-get install -y qemu-kvm libvirt-daemon-system virtinst qemu-utils

systemctl enable --now libvirtd

# ── ISO kontrolü ────────────────────────────────────────────
if [[ ! -f "$ISO_PATH" ]]; then
  echo "[ERROR] ISO not found: $ISO_PATH"
  echo "[INFO] Download: wget https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
  exit 1
fi

# ── Disk oluştur ────────────────────────────────────────────
echo "[INFO] Creating disk image (${DISK_GB}GB)..."
qemu-img create -f qcow2 "$DISK_PATH" "${DISK_GB}G"

# ── VM oluştur ──────────────────────────────────────────────
echo "[INFO] Creating VM: $VM_NAME"
virt-install \
  --name "$VM_NAME" \
  --ram "$RAM_MB" \
  --vcpus "$VCPUS" \
  --disk path="$DISK_PATH",format=qcow2 \
  --cdrom "$ISO_PATH" \
  --os-variant ubuntu22.04 \
  --network network="$NETWORK" \
  --graphics none \
  --console pty,target_type=serial \
  --extra-args 'console=ttyS0,115200n8 serial'

echo "[OK] VM created: $VM_NAME"
echo "[INFO] Manage: virsh list --all"
echo "[INFO] Connect: virsh console $VM_NAME"
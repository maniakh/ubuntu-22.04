#!/bin/bash
set -euo pipefail

# ============================================================
# Ubuntu 22.04 LTS - Minimal Basic Server Setup
# Usage: sudo bash setup.sh
# ============================================================

if [[ $EUID -ne 0 ]]; then
  echo "[ERROR] Run as root: sudo bash setup.sh"
  exit 1
fi

echo "[INFO] Starting basic Ubuntu 22.04 server setup..."

# 1. Update System
echo "[INFO] Updating system packages..."
apt-get update -qq
apt-get upgrade -y -qq

# 2. Basic Packages
echo "[INFO] Installing basic utilities (curl, wget, git, vim, htop, unzip, ufw)..."
apt-get install -y -qq curl wget git vim htop unzip ufw

# 3. Timezone
echo "[INFO] Setting timezone to UTC..."
timedatectl set-timezone UTC

# 4. Firewall (UFW)
echo "[INFO] Enabling UFW firewall and allowing SSH..."
ufw --force reset > /dev/null
ufw default deny incoming > /dev/null
ufw default allow outgoing > /dev/null
ufw allow ssh > /dev/null
ufw --force enable > /dev/null

echo ""
echo "[OK] Basic setup completed successfully."
echo "  - System updated"
echo "  - Basic tools installed"
echo "  - Timezone: UTC"
echo "  - UFW Firewall: Active (SSH allowed)"
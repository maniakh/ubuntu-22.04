#!/bin/bash
set -euo pipefail

# ============================================================
# Ubuntu 22.04 LTS (Jammy) - Initial Server Setup
# Usage: sudo bash setup.sh
# ============================================================

if [[ $EUID -ne 0 ]]; then
  echo "[ERROR] Run as root: sudo bash setup.sh"
  exit 1
fi

echo "[INFO] Starting Ubuntu 22.04 server setup..."

# ── 1. System Update ────────────────────────────────────────
echo "[INFO] Updating system packages..."
apt-get update -qq
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq
apt-get autoremove -y -qq

# ── 2. Essential Packages ───────────────────────────────────
echo "[INFO] Installing essential packages..."
apt-get install -y \
  curl wget git vim nano \
  htop iotop net-tools \
  unzip tar \
  ca-certificates gnupg \
  ufw fail2ban \
  unattended-upgrades \
  chrony

# ── 3. Timezone ─────────────────────────────────────────────
echo "[INFO] Setting timezone to UTC..."
timedatectl set-timezone UTC
systemctl enable --now chrony

# ── 4. Sysctl Hardening ─────────────────────────────────────
echo "[INFO] Applying sysctl settings..."
cat > /etc/sysctl.d/99-server.conf <<EOF
# Network hardening
net.ipv4.ip_forward = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.tcp_syncookies = 1

# File system
fs.file-max = 100000
EOF
sysctl --system > /dev/null

# ── 5. UFW Firewall ─────────────────────────────────────────
echo "[INFO] Configuring UFW firewall..."
ufw --force reset
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

# ── 6. Fail2ban ─────────────────────────────────────────────
echo "[INFO] Configuring fail2ban..."
cat > /etc/fail2ban/jail.local <<EOF
[DEFAULT]
bantime  = 1h
findtime = 10m
maxretry = 50

[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
backend = %(syslog_backend)s
EOF
systemctl enable --now fail2ban

# ── 7. SSH Hardening ────────────────────────────────────────
echo "[INFO] Hardening SSH..."
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#*MaxAuthTries.*/MaxAuthTries 3/' /etc/ssh/sshd_config
sed -i 's/^#*LoginGraceTime.*/LoginGraceTime 20/' /etc/ssh/sshd_config
sed -i 's/^#*X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config
systemctl restart ssh

# ── 8. Automatic Security Updates ───────────────────────────
echo "[INFO] Enabling automatic security updates..."
cat > /etc/apt/apt.conf.d/20auto-upgrades <<EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
EOF
systemctl enable --now unattended-upgrades

# ── 9. Summary ──────────────────────────────────────────────
echo ""
echo "[OK] Ubuntu 22.04 server setup complete."
echo ""
echo "  Hostname  : $(hostname)"
echo "  IP        : $(hostname -I | awk '{print $1}')"
echo "  Timezone  : $(timedatectl | grep 'Time zone' | awk '{print $3}')"
echo "  Firewall  : $(ufw status | head -1)"
echo "  Fail2ban  : $(systemctl is-active fail2ban)"
echo "  Auto-updates: enabled"
echo ""
echo "[INFO] Reboot recommended: sudo reboot"
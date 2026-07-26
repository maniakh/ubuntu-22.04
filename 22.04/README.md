# Ubuntu 22.04 LTS Setup

## Usage

```bash
sudo bash setup.sh
```

## What Gets Configured

| Component | Action |
|-----------|--------|
| System | Full update & upgrade |
| Packages | curl, git, vim, htop, net-tools, unzip + more |
| Timezone | Set to UTC |
| UFW | Enabled — only SSH allowed inbound |
| Fail2ban | Enabled — SSH brute-force protection (5 attempts = 1h ban) |
| SSH | Root login disabled, max 3 auth tries |
| Sysctl | Network hardening applied |
| Auto-updates | Unattended security updates enabled |

## Post-Setup Checks

```bash
sudo ufw status verbose
sudo fail2ban-client status sshd
sudo systemctl status unattended-upgrades
```
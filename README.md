# ubuntu-setup

Initial server setup and hardening scripts for Ubuntu LTS.

## Supported Versions

| Version | Codename | Status |
|---------|----------|--------|
| 22.04 | Jammy Jellyfish | ✅ LTS (supported until 2027) |

## What It Does

- System update & upgrade
- Installs essential tools (curl, git, vim, htop, unzip, net-tools)
- Sets timezone to UTC
- Configures UFW firewall (SSH allowed, rest denied)
- Enables fail2ban (brute-force protection)
- SSH hardening (disables root login, password auth optional)
- Configures sysctl for server workloads
- Enables automatic security updates

## Usage

```bash
git clone https://github.com/maniakh/ubuntu-setup.git
cd ubuntu-setup/22.04
sudo bash setup.sh
```

## After Setup

```bash
# Check firewall
sudo ufw status

# Check fail2ban
sudo systemctl status fail2ban

# Check automatic updates
sudo systemctl status unattended-upgrades
```

## License

MIT
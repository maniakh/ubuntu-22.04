# ubuntu-setup

Minimal basic server setup script for fresh Ubuntu 22.04 LTS installations.

## 1. Ubuntu 22.04 ISO Download

Download ISO directly:
https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso

Or via terminal:
```bash
wget https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso
```

---

## 2. Server Setup (Post-Installation)

Run this script after installing Ubuntu Server:

```bash
git clone https://github.com/maniakh/ubuntu-setup.git
cd ubuntu-setup/22.04
sudo bash setup.sh
```

### What `setup.sh` Configures
- System Update (`apt update && apt upgrade`)
- Essential Tools (`curl`, `wget`, `git`, `vim`, `htop`, `unzip`, `ufw`)
- Timezone (UTC)
- Firewall (UFW active, SSH allowed)

## License
MIT
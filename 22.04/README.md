# ubuntu-setup

Minimal basic server setup script for fresh Ubuntu 22.04 LTS installations.

## Quick Start

```bash
git clone https://github.com/maniakh/ubuntu-setup.git
cd ubuntu-setup/22.04
sudo bash setup.sh
```

## What It Does

- Updates system packages (`apt update && apt upgrade`)
- Installs basic essential tools (`curl`, `wget`, `git`, `vim`, `htop`, `unzip`, `ufw`)
- Sets system timezone to UTC
- Enables UFW firewall (Allows SSH only)

## License

MIT
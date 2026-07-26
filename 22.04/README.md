# ubuntu-setup

Minimal basic server setup script and ISO download helpers for Ubuntu 22.04 LTS.

## 1. ISO Download Options

### Option A: Official Download (Public / Standard)
Downloads official Ubuntu 22.04.5 Live Server ISO directly from Ubuntu mirrors:

```bash
bash 22.04/download-official.sh
```

### Option B: Private Google Drive Download
Downloads ISO from your private Google Drive file:

```bash
# Public link or API token authorized download
bash 22.04/download-drive.sh <YOUR_DRIVE_FILE_ID> [YOUR_API_ACCESS_TOKEN]
```

---

## 2. Server Setup (Post-Installation)

Run after installing Ubuntu Server:

```bash
git clone https://github.com/maniakh/ubuntu-setup.git
cd ubuntu-setup/22.04
sudo bash setup.sh
```

### What `setup.sh` Does
- System update (`apt update && apt upgrade`)
- Basic packages (`curl`, `wget`, `git`, `vim`, `htop`, `unzip`, `ufw`)
- Timezone set to UTC
- UFW Firewall active (SSH port allowed)

## License

MIT
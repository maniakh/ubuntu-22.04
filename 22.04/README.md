# ubuntu-setup

Minimal basic server setup script and ISO direct downloaders for Ubuntu 22.04 LTS.

## Direct ISO Downloaders

### Option 1: Official Ubuntu Server Mirror (Direct Link)
```bash
bash 22.04/download-official.sh
```

### Option 2: Direct Google Drive Link
```bash
bash 22.04/download-drive.sh <GOOGLE_DRIVE_FILE_ID>
```

---

## Basic Server Setup (Post-Install)

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
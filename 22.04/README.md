# ubuntu-setup

Minimal basic server setup script and ISO downloaders for Ubuntu 22.04 LTS.

## ISO Download

Users can download the official Ubuntu 22.04.5 Live Server ISO directly:

```bash
bash 22.04/download-iso.sh
```

---

## Basic Server Setup (Post-Install)

After installing Ubuntu Server:

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
# VirtualBox ile Ubuntu 22.04 VM

## Gereksinimler

- VirtualBox kurulu: https://www.virtualbox.org/wiki/Downloads

## Kullanım

```bash
# ISO ile aynı klasörde çalıştır
bash create-vm.sh

# veya ISO yolu belirt
bash create-vm.sh /path/to/ubuntu-22.04.5-live-server-amd64.iso
```

## VM Yönetimi

```bash
# VM başlat (GUI)
VBoxManage startvm "ubuntu-2204"

# VM başlat (headless)
VBoxManage startvm "ubuntu-2204" --type headless

# SSH ile bağlan (kurulum sonrası)
ssh -p 2222 ubuntu@localhost

# VM durdur
VBoxManage controlvm "ubuntu-2204" poweroff

# VM sil
VBoxManage unregistervm "ubuntu-2204" --delete
```
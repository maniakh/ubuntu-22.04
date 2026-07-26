# KVM/QEMU ile Ubuntu 22.04 VM

## Gereksinimler

- Linux host (Ubuntu/Debian/CentOS)
- KVM destekli CPU: `grep -c vmx /proc/cpuinfo` (0'dan büyükse destekli)

## Kullanım

```bash
# ISO ile aynı klasörde çalıştır
sudo bash create-vm.sh

# veya ISO yolu belirt
sudo bash create-vm.sh /path/to/ubuntu-22.04.5-live-server-amd64.iso
```

## VM Yönetimi

```bash
# VM listesi
virsh list --all

# VM konsola bağlan
virsh console ubuntu-2204

# VM başlat/durdur
virsh start ubuntu-2204
virsh shutdown ubuntu-2204

# VM sil
virsh destroy ubuntu-2204
virsh undefine ubuntu-2204
rm /var/lib/libvirt/images/ubuntu-2204.qcow2
```
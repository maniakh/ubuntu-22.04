# Otomatik Kurulum (Autoinstall)

Ubuntu 22.04, manuel kurulum yerine `autoinstall` ile tamamen otomatik kurulabilir.

## Nasıl Kullanılır?

### KVM ile Otomatik Kurulum

```bash
sudo virt-install \
  --name ubuntu-2204-auto \
  --ram 2048 \
  --vcpus 2 \
  --disk size=20 \
  --location ubuntu-22.04.5-live-server-amd64.iso \
  --initrd-inject autoinstall/user-data \
  --initrd-inject autoinstall/meta-data \
  --extra-args "autoinstall ds=nocloud" \
  --os-variant ubuntu22.04 \
  --network network=default \
  --graphics none \
  --console pty,target_type=serial
```

### Önemli: Şifreyi Hashle

`user-data` dosyasında `password` alanına hashlenmiş şifre gerekir:

```bash
openssl passwd -6 'sifreniz'
```

Çıktıyı `user-data` dosyasındaki `REPLACE_WITH_HASHED_PASSWORD` ile değiştir.
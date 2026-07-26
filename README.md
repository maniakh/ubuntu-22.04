# ubuntu-setup

Sıfırdan Ubuntu 22.04 LTS kurulum rehberi ve sunucu hazırlık scriptleri.

---

## Adım 1 — ISO İndir

```bash
wget https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso

# SHA256 doğrula
echo "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd *ubuntu-22.04.5-live-server-amd64.iso" \
  | sha256sum --check
```

---

## Adım 2 — Kurulum Yöntemi Seç

### A) KVM/QEMU ile Sanal Makine (Linux host)

```bash
cd kvm
sudo bash create-vm.sh
```

### B) VirtualBox ile Sanal Makine (Linux/Windows host)

```bash
cd virtualbox
bash create-vm.sh
```

### C) Fiziksel Sunucu / USB

Rufus (Windows) veya `dd` (Linux) ile ISO'yu USB'ye yaz:

```bash
# Linux
sudo dd if=ubuntu-22.04.5-live-server-amd64.iso of=/dev/sdX bs=4M status=progress && sync
```

---

## Adım 3 — Otomatik Kurulum (Autoinstall)

Manuel kurulum yerine tam otomatik kurulum için `autoinstall/` klasörüne bak.

---

## Adım 4 — Sunucu Hazırlık (Post-Install)

Kurulum tamamlandıktan sonra:

```bash
git clone https://github.com/maniakh/ubuntu-setup.git
cd ubuntu-setup/22.04
sudo bash setup.sh
```

---

## Desteklenen Versiyon

| Sürüm | Codename | Destek |
|-------|----------|--------|
| 22.04 LTS | Jammy Jellyfish | ✅ 2027'ye kadar |
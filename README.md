# zboot: the Zig bootloader

## Dependancies
You will need OVMF
```bash
sudo pacman -S ovmf
```

## Run on Qemu command
```bash
qemu-system-x86_64 -bios /usr/share/ovmf/x64/OVMF.4m.fd -drive file=zboot.img,format=raw -m 4G
```
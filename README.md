# zboot: the Zig bootloader

## Dependancies
You will need OVMF
```bash
sudo pacman -S ovmf
```

## Run on Qemu command x86_64
```bash
qemu-system-x86_64 -bios /usr/share/ovmf/x64/OVMF.4m.fd -drive file=zboot.img,format=raw -m 4G
```

## Run on Qemu command aarch64
```bash
qemu-system-aarch64 -machine virt -cpu cortex-a57 -bios /usr/share/ovmf/aarch64/QEMU_EFI.fd -drive file=zboot-aarch64-uefi.img,format=raw -m 4G -serial stdio
```
I don't know why but qemu-system-aarch64 doesn't have an expected output to qemu window and I have to add the serial output to stdio for some reason
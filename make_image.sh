# not really to be used but more of a note for myself
qemu-img create -f raw zboot.img 64M
mkfs.fat -F 32 zboot.img
mkdir efi_mount/
sudo mount -o loop zboot.img efi_mount/
sudo mkdir -p efi_mount/EFI/BOOT
sudo cp zig-out/x86_64-uefi/zboot.efi efi_mount/EFI/BOOT/BOOTX64.EFI
sudo umount efi_mount
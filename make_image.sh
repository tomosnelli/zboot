# not really to be used but more of a note for myself
MOUNT="x86_64-uefi_mount"
TRIPLE="x86_64-uefi"
IMG="zboot-x86_64-uefi"
qemu-img create -f raw $IMG.img 64M
mkfs.fat -F 32 $IMG.img
mkdir $MOUNT/
sudo mount -o loop $IMG.img $MOUNT/
sudo mkdir -p $MOUNT/EFI/BOOT
sudo cp zig-out/$TRIPLE/zboot.efi $MOUNT/EFI/BOOT/BOOTX64.EFI
sudo umount $MOUNT
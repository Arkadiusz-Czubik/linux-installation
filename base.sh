sgdisk -n 0:0:+250M -t 0:ef00 -c 0:"EFI system partition" /dev/sda
sgdisk -n 0:0:+4G -t 0:8200 -c 0:"Linux swap" /dev/sda
sgdisk -n 0:0:0 -t 0:8300 -c 0:"Linux filesystem" /dev/sda

mkfs.vfat /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3

mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

pacstrap /mnt base linux linux-firmware amd-ucode git vim

genfstab -U /mnt >> /mnt/etc/fstab

cp -r linux-installation /mnt

arch-chroot /mnt

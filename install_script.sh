#! /bin/bash

#loadkeys uk
#timedatectl set-ntp true
#fdisk -l

#create the partitions and give them a type
#mkfs.vfat /dev/sda1
#mkswap /dev/sda2
#mkfs.ext4 /dev/sda3
#swapon /dev/sda2

#mount root partition
#mount /dev/sda3 /mnt

#mount boot partition to /mnt/boot/efi
#mkdir -p /mnt/boot/efi
#mount /dev/sda1 /mnt/boot/efi

#pacstrap /mnt base linux base-devel linux-firmware intel-ucode nano git

#genfstab -U /mnt >> /mnt/etc/fstab

#arch-chroot /mnt

#uncomment the locale in /etc/locale.gen

locale-gen
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc

touch /etc/hostname
touch /etc/locale.conf
touch /etc/vconsole.conf
echo "LANG=en_GB.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf
echo "Arch" >> /etc/hostname
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    Arch.localdomain    Arch" >> /etc/hosts

pacman -S man-db man-pages texinfo inetutils netctl dhcpcd networkmanager network-manager-applet wpa_supplicant wireless_tools dialog linux-headers grub efibootmgr dosfstools mtools firewalld xorg-server xorg-xinit alsa-utils pulseaudio pavucontrol bash-completion neovim terminator lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings cinnamon nemo-fileroller

#pacman -S nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable firewalld
systemctl enable fstrim.timer
systemctl enable lightdm

#change root password

#create new user now
#useradd -m -g wheel <user>
#passwd <user>

#give user access to sudo
#EDITOR=nano visudo
#uncomment %wheel ALL=(ALL) ALL

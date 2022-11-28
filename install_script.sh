#! /bin/bash

#loadkeys uk
#timedatectl set-ntp true
#fdisk -l

#create the partitions and give them a type
#mkfs.fat -F32 /dev/sda1
#mkswap /dev/sda2
#mkfs.ext4 /dev/sda3
#swapon /dev/sda2

#mount root partition
#mount /dev/sda3 /mnt

#mount boot partition to /mnt/boot/efi
#mkdir -p /mnt/boot/efi
#mount /dev/sda1 /mnt/boot/efi

#pacstrap /mnt base base-devel linux linux-headers linux-lts linux-lts-headers linux-firmware intel-ucode git neovim

#genfstab -U /mnt >> /mnt/etc/fstab

#arch-chroot /mnt

#change root password

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

pacman -S man-db man-pages inetutils netctl dhcpcd networkmanager network-manager-applet wpa_supplicant wireless_tools dialog grub efibootmgr dosfstools mtools firewalld xorg-server xorg-xinit alsa-utils pulseaudio pavucontrol bash-completion firefox mpv neofetch htop reflector python-pip flameshot noto-fonts noto-fonts-emoji ffmpegthumbs ntfs-3g alacritty

pacman -S sddm plasma-meta dolphin dolphin-plugins okular sweeper gwenview ark

# The dkms module is used if you want more than one kernel installed.
#pacman -S nvidia-dkms nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable firewalld
systemctl enable fstrim.timer
systemctl enable sddm

# Create new user
#useradd -m -g wheel <user>
#passwd <user>

# Give user access to sudo
#EDITOR=nvim visudo
#uncomment %wheel ALL=(ALL) ALL

# Configuring swappiness
#touch /etc/sysctl.d/100-swappiness.conf
#echo "vm.swappiness=10" >> /etc/sysctl.d/100-swappiness.conf

# IMPORTANT!
# Keymap setup after x11 is installed (restart and boot into system before running this)
#localectl --no-convert set-x11-keymap gb

# Manually configure the mirrorlist
#reflector -c GB -a 12 -p https --sort rate --save /etc/pacman.d/mirrorlist

# Setting default kernel to most recently selected
#nvim /etc/default/grub
#change GRUB_DEFAULT=0 to GRUB_DEFAULT=saved
#uncomment GRUB_SAVEDEFAULT=true

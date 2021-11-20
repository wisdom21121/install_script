!# /bin/bash

#loadkeys uk
#timedatectl set-ntp true
#fdisk -l
#create the partitions and give them a type
#mkfs.fat -F32 /dev/sda1
#mkswap /dev/sda2
#mkfs.ext4 /dev/sda3
#swapon /dev/sda2

#mount root partition before moving on
#mount /dev/sda3 /mnt

#pacstrap /mnt base linux linux-firmware nano git

#genfstab -U /mnt >> /mnt/etc/fstab

#arch-chroot /mnt

#uncomment the locale in /etc/locale.gen
#generate the locale with locale-gen

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

pacman -S sudo man-db man-pages texinfo inetutils netctl dhcpcd networkmanager network-manager-applet wpa_supplicant wireless_tools dialog linux-headers grub efibootmgr dosfstools mtools os-prober firewalld xorg-server xorg-xinit alsa-utils pulseaudio pavucontrol bash-completion intel-ucode neovim terminator base-devel lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings cinnamon nemo-fileroller

#pacman -S nvidia nvidia-utils nvidia-settings

#mount boot partition to /boot/EFI
mkdir -p /boot/EFI
mount /dev/sda1 /boot/EFI

grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=grub_uefi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable firewalld
systemctl enable fstrim.timer
systemctl enable lightdm

#change root password with passwd

#create new user now
#useradd -m -g wheel <your_user>
#passwd <your_user>
#give user access to sudo
#EDITOR=nano visudo
#uncomment %wheel ALL=(ALL) ALL

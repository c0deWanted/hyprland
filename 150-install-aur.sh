#!/bin/bash

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

sudo pacman -Syu

func_install() {
    if yay -Qi $1 &> /dev/null; then
        tput setaf 6
        echo "|» The package "$1" is already installed"
        echo
        tput sgr0
    else
        yay -S --noconfirm --needed $1
    fi
}


list=(
brave-bin
cava
cnijfilter-mg4200
deadbeef
#hw-probe
hardinfo-git
hyprland-nvidia-git
libva-nvidia-driver-git
nomacs
#paru-bin
sddm-git
#swaylock-effects
swayosd-git
#swww
#waybar-hyprland
waybar-hyprland-git
waybar-module-pacman-updates-git
#wlogout
xdg-desktop-portal-hyprland-git
)

yay -Suy --noconfirm &

count=0

for name in "${list[@]}" ; do
    count=$[count+1]
    func_install $name
done

yay -R --noconfirm xdg-desktop-portal-gnome xdg-desktop-portal-gtk &
sudo systemctl enable sddm.service

sleep 5
sudo sed -i 's/MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
echo -e "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia.conf

cd $installed_dir/Personal

sh 900-*

echo
tput setaf 6
sleep 3
echo "|» Done"
tput sgr0
echo

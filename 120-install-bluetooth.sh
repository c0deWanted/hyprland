#!/bin/bash

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

tput setaf 6
echo "|» Bluetooth"
tput sgr0

sudo pacman -S --noconfirm --needed blueman
#sudo pacman -S --noconfirm --needed blueberry
sudo pacman -S --noconfirm --needed bluez
sudo pacman -S --noconfirm --needed bluez-libs
sudo pacman -S --noconfirm --needed bluez-utils

sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

#sudo sed -i "s/'#AutoEnable=false'/'AutoEnable=true'/g" /etc/bluetooth/main.conf

if ! grep -q "load-module module-switch-on-connect" /etc/pulse/system.pa; then
    echo 'load-module module-switch-on-connect' | sudo tee --append /etc/pulse/system.pa
fi

if ! grep -q "load-module module-bluetooth-policy" /etc/pulse/system.pa; then
    echo 'load-module module-bluetooth-policy' | sudo tee --append /etc/pulse/system.pa
fi

if ! grep -q "load-module module-bluetooth-discover" /etc/pulse/system.pa; then
    echo 'load-module module-bluetooth-discover' | sudo tee --append /etc/pulse/system.pa
fi

tput setaf 6
echo "|» Done"
tput sgr0

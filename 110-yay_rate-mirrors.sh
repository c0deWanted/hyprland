#!/bin/bash

tput setaf 6
echo "|» Install yay"
tput sgr0

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si --noconfirm

tput setaf 6
echo "|» Done"
tput sgr0

tput setaf 6
echo "|» Rate Mirrors"
tput sgr0

yay -S --noconfirm --needed rate-mirrors-bin
sudo rate-mirrors --allow-root --save /etc/pacman.d/mirrorlist arch

tput setaf 6
echo "|» Done"
tput sgr0

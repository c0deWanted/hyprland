#!/bin/bash

# Set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="btcups.log"

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

# function that will test for a package and if not found it will attempt to install it
install() {
    # First lets see if the package is there
    if yay -Q $1 &>> /dev/null ; then
        echo -e "$COK - $1 is already installed."
    else
        # no package found so installing
        echo -e "$CNT - Now installing $1 ..."
        yay -S --noconfirm $1 &>> $INSTLOG
        # test to make sure package installed
        if yay -Q $1 &>> /dev/null ; then
            echo -e "\e[1A\e[K$COK - $1 was installed."
        else
            # if this is hit then a package is missing, exit to review log
            echo -e "\e[1A\e[K$CER - $1 install had failed, please check the install.log"
            exit
        fi
    fi
}

bt_stage=(
    bluez
    bluez-libs
    bluez-utils
)

cups_stage=(
    cups
    cups-pdf
    ghostscript
    gsfonts
    gutenprint
    gtk3-print-backends
    libcups
    system-config-printer
    sane
    simple-scan
)

# BT
read -rep $'[\e[1;33mACTION\e[0m] - 1. Blueman 2. Blueberry 3. none  (1 or 2 or 3) ' CONTINST
echo -e "$CNT - Bluetooth..."
for SOFTWR in ${bt_stage[@]}; do
    install $SOFTWR
done
if [[ $CONTINST == "1" ]]; then
    install blueman
fi
if [[ $CONTINST == "2" ]]; then
    install blueberry
fi

echo -e "$CNT - Enabling services"
sudo systemctl enable --now bluetooth.service &>> $INSTLOG

echo -e "$CNT - Writing /etc/pulse/system.pa"
if ! grep -q "load-module module-switch-on-connect" /etc/pulse/system.pa; then
    echo 'load-module module-switch-on-connect' | sudo tee --append /etc/pulse/system.pa &>> $INSTLOG
fi

if ! grep -q "load-module module-bluetooth-policy" /etc/pulse/system.pa; then
    echo 'load-module module-bluetooth-policy' | sudo tee --append /etc/pulse/system.pa &>> $INSTLOG
fi

if ! grep -q "load-module module-bluetooth-discover" /etc/pulse/system.pa; then
    echo 'load-module module-bluetooth-discover' | sudo tee --append /etc/pulse/system.pa &>> $INSTLOG
fi

# CUPS
read -rep $'[\e[1;33mACTION\e[0m] - Install CUPS? (y,n) ' CONTINST
echo -e "$CNT - CUPS..."
for SOFTWR in ${cups_stage[@]}; do
    install $SOFTWR
done
if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
    install $SOFTWR
fi

echo -e "$CNT - Enabling services"
sudo systemctl enable --now cups.service &>> $INSTLOG

#yay -S --noconfirm --needed cnijfilter-mg4200

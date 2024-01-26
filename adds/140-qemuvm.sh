#!/bin/bash

# Set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="qemuvm.log"

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))
username=$(whoami)

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

qemu_stage=(
    qemu-full
    libvirt
    bridge-utils
    virt-manager
    dnsmasq
)
# CUPS
read -rep $'[\e[1;33mACTION\e[0m] - Virtualisation tools? (y,n) ' CONTINST
if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
    echo -e "$CNT - Virtualisation tools..."
    for SOFTWR in ${qemu_stage[@]}; do
        install $SOFTWR
    done
    echo -e "$CNT - Enabling services"
    sudo systemctl enable --now libvirtd &>> $INSTLOG
    sleep 1
    echo -e "$CNT - Adding user to kvm group"
    sudo usermod -G kvm -a $username &>> $INSTLOG
    sleep 1
    echo -e "$CAT - Don't forget to reboot"
fi

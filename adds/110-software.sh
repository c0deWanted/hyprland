#!/bin/bash

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
INSTLOG="software.log"

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))
count=0

# function that will test for a package and if not found it will attempt to install it
func_install() {
    # First lets see if the package is there
    if yay -Q $1 &>> /dev/null ; then
        echo -e "$COK - $count. $1 is already installed."
    else
        # no package found so installing
        echo -e "$CNT - $count. Now installing $1 ..."
        yay -S --noconfirm $1 &>> $INSTLOG
        # test to make sure package installed
        if yay -Q $1 &>> /dev/null ; then
            echo -e "\e[1A\e[K$COK - $count. $1 was installed."
        else
            # if this is hit then a package is missing, exit to review log
            echo -e "\e[1A\e[K$CER - $count. $1 install had failed, please check the install.log"
            exit
        fi
    fi
}

sudo pacman -Syy &>> $INSTLOG

list=(
celluloid
cpuid
#deadbeef
deadbeef-git
deluge-gtk
evince
file-roller
geeqie
gimp
#gvfs-smb
#hw-probe
libreoffice-fresh
meld
#obsidian
#okular
#pv
solaar
)

for name in "${list[@]}" ; do
    count=$[count+1]
    func_install $name
done

### Copy Config Files ###
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    cp -rf $installed_dir/config/* $HOME/.config/
fi

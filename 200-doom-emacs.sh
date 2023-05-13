#!/bin/bash
#set -e

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

##################################################################################################################

sudo pacman -S --noconfirm --needed emacs

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install

###############################################################################################

cd $installed_dir/Personal

sh 910-*

tput setaf 6
echo "|» Done"
tput sgr0

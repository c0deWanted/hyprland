#!/bin/bash

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

read -r -p "Proceed? [Y/n] :" input

case $input in
      [yY][eE][sS]|[yY])
            tput setaf 6
            echo "|» Boost pacman"
            echo "|» Parallel downlods -> 10"
            tput sgr0

            FIND="#ParallelDownloads = 5"
            REPLACE="ParallelDownloads = 10"
            sudo sed -i "s/$FIND/$REPLACE/g" /etc/pacman.conf

            tput setaf 6
            echo "|» Candy"
            tput sgr0

            FINDCOLOR='#Color'
            REPLACECOLOR='Color\nILoveCandy'
            sudo sed -i "s/$FINDCOLOR/$REPLACECOLOR/g" /etc/pacman.conf

            echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment
            echo 'EXA_COLORS="di=1;33:da=37:ur=30;42:uw=30;42:ux=30;42:gr=30;43:gw=30;43:gx=30;43:tr=30;41:tw=30;41:tx=30;41:sn=37:sb=37:uu=32;1"' | sudo tee -a /etc/environment

            sudo pacman -Sy
            ;;
      [nN][oO]|[nN])
            tput setaf 6
            echo "|» Bye"
            tput sgr0
            exit 0
            ;;
      *)
            tput setaf 1
            echo "|» Invalid input..."
            echo "|» Quit"
            tput sgr0
            exit 1
            ;;
esac

#!/bin/bash
#set -e
##################################################################################################################
# Author    : Erik Dubois
# Website   : https://www.erikdubois.be
# Website   : https://www.alci.online
# Website   : https://www.ariser.eu
# Website   : https://www.arcolinux.info
# Website   : https://www.arcolinux.com
# Website   : https://www.arcolinuxd.com
# Website   : https://www.arcolinuxb.com
# Website   : https://www.arcolinuxiso.com
# Website   : https://www.arcolinuxforum.com
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
#tput setaf 0 = black
#tput setaf 1 = red
#tput setaf 2 = green
#tput setaf 3 = yellow
#tput setaf 4 = dark blue
#tput setaf 5 = purple
#tput setaf 6 = cyan
#tput setaf 7 = gray
#tput setaf 8 = light blue
##################################################################################################################

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

##################################################################################################################

echo
tput setaf 6
echo "|» Display manager"
tput sgr0
echo

# we are on Arch Linux

if grep -q "archlinux" /etc/os-release; then

	echo
	tput setaf 6
	echo "|» We are on ARCH LINUX"
	tput sgr0
	echo

	echo
	echo "Installing and changing sddm theme"
	echo "Archinstall is by default lightdm"
	echo "Any time tosddm"
	echo
	echo "Copying sddm files"
	sudo pacman -S --noconfirm --needed sddm arcolinux-sddm-simplicity-git
	sudo cp -f $installed_dir/sddm/sddm.conf /etc/sddm.conf

	[ -d /etc/sddm.conf.d ] || sudo mkdir /etc/sddm.conf.d
	sudo cp -f $installed_dir/sddm.conf.d/kde_settings.conf /etc/sddm.conf.d/kde_settings.conf
	FIND="Current=breeze"
	REPLACE="Current=arcolinux-simplicity"
	sudo sed -i "s/$FIND/$REPLACE/g" /etc/sddm.conf
	sudo cp -f $installed_dir/home/oh/Pictures/Backgrounds/bg023.jpg /usr/share/sddm/themes/arcolinux-simplicity/images/background.jpg

	if [ -f /etc/lightdm/lightdm.conf ]; then

		echo
		echo "Autologin to lightdm"
		echo
		FIND="#autologin-user="
		REPLACE="autologin-user=$USER"
    	sudo sed -i "s/$FIND/$REPLACE/g" /etc/lightdm/lightdm.conf

		FIND="#autologin-session="
		REPLACE="autlogin-session=xfce"
    	sudo sed -i "s/$FIND/$REPLACE/g" /etc/lightdm/lightdm.conf

    	sudo groupadd autologin
		sudo usermod -a -G autologin $USER

	fi

	if [ -f /etc/lightdm/lightdm-gtk-greeter.conf ]; then

		echo
		echo "Changing the look of lightdm gtk greeter"
		echo

		FIND="#theme-name="
		REPLACE="theme-name=Arc-Dark"
		sudo sed -i "s/$FIND/$REPLACE/g" /etc/lightdm/lightdm-gtk-greeter.conf

		sudo cp $installed_dir/settings/wallpaper/lightdm.jpg /etc/lightdm/lightdm.jpg

		FIND="#background="
		REPLACE="background=\/etc\/lightdm\/lightdm.jpg"
		sudo sed -i "s/$FIND/$REPLACE/g" /etc/lightdm/lightdm-gtk-greeter.conf

	fi

	echo
	tput setaf 6
	echo "|» Done"
	tput sgr0
	echo

fi


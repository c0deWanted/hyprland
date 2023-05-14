#!/bin/bash

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

func_install() {
    if pacman -Qi $1 &> /dev/null; then
        tput setaf 6
        echo "|» The package "$1" is already installed"
        echo
        tput sgr0
    else
        tput setaf 6
        echo "|» Installing package "  $1
        echo
        tput sgr0
        sudo pacman -S --noconfirm --needed $1
    fi
}

sudo pacman -Syy

echo
tput setaf 6
echo "|» Core software"
tput sgr0
echo


list=(
alacritty
#asciinema
avahi
bash-completion
bat
brightnessctl
#calcurse
cmake
cpupower
curl
deluge-gtk
duf
evince
expac
exa
faad2
fd
ffmpegthumbnailer
file-roller
fish
flatpak
font-manager
gimp
gnome-calculator
gnome-disk-utility
gparted
grim
gvfs
gvfs-smb
#hyprland
hblock
htop
inxi
#kitty
kvantum
libmad
libreoffice-fresh
libva
libzip
lshw
lxappearance
mako
man-db
man-pages
mlocate
meld
midori
mousepad
mpv
neofetch
networkmanager
network-manager-applet
networkmanager-openvpn
nm-connection-editor
ntp
nss-mdns
openresolv
pacman-contrib
pamixer
pavucontrol
playerctl
polkit-gnome
pv
python-pylint
python-pywal
python-requests
qt5-wayland
qt5ct
ripgrep
rsync
sddm
slurp
smartmontools
solaar
speedtest-cli
swappy
swaybg
system-config-printer
thunar
thunar-archive-plugin
thunar-media-tags-plugin
time
tldr
tree
tumbler
vnstat
wavpack
wget
wofi
xorg-xhost
#xdg-desktop-portal-hyprland

# EXTRACTION TOOLS
gzip
p7zip
unace
unrar
unzip

# FONTS
adobe-source-code-pro-fonts
adobe-source-sans-fonts
awesome-terminal-fonts
noto-fonts
noto-fonts-emoji
#ttf-bitstream-vera
#ttf-dejavu
#ttf-droid
#ttf-fira-sans
#ttf-inconsolata
ttf-jetbrains-mono
ttf-jetbrains-mono-nerd
ttf-mononoki-nerd
ttf-nerd-fonts-symbols-common
)

count=0

for name in "${list[@]}" ; do
    count=$[count+1]
    tput setaf 6;echo "|» Installing package nr.  "$count " " $name;tput sgr0;
    func_install $name
done

xhost +
sudo hblock
sudo systemctl enable avahi-daemon.service
sudo systemctl enable ntpd.service
sudo systemctl enable cpupower.service
sudo systemctl enable sddm.service
sudo systemctl enable vnstat.service
sudo systemctl enable NetworkManager.service


echo
tput setaf 6
echo "|» Install JAVA"
tput sgr0

sudo pacman -S --noconfirm --needed jdk17-openjdk
sudo pacman -S --noconfirm --needed jdk8-openjdk

if grep -q "archlinux" /etc/os-release; then
  echo
  tput setaf 6
  echo "|» Set Java 17 as default"
  tput sgr0
  sudo archlinux-java set java-17-openjdk
fi

echo
tput setaf 6
echo "|» Add Flatpak repo"
tput sgr0
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo
tput setaf 6
echo "|» Done"
tput sgr0
echo

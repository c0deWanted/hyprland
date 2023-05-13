#!/bin/bash
#set -e

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

echo
tput setaf 6
echo "|» Personal settings"
tput sgr0
echo

echo
tput setaf 6
echo "|» Copy configuration files"
tput sgr0
echo

cp -rf $installed_dir/settings/* $HOME/.config/

echo
tput setaf 6
echo "|» Copy home"
tput sgr0
echo

cp -rf $installed_dir/home/oh* /home/

echo
tput setaf 6
echo "|» Done"
tput sgr0
echo

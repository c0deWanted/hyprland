#!/bin/bash
#set -e

installed_dir=$(dirname $(readlink -f $(basename `pwd`)))

echo
tput setaf 6
echo "----------------------------------------------------"
echo "Copy configuration files"
echo "----------------------------------------------------"
tput sgr0
echo

# Copy doom config and sync
cp -rf $installed_dir/settings/.doom.d* $HOME/

echo
tput setaf 6
echo "----------------------------------------------------"
echo "     Done"
echo "----------------------------------------------------"
tput sgr0
echo

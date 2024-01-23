#!/bin/bash

ver="1.2"
pacmcfg=/etc/pacman.conf

echo "Enter the current username: \n"
read usrnm
bshcfg= "/home/$usrnm/.bashrc"

#CHAOTIC AUR

echo "Setting up pacman mirror keys for  Chaotic AUR repositories"
if grep "chaotic-aur" $pacmcfg
then
    echo "Chaotic AUR keys are already in your pacman config file. It might be already setup."
else
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "Pacman keys done set."

echo "Appending mirror list in pacman config."
sudo echo "[chaotic-aur]" >> $pacmcfg
sudo echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> $pacmcfg
echo "Appended!"
fi

echo "Running checks"
if grep "chaotic-aur" $pacmcfg
then
    echo "All good. Carrying on."
else
    echo "Something went wrong."
fi

echo "Updating System. \n"
sudo pacman -Syu

#Can add code to install preconfigured software install profile from here





# to here


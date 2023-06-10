#!/bin/bash

ver="1.0"
pacconf=/etc/pacman.conf
echo "Enter your username for this PC below"
read usernm
bpt=/home/$usernm/.bashrc



echo "Setting up pacman keys for Chaotic AUR"
if grep "chaotic-aur" $pacconf
then
echo "Chaotic AUR is already in your pacman config, which signifies that it should be available for use"
else
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "Setting pacman keys done"

echo "Now appending chaotic-aur lines to pacman configuration file"
sudo echo "[chaotic-aur]" >> $pacconf
sudo echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> $pacconf
fi

if grep "chaotic-aur" $pacconf
then
echo " Chaotic AUR has been succesfully installed."
echo "Now lets update the system"
sudo pacman -Syu
fi

echo "Installing the specified packages"
sudo pacman -Syu htop vivaldi-snapshot octopi kate gimp onlyoffice-bin fish neofetch brave-nightly-bin qbittorrent ventoy-bin grub-customizer freedownloadmanager discord-canary obs-studio vlc qdirstat

#Now to add a directory to the PATH variable thats accessible without sudo and is in the home directory
cd
mkdir -p sysconfig/bshcrs

sudo echo "Now adding a home directory to PATH for better management of scripts"
sudo echo "PATH="'$PATH:'"/home/$usernm/sysconfigs/bshcrs"  >> $bpt
if grep "sysconfigs" $bpt
then
echo "The /sysconfigs/bshcrs directory in the /home/user directory has been added to PATH."
echo "Now all the scripts/programs that you store there will execute straight away!"
else
echo "Some error occured while trying to setup /bshcrs as PATH"
fi


echo "Changing the login shell to the fish shell"
sudo chsh -s /bin/fish
/bin/fish
set -U fish_greeting "🐟sh ⮷"


echo "Setup completed. Enjoy."

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

#Software installation profiles (premade)
echo "Do you wish to install any of the specified app profiles?"
echo "1. KP's Desktop Linux software profile"
echo "2. VM or Dev software profile"
echo "3. Stable Desktop for avg user"
echo "4. Continue without installing any applications"
echo "Enter your selected profile's responding number"
read softpro

case $softpro in
1)  sudo pacman -Syu htop vivaldi-snapshot octopi kate gimp onlyoffice-bin fish neofetch brave-nightly-bin qbittorrent ventoy-bin grub-customizer freedownloadmanager discord-canary obs-studio vlc qdirstat ;;
2)  sudo pacman -Syu htop kate fish neofetch ;;
3) sudo pacman -Syu brave-bin onlyoffice-bin vlc okular ;;
4)  echo "Continuing without installing any softwares." ;;
esac

# Custom packages install
echo "Do you wish to install any other packages? y or n?"
read pacinst

if [[ $pacinst == "y" || $pacinst == "Y" ]]; then
    echo "Name all the packages you wanna install with spaces in between"
    read packs
    sudo pacman -Syu $packs
elif [[ $pacinst == "n" || $pacinst == "N" ]]; then
    echo "OK. Continuing the script."
else
    echo "Invalid choice. Continuing the script."
fi


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

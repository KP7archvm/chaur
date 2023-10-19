#!/bin/bash

ver="1.1"
pacmcfg=/etc/pacman.conf

echo "Enter the current username for this PC below:- \n"
read usrnm
bshcfg= "/home/$usrnm/.bashrc"

#CHAOTIC AUR

echo "Setting up pacman mirror keys for Chaotic AUR reps"
if grep "chaotic-aur" $pacmcfg
then
    echo "Chaotic AUR keys are already in your pacman config file. It might be already setup."
else
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    echo "Pacman keys done set!"

    echo "Appending chaotic mirror list in the pacman config."
sudo echo "[chaotic-aur]" >> $pacmcfg
sudo echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> $pacmcfg
    echo "Appended!"
fi

echo "Running checks "
if grep "chaotic-aur" $pacmcfg
then
    echo "Chaotic AUR has been succesfully installed"
else
    echo "Something went wrong with the Chaotic AUR installation"
fi

echo"Updating the System"
sudo pacman -Syu

# Installing software
#! --- AUTOMATE LATER

echo "Do you wanna install the predefined software profile? \n"
read ynsft

if [[ $ynsft = "y" || $ynsft = "Y" ]]; then
    sudo pacman -Syu htop octopi kate fish neofetch qdirstat
else
    echo "Continuing without installing any software."
fi

#! --- AUTOMATE LATER

# Add a PATH linked folder in the home directory

echo "Adding a folder called x7utls in the home directory of your user to store all the script files"
mkdir /home/$usrnm/x7utls
echo "Done"
echo "Adding a folder called bshscripts in x7utls to store custom scripts for better straight up execution"
mkdir /home/$usrnm/x7utls/bshscripts

sudo echo "PATH"'$PATH:'"/home/$usrnm/x7utls/bshscripts" >> $bshcfg
if grep "x7utls" $bshcfg
then
    echo "PATH folder added to /home/$usrnm/xfutls/bshscripts."
else
    echo "Some error occured while setting up the PATH folder in home dir"
fi

# Change default shell to fish shell

echo "Changing the default shell to the fish shell"
sudo chsh -s /bin/fish
/bin/fish
set -U fish_greeting "🐟sh ⮷"

# # echo "Setup Completed!"









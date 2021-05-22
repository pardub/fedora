#!/bin/bash

### RUN THE SCRIPT AS SUDO

# wget -O - https://raw.githubusercontent.com/pardub/fedora/main/install.sh | sudo bash -x

### Set up Fedora

sudo adduser marc
sudo mkdir -p git/git_clone
sudo hostnamectl set-hostname fedora
sudo dnf update -y
sudo dnf -y install timeshift
sudo dnf -y install vim
#sudo dnf -y install visudo
sudo dnf -y install git
sudo dnf -y install gparted
sudo dnf -y install util-linux-user
sudo dnf -y install zsh
sudo dnf -y install chromium
sudo dnf -y groupinstall "Development Tools"
sudo dnf -y install gnome-tweaks
## OK
## INSTALL visudo
echo 'marc ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
echo 'Defaults:marc timestamp_timeout=60' | sudo EDITOR='tee -a' visudo

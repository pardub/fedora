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
## OK

### set up minimize/maximize  window
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
### activate shortcuts to minimize all windows

### ADD EXTRA REPOS rpm fusion
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
## OK

### ADD GOOGLE DNS 
echo 'nameserver=8.8.8.8' | sudo tee -a /etc/hosts

### CHANGE HOSTNAME
sudo hostnamectl set-hostname fedora

### DISABLE SELINUX
sudo sed -i 's/enforcing/disabled/' /etc/selinux/config

### Download visual studio code

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y check-update
sudo dnf -y  install code

### download .vimrc 
curl -LJO https://raw.githubusercontent.com/pardub/fedora/main/.vimrc

### Download vim plugin
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \\n    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


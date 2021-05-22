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
sudo dnf -y install autoconf 
sudo dnf -y install automake
## OK

## Setup Visudo
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

### Download Visual Studio Code

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y check-update
sudo dnf -y  install code

### download .vimrc 
curl -LJO https://raw.githubusercontent.com/pardub/fedora/main/.vimrc

### Download vim plugin
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

### DOWNLOAD MESLO FONT
## TEST IF MESLO FONT IS ALREADY DOWNLOADED OR NOT
sudo mkdir -p $HOME/.local/share/fonts/MesloGS
cd $HOME/.local/share/fonts/MesloGS

if [ ! -e "$HOME/.local/share/fonts/MesloGS/MesloLGS NF Regular.ttf" ]
then
    cd  ~/.local/share/fonts/MesloGS | exit
    sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
fi 
###
if [ ! -e "$HOME/.local/share/fonts/MesloGS/MesloLGS NF Bold.ttf" ]
then
    cd  ~/.local/share/fonts/MesloGS | exit
    sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
fi
###
if [ ! -e "$HOME/.local/share/fonts/MesloGS/MesloLGS NF Italic.ttf" ]
then
    cd  ~/.local/share/fonts/MesloGS | exit
    sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
fi
####
if [ ! -e "$HOME/.local/share/fonts/MesloGS/MesloLGS NF Bold Italic.ttf" ]
then
    cd  ~/.local/share/fonts/MesloGS | exit
    sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fi

#fc-cache -v

##### SET UP GNOME TERMINAL
# https://ncona.com/2019/11/configuring-gnome-terminal-programmatically/
# We will need this value later, so let’s save it in a variable:
GNOME_TERMINAL_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}')


gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ font 'Monospace 10'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ audible-bell false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ background-color '#000000'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ foreground-color '#AFAFAF'

### You can list all the properties that can be configured:
# gsettings list-keys org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/

### If you want to see the current value for a setting you can use:
# gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ foreground-color

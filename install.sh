#!/bin/bash

### RUN THE SCRIPT AS SUDO

# wget -O - https://raw.githubusercontent.com/pardub/fedora/main/install.sh | sudo bash -x

### Set up Fedora

sudo useradd marc
mkdir -p git/git_clone
sudo hostnamectl set-hostname fedora
sudo dnf update -y
sudo dnf -y install timeshift
sudo dnf -y install vim
sudo dnf -y install visudo
sudo dnf -y install git
sudo dnf -y install gparted
sudo dnf -y install util-linux-user
sudo dnf -y install zsh
sudo dnf -y install Chromium
sudo dnf -y install groupinstall "Development Tools"
sudo dnf -y install gnome-tweak

### set up minimize/maximize  window

gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
### activate shortcuts to minimize all windows


### FIREFOX ADD ON
#Firefox Multi-Account Containers
#Ublock Origin
#https://addons.mozilla.org/firefox/downloads/file/3768975/ublock_origin-1.35.2-an+fx.xpi
#Keepa
#OneNote Web Clipper
#Decentraleyes 
#Onetab
#Wallabag
#Gmail
#Polar


### ADD EXTRA REPOS rpm fusion
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

### ADD GOOGLE DNS 
echo "nameserver=8.8.8.8" >> /etc/hosts

### CHANGE HOSTNAME
hostnamectl set-hostname fedora

### DISABLE SELINUX
sed -i 's/enforcing/disabled/' /etc/selinux/config

### download .vimrc 
curl -LJO https://raw.githubusercontent.com/pardub/fedora/main/.vimrc

### Download vim plugin
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \\n    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

### Download visual studio code

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y check-update
sudo dnf -y  install code






### DOWNLOAD POWERLINE10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

### INSTALL docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

## INSTALL visudo
echo 'marc ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
echo 'Defaults:marc timestamp_timeout=60' | sudo EDITOR='tee -a' visudo

## Firewalld

## zsh default shell
sudo chsh -s $(which zsh) marc

### DOWNLOAD .zshrc
rm /home/marc/.zshrc
curl -LJO https://raw.githubusercontent.com/pardub/fedora/main/.zshrc
## reboot


### p10k configure
git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

### DOWNLOAD MENLO FONTS

### TEST IF FONT IS AREALDY DOWNLOADED OR NOT

if [ ! -e "$HOME/.local/share/fonts/MesloLGS NF Regular.ttf" ]
then
    cd ~/.local/share/fonts || exit
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
fi 
###
if [ ! -e "$HOME/.local/share/fonts/MesloLGS NF Bold.ttf" ]
then
    cd ~/.local/share/fonts || exit
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
fi
###
if [ ! -e "$HOME/.local/share/fonts/MesloLGS NF Italic.ttf" ]
then
    cd ~/.local/share/fonts || exit
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
fi
####
if [ ! -e "$HOME/.local/share/fonts/MesloLGS NF Bold Italic.ttf" ]
then
    cd ~/.local/share/fonts || exit
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fi

fc-cache -v

###  Configure your terminal to use this font

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

gsettings list-keys org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/

gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ foreground-color


## Docker Compose

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose


################# DOCKER INSTALL ###################
## https://docs.docker.com/engine/install/fedora/#install-using-the-repository

## Uninstall old versions
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine -y


## SET UP THE REPOSITORY

sudo dnf -y install dnf-plugins-core -y
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

## INSTALL DOCKER ENGINE
sudo dnf install docker-ce docker-ce-cli containerd.io -y
sudo systemctl start docker
sudo systemctl enable docker

## Manage Docker as a non-root user
groupadd docker
usermod -aG docker "$USER"

## REBOOT

## TEST WITHOUT SUDO
docker run hello-world

#### INSTALL JETBRAINS MONO FONTS IN ~/.local/share/fonts
#### SET UP VS CODE TO USE NEW FONTS


### TWEAKING SYSTEM FONTS
#Make Ubuntu 20.04 Look Like MacOS [You Won't Believe the End Result]





### FIREWALL SET UP OPEN/CLOSED PORTS




### VS CODE INSTALL EXTENSIONS
code --install-extension ginfuru.ginfuru-better-solarized-dark-theme
code --install-extension ms-azuretools.vscode-docker	
code --install-extension dbaeumer.vscode-eslint
code --install-extension redhat.vscode-yaml
code --install-extension 
code --install-extension 

reboot


#!/bin/bash -xev

### RUN THE SCRIPT AS SUDO
# wget -O - https://raw.githubusercontent.com/pardub/fedora/main/install.sh | sudo bash -x
sudo dnf -y update

### ADD EXTRA REPOS rpm fusion
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo adduser marc
sudo mkdir -p git/git_clone
sudo hostnamectl set-hostname fedora

sudo dnf -y install timeshift
sudo dnf -y install vim
# sudo dnf -y install visudo
sudo dnf -y install vim-default-editor
sudo dnf -y install gparted
sudo dnf -y install util-linux-user
sudo dnf -y install zsh
sudo dnf -y install chromium
sudo dnf -y groupinstall "Development Tools"
sudo dnf -y install gnome-tweaks
sudo dnf -y install autoconf 
sudo dnf -y install automake
sudo dnf -y install ansible
sudo dnf -y install borgbackup
sudo dnf -y install borgmatic
# sudo dnf -y install clamav
# sudo dnf -y clamav-unofficial-sigs
sudo dnf -y install redshift # Redshift adjusts the color temperature of the screen
### install opensnitch

# SETUP BORGMATIC
# sudo generate-borgmatic-config

# Download Vorta backup
sudo dnf -y copr enable luminoso/vorta
sudo dnf -y install vorta

# Download Jami Voip client
# First, we need to check which Fedora version is installed before downloading Jami.
# Awk can be used also to retrieve the VERSION_ID
# awk -F= '$1=="VERSION_ID" { print $2 ;}' /etc/os-release

. /etc/os-release
if [ "$VERSION_ID" -eq "33"]
then
sudo -y dnf config-manager --add-repo https://dl.jami.net/nightly/fedora_33/jami-nightly.repo && sudo-y  dnf install jami
fi
if [ "$VERSION_ID" -eq "34"]
then
sudo -y dnf config-manager --add-repo https://dl.jami.net/nightly/fedora_34/jami-nightly.repo && sudo -y dnf install jami
fi

cd

## Setup Visudo
echo 'marc ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
echo 'Defaults:marc timestamp_timeout=60' | sudo EDITOR='tee -a' visudo

### set up minimize/maximize  window
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
### activate shortcuts to minimize all windows


###  ADD FLATPAK REPO
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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

fc-cache -f -v

##### SET UP GNOME TERMINAL
# https://ncona.com/2019/11/configuring-gnome-terminal-programmatically/
# We will need this value later, so let’s save it in a variable:
GNOME_TERMINAL_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}')


#gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ font 'Monospace 10'
#gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ font 'MesloLGS NF 10'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ font 'JetBrainsMono NF'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ audible-bell false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ background-color '#000000'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ foreground-color '#AFAFAF'

### You can list all the properties that can be configured:
# gsettings list-keys org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/

### If you want to see the current value for a setting you can use:
# gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:"$GNOME_TERMINAL_PROFILE"/ foreground-color

# Disable updates and upgrades in GNOME Software
gsettings set org.gnome.software allow-updates false

# Disable automatically download and install updates
gsettings set org.gnome.software download-updates false

# Disable notifications about software updated in the background
gsettings set  org.gnome.software download-updates-notify false

# Disable check of the very first run of GNOME Software
gsettings set org.gnome.software first-run false




### FIREFOX ADD ON
# Firefox Multi-Account Containers
# Ublock Origin
# https://addons.mozilla.org/firefox/downloads/file/3768975/ublock_origin-1.35.2-an+fx.xpi
# Keepa
# OneNote Web Clipper
# Decentraleyes 
# Onetab
# Wallabag
# Gmail
# Polar
# Bitwarden 

#### Disable Firewalld ####
#### Setup iptables   #####

################# DOCKER INSTALL ###################
## https://docs.docker.com/engine/install/fedora/#install-using-the-repository

## Uninstall old versions
sudo dnf -y remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine


## SET UP THE REPOSITORY

sudo dnf -y install dnf-plugins-core -y
sudo dnf -y config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

## INSTALL DOCKER ENGINE
#sudo dnf -y install docker-ce docker-ce-cli containerd.io
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker

## Manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker "$USER"

### Docker Compose
#sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-darwin-x86_64" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

### CHECK DOCKER COMPOSE VERSION
docker-compose --version

### REBOOT
#reboot

## TEST WITHOUT SUDO
docker run hello-world


##################### TO COMPLETE ################
### INSTALL DOCKER
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh


#### INSTALL JETBRAINS MONO FONTS IN ~/.local/share/fonts

#### SET UP VS CODE TO USE NEW FONTS

### TWEAKING SYSTEM FONTS
# Make Ubuntu 20.04 Look Like MacOS [You Won't Believe the End Result]

### VS CODE INSTALL EXTENSIONS
code --install-extension ginfuru.ginfuru-better-solarized-dark-theme
code --install-extension ms-azuretools.vscode-docker	
code --install-extension dbaeumer.vscode-eslint
code --install-extension redhat.vscode-yaml
code --install-extension 
code --install-extension 

### DOWNLOAD .zshrc
rm /home/marc/.zshrc
curl -LJO https://raw.githubusercontent.com/pardub/fedora/main/.zshrc

## zsh default shell
#### sudo chsh -s $(which zsh) marc
sudo chsh -s /bin/zsh marc

logout

### DOWNLOAD POWERLINE10K
### git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
### echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

### ZSH AUTOSUGGESTIONS CONFIG
mkdir - p ~/.zsh/zsh-autosuggestions
cd ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ' >> ~/.zshrc

### ZSH SYNTAX HIGHLIGHTING
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### FZF FUZZY FINDER
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zsh/fzf
cd ~/.zsh/.fzf
./install
source ~/.zshrc
cd

reboot

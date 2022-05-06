#!/bin/bash -xev

### ADD EXTRA REPOS rpm fusion
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

### Fastest mirror and Delta RPM
echo 'fastestmirror=True'             | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=True'                  | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10'      | sudo tee -a /etc/dnf/dnf.conf
sudo dnf clean all

### DISABLING SSH
sudo systemctl stop sshd
sudo systemctl disable sshd

### Add tool to change Mac Address before reboot
###  ADD FLATPAK REPO
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

### Manage Flatpak permissions
sudo flatpak install flathub com.github.tchx84.Flatseal


## INSTALL SOFTWARES

### web console for Linux servers
sudo dnf -y install cockpit

### Backup system
sudo dnf -y install timeshift
sudo dnf -y install vim
# sudo dnf -y install visudo
sudo dnf -y install --allowerasing vim-default-editor
sudo dnf -y install gparted
sudo dnf -y install util-linux-user
sudo dnf -y install zsh
sudo dnf -y install chromium-browser-privacy
sudo dnf -y groupinstall "Development Tools"
sudo dnf -y install gnome-tweaks
sudo dnf -y install gnome-extensions-app
sudo dnf -y install autoconf 
sudo dnf -y install automake
sudo dnf -y install ansible
sudo dnf -y install borgbackup
sudo dnf -y install borgmatic
sudo dnf -y install okular
sudo dnf -y install tldr
sudo dnf -y install weechat
sudo dnf -y install filezilla
sudo dnf -y install wireguard-tools
sudo dnf -y install bat
sudo dnf -y install exa
sudo dnf -y install fzf
sudo dnf -y install youtube-dl
sudo dnf -y install git

### Text Calendar
sudo dnf -y install calcurse
sudo dnf -y install rclone
sudo dnf -y install rclone-browser
sudo dnf -y install audacity-3.0.2
sudo dnf -y install dropbox
sudo dnf -y install chrome-remote-desktop
sudo dnf -y install fuse
sudo dnf -y install power-profiles-daemon
sudo dnf -y install pdfarranger
sudo dnf -y install bookworm
sudo dnf -y install anki
sudo dnf -y install tor
sudo dnf -y install torbrowser-launcher

### Checksum verification tool
sudo dnf -y install gtkhash

sudo dnf -y install kleopatra
sudo dnf -y install ffmpeg
sudo dnf -y install gpgme
# sudo dnf -y install claws-mail
sudo dnf -y install evolution
sudo dnf -y install lynis ### audit

### For streaming with clone
sudo dnf -y install mpv 

### save workspaces after reboot
sudo dnf -y install dconf-editor

### change MAC addres
sudo dnf -y install macchanger 

### Etesync
sudo dnf copr enable daftaupe/etesync-rs   ## Etesync repo
sudo dnf -y install evolution-etesync

### Password Manager
sudo dnf -y install pass

## Gui for Pass
sudo dnf -y install qtpass

mkdir ~/git
cd ~/git
### OPENSNITCH
wget https://github.com/evilsocket/opensnitch/releases/download/v1.5.0/opensnitch-1.5.0-1.x86_64.rpm
wget https://github.com/evilsocket/opensnitch/releases/download/v1.5.0/opensnitch-ui-1.5.0-1.noarch.f29.rpm
sudo dnf -y localinstall opensnitch-1*.rpm; sudo dnf -y localinstall opensnitch-ui*.rpm
sudo systemctl enable --now opensnitch
sudo systemctl start opensnitch
cd

### UNINSTALL
sudo dnf -y remove totem

### SERVICES ACTIVATION
sudo systemctl start cockpit
sudo firewall-cmd --add-service=cockpit --permanent
sudo firewall-cmd --reload

### FIREFOX HARDWARE ACCELERATION
# https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration

### CODECS
sudo dnf -y install x264
sudo dnf -y groupupdate Multimedia
sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf -y install lame\* --exclude=lame-devel
sudo dnf -y group upgrade --with-optional Multimedia

### WINDSCRIBE
echo 'exclude=windscribe-cli-1.4' | sudo tee -a /etc/dnf/dnf.conf ### prevent windscribe update to version 1.4 that is currently not working
sudo wget https://repo.windscribe.com/fedora/windscribe.repo -O /etc/yum.repos.d/windscribe.repo
sudo dnf update -y
sudo dnf -y install windscribe-cli-1.3

### VIRTUALIZATION
sudo dnf -y install @virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
## To verify that the KVM kernel modules are properly loaded, enter:
# lsmod | grep kvm

## VIRTIO WIN DRIVERS
### sudo wget https://fedorapeople.org/groups/virt/virtio-win/virtio-win.repo \
### -O /etc/yum.repos.d/virtio-win.repo

### Antivirus
# sudo dnf -y install clamav
# sudo dnf -y clamav-unofficial-sigs
sudo dnf -y install redshift # Redshift adjusts the color temperature of the screen

### Download vim plugin
cd
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## SETUP BORGMATIC
# sudo generate-borgmatic-config

## Download Vorta backup
sudo dnf -y copr enable luminoso/vorta
sudo dnf -y install vorta

## Download Jami Voip client
sudo dnf -y config-manager --add-repo https://dl.jami.net/nightly/fedora_34/jami-nightly.repo
sudo dnf -y install jami

## Setup Visudo
echo 'marc ALL=(ALL:ALL) ALL' | sudo EDITOR='tee -a' visudo
echo 'Defaults:marc timestamp_timeout=60' | sudo EDITOR='tee -a' visudo

### ADD https://dns.watch/
echo 'nameserver='84.200.69.80' | sudo tee -a /etc/hosts
echo 'nameserver='84.200.70.40' | sudo tee -a /etc/hosts

### CHANGE HOSTNAME
sudo hostnamectl set-hostname fedora

### SETUP PERMISSIVE  SELINUX
#sudo sed -i 's/enforcing/permissive/' /etc/selinux/config

### set up minimize/maximize  window
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

### Download Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y check-update && sudo dnf -y  install code

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
###

fc-cache -v

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

#### Firewalld Setup ####

#### INSTALL JETBRAINS MONO FONTS IN ~/.local/share/fonts

#cd /tmp
#sudo wget https://download.jetbrains.com/fonts/JetBrainsMono-2.225.zip
##### sudo unzip /tmp/JetBrainsMono-2.225.zip -d ~/.local/share/fonts
#sudo unzip /tmp/JetBrainsMono-2.225.zip -d ~/.local/share/fonts/JetBrainsMono
#fc-cache -v

mkdir -p ~/.local/share/fonts/nerd-fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -v


### RECOMMENDED SETTINGS FOR THE FONT
### Size: 13
### Line spacing: 1.2


#### SET UP VS CODE TO USE NEW FONTS

### TWEAKING SYSTEM FONTS
# Make Ubuntu 20.04 Look Like MacOS [You Won't Believe the End Result]

### FIREWALL SET UP OPEN/CLOSED PORTS

### VS CODE INSTALL EXTENSIONS
code --install-extension ginfuru.ginfuru-better-solarized-dark-theme
code --install-extension ms-azuretools.vscode-docker	
code --install-extension dbaeumer.vscode-eslint
code --install-extension redhat.vscode-yaml

### download .vimrc 
curl -LJO https://raw.githubusercontent.com/pardub/fedora/main/.vimrc

### Add Gnome extensions
## https://github.com/JoseExposito/touche ## configure your touchpad and touchscreen multi-touch gestures
## Auto Activities

### WIREGUARD CONFIG
echo '[keyfile]\nunmanaged-devices=type:wireguard' /etc/NetworkManager/conf.d/unmanaged.conf
#https://wiki.archlinux.org/title/WireGuard#Routes_are_periodically_reset
# This allows the Wireguard connection to be up and running automatically after reboot when it has been set up with nmcli.

### Claws mail config timezone
sed -i 's/hide_timezone=0/hide_timezone=1/' ~/.claws-mail/clawsrc

### FZF FUZZY FINDER
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.zsh/fzf
cd ~/.zsh/.fzf
./install
source ~/.zshrc
cd

### ZSH AUTOSUGGESTIONS CONFIG
cd ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ' >> ~/.zshrc

### ZSH SYNTAX HIGHLIGHTING
cd ~/.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### ZSH-ABBR
cd ~/.zsh
git clone https://github.com/olets/zsh-abbr
echo 'source ~.zsh/zsh-abbr/zsh-abbr.zsh' >> ~/.zshrc'





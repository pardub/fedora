#!/bin/bash -xev

## ADD USER
#sudo adduser marc

sudo dnf -y install util-linux-user

## UPDATE AND ZSH INSTALL
sudo dnf -y update
sudo dnf -y install zsh

## zsh default shell
# sudo chsh -s /bin/zsh marc ## replaced by the command below
sudo chsh -s $(which zsh) $USER
if [ -e /home/marc/.zshrc ]
then rm /home/marc/.zshrc
fi

## DOWNLOAD .zshrc
curl -LJO https://raw.githubusercontent.com/pardub/fedora/main/.zshrc

### REBOOT

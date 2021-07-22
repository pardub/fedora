#!/bin/bash -xev
sudo dnf -y install zsh
sudo dnf -y update
sudo dnf -y install zsh

## zsh default shell
sudo chsh -s /bin/zsh marc
if [ -e /home/marc/.zshrc ]
then rm /home/marc/.zshrc
fi

## DOWNLOAD .zshrc
curl -LJO https://raw.githubusercontent.com/pardub/fedora/main/.zshrc

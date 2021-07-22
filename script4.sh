#!/bin/bash -xev

## TEST WITHOUT SUDO
docker run hello-world

### DOWNLOAD POWERLINE10K
cd git/git_clone
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

### REBOOT

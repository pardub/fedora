#!/bin/bash -xev






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
sudo dnf -y config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

## INSTALL DOCKER ENGINE
sudo dnf -y install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker

## Manage Docker as a non-root user
sudo groupadd docker
sudo usermod -aG docker "$USER"

### Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

### CHECK DOCKER COMPOSE VERSION
docker-compose --version


### REBOOT
#reboot

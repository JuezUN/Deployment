#!/bin/bash

sudo yum check-update

curl -fsSL https://get.docker.com/ | sh

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $(whoami)

# docker-compose installation
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

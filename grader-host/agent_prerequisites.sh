#!/bin/bash

#Installs the software needed to run an inginious grading agent

chmod +x ../deployment_scripts/*.sh
bash ../deployment_scripts/install_basic_dependencies.sh
bash ../deployment_scripts/update_server.sh

# Create agent user and group
sudo useradd agent

echo "Provide a password for the agent user"

sudo passwd agent
sudo groupadd agent
sudo usermod -aG agent agent
sudo usermod -aG docker agent

sudo usermod -aG agent $(whoami)

echo -e "\n\n$(tput setaf 3)Please logout and back in to finish the Docker installation $(tput sgr0)"

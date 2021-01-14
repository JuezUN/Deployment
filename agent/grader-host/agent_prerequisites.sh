#!/bin/bash

#Installs the software needed to run an inginious grading agent

chmod +x $DEPLOYMENT_HOME/deployment_scripts/*.sh
bash $DEPLOYMENT_HOME/deployment_scripts/install_basic_dependencies.sh
bash $DEPLOYMENT_HOME/deployment_scripts/install_nfs.sh

echo -e "\n\n$(tput setaf 3)Please logout and back in to finish the Docker installation $(tput sgr0)"

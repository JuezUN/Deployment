#!/bin/bash

#this script installs the prerequisites needed to run the Judge

#install INGInious dependencies
chmod +x deployment_scripts/*.sh
bash deployment_scripts/install_basic_dependencies.sh
sudo bash deployment_scripts/install_mongodb.sh
bash deployment_scripts/install_node.sh

echo "installing apache with mod_wsgi"
sudo bash deployment_scripts/install_apache.sh

echo -e "\n\n$(tput setaf 3)Please logout and back in to finish the Docker installation $(tput sgr0)"

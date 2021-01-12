#!/bin/bash

# This script installs the prerequisites needed to run the Judge

# Install UNCode dependencies
chmod +x $DEPLOYMENT_HOME/*.sh
chmod +x $DEPLOYMENT_HOME/deployment_scripts/*.sh
chmod +x $DEPLOYMENT_HOME/tools_host/*.sh

bash $DEPLOYMENT_HOME/deployment_scripts/install_basic_dependencies.sh
sudo bash $DEPLOYMENT_HOME/deployment_scripts/install_mongodb.sh
bash $DEPLOYMENT_HOME/deployment_scripts/install_node.sh
sudo bash $DEPLOYMENT_HOME/install_uncode_scripts.sh

echo "installing nginx + lighttpd with fastcgi"
bash $DEPLOYMENT_HOME/deployment_scripts/install_nginx.sh
bash $DEPLOYMENT_HOME/deployment_scripts/install_lighttpd.sh

echo -e "\n\n$(tput setaf 3)Please logout and back in to finish the Docker installation $(tput sgr0)"

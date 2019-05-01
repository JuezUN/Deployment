#!/bin/bash

#this script installs the prerequisites needed for linter and python tutor tools.

#install tools dependencies
chmod +x *.sh
chmod +x ../deployment_scripts/*.sh
bash ../deployment_scripts/install_basic_dependencies.sh
bash ../deployment_scripts/install_node.sh
sudo bash ../install_uncode_scripts.sh

echo "installing nginx"
bash ../deployment_scripts/install_nginx.sh

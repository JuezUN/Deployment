#!/bin/bash

# This script installs the prerequisites needed for linter and python tutor tools.

# Install tools dependencies
chmod +x $DEPLOYMENT_HOME/*.sh
chmod +x $DEPLOYMENT_HOME/deployment_scripts/*.sh
bash "$DEPLOYMENT_HOME/deployment_scripts/install_basic_dependencies.sh"
bash "$DEPLOYMENT_HOME/deployment_scripts/install_node.sh"

# Install the UNCode scripts related to the tools
chmod +x $DEPLOYMENT_HOME/uncode_scripts/uncode*
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_tools_restart" /usr/bin
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_linter_restart" /usr/bin
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_tutor_restart" /usr/bin
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_update_tools" /usr/bin
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_process_after_reboot" /usr/bin

echo "Installing Nginx for tools server"
bash "$DEPLOYMENT_HOME/deployment_scripts/install_nginx.sh"

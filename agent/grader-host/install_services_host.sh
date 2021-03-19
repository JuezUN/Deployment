#!/bin/bash

# Installs the docker_agent and mcq_agent services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

bash "$DEPLOYMENT_HOME/deployment_scripts/update_server.sh"
sudo "$DEPLOYMENT_HOME/deployment_scripts/build_all_containers.sh"

sudo "$DEPLOYMENT_HOME/deployment_scripts/deploy_nfs_client.sh"

sudo bash "$DEPLOYMENT_HOME/agent/deploy_agent_services.sh"

sudo chown agent:agent /var/www/INGInious

sudo systemctl start docker_agent && sudo systemctl start mcq_agent

# Install the UNCode scripts related to the agent
chmod +x $DEPLOYMENT_HOME/uncode_scripts/uncode*
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_agent_restart" /usr/bin

sudo sed -i 's/uncode_webapp_restart/uncode_agent_restart/g' "$DEPLOYMENT_HOME/uncode_scripts/uncode_update_server";
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_update_server" /usr/bin
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_process_after_reboot" /usr/bin
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_update_containers" /usr/bin
sudo cp "$DEPLOYMENT_HOME/uncode_scripts/uncode_config_files_backup" /usr/bin

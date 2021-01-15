#!/bin/bash

# Installs the services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

bash $DEPLOYMENT_HOME/deployment_scripts/update_server.sh
sudo $DEPLOYMENT_HOME/deployment_scripts/build_all_containers.sh

sudo $DEPLOYMENT_HOME/deployment_scripts/deploy_nfs_client.sh

sudo bash $DEPLOYMENT_HOME/agent/deploy_agent_services.sh

sudo chown agent:agent /var/www/INGInious

sudo systemctl start docker_agent && sudo systemctl start mcq_agent
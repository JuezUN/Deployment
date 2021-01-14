#!/bin/bash

# Installs the services as systemd services

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

sudo bash $DEPLOYMENT_HOME/agent/deploy_agent_services.sh

sudo chown agent:agent /var/www/INGInious

sudo systemctl start docker_agent && sudo systemctl start mcq_agent
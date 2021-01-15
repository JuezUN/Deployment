#!/bin/bash

echo "Deploying UNCode and the corresponding services to the main server"

sudo chmod +x $DEPLOYMENT_HOME/deployment_scripts/*
sudo chmod +x $DEPLOYMENT_HOME/backend/*
sudo chmod +x $DEPLOYMENT_HOME/agent/*

bash $DEPLOYMENT_HOME/deployment_scripts/update_server.sh
bash $DEPLOYMENT_HOME/deployment_scripts/setup_problem_bank.sh

sudo $DEPLOYMENT_HOME/deployment_scripts/build_all_containers.sh

sudo $DEPLOYMENT_HOME/backend/install_backend_service.sh

sudo bash $DEPLOYMENT_HOME/agent/deploy_agent_services.sh
sudo systemctl start docker_agent && sudo systemctl start mcq_agent

sudo bash $DEPLOYMENT_HOME/deployment_scripts/deploy_nginx_server.sh
sudo bash $DEPLOYMENT_HOME/deployment_scripts/deploy_lighttpd_server.sh

#!/bin/bash

sudo chmod +x $DEPLOYMENT_HOME/deployment_scripts/*
bash $DEPLOYMENT_HOME/deployment_scripts/update_server.sh
bash $DEPLOYMENT_HOME/deployment_scripts/setup_problem_bank.sh

sudo bash $DEPLOYMENT_HOME/deployment_scripts/build_all_containers.sh

sudo bash $DEPLOYMENT_HOME/backend/install_backend_service.sh
sudo systemctl start backend.service

sudo bash $DEPLOYMENT_HOME/deployment_scripts/deploy_nginx_server.sh
sudo bash $DEPLOYMENT_HOME/deployment_scripts/deploy_lighttpd_server.sh

sudo bash $DEPLOYMENT_HOME/agent/deploy_agent_services.sh
sudo systemctl start docker_agent && sudo systemctl start mcq_agent

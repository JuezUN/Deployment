#!/bin/bash

source init.sh
source helper_functions.sh
sudo chmod +x deployment_scripts/*
sudo bash deployment_scripts/check_prerequisites.sh
sudo bash deployment_scripts/configure_proxy.sh
docker-compose up -d
sudo bash deployment_scripts/setup_lighttpd.sh
bash deployment_scripts/build_all_containers.sh
sudo bash deployment_scripts/restrict_ports.sh
bash deployment_scripts/update_server.sh
startServer
enableServer
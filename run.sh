#!/bin/bash

sudo chmod +x deployment_scripts/*
docker-compose up -d
bash deployment_scripts/update_server.sh
bash deployment_scripts/setup_problem_bank.sh

if [ "$1" == "--distributed" ]
then
    #Start backend service
    sudo systemctl start backend.service
else
    #Build LOCAL grading containers
    sudo bash deployment_scripts/build_all_containers.sh
fi

sudo bash deployment_scripts/deploy_nginx_server.sh
sudo bash deployment_scripts/deploy_lighttpd_server.sh
sudo bash deployment_scripts/deploy_cokapi_service.sh

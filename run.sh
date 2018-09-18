#!/bin/bash

if [ "$1" != "--distributed" ]
then
    #Build local grading containers
    sudo bash deployment_scripts/build_all_containers.sh
fi

sudo chmod +x deployment_scripts/*
docker-compose up -d
bash deployment_scripts/update_server.sh
bash deployment_scripts/setup_problem_bank.sh

sudo bash deployment_scripts/deploy_apache_server.sh

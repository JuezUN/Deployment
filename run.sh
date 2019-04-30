#!/bin/bash

sudo chmod +x deployment_scripts/*
bash deployment_scripts/update_server.sh
bash deployment_scripts/setup_problem_bank.sh

DISTRIBUTED=0
TOOLS_DISTRIBUTED=0

for arg in "$@"
do
    case $arg in
        --distributed)
        DISTRIBUTED=1
        shift
        ;;
        --distributed-tools)
        TOOLS_DISTRIBUTED=1
        shift
        ;;
        *)
        shift # Remove generic argument from processing
        ;;
    esac
done

if [ "$TOOLS_DISTRIBUTED" -eq "0" ]
then
    docker-compose up -d
    sudo bash deployment_scripts/deploy_cokapi_service.sh
fi

if [ "$DISTRIBUTED" -eq "1" ]
then
    #Start backend service
    sudo systemctl start backend.service
else
    #Build LOCAL grading containers
    sudo bash deployment_scripts/build_all_containers.sh
fi

sudo bash deployment_scripts/deploy_nginx_server.sh
sudo bash deployment_scripts/deploy_lighttpd_server.sh

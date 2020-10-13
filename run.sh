#!/bin/bash

sudo chmod +x deployment_scripts/*
bash deployment_scripts/update_server.sh
bash deployment_scripts/setup_problem_bank.sh

TOOLS_DISTRIBUTED=0

for arg in "$@"
do
    case $arg in
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
    docker-compose --compatibility up -d
    sudo bash deployment_scripts/deploy_cokapi_service.sh
fi

sudo bash deployment_scripts/build_all_containers.sh

sudo ./install_backend_service.sh
sudo systemctl start backend.service

bash deployment_scripts/deploy_metabase.sh
sudo bash deployment_scripts/deploy_mongo_express.sh

sudo bash deployment_scripts/deploy_nginx_server.sh
sudo bash deployment_scripts/deploy_lighttpd_server.sh

sudo ./agent/deploy_agent_services.sh
sudo systemctl start docker_agent && sudo systemctl start mcq_agent

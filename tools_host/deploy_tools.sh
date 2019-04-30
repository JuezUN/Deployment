#!/bin/bash

sudo bash deployment_scripts/deploy_nginx_server_tools.sh

cd ..
docker-compose up -d
sudo bash deployment_scripts/deploy_cokapi_service.sh

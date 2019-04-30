#!/bin/bash

cd ..
docker-compose up -d
sudo bash deployment_scripts/deploy_cokapi_service.sh
sudo bash deployment_scripts/deploy_nginx_server.sh
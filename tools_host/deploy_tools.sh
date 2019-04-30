#!/bin/bash

cd ..

docker-compose up -d

sudo bash tools_host/deploy_nginx_server_tools.sh

sudo bash deployment_scripts/deploy_cokapi_service.sh

sudo systemctl restart nginx,service
sudo sustemctl restart cokapi.service

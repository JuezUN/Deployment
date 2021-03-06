#!/bin/bash

# Deploy the tools as docker services. See the docker-compose file.
docker-compose --compatibility -f "$DEPLOYMENT_HOME/docker-compose.yml" up -d

sudo bash "$DEPLOYMENT_HOME/tools_host/deploy_cokapi_service.sh"
sudo systemctl restart cokapi.service

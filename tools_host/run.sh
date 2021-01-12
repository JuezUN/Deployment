#!/bin/bash

.$DEPLOYMENT_HOME/tools_prerequisites.sh

sudo bash .$DEPLOYMENT_HOME/tools_host/deploy_tools.sh

sudo bash .$DEPLOYMENT_HOME/tools_host/deploy_nginx_server_tools.sh

sudo systemctl restart nginx.service

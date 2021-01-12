#!/bin/bash

sudo $DEPLOYMENT_HOME/tools_host/deploy_tools.sh

sudo $DEPLOYMENT_HOME/tools_host/deploy_nginx_server_tools.sh

sudo systemctl restart nginx.service

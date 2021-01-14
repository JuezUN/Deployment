#!/bin/bash

echo -e "export DEPLOYMENT_HOME=\"$(pwd)\"\n" >> env.sh
echo -e "DEPLOYMENT_HOME=\"$(pwd)\"\n" | sudo tee -a /etc/environment
echo -e "UNCODE_DOMAIN=\"$UNCODE_DOMAIN\"\n" | sudo tee -a /etc/environment

cp env.sh ~/.uncode_env
echo 'source ~/.uncode_env' >> ~/.bashrc

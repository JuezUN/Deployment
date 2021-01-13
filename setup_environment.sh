#!/bin/bash

echo -e "export DEPLOYMENT_HOME=\"$(pwd)\"\n" >> env.sh
echo "DEPLOYMENT_HOME=\"$(pwd)\"\n" | sudo tee -a /etc/environment

cp env.sh ~/.uncode_env
echo 'source ~/.uncode_env' >> ~/.bashrc

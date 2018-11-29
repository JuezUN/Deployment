#!/bin/bash

echo -e "export DEPLOYMENT_HOME=\"$(pwd)\"\n" >> env.sh

cp env.sh ~/.uncode_env
echo 'source ~/.uncode_env' >> ~/.bashrc

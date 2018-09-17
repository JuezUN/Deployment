#!/bin/bash

#Installs the software needed to run an inginious grading agent

chmod +x ../deployment_scripts/*.sh
bash ../deployment_scripts/install_basic_dependencies.sh
bash ../deployment_scripts/update_server.sh

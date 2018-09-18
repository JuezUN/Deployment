#!/bin/bash

sudo bash deployment_scripts/build_all_containers.sh

sudo chmod +x deployment_scripts/*
docker-compose up -d
bash deployment_scripts/update_server.sh
bash deployment_scripts/setup_problem_bank.sh

sudo bash deployment_scripts/deploy_apache_server.sh

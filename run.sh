#!/bin/bash

SERVER="APACHE"

while getopts ":a" opt; do
    case $opt in
        a)
            SERVER="APACHE"
            ;;
        \?)
            echo "Invalid option -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument" >&2
            exit 1
            ;;
    esac
done

sudo chmod +x deployment_scripts/*
sudo bash deployment_scripts/check_prerequisites.sh
sudo bash deployment_scripts/configure_proxy.sh
docker-compose up -d
sudo bash deployment_scripts/restrict_ports.sh
bash deployment_scripts/build_all_containers.sh
bash deployment_scripts/update_server.sh
if [ $SERVER -eq "APACHE" ]
then
    sudo bash deployment_scripts/deploy_apache_server.sh
fi
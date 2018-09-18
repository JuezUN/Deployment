#!/bin/bash

#this script installs the prerequisites needed to run the Judge

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

#install INGInious dependencies
chmod +x deployment_scripts/*.sh
bash deployment_scripts/install_basic_dependencies.sh
sudo bash deployment_scripts/install_mongodb.sh
bash deployment_scripts/install_node.sh

if [ "$SERVER" == "APACHE" ]
then
    echo "installing apache with mod_wsgi"
    sudo bash deployment_scripts/install_apache.sh
fi

echo -e "\n\n$(tput setaf 3)Please logout and back in to finish the Docker installation $(tput sgr0)"

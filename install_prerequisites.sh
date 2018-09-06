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
sudo yum install -y epel-release https://centos7.iuscommunity.org/ius-release.rpm
sudo yum install -y git gcc libtidy python35u python35u-pip python35u-devel zeromq-devel
sudo chmod +x deployment_scripts/*.sh
sudo bash deployment_scripts/install_mongodb.sh
bash deployment_scripts/install_docker.sh
bash deployment_scripts/install_node.sh
if [ "$SERVER" == "APACHE" ]
then
    echo "installing apache with mod_wsgi"
    sudo bash deployment_scripts/install_apache.sh
fi

echo "please logout and back in to finished the installation"
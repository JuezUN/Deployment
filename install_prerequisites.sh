#!/bin/bash

#this script installs the prerequisites needed to run the Judge

sudo chmod +x deployment_scripts/*.sh

sudo bash deployment_scripts/install_mongodb.sh
bash deployment_scripts/install_docker.sh
sudo bash deployment_scripts/install_lighttpd.sh

#install INGInious dependencies
sudo yum install -y epel-release https://centos7.iuscommunity.org/ius-release.rpm
sudo yum install -y git gcc libtidy python35u python35u-pip python35u-devel zeromq-devel

echo "please logout and back in to finished the installation"
#!/bin/bash

# These are the dependencies that both webapp and grading agents need

sudo yum install -y https://repo.ius.io/ius-release-el7.rpm
sudo yum install -y git gcc libtidy python36-pip python36 python3-devel zeromq-devel
sudo pip3.6 install --upgrade pip
bash "$DEPLOYMENT_HOME/deployment_scripts/install_docker.sh"

#!/bin/bash

#These are the dependencies that both webapp and graing agents need

#Set the cwd to Deployment/deployment_scripts
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

sudo yum install -y epel-release https://centos7.iuscommunity.org/ius-release.rpm
sudo yum install -y git gcc libtidy python35u python35u-pip python35u-devel zeromq-devel
bash ./install_docker.sh

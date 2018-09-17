#!/bin/bash

#These are the dependencies that both webapp and graing agents need

sudo yum install -y epel-release https://centos7.iuscommunity.org/ius-release.rpm
sudo yum install -y git gcc libtidy python35u python35u-pip python35u-devel zeromq-devel
bash ./install_docker.sh

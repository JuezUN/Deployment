#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

touch /etc/yum.repos.d/mongodb.repo

current_path=$(pwd)
cp "$current_path/deployment_scripts/mongodb.repo"  /etc/yum.repos.d/


yum -y install mongodb-org

systemctl start mongod
systemctl enable mongod

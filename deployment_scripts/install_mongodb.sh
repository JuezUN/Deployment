#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

cp $DEPLOYMENT_HOME/config/mongodb.repo  /etc/yum.repos.d/

yum -y install mongodb-org

systemctl start mongod.service
systemctl enable mongod.service

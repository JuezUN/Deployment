#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Installing NodeJS"

cp "$DEPLOYMENT_HOME/config/mongodb.repo"  /etc/yum.repos.d/

yum -y install mongodb-org

systemctl start mongod.service
systemctl enable mongod.service

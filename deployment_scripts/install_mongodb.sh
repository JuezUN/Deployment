#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

touch /etc/yum.repos.d/mongodb.repo
groupadd mongodb

current_path=$(pwd)
cp $current_path/config/mongodb.repo  /etc/yum.repos.d/

yum -y install mongodb-org

systemctl start mongod
systemctl enable mongod

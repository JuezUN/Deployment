#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

id -u ucokapi > /dev/null 2>&1
if [ $? -ne 0 ]
then
    useradd ucokapi
    usermod -aG ucokapi $(whoami)
fi

docker pull unjudge/opt-cpp-backend
docker tag unjudge/opt-cpp-backend:latest pgbovine/opt-cpp-backend:v1

mkdir -p /opt/tutor
cd /opt/tutor/
git clone https://github.com/JuezUN/OnlinePythonTutor.git
cd /opt/tutor/OnlinePythonTutor/v4-cokapi

chown -R ucokapi:ucokapi /opt/tutor

npm install express
npm install -g jshint


#Install systemd service
current_path=$(pwd)

cp $current_path/deployment_scripts/cokapi.sh /usr/local/bin
chown ucokapi:ucokapi /usr/local/bin/cokapi.sh
chmod +x /usr/local/bin/cokapi.sh

cp $current_path/deployment_scripts/cokapi.service /etc/systemd/system
chmod 664 /etc/systemd/system/cokapi.service

systemctl daemon-reload
systemctl enable cokapi.service
systemctl start cokapi.service

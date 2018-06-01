#!/bin/bash

#this configures the docker http proxy environment variables to work

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir /etc/systemd/system/docker.service.d
touch /etc/systemd/system/docker.service.d/http-proxy.conf
echo "[Service]
Environment=\"HTTP_PROXY=$http_proxy\""
sudo systemctl restart docker


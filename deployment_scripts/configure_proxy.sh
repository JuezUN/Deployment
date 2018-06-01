#!/bin/bash

#this configures the docker http proxy environment variables to work

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir /etc/systemd/system/docker.service.d
touch /etc/systemd/system/docker.service.d/http-proxy.conf
if [ -n $http_proxy ]
then
  echo "[Service]
  Environment=\"HTTP_PROXY=$http_proxy\"" >> /etc/systemd/system/docker.service.d/http-proxy.conf
  systemctl restart docker
fi


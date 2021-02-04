#!/bin/bash

# Installs the Nginx reverse proxy service for the tools server

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

rm -rf /etc/nginx
cp -r "$DEPLOYMENT_HOME/config/nginx" /etc/

rm -f /etc/nginx/conf.d/*
cp "$DEPLOYMENT_HOME/monitoring/nginx/uncode_monitoring.conf" /etc/nginx/conf.d/

systemctl enable nginx
systemctl restart nginx

#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

rm -rf /etc/nginx
cp -r $DEPLOYMENT_HOME/tools_host/config/nginx /etc/

rm -rf /etc/nginx/conf.d/inginious.conf
cp $DEPLOYMENT_HOME/tools_host/config/nginx/tools.conf /etc/nginx/conf.d/

systemctl enable nginx
systemctl restart nginx

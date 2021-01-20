#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo -e "Deploying reverse proxy with Nginx\n"

rm -rf /etc/nginx
cp -r $DEPLOYMENT_HOME/config/nginx /etc/

cp $DEPLOYMENT_HOME/config/maintenance_off.html /usr/share/nginx/html/

systemctl enable nginx
systemctl restart nginx

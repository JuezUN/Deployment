#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

current_path=$(pwd)

rm -rf /etc/nginx
cp -r $current_path/config/nginx /etc/

cp $current_path/config/maintenance_off.html /usr/share/nginx/html/

systemctl enable nginx
systemctl restart nginx

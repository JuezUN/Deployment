#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

current_path=$(pwd)

rm -rf /etc/nginx
cp -r $current_path/config/nginx /etc/

rm -rf /etc/nginx/conf.d/inginious.conf
cp $current_path/tools_host/config/nginx/tools.conf /etc/nginx/conf.d/

systemctl enable nginx
systemctl restart nginx

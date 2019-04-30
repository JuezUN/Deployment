#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

current_path=$(pwd)

rm -rf /etc/nginx
cp -r $current_path/config/nginx /etc/

systemctl enable nginx
systemctl restart nginx

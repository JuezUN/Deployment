#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

current_path=$(pwd)

#this script sets up all configuration files for lighttpd along with INGInious  
mkdir -p /var/cache/lighttpd/compress
mkdir -p /var/www/INGInious/
mkdir -p /var/www/INGInious/tasks
mkdir -p /var/www/INGInious/backup
usermod -aG docker lighttpd
chown -R lighttpd:lighttpd /var/www/INGInious
cp $current_path/configuration.yaml /var/www/INGInious/
cp $current_path/lighttpd.conf /etc/lighttpd/
cp $current_path/modules.conf /etc/lighttpd/
cp $current_path/fastcgi.conf /etc/lighttpd/conf.d/
#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "adding apache to mongo and docker group"
usermod -aG docker apache
usermod -aG mongodb apache

mkdir -p /var/www/INGInious
mkdir -p /var/www/INGInious/tasks
mkdir -p /var/www/INGInious/backup
mkdir -p /var/www/INGInious/tmp
chown -R apache:apache /var/www/INGInious

echo "setup permissions"
sudo chown 777 -R /tmp

echo "updating configuration files"
current_path=$(pwd)
echo "configuration.yaml"
cp $current_path/config/configuration.yaml /var/www/INGInious/
echo "httpd"
rm /etc/sysconfig/httpd 
cp $current_path/config/httpd /etc/sysconfig/
echo "removing welcome.conf"
rm /etc/httpd/conf.d/welcome.conf
echo "httpd.conf"
rm /etc/httpd/conf/httpd.conf
cp $current_path/config/httpd.conf /etc/httpd/conf/

echo "setting up httpd"
systemctl enable httpd
systemctl restart httpd
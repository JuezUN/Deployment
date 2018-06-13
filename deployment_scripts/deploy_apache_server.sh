#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

usermod -aG docker apache
usermod -aG mongodb apache

mkdir -p /var/www/INGInious
chown -R apache:apache /var/www/INGInious

current_path=$(pwd)
cp $current_path/config/configuration.yaml /var/www/INGInious/
rm /etc/sysconfig/httpd 
cp $current_path/config/httpd /etc/sysconfig/
rm /etc/httpd/conf.d/welcome.conf
rm /etc/httpd/conf/httpd.conf
cp $current_path/config/httpd.conf /etc/httpd/conf/

SERVICE=httpd
systemctl restart httpd
systemctl enable httpd
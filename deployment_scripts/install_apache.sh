#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

yum install -y yum install httpd httpd-devel
pip3.5 install mod_wsgi

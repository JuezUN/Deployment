#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

yum -y install lighttpd lighttpd-fastcgi
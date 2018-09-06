#!/bin/bash

# Disable selinux

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

sudo cat ./config/selinux.txt > /etc/selinux/config
sudo shutdown -r now

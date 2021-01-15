#!/bin/bash

echo "Installing NodeJS"

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

sudo yum install  -y epel-release
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum install -y nodejs

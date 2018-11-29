#!/bin/bash

# Installs the uncode_scripts i.e. copies the scripts to the folder /usr/bin

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

chmod +x ./uncode_scripts/*.sh
cp ./uncode_scripts/*.sh /usr/bin

echo "Installation successful"
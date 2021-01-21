#!/bin/bash

# Installs the uncode_scripts, it copies the scripts to the folder /usr/bin so these scripts are now runnable

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Installing UNCode scripts to manage the server"

chmod +x $DEPLOYMENT_HOME/uncode_scripts/uncode*
cp "$DEPLOYMENT_HOME/uncode_scripts/uncode*" /usr/bin

echo "UNCode scripts installation successful"
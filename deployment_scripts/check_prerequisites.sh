#!/bin/bash

# this script checks if the prerequisites required to run INGInious are met

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ $(sestatus | grep enforcing | wc -l) -eq 1 ]
then
    echo "please disable selinux enforcing policy"
    exit 1
fi


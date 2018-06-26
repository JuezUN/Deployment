#!/bin/bash


sudo yum install  -y epel-release
curl --silent --location https://rpm.nodesource.com/setup_6.x | sudo bash -
curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
sudo yum install -y nodejs

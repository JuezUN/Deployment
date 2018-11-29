#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

docker pull unjudge/opt-cpp-backend
docker tag unjudge/opt-cpp-backend:latest pgbovine/opt-cpp-backend:v1

mkdir -p /opt/tutor
cd /opt/tutor/

git clone https://github.com/JuezUN/OnlinePythonTutor.git

cd /opt/tutor/OnlinePythonTutor/v4-cokapi

npm install express
npm install -g jshint

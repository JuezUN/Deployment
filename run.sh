#!/bin/bash

#clone repositories

echo "cloning repositories"
if [ ! -d ./OnlinePythonTutor ]
  then
    git clone https://github.com/JuezUN/OnlinePythonTutor.git #pythonTutor
fi
if [ ! -d ./INGInious-containers ]
  then
    git clone https://github.com/JuezUN/INGInious-containers.git #containers
fi
if [ ! -d ./INGInious ]
  then
    git clone https://github.com/JuezUN/INGInious.git #Inginious
fi
if [ ! -d ./opt-cpp-backend ]
  then
    git clone https://github.com/JuezUN/opt-cpp-backend.git #cpp-back-end
fi
if [ ! -d ./linter-web-service ]
  then
    git clone https://github.com/JuezUN/linter-web-service.git #linter
fi

#build containers

echo "building containers"

(cd INGInious-containers  \
 && ./build-container.sh cpp \
 && ./build-container.sh java7 \
 && ./build-container.sh python3 \
 && ./build-container.sh multilang)

#install INGInious

(cd INGInious && chmod +x inginious-webapp)

pip install --upgrade pip
pip3 install INGInious

#setup task directories
echo "setting up tasks directories"
sudo mkdir /opt/INGInious && mkdir /opt/INGInious/tasks && mkdir /opt/INGInious/backend
sudo chown -R $USER:$USER /opt/INGInious/

#configure DockerFiles

echo "configuring dockerfiles"

cp ./Dockerfiles/OnlinePythonTutor/Dockerfile ./OnlinePythonTutor/
cp ./Dockerfiles/linter-web-service/Dockerfile ./linter-web-service/
rm ./opt-cpp-backend/Dockerfile
cp ./Dockerfiles/opt-cpp-backend/Dockerfile ./opt-cpp-backend/
mv ./configuration.yaml ./INGInious

#setup opt-cpp-backend
(cd opt-cpp-backend && docker build -t opt-cpp-backend .)
(cd OnlinePythonTutor/v4-cokapi/ && npm install express)

#run opt-cpp-backend
echo "running opt-cpp-backend"
(cd OnlinePythonTutor/v4-cokapi/ && node cokapi.js) &

#run docker-compose
echo "running services"
docker-compose up &

#run webapp
echo "running INGInious"
(cd INGInious && ./inginious-webapp) &

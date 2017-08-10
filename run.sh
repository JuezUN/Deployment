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

#get docker and docker-compose
echo "installing docker and python-pip"
sudo apt-get install -y docker docker-compose python3-pip

#build containers

echo "building containers"

(cd INGInious-containers  \
 && sudo ./build-container.sh base \
 && ./build-container.sh default && ./build-container.sh cpp \
 && ./build-container.sh java7 \
 && ./build-container.sh python3)

#install INGInious

echo "installing INGInious"

sudo apt-get install mongodb gcc tidy python3 python3-pip python3-dev libzmq-dev

(cd INGInious && chmod +x inginious-webapp)

sudo pip install --upgrade pip
sudo -H pip3 install -e INGInious

sudo systemctl start mongodb
sudo systemctl enable mongodb
sudo systemctl start docker
sudo systemctl enable docker

#setup linters and pythontutor

#copy DockerFiles

echo "copying dockerfiles"

cp ./Dockerfiles/OnlinePythonTutor/Dockerfile ./OnlinePythonTutor/
cp ./Dockerfiles/linter-web-service/Dockerfile ./linter-web-service/

#run webapp
(cd INGInious && ./inginious-webapp --config ../configuration.juezun.yaml) &
#run docker-compose
echo "running INGInious"
docker-compose up &

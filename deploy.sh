#! bin/bash

#get docker and docker-compose

sudo apt-get install -y docker docker-compose

#clone repositories

git clone https://github.com/JuezUN/OnlinePythonTutor.git #pythonTutor
git clone https://github.com/JuezUN/INGInious-containers.git #containers
git clone https://github.com/JuezUN/INGInious.git #Inginious
git clone https://github.com/JuezUN/opt-cpp-backend.git #cpp-back-end
git clone https://github.com/JuezUN/linter-web-service.git #linter

#copy DockerFiles

cp ./Dockerfiles/PythonTutorDockerfile ./OnlinePythonTutor/Dockerfile
cp ./Dockerfiles/linterDockerfile ./linter-web-service/Dockerfile
cp ./Dockerfiles/cppDockerFile ./OnlinePythonTutor/Dockerfile


#run docker-compose

docker-compose up




#!/bin/bash
HAS_DOCKER_DAEMON = "y\n"
MAXIMUM_CONCURRENCY = "\n" #autodetect
HOSTNAME = "\n" #autodetect
PORTS = "\n"  #default (64100-64200)
MONGODB_CONFIGURATION = "\n" #default
TASK_DIRECTORY = "." #default
DEMONSTRATION_TASKS = "n\n"
DOWNLOAD_DEFAULT_CONTAINER = "y\n"
DOWNLOAD_CPP = "y\n"
DOWNLOAD_JAVA7 = "y\n"
DOWNLOAD_JAVA8_AND_SCALA = "n\n"
DOWNLOAD_MONO = "n\n"
DOWNLOAD_MOZART2 = "n\n"
DOWNLOAD_PHP5 = "n\n"
DOWNLOAD_PYTHIA0 = "n\n"
DOWNLOAD_PYTHIA1 = "n\n"
DOWNLOAD_R = "n\n"
DOWNLOAD_SEKEXE = "n\n"
MANUALLY_ADD_IMAGES = "y\n"
BASE_IMAGE = "ingi/inginious-c-base"
DEFAULT_IMAGE = "ingi/inginious-c-default"
CPP_IMAGE = "ingi/inginious-c-cpp"
JAVA7_IMAGE = "ingi/inginious-c-java7"
PYTHON3_IMAGE = "ingi/inginious-c-python3"
END_OF_IMAGES= "\n"
MINIFIED_JS = "n\n"
BACKUP_DIR = "."
PLAGIARISM_DETECTOR = "n\n"
BATCH_IMAGES = "\n"
AUTHENTICATION = "1\n" #1 test auth 2 DB auth 3 LDAP auth
AUTHENTICATION_METHOD_NAME = "\n" #default [DEMO]
USERNAME_DEFAULT = "\n" #[test]
PASSWORD_DEFAULT = "\n" #[test]
ADITIONAL_USER = "n\n" #no aditional users
ADITONAL_AUTH_METHOD = "n\n" #no adtional authentication methods
SUPERADMIN = "\n" #no SUPERADMIN
INGINIOUS_XTERM_LOCATION = "\n"


#get docker and docker-compose

sudo apt-get install -y docker docker-compose

sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker

#clone repositories

git clone https://github.com/JuezUN/OnlinePythonTutor.git #pythonTutor
git clone https://github.com/JuezUN/INGInious-containers.git #containers
git clone https://github.com/JuezUN/INGInious.git #Inginious
git clone https://github.com/JuezUN/opt-cpp-backend.git #cpp-back-end
git clone https://github.com/JuezUN/linter-web-service.git #linter

#build containers

(cd INGInious-containers ; ./build-container base && ./build-container default && ./build-container.sh cpp && ./build-container.sh java7 && ./build-container python3)

#install INGInious

chmod +x inginious-install

(cd INGInious ; chmod +x inginious-install && printf "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s" \
 "$HAS_DOCKER_DAEMON" \
 "$MAXIMUM_CONCURRENCY" \
 "$HOSTNAME" "$PORTS" \
 "$MONGODB_CONFIGURATION" \
 "$TASK_DIRECTORY" \
 "$DEMONSTRATION_TASKS" \
 "$DOWNLOAD_DEFAULT_CONTAINER" \
 "$DOWNLOAD_CPP" \
 "$DOWNLOAD_JAVA7" \
 "$DOWNLOAD_JAVA8_AND_SCALA" \
 "$DOWNLOAD_MONO" \
 "$DOWNLOAD_MOZART2" \
 "$DOWNLOAD_PHP5" \
 "$DOWNLOAD_PYTHIA0" \
 "$DOWNLOAD_SEKEXE" \
 "$MANUALLY_ADD_IMAGES" \
 "$BASE_IMAGE" \
 "$DEFAULT_IMAGE" \
 "$CPP_IMAGE" \
 "$JAVA7_IMAGE" \
 "$PYTHON3_IMAGE" \
 "$END_OF_IMAGES" \
 "$MINIFIED_JS" \
 "$BACKUP_DIR" \
 "$PLAGIARISM_DETECTOR" \
 "$BATCH_IMAGES" \
 "$AUTHENTICATION" \
 "$AUTHENTICATION_METHOD_NAME" \
 "$USERNAME_DEFAULT" \
 "$PASSWORD_DEFAULT" \
 "$ADITIONAL_USER" \
 "$ADITONAL_AUTH_METHOD" \
 "$SUPERADMIN" \
 "$INGINIOUS_XTERM_LOCATION" \
 "$DOWNLOAD_PYTHIA1" \
 "$DOWNLOAD_R" | ./inginious-install webapp)


#run INGInious
(cd INGInious ; chmod +x inginious-webapp && ./inginious-webapp)


#copy DockerFiles

cp ./Dockerfiles/PythonTutorDockerfile ./OnlinePythonTutor/Dockerfile
cp ./Dockerfiles/linterDockerfile ./linter-web-service/Dockerfile
cp ./Dockerfiles/cppDockerFile ./OnlinePythonTutor/Dockerfile

#run docker-compose

docker-compose up

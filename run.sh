#!/bin/bash

function deploy_production {
  echo "production deployment in $JUDGE_TEMP"
  cp ./docker-compose.yml $JUDGE_TEMP/docker-compose.yml
  (cd $JUDGE_TEMP && docker-compose up)
  exit
}


function build_cokapi_containers {
  if [ "$(docker images -q pgbovine/opt-cpp-backend 2> /dev/null)" == "" ]
  then
    echo "building cokapi cpp container"
    (cd $JUDGE_TEMP/opt-cpp-backend && make docker)
  else
    echo "container  already exists"
  fi

  if [ "$(docker images -q pgbovine/cokapi-java:v1 2> /dev/null)" == "" ]
  then
    echo "buiding cokapi java container"
    (cd $JUDGE_TEMP/OnlinePythonTutor/v4-cokapi/backends/java && make)
  else
    echo "java cokapi already built"
  fi
}

function build_grading_containers {
  echo "building grading containers"
  echo "building base container"
  [[ "$(docker images -q ingi/inginious-c-base 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-base $JUDGE_TEMP/INGInious/base-containers/base
  echo "building default container"
  [[ "$(docker images -q ingi/inginious-c-default 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-default $JUDGE_TEMP/INGInious/base-containers/default/
  echo "building multilang container"
  [[ "$(docker images -q ingi/inginious-c-multilang 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-multilang $JUDGE_TEMP/INGInious-containers/grading/multilang
}

function move_config_files {
  echo "setting up config file"
  cp ./configuration.yaml /var/www/INGInious/
  yes | sudo cp -f configuration.yaml /var/www/INGInious/configuration.yaml
  
}


function clone_repositories {
  echo "cloning repositories"
  if [ ! -d $JUDGE_TEMP/INGInious ]
    then
      sudo mkdir -p $JUDGE_TEMP/INGInious-temp/
      git clone --depth=1 https://github.com/JuezUN/INGInious.git $JUDGE_TEMP/INGInious-temp/
  fi
}

function setup_files_scheme {
  if [ ! -d /var/www/INGInious ]
    then
      sudo mkdir -p /var/www/INGInious/
      sudo mkdir -p /var/www/INGInious/tasks/
      sudo mkdir -p /var/www/INGInious/backup/
  fi
}

function deploy {
  export_environment_variables
  setup_files_scheme
  clone_repositories
  move_config_file
  ./deployment_scripts/build_grading_containers
  build_cokapi_containers
  deploy_production
}

function delete_local {
  if [ -d $1 ]
  then
    echo "deleting previous version of $1"
    sudo rm -r $1
  fi
}

function update_containers {
  echo "updating containers"
  docker pull unjudge/linter-web-service
  docker pull unjudge/onlinepythontutor
  docker pull unjudge/cokapi
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

source init.sh
source helper_functions.sh

deploy

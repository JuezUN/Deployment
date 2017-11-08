#!/bin/bash

LINTER_SERVICE="judge/linter-web-service"
PYTHON_TUTOR_SERVICE="judge/OnlinePythonTutor"
INGINIOUS_FRONTEND_SERVICE="judge/INGInious"

function check_path_existence {
  if [ -d $1 ]
    then
      return
  fi
  echo "error: could not find the directory $1"
  exit 1
}

function move_docker_and_config_files {
  echo "setting up docker and config files"
  mv ./configuration.yaml $1/INGInious
  mv ./Dockerfiles/linter-web-service $1/linter-web-service
  mv ./Dockerfiles/OnlinePythonTutor $1/OnlinePythonTutor
  mv ./Dockerfiles/opt-cpp-backend $1/opt-cpp-backend
  mv ./Dockerfiles/Cokapi $1/OnlinePythonTutor/v4-cokapi
}

function build_container {
  if [ "$(docker images -q $1 2> /dev/null)" == "" ]
  then
    echo "building $1"
    docker build -t $1 $2
    [[ "$(docker images -q $1 2> /dev/null)" != "" ]] && echo "container $1 successfully built" && return
    echo "failed building container $1"
  else
    echo "container $1 already exists"
  fi
}

function build_grading_containers {
  echo "building grading containers"
  echo "building base container"
  [[ "$(docker images -q ingi/inginious-c-base 2> /dev/null)" == "" ]] && docker build -t ingi/inginous-c-base $1/IGNInious/base-containers/base/
  echo "building default container"
  [[ "$(docker images -q ingi/inginious-c-default 2> /dev/null)" == "" ]] && docker build -t ingi/inginous-c-default $1/IGNInious/base-containers/default/
  echo "building default container"
  [[ "$(docker images -q ingi/inginious-c-multilang 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-multilang $1/INGInious-containers/grading/multilang/
}

function clone_repositories {
  echo "cloning repositories"
  if [ ! -d $1/OnlinePythonTutor ]
    then
      git clone https://github.com/JuezUN/OnlinePythonTutor.git $1/OnlinePythonTutor
  fi
  if [ ! -d $1/INGInious-containers ]
    then
      git clone https://github.com/JuezUN/INGInious-containers.git $1/INGInious-containers
  fi
  if [ ! -d $1/INGInious ]
    then
      git clone https://github.com/JuezUN/INGInious.git $1/INGInious
  fi
  if [ ! -d $1/opt-cpp-backend ]
    then
      git clone https://github.com/JuezUN/opt-cpp-backend.git $1/opt-cpp-backend
  fi
  if [ ! -d $1/linter-web-service ]
    then
      git clone https://github.com/JuezUN/linter-web-service.git $1/linter-web-service
  fi
}

function deploy {
  check_path_existence $2
  clone_repositories $2
  move_docker_and_config_files $2
  build_grading_containers $2
  if [ "$1" = true ]
  then
    deploy_development_environment $2
  else
    deploy_production $2
  fi
}

function deploy_production {
  echo "production deployment $1"
  mv ./docker-compose-production.yaml $1/docker-compose.yaml
  build_container "$INGINIOUS_FRONTEND_SERVICE" "$1/INGInious"
  build_container "$LINTER_SERVICE" "$1/linter-web-service"
  build_container "$PYTHON_TUTOR_SERVICE" "$1/OnlinePythonTutor"
  docker-compose up
  exit
}

function deploy_development_environment {
  echo "development environment $1"
  exit
}

JUDGE_HOME="/opt/Judge"
AS_DEVELOPER=false

while getopts ":p:d" opt; do
  case $opt in
    p)
      JUDGE_HOME=$OPTARG
      ;;
    d)
      AS_DEVELOPER=true
      ;;
    \?)
      echo "Invalid option -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
  esac
done

deploy $AS_DEVELOPER $JUDGE_HOME

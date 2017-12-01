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

function setup_files_scheme {
  if [ ! -d $1 ]
    then
      sudo mkdir $1
      sudo chown $USER $1
      mkdir $1/tasks
      mkdir $1/backup
  fi
}

function clean_up_temporal_files {
  if [ -d $1 ]
    then
      sudo rm -r $1/OnlinePythonTutor
      sudo rm -r $1/opt-cpp-backend
  fi
}


function move_docker_and_config_files {
  echo "setting up docker and config files"
  cp ./configuration.yaml $1/INGInious
  cp ./Dockerfiles/INGInious/Dockerfile $1/INGInious
  cp ./Dockerfiles/linter-web-service/Dockerfile $1/linter-web-service
  cp ./Dockerfiles/OnlinePythonTutor/Dockerfile $1/OnlinePythonTutor
  cp ./Dockerfiles/Cokapi/Dockerfile $1/OnlinePythonTutor/v4-cokapi
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

function build_cokapi_containers {
  if [ "$(docker images -q pgbovine/opt-cpp-backend 2> /dev/null)" == "" ]
  then
    echo "building cokapi cpp container"
    (cd $1/opt-cpp-backend && make docker)
  else
    echo "container  already exists"
  fi

  if [ "$(docker images -q pgbovine/cokapi-java:v1 2> /dev/null)" == "" ]
  then
    echo "buiding cokapi java container"
    (cd $1/OnlinePythonTutor/v4-cokapi/backends/java && make)
  else
    echo "java cokapi already built"
  fi
}

function clone_repositories {
  echo "cloning repositories"
  if [ ! -d $1/OnlinePythonTutor ]
    then
      git clone -b Deployment https://github.com/JuezUN/OnlinePythonTutor.git $1/OnlinePythonTutor
  fi
  if [ ! -d $1/opt-cpp-backend ]
    then
      git clone -b Deployment https://github.com/JuezUN/opt-cpp-backend.git $1/opt-cpp-backend
  fi
  if [ ! -d $1/INGInious-containers ]
    then
      git clone https://github.com/JuezUN/INGInious-containers.git $1/INGInious-containers
  fi
}



function set_environment_variables {
  export INGINIOUS_PORT="$1"
  export LINTER_PORT="$2"
  export PYTHON_TUTOR_PORT="$3"
  export COKAPI_PORT="$4"
  export DB_PORT="$5"
}

function deploy {
  setup_files_scheme $2
  clone_repositories $2
  #move_docker_and_config_files $2
  build_grading_containers $2
  build_cokapi_containers $2
  if [ "$1" = true ]
  then
    deploy_development_environment $2
  else
    deploy_production $2
  fi
}

function deploy_production {
  echo "production deployment $1"
  cp ./docker-compose.yml $1/docker-compose.yml
  (cd $1 && docker-compose up)
  exit
}

function deploy_development_environment {
  echo "development environment $1"
  exit
}

function update_containers {
  docker pull unjudge/inginious:Deployment
  docker pull unjudge/linter-web-service:deployment
  docker pull unjudge/onlinepythontutor:Deployment
  docker pull unjudge/cokapi:Deployment
}

JUDGE_HOME="/tmp/Judge"
AS_DEVELOPER=false
INGINIOUS_CHOOSED_PORT="8080"
LINTER_WEBSERVICE_CHOOSED_PORT="4567"
ONLINE_PYTHON_TUTOR_CHOOSED_PORT="8003"
COKAPI_CHOOSED_PORT="3000"
DB_PORT="27017"

UPDATE=false

while getopts ":p:d:l:t:c:b:i:u" opt; do
  case $opt in
    p)
      JUDGE_HOME=$OPTARG
      ;;
    d)
      AS_DEVELOPER=true
      ;;
    l)
      LINTER_WEBSERVICE_PORT=$OPTARG
      ;;
    t)
      ONLINE_PYTHON_TUTOR_PORT=$OPTARG
      ;;
    c)
      COKAPI_PORT=$OPTARG
      ;;
    b)
      DB_PORT=$OPTARG
      ;;
    i)
      INGINIOUS_PORT=$OPTARG
      ;;
    u)
      UPDATE=true
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

if [ UPDATE ]
then
  update_containers
fi

set_environment_variables $INGINIOUS_PORT $LINTER_WEBSERVICE_PORT $ONLINE_PYTHON_TUTOR_PORT $COKAPI_PORT $DB_PORT
deploy $AS_DEVELOPER $JUDGE_HOME

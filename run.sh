#!/bin/bash


function deploy_production {
  echo "production deployment in $JUDGE_HOME"
  cp ./docker-compose.yml $JUDGE_HOME/docker-compose.yml
  (cd $JUDGE_HOME && docker-compose up)
  exit
}


function build_cokapi_containers {
  if [ "$(docker images -q pgbovine/opt-cpp-backend 2> /dev/null)" == "" ]
  then
    echo "building cokapi cpp container"
    (cd $JUDGE_HOME/opt-cpp-backend && make docker)
  else
    echo "container  already exists"
  fi

  if [ "$(docker images -q pgbovine/cokapi-java:v1 2> /dev/null)" == "" ]
  then
    echo "buiding cokapi java container"
    (cd $JUDGE_HOME/OnlinePythonTutor/v4-cokapi/backends/java && make)
  else
    echo "java cokapi already built"
  fi
}

function build_grading_containers {
  echo "building grading containers"
  echo "building base container"
  [[ "$(docker images -q ingi/inginious-c-base 2> /dev/null)" == "" ]] && docker build -t ingi/inginous-c-base $JUDGE_HOME/IGNInious/base-containers/base/
  echo "building default container"
  [[ "$(docker images -q ingi/inginious-c-default 2> /dev/null)" == "" ]] && docker build -t ingi/inginous-c-default $JUDGE_HOME/IGNInious/base-containers/default/
  echo "building multilang container"
  [[ "$(docker images -q ingi/inginious-c-multilang 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-multilang $JUDGE_HOME/INGInious-containers/grading/multilang/
}

function move_config_file {
  echo "setting up config file"
  cp ./configuration.yaml $JUDGE_HOME
}


function clone_repositories {
  echo "cloning repositories"
  if [ ! -d $JUDGE_HOME/OnlinePythonTutor ]
    then
      git clone https://github.com/JuezUN/OnlinePythonTutor.git $JUDGE_HOME/OnlinePythonTutor
  fi
  if [ ! -d $JUDGE_HOME/opt-cpp-backend ]
    then
      git clone https://github.com/JuezUN/opt-cpp-backend.git $JUDGE_HOME/opt-cpp-backend
  fi
  if [ ! -d $JUDGE_HOME/INGInious-containers ]
    then
      git clone https://github.com/JuezUN/INGInious-containers.git $JUDGE_HOME/INGInious-containers
  fi
}

function setup_files_scheme {
  if [ ! -d $JUDGE_HOME ]
    then
      sudo mkdir $JUDGE_HOME
      sudo chown $USER $JUDGE_HOME
      mkdir $JUDGE_HOME/tasks
      mkdir $JUDGE_HOME/backup
  fi
}

function export_environment_variables {
  source deployment_configuration.env
  export JUDGE_HOME INGINIOUS_PORT LINTER_PORT PYTHON_TUTOR_PORT COKAPI_PORT GOOGLE_AUTH_ID GOOGLE_AUTH_SECRET
}

function deploy {
  export_environment_variables
  setup_files_scheme
  clone_repositories
  move_config_file
  build_grading_containers
  build_cokapi_containers
  deploy_production
}

function delete_local {
  if [ -d $1 ]
  then
    sudo rm -r $1
  fi
}

function update_containers {
  delete_local $JUDGE_HOME/opt-cpp-backend
  delete_local $JUDGE_HOME/OnlinePythonTutor
  docker pull unjudge/inginious
  docker pull unjudge/linter-web-service
  docker pull unjudge/onlinepythontutor
  docker pull unjudge/cokapi
}

while getopts ":u" opt; do
  case $opt in
    u)
      update_containers
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

deploy

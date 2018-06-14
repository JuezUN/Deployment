#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "building grading containers"
echo "building base container"

path='/tmp/judge'

mkdir -p $path/INGInious
mkdir -p $path/INGInious-containers

git clone --depth 1 https://github.com/JuezUN/INGInious.git $path/INGInious
git clone --depth 1 https://github.com/JuezUN/INGInious-containers.git $path/INGInious-containers
[[ "$(docker images -q ingi/inginious-c-base 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-base $path/INGInious/base-containers/base
echo "building default container"
[[ "$(docker images -q ingi/inginious-c-default 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-default $path/INGInious/base-containers/default
echo "building multilang container"
[[ "$(docker images -q ingi/inginious-c-multilang 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-multilang $path/INGInious-containers/grading/multilang
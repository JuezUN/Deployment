#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Pulling grading containers"

echo "Pulling base container"
[[ "$(docker images -q ingi/inginious-c-base 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-base

echo "Pulling default container"
[[ "$(docker images -q ingi/inginious-c-default 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-default

echo "Pulling UNCode base container"
[[ "$(docker images -q unjudge/uncode-c-base 2> /dev/null)" == "" ]] && docker pull unjudge/uncode-c-base

echo "Pulling multilang container"
[[ "$(docker images -q ingi/inginious-c-multilang 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-multilang

echo "Pulling HDL container"
[[ "$(docker images -q ingi/hdl-uncode 2> /dev/null)" == "" ]] && docker pull unjudge/hdl-uncode

echo "Pulling notebook container"
[[ "$(docker images -q ingi/inginious-c-notebook 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-notebook

docker tag unjudge/inginious-c-base ingi/inginious-c-base
docker tag unjudge/inginious-c-default ingi/inginious-c-default
docker tag unjudge/inginious-c-multilang ingi/inginious-c-multilang
docker tag unjudge/hdl-uncode ingi/hdl-uncode
docker tag unjudge/inginious-c-notebook ingi/inginious-c-notebook
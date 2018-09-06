#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "building grading containers"
echo "building base container"

[[ "$(docker images -q ingi/inginious-c-base 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-base
echo "building default container"
[[ "$(docker images -q ingi/inginious-c-default 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-default
echo "building multilang container"
[[ "$(docker images -q ingi/inginious-c-multilang 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-multilang
docker tag unjudge/inginious-c-base ingi/inginious-c-base
docker tag unjudge/inginious-c-default ingi/inginious-c-default
docker tag unjudge/inginious-c-multilang ingi/inginious-c-multilang
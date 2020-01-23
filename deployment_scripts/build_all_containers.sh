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
echo "building uncode base container"
[[ "$(docker images -q unjudge/uncode-c-base 2> /dev/null)" == "" ]] && docker pull unjudge/uncode-c-base
echo "building multilang container"
[[ "$(docker images -q ingi/inginious-c-multilang 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-multilang
echo "building hdl container"
[[ "$(docker images -q ingi/hdl-uncode 2> /dev/null)" == "" ]] && docker pull unjudge/hdl-uncode
echo "building notebook container"
[[ "$(docker images -q ingi/inginious-c-notebook 2> /dev/null)" == "" ]] && docker pull unjudge/inginious-c-notebook
docker tag unjudge/inginious-c-base ingi/inginious-c-base
docker tag unjudge/inginious-c-default ingi/inginious-c-default
docker tag unjudge/inginious-c-multilang ingi/inginious-c-multilang
docker tag unjudge/hdl-uncode ingi/hdl-uncode
docker tag unjudge/inginious-c-notebook ingi/inginious-c-notebook
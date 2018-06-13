#!/bin/bash

function build_grading_containers {
    echo "building grading containers"
    echo "building base container"
    
    git pull --depth 1 https://github.com/JuezUN/INGInious.git
    git pull --depth 1 https://github.com/JuezUN/INGInious-containers.git
    [[ "$(docker images -q ingi/inginious-c-base 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-base ./INGInious/base-containers/base
    echo "building default container"
    [[ "$(docker images -q ingi/inginious-c-default 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-default ./INGInious/base-containers/default/
    echo "building multilang container"
    [[ "$(docker images -q ingi/inginious-c-multilang 2> /dev/null)" == "" ]] && docker build -t ingi/inginious-c-multilang ./INGInious-containers/grading/multilang
}
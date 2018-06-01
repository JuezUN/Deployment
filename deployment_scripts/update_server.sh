#!/bin/bash

#update server with latest version of UNcode's INGInious, a branch can also be specified to the script via the -b tag

BRANCH=""
while getopts "b:" opt; do
    case $opt in
        b)
            BRANCH = $OPTARG
            ;;
        :)
            echo "Option -$OPTARG requires an argument" >&2
            exit 1
            ;;
        \?)
            echo "Invalid option -$OPTARG" >&2
            exit 1	       
            ;;
    esac
done

if [ -n $BRANCH ]
then
    exists_branch=git ls-remote --heads git@github.com:user/repo.git $BRANCH | wc -l
    if [ !exists_branch ]
    then
        sudo -H pip3.5 install --upgrade "git+https://github.com/JuezUN/INGInious.git@$BRANCH"
    else
        echo "branch $BRANCH does not exists in JueUN/INGINIOUS"
        exit 1
    fi
else
    sudo -H pip3.5 install --upgrade git+https://github.com/JuezUN/INGInious.git
fi

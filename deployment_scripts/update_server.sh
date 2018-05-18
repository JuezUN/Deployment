#!/bin/bash

#update server with latest version of UNcode's INGInious, a branch can also be specified to the script via the -b tag

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

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
    sudo pip3.5 install --upgrade "git+https://github.com/JuezUN/INGInious.git@$BRANCH"
else
    sudo pip3.5 install --upgrade git+https://github.com/JuezUN/INGInious.git
fi

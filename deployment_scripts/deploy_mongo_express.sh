#!/bin/bash

username=""
password=""

while [[ -z "$username" && -z "$password" ]]
do
    read -p 'Mongo Express Username: ' username
    read -sp 'Mongo Express Password: ' password
done

printf "\nUsed username: $username\n"

docker run -it --rm --network host --name uncode_mongo_express -p 8081:8081 -e ME_CONFIG_OPTIONS_EDITORTHEME="ambiance" \
    -e ME_CONFIG_MONGODB_SERVER="web_db_1" -e ME_CONFIG_BASICAUTH_USERNAME="$username" -e ME_CONFIG_MONGODB_PORT=27017 \
    -e ME_CONFIG_MONGODB_SERVER=localhost -e ME_CONFIG_BASICAUTH_PASSWORD="$password" -d mongo-express
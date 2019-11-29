#!/bin/bash

echo "Setting up metabse"

mkdir ~/metabase.db
cd ../config/metabase
cp *.db ~/metabase.db/
docker-compose up -d

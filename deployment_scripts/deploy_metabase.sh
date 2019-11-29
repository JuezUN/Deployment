#!/bin/bash

echo "Setting up metabse"

mkdir ~/metabase.db
cp config/metabase/*.db ~/metabase.db/
docker-compose -f config/metabase/docker-compose.yml up -d

#!/bin/bash

echo "Setting up metabse"

rm -rf ~/metabase.db
mkdir ~/metabase.db
cp config/metabase/*.db ~/metabase.db/
docker-compose -f config/metabase/docker-compose.yml up -d

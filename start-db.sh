#!/bin/sh

container_id=$(docker ps -a | grep "couchdb-for-ols" | awk '{print $1}')

if [ -z $container_id ]; then echo "The container does not exist, try lauch 'setup.sh'"; exit 1; fi

docker container start $container_id 
echo "couchdb launched"

#! /usr/bin/bash

container_id=$(docker ps | grep "couchdb-for-ols" | awk '{print $1}')

if [ -z $container_id ]; then echo "container not running"; exit 1; fi

docker container stop $container_id
echo "couchdb stopped"

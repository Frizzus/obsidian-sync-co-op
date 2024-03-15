#! /usr/bin/sh

container_id=$(docker ps | grep "couchdb-for-ols" | awk '{print $1}')

docker container stop $container_id
docker container rm $container_id

echo "volumes are not deleted ! (./couchdb-etc/ ; ./couchdb-data/)"

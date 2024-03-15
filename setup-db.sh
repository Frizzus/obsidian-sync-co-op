!/bin/bash

if [ -z $(docker image ls | grep "couchdb") ]; then
    docker pull couchdb
fi

export hostname=localhost:5984
export username=username
export password=password

container_id=$(docker ps | grep "couchdb-for-ols" | awk '{print $1}')

#echo $container_id
#echo $ols_network

if [ ! -d './couchdb-etc/' ] && [ ! -d './couchdb-data/' ]; then
    mkdir couchdb-data
    mkdir couchdb-etc
else
    echo "folder already created"
fi

if [ -z "$container_id" ]; then
    container_id=$(docker run --name couchdb-for-ols \
                                -d \
                                --restart always \
                                -e COUCHDB_USER=$username \
                                -e COUCHDB_PASSWORD=$password \
                                -v ${PWD}/couchdb-data:/opt/couchdb/data \
                                -v ${PWD}/couchdb-etc:/opt/couchdb/etc/local.d \
                                -p 5984:5984 \
                                --network host \
                                couchdb)
fi

if [ -z "$hostname" ]; then
    echo "ERROR: Hostname missing"
    exit 1
fi
if [ -z "$username" ]; then
    echo "ERROR: Username missing"
    exit 1
fi

if [ -z "$password" ]; then
    echo "ERROR: Password missing"
    exit 1
fi

echo "-- Configuring CouchDB by REST APIs... -->"

until (curl -X POST "${hostname}/_cluster_setup" -H "Content-Type: application/json" -d "{\"action\":\"enable_single_node\",\"username\":\"${username}\",\"password\":\"${password}\",\"bind_address\":\"0.0.0.0\",\"port\":5984,\"singlenode\":true}" --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/chttpd/require_valid_user" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/chttpd_auth/require_valid_user" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/httpd/WWW-Authenticate" -H "Content-Type: application/json" -d '"Basic realm=\"couchdb\""' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/httpd/enable_cors" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/chttpd/enable_cors" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/chttpd/max_http_request_size" -H "Content-Type: application/json" -d '"4294967296"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/couchdb/max_document_size" -H "Content-Type: application/json" -d '"50000000"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/cors/credentials" -H "Content-Type: application/json" -d '"true"' --user "${username}:${password}"); do sleep 5; done
until (curl -X PUT "${hostname}/_node/nonode@nohost/_config/cors/origins" -H "Content-Type: application/json" -d '"app://obsidian.md,capacitor://localhost,http://localhost"' --user "${username}:${password}"); do sleep 5; done

echo "<-- Configuring CouchDB by REST APIs Done!"

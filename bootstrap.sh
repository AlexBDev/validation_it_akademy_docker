#!/usr/bin/env bash

confirm()
{
    read -r -p "${1} [y/N] " response

    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

ORIGIN_DIR=$(pwd)
NGINX_DIR=dockerfiles/nginx
CONTAINER_RANCHER_ID="rancher_toy"

cd ${NGINX_DIR}
docker build -t my_nginx .

cd ${ORIGIN_DIR}

docker pull rancher/server:stable
docker run -d --name ${CONTAINER_RANCHER_ID} --restart=unless-stopped -p 8080:8080 rancher/server:stable

IP_RANCHER=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${CONTAINER_RANCHER_ID})

echo "Rancher IP ${IP_RANCHER}"
echo "Rancher link http://${IP_RANCHER}:8080 (You need to wait for the complete boot up)"

echo "Then go to 'Infrastructure->Host' click on save then add a new host copy and paste the command in section 5
WITHOUT sudo"

if ! confirm "All the containers of rancher are up ?"; then
        exit 0
fi

echo "OK !"
echo "Go to API KEY then Advanced options click on 'Add Environment API Keys' complete the command"

printf "Enter the ACCESS_KEY : "
read API_ACCESS_KEY

printf "Enter the SECRET_KEY : "
read API_SECRET_KEY

./rancher-compose --url http://${IP_RANCHER}:8080 --access-key ${API_ACCESS_KEY} --secret-key ${API_SECRET_KEY} up -d
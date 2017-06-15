# Validation Docker IT-Akademy



### Pre required
- docker >= 17.03.1-ce
- docker-compose >= 1.13.0

## Setup

During the setup make sure the containers boot up correctly on

### Auto 

Run `$ ./bootstrap.sh`

### Manually

Rancher need to use AWS services or http link to build image in docker-compose.yml, this is why we need to create nginx 
image firstly.

Go to dockerfiles/nginx directory and build the nginx image as follow
`$ docker build -t my_nginx .`

`$ docker run -d --name rancher_toy --restart=unless-stopped -p 8080:8080 rancher/server:stable`

You need to get the ip of this container.

`$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' rancher_toy`

The go to http://IP_ADDRESS:8080/ the setup of rancher take long check the progress with :

`$ docker logs -f rancher_toy`

Then go to "Infrastructure->Host" click on save then add a new host copy and paste the command in section 5 WITHOUT 
sudo in your terminal.
Go to API KEY then Advanced options click on "Add Environment API Keys" complete the command

`./rancher-compose --url http://ADDRESS_IP:8080 --access-key <username_of_environment_api_key> --secret-key 
<password_of_environment_api_key> up -d`

Wait for bootstrap of containers an go to http://localhost

## Reminder

Web : http://localhost
phpmyadmin : http://localhost:8888

MySQL :

user : root
password : root

user : user_1
password : user_1

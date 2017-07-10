echo Current directory is...
echo $(pwd)

# Stop running containers and then remove them
if [ "$(docker ps -aq)" ]; then
    docker kill $(docker ps -aq)
    docker rm -f $(docker ps -aq)
fi

# Remove all images
if [ "$(docker images -aq)" ]; then
    docker rmi -f $(docker images -aq)
fi

#Load images copied over from CodeDeploy
cd PetClinic/images
docker load --input tracing-server.tar
docker load --input admin-server.tar
docker load --input customers-service.tar
docker load --input vets-service.tar
docker load --input visits-service.tar
docker load --input config-server.tar
docker load --input discovery-server.tar
docker load --input api-gateway.tar

# Start everything
/usr/local/bin/docker-compose up -d

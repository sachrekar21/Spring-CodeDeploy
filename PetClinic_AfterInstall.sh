# Make sure the Region is properly set up
#echo export AWS_REGION="" >> /etc/profile
#aws configure --region us-east1

#De-register this instance with load balancer
#aws elb deregister-instances-from-load-balancer --load-balancer-name LB-QA-PetClinic --instances $(curl http://169.254.169.254/latest/meta-data/instance-id)

echo printing results of pwd
echo $(pwd)
cd /root/images
echo printing results of pwd
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
docker load --input tracing-server
docker load --input admin-server
docker load --input customers-service
docker load --input vets-service
docker load --input visits-service
docker load --input config-server
docker load --input discovery-server
docker load --input api-gateway

# Start everything
docker-compose up

#Re-register this instance with load balancer
#aws elb register-instances-with-load-balancer --load-balancer-name LB-QA-PetClinic --instances $(curl http://169.254.169.254/latest/meta-data/instance-id)

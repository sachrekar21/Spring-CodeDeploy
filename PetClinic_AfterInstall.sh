# Make sure the Region is properly set up
#echo export AWS_REGION="" >> /etc/profile
#aws configure --region us-east1

#De-register this instance with load balancer
#aws elb deregister-instances-from-load-balancer --load-balancer-name LB-QA-PetClinic --instances $(curl http://169.254.169.254/latest/meta-data/instance-id)

# Stop running containers
#docker kill $(docker ps -aq)

# Remove all containers
#docker rm -f $(docker ps -aq)

# Remove all images
#docker rmi -f  $(docker images -aq)

#Load images copied over from CodeDeploy
docker load --input tracing-server.tar
docker load --input admin-server.tar
docker load --input customers-service.tar
docker load --input vets-service.tar
docker load --input visits-service.tar
docker load --input config-server.tar
docker load --input discovery-server.tar
docker load --input api-gateway.tar

# Start everything
docker-compose up

#Re-register this instance with load balancer
#aws elb register-instances-with-load-balancer --load-balancer-name LB-QA-PetClinic --instances $(curl http://169.254.169.254/latest/meta-data/instance-id)

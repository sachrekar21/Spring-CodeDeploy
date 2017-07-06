# Make sure the Region is properly set up
#echo export AWS_REGION="" >> /etc/profile
#aws configure --region us-east1

#De-register this instance with load balancer
#aws elb deregister-instances-from-load-balancer --load-balancer-name LB-QA-PetClinic --instances $(curl http://169.254.169.254/latest/meta-data/instance-id)

# Stop running containers
docker kill $(docker ps -aq)

# Remove all containers
docker rm -f $(docker ps -aq)

# Remove all images
docker rmi -f  $(docker images -aq)

#Load images copied over from CodeDeploy
docker load tracing-server
docker load admin-server
docker load customers-service
docker load vets-service
docker load visits-service
docker load config-server
docker load discovery-server
docker load api-gateway

# Start everything
docker-compose up

#Re-register this instance with load balancer
#aws elb register-instances-with-load-balancer --load-balancer-name LB-QA-PetClinic --instances $(curl http://169.254.169.254/latest/meta-data/instance-id)

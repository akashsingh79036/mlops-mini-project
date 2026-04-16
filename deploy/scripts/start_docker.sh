#!/bin/bash
#Login to AWS ECR
#Authenticate Docker to the AWS ECR registry
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 905418184838.dkr.ecr.ap-south-1.amazonaws.com

#Pull the latest docker image from your ECR repository
docker pull 905418184838.dkr.ecr.ap-south-1.amazonaws.com/supi_ecr:v3

#Stop the old container (if any)
sudo docker stop campusx-app || true
sudo docker rm campusx-app || true

#Run the new Docker container
docker run -d -p 80:5000 -e DAGSHUB_PAT=9518fe2b397bdeb827e49cb35501b5bb91448d8a --name campusx-app 905418184838.dkr.ecr.ap-south-1.amazonaws.com/supi_ecr:v3
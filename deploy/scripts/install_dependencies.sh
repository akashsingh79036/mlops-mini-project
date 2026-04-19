#!/bin/bash

#Ensure the script runs in non-interactive mode
export DEBIAN_FRONTEND=noninteractive

#Update the package list
sudo apt-get update -y

#install docker
sudo apt-get install -y docker.io

#start and enable docker service
sudo systemctl start docker
sudo systemctl enable docker

#install necessary utilities
sudo apt-get install -y unzip curl

#Download and install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/home/ubuntu/awscliv2.zip"
unzip -o /home/ubuntu/awscliv2.zip -d /home/ubuntu/
sudo /home/ubuntu/aws/install

sudo usermod -aG docker ubuntu
sudo chmod +x deploy/scripts/install_dependencies.sh

#clean up the AWS CLI installation files
rm -rf /home/ubuntu/awscliv2.zip /home/ubuntu/aws

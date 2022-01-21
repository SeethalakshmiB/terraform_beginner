#!/bin/bash
sudo yum install -y yum-utils 

sudo yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo 

sudo yum install docker-ce docker-ce-cli containerd.io -y

sudo systemctl start docker

# status=`sudo systemctl status docker | awk 'NR==3 {print $2}'`
# echo -e "Docker Daemon Status: \e[0;32m$status\e[0;m"


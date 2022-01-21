#!/bin/bash

sudo su

dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y


yum install java-11-openjdk-devel wget -y

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key


yum install jenkins -y

systemctl start jenkins


sudo yum install -y yum-utils 

sudo yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo 

sudo yum install docker-ce docker-ce-cli containerd.io -y

sudo systemctl start docker

# systemctl status jenkins

# cat /var/lib/jenkins/secrets/initialAdminPassword

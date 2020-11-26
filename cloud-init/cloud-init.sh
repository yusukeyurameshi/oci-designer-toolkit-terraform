#!/bin/bash

systemctl stop firewalld
systemctl disable firewalld

echo "nameserver 8.8.8.8">>/etc/resolv.conf

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io docker-compose
systemctl start docker
systemctl enable docker

yum install -y git

git clone https://github.com/oracle/oci-designer-toolkit.git


cd oci-designer-toolkit/containers/docker
docker-compose up

cd ../../
docker build --tag okit --file ./containers/docker/Dockerfile --force-rm ..


docker run -d --rm -p 443:443 -p 80:80 --name okit --hostname okit okit

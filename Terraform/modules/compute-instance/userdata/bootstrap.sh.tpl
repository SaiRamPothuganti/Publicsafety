#!/bin/bash
yum update -y;
yum install -y yum-utils \
device-mapper-persistent-data \
lvm2

yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io

set -o vi

mkdir -p /etc/systemd/system/docker.service.d

(
echo [service]
echo Environment="HTTP_PROXY=http://www-proxy-hqdc.us.oracle.com:80/"
echo Environment="http_proxy=http://www-proxy-hqdc.us.oracle.com:80"
echo Environment="HTTPS_PROXY=http://www-proxy-hqdc.us.oracle.com:80"
echo Environment="https_proxy=http://www-proxy-hqdc.us.oracle.com:80/"
echo Environment="NO_PROXY=localhost,oraclecorp.com"
)> /etc/systemd/system/docker.service.d/http-proxy.conf
pause

(
echo [Service]
echo ExecStart=
echo EnvironmentFile=-/etc/sysconfig/docker
echo EnvironmentFile=-/etc/sysconfig/docker-storage
echo EnvironmentFile=-/etc/sysconfig/docker-network
echo ExecStart=/usr/bin/dockerd -H unix:///var/run/docker.sock -H tcp://0.0.0.0:2375 --insecure-registry=oaa-dev-local.dockerhub-den.oraclecorp.com
)> /etc/systemd/system/docker.service.d/docker-sysconfig.conf
pause

systemctl start docker
docker pull oaa-dev-local.dockerhub-den.oraclecorp.com/cognitive-image-service:0.9.0
docker run -p 9090:80 -it oaa-dev-local.dockerhub-den.oraclecorp.com/cognitive-image-service:0.9.0

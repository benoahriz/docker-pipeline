#!/bin/bash
# This script will install the docker binaries for working on OSX as well
# as creating a docker machine and importing the tar docker image
# Author Benjamin Rizkowsky benoahriz@gmail.com 

echo "version of docker-machine should be at least version 0.3.1-rc1 (993f2db)"
# curl -L "https://github.com/docker/machine/releases/download/v0.3.1-rc1/docker-machine_darwin-amd64" > /usr/local/bin/docker-machine

cat osx/docker-machine_darwin-amd64 > /usr/local/bin/docker-machine

echo "making docker-machine executable"
chmod +x /usr/local/bin/docker-machine

echo "check the version of docker-machine"
docker-machine -v 

echo "install the latest docker client binary for osx Docker version 1.7.1, build 786b29d"
# curl -L "https://get.docker.com/builds/Darwin/x86_64/docker-latest" > /usr/local/bin/docker
cat osx/docker-latest > /usr/local/bin/docker

echo "making docker executable"
chmod +x /usr/local/bin/docker
docker -v

echo "install the latest docker-compose binary"
# curl -L "https://github.com/docker/compose/releases/download/1.3.3/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose
cat osx/docker-compose-Darwin-x86_64 > /usr/local/bin/docker-compose

echo "making docker-compose executable"
chmod +x /usr/local/bin/docker-compose
docker-compose -v

echo "create a docker machine for the pipeline"
echo "you need to have at least 4096mb of ram available for your vm"

VIRTUALBOX_BOOT2DOCKER_URL=file:///$(pwd)/boot2docker.iso
export VIRTUALBOX_BOOT2DOCKER_URL
echo "VIRTUALBOX_BOOT2DOCKER_URL = ${VIRTUALBOX_BOOT2DOCKER_URL}"

VIRTUALBOX_MEMORY_SIZE="4096"
export VIRTUALBOX_MEMORY_SIZE
echo "VIRTUALBOX_MEMORY_SIZE = ${VIRTUALBOX_MEMORY_SIZE}"


docker-machine create -d virtualbox pipelinebythebay
echo "execute this after you run the script as well since it won't stay in your shell with this script."
echo "# eval \$(docker-machine env pipelinebythebay)"

eval $(docker-machine env pipelinebythebay)

# echo "check if you have the docker container already docker images |grep 8a642f29fd93"
echo "docker load < pipelinebythebay.tar" 
docker load < pipelinebythebay.tar
docker images

echo "If you need to delete your existing docker machine"
echo "docker-machine stop pipelinebythebay"
echo "docker-machine rm pipelinebythebay"


echo "Virtualbox version is $(vboxmanage --version)"
echo "if you are having problems with virtualbox you may need to uninstall or upgrade."
echo "/Volumes/KINGSTON/VirtualBox_Uninstall.tool.sh"
docker-machine env pipelinebythebay

echo "to run this image type the following"
echo "docker run -it 0875d176e1c6 /bin/bash"


docker-machine ls

echo "the ip address of your virtual machine is $(docker-machine ip pipelinebythebay)"



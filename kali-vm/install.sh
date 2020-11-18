#!/bin/bash

# Script should successfully run on Kali Linux 2020.3.0
# Installs: docker, docker-compose, Merlin Server (which includes agents)

MERLIN_BASE_VERSION=v0.9.1-beta
MERLIN_HOST_DIR="${HOME}/merlin"

# Install Docker and misc dependencies
# Docker isn't mandatory for traditional Merlin usage
sudo apt-get update &&\
    sudo apt-get install -y docker.io\
        wget\
        p7zip-full &&\
    sudo usermod -aG docker $USER || exit

# Set virtual memory for Elasticsearch container (used by Wazuh)
sudo sysctl -w vm.max_map_count=262144

# Install docker-compose
# docker-compose isn't mandatory for traditional Merlin usage
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&\
    sudo chmod +x /usr/local/bin/docker-compose || exit

# Install Merlin Server
# Inspired by: https://merlin-c2.readthedocs.io/en/v0.9.0-beta/quickStart/server.html
MERLIN_FILE_NAME=merlinServer-Linux-x64.7z
mkdir -p "${MERLIN_HOST_DIR}" &&\
    cd "${MERLIN_HOST_DIR}" &&\
    wget "https://github.com/Ne0nd0g/merlin/releases/download/${MERLIN_BASE_VERSION}/${MERLIN_FILE_NAME}" &&\
    7za x -pmerlin "${MERLIN_FILE_NAME}" &&\
    rm -rf "${MERLIN_FILE_NAME}" || exit

echo "-------------------------------------------------------------------------------------"
echo "DONE INSTALLING!"
echo "Merlin Linux Server is at path ${MERLIN_HOST_DIR}/merlinServer-Linux-x64"
echo "Merlin Linux Agent is at path ${MERLIN_HOST_DIR}/data/bin/linux/merlinAgent-Linux-x64"
echo "-------------------------------------------------------------------------------------"

#!/bin/bash

echo "Creating Parent Directory for Docker APT Registry Signing Key..."
mkdir -p $(dirname "${DOCKER_GPG_PATH}")

echo "Downloading Docker APT Registry Signing Key..."
curl -fssSL "${DOCKER_GPG_DOWNLOAD_URL}" -o "${DOCKER_GPG_PATH}"

echo "Granting Universal Read Access to Docker GPG Signing Key..."
chmod a+r "${DOCKER_GPG_PATH}"

echo "Retrieving Operating System (OS) Architecture Name..."
architecture=$(dpkg --print-architecture)

echo "Retrieving Operating System (OS) Version Code Name..."
version=$(. /etc/os-release && echo "${VERSION_CODENAME}")

echo "Creating Docker APT Registry Description..."
info="deb [arch=${architecture} signed-by=${DOCKER_GPG_PATH}] ${DOCKER_APT_REPO_URL} ${version} stable"

echo "Adding Docker APT Registry Entry to APT Source List..."
echo $info > /etc/apt/sources.list.d/docker.list

echo "Updating Advanced Packaging Tool (APT) Cache..."
apt-get update

echo "Installing Required Docker Operating System (OS) Packages..."
apt-get install -y docker-buildx-plugin docker-ce-cli

echo "Removing Local APT Cache Files..."
rm -rf /var/lib/apt/lists/*

echo "Validating Docker CE CLI Installation..."
docker --version

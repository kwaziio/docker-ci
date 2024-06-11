#!/bin/bash

echo "Creating Parent Directory for HashiCorp APT Registry Signing Key..."
mkdir -p $(dirname "${HASHICORP_GPG_PATH}")

echo "Downloading HashiCorp APT Registry Signing Key..."
curl -fssSL "${HASHICORP_GPG_DOWNLOAD_URL}" -o "${HASHICORP_GPG_PATH}"

echo "Granting Universal Read Access to HashiCorp GPG Signing Key..."
chmod a+r "${HASHICORP_GPG_PATH}"

echo "Retrieving Operating System (OS) Architecture Name..."
architecture=$(dpkg --print-architecture)

echo "Retrieving Operating System (OS) Version Code Name..."
version=$(. /etc/os-release && echo "${VERSION_CODENAME}")

echo "Adding HashiCorp APT Repository to APT Repository List..."
info="deb [arch=${architecture} signed-by=${HASHICORP_GPG_PATH}] ${HASHICORP_APT_REPO_URL} ${version} main"

echo "Adding HashiCorp APT Registry Entry to APT Source List..."
echo $info > /etc/apt/sources.list.d/hashicorp.list

echo "Updating Advanced Packaging Tool (APT) Cache..."
apt-get update

echo "Installing Required HashiCorp Operating System (OS) Packages..."
apt-get install -y packer terraform

echo "Removing Local APT Cache Files..."
rm -rf /var/lib/apt/lists/*

echo "Validating HashiCorp Packer CLI Installation..."
packer --version

echo "Validating HashiCorp Terraform CLI Installation..."
terraform --version

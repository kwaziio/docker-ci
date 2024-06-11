#!/bin/bash

echo "Retrieving Latest Helm CLI Stable Release Version..."
version=$(curl -L -s "${HELM_VERSION_URL}" | jq -r '.[0].name')

echo "Retrieving Operating System (OS) Architecture Name..."
architecture=$(dpkg --print-architecture)

echo "Generating Helm CLI Download URL..."
downloadURL=$(echo "${HELM_DOWNLOAD_URL}" | sed s/VERSION/${version}/ | sed s/ARCHITECTURE/${architecture}/)

echo "Downloading Helm CLI..."
curl -L "${downloadURL}" > /tmp/helm.tar.gz

echo "Generating Helm CLI Checksum URL..."
checkumURL=$(echo "${HELM_SUM_URL}" | sed s/VERSION/${version}/ | sed s/ARCHITECTURE/${architecture}/)

echo "Downloading Helm CLI Checksum..."
curl -L "${checkumURL}" > /tmp/helm.tar.gz.sha256

echo "Validating Downloaded CLI Against Downloaded SHA-256 Checksum..."
echo "$(cat /tmp/helm.tar.gz.sha256 | awk '{print $1}') /tmp/helm.tar.gz" | sha256sum --check

echo "Creating Installation Directory for Helm CLI..."
mkdir -p "${HELM_CLI_INSTALL_DIR}"

echo "Extracting Helm CLI Archive..."
tar -C "${HELM_CLI_INSTALL_DIR}" -zxvf /tmp/helm.tar.gz

echo "Creating Symbolic Link for Helm CLI Binary..."
ln -s "${HELM_CLI_INSTALL_DIR}/linux-${architecture}/helm" /usr/sbin/helm

echo "Validating Helm CLI Installation..."
helm version

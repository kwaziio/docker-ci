#!/bin/bash

echo "Retrieving Latest Kubernetes CLI Stable Release Version..."
version=$(curl -L -s "${KUBECTL_VERSION_URL}")

echo "Generating Kubernetes CLI Download URL..."
downloadURL=$(echo "${KUBECTL_DOWNLOAD_URL}" | sed s/VERSION/${version}/)

echo "Downloading Kubernetes CLI..."
curl -L "${downloadURL}" > /tmp/kubectl

echo "Generating Kubernetes CLI Checksum URL..."
checkumURL=$(echo "${KUBECTL_SUM_URL}" | sed s/VERSION/${version}/)

echo "Downloading Kuberntes CLI Checksum..."
curl -L "${checkumURL}" > /tmp/kubectl.sha256

echo "Validating Downloaded CLI Against Downloaded SHA-256 Checksum..."
echo "$(cat /tmp/kubectl.sha256) /tmp/kubectl" | sha256sum --check

echo "Moving Kubernetes CLI (kubectl) to Binary Directory..."
mv /tmp/kubectl /usr/bin/kubectl

echo "Updating File Permissions for Kubernetes CLI (kubectl) Binary..."
chmod +x /usr/bin/kubectl

echo "Removing Temporary Installation Artifacts..."
rm -rf /tmp/kubectl.sha256

echo "Validating Kubernetes CLI Installation..."
kubectl version --client=true

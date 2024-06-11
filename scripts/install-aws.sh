#!/bin/bash

echo "Downloading Official Amazon Web Services (AWS) CLI Installer..."
curl "${AWS_CLI_DOWNLOAD_URL}" > /tmp/aws-cli-installer.zip

echo "Creating Installation Directory for Official AWS CLI Installer..."
mkdir -p "${AWS_CLI_INSTALL_DIR}"

echo "Extracting Official AWS CLI Installer"
unzip /tmp/aws-cli-installer.zip -d /tmp/

echo "Installing AWS CLI via Official AWS CLI Installer..."
/tmp/aws/install -i "${AWS_CLI_INSTALL_DIR}"

echo "Removing Temporary Installation Artifacts..."
rm -rf /tmp/aws /tmp/aws-cli-installer.zip

echo "Validating AWS CLI Installation..."
aws --version

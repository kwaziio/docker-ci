# Docker Image for CI/CD

This project manages the creation of a Docker Image designed to support some of our most common automated Continuous Integration (CI) and Continuous Deliver (CD) processes. It is created and maintained by [KWAZI](https://kwazi.io).

## Getting Started

Before getting started, you'll need to have the following software installed:

Requirement | Version | Notes
--- | --- | ---
Docker Engine | 24.0.6+ | Container Runtime Engine (w/ CLI)

### Building w/ Image Defaults

This project is designed to work with Ubuntu. The default values for this project will create an image that utilizes our pre-hardened Ubuntu base image. To build this image using default values, execute the following command:

```BASH
docker build -t ci:latest .
```

*NOTE: For more information about the default base image used by this project, see [our official GitHub repository](https://github.com/kwaziio/docker-ubuntu).*

## Supported Software

This Docker Image was designed to support some of our most common CI/CD tasks. It includes pre-configured support for the following open-source software (OSS):

Name | Command | Description
--- | ---
Ansible | `ansible` | Configuration-as-Code Tool Powered by Python
AWS CLI v2 | `aws` | CLI Required for Most AWS API Interactions
Docker BuildKit | `docker buildx` | Docker BuildKit Plugin for Docker CE CLI
Docker CE CLI | `docker` | Docker Container Engine CLI (Community Edition)
HashiCorp Packer | `packer` | Image Creation Automation Tool by HashiCorp
HashiCorp Terraform | `terraform` | Infrastructure-as-Code (IaC) Tool by HashiCorp
Helm CLI | `helm` | Package Manager CLI for Kubernetes
Kubernetes CLI | `kubectl` | CLI Required for Kubernetes Interactions

*NOTE: Additional software may be available for use, but only the software above is officially supported by this project.*

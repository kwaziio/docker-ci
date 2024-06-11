######################################################
# Build-Time Arguments for the Docker Runtime Engine #
######################################################

ARG IMAGE=kwaziio/ubuntu
ARG TAG=latest

############################
# Ubuntu Base Docker Image #
############################

FROM ${IMAGE}:${TAG}

################################################
# Copies Configuration Scripts to Docker Image #
################################################

ARG SCRIPTS_DEST_DIR=/scripts
ENV SCRIPTS_DEST_DIR=${SCRIPTS_DEST_DIR}

ARG SCRIPTS_SRC_DIR=./scripts
ENV SCRIPTS_SRC_DIR=${SCRIPTS_SRC_DIR}

COPY ${SCRIPTS_SRC_DIR}/ ${SCRIPTS_DEST_DIR}/
RUN chmod +x ${SCRIPTS_DEST_DIR}/*

######################################################
# Disables Interactivity for the Image Build Process #
######################################################

ENV DEBIAN_FRONTEND=noninteractive

#######################################################
# Updates and Installs Operating System (OS) Packages #
#######################################################

RUN ${SCRIPTS_DEST_DIR}/install-packages.sh

###################################################################
# Installs Amazon Web Services (AWS) Command Line Interface (CLI) #
###################################################################

ARG AWS_CLI_DOWNLOAD_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
ENV AWS_CLI_DOWNLOAD_URL="${AWS_CLI_DOWNLOAD_URL}"

ARG AWS_CLI_INSTALL_DIR="/opt/aws"
ENV AWS_CLI_INSTALL_DIR="${AWS_CLI_INSTALL_DIR}"

RUN ${SCRIPTS_DEST_DIR}/install-aws.sh

#############################################################
# Installs Docker Engine via Official Docker APT Repository #
#############################################################

ARG DOCKER_GPG_DOWNLOAD_URL="https://download.docker.com/linux/ubuntu/gpg"
ENV DOCKER_GPG_DOWNLOAD_URL="${DOCKER_GPG_DOWNLOAD_URL}"

ARG DOCKER_GPG_PATH="/etc/apt/keyrings/docker.asc"
ENV DOCKER_GPG_PATH="${DOCKER_GPG_PATH}"

ARG DOCKER_APT_REPO_URL="https://download.docker.com/linux/ubuntu"
ENV DOCKER_APT_REPO_URL="${DOCKER_APT_REPO_URL}"

RUN ${SCRIPTS_DEST_DIR}/install-docker.sh

##################################################################
# Installs HashiCorp Tools via Official HashiCorp APT Repository #
##################################################################

ARG HASHICORP_GPG_DOWNLOAD_URL="https://apt.releases.hashicorp.com/gpg"
ENV HASHICORP_GPG_DOWNLOAD_URL="${HASHICORP_GPG_DOWNLOAD_URL}"

ARG HASHICORP_GPG_PATH="/etc/apt/keyrings/hashicorp.asc"
ENV HASHICORP_GPG_PATH="${HASHICORP_GPG_PATH}"

ARG HASHICORP_APT_REPO_URL="https://apt.releases.hashicorp.com"
ENV HASHICORP_APT_REPO_URL="${HASHICORP_APT_REPO_URL}"

RUN ${SCRIPTS_DEST_DIR}/install-hashicorp.sh

###########################################################
# Installs Kubernetes CLI (kubectl) via Official Releases #
###########################################################

ARG KUBECTL_VERSION_URL="https://cdn.dl.k8s.io/release/stable.txt"
ENV KUBECTL_VERSION_URL="${KUBECTL_VERSION_URL}"

ARG KUBECTL_DOWNLOAD_URL="https://dl.k8s.io/release/VERSION/bin/linux/amd64/kubectl"
ENV KUBECTL_DOWNLOAD_URL="${KUBECTL_DOWNLOAD_URL}"

ARG KUBECTL_SUM_URL="https://dl.k8s.io/release/VERSION/bin/linux/amd64/kubectl.sha256"
ENV KUBECTL_SUM_URL="${KUBECTL_SUM_URL}"

RUN ${SCRIPTS_DEST_DIR}/install-kubectl.sh

###########################################
# Installs Helm CLI via Official Releases #
###########################################

ARG HELM_VERSION_URL="https://api.github.com/repos/helm/helm/tags"
ENV HELM_VERSION_URL="${HELM_VERSION_URL}"

ARG HELM_DOWNLOAD_URL="https://get.helm.sh/helm-VERSION-linux-ARCHITECTURE.tar.gz"
ENV HELM_DOWNLOAD_URL="${HELM_DOWNLOAD_URL}"

ARG HELM_SUM_URL="https://get.helm.sh/helm-VERSION-linux-ARCHITECTURE.tar.gz.sha256sum"
ENV HELM_SUM_URL="${HELM_SUM_URL}"

ARG HELM_CLI_INSTALL_DIR="/opt/helm"
ENV HELM_CLI_INSTALL_DIR="${HELM_CLI_INSTALL_DIR}"

RUN ${SCRIPTS_DEST_DIR}/install-helm.sh

#######################################################
# Enables Interactivity for Debian Frontend Processes #
#######################################################

ENV DEBIAN_FRONTEND=

#!/bin/bash


sudo apt-get update
sudo apt-get install -y \
  git curl wget ca-certificates gnupg \
  unzip tar xz-utils \
  build-essential make \
  jq \
  openssh-client \
  iproute2 dnsutils net-tools

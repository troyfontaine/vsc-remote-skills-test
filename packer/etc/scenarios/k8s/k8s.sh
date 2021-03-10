#!/usr/bin/env bash

# Install k3s
curl -sfL https://get.k3s.io | sh -

# kubeconfig is located at /etc/rancher/k3s/k3s.yaml

# Create the documentation directory
sudo mkdir -p /var/www/html/docs
sudo chmod 755 /var/www/html -R
sudo mv /tmp/public /var/www/html/docs/public

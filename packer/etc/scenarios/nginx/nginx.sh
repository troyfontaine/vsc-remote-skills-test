#!/usr/bin/env bash
set -x

# Install nginx
sudo apt-get -y -qq install nginx net-tools

# Stop and disable nginx
sudo systemctl stop nginx
sudo systemctl disable nginx

# Create alternative root directory for Nginx to use
sudo mkdir -p /web/html/my-app-2/
sudo chown www-data:www-data /web/
sudo mv /tmp/default /etc/nginx/sites-available/default
sudo mv /tmp/index.nginx-debian.html /web/html/my-app-2/index.nginx-debian.html

# Create the documentation directory
sudo mkdir -p /var/www/html/docs
sudo mv /tmp/public /var/www/html/docs/public

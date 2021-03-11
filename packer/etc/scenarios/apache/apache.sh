#!/usr/bin/env bash
set -x

# We install both because problems!
sudo apt-get -y -qq install apache2 nginx

# Remove un-necessary files
sudo rm /var/www/html/*.html
sudo rm /etc/nginx/sites-available/*
sudo rm /etc/apache2/sites-available/*

# Move our new default page
sudo mv /tmp/index.htm /var/www/html/

# Move the Nginx Configuration
sudo mv /tmp/proxy.conf /etc/nginx/sites-available/

# Move the Apache Configuration
sudo mv /tmp/web-app.conf /etc/apache2/sites-available/

# Create the documentation directory
sudo mkdir -p /var/www/html/docs
sudo mv /tmp/public /var/www/html/docs/public

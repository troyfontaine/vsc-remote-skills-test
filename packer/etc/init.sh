#!/usr/bin/env bash
set -x

# Install necessary dependencies
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get update
sudo apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates net-tools

# Install the VSCode Server App
# https://github.com/cdr/code-server
curl -fsSL https://code-server.dev/install.sh | sudo sh
sudo systemctl enable --now code-server@$USER

# Install Caddy
sudo apt-get install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/cfg/gpg/gpg.155B6D79CA56EA34.key' | sudo apt-key add -
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/cfg/setup/config.deb.txt?distro=debian&version=any-version' | sudo tee -a /etc/apt/sources.list.d/caddy-stable.list
sudo apt-get update
sudo apt-get -y -qq install caddy

# Replace the domain_name in /tmp/Caddyfile
# This is required for Acme/Let's Encrypt to work as Caddy
# doesn't otherwise know what domain we're using
sudo sed -i "s/domain_name/${SUB_DOMAIN}${DOMAIN}/g" /tmp/Caddyfile

# Move the Caddy Config File
sudo mv /tmp/Caddyfile /etc/caddy/Caddyfile

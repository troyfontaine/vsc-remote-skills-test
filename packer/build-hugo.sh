#!/usr/bin/env bash

SCENARIO="$1"

# Change into the scenario directory
pushd ../docs/scenarios/"${SCENARIO}" || return

# Remove the static site files
rm -rf public;

# Replace the example URL in the Hugo config
sed -i "s/example.com/${SUB_DOMAIN}${DOMAIN}/g" config/_default/config.yaml

# Replace the example URL in the content
sed -i "s/example.com/${SUB_DOMAIN}${DOMAIN}/g" content/_index.md

# Rebuild the static site files
hugo --environment production

# Restore the example URL in the Hugo config
sed -i "s/${SUB_DOMAIN}${DOMAIN}/example.com/g" config/_default/config.yaml

# Restore the example URL in the content
sed -i "s/${SUB_DOMAIN}${DOMAIN}/example.com/g" content/_index.md

popd || return

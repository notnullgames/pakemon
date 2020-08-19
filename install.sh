#!/bin/bash

# This is the top-level installer for pakemon

echo "Installing dependencies"
sudo apt-get update
sudo apt-get install -y --no-install-recommends git love

if [ -d "/opt/pakemon" ]; then
    cd /opt/pakemon
    echo "Updating pakemon"
    sudo git pull
else
    echo "Installing pakemon"
    sudo git clone --depth 1 https://github.com/notnullgames/pakemon.git /opt/pakemon
fi

sudo ln -s /opt/pakemon/start.sh /usr/local/bin/pakemon

cd /opt/pakemon
for plugin in src/plugins/*/setup.sh; do
    $plugin
done
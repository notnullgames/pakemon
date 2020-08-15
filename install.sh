#!/bin/sh

# This is the top-level installer for pakemon

echo "Installing dependencies"
sudo apt-get install -y git libcurl4
sudo ln -s /usr/lib/x86_64-linux-gnu/libcurl.so.4 /usr/lib/x86_64-linux-gnu/libcurl.so

echo "Installing pakemon"
sudo git clone clone -–depth 1 https://github.com/notnullgames/pakemon.git /opt/pakemon

echo "Setting permissions to current user"
sudo chown -R $UID:$GID /opt/pakemon

# TOOD: loop through plugins and install them, too

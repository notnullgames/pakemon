#!/bin/bash

echo "Installing deps for the radio plugin"
sudo apt-get install -y --no-install-recommends librtlsdr-dev

# should we build a deb of this?
git clone --depth 1 https://github.com/antirez/dump1090.git /tmp/dump1090
cd /tmp/dump1090
make
sudo cp dump1090 /usr/bin

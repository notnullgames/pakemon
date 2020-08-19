#!/bin/bash

echo "Installing deps for the radio plugin"
sudo apt-get install -y --no-install-recommends librtlsdr-dev

git clone --depth 1 git://github.com/MalcolmRobb/dump1090.git /tmp/dump1090
cd /tmp/dump1090
make
sudo cp dump1090 /usr/bin
# notes on radio

We need a cross-device lightweight lib for processing radio signals.  I think soapysdr + luaradio will best fit these purposes, but I'm no expert.

## installation

```
# cross-device interface library
sudo apt install soapysdr0.7-module-all soapysdr-tools

# luaradio deps
sudo apt install luajit libluajit-5.1-dev pkg-config

# luaradio live deps
sudo apt install libliquid-dev libvolk2-dev libfftw3-dev

# build & install luaradio
cd /tmp
git clone https://github.com/vsergeev/luaradio.git
cd luaradio/embed
make lib
sudo make install
```

On pop 20.04, I used `libvolk2-dev` instead of `libvolk1-dev` recommended in docs, because volk1 wasn't available.

`soapysdr-tools` includes `SoapySDRUtil` which can help inspect what the library can support.

Need to make a an interface for outputting luaradio data to visually use in love2d.
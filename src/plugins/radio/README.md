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

Make sure to blacklist the rtl-sdr TV drivers, too:

```
echo "blacklist dvb_usb_rtl28xxu" | sudo tee >> /etc/modprobe.d/blacklist.conf
```

On pop 20.04, I used `libvolk2-dev` instead of `libvolk1-dev` recommended in docs, because volk1 wasn't available.

## usage notes

`soapysdr-tools` package includes `SoapySDRUtil` which can help inspect what the library can support.

Need to make a an interface for outputting luaradio data to visually use in love2d.

It'd be cool to rewrite any radio tools as luaradio pipes, that use soapysdr, and use that as a central way to work with radio. It would allow for the underlying hardware to be more diverse (like re-implement dump1090, so it works in any sdr, not just rtl-sdr.)

I've added some radio demos to this plugin dir that aren't meant to run in pakemon (yet) and they should all work with `luaradio`
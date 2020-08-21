# this tracks system deps for pakemon
# on real installs, all this will need to be insstalled+

FROM  kalilinux/kali-rolling
RUN apt-get update && apt-get install -y --no-install-recommends iproute2 bettercap nmap && rm -rf /var/lib/{apt,dpkg,cache,log}/
CMD /usr/bin/bettercap -no-colors -eval "set events.stream.output /var/log/bettercap.log; set api.rest.address 0.0.0.0; api.rest on"
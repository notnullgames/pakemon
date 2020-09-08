# Pakémon

Short for "packet monitor/monster". Gamified fun device/platform for hacking technology around you.

## installation

You will need to be on a debian-based system (raspbian, debian, ubuntu, pop, etc.)


```
wget https://raw.githubusercontent.com/notnullgames/pakemon/master/install.sh -O - | bash
```

## local dev

There is a Makefile included with a few targets for dev.

```
help                           show this help
run                            run pakemon & a demo network for attacking
clean                          delete all output files
build                          build .love file in dist/
```

While it's running, there is a web debugger [here](http://localhost:8000). There is also a docker-compose network you can explore (use `docker-compose exec pakemon bash` to get a nice console on the main entry-point machine.)
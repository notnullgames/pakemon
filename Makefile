NAME=yourgamenamehere
VERSION=11.3

.PHONY: help run clean

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## run the current project
	cd $(PWD)/src && love .

clean: ## delete all output files
	rm -rf dist

build: dist/$(NAME).love ## build .love file in dist/

dist/$(NAME).love: src/**/*.lua
	mkdir -p $(PWD)/dist
	cd src && zip -9 -r /tmp/$(NAME).zip .
	mv /tmp/$(NAME).zip $(PWD)/dist/$(NAME).love

# this is sort of specific to my setup
deploy: dist/$(NAME).love
	ssh pi@gameboy.local "killall -9 love || exit 0"
	scp dist/$(NAME).love pi@gameboy.local:/home/pi/RetroPie/roms/love/$(NAME).love
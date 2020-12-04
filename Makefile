NAME=pakemon

.PHONY: help run clean

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## run pakemon & a demo network for attacking
	docker-compose up -d && cd $(PWD)/src && LOVE_GRAPHICS_USE_OPENGLES=1 love .; docker-compose down

clean: ## delete all output files
	rm -rf dist

build: dist/$(NAME).love ## build .love file in dist/

dist/$(NAME).love: src/**/*.lua
	mkdir -p $(PWD)/dist
	cd src && zip -9 -r /tmp/$(NAME).zip .
	mv /tmp/$(NAME).zip $(PWD)/dist/$(NAME).love

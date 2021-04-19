.PHONY: help run setup back testnet interrogate stop linux windows mac web

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## Run pakemon frontend (requires love)
	LOVE_GRAPHICS_USE_OPENGLES=1 love src

setup: ## setup dev-tools for use in other targets
	pip3 install makelove

back: ## Just run backend
	docker-compose -f testnet/docker-compose.yml up pakemon

testnet: ## Run a testnet (complete with pakemon backend) for testing
	docker-compose -f testnet/docker-compose.yml up --scale haxor=0

interrogate: ## run kali tester inside the testnet to ionterrogate things
	docker-compose  -f testnet/docker-compose.yml run haxor bash

stop: ## Shutdown any docker services
	docker-compose -f testnet/docker-compose.yml down

deploy: web ## deploy web version to site
	cd dist/lovejs && unzip pakemon-lovejs.zip && cp ../../testnet/index.html pakemon && npx -y surge pakemon pakemon.surge.sh

linux: ## build a standalone appimage for linux
	cd src && makelove --config ../makelove.toml appimage

windows: ## build a standalone windows (64bit) app
	cd src && makelove --config ../makelove.toml win64

mac: ## build a standalone macos app
	cd src && makelove --config ../makelove.toml macos

web: ## build a standalone macos app
	cd src && makelove --config ../makelove.toml lovejs
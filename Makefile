.PHONY: help run back testnet interrogate stop

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## Run pakemon frontend (requires love)
	LOVE_GRAPHICS_USE_OPENGLES=1 love src

back: ## Just run backend
	docker-compose -f testnet/docker-compose.yml up pakemon

testnet: ## Run a testnet (complete with pakemon backend) for testing
	docker-compose -f testnet/docker-compose.yml up --scale haxor=0

interrogate: ## run kali tester inside the testnet to ionterrogate things
	docker-compose  -f testnet/docker-compose.yml run haxor bash

stop: ## Shutdown any docker services
	docker-compose -f testnet/docker-compose.yml down
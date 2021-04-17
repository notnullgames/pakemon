NAME=pakemon

.PHONY: help run testnet

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## Run pakemon frontend (requires love)
	love src

testnet: ## Run a testnet (complete with pakemon backend) for testing
	docker-compose -f testnet/docker-compose.yml up --scale haxor=0

interrogate: ## run kali tester inside the testnet to ionterrogate things
	docker-compose  -f testnet/docker-compose.yml run haxor bash
.PHONY: help run back testnet interrogate stop

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

run: ## Run pakemon frontend (requires love)
	love src

back: ## Just run backend
	docker-compose -f testnet/docker-compose.yml up \
	--scale haxor=0 --scale nowasp=0 --scale webgoat=0 --scale dvwa=0 \
	--scale securityshepherd=0 --scale vaas-cve-2014-0160=0 --scale cve-2017-7494=0 --scale vaas-cve-2014-6271=0

testnet: ## Run a testnet (complete with pakemon backend) for testing
	docker-compose -f testnet/docker-compose.yml up --scale haxor=0

interrogate: ## run kali tester inside the testnet to ionterrogate things
	docker-compose  -f testnet/docker-compose.yml run haxor bash

stop: ## Shutdown any docker services
	docker-compose -f testnet/docker-compose.yml down
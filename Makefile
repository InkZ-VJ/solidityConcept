.PHONY: truffle_compile,truffle_init

truffle_init:
	truffle init
truffle_compile:
	truffle compile

.PHONY: truffle_deploy 
truffle_deploy:
	truffle migrate --network development

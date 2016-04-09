BIN_DIR ?= node_modules/.bin
BUILD_DIR ?= build

WBP_LOADERS ?= --module-bind 'css=style-loader!css-loader' --module-bind html --module-bind json
WBP_PATH ?= --content-base example
WBP_PORT ?= --port 3000
WBP_FLAGS ?= --devtool cheap-module-eval-source-map --progress --hot --inline --output-public-path /
WBP_ENTRY ?= example/index.js

P="\\033[34m[+]\\033[0m"

start:
	@echo "  $(P) starting webpack-dev-server"
	@$(BIN_DIR)/webpack-dev-server $(WBP_ENTRY) $(WBP_LOADERS) $(WBP_PATH) $(WBP_FLAGS) $(WBP_PORT)

size:
	@$(BIN_DIR)/webpack $(WBP_LOADERS) $(WBP_ENTRY) bundle.js --json | webpack-bundle-size-analyzer
	@rm bundle.js

test:
	@chrome http://localhost:8080/bundle
	@$(BIN_DIR)/webpack-dev-server 'mocha!./test/test.js' $(WBP_LOADERS) ${WBP_FLAGS}

doc:
	@ghp-import example -n -p

.PHONY: start size test test-coveralls doc

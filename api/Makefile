PROTO_DIR := $(if  $(PROTO_DIR),$(PROTO_DIR),"../proto")
PROTO_FILES = $(shell find $(PROTO_DIR) -name "*.proto")
OUT_DIR := ./lib/protos

all: npm-install ts

npm-install:
	npm clean-install

ts: protos
	tsc --build

protos:
	export PATH=$(PATH):./node_modules/.bin; pbjs -t json-module -w commonjs -o $(OUT_DIR)/json-module.js $(PROTO_FILES) && \
		pbjs -t static-module $(PROTO_FILES) | pbts -o $(OUT_DIR)/root.d.ts -
	cp src/protos/root.js $(OUT_DIR)

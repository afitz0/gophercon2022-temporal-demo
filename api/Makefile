PROTO_DIR := ../proto
PROTO_FILES = $(shell find $(PROTO_DIR) -name "*.proto")
OUT_DIR := ./src/protos

all: npm-install ts

npm-install:
	npm install

ts: protos
	tsc --build

protos:
	export PATH=$(PATH):./node_modules/.bin; pbjs -t json-module -w commonjs -o $(OUT_DIR)/json-module.js $(PROTO_FILES) && \
		pbjs -t static-module $(PROTO_FILES) | pbts -o $(OUT_DIR)/root.d.ts -

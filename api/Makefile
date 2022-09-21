PROTO_DIR := ../proto
PROTO_FILES = $(shell find $(PROTO_DIR) -name "*.proto")
OUT_DIR := ./src/protos

ifeq (, $(shell which pbjs))
$(error "pbjs not found, required for this build")
endif

all: ts

ts: protos
	tsc --build

protos:
	pbjs -t json-module -w commonjs -o $(OUT_DIR)/json-module.js $(PROTO_FILES) && \
		pbjs -t static-module $(PROTO_FILES) | pbts -o $(OUT_DIR)/root.d.ts -

all: proto
proto: go-proto dart-proto ts-proto

PROTO_DIR := ./proto 
PROTO_FILES = $(shell find $(PROTO_DIR) -name "*.proto")

GO_OUT := temporal/api
DART_OUT := frontend/lib/gen

TS_DIR := ./api

go-proto:
	protoc --go_out $(GO_OUT) $(PROTO_FILES)

ts-proto:
	$(MAKE) -C $(TS_DIR) all

dart-proto:
	dart pub global activate protoc_plugin
	export PATH=$(HOME)/.pub-cache/bin:$(PATH); protoc --dart_out $(DART_OUT) $(PROTO_FILES)

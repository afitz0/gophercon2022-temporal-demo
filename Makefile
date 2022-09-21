proto: go-proto dart-proto ts-proto

PROTO_DIR := ./proto 
PROTO_FILES = $(shell find $(PROTO_DIR) -name "*.proto")

GO_OUT := temporal/api
DART_OUT := frontend/lib/gen

TS_PLUGIN := /Users/fitz/.nvm/versions/node/v16.16.0/bin/protoc-gen-ts_proto
TS_DIR := ./api
TS_OUT := $(TS_DIR)/gen

go-proto:
	protoc --go_out $(GO_OUT) $(PROTO_FILES)

ts-proto:
	protoc --plugin=$(TS_PLUGIN) --ts_proto_out=$(TS_OUT) $(PROTO_FILES)

dart-proto:
	protoc --dart_out $(DART_OUT) $(PROTO_FILES)

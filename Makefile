proto: go-proto dart-proto ts-proto

PROTO_DIR := ./proto 
PROTO_FILES = $(shell find $(PROTO_DIR) -name "*.proto")

GO_OUT := temporal/api
DART_OUT := frontend/lib/gen

TS_DIR := ./api
TS_PLUGIN := $(TS_DIR)/node_modules/.bin/protoc-gen-ts_proto
TS_OUT := $(TS_DIR)/gen


go-proto:
	protoc --go_out $(GO_OUT) $(PROTO_FILES)

ts-proto:
	protoc --plugin=$(TS_PLUGIN) --ts_proto_out=$(TS_OUT) $(PROTO_FILES)

dart-proto:
	protoc --dart_out $(DART_OUT) $(PROTO_FILES)

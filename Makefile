all: proto docker
proto: go-proto dart-proto ts-proto

PROTO_DIR := ./proto 
PROTO_FILES = $(shell find $(PROTO_DIR) -name "*.proto")

GO_OUT := temporal/api
DART_OUT := frontend/lib/gen

TS_DIR := ./api

NODE_PORT := 8111
FRONT_PORT := 8222
TMPRL_UI_PORT := 8333

go-proto:
	protoc --go_out $(GO_OUT) $(PROTO_FILES)

ts-proto:
	$(MAKE) -C $(TS_DIR) all

dart-proto:
	dart pub global activate protoc_plugin
	export PATH=$(HOME)/.pub-cache/bin:$(PATH); protoc --dart_out $(DART_OUT) $(PROTO_FILES)

docker: docker-worker docker-node docker-frontend

docker-worker:
	docker build -t gopher-pizza/temporal-worker temporal

docker-node:
	docker build -t gopher-pizza/node-api -f api/Dockerfile .

docker-frontend:
	docker build --build-arg NODE_PORT=$(NODE_PORT) --no-cache -t gopher-pizza/frontend frontend

run: all
	REBUILD=0 ./run_all.sh

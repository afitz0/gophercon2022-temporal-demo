FROM golang:1.19 AS base

WORKDIR /go/src/gopherpizza

COPY temporal/ ./

RUN go mod download
RUN go install -v ./worker

ENTRYPOINT ["/go/bin/worker"]

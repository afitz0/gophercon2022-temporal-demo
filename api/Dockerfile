FROM node:16.16.0 as builder

WORKDIR /app

ENV NODE_ENV=development
ARG PROTO_DIR=./proto

COPY api .
COPY proto proto

RUN npm install --location=global typescript
RUN make all

FROM gcr.io/distroless/nodejs:16
EXPOSE ${PORT:-8000}
CMD ["/app/lib/index.js"]

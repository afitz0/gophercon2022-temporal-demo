FROM node:16.16.0 as builder

WORKDIR /app

ENV NODE_ENV=development
ARG PROTO_DIR=./proto

COPY api .
COPY proto proto

RUN npm install --location=global typescript
RUN make all

FROM gcr.io/distroless/nodejs:16

COPY --from=builder /app /app

# For debugging/inspecting
#COPY --from=busybox:1.35.0-uclibc /bin/sh /bin/sh
#COPY --from=busybox:1.35.0-uclibc /bin/ls /bin/ls

EXPOSE ${PORT:-8000}
CMD ["/app/lib/index.js"]

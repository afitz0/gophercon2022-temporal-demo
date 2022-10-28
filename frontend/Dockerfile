FROM ubuntu:22.04 as builder

USER root
RUN apt-get update && apt-get install -y git curl wget unzip

WORKDIR /root
ENV PATH ${PATH}:/root/flutter/bin
RUN git clone --depth 1 -b stable https://github.com/flutter/flutter.git
RUN flutter precache

WORKDIR /app
COPY . /app
ARG NODE_PORT=8080

RUN flutter clean
RUN flutter --suppress-analytics build web --dart-define=NODE_PORT=$NODE_PORT --web-renderer canvaskit

FROM gcr.io/distroless/python3
COPY --from=builder /app/build/web /app
COPY --from=builder /app/serve.py /bin/
WORKDIR /app

ENV PORT ${PORT:-80}
EXPOSE ${PORT:-80}
CMD ["/bin/serve.py"]

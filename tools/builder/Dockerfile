# syntax=docker/dockerfile:1.17.0

FROM base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    ca-certificates curl pkg-config binutils build-essential gcc make autoconf &&\
    rm -rf /var/lib/apt/lists/*

COPY --chmod=0755 vendor-dependencies.sh /usr/local/bin
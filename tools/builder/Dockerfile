# syntax=docker/dockerfile:1.17.0

FROM base

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update &&\
    apt-get install -y --no-install-recommends \
    ca-certificates curl pkg-config binutils build-essential gcc make autoconf

COPY --chmod=0755 vendor-dependencies.sh /usr/local/bin
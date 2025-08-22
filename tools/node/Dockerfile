# syntax=docker.io/docker/dockerfile-upstream:1.14.0-labs

FROM builder AS build

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	  --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update &&\
    apt-get install -y --no-install-recommends \
    curl xz-utils binutils

ARG NODE_VERSION=22.18.0

# Infer architecture for Node.js binary
RUN set -eux; \
  arch="$(uname -m)"; \
  case "$arch" in \
    x86_64) node_arch="linux-x64" ;; \
    aarch64) node_arch="linux-arm64" ;; \
    armv7l) node_arch="linux-armv7l" ;; \
    *) echo "Unsupported architecture: $arch"; exit 1 ;; \
  esac; \
  echo "NODE_ARCH=$node_arch" > /tmp/node_arch.env

WORKDIR /tmp

# Load inferred architecture
ENV NODE_ARCH=""
RUN . /tmp/node_arch.env && export NODE_ARCH

# Download and extract official prebuilt Node.js binary
COPY --chmod=0755 install-node.sh /usr/local/bin
RUN install-node.sh

# Vendor non-glibc shared libraries
RUN vendor-dependencies.sh

FROM base

COPY --from=build $TOOLS_DIR $TOOLS_DIR

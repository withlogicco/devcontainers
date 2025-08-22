FROM builder AS build

RUN apt-get install -y --no-install-recommends \
    curl xz-utils binutils \
    && rm -rf /var/lib/apt/lists/*

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
RUN . /tmp/node_arch.env; \
  curl -fsSL -o node.tar.xz https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-${NODE_ARCH}.tar.xz \
  && tar -xJf node.tar.xz \
  && rm node.tar.xz \
  && mv node-v${NODE_VERSION}-${NODE_ARCH} $TOOLS_DIR

# Vendor non-glibc shared libraries
RUN vendor-dependencies.sh

FROM base

COPY --from=build $TOOLS_DIR $TOOLS_DIR

#! /bin/sh

set -eux

arch="$(uname -m)"
case "$arch" in
    x86_64) NODE_ARCH="linux-x64" ;;
    aarch64|arm64) NODE_ARCH="linux-arm64" ;;
    *) echo "Unsupported architecture: $arch" >&2; exit 1 ;;
esac

echo "NODE_ARCH=$NODE_ARCH" >> ${BUILDER_ENV_FILE}
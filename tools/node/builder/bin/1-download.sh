#! /bin/bash

set -ex

export $(cat $BUILDER_ENV_FILE)

curl -fsSL -o node.tar.xz https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-$NODE_ARCH.tar.xz 
tar -xJf node.tar.xz
rm node.tar.xz

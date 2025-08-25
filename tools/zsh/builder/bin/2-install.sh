#! /bin/sh

set -eux

export $(cat $BUILDER_ENV_FILE)

cd zsh-$ZSH_VERSION

# Install zsh
./Util/preconfig
./configure --prefix=$TOOL_DIR --enable-multibyte --with-tcsetpgrp
make -j"$(nproc)"
make install

#! /bin/sh

set -eux

export $(cat $BUILDER_ENV_FILE)

cd git-$TOOL_VERSION

make configure
./configure --prefix=$TOOL_DIR --with-openssl --with-curl
make -j"$(nproc)" all
make install

# Provide PATH fallbacks for remote helpers if exec-path isn't set downstream
core=$TOOL_DIR/libexec/git-core
for h in git-remote-https git-remote-http; do
	if [ -x "$core/$h" ] && [ ! -e "$TOOL_DIR/bin/$h" ]; then
		ln -s "$core/$h" "$TOOL_DIR/bin/$h"
	fi
done
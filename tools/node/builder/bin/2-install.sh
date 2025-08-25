#! /bin/sh

set -eux

export $(cat $BUILDER_ENV_FILE)

mv node-v$TOOL_VERSION-$NODE_ARCH/bin $TOOL_DIR/
mv node-v$TOOL_VERSION-$NODE_ARCH/include $TOOL_DIR/
mv node-v$TOOL_VERSION-$NODE_ARCH/lib $TOOL_DIR/
mv node-v$TOOL_VERSION-$NODE_ARCH/share $TOOL_DIR/
